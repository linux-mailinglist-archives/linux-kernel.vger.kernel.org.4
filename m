Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D7E6007F0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 09:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbiJQHnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 03:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbiJQHnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 03:43:35 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC805AC6D
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 00:43:33 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id j8-20020a056e02154800b002fc89e9ebeeso8506284ilu.16
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 00:43:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UfK1+fv3Ya5Q5MNSmq1YC4ie1AyJ3S/K2IZh9i7n/u0=;
        b=pZW5RogcZZS6m453K2Wr5UM1JsOPck5HQlAtTiOMGaJnwUxeCWuwFrSr1l4VHvQleG
         4AAL70xKT5zrtwjFBFqNW/vDzEUNCbox0T5Brv5qAIp6MrkYaYscPQ5P9k32YvZnaJMi
         1nNTzR900YIr+qrDQnDkXskprx232LqV1QAJJHwdRaJE+hgg6fg7iois3MNkNZwiosgV
         SjiC90k3baVSWnfa/3rLdUlxKdfeS/PvGhcuml9xe5FwAKFrHJSzD9Wql/AXZYl5w2UV
         KdsEaQ1Z3/0R6pIh3q83FnlrkSa+Jqo6UJh6NllCv/1Nn/lc0J47iJqP/eGCFikHCyP0
         3jpQ==
X-Gm-Message-State: ACrzQf2Ie5mV5bgpDTSt3Osl+ERx2hqMsA45O8WEyWDhvznq9wYEsSzI
        /SL6l/qimRSOXENgaTuFiSkVHtS4IZsaldjEft4phWdYhuhz
X-Google-Smtp-Source: AMsMyM5DwIhNIsr790vF1a/B0/aBUlOhdTpCpEuKwM62eewHdsfW2tD2wpPmFiUNBY0fAHrrQz5XDDU6mUMb3R/HUHElt4CiYuQY
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4113:b0:363:f47e:7efd with SMTP id
 ay19-20020a056638411300b00363f47e7efdmr4996107jab.264.1665992613336; Mon, 17
 Oct 2022 00:43:33 -0700 (PDT)
Date:   Mon, 17 Oct 2022 00:43:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ea9fef05eb3621b6@google.com>
Subject: [syzbot] possible deadlock in attr_data_get_block
From:   syzbot <syzbot+36bb70085ef6edc2ebb9@syzkaller.appspotmail.com>
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

Hello,

syzbot found the following issue on:

HEAD commit:    bbed346d5a96 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=13ce2a7c880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3a4a45d2d827c1e
dashboard link: https://syzkaller.appspot.com/bug?extid=36bb70085ef6edc2ebb9
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e8e91bc79312/disk-bbed346d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c1cb3fb3b77e/vmlinux-bbed346d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+36bb70085ef6edc2ebb9@syzkaller.appspotmail.com

ntfs3: loop4: Different NTFS' sector size (1024) and media sector size (512)
ntfs3: loop4: Mark volume as dirty due to NTFS errors
======================================================
WARNING: possible circular locking dependency detected
6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0 Not tainted
------------------------------------------------------
syz-executor.4/15497 is trying to acquire lock:
ffff000116476948 (&ni->file.run_lock#3){++++}-{3:3}, at: attr_data_get_block+0x84/0xa54 fs/ntfs3/attrib.c:899

but task is already holding lock:
ffff0000c7543ad8 (&mm->mmap_lock){++++}-{3:3}, at: mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
ffff0000c7543ad8 (&mm->mmap_lock){++++}-{3:3}, at: vm_mmap_pgoff+0xa0/0x1d0 mm/util.c:550

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&mm->mmap_lock){++++}-{3:3}:
       __might_fault+0x7c/0xb4 mm/memory.c:5577
       _copy_to_user include/linux/uaccess.h:134 [inline]
       copy_to_user include/linux/uaccess.h:160 [inline]
       fiemap_fill_next_extent+0xc4/0x1f8 fs/ioctl.c:144
       ni_fiemap+0x4cc/0x620 fs/ntfs3/frecord.c:2051
       ntfs_fiemap+0x9c/0xdc fs/ntfs3/file.c:1245
       ioctl_fiemap fs/ioctl.c:219 [inline]
       do_vfs_ioctl+0x10f0/0x16a4 fs/ioctl.c:810
       __do_sys_ioctl fs/ioctl.c:868 [inline]
       __se_sys_ioctl fs/ioctl.c:856 [inline]
       __arm64_sys_ioctl+0x98/0x140 fs/ioctl.c:856
       __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
       invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
       el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
       do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
       el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
       el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
       el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581

-> #0 (&ni->file.run_lock#3){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3095 [inline]
       check_prevs_add kernel/locking/lockdep.c:3214 [inline]
       validate_chain kernel/locking/lockdep.c:3829 [inline]
       __lock_acquire+0x1530/0x30a4 kernel/locking/lockdep.c:5053
       lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5666
       down_read+0x5c/0x78 kernel/locking/rwsem.c:1499
       attr_data_get_block+0x84/0xa54 fs/ntfs3/attrib.c:899
       ntfs_file_mmap+0x1d0/0x2e4 fs/ntfs3/file.c:387
       call_mmap include/linux/fs.h:2192 [inline]
       mmap_region+0x7fc/0xc14 mm/mmap.c:1752
       do_mmap+0x644/0x97c mm/mmap.c:1540
       vm_mmap_pgoff+0xe8/0x1d0 mm/util.c:552
       ksys_mmap_pgoff+0x1cc/0x278 mm/mmap.c:1586
       __do_sys_mmap arch/arm64/kernel/sys.c:28 [inline]
       __se_sys_mmap arch/arm64/kernel/sys.c:21 [inline]
       __arm64_sys_mmap+0x58/0x6c arch/arm64/kernel/sys.c:21
       __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
       invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
       el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
       do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
       el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
       el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
       el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&mm->mmap_lock);
                               lock(&ni->file.run_lock#3);
                               lock(&mm->mmap_lock);
  lock(&ni->file.run_lock#3);

 *** DEADLOCK ***

1 lock held by syz-executor.4/15497:
 #0: ffff0000c7543ad8 (&mm->mmap_lock){++++}-{3:3}, at: mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #0: ffff0000c7543ad8 (&mm->mmap_lock){++++}-{3:3}, at: vm_mmap_pgoff+0xa0/0x1d0 mm/util.c:550

stack backtrace:
CPU: 0 PID: 15497 Comm: syz-executor.4 Not tainted 6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
Call trace:
 dump_backtrace+0x1c4/0x1f0 arch/arm64/kernel/stacktrace.c:156
 show_stack+0x2c/0x54 arch/arm64/kernel/stacktrace.c:163
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x104/0x16c lib/dump_stack.c:106
 dump_stack+0x1c/0x58 lib/dump_stack.c:113
 print_circular_bug+0x2c4/0x2c8 kernel/locking/lockdep.c:2053
 check_noncircular+0x14c/0x154 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3095 [inline]
 check_prevs_add kernel/locking/lockdep.c:3214 [inline]
 validate_chain kernel/locking/lockdep.c:3829 [inline]
 __lock_acquire+0x1530/0x30a4 kernel/locking/lockdep.c:5053
 lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5666
 down_read+0x5c/0x78 kernel/locking/rwsem.c:1499
 attr_data_get_block+0x84/0xa54 fs/ntfs3/attrib.c:899
 ntfs_file_mmap+0x1d0/0x2e4 fs/ntfs3/file.c:387
 call_mmap include/linux/fs.h:2192 [inline]
 mmap_region+0x7fc/0xc14 mm/mmap.c:1752
 do_mmap+0x644/0x97c mm/mmap.c:1540
 vm_mmap_pgoff+0xe8/0x1d0 mm/util.c:552
 ksys_mmap_pgoff+0x1cc/0x278 mm/mmap.c:1586
 __do_sys_mmap arch/arm64/kernel/sys.c:28 [inline]
 __se_sys_mmap arch/arm64/kernel/sys.c:21 [inline]
 __arm64_sys_mmap+0x58/0x6c arch/arm64/kernel/sys.c:21
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
 el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
