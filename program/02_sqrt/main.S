
## unsigned isqrt (unsigned x) {
##     unsigned m, y, b;
##     m = 0x40000000;
##     y = 0;
##     while (m != 0) { // Do 16 times
##         b = y |  m;
##         y >>= 1;
##         if (x >= b) {
##             x -= b;
##             y |= m;
##         }
##         m >>= 2;
##     }
##     return y;
## }

        .text

init:   addiu   $a0, $0,  0     ## x = dbg
        li      $v0, 0          ## calculation result reset

sqrt:   lui     $t0, 0x4000     ## m = 0x40000000
        move    $t1, $0         ## y = 0

L0:     or      $t2, $t1, $t0   ## b = y | m;
        srl     $t1, $t1, 1     ## y >>= 1
        sltu    $t3, $a0, $t2   ## if (x < b)
        bnez    $t3, L1         ##   goto L1
                                ## else
        subu    $a0, $a0, $t2   ##   x -= b
        or      $t1, $t1, $t0   ##   y |= m

L1:     srl     $t0, $t0, 2     ## m >>= 2
        bnez    $t0, L0         ## if(m != 0) goto L0
        move    $v0, $t1        ## return y
        addiu   $0,  $v0, 0

end:    beqz    $0,  end        ## while(1);
