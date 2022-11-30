Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB3B563D601
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 13:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbiK3MwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 07:52:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbiK3Mv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 07:51:59 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B904198C
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 04:51:58 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id q197-20020a6b8ece000000b006de79f67604so11065926iod.13
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 04:51:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rpaBHYH7J8llwWmefngwCVsX68GsX6D7qLzzZqpW4EI=;
        b=Lme1cGJ7aMGRwJZ5XDPaTP7lLawSJHbFYFdXx9xqeELSsk5V/i/Y6qGgZhYL9EXlhO
         66K4e/m9m95JyNEnP557Xy/qI3R5q3rI5Tq3JvvFgJVVYKuE9s6Kd3mfbeEeYOZjQCRw
         lWAVMFUwY1xty5mmz5dibYiuUH0vA3kqVEIEpZZ55mUAQV7XT8j8C++NYIXOGVe/0zyG
         RWk48SWgLUjTX0j35lnzyc0LzTVCwIryI2ztwueBf9sJCEhpw6pvBt4ExLTcSRoyp+1I
         9a86lZhVQNjdnUG+qS+kHUXE24UCPB0T+CVfFLgpGHyS6Nl0iO/r23M2xhMHl7BoneBB
         mpTA==
X-Gm-Message-State: ANoB5pkJpq/QBT9km9oaBQu/I9t/Ra13Kgoh4qJMvr2k7uVk7qR2B4+l
        xDltKJI67m4x7ClP0TpX00KwGAneUD2mQJfQeaFnm1fkE2jR
X-Google-Smtp-Source: AA0mqf5O5/1WKIkzk8bnWi31vjGDIeYnnbCPA1orrc+QWsVehZlofpypWQ5CesFY2nNBOMFkHfgVQLEP/DAUmbEtEGf712YrF/yf
MIME-Version: 1.0
X-Received: by 2002:a02:3847:0:b0:364:e67:8d26 with SMTP id
 v7-20020a023847000000b003640e678d26mr21188028jae.117.1669812717750; Wed, 30
 Nov 2022 04:51:57 -0800 (PST)
Date:   Wed, 30 Nov 2022 04:51:57 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e2102c05eeaf9113@google.com>
Subject: [syzbot] possible deadlock in ntfs_fiemap
From:   syzbot <syzbot+96cee7d33ca3f87eee86@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        nathan@kernel.org, ndesaulniers@google.com, ntfs3@lists.linux.dev,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
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

HEAD commit:    01f856ae6d0c Merge tag 'net-6.1-rc8-2' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15bc5fc3880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2325e409a9a893e1
dashboard link: https://syzkaller.appspot.com/bug?extid=96cee7d33ca3f87eee86
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5428d604f56a/disk-01f856ae.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e953d290d254/vmlinux-01f856ae.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3f71610a4904/bzImage-01f856ae.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+96cee7d33ca3f87eee86@syzkaller.appspotmail.com

loop5: detected capacity change from 0 to 4096
ntfs3: loop5: Different NTFS' sector size (2048) and media sector size (512)
======================================================
WARNING: possible circular locking dependency detected
6.1.0-rc7-syzkaller-00101-g01f856ae6d0c #0 Not tainted
------------------------------------------------------
syz-executor.5/25213 is trying to acquire lock:
ffff88801d328fd8 (&mm->mmap_lock#2){++++}-{3:3}, at: __might_fault+0x8f/0x110 mm/memory.c:5645

but task is already holding lock:
ffff88801ebd34a0 (&ni->ni_lock/4){+.+.}-{3:3}, at: ni_lock fs/ntfs3/ntfs_fs.h:1108 [inline]
ffff88801ebd34a0 (&ni->ni_lock/4){+.+.}-{3:3}, at: ntfs_fiemap+0x101/0x180 fs/ntfs3/file.c:1243

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&ni->ni_lock/4){+.+.}-{3:3}
:
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
       __mutex_lock_common+0x1bd/0x26e0 kernel/locking/mutex.c:603
       __mutex_lock kernel/locking/mutex.c:747 [inline]
       mutex_lock_nested+0x17/0x20 kernel/locking/mutex.c:799
       ni_lock fs/ntfs3/ntfs_fs.h:1108 [inline]
       attr_data_get_block+0x301/0x2370 fs/ntfs3/attrib.c:917
       ntfs_file_mmap+0x48c/0x730 fs/ntfs3/file.c:387
       call_mmap include/linux/fs.h:2204 [inline]
       mmap_region+0xfe6/0x1e20 mm/mmap.c:2625
       do_mmap+0x8d9/0xf30 mm/mmap.c:1412
       vm_mmap_pgoff+0x19e/0x2b0 mm/util.c:520
       ksys_mmap_pgoff+0x48c/0x6d0 mm/mmap.c:1458
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (&mm->mmap_lock#2){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3097 [inline]
       check_prevs_add kernel/locking/lockdep.c:3216 [inline]
       validate_chain+0x1898/0x6ae0 kernel/locking/lockdep.c:3831
       __lock_acquire+0x1292/0x1f60 kernel/locking/lockdep.c:5055
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
       __might_fault+0xb2/0x110 mm/memory.c:5646
       _copy_to_user+0x26/0x130 lib/usercopy.c:29
       copy_to_user include/linux/uaccess.h:169 [inline]
       fiemap_fill_next_extent+0x22e/0x410 fs/ioctl.c:144
       ni_fiemap+0xf57/0x1130 fs/ntfs3/frecord.c:1934
       ntfs_fiemap+0x134/0x180 fs/ntfs3/file.c:1245
       ioctl_fiemap fs/ioctl.c:219 [inline]
       do_vfs_ioctl+0x187f/0x29a0 fs/ioctl.c:810
       __do_sys_ioctl fs/ioctl.c:868 [inline]
       __se_sys_ioctl+0x83/0x170 fs/ioctl.c:856
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ni->ni_lock/4);
                               lock(&mm->mmap_lock#2);
                               lock(&ni->ni_lock/4);
  lock(&mm->mmap_lock#2
);

 *** DEADLOCK ***

1 lock held by syz-executor.5/25213:
 #0: ffff88801ebd34a0 (&ni->ni_lock
/4){+.+.}-{3:3}, at: ni_lock fs/ntfs3/ntfs_fs.h:1108 [inline]
/4){+.+.}-{3:3}, at: ntfs_fiemap+0x101/0x180 fs/ntfs3/file.c:1243

stack backtrace:
CPU: 0 PID: 25213 Comm: syz-executor.5 Not tainted 6.1.0-rc7-syzkaller-00101-g01f856ae6d0c #0
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
 __might_fault+0xb2/0x110 mm/memory.c:5646
 _copy_to_user+0x26/0x130 lib/usercopy.c:29
 copy_to_user include/linux/uaccess.h:169 [inline]
 fiemap_fill_next_extent+0x22e/0x410 fs/ioctl.c:144
 ni_fiemap+0xf57/0x1130 fs/ntfs3/frecord.c:1934
 ntfs_fiemap+0x134/0x180 fs/ntfs3/file.c:1245
 ioctl_fiemap fs/ioctl.c:219 [inline]
 do_vfs_ioctl+0x187f/0x29a0 fs/ioctl.c:810
 __do_sys_ioctl fs/ioctl.c:868 [inline]
 __se_sys_ioctl+0x83/0x170 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f692648c0d9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6927202168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f69265abf80 RCX: 00007f692648c0d9
RDX: 0000000020000240 RSI: 00000000c020660b RDI: 0000000000000004
RBP: 00007f69264e7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe980edc3f R14: 00007f6927202300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
