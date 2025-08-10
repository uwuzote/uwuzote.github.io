#!/usr/bin/env luajit

assert(jit and jit.os == "Linux") -- Only LuaJIT on Linux
assert(os.execute()) -- Shell must be accessible

local LANGUAGES = {
  fi = { macro = "FI", ext = "" },
  ru = { macro = "RU", ext = ".ru" },
}

local datetime

local function execute(cmd)
  print("* " .. cmd)

  local code = os.execute(cmd)

  if (code ~= 0) or not code then
    error("Command `" .. cmd .. "` failed with code " .. tostring(code))
  end
end

local function get_timestamp(file)
  local handle =
    io.popen("test -f '" .. file .. "' && stat --printf %Y '" .. file .. "' || echo 0")
  local result = handle:read("*n")
  handle:close()
  return result
end

local function edge(input, output, cmd)
  if get_timestamp(input) >= get_timestamp(output) then
    execute(cmd)
  end
end

local function build_page(input, params, output)
  edge(
    input,
    output,
    "m4 -EE -DDATETIME='"
      .. datetime
      .. "' -DSRC="
      .. input
      .. " "
      .. params
      .. " m4/gen.html.m4 > "
      .. output
  )
end

datetime = os.date("!%Y-%m-%d %H:%M:%S")

execute("mkdir -p docs")
execute("cp -r static/* docs")

for file in io.popen("find pages/ -type f -name '*.lua'"):lines() do
  local name = file:sub(7, -5)
  local module = require("pages." .. name)

  if type(module) == "table" then
    for _, lang_id in ipairs(module) do
      local lang = LANGUAGES[lang_id]
      local input = "pages/" .. name .. ".html"
      local output = "docs/" .. name .. lang.ext .. ".html"

      edge(
        input,
        output,
        "m4 -EE -DDATETIME='"
          .. datetime
          .. "' -DSRC="
          .. input
          .. " -DLANG="
          .. lang.macro
          .. " -DSELF="
          .. name
          .. " m4/gen.html.m4 > "
          .. output
      )
    end
  end
end

execute(
  "minify -q --html-keep-comments --html-keep-document-tags --html-keep-end-tags -r docs/ -o docs/"
)
