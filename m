Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFF7655291
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 17:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbiLWQNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 11:13:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbiLWQNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 11:13:43 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74274A45D
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 08:13:42 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id i7-20020a056e021b0700b003033a763270so2860161ilv.19
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 08:13:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G2fxcvjHeOeT+c321+0jWOGOEOFvL9aqKt045Mip7XY=;
        b=Bo53skg24sEn7h5ig9brdPpgAx1DFYGP86yrR7GMH89ENtmNloQiA1LHUmlzPTaoVW
         UxZwXKXHd4pC9M3JgUlJWm2YtV7ttDhCS/wi2S9NmxlGRMF9NOzHLCiH6TWZOaCbLasq
         gFRIYYj25oE/Yujcy93SmuP+1HwbdU6RD7jQnjE7lHY3EeM9jCnzvhfCf4vMOWOA2Vop
         4+DxD/fR6+wScowL0Vp0I452UqWZaKnLrmoGCPYDE6/0d5ojs54MY8yBW+k5pvs1yU4t
         EYk9wJTSZSIJsmwIx6Wa4QIUMDyho0Ru+46fczGE0XDQLnmU3M8Ru+HyTvbVEhmnI88S
         +jgA==
X-Gm-Message-State: AFqh2kqy1HjM8Uf2eSxNlG/SP8NG7k+G5W+EitWtnQRav/YSleE8+PYs
        O/+wKarqjuDDqZEYp4CDQjf6ZtAibEChlon2a6/QN2ndZr+1
X-Google-Smtp-Source: AMrXdXsXvCv6acTdARziEUMn7or1vrDCcN7leK4AUlZHFBUc0kKxWkYbXvrnuVv35BTQt0TsBf1Sl5gm6uPJgqgTkhNvSUIK/CTh
MIME-Version: 1.0
X-Received: by 2002:a5d:81d9:0:b0:6df:bcf7:d86 with SMTP id
 t25-20020a5d81d9000000b006dfbcf70d86mr776856iol.188.1671812021829; Fri, 23
 Dec 2022 08:13:41 -0800 (PST)
Date:   Fri, 23 Dec 2022 08:13:41 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b145f905f081118e@google.com>
Subject: [syzbot] [reiserfs?] possible deadlock in reiserfs_get_block
From:   syzbot <syzbot+8a4c84020c63609f15ec@syzkaller.appspotmail.com>
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

HEAD commit:    f9ff5644bcc0 Merge tag 'hsi-for-6.2' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1246ddbf880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c163713cf9186fe7
dashboard link: https://syzkaller.appspot.com/bug?extid=8a4c84020c63609f15ec
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/95eb66f6b569/disk-f9ff5644.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fb05e1a5a9de/vmlinux-f9ff5644.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e2f1f698973a/bzImage-f9ff5644.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8a4c84020c63609f15ec@syzkaller.appspotmail.com

REISERFS (device loop2): Created .reiserfs_priv - reserved for xattr storage.
======================================================
WARNING: possible circular locking dependency detected
6.1.0-syzkaller-13139-gf9ff5644bcc0 #0 Not tainted
------------------------------------------------------
syz-executor.2/16192 is trying to acquire lock:
ffff8880220f5018 (&mm->mmap_lock#2){++++}-{3:3}, at: __might_fault+0x8f/0x110 mm/memory.c:5646

but task is already holding lock:
ffff88801f15e090 (&sbi->lock){+.+.}-{3:3}, at: reiserfs_write_lock+0x77/0xd0 fs/reiserfs/lock.c:27

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&sbi->lock){+.+.}-{3:3}:
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
       __mutex_lock_common+0x1bd/0x26e0 kernel/locking/mutex.c:603
       __mutex_lock kernel/locking/mutex.c:747 [inline]
       mutex_lock_nested+0x17/0x20 kernel/locking/mutex.c:799
       reiserfs_write_lock+0x77/0xd0 fs/reiserfs/lock.c:27
       reiserfs_get_block+0x24e/0x5180 fs/reiserfs/inode.c:680
       do_mpage_readpage+0x970/0x1c50 fs/mpage.c:208
       mpage_readahead+0x210/0x380 fs/mpage.c:361
       read_pages+0x169/0x9c0 mm/readahead.c:161
       page_cache_ra_unbounded+0x194/0x820 mm/readahead.c:242
       page_cache_sync_readahead include/linux/pagemap.h:1210 [inline]
       filemap_get_pages+0x465/0x10d0 mm/filemap.c:2600
       filemap_read+0x3cf/0xea0 mm/filemap.c:2694
       call_read_iter include/linux/fs.h:2180 [inline]
       generic_file_splice_read+0x1ff/0x5d0 fs/splice.c:309
       do_splice_to fs/splice.c:793 [inline]
       splice_direct_to_actor+0x41b/0xc00 fs/splice.c:865
       do_splice_direct+0x279/0x3d0 fs/splice.c:974
       do_sendfile+0x5fb/0xf80 fs/read_write.c:1255
       __do_sys_sendfile64 fs/read_write.c:1323 [inline]
       __se_sys_sendfile64+0x14f/0x1b0 fs/read_write.c:1309
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #1 (mapping.invalidate_lock#7){.+.+}-{3:3}:
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
       down_read+0x39/0x50 kernel/locking/rwsem.c:1509
       filemap_invalidate_lock_shared include/linux/fs.h:811 [inline]
       filemap_fault+0x2fb/0x1060 mm/filemap.c:3146
       __do_fault+0x136/0x4f0 mm/memory.c:4163
       do_shared_fault mm/memory.c:4569 [inline]
       do_fault mm/memory.c:4647 [inline]
       handle_pte_fault mm/memory.c:4931 [inline]
       __handle_mm_fault mm/memory.c:5073 [inline]
       handle_mm_fault+0x17fa/0x2640 mm/memory.c:5219
       do_user_addr_fault+0x69b/0xcb0 arch/x86/mm/fault.c:1428
       handle_page_fault arch/x86/mm/fault.c:1519 [inline]
       exc_page_fault+0x7a/0x110 arch/x86/mm/fault.c:1575
       asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570

-> #0 (&mm->mmap_lock#2){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3097 [inline]
       check_prevs_add kernel/locking/lockdep.c:3216 [inline]
       validate_chain+0x1898/0x6ae0 kernel/locking/lockdep.c:3831
       __lock_acquire+0x1292/0x1f60 kernel/locking/lockdep.c:5055
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
       __might_fault+0xb2/0x110 mm/memory.c:5647
       reiserfs_ioctl+0x11c/0x340 fs/reiserfs/ioctl.c:96
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:870 [inline]
       __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:856
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

Chain exists of:
  &mm->mmap_lock#2 --> mapping.invalidate_lock#7 --> &sbi->lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sbi->lock);
                               lock(mapping.invalidate_lock#7);
                               lock(&sbi->lock);
  lock(&mm->mmap_lock#2);

 *** DEADLOCK ***

1 lock held by syz-executor.2/16192:
 #0: ffff88801f15e090 (&sbi->lock){+.+.}-{3:3}, at: reiserfs_write_lock+0x77/0xd0 fs/reiserfs/lock.c:27

stack backtrace:
CPU: 0 PID: 16192 Comm: syz-executor.2 Not tainted 6.1.0-syzkaller-13139-gf9ff5644bcc0 #0
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
 reiserfs_ioctl+0x11c/0x340 fs/reiserfs/ioctl.c:96
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f5a8b88c0d9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5a8c578168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f5a8b9abf80 RCX: 00007f5a8b88c0d9
RDX: 00000000200000c0 RSI: 0000000080087601 RDI: 0000000000000004
RBP: 00007f5a8b8e7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff6e17e56f R14: 00007f5a8c578300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
