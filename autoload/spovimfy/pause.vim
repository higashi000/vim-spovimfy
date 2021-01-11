function spovimfy#pause#pause() abort
    if !exists('g:spovimfy_token') || g:spovimfy_token == ''
        echo 'Please set your api key'
        return
    endif

    let s:V = vital#spovimfy#new()
    let s:H = s:V.import('Web.HTTP')
    let s:J = s:V.import('Web.JSON')

    let url = 'https://api.spotify.com/v1/me/player/pause'

    let res = s:H.request('PUT', url, {'headers': {'Authorization': 'Bearer '.g:spovimfy_token}})


    if res['status'] == 204
        return 'Success!'
    else
        let content = s:J.decode(res['content'])
        return content.error.message
    endif
endfunction
