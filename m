Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56EDE5F645A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 12:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbiJFK3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 06:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiJFK3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 06:29:46 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8656355
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 03:29:43 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id j29-20020a056e02219d00b002f9b13c40c5so1205701ila.21
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 03:29:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PizYAyBxuciDMalCP24hEoaXNIN23lHYOqUuXga5O5M=;
        b=JKaNbY/Yk/5EHpEGfubVh0kjcBIprtaGX1VJ4lZZj1KjokRdNPkt10mgqPnaFMIg5w
         WeVam6/WXJpMej1qlQDX2nMt+7esQ3CYcjygMZswpOtXLXLUv6dS8vEv3d+GjXGGrPjL
         dA+pkn4gP+NKhHPFJ9k4msBpIsoRd3XT4Due9bdA/FDsj3S6ZZarJuaQeB+a/lcnpxSR
         p16KFd1Gxt+CjQxHa+dXNhCXg7ufnkEWNiJZ2SLDtBJG8jO/TTT2HmW9SI4fVn8NOC8r
         6Te9EY59Tk9qeazODd8hD3JhTRkjAc0JLt5qcVyLqoXDxIg3WoprXfdxsO8oWcOYTl5l
         5FdA==
X-Gm-Message-State: ACrzQf3JBmblrLyTIb7EjDiI+dkfcVqcxjzulOKq3Cg/qisjQrCoyHe6
        /ET+UllhKZ7Mk2/3WqgZWSuenaTv/N7w94uWk6eazy1Ib69p
X-Google-Smtp-Source: AMsMyM4O9ePbmESf88gX28Bab1ptDVAeW0CcqiUAo8z5KP+AHoUCS0+pt0AVN/dGgBOP3YVZQHXwFOODnrsXKBYLMd16CFfmfvUf
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17c5:b0:2f8:1183:340e with SMTP id
 z5-20020a056e0217c500b002f81183340emr1889577ilu.192.1665052182857; Thu, 06
 Oct 2022 03:29:42 -0700 (PDT)
Date:   Thu, 06 Oct 2022 03:29:42 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e450e805ea5b2b39@google.com>
Subject: [syzbot] INFO: task hung in path_openat (7)
From:   syzbot <syzbot+950a0cdaa2fdd14f5bdc@syzkaller.appspotmail.com>
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

HEAD commit:    2bca25eaeba6 Merge tag 'spi-v6.1' of git://git.kernel.org/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10ff71a2880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9df203be43a870b5
dashboard link: https://syzkaller.appspot.com/bug?extid=950a0cdaa2fdd14f5bdc
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9885e6765755/disk-2bca25ea.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6e78c91286aa/vmlinux-2bca25ea.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+950a0cdaa2fdd14f5bdc@syzkaller.appspotmail.com

INFO: task syz-executor.0:4146 blocked for more than 143 seconds.
      Not tainted 6.0.0-syzkaller-03015-g2bca25eaeba6 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:24016 pid: 4146 ppid:  3642 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5183 [inline]
 __schedule+0x91f/0xdf0 kernel/sched/core.c:6495
 schedule+0xcb/0x190 kernel/sched/core.c:6571
 rwsem_down_write_slowpath+0xf1c/0x1350 kernel/locking/rwsem.c:1182
 __down_write_common kernel/locking/rwsem.c:1297 [inline]
 __down_write kernel/locking/rwsem.c:1306 [inline]
 down_write+0x163/0x170 kernel/locking/rwsem.c:1553
 inode_lock include/linux/fs.h:756 [inline]
 open_last_lookups fs/namei.c:3478 [inline]
 path_openat+0x7b9/0x2df0 fs/namei.c:3688
 do_filp_open+0x264/0x4f0 fs/namei.c:3718
 do_sys_openat2+0x124/0x4e0 fs/open.c:1313
 do_sys_open fs/open.c:1329 [inline]
 __do_sys_creat fs/open.c:1405 [inline]
 __se_sys_creat fs/open.c:1399 [inline]
 __x64_sys_creat+0x11f/0x160 fs/open.c:1399
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f437d08a5a9
RSP: 002b:00007f437bffe168 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 00007f437d1ac050 RCX: 00007f437d08a5a9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000080
RBP: 00007f437d0e5580 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff063c0d0f R14: 00007f437bffe300 R15: 0000000000022000
 </TASK>
INFO: task segctord:4132 blocked for more than 143 seconds.
      Not tainted 6.0.0-syzkaller-03015-g2bca25eaeba6 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:segctord        state:D stack:24832 pid: 4132 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5183 [inline]
 __schedule+0x91f/0xdf0 kernel/sched/core.c:6495
 schedule+0xcb/0x190 kernel/sched/core.c:6571
 rwsem_down_write_slowpath+0xf1c/0x1350 kernel/locking/rwsem.c:1182
 __down_write_common kernel/locking/rwsem.c:1297 [inline]
 __down_write kernel/locking/rwsem.c:1306 [inline]
 down_write+0x163/0x170 kernel/locking/rwsem.c:1553
 nilfs_transaction_lock+0x246/0x4b0 fs/nilfs2/segment.c:357
 nilfs_segctor_thread_construct fs/nilfs2/segment.c:2482 [inline]
 nilfs_segctor_thread+0x52a/0x1180 fs/nilfs2/segment.c:2566
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>

Showing all locks held in the system:
1 lock held by rcu_tasks_kthre/13:
 #0: ffffffff8cb21db0 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x30/0xd00 kernel/rcu/tasks.h:507
1 lock held by rcu_tasks_trace/14:
 #0: ffffffff8cb225b0 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x30/0xd00 kernel/rcu/tasks.h:507
1 lock held by khungtaskd/29:
 #0: ffffffff8cb21be0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x0/0x30
2 locks held by kworker/u4:4/93:
2 locks held by getty/3285:
 #0: ffff88814ad5c098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x21/0x70 drivers/tty/tty_ldisc.c:244
 #1: ffffc900031262f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x53b/0x1650 drivers/tty/n_tty.c:2177
1 lock held by syz-fuzzer/3631:
6 locks held by syz-executor.0/4125:
2 locks held by syz-executor.0/4146:
 #0: ffff8880302f4460 (sb_writers#14){.+.+}-{0:0}, at: mnt_want_write+0x3b/0x80 fs/namespace.c:393
 #1: ffff8880713f95e0 (&type->i_mutex_dir_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:756 [inline]
 #1: ffff8880713f95e0 (&type->i_mutex_dir_key#8){++++}-{3:3}, at: open_last_lookups fs/namei.c:3478 [inline]
 #1: ffff8880713f95e0 (&type->i_mutex_dir_key#8){++++}-{3:3}, at: path_openat+0x7b9/0x2df0 fs/namei.c:3688
1 lock held by segctord/4132:
 #0: ffff88802e7da2a0 (&nilfs->ns_segctor_sem){++++}-{3:3}, at: nilfs_transaction_lock+0x246/0x4b0 fs/nilfs2/segment.c:357
2 locks held by kworker/u4:6/4564:
 #0: ffff888145a55138 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work+0x7f2/0xdb0
 #1: ffffc9000cacfd00 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0x831/0xdb0 kernel/workqueue.c:2264
2 locks held by syz-executor.0/4936:
 #0: ffff8880302f40e0 (&type->s_umount_key#78){++++}-{3:3}, at: iterate_supers+0xb0/0x1f0 fs/super.c:721
 #1: ffff8881475b07d0 (&bdi->wb_switch_rwsem){+.+.}-{3:3}, at: bdi_down_write_wb_switch_rwsem fs/fs-writeback.c:362 [inline]
 #1: ffff8881475b07d0 (&bdi->wb_switch_rwsem){+.+.}-{3:3}, at: sync_inodes_sb+0x264/0xaa0 fs/fs-writeback.c:2691
2 locks held by syz-executor.0/4939:
 #0: ffff8880302f40e0 (&type->s_umount_key#78){++++}-{3:3}, at: iterate_supers+0xb0/0x1f0 fs/super.c:721
 #1: ffff8881475b07d0 (&bdi->wb_switch_rwsem){+.+.}-{3:3}, at: bdi_down_write_wb_switch_rwsem fs/fs-writeback.c:362 [inline]
 #1: ffff8881475b07d0 (&bdi->wb_switch_rwsem){+.+.}-{3:3}, at: sync_inodes_sb+0x264/0xaa0 fs/fs-writeback.c:2691
2 locks held by syz-executor.0/5095:
 #0: ffff8880302f40e0 (&type->s_umount_key#78){++++}-{3:3}, at: iterate_supers+0xb0/0x1f0 fs/super.c:721
 #1: ffff8881475b07d0 (&bdi->wb_switch_rwsem){+.+.}-{3:3}, at: bdi_down_write_wb_switch_rwsem fs/fs-writeback.c:362 [inline]
 #1: ffff8881475b07d0 (&bdi->wb_switch_rwsem){+.+.}-{3:3}, at: sync_inodes_sb+0x264/0xaa0 fs/fs-writeback.c:2691
2 locks held by syz-executor.0/5096:
 #0: ffff8880302f40e0 (&type->s_umount_key#78){++++}-{3:3}, at: iterate_supers+0xb0/0x1f0 fs/super.c:721
 #1: ffff8881475b07d0 (&bdi->wb_switch_rwsem){+.+.}-{3:3}, at: bdi_down_write_wb_switch_rwsem fs/fs-writeback.c:362 [inline]
 #1: ffff8881475b07d0 (&bdi->wb_switch_rwsem){+.+.}-{3:3}, at: sync_inodes_sb+0x264/0xaa0 fs/fs-writeback.c:2691

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 29 Comm: khungtaskd Not tainted 6.0.0-syzkaller-03015-g2bca25eaeba6 #0
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
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 93 Comm: kworker/u4:4 Not tainted 6.0.0-syzkaller-03015-g2bca25eaeba6 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
Workqueue: bat_events batadv_nc_worker
RIP: 0010:__lock_is_held kernel/locking/lockdep.c:5407 [inline]
RIP: 0010:lock_is_held_type+0xa1/0x180 kernel/locking/lockdep.c:5709
Code: 83 bd 70 0a 00 00 00 7e 4b 4c 89 ed 48 81 c5 78 0a 00 00 31 db 0f 1f 40 00 48 83 fb 31 73 24 48 89 ef 4c 89 fe e8 ff 01 00 00 <85> c0 75 2a 48 ff c3 49 63 85 70 0a 00 00 48 83 c5 28 48 39 c3 7c
RSP: 0018:ffffc900015f7998 EFLAGS: 00000046
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000080000001
RDX: 0000000000000000 RSI: ffffffff8cb21b60 RDI: ffff888019238aa0
RBP: ffff888019238aa0 R08: dffffc0000000000 R09: fffffbfff1c188fe
R10: fffffbfff1c188fe R11: 1ffffffff1c188fd R12: 0000000000000246
R13: ffff888019238000 R14: 00000000ffffffff R15: ffffffff8cb21b60
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c00f1c8000 CR3: 0000000020bff000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lock_is_held include/linux/lockdep.h:283 [inline]
 rcu_read_lock_sched_held+0x87/0x110 kernel/rcu/update.c:125
 trace_lock_release+0x7b/0x1a0 include/trace/events/lock.h:69
 lock_release+0x81/0x820 kernel/locking/lockdep.c:5677
 rcu_read_unlock include/linux/rcupdate.h:771 [inline]
 batadv_nc_purge_orig_hash net/batman-adv/network-coding.c:412 [inline]
 batadv_nc_worker+0x251/0x5b0 net/batman-adv/network-coding.c:719
 process_one_work+0x877/0xdb0 kernel/workqueue.c:2289
 worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
