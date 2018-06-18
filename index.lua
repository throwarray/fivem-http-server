local visits = 0

STATIC_FOLDER = 'static/'

FILE_CACHE = {
  ['/hello.txt'] = 'Hello world', -- page is cached with this preset data
  ['/style.css'] = true -- page cached on first request
}

function Log (...)
  -- misc.flogisoft.com/bash/tip_colors_and_formatting
  -- stackoverflow.com/a/1718607
  print('\27[32m['.. GetCurrentResourceName() ..']\27[0m', ...)
end

ROUTES = {
  ['/404.html'] = function (req, res)
    res.writeHead(404)
    res.send('404: Page not found.')
  end,

  ['/visitors'] = function (req, res)
    visits = visits + 1

    local body = req.body
    local query = req.query
    local name = 'Unknown'

    if body and req.method == 'POST' then
      name = body.name
    end

    res.writeHead(200)

    -- res.writeHead(200, {
    --   ["Access-Control-Allow-Origin"] = "*",
    --   ["X-Frame-Options"] = "allowall",
    --   ["X-Powered-By"] = "FiveM"
    -- })

    res.send(json.encode({
      visitors = visits,
      message =  'Hello ' .. ((query and query.name) or name) .. ', there have been ' .. visits .. ' visitors.'
    }))
  end
}
