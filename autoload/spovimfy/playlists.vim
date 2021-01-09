function spovimfy#playlists#playlists() abort
    if !exists('g:spovimfy_token') || g:spovimfy_token == ''
        echo 'Please set your api key'
        return
    endif

    let s:V = vital#spovimfy#new()
    let s:H = s:V.import('Web.HTTP')
    let s:J = s:V.import('Web.JSON')

    let url = 'https://api.spotify.com/v1/me/playlists'

    let res = s:H.request('GET', url, {'headers': {'Authorization': 'Bearer '.g:spovimfy_token}})

    let content = s:J.decode(res['content'])

    let playlists = {}

    if len(content.items) == 0
        return 'failed'
    endif

    for i in content.items
        let playlists[i.name] = i.uri
    endfor

    return playlists
endfunction

