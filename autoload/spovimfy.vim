function spovimfy#choicePlay() abort
    let s:V = vital#spovimfy#new()
    let s:J = s:V.import('Web.JSON')

    let l:isTrack = input('track or artist (default track) :')

    let l:title = ''

    if l:isTrack == 'artist'
        let l:title = input('artist name :')
    else
        let l:isTrack = 'track'
        let l:title = input('track title :')
    endif

    let searchRes = spovimfy#search#search({'q': l:title, 'type': l:isTrack})

    if len(searchRes.items) == 0
        echo 'error'
        return
    endif

    call spovimfy#play#choice(searchRes.items[0].uri)
endfunction

function spovimfy#playPlaylists() abort
    let name = input('playlists name: ')

    let playlists = spovimfy#playlists#playlists()

    if has_key(playlists, name)
        call spovimfy#play#playlists(playlists[name])
    else
        echo 'play lists is not find'
    endif
endfunction

function spovimfy#getToken() abort
    let s:V = vital#spovimfy#new()
    let s:H = s:V.import('Web.HTTP')
    let s:J = s:V.import('Web.JSON')

    let url = 'https://localhost:5000/'

    let res = system("curl -X GET -w \"%{redirect_url}\" -s 'https://localhost:5000/' -k")

    let cmd = 'OpenBrowser ' . res
    echo cmd
    execute(cmd)
endfunction
