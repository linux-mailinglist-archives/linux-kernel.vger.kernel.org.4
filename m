Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4A1669CF7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 16:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjAMPyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 10:54:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjAMPwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 10:52:55 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0D66412
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 07:45:50 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id r6-20020a92cd86000000b00304b2d1c2d7so16146105ilb.11
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 07:45:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xu4PeIo+TLi12PFCasLbr+bPgbSXb44XTS6PTkWr8EI=;
        b=lQRIAdZw5jsTruxkn0T52aIIy/mCKJy5fRaKcyDuvoIuqXcgYBHNoklHuUARUVVak2
         HVzcL3ZXjSpFNMCl6JdG/gvkXA6b6PNKQZvDIjkk0fkJqtyrBOjjEIn0irDbe/YAd2I/
         TVoKkfhEJJhQZktsFAsva0LxB6JzGPwt7/CqIhzJIMCpYpndf4k/LLu5lMXijkZKPUyB
         n8AVWPFMb+0QH2jPUrIioAmBzkN0ipR6hZa0R3Bz9ImkojG8TKlhuszw1fa29avqpLBo
         REpVC5DYSvjHEJoO4ObT6svH54EY6l+l/Azk1WBXRkP5XSrWrnaZ0LQMf6+VfueLJDAF
         H5RA==
X-Gm-Message-State: AFqh2kqI2ux8HpXutx0ufbhOKoe4krVS9/VvxA6tGMzhKj983cM2EJ0q
        6761fXs8Dp++S2kNu5ZYzO4mJEpU3B5tMLlvgyiyvDMwBeuT
X-Google-Smtp-Source: AMrXdXuCFap+EJk5ZCRjr4z8qtaMXlxkYnFmRAWetWuHtAHwSvMz54hTDUOGz3PBJiobztFd8/ygmd8+23+VIO1jFS/OYu3Or+5y
MIME-Version: 1.0
X-Received: by 2002:a6b:620d:0:b0:704:7faa:6fb9 with SMTP id
 f13-20020a6b620d000000b007047faa6fb9mr558093iog.203.1673624749685; Fri, 13
 Jan 2023 07:45:49 -0800 (PST)
Date:   Fri, 13 Jan 2023 07:45:49 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b146b505f22720c9@google.com>
Subject: [syzbot] [reiserfs?] INFO: task hung in queue_log_writer
From:   syzbot <syzbot+d7c9b7185ced98364b13@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, bvanassche@acm.org, jack@suse.cz,
        jlayton@kernel.org, linux-kernel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        willy@infradead.org, yi.zhang@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    c757fc92a3f7 Merge tag 'spi-fix-v6.2-rc3' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11a3daea480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2b6ecad960fc703e
dashboard link: https://syzkaller.appspot.com/bug?extid=d7c9b7185ced98364b13
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/83ba79e6cb20/disk-c757fc92.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e980be3e55fc/vmlinux-c757fc92.xz
kernel image: https://storage.googleapis.com/syzbot-assets/325d4d480267/bzImage-c757fc92.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d7c9b7185ced98364b13@syzkaller.appspotmail.com

INFO: task kworker/u4:11:5357 blocked for more than 143 seconds.
      Not tainted 6.2.0-rc3-syzkaller-00060-gc757fc92a3f7 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u4:11   state:D stack:26224 pid:5357  ppid:2      flags:0x00004000
Workqueue: writeback wb_workfn (flush-7:1)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5244 [inline]
 __schedule+0xb8a/0x5450 kernel/sched/core.c:6555
 schedule+0xde/0x1b0 kernel/sched/core.c:6631
 queue_log_writer+0x293/0x2f0 fs/reiserfs/journal.c:2980
 do_journal_begin_r+0x988/0x10e0 fs/reiserfs/journal.c:3103
 journal_begin+0x166/0x400 fs/reiserfs/journal.c:3255
 reiserfs_write_inode+0x1f4/0x2d0 fs/reiserfs/inode.c:1777
 write_inode fs/fs-writeback.c:1451 [inline]
 __writeback_single_inode+0xcfc/0x1440 fs/fs-writeback.c:1663
 writeback_sb_inodes+0x54d/0xf90 fs/fs-writeback.c:1889
 wb_writeback+0x2c5/0xd70 fs/fs-writeback.c:2063
 wb_do_writeback fs/fs-writeback.c:2206 [inline]
 wb_workfn+0x2e0/0x12f0 fs/fs-writeback.c:2246
 process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
 worker_thread+0x669/0x1090 kernel/workqueue.c:2436
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
INFO: task syz-executor.1:5768 blocked for more than 143 seconds.
      Not tainted 6.2.0-rc3-syzkaller-00060-gc757fc92a3f7 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.1  state:D stack:24760 pid:5768  ppid:5109   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5244 [inline]
 __schedule+0xb8a/0x5450 kernel/sched/core.c:6555
 schedule+0xde/0x1b0 kernel/sched/core.c:6631
 bit_wait+0x16/0xe0 kernel/sched/wait_bit.c:199
 __wait_on_bit+0x64/0x180 kernel/sched/wait_bit.c:49
 __inode_wait_for_writeback+0x153/0x1f0 fs/fs-writeback.c:1472
 inode_wait_for_writeback+0x26/0x40 fs/fs-writeback.c:1484
 evict+0x2b7/0x6b0 fs/inode.c:661
 iput_final fs/inode.c:1747 [inline]
 iput.part.0+0x59b/0x880 fs/inode.c:1773
 iput+0x5c/0x80 fs/inode.c:1763
 dentry_unlink_inode+0x2b1/0x460 fs/dcache.c:401
 d_delete fs/dcache.c:2565 [inline]
 d_delete+0x16f/0x1c0 fs/dcache.c:2554
 xattr_unlink+0x139/0x190 fs/reiserfs/xattr.c:96
 lookup_and_delete_xattr fs/reiserfs/xattr.c:494 [inline]
 reiserfs_xattr_set_handle+0x83c/0xb00 fs/reiserfs/xattr.c:529
 reiserfs_xattr_set+0x454/0x5b0 fs/reiserfs/xattr.c:633
 trusted_set+0xa7/0xd0 fs/reiserfs/xattr_trusted.c:31
 __vfs_removexattr+0x155/0x1c0 fs/xattr.c:497
 __vfs_removexattr_locked+0x1b0/0x440 fs/xattr.c:532
 vfs_removexattr+0xcf/0x260 fs/xattr.c:554
 ovl_do_removexattr fs/overlayfs/overlayfs.h:272 [inline]
 ovl_removexattr fs/overlayfs/overlayfs.h:280 [inline]
 ovl_make_workdir fs/overlayfs/super.c:1361 [inline]
 ovl_get_workdir fs/overlayfs/super.c:1444 [inline]
 ovl_fill_super+0x20ba/0x6330 fs/overlayfs/super.c:2000
 mount_nodev+0x64/0x120 fs/super.c:1405
 legacy_get_tree+0x109/0x220 fs/fs_context.c:610
 vfs_get_tree+0x8d/0x2f0 fs/super.c:1489
 do_new_mount fs/namespace.c:3145 [inline]
 path_mount+0x132a/0x1e20 fs/namespace.c:3475
 do_mount fs/namespace.c:3488 [inline]
 __do_sys_mount fs/namespace.c:3697 [inline]
 __se_sys_mount fs/namespace.c:3674 [inline]
 __x64_sys_mount+0x283/0x300 fs/namespace.c:3674
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7ff5f6c8c0c9
RSP: 002b:00007ff5f7993168 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ff5f6dabf80 RCX: 00007ff5f6c8c0c9
RDX: 0000000020000080 RSI: 00000000200000c0 RDI: 0000000000000000
RBP: 00007ff5f6ce7ae9 R08: 0000000020000480 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd299fb68f R14: 00007ff5f7993300 R15: 0000000000022000
 </TASK>
INFO: task syz-executor.1:5787 blocked for more than 144 seconds.
      Not tainted 6.2.0-rc3-syzkaller-00060-gc757fc92a3f7 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.1  state:D stack:26120 pid:5787  ppid:5109   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5244 [inline]
 __schedule+0xb8a/0x5450 kernel/sched/core.c:6555
 schedule+0xde/0x1b0 kernel/sched/core.c:6631
 wb_wait_for_completion+0x182/0x240 fs/fs-writeback.c:192
 sync_inodes_sb+0x1aa/0x9e0 fs/fs-writeback.c:2725
 sync_filesystem.part.0+0xe6/0x1d0 fs/sync.c:64
 sync_filesystem+0x8f/0xc0 fs/sync.c:43
 reiserfs_remount+0x129/0x1540 fs/reiserfs/super.c:1445
 legacy_reconfigure+0x119/0x180 fs/fs_context.c:633
 reconfigure_super+0x40c/0xa30 fs/super.c:935
 do_remount fs/namespace.c:2807 [inline]
 path_mount+0x1830/0x1e20 fs/namespace.c:3467
 do_mount fs/namespace.c:3488 [inline]
 __do_sys_mount fs/namespace.c:3697 [inline]
 __se_sys_mount fs/namespace.c:3674 [inline]
 __x64_sys_mount+0x283/0x300 fs/namespace.c:3674
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7ff5f6c8d5fa
RSP: 002b:00007ff5f7971f88 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ff5f6c8d5fa
RDX: 00000000200000c0 RSI: 0000000020000100 RDI: 0000000000000000
RBP: 00007ff5f7972020 R08: 00007ff5f7972020 R09: 0000000001a484bc
R10: 0000000001a484bc R11: 0000000000000206 R12: 00000000200000c0
R13: 0000000020000100 R14: 00007ff5f7971fe0 R15: 00000000200007c0
 </TASK>

Showing all locks held in the system:
1 lock held by rcu_tasks_kthre/12:
 #0: ffffffff8c790f30 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x26/0xc70 kernel/rcu/tasks.h:507
1 lock held by rcu_tasks_trace/13:
 #0: ffffffff8c790c30 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x26/0xc70 kernel/rcu/tasks.h:507
1 lock held by khungtaskd/28:
 #0: ffffffff8c791a80 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x57/0x264 kernel/locking/lockdep.c:6494
5 locks held by kworker/u4:3/46:
 #0: ffff8880b983b598 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2f/0x120 kernel/sched/core.c:537
 #1: ffff8880b98287c8 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x2de/0x930 kernel/sched/psi.c:976
 #2: ffff8880b9829618 (&base->lock){-.-.}-{2:2}, at: lock_timer_base+0x5a/0x1f0 kernel/time/timer.c:999
 #3: ffffffff91dee210 (&obj_hash[i].lock){-.-.}-{2:2}, at: debug_object_activate+0x132/0x3e0 lib/debugobjects.c:665
 #4: ffff8880b98293f0 (krc.lock){..-.}-{2:2}, at: krc_this_cpu_lock kernel/rcu/tree.c:2977 [inline]
 #4: ffff8880b98293f0 (krc.lock){..-.}-{2:2}, at: add_ptr_to_bulk_krc_lock kernel/rcu/tree.c:3286 [inline]
 #4: ffff8880b98293f0 (krc.lock){..-.}-{2:2}, at: kvfree_call_rcu+0xe2/0x8f0 kernel/rcu/tree.c:3377
2 locks held by getty/4747:
 #0: ffff88802baab098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x26/0x80 drivers/tty/tty_ldisc.c:244
 #1: ffffc900015b02f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xef4/0x13e0 drivers/tty/n_tty.c:2177
2 locks held by kworker/u4:11/5357:
 #0: ffff888140858138 ((wq_completion)writeback){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888140858138 ((wq_completion)writeback){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888140858138 ((wq_completion)writeback){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff888140858138 ((wq_completion)writeback){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff888140858138 ((wq_completion)writeback){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff888140858138 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work+0x86d/0x1710 kernel/workqueue.c:2260
 #1: ffffc90005117da8 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0x8a1/0x1710 kernel/workqueue.c:2264
4 locks held by syz-executor.1/5768:
 #0: ffff88807b9320e0 (&type->s_umount_key#47/1){+.+.}-{3:3}, at: alloc_super+0x22e/0xb60 fs/super.c:228
 #1: ffff88807c650460 (sb_writers#15){.+.+}-{0:0}, at: ovl_make_workdir fs/overlayfs/super.c:1290 [inline]
 #1: ffff88807c650460 (sb_writers#15){.+.+}-{0:0}, at: ovl_get_workdir fs/overlayfs/super.c:1444 [inline]
 #1: ffff88807c650460 (sb_writers#15){.+.+}-{0:0}, at: ovl_fill_super+0x19d6/0x6330 fs/overlayfs/super.c:2000
 #2: ffff88807332e640 (&type->i_mutex_dir_key#9){++++}-{3:3}, at: inode_lock include/linux/fs.h:756 [inline]
 #2: ffff88807332e640 (&type->i_mutex_dir_key#9){++++}-{3:3}, at: vfs_removexattr+0xbb/0x260 fs/xattr.c:553
 #3: ffff88808791dfa0 (&type->i_mutex_dir_key#9/3){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:791 [inline]
 #3: ffff88808791dfa0 (&type->i_mutex_dir_key#9/3){+.+.}-{3:3}, at: lookup_and_delete_xattr fs/reiserfs/xattr.c:486 [inline]
 #3: ffff88808791dfa0 (&type->i_mutex_dir_key#9/3){+.+.}-{3:3}, at: reiserfs_xattr_set_handle+0x7ab/0xb00 fs/reiserfs/xattr.c:529
2 locks held by syz-executor.1/5787:
 #0: ffff88807c6500e0 (&type->s_umount_key#53){++++}-{3:3}, at: do_remount fs/namespace.c:2804 [inline]
 #0: ffff88807c6500e0 (&type->s_umount_key#53){++++}-{3:3}, at: path_mount+0x13e0/0x1e20 fs/namespace.c:3467
 #1: ffff88801e4b27d0 (&bdi->wb_switch_rwsem){+.+.}-{3:3}, at: bdi_down_write_wb_switch_rwsem fs/fs-writeback.c:364 [inline]
 #1: ffff88801e4b27d0 (&bdi->wb_switch_rwsem){+.+.}-{3:3}, at: sync_inodes_sb+0x190/0x9e0 fs/fs-writeback.c:2723
2 locks held by kworker/u4:14/8107:
 #0: ffff8880b983b598 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2f/0x120 kernel/sched/core.c:537
 #1: ffff8880b98287c8 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x216/0x930 kernel/sched/psi.c:964
1 lock held by syz-executor.5/8770:
 #0: ffff88807c6500e0 (&type->s_umount_key#53){++++}-{3:3}, at: iterate_supers+0xdf/0x2a0 fs/super.c:722

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 28 Comm: khungtaskd Not tainted 6.2.0-rc3-syzkaller-00060-gc757fc92a3f7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd1/0x138 lib/dump_stack.c:106
 nmi_cpu_backtrace.cold+0x24/0x18a lib/nmi_backtrace.c:111
 nmi_trigger_cpumask_backtrace+0x333/0x3c0 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:148 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:220 [inline]
 watchdog+0xc75/0xfc0 kernel/hung_task.c:377
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 8154 Comm: kworker/u4:16 Not tainted 6.2.0-rc3-syzkaller-00060-gc757fc92a3f7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Workqueue: phy4 ieee80211_iface_work
RIP: 0010:virt_to_folio include/linux/mm.h:958 [inline]
RIP: 0010:virt_to_slab mm/slab.h:185 [inline]
RIP: 0010:kmem_cache_free+0x6b/0x5c0 mm/slub.c:3809
Code: 8b 05 45 9b 34 7e 3b 05 f3 c6 a3 0c 0f 83 bf 02 00 00 89 c0 48 0f a3 05 f3 c4 a3 0c 0f 82 45 02 00 00 48 89 df 4c 8b 6c 24 60 <e8> 60 66 6a ff 48 c1 e8 0c 49 89 c4 48 b8 00 00 00 00 00 ea ff ff
RSP: 0018:ffffc9001477fbf0 EFLAGS: 00000286
RAX: 0000000000000001 RBX: ffff88807dd51780 RCX: 0000000000000001
RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff88807dd51780
RBP: ffff88801271e280 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000094001 R12: 0000000000000000
R13: ffffffff87c1e69f R14: ffffffff8945abc7 R15: ffff888025de5878
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c00f8e7000 CR3: 0000000020d2d000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 kfree_skbmem+0xef/0x1b0 net/core/skbuff.c:874
 __kfree_skb net/core/skbuff.c:931 [inline]
 kfree_skb_reason+0x1b8/0x4f0 net/core/skbuff.c:956
 kfree_skb include/linux/skbuff.h:1218 [inline]
 ieee80211_iface_work+0x357/0xd70 net/mac80211/iface.c:1637
 process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
 worker_thread+0x669/0x1090 kernel/workqueue.c:2436
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
