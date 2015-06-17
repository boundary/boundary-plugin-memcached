-- Copyright 2015 Boundary, Inc.
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--    http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.

local framework = require('framework')
local Accumulator = framework.Accumulator
local Plugin = framework.Plugin
local NetDataSource = framework.NetDataSource
local gsplit = framework.string.gsplit
local parseValue = framework.util.parseValue

local params = framework.params

local function parseStat(line)
  local metric, value = string.match(line, 'STAT ([%a_]+) (%d+)')
  return metric, value
end

local function parse(data)
  local result = {}
  for v in gsplit(data, '\r\n') do
    local metric, value = parseStat(v)
    if metric then
      result[metric] = parseValue(value)
    end
  end
  return result
end

local ds = NetDataSource:new(params.host, params.port)
function ds:onFetch(socket)
  socket:write('stats\r\n')
end

local acc = Accumulator:new()
local plugin = Plugin:new(params, ds)
function plugin:onParseValues(data)
  local result = {}
  local d = parse(data)
  result['MEMCACHED_ALLOCATED'] = (d.limit_maxbytes and d.bytes / d.limit_maxbytes) or 0
  result['MEMCACHED_CONNECTIONS'] = d.curr_connections
  result['MEMCACHED_HITS'] = acc:accumulate('get_hits', d.get_hits or 0)
  result['MEMCACHED_MISSES'] = acc:accumulate('get_misses', d.get_misses or 0)
  result['MEMCACHED_ITEMS'] = d.curr_items
  result['MEMCACHED_REQUESTS'] = acc:accumulate('cmd_get', d.cmd_get or 0) + acc:accumulate('cmd_set', d.cmd_set or 0)
  result['MEMCACHED_NETWORK_IN'] = acc:accumulate('bytes_read', d.bytes_read or 0)
  result['MEMCACHED_NETWORK_OUT'] = acc:accumulate('bytes_written', d.bytes_written or 0)

  return result
end

plugin:run()
