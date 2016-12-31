function! s:RequireHaskellHost(name)
	return jobstart(['cabal', 'run', 'nvim.hs', '--', a:name.name, '-l', 'log.txt', '-v', 'DEBUG'], {'rpc': v:true, 'cwd': expand('%:p:h') })
endfunction

let nvimhs='nvimhs'

call remote#host#Register(nvimhs, "*.l\?hs", function('s:RequireHaskellHost'))
let hc=remote#host#Require(nvimhs)

let fib12=rpcrequest(hc, 'Fib', 12)

if fib12 != '144'
	echo 'fib(12) should be 144'
	cq!
endif

try
	let brokenFib=rpcrequest(hc, 'BrokenFib', 10927)
	echo 'Unexpected result for calling BrokenFib: ' . brokenFib
	cq!
catch
	" all good
endtry


quit!


