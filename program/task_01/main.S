
        .text

oper_1: li      $v0, 0
        li      $t0, 5
        li      $t1, -1
        bgez    $t1, oper_2
        li      $v0, 3
        bgez    $t0, oper_2
        li      $v0, 6

oper_2: li      $t0, 10
        sltiu   $v0, $t0, 25
        sltiu   $v0, $t0, 5

oper_3: li      $t0, 10
        xori    $v0, $t0, 15

oper_4: li      $v0, 1
        li      $t0, 3
        sllv    $v0, $v0, $t0

end:    beqz    $0,  end
