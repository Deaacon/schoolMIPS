

            .text

start:      move    $t0, $0
            addiu   $t1, $0,  0
            move    $v0, $t1

fibonacci:  addu    $t0, $t0, $t1
            move    $v0, $t0
            addu    $t1, $t0, $t1
            move    $v0, $t1
            addiu   $0,  $v0, 0
            beqz    $0,  fibonacci
