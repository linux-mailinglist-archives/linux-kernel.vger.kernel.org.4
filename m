Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8ED70000E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 07:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239886AbjELFz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 01:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239514AbjELFz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 01:55:57 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25ACD423A
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 22:55:56 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-76353eb51acso1377136539f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 22:55:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683870955; x=1686462955;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Abjweqy2kDxg05fOrLrKm9tjliW5e9btyXKQYLKCwyg=;
        b=D29yqipSX01fTXsfwFvNJYa6LWWOSGCSwJgc5RJcsEAZfAvMkrm6unt3vprsgxqOaF
         9hnY4/4qozXYjtJ6r3uXOEPL9etYUKWKLLX72ZS98AvV2OcduK8X253JA+Qr2ijZOyxB
         FKyWXBtNCDOKwm8zYVjR8FcgCDD/HpmYcmEpHyqiO5HJFLgxXKJH3qUN3ymN6R5xrXN+
         jXexkXrs9hCyshFOikAQ+aHciPANTW2L/BZZIaNrrSqeXcCMOsmCQLKyABwHRJdRiPf+
         Yfthm5cQ9NyGm7OneQiYO9VZVtbjiyIB3PyVrrZVf+LT7Cmk05LUjXnycf00rBbLQpri
         PpiQ==
X-Gm-Message-State: AC+VfDx2RcLk6gx2Xzh5UbkbD6SL6EUd944FukpanpIUKv68jvN08m1x
        5ljIabolG9E53mziOF3CgT1+KA1JeZy0otPOPPDIIp4/lnh5OVM=
X-Google-Smtp-Source: ACHHUZ5p6/diVusnf1HI4L2J/1EprCZLnjczZZUwszaLj0KSm5gTzUO96Zu2t8qwujilckxKlp//gCuJGvUPCOG/ucbobm5hrDp/
MIME-Version: 1.0
X-Received: by 2002:a5e:a910:0:b0:76c:6635:321d with SMTP id
 c16-20020a5ea910000000b0076c6635321dmr4639402iod.4.1683870955514; Thu, 11 May
 2023 22:55:55 -0700 (PDT)
Date:   Thu, 11 May 2023 22:55:55 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000026b68305fb78c24d@google.com>
Subject: [syzbot] [kernel?] possible deadlock in __hrtimer_run_queues
From:   syzbot <syzbot+3384541342de0ca933f1@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    1dc3731daf1f Merge tag 'for-6.4-rc1-tag' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14ebdafa280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8bc832f563d8bf38
dashboard link: https://syzkaller.appspot.com/bug?extid=3384541342de0ca933f1
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-1dc3731d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9ac41c523f85/vmlinux-1dc3731d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/40b82936b92f/bzImage-1dc3731d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3384541342de0ca933f1@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.4.0-rc1-syzkaller-00011-g1dc3731daf1f #0 Not tainted
------------------------------------------------------
syz-fuzzer/5789 is trying to acquire lock:
ffff88807ffdaba0 (&pgdat->kswapd_wait){-...}-{2:2}, at: __wake_up_common_lock+0xb8/0x140 kernel/sched/wait.c:137

but task is already holding lock:
ffff88802c92b858 (hrtimer_bases.lock){-.-.}-{2:2}, at: __run_hrtimer kernel/time/hrtimer.c:1689 [inline]
ffff88802c92b858 (hrtimer_bases.lock){-.-.}-{2:2}, at: __hrtimer_run_queues+0x23e/0xbe0 kernel/time/hrtimer.c:1749

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (hrtimer_bases.lock){-.-.}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x3d/0x60 kernel/locking/spinlock.c:162
       lock_hrtimer_base kernel/time/hrtimer.c:173 [inline]
       hrtimer_start_range_ns+0xe9/0xd80 kernel/time/hrtimer.c:1296
       hrtimer_start_expires include/linux/hrtimer.h:432 [inline]
       do_start_rt_bandwidth kernel/sched/rt.c:116 [inline]
       start_rt_bandwidth kernel/sched/rt.c:127 [inline]
       inc_rt_group kernel/sched/rt.c:1241 [inline]
       inc_rt_tasks kernel/sched/rt.c:1285 [inline]
       __enqueue_rt_entity kernel/sched/rt.c:1461 [inline]
       enqueue_rt_entity kernel/sched/rt.c:1510 [inline]
       enqueue_task_rt+0xa86/0xfc0 kernel/sched/rt.c:1545
       enqueue_task+0xad/0x330 kernel/sched/core.c:2082
       __sched_setscheduler.constprop.0+0xb89/0x25d0 kernel/sched/core.c:7774
       _sched_setscheduler kernel/sched/core.c:7820 [inline]
       sched_setscheduler_nocheck kernel/sched/core.c:7867 [inline]
       sched_set_fifo+0xb1/0x110 kernel/sched/core.c:7891
       irq_thread+0xe3/0x540 kernel/irq/manage.c:1302
       kthread+0x344/0x440 kernel/kthread.c:379
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

-> #3 (&rt_b->rt_runtime_lock){-.-.}-{2:2}:
       __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
       _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
       __enable_runtime kernel/sched/rt.c:876 [inline]
       rq_online_rt+0xb3/0x3b0 kernel/sched/rt.c:2485
       set_rq_online.part.0+0xf9/0x140 kernel/sched/core.c:9541
       set_rq_online kernel/sched/core.c:9533 [inline]
       sched_cpu_activate+0x216/0x440 kernel/sched/core.c:9649
       cpuhp_invoke_callback+0x645/0xeb0 kernel/cpu.c:192
       cpuhp_thread_fun+0x47f/0x700 kernel/cpu.c:815
       smpboot_thread_fn+0x659/0x9e0 kernel/smpboot.c:164
       kthread+0x344/0x440 kernel/kthread.c:379
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

-> #2 (&rq->__lock){-.-.}-{2:2}:
       _raw_spin_lock_nested+0x34/0x40 kernel/locking/spinlock.c:378
       raw_spin_rq_lock_nested+0x2f/0x120 kernel/sched/core.c:558
       raw_spin_rq_lock kernel/sched/sched.h:1366 [inline]
       rq_lock kernel/sched/sched.h:1653 [inline]
       task_fork_fair+0x74/0x4f0 kernel/sched/fair.c:12095
       sched_cgroup_fork+0x3d1/0x540 kernel/sched/core.c:4777
       copy_process+0x4b8a/0x7600 kernel/fork.c:2618
       kernel_clone+0xeb/0x890 kernel/fork.c:2918
       user_mode_thread+0xb1/0xf0 kernel/fork.c:2996
       rest_init+0x27/0x2b0 init/main.c:700
       arch_call_rest_init+0x13/0x30 init/main.c:834
       start_kernel+0x3b6/0x490 init/main.c:1088
       x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:556
       x86_64_start_kernel+0xb3/0xc0 arch/x86/kernel/head64.c:537
       secondary_startup_64_no_verify+0xf4/0xfb

-> #1 (&p->pi_lock){-.-.}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x3d/0x60 kernel/locking/spinlock.c:162
       try_to_wake_up+0xab/0x1c40 kernel/sched/core.c:4191
       autoremove_wake_function+0x16/0x150 kernel/sched/wait.c:419
       __wake_up_common+0x147/0x650 kernel/sched/wait.c:107
       __wake_up_common_lock+0xd4/0x140 kernel/sched/wait.c:138
       wakeup_kswapd+0x3fe/0x5c0 mm/vmscan.c:7797
       rmqueue mm/page_alloc.c:3057 [inline]
       get_page_from_freelist+0x6c5/0x2c00 mm/page_alloc.c:3499
       __alloc_pages+0x1cb/0x4a0 mm/page_alloc.c:4768
       __folio_alloc+0x16/0x40 mm/page_alloc.c:4800
       vma_alloc_folio+0x155/0x890 mm/mempolicy.c:2240
       wp_page_copy mm/memory.c:3070 [inline]
       do_wp_page+0x173d/0x33c0 mm/memory.c:3432
       handle_pte_fault mm/memory.c:4964 [inline]
       __handle_mm_fault+0x1635/0x41c0 mm/memory.c:5089
       handle_mm_fault+0x2af/0x9f0 mm/memory.c:5243
       do_user_addr_fault+0x2ca/0x1210 arch/x86/mm/fault.c:1349
       handle_page_fault arch/x86/mm/fault.c:1534 [inline]
       exc_page_fault+0x98/0x170 arch/x86/mm/fault.c:1590
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570

-> #0 (&pgdat->kswapd_wait){-...}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:3108 [inline]
       check_prevs_add kernel/locking/lockdep.c:3227 [inline]
       validate_chain kernel/locking/lockdep.c:3842 [inline]
       __lock_acquire+0x2f21/0x5df0 kernel/locking/lockdep.c:5074
       lock_acquire kernel/locking/lockdep.c:5691 [inline]
       lock_acquire+0x1b1/0x520 kernel/locking/lockdep.c:5656
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x3d/0x60 kernel/locking/spinlock.c:162
       __wake_up_common_lock+0xb8/0x140 kernel/sched/wait.c:137
       wakeup_kswapd+0x3fe/0x5c0 mm/vmscan.c:7797
       wake_all_kswapds+0x182/0x2d0 mm/page_alloc.c:4028
       __alloc_pages_slowpath.constprop.0+0x1724/0x2170 mm/page_alloc.c:4296
       __alloc_pages+0x408/0x4a0 mm/page_alloc.c:4781
       alloc_pages+0x1aa/0x270 mm/mempolicy.c:2279
       alloc_slab_page mm/slub.c:1851 [inline]
       allocate_slab+0x25f/0x390 mm/slub.c:1998
       new_slab mm/slub.c:2051 [inline]
       ___slab_alloc+0xa91/0x1400 mm/slub.c:3192
       __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3291
       __slab_alloc_node mm/slub.c:3344 [inline]
       slab_alloc_node mm/slub.c:3441 [inline]
       slab_alloc mm/slub.c:3459 [inline]
       __kmem_cache_alloc_lru mm/slub.c:3466 [inline]
       kmem_cache_alloc+0x38e/0x3b0 mm/slub.c:3475
       kmem_cache_zalloc include/linux/slab.h:670 [inline]
       fill_pool+0x264/0x5c0 lib/debugobjects.c:168
       debug_objects_fill_pool lib/debugobjects.c:597 [inline]
       debug_object_activate+0xfd/0x400 lib/debugobjects.c:693
       debug_hrtimer_activate kernel/time/hrtimer.c:420 [inline]
       debug_activate kernel/time/hrtimer.c:475 [inline]
       enqueue_hrtimer+0x27/0x320 kernel/time/hrtimer.c:1084
       __run_hrtimer kernel/time/hrtimer.c:1702 [inline]
       __hrtimer_run_queues+0xa5b/0xbe0 kernel/time/hrtimer.c:1749
       hrtimer_interrupt+0x320/0x7b0 kernel/time/hrtimer.c:1811
       local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1095 [inline]
       __sysvec_apic_timer_interrupt+0x14a/0x430 arch/x86/kernel/apic/apic.c:1112
       sysvec_apic_timer_interrupt+0x44/0xc0 arch/x86/kernel/apic/apic.c:1106
       asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645

other info that might help us debug this:

Chain exists of:
  &pgdat->kswapd_wait --> &rt_b->rt_runtime_lock --> hrtimer_bases.lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(hrtimer_bases.lock);
                               lock(&rt_b->rt_runtime_lock);
                               lock(hrtimer_bases.lock);
  lock(&pgdat->kswapd_wait);

 *** DEADLOCK ***

1 lock held by syz-fuzzer/5789:
 #0: ffff88802c92b858 (hrtimer_bases.lock){-.-.}-{2:2}, at: __run_hrtimer kernel/time/hrtimer.c:1689 [inline]
 #0: ffff88802c92b858 (hrtimer_bases.lock){-.-.}-{2:2}, at: __hrtimer_run_queues+0x23e/0xbe0 kernel/time/hrtimer.c:1749

stack backtrace:
CPU: 3 PID: 5789 Comm: syz-fuzzer Not tainted 6.4.0-rc1-syzkaller-00011-g1dc3731daf1f #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2188
 check_prev_add kernel/locking/lockdep.c:3108 [inline]
 check_prevs_add kernel/locking/lockdep.c:3227 [inline]
 validate_chain kernel/locking/lockdep.c:3842 [inline]
 __lock_acquire+0x2f21/0x5df0 kernel/locking/lockdep.c:5074
 lock_acquire kernel/locking/lockdep.c:5691 [inline]
 lock_acquire+0x1b1/0x520 kernel/locking/lockdep.c:5656
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x3d/0x60 kernel/locking/spinlock.c:162
 __wake_up_common_lock+0xb8/0x140 kernel/sched/wait.c:137
 wakeup_kswapd+0x3fe/0x5c0 mm/vmscan.c:7797
 wake_all_kswapds+0x182/0x2d0 mm/page_alloc.c:4028
 __alloc_pages_slowpath.constprop.0+0x1724/0x2170 mm/page_alloc.c:4296
 __alloc_pages+0x408/0x4a0 mm/page_alloc.c:4781
 alloc_pages+0x1aa/0x270 mm/mempolicy.c:2279
 alloc_slab_page mm/slub.c:1851 [inline]
 allocate_slab+0x25f/0x390 mm/slub.c:1998
 new_slab mm/slub.c:2051 [inline]
 ___slab_alloc+0xa91/0x1400 mm/slub.c:3192
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3291
 __slab_alloc_node mm/slub.c:3344 [inline]
 slab_alloc_node mm/slub.c:3441 [inline]
 slab_alloc mm/slub.c:3459 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3466 [inline]
 kmem_cache_alloc+0x38e/0x3b0 mm/slub.c:3475
 kmem_cache_zalloc include/linux/slab.h:670 [inline]
 fill_pool+0x264/0x5c0 lib/debugobjects.c:168
 debug_objects_fill_pool lib/debugobjects.c:597 [inline]
 debug_object_activate+0xfd/0x400 lib/debugobjects.c:693
 debug_hrtimer_activate kernel/time/hrtimer.c:420 [inline]
 debug_activate kernel/time/hrtimer.c:475 [inline]
 enqueue_hrtimer+0x27/0x320 kernel/time/hrtimer.c:1084
 __run_hrtimer kernel/time/hrtimer.c:1702 [inline]
 __hrtimer_run_queues+0xa5b/0xbe0 kernel/time/hrtimer.c:1749
 hrtimer_interrupt+0x320/0x7b0 kernel/time/hrtimer.c:1811
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1095 [inline]
 __sysvec_apic_timer_interrupt+0x14a/0x430 arch/x86/kernel/apic/apic.c:1112
 sysvec_apic_timer_interrupt+0x44/0xc0 arch/x86/kernel/apic/apic.c:1106
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
RIP: 0033:0x4804d1
Code: ff 74 1c 48 8b 0d 4f 3a ce 00 48 8b 3d 50 3a ce 00 31 c0 31 db 48 8b 6c 24 18 48 83 c4 20 c3 48 89 f1 4c 89 c7 48 8b 6c 24 18 <48> 83 c4 20 c3 48 89 44 24 08 48 89 5c 24 10 e8 fb 71 fe ff 48 8b
RSP: 002b:000000c000e954c0 EFLAGS: 00000246
RAX: 0000000000921f51 RBX: 0000000000000005 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 000000c000e95520 R08: 0000000000000000 R09: 0000000000921f50
R10: 0000000000921f51 R11: 0000000000000000 R12: 000000c000e95468
R13: ffffffffffffffff R14: 000000c000083860 R15: 000000c00dbb6c00
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
