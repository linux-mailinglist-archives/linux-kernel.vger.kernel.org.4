Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CABAF6434C3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 20:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235081AbiLETt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 14:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235198AbiLETtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 14:49:39 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6902529A
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 11:46:42 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id d6-20020a056e02214600b00303620c6e39so2795156ilv.6
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 11:46:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sYbL8IcdGUlBSoaO4m8GVmEFvhg63uZokvFdwijQ1Cs=;
        b=xUQl2EJb3fjctNdmai/jBNcqm2MsVT5n3qTjZCyRuy/WQffrnSB+yoyte3yyRI99BR
         HquidR1Pp0AeBcP/rfAYevbvQvR8jZaRw3ysuXo/sgn4JdJxuxC/8u2am3ZFPVRfPuYL
         GK7vqcm9CNQyVHx1Qpq9tckXoeXXBGnx54lIvGRyC+a+xfkw4IAGegQETG8O1Rbl08rz
         pgW62u8NDTDGkrojS/jhI0zrjAsYcPyx+Fq0XcNfbykcJ2gV91cZRcoOutZYJ3UTRAnM
         PCR2i0IJHlLtN7G+gY8CsVslvjpvgdE6OheFtdpx0wgEFD8/vJpFBrdt/K439bu+xh2x
         zwbg==
X-Gm-Message-State: ANoB5pkHsXxSBE3V3rNkCxjDRTljoSPlA7+U5zEfoZsoKetASjfhaoT4
        8Ihjr+3Seetnii9Z3WlbgTIHPPv5n0H61qVERmLOkRICDXQq
X-Google-Smtp-Source: AA0mqf7cdB05KjJ3bqHnJPVDowjflusTvM4LBEl9b8K9tqxU68D93XEmomEhq7H0irnw8oNXS+lJfEVHH2g+awt4O5nlNwtwl88X
MIME-Version: 1.0
X-Received: by 2002:a5d:8902:0:b0:6bc:711:821 with SMTP id b2-20020a5d8902000000b006bc07110821mr38842343ion.192.1670269601860;
 Mon, 05 Dec 2022 11:46:41 -0800 (PST)
Date:   Mon, 05 Dec 2022 11:46:41 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004c586005ef19f235@google.com>
Subject: [syzbot] INFO: rcu detected stall in syscall_exit_to_user_mode (2)
From:   syzbot <syzbot+a68ef3b1f46bc3aced5c@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    b7b275e60bcd Linux 6.1-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=130547ed880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4aa2a38f1d88bd1c
dashboard link: https://syzkaller.appspot.com/bug?extid=a68ef3b1f46bc3aced5c
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e34e673da4d5/disk-b7b275e6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7cb6f1db443a/vmlinux-b7b275e6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9e69ef57132c/bzImage-b7b275e6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a68ef3b1f46bc3aced5c@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	0-...!: (0 ticks this GP) idle=7484/1/0x4000000000000000 softirq=89542/89542 fqs=2
	(detected by 1, t=10506 jiffies, g=139089, q=62 ncpus=2)
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 27664 Comm: syz-executor.4 Not tainted 6.1.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:check_wait_context kernel/locking/lockdep.c:4729 [inline]
RIP: 0010:__lock_acquire+0x423/0x56d0 kernel/locking/lockdep.c:5005
Code: 6c 6d 00 48 c1 e5 06 48 81 c5 60 be 0e 91 48 8d bd b8 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 0f b6 04 02 <84> c0 74 06 0f 8e 5e 11 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b
RSP: 0018:ffffc90000007bb8 EFLAGS: 00000802
RAX: 0000000000000000 RBX: ffff88802e6a8c10 RCX: ffffffff8161c8d9
RDX: 1ffffffff221e09b RSI: 0000000000000008 RDI: ffffffff910f04d8
RBP: ffffffff910f0420 R08: 0000000000000000 R09: ffffffff910eba4f
R10: fffffbfff221d749 R11: 0000000000000000 R12: ffff88802e6a8c60
R13: ffff88802e6a81c0 R14: ffff8880b9a2b598 R15: 0000000000044000
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020001100 CR3: 0000000021bed000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 lock_acquire kernel/locking/lockdep.c:5668 [inline]
 lock_acquire+0x1e3/0x630 kernel/locking/lockdep.c:5633
 __raw_spin_lock_irq include/linux/spinlock_api_smp.h:119 [inline]
 _raw_spin_lock_irq+0x36/0x50 kernel/locking/spinlock.c:170
 __run_hrtimer kernel/time/hrtimer.c:1689 [inline]
 __hrtimer_run_queues+0x266/0xfb0 kernel/time/hrtimer.c:1749
 hrtimer_interrupt+0x320/0x790 kernel/time/hrtimer.c:1811
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1096 [inline]
 __sysvec_apic_timer_interrupt+0x180/0x640 arch/x86/kernel/apic/apic.c:1113
 sysvec_apic_timer_interrupt+0x92/0xc0 arch/x86/kernel/apic/apic.c:1107
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:649
RIP: 0010:folio_batch_count include/linux/pagevec.h:108 [inline]
RIP: 0010:lru_add_drain_cpu+0xdf/0x850 mm/swap.c:673
Code: c1 ea 03 80 3c 02 00 0f 85 99 06 00 00 4c 03 24 ed e0 e8 ff 8b 48 b8 00 00 00 00 00 fc ff df 4c 89 e2 48 c1 ea 03 0f b6 04 02 <84> c0 74 06 0f 8e e5 05 00 00 45 0f b6 2c 24 31 ff 44 89 ee e8 e8
RSP: 0018:ffffc9000af1f928 EFLAGS: 00000a02
RAX: 0000000000000000 RBX: ffff8880b9a35d20 RCX: 0000000000000000
RDX: 1ffff11017346c02 RSI: ffffffff81ac89e6 RDI: ffff8880b9a35d51
RBP: 0000000000000000 R08: 0000000000000001 R09: ffffc9000af1f6c0
R10: fffff520015e3edc R11: 0000000000000000 R12: ffff8880b9a36010
R13: ffff8880b9a35d50 R14: ffff88802e6a81c0 R15: ffffffff8bffe8e0
 lru_add_drain+0x10c/0x440 mm/swap.c:773
 exit_mmap+0x163/0x7b0 mm/mmap.c:3089
 __mmput+0x128/0x4c0 kernel/fork.c:1185
 mmput+0x60/0x70 kernel/fork.c:1207
 exit_mm kernel/exit.c:516 [inline]
 do_exit+0xa41/0x2a30 kernel/exit.c:807
 do_group_exit+0xd4/0x2a0 kernel/exit.c:950
 get_signal+0x21b1/0x2440 kernel/signal.c:2858
 arch_do_signal_or_restart+0x86/0x2300 arch/x86/kernel/signal.c:869
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x15f/0x250 kernel/entry/common.c:203
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:296
 do_syscall_64+0x46/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f0fe108c0d9
Code: Unable to access opcode bytes at 0x7f0fe108c0af.
RSP: 002b:00007f0fe1ecd218 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: 0000000000000001 RBX: 00007f0fe11abf88 RCX: 00007f0fe108c0d9
RDX: 00000000000f4240 RSI: 0000000000000081 RDI: 00007f0fe11abf8c
RBP: 00007f0fe11abf80 R08: 00007ffea33a9080 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f0fe11abf8c
R13: 00007ffea331029f R14: 00007f0fe1ecd300 R15: 0000000000022000
 </TASK>
rcu: rcu_preempt kthread timer wakeup didn't happen for 10494 jiffies! g139089 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
rcu: 	Possible timer handling issue on cpu=1 timer-softirq=81926
rcu: rcu_preempt kthread starved for 10495 jiffies! g139089 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:I stack:28392 pid:15    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5209 [inline]
 __schedule+0xae9/0x53f0 kernel/sched/core.c:6521
 schedule+0xde/0x1b0 kernel/sched/core.c:6597
 schedule_timeout+0x14e/0x2a0 kernel/time/timer.c:1935
 rcu_gp_fqs_loop+0x190/0x910 kernel/rcu/tree.c:1660
 rcu_gp_kthread+0x23a/0x360 kernel/rcu/tree.c:1859
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
CPU: 1 PID: 23132 Comm: kworker/u4:54 Not tainted 6.1.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Workqueue: events_unbound toggle_allocation_gate
RIP: 0010:csd_lock_wait kernel/smp.c:413 [inline]
RIP: 0010:smp_call_function_many_cond+0x43f/0x10a0 kernel/smp.c:987
Code: e6 e8 95 f7 0a 00 45 85 e4 74 48 48 8b 04 24 49 89 c5 83 e0 07 49 c1 ed 03 49 89 c4 4d 01 fd 41 83 c4 03 e8 c3 fa 0a 00 f3 90 <41> 0f b6 45 00 41 38 c4 7c 08 84 c0 0f 85 4e 0a 00 00 8b 43 08 31
RSP: 0018:ffffc9000512f970 EFLAGS: 00000293
RAX: 0000000000000000 RBX: ffff8880b9a45f80 RCX: 0000000000000000
RDX: ffff888030c8c1c0 RSI: ffffffff817440fd RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000003
R13: ffffed1017348bf1 R14: 0000000000000001 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe7d24d56be CR3: 000000000c28e000 CR4: 00000000003526e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 on_each_cpu_cond_mask+0x5a/0xa0 kernel/smp.c:1155
 on_each_cpu include/linux/smp.h:71 [inline]
 text_poke_sync arch/x86/kernel/alternative.c:1311 [inline]
 text_poke_bp_batch+0x22e/0x6b0 arch/x86/kernel/alternative.c:1502
 text_poke_flush arch/x86/kernel/alternative.c:1670 [inline]
 text_poke_flush arch/x86/kernel/alternative.c:1667 [inline]
 text_poke_finish+0x1a/0x30 arch/x86/kernel/alternative.c:1677
 arch_jump_label_transform_apply+0x17/0x30 arch/x86/kernel/jump_label.c:146
 jump_label_update+0x32f/0x410 kernel/jump_label.c:801
 static_key_enable_cpuslocked+0x1b5/0x270 kernel/jump_label.c:177
 static_key_enable+0x1a/0x20 kernel/jump_label.c:190
 toggle_allocation_gate mm/kfence/core.c:800 [inline]
 toggle_allocation_gate+0x104/0x390 mm/kfence/core.c:792
 process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
 worker_thread+0x669/0x1090 kernel/workqueue.c:2436
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
