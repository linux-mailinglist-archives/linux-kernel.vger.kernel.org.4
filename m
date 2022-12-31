Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA7365A2EC
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 07:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiLaGfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 01:35:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiLaGfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 01:35:46 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD72B2E
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 22:35:45 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id h24-20020a056e021d9800b0030be8a5dd68so13047457ila.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 22:35:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=juCe1TqFqm+iTsVLwe+XNJ8x9hxbrFPkYvFM/A4+eRI=;
        b=klHnxXOT6zqjcgvVwvQFc4tXS+Ct9bFAHcH4XRMZwsym6NvizoaEF6qNcTp6jOdhQD
         Bu6djbBGPaX4vPphGepuxxN0nYpwIWBvD6+nu5g9m7IB43U1Px9mJxZFGHsSRZcg4IBX
         1LRebmPuq1MBaQJv8tjTO84O+2rZ25ianT9zFPjk4oLCqybScVnimFcsC2GuU1uchJMA
         c4I6TQoYlSsgNeRFn8KnfESgkW92FFnlqhA9EGAW7aIOosj4FEy7SPbnNMTK0XMjoqy1
         0DofEy61L0hRJ4gGVjptSF9oQs41uK8dQqfRzzY6/eKNpblOvV2l2yfJzJlBDdTg7niZ
         ie/w==
X-Gm-Message-State: AFqh2kpNbqoVWOgkwDNNuyqGgmvY9UZFIMrbdsHuN8TZ3jIUErXoOi4N
        tv0qVAHw5oKjAO6bu3af0rbt46oZoZdqkxLoZD7XXXxSOO88
X-Google-Smtp-Source: AMrXdXspXSzbT+gQDj7Qd5Khlj+K5nqAr4AEJSVD8sXgJDwYI/euVoIEtaO8OPYryXcbt+ZPEilCtI3ln2W5mPPPeZ+6Qo2M+NjI
MIME-Version: 1.0
X-Received: by 2002:a5e:8b4a:0:b0:6e9:d093:8298 with SMTP id
 z10-20020a5e8b4a000000b006e9d0938298mr2477886iom.118.1672468544349; Fri, 30
 Dec 2022 22:35:44 -0800 (PST)
Date:   Fri, 30 Dec 2022 22:35:44 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007bedb605f119ed9f@google.com>
Subject: [syzbot] [reiserfs?] possible deadlock in open_xa_dir
From:   syzbot <syzbot+8fb64a61fdd96b50f3b8@syzkaller.appspotmail.com>
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

HEAD commit:    1b929c02afd3 Linux 6.2-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11da7f8c480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2651619a26b4d687
dashboard link: https://syzkaller.appspot.com/bug?extid=8fb64a61fdd96b50f3b8
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d562ace1a56c/disk-1b929c02.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/39f000fe6b9e/vmlinux-1b929c02.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1c67e48de5a0/bzImage-1b929c02.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8fb64a61fdd96b50f3b8@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.2.0-rc1-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor.1/19784 is trying to acquire lock:
ffff88807d682090 (&sbi->lock){+.+.}-{3:3}, at: reiserfs_write_lock+0x79/0x100 fs/reiserfs/lock.c:27

but task is already holding lock:
ffff8880899d6ce0 (&type->i_mutex_dir_key#9/3){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:791 [inline]
ffff8880899d6ce0 (&type->i_mutex_dir_key#9/3){+.+.}-{3:3}, at: open_xa_root fs/reiserfs/xattr.c:127 [inline]
ffff8880899d6ce0 (&type->i_mutex_dir_key#9/3){+.+.}-{3:3}, at: open_xa_dir+0x127/0x830 fs/reiserfs/xattr.c:152

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&type->i_mutex_dir_key#9/3){+.+.}-{3:3}:
       down_write_nested+0x98/0x220 kernel/locking/rwsem.c:1672
       inode_lock_nested include/linux/fs.h:791 [inline]
       open_xa_root fs/reiserfs/xattr.c:127 [inline]
       open_xa_dir+0x127/0x830 fs/reiserfs/xattr.c:152
       reiserfs_for_each_xattr+0x1ab/0x9a0 fs/reiserfs/xattr.c:252
       reiserfs_delete_xattrs+0x20/0xa0 fs/reiserfs/xattr.c:364
       reiserfs_evict_inode+0x2e7/0x540 fs/reiserfs/inode.c:53
       evict+0x2ed/0x6b0 fs/inode.c:664
       iput_final fs/inode.c:1747 [inline]
       iput.part.0+0x59b/0x880 fs/inode.c:1773
       iput+0x5c/0x80 fs/inode.c:1763
       reiserfs_create+0x65a/0x730 fs/reiserfs/namei.c:688
       vfs_create fs/namei.c:3115 [inline]
       vfs_create+0x3ed/0x670 fs/namei.c:3101
       do_mknodat+0x3c4/0x510 fs/namei.c:3965
       __do_sys_mknod fs/namei.c:3998 [inline]
       __se_sys_mknod fs/namei.c:3996 [inline]
       __x64_sys_mknod+0x11e/0x180 fs/namei.c:3996
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (&sbi->lock){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3097 [inline]
       check_prevs_add kernel/locking/lockdep.c:3216 [inline]
       validate_chain kernel/locking/lockdep.c:3831 [inline]
       __lock_acquire+0x2a43/0x56d0 kernel/locking/lockdep.c:5055
       lock_acquire kernel/locking/lockdep.c:5668 [inline]
       lock_acquire+0x1e3/0x630 kernel/locking/lockdep.c:5633
       __mutex_lock_common kernel/locking/mutex.c:603 [inline]
       __mutex_lock+0x12f/0x1360 kernel/locking/mutex.c:747
       reiserfs_write_lock+0x79/0x100 fs/reiserfs/lock.c:27
       reiserfs_mkdir+0x31c/0x990 fs/reiserfs/namei.c:831
       xattr_mkdir fs/reiserfs/xattr.c:76 [inline]
       open_xa_root fs/reiserfs/xattr.c:136 [inline]
       open_xa_dir+0x6a3/0x830 fs/reiserfs/xattr.c:152
       xattr_lookup+0x21/0x3d0 fs/reiserfs/xattr.c:395
       reiserfs_xattr_set_handle+0xfb/0xb00 fs/reiserfs/xattr.c:533
       reiserfs_xattr_set+0x454/0x5b0 fs/reiserfs/xattr.c:633
       trusted_set+0xa7/0xd0 fs/reiserfs/xattr_trusted.c:31
       __vfs_setxattr+0x173/0x1e0 fs/xattr.c:202
       __vfs_setxattr_noperm+0x129/0x5f0 fs/xattr.c:236
       __vfs_setxattr_locked+0x1d3/0x260 fs/xattr.c:297
       vfs_setxattr+0x143/0x340 fs/xattr.c:323
       do_setxattr+0x151/0x190 fs/xattr.c:608
       setxattr+0x146/0x160 fs/xattr.c:631
       path_setxattr+0x197/0x1c0 fs/xattr.c:650
       __do_sys_setxattr fs/xattr.c:666 [inline]
       __se_sys_setxattr fs/xattr.c:662 [inline]
       __x64_sys_setxattr+0xc4/0x160 fs/xattr.c:662
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&type->i_mutex_dir_key#9/3);
                               lock(&sbi->lock);
                               lock(&type->i_mutex_dir_key#9/3);
  lock(&sbi->lock);

 *** DEADLOCK ***

3 locks held by syz-executor.1/19784:
 #0: ffff88801c7fe460 (sb_writers#17){.+.+}-{0:0}, at: path_setxattr+0xb2/0x1c0 fs/xattr.c:648
 #1: ffff8880899d7a20 (&type->i_mutex_dir_key#9){++++}-{3:3}, at: inode_lock include/linux/fs.h:756 [inline]
 #1: ffff8880899d7a20 (&type->i_mutex_dir_key#9){++++}-{3:3}, at: vfs_setxattr+0x120/0x340 fs/xattr.c:322
 #2: ffff8880899d6ce0 (&type->i_mutex_dir_key#9/3){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:791 [inline]
 #2: ffff8880899d6ce0 (&type->i_mutex_dir_key#9/3){+.+.}-{3:3}, at: open_xa_root fs/reiserfs/xattr.c:127 [inline]
 #2: ffff8880899d6ce0 (&type->i_mutex_dir_key#9/3){+.+.}-{3:3}, at: open_xa_dir+0x127/0x830 fs/reiserfs/xattr.c:152

stack backtrace:
CPU: 1 PID: 19784 Comm: syz-executor.1 Not tainted 6.2.0-rc1-syzkaller #0
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
 __mutex_lock_common kernel/locking/mutex.c:603 [inline]
 __mutex_lock+0x12f/0x1360 kernel/locking/mutex.c:747
 reiserfs_write_lock+0x79/0x100 fs/reiserfs/lock.c:27
 reiserfs_mkdir+0x31c/0x990 fs/reiserfs/namei.c:831
 xattr_mkdir fs/reiserfs/xattr.c:76 [inline]
 open_xa_root fs/reiserfs/xattr.c:136 [inline]
 open_xa_dir+0x6a3/0x830 fs/reiserfs/xattr.c:152
 xattr_lookup+0x21/0x3d0 fs/reiserfs/xattr.c:395
 reiserfs_xattr_set_handle+0xfb/0xb00 fs/reiserfs/xattr.c:533
 reiserfs_xattr_set+0x454/0x5b0 fs/reiserfs/xattr.c:633
 trusted_set+0xa7/0xd0 fs/reiserfs/xattr_trusted.c:31
 __vfs_setxattr+0x173/0x1e0 fs/xattr.c:202
 __vfs_setxattr_noperm+0x129/0x5f0 fs/xattr.c:236
 __vfs_setxattr_locked+0x1d3/0x260 fs/xattr.c:297
 vfs_setxattr+0x143/0x340 fs/xattr.c:323
 do_setxattr+0x151/0x190 fs/xattr.c:608
 setxattr+0x146/0x160 fs/xattr.c:631
 path_setxattr+0x197/0x1c0 fs/xattr.c:650
 __do_sys_setxattr fs/xattr.c:666 [inline]
 __se_sys_setxattr fs/xattr.c:662 [inline]
 __x64_sys_setxattr+0xc4/0x160 fs/xattr.c:662
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fd78168c0a9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd78242a168 EFLAGS: 00000246 ORIG_RAX: 00000000000000bc
RAX: ffffffffffffffda RBX: 00007fd7817abf80 RCX: 00007fd78168c0a9
RDX: 0000000020000440 RSI: 00000000200002c0 RDI: 0000000020000280
RBP: 00007fd7816e7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 000000000000010c R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff9b71513f R14: 00007fd78242a300 R15: 0000000000022000
 </TASK>
REISERFS warning (device loop1): vs-13060 reiserfs_update_sd_size: stat data of object [3 6 0x0 SD] (nlink == 2) not found (pos 5)
REISERFS warning (device loop1): vs-13060 reiserfs_update_sd_size: stat data of object [3 6 0x0 SD] (nlink == 3) not found (pos 3)


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
