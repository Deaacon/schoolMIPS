
            .text

init:       addiu   $t2, $0, 0x00001a2b
            move    $t0, $0             # int cur_delay = 0;
            li      $t1, 0x1            # int max_delay = 0x1;

delay:      addiu   $t0, $t0, 1         # cur_delay++;
            addiu   $t3, $0, 0
            addiu   $0, $t3, 0
            bne     $t0, $t1, delay     # if(cur_delay != max_delay) goto delay
            move    $t0, $0             # cur_delay = 0;

read:       lw      $t1, 0x00007f00 ($0) # max = SM_GPIO_REG_INPUT;
write:      sw      $t1, 0x00007f04 ($0) # SM_GPIO_REG_OUTPUT = var;
            beqz    $0,  delay
