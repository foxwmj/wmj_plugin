function! WMJ_transpose(...)

"====================
echo "Usage: call WMJ_transpose([sep_char default: auto_guess])"
"====================
"


python << EOF
import vim

# use first line to guess sep char, according to the max occurrence char in sep_chars
try:
    sep_chars=" \t,`~!@#$%^*;"
    sep_list=map(str, sep_chars)
    first_line =  vim.current.buffer[0]
    sep = max(sep_chars, key=lambda x: first_line.count(x))
except:
    sep = ","

try:
    sep = str( vim.eval("a:1") )
except:
    pass

try:
    ret = []
    ret.append("====== Transpose lines ======")
    ret.append("sep_char = [%s]" % (sep, ) )
    ret.append("")

    normal_size = -1
    temp = []
    for idx,line in enumerate(vim.current.buffer[:]):
        tb = line.split(sep)
        if normal_size == -1:
            normal_size = len(tb)

        if len(tb) != normal_size:
            print "line %d size [%d] != [%d]" % (idx+1, len(tb), normal_size)
            for i in range(normal_size - len(tb) ):
                tb.append("")

        temp.append(tb)

    result = map(list, zip(*temp))
    for line in result:
        ret.append( sep.join(line) + "\n" )

    vim.current.buffer[:] = ret
except:
    print "Internal Error"

EOF
endfunction
