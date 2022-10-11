Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F6A5FAF53
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 11:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiJKJ2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 05:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiJKJ2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 05:28:34 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7BD88A7DC
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 02:28:32 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id y26-20020a5d9b1a000000b006bc71505e97so1088202ion.16
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 02:28:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bBH9PAL7BQHFNEeUcKRoFLA6m358WuCZdb8vixqEZaA=;
        b=hfK2g/rgL0+6VNXjCT2CidVpEhNmM7Nn4xvheg2ZSDA5u6fpmF//jhKkNS/6SA5vTI
         ued+L+zakIgiS6MJP61Y6XlbrVOgYdNPGdT00CsGeRBgQiya08iNkNlvjpNFeHmN4lr8
         9iNtykyk2YFw4G/TtLmYA5K8aaof1TMsaer4rGC1DS3qp6C078cVrgebR519b29m1yjM
         37eriJce6RAskLNs8RK+q1RWSIs+BVbZuytY4bsZ4RWsLGNBVVNMVp97cQlfKY1es4l2
         qaIBlOdK4vKlyB4yJ4ZucRJmsi9LDqdGCnMVMyxlj705Ts0wswcze/4M5wxRw7vev+ne
         V8TA==
X-Gm-Message-State: ACrzQf167xyjng1SX0s+v5RxGdPkVQA+8w8rF5qRp8EFOlZMtBWvX0fJ
        j3HXWMAppjhGkHIXoUAR+uPcJoMaNeQdNqr0iZ2F/K3/orhX
X-Google-Smtp-Source: AMsMyM5EsfM+DWUUwqm4r9s7IBwgUU3MPv88gdEwV6gRVxsKY1pgmCDZWNrOpWgEE6vSqX0bAdEMDMoMyoL4rQRP/1g/IJeL5fUp
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1595:b0:6a1:cfa8:bff5 with SMTP id
 e21-20020a056602159500b006a1cfa8bff5mr10285645iow.94.1665480512214; Tue, 11
 Oct 2022 02:28:32 -0700 (PDT)
Date:   Tue, 11 Oct 2022 02:28:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004f9dd605eabee6dc@google.com>
Subject: [syzbot] INFO: task hung in __get_metapage
From:   syzbot <syzbot+84c274731411665e6c52@syzkaller.appspotmail.com>
To:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    493ffd6605b2 Merge tag 'ucount-rlimits-cleanups-for-v5.19'..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=104781dc880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d19f5d16783f901
dashboard link: https://syzkaller.appspot.com/bug?extid=84c274731411665e6c52
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1697c1a4880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=103e09dc880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f1ff6481e26f/disk-493ffd66.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/101bd3c7ae47/vmlinux-493ffd66.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/c56d1648ea0c/mount_2.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+84c274731411665e6c52@syzkaller.appspotmail.com

INFO: task jfsCommit:121 blocked for more than 143 seconds.
      Not tainted 6.0.0-syzkaller-09423-g493ffd6605b2 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:jfsCommit       state:D stack:24280 pid:  121 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5183 [inline]
 __schedule+0x91f/0xdf0 kernel/sched/core.c:6495
 schedule+0xcb/0x190 kernel/sched/core.c:6571
 io_schedule+0x83/0x100 kernel/sched/core.c:8715
 __lock_metapage+0x209/0x330 fs/jfs/jfs_metapage.c:50
 lock_metapage fs/jfs/jfs_metapage.c:64 [inline]
 __get_metapage+0x849/0xff0 fs/jfs/jfs_metapage.c:639
 diIAGRead+0xca/0x130 fs/jfs/jfs_imap.c:2662
 diFree+0x8fa/0x2c90 fs/jfs/jfs_imap.c:955
 jfs_evict_inode+0x323/0x440 fs/jfs/inode.c:156
 evict+0x2a4/0x620 fs/inode.c:664
 txUpdateMap+0x8eb/0xaa0 fs/jfs/jfs_txnmgr.c:2362
 txLazyCommit fs/jfs/jfs_txnmgr.c:2659 [inline]
 jfs_lazycommit+0x433/0xba0 fs/jfs/jfs_txnmgr.c:2727
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
INFO: lockdep is turned off.
NMI backtrace for cpu 0
CPU: 0 PID: 29 Comm: khungtaskd Not tainted 6.0.0-syzkaller-09423-g493ffd6605b2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 nmi_cpu_backtrace+0x425/0x450 lib/nmi_backtrace.c:111
 nmi_trigger_cpumask_backtrace+0x169/0x280 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:148 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:212 [inline]
 watchdog+0xcd5/0xd20 kernel/hung_task.c:369
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 3611 Comm: strace-static-x Not tainted 6.0.0-syzkaller-09423-g493ffd6605b2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
RIP: 0010:__might_fault+0x7d/0x110 mm/memory.c:5582
Code: c0 ff 5b 41 5c 41 5e 41 5f 5d c3 4c 89 ff 44 89 f6 e8 67 a1 96 ff 48 81 c3 28 05 00 00 48 89 dd 48 c1 ed 03 42 80 7c 25 00 00 <74> 08 48 89 df e8 39 2c 14 00 48 8b 3b 48 85 ff 74 58 48 81 c7 28
RSP: 0018:ffffc90003bcfc50 EFLAGS: 00000246
RAX: d231c7be326ee100 RBX: ffff88801c48dda8 RCX: 0000000000000000
RDX: ffff88801c48d880 RSI: ffff88801c48dcbc RDI: ffffc90003bcfbc0
RBP: 1ffff11003891bb5 R08: ffffffff81c5bf8c R09: ffffed1003c3a0dd
R10: ffffed1003c3a0dd R11: 1ffff11003c3a0dc R12: dffffc0000000000
R13: 1ffff92000779f94 R14: 00000000000006a5 R15: ffffffff8a8c3bf8
FS:  0000000000d12340(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3f1d8b2c10 CR3: 000000001d844000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 kernel_wait4+0x2ca/0x3c0 kernel/exit.c:1701
 __do_sys_wait4 kernel/exit.c:1727 [inline]
 __se_sys_wait4 kernel/exit.c:1723 [inline]
 __x64_sys_wait4+0x117/0x1c0 kernel/exit.c:1723
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x4d49a6
Code: 00 00 00 90 31 c9 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 49 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 11 b8 3d 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 5a c3 90 48 83 ec 28 89 54 24 14 48 89 74 24
RSP: 002b:00007ffd0333c588 EFLAGS: 00000246 ORIG_RAX: 000000000000003d
RAX: ffffffffffffffda RBX: 0000000000d122f8 RCX: 00000000004d49a6
RDX: 0000000040000000 RSI: 00007ffd0333c5ac RDI: 00000000ffffffff
RBP: 0000000000000000 R08: 0000000000000017 R09: 0000000000000004
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000d182b0
R13: 0000000000000000 R14: 00007ffd0333c5ac R15: 0000000000617180
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
