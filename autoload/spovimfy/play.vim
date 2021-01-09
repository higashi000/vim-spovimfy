function spovimfy#play#play() abort
    if !exists('g:spovimfy_token') || g:spovimfy_token == ''
        echo 'Please set your api key'
        return
    endif

    let s:V = vital#spovimfy#new()
    let s:H = s:V.import('Web.HTTP')
    let s:J = s:V.import('Web.JSON')

    let url = 'https://api.spotify.com/v1/me/player/play'

    let res = s:H.request('PUT', url, {'headers': {'Authorization': 'Bearer '.g:spovimfy_token}})


    if res['status'] == 204
        return 'success'
    else
        let content = s:J.decode(res['content'])
        return content.error.message
    endif
endfunction

function spovimfy#play#choice(trackURI) abort
    if !exists('g:spovimfy_token') || g:spovimfy_token == ''
        echo 'Please set your api key'
        return
    endif

    let s:V = vital#spovimfy#new()
    let s:H = s:V.import('Web.HTTP')
    let s:J = s:V.import('Web.JSON')

    let url = 'https://api.spotify.com/v1/me/player/play'

    let cmd = 'curl -X PUT "'.url.'" -H "Authorization: Bearer '.g:spovimfy_token.'" -d '.'"{\"uris\": [\"'.a:trackURI.'\"]}"'

    call system(cmd)
endfunction

function spovimfy#play#playlists(uri) abort
    if !exists('g:spovimfy_token') || g:spovimfy_token == ''
        echo 'Please set your api key'
        return
    endif

    let s:V = vital#spovimfy#new()
    let s:H = s:V.import('Web.HTTP')
    let s:J = s:V.import('Web.JSON')

    let url = 'https://api.spotify.com/v1/me/player/play'

    let cmd = 'curl -X PUT "'.url.'" -H "Authorization: Bearer '.g:spovimfy_token.'" -d '.'"{\"context_uri\": \"'.a:uri.'\"}"'

    call system(cmd)
endfunction
