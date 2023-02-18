import os
from libqtile.confreader import Config

c = Config("/home/grfreire/.config/qtile/config.py")
c.load()

def columnate(matrix):
    def _columnate(matrix):
        widths = [max(map(len, map(str, col))) for col in zip(*matrix)]
        for row in matrix:
            yield "    |    ".join((str(val).ljust(width) for val, width in zip(row, widths)))

    return "\n".join(_columnate(matrix))

matrix = [["Key", "Command"], ["---", "-------"]]
for key in c.keys:
    keys = ' + '.join((key.modifiers + [key.key]))
    desc = key.desc
    matrix.append([keys, desc])

os.system(f"echo \"{columnate(matrix).replace('`', '̀ ')}\" | col -bx | xargs -I \"[]\" printf \"\t%s\n\" \"[]\" | less")
