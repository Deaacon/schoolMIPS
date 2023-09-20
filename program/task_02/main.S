
        .text

start:  li      $t0, 1
        li      $v0, 1
        li      $t1, 1
        li      $s0, 6
        li      $s1, 8

prod_i: move    $t2, $t1
        li      $t3, 1
prod_f: addu    $t1, $t1, $t2
        addiu   $t3, $t3, 1
        bne     $t3, $s0, prod_f

progr:  addu    $v0, $v0, $t1
        addiu   $t0, $t0, 1
        bne     $t0, $s1, prod_i

end:    beqz    $0,  end
