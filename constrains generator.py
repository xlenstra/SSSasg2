def printLocations(block, x, y, apuf, puf, sb, topBottom):
    print("""set_property BEL {0}6LUT [get_cells APUF_1b_i/XOR_8_APUF_0/inst/apuf{1}/puf{2}/sb{3}/{4}_mux/selected_INST_0]
set_property LOC SLICE_X{5}Y{6} [get_cells APUF_1b_i/XOR_8_APUF_0/inst/apuf{1}/puf{2}/sb{3}/{4}_mux/selected_INST_0]"""
          .format(block, apuf, puf, sb, topBottom, x, y)
    )


yLow = 50
yHigh = 142

for apuf in range(8):
    x = 26
    for puf in range(4):
        for sb in [0, 4]:
            printLocations("A", x, yLow , apuf, puf, sb, "bottom")
            printLocations("B", x, yLow , apuf, puf, sb, "top")
            printLocations("C", x, yLow , apuf, puf, sb+2, "bottom")
            printLocations("D", x, yLow , apuf, puf, sb+2, "top")
            printLocations("A", x, yHigh, apuf, puf, sb+1, "bottom")
            printLocations("B", x, yHigh, apuf, puf, sb+1, "top")
            printLocations("C", x, yHigh, apuf, puf, sb+3, "bottom")
            printLocations("D", x, yHigh, apuf, puf, sb+3, "top")
            x += 1
    yLow += 1
    yHigh += 1
