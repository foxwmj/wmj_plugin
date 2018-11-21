function! WMJ_line_zip(...)

"====================
echo "Usage: call WMJ_line_zip([sample_size default:2], [sep_char default:,])"
"====================
"


python << EOF
import vim

try:
    sample_size = int( vim.eval("a:1") )
except:
    sample_size = 2

try:
    sep = str( vim.eval("a:2") )
except:
    sep = ","

ta = ""
try:
    title = vim.current.buffer[0]
    ta = title.split(sep)
except:
    print "No line 0"



try:
    max_string_a = max(ta, key=len)
    max_string_len = len(max_string_a) + 4
    format_string = "%-{}s[%s]".format(max_string_len)

    ret = []
    ret.append("====== Sumary of CSV lines ======")
    ret.append("")

    for idx,line in enumerate(vim.current.buffer[1:sample_size+1]):
        tb = line.split(sep)
        
        ret.append("------------ Sample %d" % (idx,) )
        for a,b in zip(ta,tb):
            line = format_string % (a, b)
            ret.append(line)
        ret.append("")

    vim.current.buffer[:] = ret
except:
    print "Internal Error"

EOF
endfunction
