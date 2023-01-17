Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D7E66D4D0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 04:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235806AbjAQDAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 22:00:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235641AbjAQDAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 22:00:18 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462FC2F79E
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 18:57:42 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id 9-20020a056e0220c900b0030f1b0dfa9dso686589ilq.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 18:57:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HqpxAh/EoBvs9t1kZ3h25qJbgIvOUq78kZI3AqDinps=;
        b=tN/yRE1YyUYHBn5DAOzNkfe3aTcELwDcV2AA4w7d5NlZxTf5UnQGDtOjxFWXiq6PuX
         Sf1KetsTEmtpY/Uo/RqTt7CfZpBQnn52hNyqFuEJ4PR2XqXpUV+HuTarWXcuIUN2qe6V
         +WTCq8EgKKxBW+mdAXERl3GcmImChAxTI6keb3McRiDZ+fjN+7Aag0BXwgq3cLLxTeVu
         1MQXuZvvqK//Gckc0xIXEpHvs/k1WaIrDjWxB7l0I9ms2Wwg3YPzLDlvjc54zP4DzI/+
         E8ONGDbdKKn1W50S92DaJrlc5Kc/T37MmEULvKk08ECnIPOr1giH5NuoBgFW2DLTBWEz
         iDvA==
X-Gm-Message-State: AFqh2koONx0DVZrCSHhUL/dTN6G4iXfeYrpAm05dSgTMK1EK3/Wi66W8
        T0of8u6sR9/nTmE4dEEd3ZJ15zh1r84I8ma9r9nL480rePVl
X-Google-Smtp-Source: AMrXdXsIYhyAHHWYiWqoHjuIP0IP7v288ElekurC6b7CdOi0sluKEC+XMfk/M2M45jeq6Rl6jLb+o33GOInnxoBxlz+XXNUVjbUv
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:ece:b0:30c:1693:594b with SMTP id
 i14-20020a056e020ece00b0030c1693594bmr134880ilk.210.1673924261614; Mon, 16
 Jan 2023 18:57:41 -0800 (PST)
Date:   Mon, 16 Jan 2023 18:57:41 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fe9c9d05f26cdc3c@google.com>
Subject: [syzbot] [f2fs?] possible deadlock in __f2fs_ioctl (2)
From:   syzbot <syzbot+0d79d79c510d77a7c661@syzkaller.appspotmail.com>
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

HEAD commit:    5dc4c995db9e Linux 6.2-rc4
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11cc0da1480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2d1e01fb80d3df97
dashboard link: https://syzkaller.appspot.com/bug?extid=0d79d79c510d77a7c661
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e52acf94631e/disk-5dc4c995.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8ead5c940574/vmlinux-5dc4c995.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f6b43b71bf31/bzImage-5dc4c995.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0d79d79c510d77a7c661@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.2.0-rc4-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor.4/7644 is trying to acquire lock:
ffff8880193935d8 (&mm->mmap_lock){++++}-{3:3}, at: __might_fault+0x8f/0x110 mm/memory.c:5646

but task is already holding lock:
ffff88802babc088 (&sbi->sb_lock){++++}-{3:3}, at: f2fs_down_write fs/f2fs/f2fs.h:2213 [inline]
ffff88802babc088 (&sbi->sb_lock){++++}-{3:3}, at: f2fs_ioc_get_encryption_pwsalt fs/f2fs/file.c:2350 [inline]
ffff88802babc088 (&sbi->sb_lock){++++}-{3:3}, at: __f2fs_ioctl+0x3572/0xb540 fs/f2fs/file.c:4169

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&sbi->sb_lock){++++}-{3:3}:
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
       down_write+0x9c/0x270 kernel/locking/rwsem.c:1562
       f2fs_down_write fs/f2fs/f2fs.h:2213 [inline]
       f2fs_handle_error+0xe0/0x230 fs/f2fs/super.c:3926
       scan_nat_page fs/f2fs/node.c:2387 [inline]
       __f2fs_build_free_nids fs/f2fs/node.c:2493 [inline]
       f2fs_build_free_nids+0xb8c/0x1190 fs/f2fs/node.c:2531
       f2fs_fill_super+0x4a5f/0x6ee0 fs/f2fs/super.c:4334
       mount_bdev+0x26c/0x3a0 fs/super.c:1359
       legacy_get_tree+0xea/0x180 fs/fs_context.c:610
       vfs_get_tree+0x88/0x270 fs/super.c:1489
       do_new_mount+0x289/0xad0 fs/namespace.c:3145
       do_mount fs/namespace.c:3488 [inline]
       __do_sys_mount fs/namespace.c:3697 [inline]
       __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3674
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #2 (&nm_i->nat_tree_lock){++++}-{3:3}:
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
       down_read+0x39/0x50 kernel/locking/rwsem.c:1509
       f2fs_down_read fs/f2fs/f2fs.h:2188 [inline]
       f2fs_get_node_info+0x100/0x1720 fs/f2fs/node.c:564
       f2fs_new_node_page+0x402/0xea0 fs/f2fs/node.c:1295
       f2fs_get_dnode_of_data+0x5b0/0x1da0 fs/f2fs/node.c:810
       f2fs_reserve_block+0x50/0x240 fs/f2fs/data.c:1199
       f2fs_get_new_data_page+0x180/0x7b0 fs/f2fs/data.c:1387
       f2fs_add_regular_entry+0x687/0xea0 fs/f2fs/dir.c:754
       f2fs_add_dentry fs/f2fs/dir.c:816 [inline]
       f2fs_do_add_link+0x2a7/0x470 fs/f2fs/dir.c:855
       f2fs_add_link fs/f2fs/f2fs.h:3564 [inline]
       f2fs_create+0x324/0x530 fs/f2fs/namei.c:363
       lookup_open fs/namei.c:3413 [inline]
       open_last_lookups fs/namei.c:3481 [inline]
       path_openat+0x12ac/0x2dd0 fs/namei.c:3711
       do_filp_open+0x264/0x4f0 fs/namei.c:3741
       do_sys_openat2+0x124/0x4e0 fs/open.c:1310
       do_sys_open fs/open.c:1326 [inline]
       __do_sys_creat fs/open.c:1402 [inline]
       __se_sys_creat fs/open.c:1396 [inline]
       __x64_sys_creat+0x11f/0x160 fs/open.c:1396
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #1 (&sbi->cp_rwsem){++++}-{3:3}:
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
       down_read+0x39/0x50 kernel/locking/rwsem.c:1509
       f2fs_down_read fs/f2fs/f2fs.h:2188 [inline]
       f2fs_lock_op fs/f2fs/f2fs.h:2231 [inline]
       f2fs_convert_inline_inode+0x55f/0x820 fs/f2fs/inline.c:219
       f2fs_vm_page_mkwrite+0x2d8/0x1350 fs/f2fs/file.c:79
       do_page_mkwrite+0x19e/0x5e0 mm/memory.c:2947
       wp_page_shared+0x15e/0x380 mm/memory.c:3295
       handle_pte_fault mm/memory.c:4949 [inline]
       __handle_mm_fault mm/memory.c:5073 [inline]
       handle_mm_fault+0x1b79/0x26b0 mm/memory.c:5219
       do_user_addr_fault+0x69b/0xcb0 arch/x86/mm/fault.c:1428
       handle_page_fault arch/x86/mm/fault.c:1519 [inline]
       exc_page_fault+0x7a/0x110 arch/x86/mm/fault.c:1575
       asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570

-> #0 (&mm->mmap_lock){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3097 [inline]
       check_prevs_add kernel/locking/lockdep.c:3216 [inline]
       validate_chain+0x1898/0x6ae0 kernel/locking/lockdep.c:3831
       __lock_acquire+0x1292/0x1f60 kernel/locking/lockdep.c:5055
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
       __might_fault+0xb2/0x110 mm/memory.c:5647
       _copy_to_user+0x26/0x130 lib/usercopy.c:29
       copy_to_user include/linux/uaccess.h:169 [inline]
       f2fs_ioc_get_encryption_pwsalt fs/f2fs/file.c:2365 [inline]
       __f2fs_ioctl+0xaf72/0xb540 fs/f2fs/file.c:4169
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:870 [inline]
       __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:856
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

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

2 locks held by syz-executor.4/7644:
 #0: ffff888029ce0460 (sb_writers#30){.+.+}-{0:0}, at: mnt_want_write_file+0x5a/0x1f0 fs/namespace.c:552
 #1: ffff88802babc088 (&sbi->sb_lock){++++}-{3:3}, at: f2fs_down_write fs/f2fs/f2fs.h:2213 [inline]
 #1: ffff88802babc088 (&sbi->sb_lock){++++}-{3:3}, at: f2fs_ioc_get_encryption_pwsalt fs/f2fs/file.c:2350 [inline]
 #1: ffff88802babc088 (&sbi->sb_lock){++++}-{3:3}, at: __f2fs_ioctl+0x3572/0xb540 fs/f2fs/file.c:4169

stack backtrace:
CPU: 1 PID: 7644 Comm: syz-executor.4 Not tainted 6.2.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x290 lib/dump_stack.c:106
 check_noncircular+0x2cc/0x390 kernel/locking/lockdep.c:2177
 check_prev_add kernel/locking/lockdep.c:3097 [inline]
 check_prevs_add kernel/locking/lockdep.c:3216 [inline]
 validate_chain+0x1898/0x6ae0 kernel/locking/lockdep.c:3831
 __lock_acquire+0x1292/0x1f60 kernel/locking/lockdep.c:5055
 lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
 __might_fault+0xb2/0x110 mm/memory.c:5647
 _copy_to_user+0x26/0x130 lib/usercopy.c:29
 copy_to_user include/linux/uaccess.h:169 [inline]
 f2fs_ioc_get_encryption_pwsalt fs/f2fs/file.c:2365 [inline]
 __f2fs_ioctl+0xaf72/0xb540 fs/f2fs/file.c:4169
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f84dbc8c0c9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f84dc990168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f84dbdac050 RCX: 00007f84dbc8c0c9
RDX: 0000000020000680 RSI: 0000000040106614 RDI: 0000000000000006
RBP: 00007f84dbce7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fffc413f05f R14: 00007f84dc990300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
