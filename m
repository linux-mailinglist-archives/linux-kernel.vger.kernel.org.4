Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330D860EBE8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 00:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233932AbiJZW6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 18:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiJZW6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 18:58:40 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97EC17199E
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 15:58:39 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id u11-20020a6b490b000000b006bbcc07d893so11651061iob.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 15:58:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AptnPqhvl/RmbbRCiNAL+QuT41rFvT1BUdRpiTxff7s=;
        b=C3JhflrbQJ2ex2ecXXqjzVEpLMrW4nHH7X/QmTSoir9V1ajzh8y+BtmrxbUrdNuGr/
         IMrUyTRQwDgFV/ZzMQvQb/gtEfv6TDR1g7tsukUId8NrVIKVcZclSqVtavSKG8s7z709
         Tzd341VcGGF90YzIxhsVmcfVDuPT2BJJw5Ogi3F04G697e6MGuTIH5Hy8Q2J6JitCaoU
         G9UJY/olkudHy+9zlLnRs0uZUp+BcIxsQuTrgOf2ZUfYgVzeSnbTpex1ZIoi9RfMr435
         WmjV6JfKVaSUIPUJELxaip4eQtmkCxUGm9p/+dlzo+bDfAm5xpnuiksoqPzsngqGZ3kx
         rtqg==
X-Gm-Message-State: ACrzQf21xvAF8NP5TCkxJC1Z0M3TrMgPpFiuchTR+mvLCjSErr3x8YJu
        0K+1AWF2SenLZGzg/+mMEGBIsQ8sNDr8rn/rwqVdpvpB2XH7
X-Google-Smtp-Source: AMsMyM5PN9yi7mHZtsYMRFVhxnlgTt4s3V1oPQBxV81NOgKTL2VMYwMUN+FaG4X7IrlCSMPeSulYRfJSbgAyX56tZ+vVJTOPi0cg
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a41:b0:2fa:969d:fcd0 with SMTP id
 u1-20020a056e021a4100b002fa969dfcd0mr29670824ilv.6.1666825118981; Wed, 26 Oct
 2022 15:58:38 -0700 (PDT)
Date:   Wed, 26 Oct 2022 15:58:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001ea37505ebf7f76f@google.com>
Subject: [syzbot] INFO: task hung in lock_metapage
From:   syzbot <syzbot+1d84a1682e4673d5c4fb@syzkaller.appspotmail.com>
To:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    4da34b7d175d Merge tag 'thermal-6.1-rc2' of git://git.kern..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16d8632c880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea03ca45176080bc
dashboard link: https://syzkaller.appspot.com/bug?extid=1d84a1682e4673d5c4fb
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16d34f76880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=140885ba880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/16383add8425/disk-4da34b7d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/98ccd5b01b67/vmlinux-4da34b7d.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/b4f21acc14af/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1d84a1682e4673d5c4fb@syzkaller.appspotmail.com

INFO: task jfsCommit:121 blocked for more than 143 seconds.
      Not tainted 6.1.0-rc1-syzkaller-00249-g4da34b7d175d #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:jfsCommit       state:D stack:28520 pid:121   ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5191 [inline]
 __schedule+0xae9/0x53f0 kernel/sched/core.c:6503
 schedule+0xda/0x1b0 kernel/sched/core.c:6579
 io_schedule+0xba/0x130 kernel/sched/core.c:8723
 __lock_metapage fs/jfs/jfs_metapage.c:50 [inline]
 lock_metapage+0x235/0x4d0 fs/jfs/jfs_metapage.c:64
 __get_metapage+0x3d8/0xef0 fs/jfs/jfs_metapage.c:639
 diIAGRead.isra.0+0xcd/0x140 fs/jfs/jfs_imap.c:2662
 diFree+0x9ed/0x2660 fs/jfs/jfs_imap.c:955
 jfs_evict_inode+0x3c1/0x4a0 fs/jfs/inode.c:156
 evict+0x2ed/0x6b0 fs/inode.c:664
 iput_final fs/inode.c:1747 [inline]
 iput.part.0+0x59b/0x880 fs/inode.c:1773
 iput+0x58/0x70 fs/inode.c:1763
 txUpdateMap+0x97c/0xc50 fs/jfs/jfs_txnmgr.c:2362
 txLazyCommit fs/jfs/jfs_txnmgr.c:2659 [inline]
 jfs_lazycommit+0x5bb/0xaa0 fs/jfs/jfs_txnmgr.c:2727
 kthread+0x2e4/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
INFO: lockdep is turned off.
NMI backtrace for cpu 0
CPU: 0 PID: 28 Comm: khungtaskd Not tainted 6.1.0-rc1-syzkaller-00249-g4da34b7d175d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 nmi_cpu_backtrace.cold+0x24/0x18a lib/nmi_backtrace.c:111
 nmi_trigger_cpumask_backtrace+0x32f/0x3c0 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:148 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:220 [inline]
 watchdog+0xc71/0xfc0 kernel/hung_task.c:377
 kthread+0x2e4/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 4980 Comm: syz-executor309 Not tainted 6.1.0-rc1-syzkaller-00249-g4da34b7d175d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
RIP: 0010:migrate_disable_switch kernel/sched/core.c:2200 [inline]
RIP: 0010:__schedule+0x4a7/0x53f0 kernel/sched/core.c:6497
Code: 4d 89 a5 18 0a 00 00 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 8f 41 00 00 48 8b 85 10 ff ff ff 48 83 00 01 <48> 8b 85 70 ff ff ff 48 8d b8 38 04 00 00 48 b8 00 00 00 00 00 fc
RSP: 0018:ffffc90004c4fc50 EFLAGS: 00000002
RAX: ffff88807ce28768 RBX: ffff88807ce28000 RCX: ffffffff898fb935
RDX: 1ffff1100f9c50ed RSI: 0000000000000008 RDI: ffff8880b9b3a190
RBP: ffffc90004c4fd90 R08: 0000000000000001 R09: ffff88807ce28007
R10: ffffed100f9c5000 R11: 0000000000000002 R12: ffff888020693a80
R13: ffff8880b9b3a100 R14: ffff88807ce28290 R15: ffffc90004c4fd28
FS:  0000555556466300(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2c623c9b80 CR3: 0000000016fdd000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 schedule+0xda/0x1b0 kernel/sched/core.c:6579
 ptrace_stop.part.0+0x490/0x8c0 kernel/signal.c:2308
 ptrace_stop kernel/signal.c:2233 [inline]
 ptrace_do_notify+0x215/0x2b0 kernel/signal.c:2345
 ptrace_notify+0xc4/0x140 kernel/signal.c:2357
 ptrace_report_syscall include/linux/ptrace.h:420 [inline]
 ptrace_report_syscall_exit include/linux/ptrace.h:482 [inline]
 syscall_exit_work kernel/entry/common.c:251 [inline]
 syscall_exit_to_user_mode_prepare+0x129/0x280 kernel/entry/common.c:278
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x9/0x50 kernel/entry/common.c:296
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f2c623582d6
Code: b8 ff ff ff ff eb b9 e8 28 34 04 00 0f 1f 84 00 00 00 00 00 49 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 11 b8 12 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 5a c3 90 48 83 ec 28 48 89 54 24 10 48 89 74
RSP: 002b:00007ffd4d6194d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000012
RAX: 00000000000000a0 RBX: 0000000000000003 RCX: 00007f2c623582d6
RDX: 00000000000000a0 RSI: 0000000020031a60 RDI: 0000000000000003
RBP: 00007ffd4d6194f0 R08: 00007ffd4d619370 R09: 00005555564662c0
R10: 0000000000f7af80 R11: 0000000000000246 R12: 0000000000000322
R13: 0000000000000003 R14: 00000000000001b2 R15: 0000000020002ab0
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
