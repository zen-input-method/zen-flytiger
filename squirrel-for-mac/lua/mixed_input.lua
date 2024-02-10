local function mixed_input(key, env)
  local engine = env.engine
  local context = engine.context
	local input = context.input
  local kRejected, kAccepted, kNoop = 0, 1, 2
  if (context:is_composing() and input:sub(1, 1) == "~") then
    if (key:repr() == "Return") then
      if (input == "~") then
        context.input = "~"
      else
        context.input = input:gsub("^~", ""):gsub("`"," ")
      end
    elseif (key:repr() == "space") then
      if (input == "~") then
        context.input = "~~"
      elseif (string.match(input, "^~[^,.!?):~*-]")) then
        context:push_input("`")
        return kAccepted
      elseif (string.match(input, "``")) then
        context.input = input:gsub("``", "")
      end
    end
  end
  return kNoop
end 

return mixed_input
