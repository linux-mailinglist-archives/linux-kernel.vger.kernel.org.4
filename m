Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E9364F803
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 07:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbiLQGtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 01:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLQGtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 01:49:49 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1550CB1FE
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 22:49:48 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id n23-20020a056602341700b00689fc6dbfd6so2294922ioz.8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 22:49:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GyQq3J/CsQAhIaTo8vCcmGo+Pj4aGJUo66uY5Wlp/xU=;
        b=eu7XfLvB8VqN82Eah/qzjyfPEOvhjBDe1YWtUk0mZA5LnAMgeaRebgkRnwZ33IvRoo
         6Fs8MafWwYr0aXu0x/bih/zdgYTo5jGIQE05Veo65o117Yg633IobL5Ac9CfiC5EN4HG
         EkVcjX92KHtjpM9poK3/AH2+bcGvbgzC8QYBszn3pocN6f6LsP2q/GVyIuHTG9O3zVA6
         BahV+PYtcnudXPGiem9Dbmz6dtvbrOByLvRY4qp1vUSxG+qrSPAntAewMagNDoqjHM5K
         Vvwz7a6R83zmsbbiW74w2LgoEWR5xTC2CeCq8h4wOqvPUNQ+B3TiwiIjZyv3vJdb81jZ
         xhWQ==
X-Gm-Message-State: ANoB5pluy35Lqx3cYBhzi23uH+ZdJysOVH6qGWwoiRv5XLBL7z/M6ITR
        x5rqHaYcaogkPXieHmsmGK+2hWZ/V0kyBPpPstfp+NCxCLPa
X-Google-Smtp-Source: AA0mqf7DRFT0Eh75MRLv+Lwe9y5M4ZmigwmS09P9gLiFONoTfLtVLXR6xdRGWQT46OTBwi9FBhMZZdN0hjedrYNc8NCkcWd/8w8T
MIME-Version: 1.0
X-Received: by 2002:a02:5447:0:b0:38a:66d5:f599 with SMTP id
 t68-20020a025447000000b0038a66d5f599mr7466588jaa.274.1671259787365; Fri, 16
 Dec 2022 22:49:47 -0800 (PST)
Date:   Fri, 16 Dec 2022 22:49:47 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f413dc05f0007d10@google.com>
Subject: [syzbot] [ntfs3?] INFO: task hung in attr_data_get_block
From:   syzbot <syzbot+0ed04a03534f9788b484@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev,
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

HEAD commit:    830b3c68c1fb Linux 6.1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1647ee1f880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5a194ed4fc682723
dashboard link: https://syzkaller.appspot.com/bug?extid=0ed04a03534f9788b484
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12b69bc7880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17ecbc3b880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/955d55d85d6c/disk-830b3c68.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7ef0e1f6a0c3/vmlinux-830b3c68.xz
kernel image: https://storage.googleapis.com/syzbot-assets/27601eb5ff0b/bzImage-830b3c68.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/bdcae8f0f777/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0ed04a03534f9788b484@syzkaller.appspotmail.com

INFO: task syz-executor194:6265 blocked for more than 143 seconds.
      Not tainted 6.1.0-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor194 state:D stack:21160 pid:6265  ppid:3719   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5209 [inline]
 __schedule+0x8c9/0xd70 kernel/sched/core.c:6521
 schedule+0xcb/0x190 kernel/sched/core.c:6597
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6656
 __mutex_lock_common+0xe4f/0x26e0 kernel/locking/mutex.c:679
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x17/0x20 kernel/locking/mutex.c:799
 ni_lock fs/ntfs3/ntfs_fs.h:1108 [inline]
 attr_data_get_block+0x301/0x2370 fs/ntfs3/attrib.c:917
 ntfs_get_block_vbo+0x310/0xe40 fs/ntfs3/inode.c:564
 do_mpage_readpage+0x970/0x1c50 fs/mpage.c:208
 mpage_readahead+0x210/0x380 fs/mpage.c:361
 read_pages+0x169/0x9c0 mm/readahead.c:161
 page_cache_ra_unbounded+0x703/0x820 mm/readahead.c:270
 filemap_readahead mm/filemap.c:2557 [inline]
 filemap_get_pages+0x72f/0x10d0 mm/filemap.c:2597
 filemap_read+0x3cf/0xea0 mm/filemap.c:2675
 call_read_iter include/linux/fs.h:2193 [inline]
 generic_file_splice_read+0x1ff/0x5d0 fs/splice.c:309
 do_splice_to fs/splice.c:793 [inline]
 splice_direct_to_actor+0x41b/0xc00 fs/splice.c:865
 do_splice_direct+0x279/0x3d0 fs/splice.c:974
 do_sendfile+0x5fb/0xf80 fs/read_write.c:1255
 __do_sys_sendfile64 fs/read_write.c:1323 [inline]
 __se_sys_sendfile64+0x14f/0x1b0 fs/read_write.c:1309
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f8784c2fe69
RSP: 002b:00007f8784bda208 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f8784cd37a8 RCX: 00007f8784c2fe69
RDX: 0000000000000000 RSI: 0000000000000005 RDI: 0000000000000004
RBP: 00007f8784cd37a0 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000010007c9 R11: 0000000000000246 R12: 00007f8784cd37ac
R13: 00007ffda4d8823f R14: 00007f8784bda300 R15: 0000000000022000
 </TASK>
INFO: task syz-executor194:6275 blocked for more than 144 seconds.
      Not tainted 6.1.0-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor194 state:D stack:22856 pid:6275  ppid:3719   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5209 [inline]
 __schedule+0x8c9/0xd70 kernel/sched/core.c:6521
 schedule+0xcb/0x190 kernel/sched/core.c:6597
 io_schedule+0x83/0x100 kernel/sched/core.c:8741
 folio_wait_bit_common+0x83a/0x12a0 mm/filemap.c:1296
 folio_lock include/linux/pagemap.h:939 [inline]
 truncate_inode_pages_range+0xc9d/0x17f0 mm/truncate.c:423
 truncate_inode_pages mm/truncate.c:452 [inline]
 truncate_pagecache mm/truncate.c:753 [inline]
 truncate_setsize+0xcb/0xf0 mm/truncate.c:778
 ntfs_truncate fs/ntfs3/file.c:491 [inline]
 ntfs3_setattr+0x4f2/0xb00 fs/ntfs3/file.c:792
 notify_change+0xe38/0x10f0 fs/attr.c:420
 do_truncate+0x1fb/0x2e0 fs/open.c:65
 handle_truncate fs/namei.c:3216 [inline]
 do_open fs/namei.c:3561 [inline]
 path_openat+0x2770/0x2df0 fs/namei.c:3714
 do_filp_open+0x264/0x4f0 fs/namei.c:3741
 do_sys_openat2+0x124/0x4e0 fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_creat fs/open.c:1402 [inline]
 __se_sys_creat fs/open.c:1396 [inline]
 __x64_sys_creat+0x11f/0x160 fs/open.c:1396
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f8784c2fe69
RSP: 002b:00007f877c9b9208 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 00007f8784cd37b8 RCX: 00007f8784c2fe69
RDX: 00007f877c9b9700 RSI: 0000000000000000 RDI: 0000000020000180
RBP: 00007f8784cd37b0 R08: 00007f877c9b9700 R09: 0000000000000000
R10: 00007f877c9b9700 R11: 0000000000000246 R12: 00007f8784cd37bc
R13: 00007ffda4d8823f R14: 00007f877c9b9300 R15: 0000000000022000
 </TASK>

Showing all locks held in the system:
1 lock held by rcu_tasks_kthre/12:
 #0: ffffffff8d127330 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x30/0xd00 kernel/rcu/tasks.h:507
1 lock held by rcu_tasks_trace/13:
 #0: ffffffff8d127b30 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x30/0xd00 kernel/rcu/tasks.h:507
1 lock held by khungtaskd/28:
 #0: 
ffffffff8d127160 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x0/0x30
2 locks held by getty/3312:
 #0: ffff888017ba7098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x21/0x70 drivers/tty/tty_ldisc.c:244
 #1: ffffc900031262f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x53b/0x1650 drivers/tty/n_tty.c:2177
3 locks held by syz-executor194/6265:
 #0: ffff88807c0ce460 (sb_writers#10){.+.+}-{0:0}, at: do_sendfile+0x5d6/0xf80 fs/read_write.c:1254
 #1: ffff8880707022c0 (mapping.invalidate_lock#3){.+.+}-{3:3}, at: filemap_invalidate_lock_shared include/linux/fs.h:811 [inline]
 #1: ffff8880707022c0 (mapping.invalidate_lock#3){.+.+}-{3:3}, at: page_cache_ra_unbounded+0xe9/0x820 mm/readahead.c:226
 #2: ffff888070701e80 (&ni->ni_lock/4){+.+.}-{3:3}, at: ni_lock fs/ntfs3/ntfs_fs.h:1108 [inline]
 #2: ffff888070701e80 (&ni->ni_lock/4){+.+.}-{3:3}, at: attr_data_get_block+0x301/0x2370 fs/ntfs3/attrib.c:917
3 locks held by syz-executor194/6275:
 #0: ffff88807c0ce460 (sb_writers#10){.+.+}-{0:0}, at: mnt_want_write+0x3b/0x80 fs/namespace.c:393
 #1: ffff888070702120 (&sb->s_type->i_mutex_key#18){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:756 [inline]
 #1: ffff888070702120 (&sb->s_type->i_mutex_key#18){+.+.}-{3:3}, at: do_truncate+0x1e7/0x2e0 fs/open.c:63
 #2: ffff888070701e80 (&ni->ni_lock/4){+.+.}-{3:3}, at: ni_lock fs/ntfs3/ntfs_fs.h:1108 [inline]
 #2: ffff888070701e80 (&ni->ni_lock/4){+.+.}-{3:3}, at: ntfs_truncate fs/ntfs3/file.c:489 [inline]
 #2: ffff888070701e80 (&ni->ni_lock/4){+.+.}-{3:3}, at: ntfs3_setattr+0x4e3/0xb00 fs/ntfs3/file.c:792
2 locks held by syz-executor194/11945:
 #0: ffff8880b9839dd8 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x25/0x110 kernel/sched/core.c:537
 #1: ffff8880b9827788 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x611/0x9a0 kernel/sched/psi.c:909

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 28 Comm: khungtaskd Not tainted 6.1.0-syzkaller #0
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
CPU: 1 PID: 11955 Comm: syz-executor194 Not tainted 6.1.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:io_serial_out+0x79/0xb0 drivers/tty/serial/8250/8250_port.c:467
Code: fc 89 e9 41 d3 e7 48 83 c3 40 48 89 d8 48 c1 e8 03 42 80 3c 20 00 74 08 48 89 df e8 81 16 2a fd 44 03 3b 44 89 f0 44 89 fa ee <5b> 41 5c 41 5e 41 5f 5d c3 89 e9 80 e1 07 38 c1 7c ab 48 89 ef e8
RSP: 0018:ffffc9000b917350 EFLAGS: 00000002
RAX: 0000000000000030 RBX: ffffffff92117ec0 RCX: 0000000000000000
RDX: 00000000000003f8 RSI: 0000000000000000 RDI: 0000000000000020
RBP: 0000000000000000 R08: ffffffff84b4ae06 R09: ffffed1003ca6047
R10: ffffed1003ca6047 R11: 1ffff11003ca6046 R12: dffffc0000000000
R13: ffffffff91dd1d0a R14: 0000000000000030 R15: 00000000000003f8
FS:  00007f8784bda700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8784bdb000 CR3: 000000002109b000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 serial8250_console_write+0x14c0/0x1ab0 drivers/tty/serial/8250/8250_port.c:3436
 call_console_driver kernel/printk/printk.c:1942 [inline]
 console_emit_next_record+0x778/0xa40 kernel/printk/printk.c:2731
 console_unlock+0x27c/0x6f0 kernel/printk/printk.c:2860
 vprintk_emit+0xd1/0x1e0 kernel/printk/printk.c:2268
 _printk+0xc0/0x100 kernel/printk/printk.c:2289
 ntfs_printk+0x2fa/0x340 fs/ntfs3/super.c:68
 ntfs_init_from_boot fs/ntfs3/super.c:758 [inline]
 ntfs_fill_super+0xe69/0x42a0 fs/ntfs3/super.c:935
 get_tree_bdev+0x400/0x620 fs/super.c:1324
 vfs_get_tree+0x88/0x270 fs/super.c:1531
 do_new_mount+0x289/0xad0 fs/namespace.c:3040
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f8784c3132a
Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 08 01 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8784bda078 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f8784c3132a
RDX: 000000002001f180 RSI: 000000002001f1c0 RDI: 00007f8784bda090
RBP: 0000000000000004 R08: 00007f8784bda0d0 R09: 000000000001f16e
R10: 000000000000000e R11: 0000000000000286 R12: 00007f8784bda6b8
R13: 00007f8784bda090 R14: 00007f8784bda0d0 R15: 000000000000000e
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.040 msecs


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
