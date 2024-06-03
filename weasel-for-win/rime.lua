charset_comment_filter = require("charset_comment_filter") --Unicode分区提示
core2022 = require("core2022_filter") --自定义字符集过滤（常用字集）
number_translator = require("number")
lua_unicode_display_filter = require("unicode_display")  --Unicode编码提示
calculator_translator = require("calculator_translator")  --简易计算器
exe_processor = require("exe")  -- 网页启动器
shijian2_translator = require("shijian2") -- 高级时间

-- pimgeek diy processors --
mixed_input_processor = require("mixed_input")

-- pimgeek diy translators --
function pimgeek_date_translator(input, seg)
  if (input == ";rq") then
    --- Candidate(type, start, end, text, comment)
    yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d"), "简单日期"))
  elseif (input == ";zd" or input == ";zz") then
    yield(Candidate("date", seg.start, seg._end, os.date("%Y%m%d "), "永久笔记"))
  end
end

function pimgeek_time_translator(input, seg)
  local cand = ""
  if (input == ";zt") then
    cand = Candidate("time", seg.start, seg._end, os.date("%Y%m%d%H%M-"), "年月日小时分-")
  end
  yield(cand)
end

function pimgeek_english_translator(input, seg)
  local cand = ""
  if (input:sub(1, 1) == "~") then
    if (input == "~") then
      cand = Candidate("typing", seg.start, seg._end, "", "🔤")
      cand.preedit = "~"
    else
      cand = Candidate("typing", seg.start, seg._end, input:gsub("^~", ""):gsub("`"," "), "🔤")
      cand.preedit = input:gsub("^~", ""):gsub("`"," ")
    end
  end
  yield(cand)
end

-- pimgeek diy filters --
function pimgeek_preedit_filter(input, env)
  local eng = env.engine
  local ctx = eng.context
  local code = ctx.input
  local dict = eng.schema.schema_id
  local mem = Memory(eng, eng.schema)
  ---- 处理快速符号类编码 ; ----
  if (code:sub(1,1) == ";") then
    for cand in input:iter() do
      ---- 以下快速符号不用敲空格，直接上屏 ----
      if (code == ";rq" or code == ";zd" or code == ";zt" or code == ";zz") then
        ctx:pop_input(#code)
        eng:commit_text(cand.text)
      ---- 其它快速符号，先预上屏，然后敲空格确认 ----
      else
        cand.preedit = cand.text
        yield(cand)
      end
    end
  ---- 处理首字母大写的英文单词类编码 ^[A-Z] ----
  elseif string.match(code:sub(1,1),"[A-Z]") then
    local tmpcand = Candidate("capital-word", 0, #code, code, "🔤")
    yield(tmpcand)
  ---- 处理英文长句类编码 ~ ----
  elseif (code:sub(1,1) == "~") then
    for cand in input:iter() do
      ---- 输出英文句子 ----
      if (code:sub(#code-1,#code) == "``") then
        ctx:pop_input(#code)
        eng:commit_text(cand.text:sub(1, #cand.text-1))
      else
        yield(cand)
      end
    end
  ---- 处理单字和词组类编码 ----
  else
    if (#code <= 3) then
      for cand in input:iter() do
        cand.preedit = cand.text
        yield(cand)
      end
    elseif (#code == 4) then
      --local committed = false
      for cand in input:iter() do
        local c4code_words = {}
        local c4code_wdmap = {}
        local c4code_wdcnt = 0
        mem:dict_lookup(code, true, 5)
        for entry in mem:iter_dict() do
          table.insert(c4code_words, entry.text)
          c4code_wdmap[entry.text] = 1
        end
        for wd in pairs(c4code_wdmap) do
          c4code_wdcnt = c4code_wdcnt + 1
        end
        ---- 确定是唯一候选，可直接上屏 ----
        if (c4code_wdcnt==1) then
          tmpcand = Candidate("temp", 0, #code, c4code_words[1], "唯一候选")
          tmpcand.preedit = c4code_words[1]
          yield(tmpcand)
          --if (committed == false) then
          --  ctx:pop_input(#code)
          --  eng:commit_text(cand.text)
          --  committed = true
          --end
        ---- 候选不唯一，可在末尾加 * 号标记 ----
        else
          cand.preedit = cand.text -- .. "*"
          yield(cand)
          for _, wd in ipairs(c4code_words) do
            if (wd ~= cand.text) then
              tmpcand = Candidate("temp", 0, #code, wd, "") -- 其它候选
              tmpcand.preedit = wd
              yield(tmpcand)
            end
          end
        end
      end
    elseif (#code >= 5) then
      local tmpcand = ""
      ---- 获取最末位编码 ----
      local newcode = code:sub(#code, #code) 
      local fullcode_words = {}
      local fullcode_candtext = ""
      ---- 用完整编码查候选 ----
      mem:dict_lookup(code, true, 5)
      for entry in mem:iter_dict() do
        tmpcand = Candidate("temp", 0, #code, entry.text, "") -- 空码检测
        tmpcand.preedit = entry.text
        yield(tmpcand)
        table.insert(fullcode_words, entry.text)
      end
      for _, wd in ipairs(fullcode_words) do
        fullcode_candtext = fullcode_candtext .. wd
      end
      ---- 确认当前编码是空码 ----
      if (fullcode_candtext:len() == 0) then
        ---- 去掉最末位编码，上屏首选 ----
        local prevcode_words = {}
        mem:dict_lookup(code:sub(1, #code-1), true, 5)
        for entry in mem:iter_dict() do
          table.insert(prevcode_words, entry.text)
        end
        ctx:pop_input(#code)
        eng:commit_text(prevcode_words[1])
        ---- 最末位编码单独输出 ----
        local newcode = code:sub(#code, #code) -- 获取最末位编码
        local lastcode_words = {}
        local lastcode_words_checked = {}
        local lastcode_words_count = 0
        ctx:push_input(newcode)
        mem:dict_lookup(newcode, true, 5)
        for entry in mem:iter_dict() do
          tmpcand = Candidate("temp", 0, 1, entry.text, "") -- 末位编码
          tmpcand.preedit = entry.text
          yield(tmpcand)
        end
      end
    end
  end
end
