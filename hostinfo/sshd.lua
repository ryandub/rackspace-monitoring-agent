--[[
Copyright 2014 Rackspace

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS-IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
--]]
local HostInfo = require('./base').HostInfo

local string = require('string')
local fmt = require('string').format
local table = require('table')
local os = require('os')
local spawn = require('childprocess').spawn

--[[ SSHd Variables ]]--
local Info = HostInfo:extend()
function Info:initialize()
  HostInfo.initialize(self)
end

function Info:run(callback)
  if os.type() ~= 'Linux' and os.type() ~= 'Darwin' then
    self._error = 'Unsupported OS for SSHd'
    callback()
    return
  end

  local child = spawn('sshd', {'-T'}, {})
  local data = ''

  child.stdout:on('data', function(chunk)
    data = data .. chunk
  end)

  child:on('exit', function(exit_code)
    if exit_code ~= 0 then
      self._error = fmt("sshd exited with a %d exit_code", exit_code)
      callback()
      return
    end
  end)

  child.stdout:on('end', function()
    local line
    for line in data:gmatch("[^\r\n]+") do
      line = line:gsub("^%s*(.-)%s*$", "%1")
      local a, b, key, value = line:find("(.*)%s(.*)")
      if key ~= nil then
        local obj = {}
        obj[key] = value
        table.insert(self._params, obj)
      end
    end
    callback()
  end)

  child:on('error', function(err)
    self._error = err
    callback()
  end)
end

function Info:getType()
  return 'SSHD'
end

return Info
