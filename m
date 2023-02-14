Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294E0695CB3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 09:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbjBNIQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 03:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbjBNIOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 03:14:46 -0500
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB7061BE
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 00:14:43 -0800 (PST)
Received: by mail-il1-f206.google.com with SMTP id k8-20020a056e02156800b003152ca1c48aso5597084ilu.21
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 00:14:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GlYqCYyXBloBLMF5vR9Z9Xz3Lu/fOJYWyAo9RmNhjiM=;
        b=J43J+vWsQmBJnl3uMgAzXfujQxVQOq1h3MeLH1APGLvUYjPUhwv/Th9N3nqvridTWd
         1yiyBSwZ+80KDxdwsVS9hdcwMpfvVPQOVb9K2x3RPlTaFxCAmunEzZAuqE9iBEtWSrce
         G78yFFD87zBMkAxb+O3fUMkCNOW/0V88wvhhhtWoMbIJ7ExHGhNU0y4VfLKODDhVI2Wz
         qOeF2AVU2HhOEJqbrG5Nb0kZCErPXJOeZYlU87WlLqfaMl6yDOXy/Mel24hA49wW6ym4
         Ji265z9IqBPshzfiW7gknxjOrmoHrvguawP0TV1SMIhHyEx40WlwsTAO+KbLoHJ3MJ+C
         wQhw==
X-Gm-Message-State: AO0yUKVpR4uTQdd+VaVapQaQXvyxVbKHtM6R9Gecy4OGw2BaQUr/1vFX
        kF4bsJYXKBAqC9w5YODSGIaLsbDblIYh0aFJhrVgUi6ejmBy
X-Google-Smtp-Source: AK7set9+73byzPLLVn0Nxlt9oxlJNcgqlNtJ8AFzI8jucgjzzye1nYcrpP3jF76eCNV6n+TE4RVrWS8o7+q6u8yfdYuUy34LDkGl
MIME-Version: 1.0
X-Received: by 2002:a92:7a0c:0:b0:310:efc8:49bf with SMTP id
 v12-20020a927a0c000000b00310efc849bfmr297094ilc.5.1676362482848; Tue, 14 Feb
 2023 00:14:42 -0800 (PST)
Date:   Tue, 14 Feb 2023 00:14:42 -0800
In-Reply-To: <00000000000037441f05ed0f8f9f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004e1dfa05f4a48e6b@google.com>
Subject: Re: [syzbot] [nilfs2?] INFO: task hung in nilfs_segctor_thread
From:   syzbot <syzbot+f0c4082ce5ebebdac63b@syzkaller.appspotmail.com>
To:     konishi.ryusuke@gmail.com, linux-kernel@vger.kernel.org,
        linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    f6feea56f66d Merge tag 'mm-hotfixes-stable-2023-02-13-13-5..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=165ee62b480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=42ba4da8e1e6af9f
dashboard link: https://syzkaller.appspot.com/bug?extid=f0c4082ce5ebebdac63b
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14ba7207480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15fd30d0c80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1ae0143f08d5/disk-f6feea56.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/18b8a23fa0cb/vmlinux-f6feea56.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d915f4c5c8c0/bzImage-f6feea56.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/1acd3b288433/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f0c4082ce5ebebdac63b@syzkaller.appspotmail.com

INFO: task segctord:5067 blocked for more than 143 seconds.
      Not tainted 6.2.0-rc8-syzkaller-00015-gf6feea56f66d #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:segctord        state:D stack:23456 pid:5067  ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5293 [inline]
 __schedule+0x1409/0x43f0 kernel/sched/core.c:6606
 schedule+0xc3/0x190 kernel/sched/core.c:6682
 rwsem_down_write_slowpath+0xfcf/0x14a0 kernel/locking/rwsem.c:1190
 nilfs_transaction_lock+0x25c/0x4f0 fs/nilfs2/segment.c:357
 nilfs_segctor_thread_construct fs/nilfs2/segment.c:2486 [inline]
 nilfs_segctor_thread+0x52f/0x1140 fs/nilfs2/segment.c:2570
 kthread+0x270/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>

Showing all locks held in the system:
1 lock held by rcu_tasks_kthre/12:
 #0: ffffffff8cf258d0 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x26/0xce0 kernel/rcu/tasks.h:507
1 lock held by rcu_tasks_trace/13:
 #0: ffffffff8cf260d0 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x26/0xce0 kernel/rcu/tasks.h:507
1 lock held by khungtaskd/28:
 #0: ffffffff8cf25700 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x0/0x30
2 locks held by getty/4745:
 #0: ffff88802c2eb098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:244
 #1: ffffc900015b02f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6ab/0x1db0 drivers/tty/n_tty.c:2177
3 locks held by syz-executor996/5065:
1 lock held by segctord/5067:
 #0: ffff888017ce92a0 (&nilfs->ns_segctor_sem){++++}-{3:3}, at: nilfs_transaction_lock+0x25c/0x4f0 fs/nilfs2/segment.c:357

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 28 Comm: khungtaskd Not tainted 6.2.0-rc8-syzkaller-00015-gf6feea56f66d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/21/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x4e5/0x560 lib/nmi_backtrace.c:111
 nmi_trigger_cpumask_backtrace+0x1b4/0x3f0 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:148 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:220 [inline]
 watchdog+0xf70/0xfb0 kernel/hung_task.c:377
 kthread+0x270/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 5065 Comm: syz-executor996 Not tainted 6.2.0-rc8-syzkaller-00015-gf6feea56f66d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/21/2023
RIP: 0010:__lock_release kernel/locking/lockdep.c:5372 [inline]
RIP: 0010:lock_release+0x333/0xaa0 kernel/locking/lockdep.c:5688
Code: 00 f0 ff 42 0f b6 04 3b 84 c0 0f 85 7e 05 00 00 45 89 2e 41 81 fd ff ff 0f 00 0f 87 ff 02 00 00 48 8b 44 24 40 42 0f b6 04 38 <84> c0 0f 85 34 05 00 00 89 16 4c 89 e0 48 c1 e8 03 42 80 3c 38 00
RSP: 0018:ffffc90003def1c0 EFLAGS: 00000087
RAX: 0000000000000000 RBX: 1ffff11004d808aa RCX: ffffc90003def203
RDX: 0000000000000003 RSI: ffff888026c044b0 RDI: ffff888026c04530
RBP: ffffc90003def2f0 R08: dffffc0000000000 R09: fffffbfff1ca4ece
R10: 0000000000000000 R11: dffffc0000000001 R12: ffff888026c04530
R13: 0000000000020021 R14: ffff888026c04550 R15: dffffc0000000000
FS:  0000555556f2e300(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056435c9b6680 CR3: 000000001e10a000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 folio_mark_accessed+0x51c/0xf00 mm/swap.c:515
 __nilfs_get_page_block fs/nilfs2/page.c:42 [inline]
 nilfs_grab_buffer+0x3d3/0x540 fs/nilfs2/page.c:61
 nilfs_mdt_submit_block+0xd7/0x8f0 fs/nilfs2/mdt.c:121
 nilfs_mdt_read_block+0xeb/0x430 fs/nilfs2/mdt.c:176
 nilfs_mdt_get_block+0x12d/0xbb0 fs/nilfs2/mdt.c:251
 nilfs_sufile_get_segment_usage_block fs/nilfs2/sufile.c:92 [inline]
 nilfs_sufile_truncate_range fs/nilfs2/sufile.c:679 [inline]
 nilfs_sufile_resize+0x7a3/0x12b0 fs/nilfs2/sufile.c:777
 nilfs_resize_fs+0x20c/0xed0 fs/nilfs2/super.c:422
 nilfs_ioctl_resize fs/nilfs2/ioctl.c:1033 [inline]
 nilfs_ioctl+0x137c/0x2440 fs/nilfs2/ioctl.c:1301
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0xf1/0x160 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fada4f355f9
Code: Unable to access opcode bytes at 0x7fada4f355cf.
RSP: 002b:00007ffdc80a3908 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fada4f355f9
RDX: 0000000020000040 RSI: 0000000040086e8b RDI: 0000000000000006
RBP: 0000000000000000 R08: 00007fada4fa3ec0 R09: 00007fada4fa3ec0
R10: 00007fada4fa3ec0 R11: 0000000000000246 R12: 00007ffdc80a3930
R13: 0000000000000000 R14: 431bde82d7b634db R15: 0000000000000000
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.549 msecs

