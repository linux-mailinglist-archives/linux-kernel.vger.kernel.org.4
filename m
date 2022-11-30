Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4897E63DBEA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 18:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiK3RZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 12:25:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiK3RZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 12:25:51 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131B22B266
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 09:25:51 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id e12-20020a056602044c00b006dfbda66242so2641392iov.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 09:25:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dg8pE2pdZzQF1aNYzVD7kT09v4/1tI50YgS+w3Nil2Q=;
        b=1rrbO37bBDp/GZD1mFelzcpRADVQE91EyxXIXgb7/svcSc/A1xQr18gBcADoAu/t0I
         o1QaeyySm+o5+YjBjiYLCo0e9Tc4luas0ywaHMZk4NfpsE7Y6fOOx6QJFwMtO730poQT
         M3zTeyBkenaJqwQaePQAAmoO9jrMY5oUno8kCXnyO5y/CcHw7AbSPeu6yA6UYpjhge4W
         5qeJ2ARay6w2v3EhXcM5eM8lrqkQ9xMD87r9RKiNbJeLZisJMkmxYPsGtv5W9oUnFIyk
         mZcn6ySmHO2OJLpPHqZX+HNZE3w/PcRo9M9Gg5hiuXJYb5pI40SgwycoWEnyiiSSdRqo
         9iwA==
X-Gm-Message-State: ANoB5plZ/YrLzmwbBZ3z6l2/6y1+VGnpRbbQiWuedabBFuJbTpjKmx9o
        fXCiWyGeLwrMvUzHTdBsnJwQ3wpkhPGsRVdipVf+YSXhSMNY
X-Google-Smtp-Source: AA0mqf5jGrApGbt+LJN+VyLtlYeppc+xGdmsRq9lxFwDz4q0j+JslNet6bARhCdxxi/jbDFktN8QuozoegLmXQV0Hefd/XshKzdR
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:11a3:b0:302:a9a5:d608 with SMTP id
 3-20020a056e0211a300b00302a9a5d608mr21740136ilj.141.1669829150457; Wed, 30
 Nov 2022 09:25:50 -0800 (PST)
Date:   Wed, 30 Nov 2022 09:25:50 -0800
In-Reply-To: <0000000000000fc50405eb48a1be@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005948f105eeb3656a@google.com>
Subject: Re: [syzbot] possible deadlock in ni_fiemap
From:   syzbot <syzbot+c300ab283ba3bc072439@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev,
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    01f856ae6d0c Merge tag 'net-6.1-rc8-2' of git://git.kernel..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15502883880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2325e409a9a893e1
dashboard link: https://syzkaller.appspot.com/bug?extid=c300ab283ba3bc072439
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=161b2cf5880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=125b2cbd880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5428d604f56a/disk-01f856ae.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e953d290d254/vmlinux-01f856ae.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3f71610a4904/bzImage-01f856ae.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/073a0bd8a341/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c300ab283ba3bc072439@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 4096
======================================================
WARNING: possible circular locking dependency detected
6.1.0-rc7-syzkaller-00101-g01f856ae6d0c #0 Not tainted
------------------------------------------------------
syz-executor911/3632 is trying to acquire lock:
ffff888021991718 (&mm->mmap_lock#2){++++}-{3:3}, at: __might_fault+0x8f/0x110 mm/memory.c:5645

but task is already holding lock:
ffff8880741101b0 (&ni->file.run_lock#3){++++}-{3:3}, at: ni_fiemap+0x32b/0x1130 fs/ntfs3/frecord.c:1947

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&ni->file.run_lock#3){++++}-{3:3}:
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
       down_read+0x39/0x50 kernel/locking/rwsem.c:1509
       attr_data_get_block+0x158/0x2370 fs/ntfs3/attrib.c:899
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
       ni_fiemap+0xa11/0x1130 fs/ntfs3/frecord.c:2051
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
  lock(&ni->file.run_lock#3);
                               lock(&mm->mmap_lock#2);
                               lock(&ni->file.run_lock#3);
  lock(&mm->mmap_lock#2);

 *** DEADLOCK ***

2 locks held by syz-executor911/3632:
 #0: ffff888074110100 (&ni->ni_lock/4){+.+.}-{3:3}, at: ni_lock fs/ntfs3/ntfs_fs.h:1108 [inline]
 #0: ffff888074110100 (&ni->ni_lock/4){+.+.}-{3:3}, at: ntfs_fiemap+0x101/0x180 fs/ntfs3/file.c:1243
 #1: ffff8880741101b0 (&ni->file.run_lock#3){++++}-{3:3}, at: ni_fiemap+0x32b/0x1130 fs/ntfs3/frecord.c:1947

stack backtrace:
CPU: 0 PID: 3632 Comm: syz-executor911 Not tainted 6.1.0-rc7-syzkaller-00101-g01f856ae6d0c #0
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
 ni_fiemap+0xa11/0x1130 fs/ntfs3/frecord.c:2051
 ntfs_fiemap+0x134/0x180 fs/ntfs3/file.c:1245
 ioctl_fiemap fs/ioctl.c:219 [inline]
 do_vfs_ioctl+0x187f/0x29a0 fs/ioctl.c:810
 __do_sys_ioctl fs/ioctl.c:868 [inline]
 __se_sys_ioctl+0x83/0x170 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7febc4d60d69
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffe05c24d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007febc4d60d69
RDX: 00000000200001c0 RSI: 00000000c020660b RDI: 00000000

