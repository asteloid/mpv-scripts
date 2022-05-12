--[[
mpv-ytfzf.
Copyright 2022 asteloid ( https://github.com/asteloid )

Requires ytfzf and rofi installed in the system..
Default config:
- YouTube Search: CTRL+x
- Subscriptions: CTRL+SHIFT+x
 
--]]

utils = require 'mp.utils'

function invoke_ytfzf(args)
    return utils.subprocess({
        args = {'ytfzf', table.unpack(args)},
        cancellable = false,
    })
end

function search_ytfzf()
    local url_select = invoke_ytfzf({
            '-D',
            '--scrape=yt',
            '-L'
    })
    if (url_select.status ~= 0) then
        return end
    
    for youtubename in string.gmatch(url_select.stdout, '[^\n]+') do
        mp.commandv('loadfile', youtubename, 'replace')
    end
end

function subs_ytfzf()
    local url_select = invoke_ytfzf({
            '-D',
            '--scrape=youtube-subscriptions',
            '-L'
    })
    if (url_select.status ~= 0) then
        return end
    
    for youtubename in string.gmatch(url_select.stdout, '[^\n]+') do
        mp.commandv('loadfile', youtubename, 'replace')
    end
end

mp.add_key_binding("CTRL+x", "search_ytfzf", search_ytfzf)
mp.add_key_binding("CTRL+SHIFT+x", "subs_ytfzf", subs_ytfzf)