Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2B5647FD9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 10:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiLIJIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 04:08:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiLIJIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 04:08:39 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0091654763
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 01:08:38 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id s22-20020a6bdc16000000b006e2d7c78010so982111ioc.21
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 01:08:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TF5ie83wtsfTTxZXUekCgjhjLY7yojLkVvnRe+vUtyM=;
        b=Me+008K/EqBRvzAOqhuoL7JPYuhlLILQaqgFA/nrUCbaH+xuhRN1VTOu2qhJqsEVwN
         EgB3iiDVEFAX9ebpmpRXIpuibh7AjjUDXqjA0pI6DwWNR1t7AJKW9/sZ/k2DTCHaFa+8
         8A5ylUOJvs7kQp3oPBYrhsROdmufynVtYubHr00A3TV9D2avJESHhSK6SJltdYAQ8NKd
         sL79tjDklRWgJhQc+WXujFp4UbBynPLeHdHThHGXqf2fT0RDObxUKINTIdpeUuVE61NM
         DqMsvKfeUGOs3IlGIa8TKF6SlhyS5t32rkHf1L/AuAiLzt1mjnUvbI7BwReBODv/EitF
         AlmA==
X-Gm-Message-State: ANoB5pmg6TK2egSkptS85CLQQpKdsXK2bPcV4z0NZUPuEnQRaXOKsD2Q
        ZtAZItP0HmJrX9Xa2hDtGTsgJAdby5B8ub+IfR2IJMzMxBMu
X-Google-Smtp-Source: AA0mqf6cE9yHQUgca5kuYwvj+IN3MpzzKMBs+pnpBfLAiP+iidl9ZpW3A0AOZrQdp4Xl2Pgq97kmOqaQpg3jqR5qn0V8aQJVBDKn
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1007:b0:300:ea06:8f3d with SMTP id
 n7-20020a056e02100700b00300ea068f3dmr35541707ilj.128.1670576918305; Fri, 09
 Dec 2022 01:08:38 -0800 (PST)
Date:   Fri, 09 Dec 2022 01:08:38 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c921b105ef617f05@google.com>
Subject: [syzbot] INFO: task hung in freeze_super (3)
From:   syzbot <syzbot+f51cb4b9afbd87ec06f2@syzkaller.appspotmail.com>
To:     agruenba@redhat.com, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, rpeterso@redhat.com,
        syzkaller-bugs@googlegroups.com
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

HEAD commit:    f3e8416619ce Merge tag 'soc-fixes-6.1-5' of git://git.kern..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12fb534d880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d58e7fe7f9cf5e24
dashboard link: https://syzkaller.appspot.com/bug?extid=f51cb4b9afbd87ec06f2
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=123d216b880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16e46f5b880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/628abc27cbe7/disk-f3e84166.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2f19ea836174/vmlinux-f3e84166.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f2e1347e85a5/bzImage-f3e84166.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/c239a19c8749/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f51cb4b9afbd87ec06f2@syzkaller.appspotmail.com

INFO: task kworker/0:1H:120 blocked for more than 143 seconds.
      Not tainted 6.1.0-rc8-syzkaller-00035-gf3e8416619ce #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:1H    state:D stack:23480 pid:120   ppid:2      flags:0x00004000
Workqueue: glock_workqueue glock_work_func
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5209 [inline]
 __schedule+0x8c9/0xd70 kernel/sched/core.c:6521
 schedule+0xcb/0x190 kernel/sched/core.c:6597
 rwsem_down_write_slowpath+0xfc1/0x1480 kernel/locking/rwsem.c:1190
 __down_write_common kernel/locking/rwsem.c:1305 [inline]
 __down_write kernel/locking/rwsem.c:1314 [inline]
 down_write+0x231/0x270 kernel/locking/rwsem.c:1563
 freeze_super+0x45/0x420 fs/super.c:1697
 freeze_go_sync+0x178/0x340 fs/gfs2/glops.c:573
 do_xmote+0x34d/0x13d0 fs/gfs2/glock.c:776
 glock_work_func+0x2c2/0x450 fs/gfs2/glock.c:1082
 process_one_work+0x877/0xdb0 kernel/workqueue.c:2289
 worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
INFO: task syz-executor330:3631 blocked for more than 143 seconds.
      Not tainted 6.1.0-rc8-syzkaller-00035-gf3e8416619ce #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor330 state:D stack:20176 pid:3631  ppid:3630   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5209 [inline]
 __schedule+0x8c9/0xd70 kernel/sched/core.c:6521
 schedule+0xcb/0x190 kernel/sched/core.c:6597
 schedule_timeout+0x98/0x2f0 kernel/time/timer.c:1911
 do_wait_for_common+0x3ea/0x560 kernel/sched/completion.c:85
 __wait_for_common kernel/sched/completion.c:106 [inline]
 wait_for_common kernel/sched/completion.c:117 [inline]
 wait_for_completion+0x46/0x60 kernel/sched/completion.c:138
 __flush_workqueue+0x74a/0x1680 kernel/workqueue.c:2861
 gfs2_gl_hash_clear+0xbe/0x300 fs/gfs2/glock.c:2262
 gfs2_fill_super+0x2202/0x2700 fs/gfs2/ops_fstype.c:1307
 get_tree_bdev+0x400/0x620 fs/super.c:1324
 gfs2_get_tree+0x50/0x210 fs/gfs2/ops_fstype.c:1330
 vfs_get_tree+0x88/0x270 fs/super.c:1531
 do_new_mount+0x289/0xad0 fs/namespace.c:3040
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f19da3f458a
RSP: 002b:00007ffd6b2d69e8 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f19da3f458a
RDX: 0000000020000040 RSI: 000000002003b300 RDI: 00007ffd6b2d6a00
RBP: 00007ffd6b2d6a00 R08: 00007ffd6b2d6a40 R09: 0000000000000002
R10: 0000000000000000 R11: 0000000000000282 R12: 0000000000000004
R13: 0000555556b0d2c0 R14: 0000000000000000 R15: 00007ffd6b2d6a40
 </TASK>

Showing all locks held in the system:
1 lock held by rcu_tasks_kthre/12:
 #0: ffffffff8d127330 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x30/0xd00 kernel/rcu/tasks.h:507
1 lock held by rcu_tasks_trace/13:
 #0: ffffffff8d127b30 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x30/0xd00 kernel/rcu/tasks.h:507
1 lock held by khungtaskd/28:
 #0: ffffffff8d127160 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x0/0x30
3 locks held by kworker/0:1H/120:
 #0: ffff8880194f5d38 ((wq_completion)glock_workqueue){+.+.}-{0:0}, at: process_one_work+0x7f2/0xdb0
 #1: ffffc90002587d00 ((work_completion)(&(&gl->gl_work)->work)){+.+.}-{0:0}, at: process_one_work+0x831/0xdb0 kernel/workqueue.c:2264
 #2: ffff888026c2c0e0 (&type->s_umount_key#42){+.+.}-{3:3}, at: freeze_super+0x45/0x420 fs/super.c:1697
2 locks held by getty/3308:
 #0: ffff888028211098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x21/0x70 drivers/tty/tty_ldisc.c:244
 #1: ffffc900031262f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x53b/0x1650 drivers/tty/n_tty.c:2177
1 lock held by syz-executor330/3631:
 #0: ffff888026c2c0e0 (&type->s_umount_key#41/1){+.+.}-{3:3}, at: alloc_super+0x212/0x920 fs/super.c:228

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 28 Comm: khungtaskd Not tainted 6.1.0-rc8-syzkaller-00035-gf3e8416619ce #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 nmi_cpu_backtrace+0x46f/0x4f0 lib/nmi_backtrace.c:111
 nmi_trigger_cpumask_backtrace+0x1ba/0x420 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:148 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:220 [inline]
 watchdog+0xcf5/0xd40 kernel/hung_task.c:377
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.1.0-rc8-syzkaller-00035-gf3e8416619ce #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:debug_smp_processor_id+0x7/0x10 lib/smp_processor_id.c:60
Code: e8 0e 97 d7 f9 e9 50 ff ff ff 48 c7 c7 00 44 1c 8d 48 89 de e8 fa 96 d7 f9 e9 64 ff ff ff cc cc cc cc cc 48 c7 c7 40 3f 4b 8b <48> c7 c6 80 3f 4b 8b eb 00 41 57 41 56 41 54 53 48 83 ec 10 65 48
RSP: 0018:ffffc90000177a88 EFLAGS: 00000093
RAX: ffffffff8179e533 RBX: ffff8880b992839d RCX: ffff888012a29d40
RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffffffff8b4b3f40
RBP: ffffffffffffff01 R08: dffffc0000000000 R09: ffffed1017325069
R10: ffffed1017325069 R11: 1ffff11017325068 R12: ffff8880b9928340
R13: 1ffff11017325071 R14: 00000042d0b03c33 R15: 00000042d6a61d33
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055b144b2f000 CR3: 000000000ce8e000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 hrtimer_get_next_event+0x18/0x810 kernel/time/hrtimer.c:1481
 cmp_next_hrtimer_event kernel/time/timer.c:1654 [inline]
 get_next_timer_interrupt+0x311/0x430 kernel/time/timer.c:1737
 tick_nohz_next_event+0x383/0x5f0 kernel/time/tick-sched.c:821
 tick_nohz_get_sleep_length+0x132/0x1f0 kernel/time/tick-sched.c:1238
 menu_select+0x5d1/0x1d30 drivers/cpuidle/governors/menu.c:283
 cpuidle_idle_call kernel/sched/idle.c:229 [inline]
 do_idle+0x339/0x640 kernel/sched/idle.c:303
 cpu_startup_entry+0x15/0x20 kernel/sched/idle.c:400
 start_secondary+0xe4/0xf0 arch/x86/kernel/smpboot.c:262
 secondary_startup_64_no_verify+0xcf/0xdb
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
