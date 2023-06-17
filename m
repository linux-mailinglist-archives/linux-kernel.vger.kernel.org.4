Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9166734131
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 15:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbjFQNZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 09:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjFQNZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 09:25:03 -0400
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D54C1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 06:25:02 -0700 (PDT)
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-341ce6fb1f5so17207565ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 06:25:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687008301; x=1689600301;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eKT35itmh35X+BVg1xyD9Iz6NOKE1S0Sbt2WIuNW/AI=;
        b=Die7Nzufq4EaX3214FyWTkMZgmOzIDjWevst3rQNy7XmvOFSpiiZ1uxk566xfr/ppR
         3zHGoPinDwpGs6hgUoPxBQcRhY+P7xwQWr9mM7Fbw48FtNeBwXMNWXOd/2tYf/AlAh8I
         fHBrE3kGXsiXUsQfcLsi3m/o1y9w9fgv5DNb07e7u495zuB0Z5ZisfybpK3UIDvxyWVq
         fPZtlpWov/fi228M/xRjWQGf7is6jRpmOr4jCr/NR+qWgwRrKz/376MxuHjlqq7i90CW
         ipVc+iHXoVXDqFchoHtI1IEX9aIWL1ZPR3MPwTucWqDrim7zyzI5vHeM0AlzfIlPc5ZE
         nYMA==
X-Gm-Message-State: AC+VfDzNUELHU+R1vxDgKTCryX2rOEHb88VQ6kegj3nIX41SGhr2IPXG
        UTYtOSzFUXint8417ACV7eWnnEnKFxKvXh0/e6gVk3weEfpa
X-Google-Smtp-Source: ACHHUZ5hY1CtLi6DQK0PcL4kz8OLy4HRx6wdNtGgJ/4ih3twZhZKNVIp04Be/L73r+3AALt4uW5KmpMD6uibsNK8NKogpD0fEOYI
MIME-Version: 1.0
X-Received: by 2002:a92:d483:0:b0:341:da64:d82d with SMTP id
 p3-20020a92d483000000b00341da64d82dmr1289041ilg.6.1687008301588; Sat, 17 Jun
 2023 06:25:01 -0700 (PDT)
Date:   Sat, 17 Jun 2023 06:25:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008ca7ee05fe533ac3@google.com>
Subject: [syzbot] [block?] KMSAN: kernel-infoleak in copy_page_to_iter (4)
From:   syzbot <syzbot+17a061f6132066e9fb95@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, glider@google.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    7cccf3be6dcb string: use __builtin_memcpy() in strlcpy/str..
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1228ed9b280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5e9e8900159378
dashboard link: https://syzkaller.appspot.com/bug?extid=17a061f6132066e9fb95
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5e08b958e39c/disk-7cccf3be.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9003cbdf6555/vmlinux-7cccf3be.xz
kernel image: https://storage.googleapis.com/syzbot-assets/192dba10f451/bzImage-7cccf3be.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+17a061f6132066e9fb95@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: kernel-infoleak in instrument_copy_to_user include/linux/instrumented.h:114 [inline]
BUG: KMSAN: kernel-infoleak in copyout lib/iov_iter.c:169 [inline]
BUG: KMSAN: kernel-infoleak in _copy_to_iter+0x420/0x1d00 lib/iov_iter.c:536
 instrument_copy_to_user include/linux/instrumented.h:114 [inline]
 copyout lib/iov_iter.c:169 [inline]
 _copy_to_iter+0x420/0x1d00 lib/iov_iter.c:536
 copy_page_to_iter+0x46e/0x920 lib/iov_iter.c:742
 copy_folio_to_iter include/linux/uio.h:197 [inline]
 filemap_read+0xc37/0x14f0 mm/filemap.c:2742
 blkdev_read_iter+0xa1b/0xbc0 block/fops.c:606
 call_read_iter include/linux/fs.h:1862 [inline]
 new_sync_read fs/read_write.c:389 [inline]
 vfs_read+0x933/0xe40 fs/read_write.c:470
 ksys_read+0x20f/0x4c0 fs/read_write.c:613
 __do_sys_read fs/read_write.c:623 [inline]
 __se_sys_read fs/read_write.c:621 [inline]
 __x64_sys_read+0x93/0xd0 fs/read_write.c:621
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Uninit was stored to memory at:
 _copy_to_iter+0xc9e/0x1d00 lib/iov_iter.c:536
 copy_page_to_iter+0x46e/0x920 lib/iov_iter.c:742
 shmem_file_read_iter+0xac2/0x1310 mm/shmem.c:2696
 do_iter_read+0xd0a/0x1340 fs/read_write.c:795
 vfs_iter_read+0x88/0xe0 fs/read_write.c:837
 lo_read_simple drivers/block/loop.c:290 [inline]
 do_req_filebacked drivers/block/loop.c:500 [inline]
 loop_handle_cmd drivers/block/loop.c:1888 [inline]
 loop_process_work+0x12c9/0x3990 drivers/block/loop.c:1923
 loop_rootcg_workfn+0x2b/0x30 drivers/block/loop.c:1954
 process_one_work+0xb0d/0x1410 kernel/workqueue.c:2405
 worker_thread+0x107e/0x1d60 kernel/workqueue.c:2552
 kthread+0x3e8/0x540 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

Uninit was stored to memory at:
 memcpy_from_iter lib/iov_iter.c:639 [inline]
 copy_page_from_iter_atomic+0x1271/0x26d0 lib/iov_iter.c:872
 generic_perform_write+0x4a2/0xbb0 mm/filemap.c:3931
 __generic_file_write_iter+0x393/0x920 mm/filemap.c:4051
 generic_file_write_iter+0x103/0x5b0 mm/filemap.c:4083
 do_iter_write+0x605/0x1310 fs/read_write.c:860
 vfs_iter_write+0x88/0xe0 fs/read_write.c:901
 lo_write_bvec drivers/block/loop.c:249 [inline]
 lo_write_simple drivers/block/loop.c:271 [inline]
 do_req_filebacked drivers/block/loop.c:495 [inline]
 loop_handle_cmd drivers/block/loop.c:1888 [inline]
 loop_process_work+0x206d/0x3990 drivers/block/loop.c:1923
 loop_workfn+0x48/0x60 drivers/block/loop.c:1947
 process_one_work+0xb0d/0x1410 kernel/workqueue.c:2405
 worker_thread+0x107e/0x1d60 kernel/workqueue.c:2552
 kthread+0x3e8/0x540 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

Uninit was stored to memory at:
 copy_to_dinode+0x88d/0xb40 fs/jfs/jfs_imap.c:3148
 diWrite+0x1bf0/0x1f00 fs/jfs/jfs_imap.c:786
 txCommit+0xe52/0x8f40 fs/jfs/jfs_txnmgr.c:1250
 __jfs_xattr_set+0x1b3/0x1f0 fs/jfs/xattr.c:919
 jfs_xattr_set+0x79/0x90 fs/jfs/xattr.c:941
 __vfs_setxattr+0x7aa/0x8b0 fs/xattr.c:201
 __vfs_setxattr_noperm+0x24f/0xa30 fs/xattr.c:235
 __vfs_setxattr_locked+0x441/0x480 fs/xattr.c:296
 vfs_setxattr+0x294/0x650 fs/xattr.c:322
 do_setxattr fs/xattr.c:630 [inline]
 setxattr+0x45f/0x540 fs/xattr.c:653
 __do_sys_fsetxattr fs/xattr.c:709 [inline]
 __se_sys_fsetxattr+0x2bb/0x420 fs/xattr.c:698
 __ia32_sys_fsetxattr+0xe3/0x150 fs/xattr.c:698
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x37/0x80 arch/x86/entry/common.c:203
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:246
 entry_SYSENTER_compat_after_hwframe+0x70/0x82

Uninit was stored to memory at:
 ea_put fs/jfs/xattr.c:637 [inline]
 __jfs_setxattr+0x1877/0x1b90 fs/jfs/xattr.c:783
 __jfs_xattr_set+0xe6/0x1f0 fs/jfs/xattr.c:917
 jfs_xattr_set+0x79/0x90 fs/jfs/xattr.c:941
 __vfs_setxattr+0x7aa/0x8b0 fs/xattr.c:201
 __vfs_setxattr_noperm+0x24f/0xa30 fs/xattr.c:235
 __vfs_setxattr_locked+0x441/0x480 fs/xattr.c:296
 vfs_setxattr+0x294/0x650 fs/xattr.c:322
 do_setxattr fs/xattr.c:630 [inline]
 setxattr+0x45f/0x540 fs/xattr.c:653
 __do_sys_fsetxattr fs/xattr.c:709 [inline]
 __se_sys_fsetxattr+0x2bb/0x420 fs/xattr.c:698
 __ia32_sys_fsetxattr+0xe3/0x150 fs/xattr.c:698
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x37/0x80 arch/x86/entry/common.c:203
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:246
 entry_SYSENTER_compat_after_hwframe+0x70/0x82

Local variable ea_buf created at:
 __jfs_setxattr+0x5d/0x1b90 fs/jfs/xattr.c:660
 __jfs_xattr_set+0xe6/0x1f0 fs/jfs/xattr.c:917

Bytes 3689-3691 of 4096 are uninitialized
Memory access of size 4096 starts at ffff88815f2ee000
Data copied to user address 000055a672e8dc78

CPU: 1 PID: 7649 Comm: udevd Not tainted 6.4.0-rc6-syzkaller-g7cccf3be6dcb #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
