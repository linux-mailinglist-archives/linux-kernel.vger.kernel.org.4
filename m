Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0168064F673
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 01:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiLQAqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 19:46:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiLQAqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 19:46:42 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94ED92656F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 16:46:40 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id s4-20020a056e02216400b00304cd64ce20so2630913ilv.6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 16:46:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zbhz5hYdc5507PTzEvKg+x5ZfnFp0eVbrdWTDciABXU=;
        b=s+lzZhkGNL1itoJanf2J3qOFV9G2E4VHw+HveeY1vuq3SPLpjfFTnGsp1EjXdJ/KbA
         1WsvCPtWyqVtzTBvARKO9rtM0gR5Zj3LOFIbTj8UDuz1KoYx7k+Rxoe8GmMr+ipX4XIL
         DUozvfIG8EVpbe8vBX6sPyvLTGl2yAy67/WG2bxArgqhwIJ0QbTsbTIWx88GRLyrFpMy
         PTv0CaUMFRQRn9Ze9t7dNdVF6EyZ2Lh3BzdqtZ8+BKphX2im/C9Tjkw9fdFawYS0o1Vi
         UP3HYXOUeFCwOHqhYD0Ttw1y2M3xcXFGWwJdVQMQ65ALE6JteZwNrSreuzDHYCWC7Q7U
         rEag==
X-Gm-Message-State: AFqh2ko3QF35F8SW92XUNVHwMVjNJ/Jkoz1u3y1geVVQjiirUF/0ZLn9
        hKj8WMpio6EB9wgBtiDvcXiHncR7qdrMlDQgcweSbqdEZAUF
X-Google-Smtp-Source: AMrXdXsJB8/byPFCMJ8QVcntvw73I2qlU21ExYOTd6lfA/p8HzHhQHq8TvWkqvJH9uXZMX24FLF0QgXDPID5ZXcw/REsri92Q6e1
MIME-Version: 1.0
X-Received: by 2002:a05:6638:59b:b0:38c:8ef9:c68b with SMTP id
 a27-20020a056638059b00b0038c8ef9c68bmr857481jar.298.1671237999980; Fri, 16
 Dec 2022 16:46:39 -0800 (PST)
Date:   Fri, 16 Dec 2022 16:46:39 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000052f6ae05effb6b1f@google.com>
Subject: [syzbot] possible deadlock in f2fs_ioc_get_encryption_pwsalt
From:   syzbot <syzbot+883ded0ab581cc190f58@syzkaller.appspotmail.com>
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

HEAD commit:    830b3c68c1fb Linux 6.1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17951967880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=26d9ba6d9b746f4
dashboard link: https://syzkaller.appspot.com/bug?extid=883ded0ab581cc190f58
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2c32f77928d8/disk-830b3c68.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/02c35bb3112e/vmlinux-830b3c68.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fe93aa8e0468/bzImage-830b3c68.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+883ded0ab581cc190f58@syzkaller.appspotmail.com

F2FS-fs (loop4): Try to recover 2th superblock, ret: 0
F2FS-fs (loop4): Mounted with checkpoint version = 753bd00b
======================================================
WARNING: possible circular locking dependency detected
6.1.0-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor.4/21588 is trying to acquire lock:
ffff88807d6cc9d8 (&mm->mmap_lock#2){++++}-{3:3}, at: __might_fault+0xa9/0x180 mm/memory.c:5644

but task is already holding lock:
ffff888021560088 (&sbi->sb_lock){++++}-{3:3}, at: f2fs_down_write fs/f2fs/f2fs.h:2205 [inline]
ffff888021560088 (&sbi->sb_lock){++++}-{3:3}, at: f2fs_ioc_get_encryption_pwsalt+0x174/0x370 fs/f2fs/file.c:2334

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (&sbi->sb_lock){++++}-{3:3}:
       down_write+0x94/0x220 kernel/locking/rwsem.c:1562
       f2fs_down_write fs/f2fs/f2fs.h:2205 [inline]
       f2fs_handle_error+0x8e/0x200 fs/f2fs/super.c:3898
       f2fs_check_nid_range.part.0+0x4d/0x60 fs/f2fs/node.c:39
       f2fs_check_nid_range fs/f2fs/node.c:2275 [inline]
       add_free_nid.isra.0+0x781/0x940 fs/f2fs/node.c:2282
       scan_nat_page fs/f2fs/node.c:2384 [inline]
       __f2fs_build_free_nids+0x5b5/0xe10 fs/f2fs/node.c:2490
       f2fs_build_free_nids fs/f2fs/node.c:2528 [inline]
       f2fs_build_node_manager+0x2007/0x2fb0 fs/f2fs/node.c:3313
       f2fs_fill_super+0x3a95/0x77a0 fs/f2fs/super.c:4306
       mount_bdev+0x351/0x410 fs/super.c:1401
       legacy_get_tree+0x109/0x220 fs/fs_context.c:610
       vfs_get_tree+0x8d/0x2f0 fs/super.c:1531
       do_new_mount fs/namespace.c:3040 [inline]
       path_mount+0x132a/0x1e20 fs/namespace.c:3370
       do_mount fs/namespace.c:3383 [inline]
       __do_sys_mount fs/namespace.c:3591 [inline]
       __se_sys_mount fs/namespace.c:3568 [inline]
       __x64_sys_mount+0x283/0x300 fs/namespace.c:3568
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #3 (&nm_i->nat_tree_lock){++++}-{3:3}:
       down_read+0x9c/0x450 kernel/locking/rwsem.c:1509
       f2fs_down_read fs/f2fs/f2fs.h:2180 [inline]
       f2fs_get_node_info+0x1ac/0x1070 fs/f2fs/node.c:560
       f2fs_new_node_page+0x249/0xac0 fs/f2fs/node.c:1291
       f2fs_get_dnode_of_data+0x530/0x2480 fs/f2fs/node.c:806
       f2fs_reserve_block+0x4d/0x430 fs/f2fs/data.c:1184
       f2fs_get_block+0x131/0x150 fs/f2fs/data.c:1205
       f2fs_vm_page_mkwrite+0x12b2/0x1c90 fs/f2fs/file.c:118
       do_page_mkwrite+0x19b/0x680 mm/memory.c:2977
       wp_page_shared mm/memory.c:3323 [inline]
       do_wp_page+0xde5/0x1930 mm/memory.c:3473
       handle_pte_fault mm/memory.c:4972 [inline]
       __handle_mm_fault+0x181b/0x3a40 mm/memory.c:5096
       handle_mm_fault+0x1cc/0x780 mm/memory.c:5217
       faultin_page mm/gup.c:1009 [inline]
       __get_user_pages+0x497/0xf10 mm/gup.c:1230
       __get_user_pages_locked mm/gup.c:1434 [inline]
       __get_user_pages_remote+0x18f/0x830 mm/gup.c:2187
       pin_user_pages_remote+0x70/0xb0 mm/gup.c:3245
       process_vm_rw_single_vec mm/process_vm_access.c:105 [inline]
       process_vm_rw_core.constprop.0+0x43b/0x980 mm/process_vm_access.c:215
       process_vm_rw+0x29c/0x300 mm/process_vm_access.c:283
       __do_sys_process_vm_writev mm/process_vm_access.c:303 [inline]
       __se_sys_process_vm_writev mm/process_vm_access.c:298 [inline]
       __x64_sys_process_vm_writev+0xe3/0x1b0 mm/process_vm_access.c:298
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #2 (&sbi->node_change){++++}-{3:3}:
       down_read+0x9c/0x450 kernel/locking/rwsem.c:1509
       f2fs_down_read fs/f2fs/f2fs.h:2180 [inline]
       f2fs_lock_op fs/f2fs/f2fs.h:2223 [inline]
       f2fs_do_map_lock+0x4e/0x80 fs/f2fs/data.c:1442
       f2fs_vm_page_mkwrite+0x1253/0x1c90 fs/f2fs/file.c:116
       do_page_mkwrite+0x19b/0x680 mm/memory.c:2977
       do_shared_fault mm/memory.c:4618 [inline]
       do_fault mm/memory.c:4686 [inline]
       handle_pte_fault mm/memory.c:4954 [inline]
       __handle_mm_fault+0x2280/0x3a40 mm/memory.c:5096
       handle_mm_fault+0x1cc/0x780 mm/memory.c:5217
       faultin_page mm/gup.c:1009 [inline]
       __get_user_pages+0x497/0xf10 mm/gup.c:1230
       __get_user_pages_locked mm/gup.c:1494 [inline]
       __get_user_pages_remote+0x326/0x830 mm/gup.c:2187
       pin_user_pages_remote+0x70/0xb0 mm/gup.c:3245
       process_vm_rw_single_vec mm/process_vm_access.c:105 [inline]
       process_vm_rw_core.constprop.0+0x43b/0x980 mm/process_vm_access.c:215
       process_vm_rw+0x29c/0x300 mm/process_vm_access.c:283
       __do_sys_process_vm_writev mm/process_vm_access.c:303 [inline]
       __se_sys_process_vm_writev mm/process_vm_access.c:298 [inline]
       __x64_sys_process_vm_writev+0xe3/0x1b0 mm/process_vm_access.c:298
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #1 (mapping.invalidate_lock#3){++++}-{3:3}:
       down_read+0x9c/0x450 kernel/locking/rwsem.c:1509
       filemap_invalidate_lock_shared include/linux/fs.h:811 [inline]
       filemap_fault+0xba2/0x2400 mm/filemap.c:3127
       f2fs_filemap_fault+0x82/0x3e0 fs/f2fs/file.c:44
       __do_fault+0x107/0x600 mm/memory.c:4202
       do_shared_fault mm/memory.c:4608 [inline]
       do_fault mm/memory.c:4686 [inline]
       handle_pte_fault mm/memory.c:4954 [inline]
       __handle_mm_fault+0x2200/0x3a40 mm/memory.c:5096
       handle_mm_fault+0x1cc/0x780 mm/memory.c:5217
       faultin_page mm/gup.c:1009 [inline]
       __get_user_pages+0x497/0xf10 mm/gup.c:1230
       __get_user_pages_locked mm/gup.c:1434 [inline]
       __get_user_pages_remote+0x18f/0x830 mm/gup.c:2187
       pin_user_pages_remote+0x70/0xb0 mm/gup.c:3245
       process_vm_rw_single_vec mm/process_vm_access.c:105 [inline]
       process_vm_rw_core.constprop.0+0x43b/0x980 mm/process_vm_access.c:215
       process_vm_rw+0x29c/0x300 mm/process_vm_access.c:283
       __do_sys_process_vm_writev mm/process_vm_access.c:303 [inline]
       __se_sys_process_vm_writev mm/process_vm_access.c:298 [inline]
       __x64_sys_process_vm_writev+0xe3/0x1b0 mm/process_vm_access.c:298
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (&mm->mmap_lock#2){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3097 [inline]
       check_prevs_add kernel/locking/lockdep.c:3216 [inline]
       validate_chain kernel/locking/lockdep.c:3831 [inline]
       __lock_acquire+0x2a43/0x56d0 kernel/locking/lockdep.c:5055
       lock_acquire kernel/locking/lockdep.c:5668 [inline]
       lock_acquire+0x1e3/0x630 kernel/locking/lockdep.c:5633
       __might_fault mm/memory.c:5645 [inline]
       __might_fault+0x10c/0x180 mm/memory.c:5638
       _copy_to_user+0x29/0x150 lib/usercopy.c:29
       copy_to_user include/linux/uaccess.h:169 [inline]
       f2fs_ioc_get_encryption_pwsalt+0x2b2/0x370 fs/f2fs/file.c:2349
       __f2fs_ioctl+0x1755/0xa800 fs/f2fs/file.c:4151
       f2fs_ioctl+0x18e/0x220 fs/f2fs/file.c:4224
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:870 [inline]
       __se_sys_ioctl fs/ioctl.c:856 [inline]
       __x64_sys_ioctl+0x197/0x210 fs/ioctl.c:856
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

Chain exists of:
  &mm->mmap_lock#2 --> &nm_i->nat_tree_lock --> &sbi->sb_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sbi->sb_lock);
                               lock(&nm_i->nat_tree_lock);
                               lock(&sbi->sb_lock);
  lock(&mm->mmap_lock#2);

 *** DEADLOCK ***

2 locks held by syz-executor.4/21588:
 #0: ffff88801bc5e460 (sb_writers#21){.+.+}-{0:0}, at: f2fs_ioc_get_encryption_pwsalt+0x136/0x370 fs/f2fs/file.c:2330
 #1: ffff888021560088 (&sbi->sb_lock){++++}-{3:3}, at: f2fs_down_write fs/f2fs/f2fs.h:2205 [inline]
 #1: ffff888021560088 (&sbi->sb_lock){++++}-{3:3}, at: f2fs_ioc_get_encryption_pwsalt+0x174/0x370 fs/f2fs/file.c:2334

stack backtrace:
CPU: 1 PID: 21588 Comm: syz-executor.4 Not tainted 6.1.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd1/0x138 lib/dump_stack.c:106
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2177
 check_prev_add kernel/locking/lockdep.c:3097 [inline]
 check_prevs_add kernel/locking/lockdep.c:3216 [inline]
 validate_chain kernel/locking/lockdep.c:3831 [inline]
 __lock_acquire+0x2a43/0x56d0 kernel/locking/lockdep.c:5055
 lock_acquire kernel/locking/lockdep.c:5668 [inline]
 lock_acquire+0x1e3/0x630 kernel/locking/lockdep.c:5633
 __might_fault mm/memory.c:5645 [inline]
 __might_fault+0x10c/0x180 mm/memory.c:5638
 _copy_to_user+0x29/0x150 lib/usercopy.c:29
 copy_to_user include/linux/uaccess.h:169 [inline]
 f2fs_ioc_get_encryption_pwsalt+0x2b2/0x370 fs/f2fs/file.c:2349
 __f2fs_ioctl+0x1755/0xa800 fs/f2fs/file.c:4151
 f2fs_ioctl+0x18e/0x220 fs/f2fs/file.c:4224
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x197/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f4c6808c0d9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4c66bfe168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f4c681abf80 RCX: 00007f4c6808c0d9
RDX: 0000000000000000 RSI: 0000000040106614 RDI: 0000000000000003
RBP: 00007f4c680e7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff2fcbd3ff R14: 00007f4c66bfe300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
