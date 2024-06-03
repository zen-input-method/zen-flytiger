local function mixed_input(key, env)
  local eng = env.engine
  local ctx = eng.context
  local input = ctx.input
  local kRejected, kAccepted, kNoop = 0, 1, 2
  if (ctx:is_composing() and input:sub(1, 1) == "~") then
    if (key:repr() == "Return") then
      if (input == "~") then
        ctx.input = "~"
      ---- 英文长句，遇回车键自动上屏 ----
      else
        ctx.input = input:gsub("`"," ")
        ctx:pop_input(#input)
        eng:commit_text(input:gsub("^~", ""):gsub("`"," "))
        return kAccepted
      end
    elseif (key:repr() == "space") then
      -- 输入编码为 '~'，按空格后直接上屏 ~
      if (input == "~") then
        ctx.input = "~~"
      -- 输入编码为 '~[^*]'，其中 * 为指定的单字符集合
      -- 当第二位编码属于该字符集合时，后接空格将会直接上屏，
      -- 对于其它字符，连按两次空格才上屏
      -- 例如：" 通常成对出现，不希望它们单空格上屏
      -- 但是 (、[、{ 因为可以触发双链笔记功能，所以希望单空格上屏
      -- 这些符号的选择与日常打字习惯密切相关，可以逐步调整优化
      elseif (string.match(input, "^~[^!#&(,./:;<=>?@[-^_{|}-]")) then
        -- 必须在输入编码中额外插一个 `，否则无法退出临时英文输入模式
        ctx:push_input("`")
        return kAccepted
      end
    end
  end
  return kNoop
end 

return mixed_input
