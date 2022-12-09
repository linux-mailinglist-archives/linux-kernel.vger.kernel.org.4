Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E982D647FDA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 10:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiLIJIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 04:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiLIJIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 04:08:40 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9BC54767
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 01:08:39 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id z200-20020a6bc9d1000000b006e003aecf04so1787683iof.16
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 01:08:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ijsm07zxCBrVTgqLExNAgXLfYVJ4tHyHwAv61EC2Joc=;
        b=jyr0QXjMJdIutKZDYyvovyRiNMz3gWJxFQyOzmQACHNuzqeP36dIgUjm25ps46mcju
         EwdWgAffAuXUYPwHRfu1CzsTpoFZMLQe9c9z7W9XvK9ZaFjBYzcyUSCunkh31C8EE4Op
         uhr89NEXdSrUO7oQQSqKvbPTEIAC/4juEzTvLPdRLsr3IFG09Xo8TSWQpCJci0p27fND
         j8Z/SKGHp5l8gaGkuy1dQXJEGnD/nmIMidTcJQVp4TGHCF0ZT/OCB9xUzWmQ+IO6zJwf
         MFiJbuKGjXG3zPB8zgTQKLRO7BPIRqeiM5bCOX59/8e6X3mLuqsWvIogHkMMOTBZd/aV
         6Gxg==
X-Gm-Message-State: ANoB5pnHN5++wj6Cwdpb2Ibqy3L4t0w3n22aCVTtN23AapVMePIFx+AS
        xQ05v9EF2STZY17hjvNaOJIqPmZZ9ScLYihZr1PeBMKQNsVH
X-Google-Smtp-Source: AA0mqf60VSWSPW5mFCxe8omoF9Anxi4OSnGlKYiePOP8wWu0US2fLoCsDtd1tHbg8cx/3tNcLpwm9Aui48vNM0qBKSbwWho2H0OY
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2206:b0:302:d141:bf84 with SMTP id
 j6-20020a056e02220600b00302d141bf84mr35387770ilf.287.1670576918582; Fri, 09
 Dec 2022 01:08:38 -0800 (PST)
Date:   Fri, 09 Dec 2022 01:08:38 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cd5fe305ef617fe2@google.com>
Subject: [syzbot] possible deadlock in __f2fs_ioctl
From:   syzbot <syzbot+4793f6096d174c90b4f7@syzkaller.appspotmail.com>
To:     chao@kernel.org, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    a5541c0811a0 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=13a6e7cb880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cbd4e584773e9397
dashboard link: https://syzkaller.appspot.com/bug?extid=4793f6096d174c90b4f7
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4b7702208fb9/disk-a5541c08.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9ec0153ec051/vmlinux-a5541c08.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6f8725ad290a/Image-a5541c08.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4793f6096d174c90b4f7@syzkaller.appspotmail.com

F2FS-fs (loop2): invalid crc value
F2FS-fs (loop2): Found nat_bits in checkpoint
F2FS-fs (loop2): Mounted with checkpoint version = 48b305e4
======================================================
WARNING: possible circular locking dependency detected
6.1.0-rc8-syzkaller-33330-ga5541c0811a0 #0 Not tainted
------------------------------------------------------
syz-executor.2/32123 is trying to acquire lock:
ffff0000c0e1a608 (&mm->mmap_lock){++++}-{3:3}, at: __might_fault+0x54/0xb4 mm/memory.c:5644

but task is already holding lock:
ffff0001317c6088 (&sbi->sb_lock){++++}-{3:3}, at: f2fs_down_write fs/f2fs/f2fs.h:2205 [inline]
ffff0001317c6088 (&sbi->sb_lock){++++}-{3:3}, at: f2fs_ioc_get_encryption_pwsalt fs/f2fs/file.c:2334 [inline]
ffff0001317c6088 (&sbi->sb_lock){++++}-{3:3}, at: __f2fs_ioctl+0x1370/0x3318 fs/f2fs/file.c:4151

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&sbi->sb_lock){++++}-{3:3}:
       down_write+0x5c/0x88 kernel/locking/rwsem.c:1562
       f2fs_down_write fs/f2fs/f2fs.h:2205 [inline]
       f2fs_handle_error+0x9c/0x17c fs/f2fs/super.c:3898
       f2fs_check_nid_range fs/f2fs/node.c:39 [inline]
       add_free_nid+0x4d8/0x50c fs/f2fs/node.c:2282
       scan_nat_page fs/f2fs/node.c:2384 [inline]
       __f2fs_build_free_nids fs/f2fs/node.c:2490 [inline]
       f2fs_build_free_nids+0x680/0x8f4 fs/f2fs/node.c:2528
       f2fs_build_node_manager+0x624/0x64c fs/f2fs/node.c:3313
       f2fs_fill_super+0x1470/0x1e90 fs/f2fs/super.c:4306
       mount_bdev+0x1b8/0x210 fs/super.c:1401
       f2fs_mount+0x44/0x58 fs/f2fs/super.c:4580
       legacy_get_tree+0x30/0x74 fs/fs_context.c:610
       vfs_get_tree+0x40/0x140 fs/super.c:1531
       do_new_mount+0x1dc/0x4e4 fs/namespace.c:3040
       path_mount+0x358/0x890 fs/namespace.c:3370
       do_mount fs/namespace.c:3383 [inline]
       __do_sys_mount fs/namespace.c:3591 [inline]
       __se_sys_mount fs/namespace.c:3568 [inline]
       __arm64_sys_mount+0x2c4/0x3c4 fs/namespace.c:3568
       __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
       invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
       el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
       do_el0_svc+0x48/0x140 arch/arm64/kernel/syscall.c:197
       el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
       el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584

-> #2 (&nm_i->nat_tree_lock){++++}-{3:3}:
       down_read+0x5c/0x78 kernel/locking/rwsem.c:1509
       f2fs_down_read fs/f2fs/f2fs.h:2180 [inline]
       f2fs_get_node_info+0x74/0x458 fs/f2fs/node.c:560
       read_node_page+0x100/0x7a4 fs/f2fs/node.c:1358
       __get_node_page+0x1b4/0xa3c fs/f2fs/node.c:1419
       f2fs_get_node_page fs/f2fs/node.c:1468 [inline]
       f2fs_get_dnode_of_data+0xc8/0xad0 fs/f2fs/node.c:776
       f2fs_remove_inode_page+0x50/0x288 fs/f2fs/node.c:1225
       f2fs_evict_inode+0x348/0x978 fs/f2fs/inode.c:813
       evict+0xec/0x334 fs/inode.c:664
       iput_final fs/inode.c:1747 [inline]
       iput+0x2c4/0x324 fs/inode.c:1773
       f2fs_new_inode+0x284/0x7bc fs/f2fs/namei.c:152
       f2fs_create+0xa4/0x4b0 fs/f2fs/namei.c:355
       lookup_open fs/namei.c:3413 [inline]
       open_last_lookups fs/namei.c:3481 [inline]
       path_openat+0x804/0x11c4 fs/namei.c:3711
       do_filp_open+0xdc/0x1b8 fs/namei.c:3741
       do_sys_openat2+0xb8/0x22c fs/open.c:1310
       do_sys_open fs/open.c:1326 [inline]
       __do_sys_openat fs/open.c:1342 [inline]
       __se_sys_openat fs/open.c:1337 [inline]
       __arm64_sys_openat+0xb0/0xe0 fs/open.c:1337
       __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
       invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
       el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
       do_el0_svc+0x48/0x140 arch/arm64/kernel/syscall.c:197
       el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
       el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584

-> #1 (&sbi->cp_rwsem){++++}-{3:3}:
       down_read+0x5c/0x78 kernel/locking/rwsem.c:1509
       f2fs_down_read fs/f2fs/f2fs.h:2180 [inline]
       f2fs_lock_op fs/f2fs/f2fs.h:2223 [inline]
       f2fs_convert_inline_inode+0x1e8/0x2e4 fs/f2fs/inline.c:219
       f2fs_vm_page_mkwrite+0xb4/0x9a4 fs/f2fs/file.c:79
       do_page_mkwrite+0x74/0x288 mm/memory.c:2977
       wp_page_shared+0x8c/0x364 mm/memory.c:3323
       do_wp_page+0x794/0xd10 mm/memory.c:3473
       handle_pte_fault mm/memory.c:4972 [inline]
       __handle_mm_fault mm/memory.c:5096 [inline]
       handle_mm_fault+0x880/0xa48 mm/memory.c:5217
       __do_page_fault arch/arm64/mm/fault.c:508 [inline]
       do_page_fault+0x428/0x79c arch/arm64/mm/fault.c:608
       do_mem_abort+0x54/0x130 arch/arm64/mm/fault.c:827
       el0_da+0x70/0x16c arch/arm64/kernel/entry-common.c:515
       el0t_64_sync_handler+0xcc/0xf0 arch/arm64/kernel/entry-common.c:658
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584

-> #0 (&mm->mmap_lock){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3097 [inline]
       check_prevs_add kernel/locking/lockdep.c:3216 [inline]
       validate_chain kernel/locking/lockdep.c:3831 [inline]
       __lock_acquire+0x1530/0x3084 kernel/locking/lockdep.c:5055
       lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5668
       __might_fault+0x7c/0xb4 mm/memory.c:5645
       _copy_to_user include/linux/uaccess.h:143 [inline]
       copy_to_user include/linux/uaccess.h:169 [inline]
       f2fs_ioc_get_encryption_pwsalt fs/f2fs/file.c:2349 [inline]
       __f2fs_ioctl+0x3204/0x3318 fs/f2fs/file.c:4151
       f2fs_ioctl+0x74/0xbc fs/f2fs/file.c:4224
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:870 [inline]
       __se_sys_ioctl fs/ioctl.c:856 [inline]
       __arm64_sys_ioctl+0xd0/0x140 fs/ioctl.c:856
       __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
       invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
       el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
       do_el0_svc+0x48/0x140 arch/arm64/kernel/syscall.c:197
       el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
       el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584

other info that might help us debug this:

Chain exists of:
  &mm->mmap_lock --> &nm_i->nat_tree_lock --> &sbi->sb_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sbi->sb_lock);
                               lock(&nm_i->nat_tree_lock);
                               lock(&sbi->sb_lock);
  lock(&mm->mmap_lock);

 *** DEADLOCK ***

2 locks held by syz-executor.2/32123:
 #0: ffff000112968460 (sb_writers#13){.+.+}-{0:0}, at: mnt_want_write_file+0x28/0xd8 fs/namespace.c:437
 #1: ffff0001317c6088 (&sbi->sb_lock){++++}-{3:3}, at: f2fs_down_write fs/f2fs/f2fs.h:2205 [inline]
 #1: ffff0001317c6088 (&sbi->sb_lock){++++}-{3:3}, at: f2fs_ioc_get_encryption_pwsalt fs/f2fs/file.c:2334 [inline]
 #1: ffff0001317c6088 (&sbi->sb_lock){++++}-{3:3}, at: __f2fs_ioctl+0x1370/0x3318 fs/f2fs/file.c:4151

stack backtrace:
CPU: 1 PID: 32123 Comm: syz-executor.2 Not tainted 6.1.0-rc8-syzkaller-33330-ga5541c0811a0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
Call trace:
 dump_backtrace+0x1c4/0x1f0 arch/arm64/kernel/stacktrace.c:156
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:163
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x104/0x16c lib/dump_stack.c:106
 dump_stack+0x1c/0x58 lib/dump_stack.c:113
 print_circular_bug+0x2c4/0x2c8 kernel/locking/lockdep.c:2055
 check_noncircular+0x14c/0x154 kernel/locking/lockdep.c:2177
 check_prev_add kernel/locking/lockdep.c:3097 [inline]
 check_prevs_add kernel/locking/lockdep.c:3216 [inline]
 validate_chain kernel/locking/lockdep.c:3831 [inline]
 __lock_acquire+0x1530/0x3084 kernel/locking/lockdep.c:5055
 lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5668
 __might_fault+0x7c/0xb4 mm/memory.c:5645
 _copy_to_user include/linux/uaccess.h:143 [inline]
 copy_to_user include/linux/uaccess.h:169 [inline]
 f2fs_ioc_get_encryption_pwsalt fs/f2fs/file.c:2349 [inline]
 __f2fs_ioctl+0x3204/0x3318 fs/f2fs/file.c:4151
 f2fs_ioctl+0x74/0xbc fs/f2fs/file.c:4224
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __arm64_sys_ioctl+0xd0/0x140 fs/ioctl.c:856
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x140 arch/arm64/kernel/syscall.c:197
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
