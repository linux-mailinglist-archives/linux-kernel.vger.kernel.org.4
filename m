Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378876234A5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 21:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbiKIUcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 15:32:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiKIUct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 15:32:49 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498721DA5E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 12:32:47 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id 15-20020a056e0220cf00b0030099e75602so5388ilq.21
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 12:32:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4MU/g/1UDkfBximrQEkFo0xsospwITNXw5+wRoYC7Yk=;
        b=Jc3CNVKK1vLQg8boq/czzyPgDvuYs/GLC7QAjRlNMl9PkPfayB83q+V8DH8U0qHLbd
         hmX+qyj7bJ1eRC5tH1j1OWnBCYcrp4cvYoD12wdjFG6DWM+HJ29dwWVUMxl1DzJtbVoE
         iTs2mefHNWcOfkUloPVvDh9YT8vvz1xrHjB8P2NPTR0OiYLygGFunlbZK6ms4Cj8PPC8
         p/ipifZtqDmeLbMTDq4ZczNk8QIRg6RlyEk9Yqs4blTRLa4SVMuQcfgSQsdY/557OAre
         P3lAePUINyKGLZnux23Q9gd1saekomuQYSV+lS0nSUvLYe9OZwUW2gvwFYANsE9WgPdy
         Gn8w==
X-Gm-Message-State: ACrzQf3L/TPmuJZYyQCHPQNuwXnv4GJgj3QgrsaMhsayNeUr0n2ULn5D
        ht5b+bK6ySq+fSEX2oBPvEpewZ8TA1UqdxnN3NDljjJEC7wd
X-Google-Smtp-Source: AMsMyM6ISXKSHKNw+UNIO6IJ8bKd6Avm8P4YGoC1AXmFgxqDIcnIIjBcIkBVWiRCLm0xREP820PExg9gju424a5FM4nv87ID/Lgf
MIME-Version: 1.0
X-Received: by 2002:a6b:671c:0:b0:6ca:d264:6d84 with SMTP id
 b28-20020a6b671c000000b006cad2646d84mr35835878ioc.174.1668025966607; Wed, 09
 Nov 2022 12:32:46 -0800 (PST)
Date:   Wed, 09 Nov 2022 12:32:46 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000037441f05ed0f8f9f@google.com>
Subject: [syzbot] INFO: task hung in nilfs_segctor_thread
From:   syzbot <syzbot+f0c4082ce5ebebdac63b@syzkaller.appspotmail.com>
To:     konishi.ryusuke@gmail.com, linux-kernel@vger.kernel.org,
        linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    089d1c31224e Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=163a050e880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f7e100ed8aaa828e
dashboard link: https://syzkaller.appspot.com/bug?extid=f0c4082ce5ebebdac63b
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a02b3b8ebb13/disk-089d1c31.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/52a3c8951f42/vmlinux-089d1c31.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d370e2467349/bzImage-089d1c31.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f0c4082ce5ebebdac63b@syzkaller.appspotmail.com

INFO: task segctord:5652 blocked for more than 143 seconds.
      Not tainted 6.1.0-rc3-syzkaller-00332-g089d1c31224e #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:segctord        state:D stack:23704 pid:5652  ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5191 [inline]
 __schedule+0x8c9/0xd70 kernel/sched/core.c:6503
 schedule+0xcb/0x190 kernel/sched/core.c:6579
 rwsem_down_write_slowpath+0xfc1/0x1480 kernel/locking/rwsem.c:1190
 __down_write_common kernel/locking/rwsem.c:1305 [inline]
 __down_write kernel/locking/rwsem.c:1314 [inline]
 down_write+0x231/0x270 kernel/locking/rwsem.c:1563
 nilfs_transaction_lock+0x246/0x4b0 fs/nilfs2/segment.c:357
 nilfs_segctor_thread_construct fs/nilfs2/segment.c:2486 [inline]
 nilfs_segctor_thread+0x593/0x11c0 fs/nilfs2/segment.c:2570
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>

Showing all locks held in the system:
1 lock held by rcu_tasks_kthre/12:
 #0: ffffffff8cb22630 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x30/0xd00 kernel/rcu/tasks.h:507
1 lock held by rcu_tasks_trace/13:
 #0: ffffffff8cb22e30 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x30/0xd00 kernel/rcu/tasks.h:507
1 lock held by khungtaskd/28:
 #0: ffffffff8cb22460 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x0/0x30
3 locks held by udevd/2974:
2 locks held by getty/3289:
 #0: ffff888027ad0098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x21/0x70 drivers/tty/tty_ldisc.c:244
 #1: ffffc900031262f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x53b/0x1650 drivers/tty/n_tty.c:2177
7 locks held by syz-executor.5/5653:
1 lock held by segctord/5652:
 #0: ffff8880369932a0 (&nilfs->ns_segctor_sem){++++}-{3:3}, at: nilfs_transaction_lock+0x246/0x4b0 fs/nilfs2/segment.c:357
1 lock held by syz-executor.0/12093:
 #0: ffff88807d6b9080 (&iint->mutex){+.+.}-{3:3}, at: ima_check_last_writer security/integrity/ima/ima_main.c:164 [inline]
 #0: ffff88807d6b9080 (&iint->mutex){+.+.}-{3:3}, at: ima_file_free+0x109/0x3a0 security/integrity/ima/ima_main.c:198
1 lock held by syz-executor.0/12095:

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 28 Comm: khungtaskd Not tainted 6.1.0-rc3-syzkaller-00332-g089d1c31224e #0
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
CPU: 1 PID: 4152 Comm: syz-fuzzer Not tainted 6.1.0-rc3-syzkaller-00332-g089d1c31224e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0033:0x42f560
Code: b4 d0 d0 16 00 00 0f 1f 40 00 48 81 fe 00 10 00 00 72 df 48 89 54 24 28 48 89 5c 24 20 48 89 f0 31 db 48 89 d9 0f 1f 44 00 00 <e8> 7b 46 fe ff 48 85 c0 75 18 48 8b 44 24 48 48 8b 4c 24 30 48 8b
RSP: 002b:000000c036133f60 EFLAGS: 00000246
RAX: 0000000001314a80 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000184 RSI: 0000000001314a80 RDI: 000000000045e5a0
RBP: 000000c036133f98 R08: 0000000000000002 R09: 0000000000000000
R10: 0000000000cdd5b8 R11: 000000c01a5937a0 R12: 000000c000042ed0
R13: 000000000186b680 R14: 000000c0009ee680 R15: 00007fd6f58ddc68
FS:  000000c0254c0890 GS:  0000000000000000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
