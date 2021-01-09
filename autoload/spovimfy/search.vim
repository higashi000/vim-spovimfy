function spovimfy#search#search(searchCond) abort
    if !exists('g:spovimfy_token') || g:spovimfy_token == ''
        echo 'Please set your api key'
        return
    endif

    let s:V = vital#spovimfy#new()
    let s:H = s:V.import('Web.HTTP')
    let s:J = s:V.import('Web.JSON')

    let url = 'https://api.spotify.com/v1/search?'

    if a:searchCond['q'] == ''
        echo 'please set keyword'
    elseif a:searchCond['type'] == ''
        echo 'please set type'
    endif

    let a:searchCond['q'] = substitute(a:searchCond['q'], '\s', '%20', 'g')
    let a:searchCond['type'] = substitute(a:searchCond['type'], '\s', '%20', 'g')

    let limit = has_key(a:searchCond, 'limit') ? a:searchCond['limit'] : 1

    let url = url.'q='.a:searchCond['q'].'&'.'type='.a:searchCond['type'].'&limit='.limit

    let res = s:H.request('GET', url, {'headers': {'Authorization': 'Bearer '.g:spovimfy_token, 'Accept-Language': '*'}})

    let content = s:J.decode(res['content'])

    if res['status'] == 200
        if a:searchCond['type'] == 'artist'
            return content.artists
        elseif a:searchCond['type'] == 'track'
            return content.tracks
        endif
    else
        echo content.error.message
    endif
endfunction
