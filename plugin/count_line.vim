function! WMJ_count_line(...)

"====================
echo "Usage: call WMJ_count_line([sort_by_count default: 1])"
"====================
"


python << EOF
import vim

try:
    arg_sort_by_count = int( vim.eval("a:1") )
except:
    arg_sort_by_count = 1

ret = []
ret.append("====== Count dumplicated lines ======")
ret.append("")

m = {}
for idx,line in enumerate(vim.current.buffer[:]):
    if line in m:
        m[line] += 1
    else:
        m.setdefault(line, 1)

max_length = len( max(m.keys(), key=len) )
format_str = "%-{}s[%d]".format(max_length + 4)

if arg_sort_by_count == 1:
    pairs = sorted(m.items(), lambda x,y: cmp(x[1],y[1]), reverse=True)
else:
    pairs = sorted(m.items(), lambda x,y: cmp(x[0],y[0]))

ret = [format_str % (k, v) for k,v in pairs]
ret.append("")

vim.current.buffer[:] = ret

EOF
endfunction
