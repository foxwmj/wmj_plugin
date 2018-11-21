function! WMJ_line_zip(...)

"====================
echo "Usage: call WMJ_line_zip([sep_char])"
"====================
"


python << EOF
import vim

try:
    sep = str( vim.eval("a:1") )
except:
    sep = ","

ta = ""
tb = ""
try:
    title = vim.current.buffer[0]
    ta = title.split(sep)

    sample = vim.current.buffer[1]
    tb = sample.split(sep)
except:
    print "No line 0 or line 1"

try:
    max_string_a = max(ta, key=len)
    max_string_len = len(max_string_a) + 4
    format_string = "%-{}s[%s]".format(max_string_len)

    ret = []
    ret.append("====== Sumary of CSV lines ======")
    ret.append("")

    for a,b in zip(ta,tb):
        line = format_string % (a, b)
        ret.append(line)

    vim.current.buffer[:] = ret
except:
    print "Internal Error"

EOF
endfunction
