#!/usr/bin/env luajit

assert(jit and jit.os == "Linux") -- Only LuaJIT on Linux
assert(os.execute()) -- Shell must be accessible

local datetime

local function execute(cmd)
  print("* " .. cmd)

  local code = os.execute(cmd)

  if (code ~= 0) or not code then
    error("Command `" .. cmd .. "` failed with code " .. tostring(code))
  end
end

local function get_timestamp(file)
  local handle = io.popen("test -f '" .. file .. "' && stat --printf %Y '" .. file .. "' || echo 0")
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
  edge(input, output, "m4 -EE -DDATETIME='" .. datetime .. "' -DSRC=" .. input .. " " .. params .. " m4/gen.html.m4 > " .. output)
end

local function build_full_page(id)
  build_page("pages/" .. id .. ".html", "-DLANG=FI -DSELF=" .. id, "docs/" .. id .. ".html")
  build_page("pages/" .. id .. ".html", "-DLANG=RU -DSELF=" .. id, "docs/" .. id .. ".ru.html")
end

datetime = os.date("!%Y-%m-%d %H:%M:%S")

execute("mkdir -p docs")
execute("cp -r static/* docs")

build_page("pages/404.html", "-DLANG=FI", "docs/404.html")

build_full_page("index")
build_full_page("verbs")
build_full_page("object")
build_full_page("numbers")
build_page("pages/nouns.html", "-DLANG=RU -DSELF=nouns", "docs/nouns.ru.html")
-- build_page("pages/orthography.html", "-DLANG=RU -DSELF=orthography", "docs/orthography.ru.html")

execute("minify --html-keep-comments --html-keep-document-tags --html-keep-end-tags -r docs/ -o docs/")
