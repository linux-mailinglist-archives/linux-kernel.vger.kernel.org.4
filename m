Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3594C649927
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 08:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbiLLHDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 02:03:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbiLLHDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 02:03:05 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156FF2BD
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 23:03:04 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id b24-20020a056602219800b006e2bf9902cbso5624608iob.4
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 23:03:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UPQdXpVEAh8N9SIBSH1a9NivfmH8puJf79PnbNA5xFA=;
        b=7FTxeXgppCbaYFf7HeWxXpp9kqedZdqQIvFFgj1NHiZvzUQXRhaLKR5UqCWAPazVHh
         rrqJ3AZ3MimQG2udnMyp7f4283vF+39c7JKxJi1pRYnpCLoCa8dcAaaJQR82+dDmUDfT
         kHvGvcVdUxhEegn6+D5CB//H5izX/0D3A+ktzLOU4gIHcMe/Ydi88osaeRNWG0M3JrqD
         9pApsapvO/W2vT6Oo4wzQBEoRx4pygHtwGky+RNEvt68oX9jqRHri17wULKtXNzEfzLN
         PeY/bYIG8OkG6NJ2Zps9WkKlRtApJfx6aVP0PUZXeNPvuSVdQ4iL+TZvxNb0Huk1loE/
         fdrg==
X-Gm-Message-State: ANoB5pnrU6x/N1B/EvxxviLUwtxYYO2kZQclUfGRm2ACLV/tcGOaIpvb
        1xbrI1VzQm2vFUkXlUqzEv2kz5ZaSdtkrCmcXXjHOtajOQOL
X-Google-Smtp-Source: AA0mqf6M4+hAsfwkGkeQy5bBbmjtlI0ER5S96MF/TVSIP/yqJ8dE086xsT30fb4XVoMffLacBrqqWNwwo9w3+yV02kxzQdgd2EgO
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3470:b0:389:c976:846e with SMTP id
 q48-20020a056638347000b00389c976846emr27282866jav.246.1670828583441; Sun, 11
 Dec 2022 23:03:03 -0800 (PST)
Date:   Sun, 11 Dec 2022 23:03:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000032654605ef9c1846@google.com>
Subject: [syzbot] possible deadlock in do_page_mkwrite
From:   syzbot <syzbot+ff866d16791d4984b3c7@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, reiserfs-devel@vger.kernel.org,
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

HEAD commit:    296a7b7eb792 Merge tag 'for-linus' of git://git.armlinux.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17a4643f880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d58e7fe7f9cf5e24
dashboard link: https://syzkaller.appspot.com/bug?extid=ff866d16791d4984b3c7
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e884bd14818f/disk-296a7b7e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9d1ad945db61/vmlinux-296a7b7e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1295336774a6/bzImage-296a7b7e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ff866d16791d4984b3c7@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.1.0-rc8-syzkaller-00154-g296a7b7eb792 #0 Not tainted
------------------------------------------------------
syz-executor.4/7705 is trying to acquire lock:
ffff88807ba26090 (&sbi->lock){+.+.}-{3:3}, at: reiserfs_write_lock+0x77/0xd0 fs/reiserfs/lock.c:27

but task is already holding lock:
ffff88807b57c558 (sb_pagefaults#3){.+.+}-{0:0}, at: do_page_mkwrite+0x19e/0x5e0 mm/memory.c:2977

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (sb_pagefaults#3){.+.+}-{0:0}:
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1826 [inline]
       sb_start_pagefault include/linux/fs.h:1930 [inline]
       filemap_page_mkwrite+0x15c/0x7a0 mm/filemap.c:3420
       do_page_mkwrite+0x19e/0x5e0 mm/memory.c:2977
       do_shared_fault mm/memory.c:4618 [inline]
       do_fault mm/memory.c:4686 [inline]
       handle_pte_fault mm/memory.c:4954 [inline]
       __handle_mm_fault mm/memory.c:5096 [inline]
       handle_mm_fault+0x1c63/0x3630 mm/memory.c:5217
       do_user_addr_fault+0x69b/0xcb0 arch/x86/mm/fault.c:1428
       handle_page_fault arch/x86/mm/fault.c:1519 [inline]
       exc_page_fault+0x7a/0x110 arch/x86/mm/fault.c:1575
       asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570

-> #1 (&mm->mmap_lock#2){++++}-{3:3}:
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
       __might_fault+0xb2/0x110 mm/memory.c:5645
       reiserfs_ioctl+0x11c/0x340 fs/reiserfs/ioctl.c:96
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:870 [inline]
       __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:856
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (&sbi->lock){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3097 [inline]
       check_prevs_add kernel/locking/lockdep.c:3216 [inline]
       validate_chain+0x1898/0x6ae0 kernel/locking/lockdep.c:3831
       __lock_acquire+0x1292/0x1f60 kernel/locking/lockdep.c:5055
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
       __mutex_lock_common+0x1bd/0x26e0 kernel/locking/mutex.c:603
       __mutex_lock kernel/locking/mutex.c:747 [inline]
       mutex_lock_nested+0x17/0x20 kernel/locking/mutex.c:799
       reiserfs_write_lock+0x77/0xd0 fs/reiserfs/lock.c:27
       reiserfs_dirty_inode+0xdf/0x230 fs/reiserfs/super.c:704
       __mark_inode_dirty+0x1e7/0x600 fs/fs-writeback.c:2408
       generic_update_time fs/inode.c:1859 [inline]
       inode_update_time fs/inode.c:1872 [inline]
       __file_update_time fs/inode.c:2088 [inline]
       file_update_time+0x551/0x5d0 fs/inode.c:2119
       filemap_page_mkwrite+0x248/0x7a0 mm/filemap.c:3421
       do_page_mkwrite+0x19e/0x5e0 mm/memory.c:2977
       wp_page_shared+0x15e/0x380 mm/memory.c:3323
       handle_pte_fault mm/memory.c:4972 [inline]
       __handle_mm_fault mm/memory.c:5096 [inline]
       handle_mm_fault+0x1e72/0x3630 mm/memory.c:5217
       do_user_addr_fault+0x69b/0xcb0 arch/x86/mm/fault.c:1428
       handle_page_fault arch/x86/mm/fault.c:1519 [inline]
       exc_page_fault+0x7a/0x110 arch/x86/mm/fault.c:1575
       asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570

other info that might help us debug this:

Chain exists of:
  &sbi->lock --> &mm->mmap_lock#2 --> sb_pagefaults#3

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(sb_pagefaults#3);
                               lock(&mm->mmap_lock#2);
                               lock(sb_pagefaults#3);
  lock(&sbi->lock);

 *** DEADLOCK ***

2 locks held by syz-executor.4/7705:
 #0: ffff888017d7f558 (&mm->mmap_lock#2){++++}-{3:3}, at: mmap_read_trylock include/linux/mmap_lock.h:136 [inline]
 #0: ffff888017d7f558 (&mm->mmap_lock#2){++++}-{3:3}, at: do_user_addr_fault+0x2e2/0xcb0 arch/x86/mm/fault.c:1369
 #1: ffff88807b57c558 (sb_pagefaults#3){.+.+}-{0:0}, at: do_page_mkwrite+0x19e/0x5e0 mm/memory.c:2977

stack backtrace:
CPU: 0 PID: 7705 Comm: syz-executor.4 Not tainted 6.1.0-rc8-syzkaller-00154-g296a7b7eb792 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 check_noncircular+0x2cc/0x390 kernel/locking/lockdep.c:2177
 check_prev_add kernel/locking/lockdep.c:3097 [inline]
 check_prevs_add kernel/locking/lockdep.c:3216 [inline]
 validate_chain+0x1898/0x6ae0 kernel/locking/lockdep.c:3831
 __lock_acquire+0x1292/0x1f60 kernel/locking/lockdep.c:5055
 lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
 __mutex_lock_common+0x1bd/0x26e0 kernel/locking/mutex.c:603
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x17/0x20 kernel/locking/mutex.c:799
 reiserfs_write_lock+0x77/0xd0 fs/reiserfs/lock.c:27
 reiserfs_dirty_inode+0xdf/0x230 fs/reiserfs/super.c:704
 __mark_inode_dirty+0x1e7/0x600 fs/fs-writeback.c:2408
 generic_update_time fs/inode.c:1859 [inline]
 inode_update_time fs/inode.c:1872 [inline]
 __file_update_time fs/inode.c:2088 [inline]
 file_update_time+0x551/0x5d0 fs/inode.c:2119
 filemap_page_mkwrite+0x248/0x7a0 mm/filemap.c:3421
 do_page_mkwrite+0x19e/0x5e0 mm/memory.c:2977
 wp_page_shared+0x15e/0x380 mm/memory.c:3323
 handle_pte_fault mm/memory.c:4972 [inline]
 __handle_mm_fault mm/memory.c:5096 [inline]
 handle_mm_fault+0x1e72/0x3630 mm/memory.c:5217
 do_user_addr_fault+0x69b/0xcb0 arch/x86/mm/fault.c:1428
 handle_page_fault arch/x86/mm/fault.c:1519 [inline]
 exc_page_fault+0x7a/0x110 arch/x86/mm/fault.c:1575
 asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0033:0x7f2f83486b3f
Code: d0 eb 0b 0f 1f 84 00 00 00 00 00 48 89 f8 48 83 fa 10 0f 82 da 00 00 00 48 83 fa 20 0f 87 1f 01 00 00 0f 10 06 0f 10 4c 16 f0 <0f> 11 07 0f 11 4c 17 f0 c3 0f 1f 84 00 00 00 00 00 48 39 d1 0f 82
RSP: 002b:00007ffd6e289b38 EFLAGS: 00010287
RAX: 0000000020000080 RBX: 0000000000000000 RCX: 00007f2f83000000
RDX: 0000000000000013 RSI: 00007f2f83001548 RDI: 0000000020000080
RBP: 00007ffd6e289bf8 R08: 00007f2f83400000 R09: 00007f2f83000000
R10: 00007f2f83001530 R11: 0000000000000246 R12: 000000000004b63d
R13: 00007ffd6e289c20 R14: 00007f2f835abf80 R15: 0000000000000032
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
