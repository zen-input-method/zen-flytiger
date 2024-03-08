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
  local cands = 0
  for cand in input:iter() do
    if (code == ";rq" or code == ";zd" or code == ";zt" or code == ";zz") then
      eng:commit_text(cand.text)
      ctx:pop_input(#code)
    elseif (#code>=1) then
      yield(cand)
    end
  end
  if (cands == 1) then
    local selcand = ctx:get_selected_candidate()
    eng:commit_text(selcand.text)
    ctx:pop_input(#code)
  end
end
