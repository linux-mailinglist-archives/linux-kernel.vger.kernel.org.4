Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE63465A35D
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 10:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbiLaJam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 04:30:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiLaJak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 04:30:40 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C349DECA
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 01:30:39 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id s22-20020a6bdc16000000b006e2d7c78010so7032826ioc.21
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 01:30:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ffGl+WxU+tblGo+bWMzEOKa8UNXKtH4WBKL6LgGNwKg=;
        b=dpdB8FxRnDccDNEnEo0m7TOMqCAPxTYQelSOQk7DMDnA/uxW6pe4t+4RWJyb+SdbRL
         xj1+xlPcmqg61cUr49PyJISkDZXsn15FMpKecqp3Ojsui0kjLSqWnag3+YksvQi3qSLQ
         KmJ6ju1zFAGyrnhhZm4vCTOInvLbBLs+NanXwm659JDh8vOyUwXpJ93wwk8emdUbAdvA
         Gh1KC8QAV6j8vNDppA1Xs046HGhDtiItCDTZO+ZLh/bzBLWJBvPDqASIXyhY/lSwoCUr
         YUA2HyRylk2POUPONB6+SfDVvIzX5Gzpbr7RNzem5bDkqSHTbm3Fk3uxnGdyjRJ172rS
         mi8w==
X-Gm-Message-State: AFqh2kr4VpuAFjYx2zH5AsWpfg8BYa/u0E414kEibOVFB+yia7EuG+QF
        SPvAH8Yf9sbJtJqxAOCKzsZgsF+X++nL0ypz1SvYgxZoWKde
X-Google-Smtp-Source: AMrXdXsgKiJyrvKp4c2xREuWsViOkCBeNlF1gvvRjuAE6ErZ1F8PbXrnaOg9mjJ7bsEFFrCbOzy6tjURtC6u7ekmAzEBcl6J2Q5C
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1206:b0:304:bf1f:d72c with SMTP id
 a6-20020a056e02120600b00304bf1fd72cmr3007491ilq.69.1672479038993; Sat, 31 Dec
 2022 01:30:38 -0800 (PST)
Date:   Sat, 31 Dec 2022 01:30:38 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000037f2205f11c5fde@google.com>
Subject: [syzbot] [reiserfs?] possible deadlock in vfs_setxattr
From:   syzbot <syzbot+2c493ef16c1927e777f8@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=11fc3d44480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=555d27e379d75ff1
dashboard link: https://syzkaller.appspot.com/bug?extid=2c493ef16c1927e777f8
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2824225be62b/disk-1b929c02.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ff607a05be90/vmlinux-1b929c02.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c0b523d63d64/bzImage-1b929c02.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2c493ef16c1927e777f8@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.2.0-rc1-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor.2/20058 is trying to acquire lock:
ffff88809c454bc0 (&type->i_mutex_dir_key#13){++++}-{3:3}, at: inode_lock include/linux/fs.h:756 [inline]
ffff88809c454bc0 (&type->i_mutex_dir_key#13){++++}-{3:3}, at: vfs_setxattr+0x1e8/0x450 fs/xattr.c:322

but task is already holding lock:
ffff8880238a0460 (sb_writers#25){.+.+}-{0:0}, at: mnt_want_write+0x3b/0x80 fs/namespace.c:508

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (sb_writers#25){.+.+}-{0:0}:
       lock_acquire+0x1a7/0x400 kernel/locking/lockdep.c:5668
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1811 [inline]
       sb_start_write+0x4d/0x1a0 include/linux/fs.h:1886
       mnt_want_write_file+0x5a/0x1f0 fs/namespace.c:552
       reiserfs_ioctl+0x16e/0x340 fs/reiserfs/ioctl.c:103
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:870 [inline]
       __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:856
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #1 (&sbi->lock){+.+.}-{3:3}:
       lock_acquire+0x1a7/0x400 kernel/locking/lockdep.c:5668
       __mutex_lock_common+0x1de/0x26c0 kernel/locking/mutex.c:603
       __mutex_lock kernel/locking/mutex.c:747 [inline]
       mutex_lock_nested+0x17/0x20 kernel/locking/mutex.c:799
       reiserfs_write_lock+0x77/0xd0 fs/reiserfs/lock.c:27
       reiserfs_lookup+0x15a/0x4a0 fs/reiserfs/namei.c:364
       __lookup_slow+0x286/0x3e0 fs/namei.c:1685
       lookup_one_len+0x430/0x690 fs/namei.c:2711
       reiserfs_lookup_privroot+0x85/0x1e0 fs/reiserfs/xattr.c:973
       reiserfs_fill_super+0x1964/0x2620 fs/reiserfs/super.c:2192
       mount_bdev+0x26c/0x3a0 fs/super.c:1359
       legacy_get_tree+0xea/0x180 fs/fs_context.c:610
       vfs_get_tree+0x88/0x270 fs/super.c:1489
       do_new_mount+0x289/0xad0 fs/namespace.c:3145
       do_mount fs/namespace.c:3488 [inline]
       __do_sys_mount fs/namespace.c:3697 [inline]
       __se_sys_mount+0x2e3/0x3d0 fs/namespace.c:3674
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (&type->i_mutex_dir_key#13){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3097 [inline]
       check_prevs_add kernel/locking/lockdep.c:3216 [inline]
       validate_chain+0x184a/0x6470 kernel/locking/lockdep.c:3831
       __lock_acquire+0x1292/0x1f60 kernel/locking/lockdep.c:5055
       lock_acquire+0x1a7/0x400 kernel/locking/lockdep.c:5668
       down_write+0x9c/0x270 kernel/locking/rwsem.c:1562
       inode_lock include/linux/fs.h:756 [inline]
       vfs_setxattr+0x1e8/0x450 fs/xattr.c:322
       do_setxattr fs/xattr.c:608 [inline]
       setxattr fs/xattr.c:631 [inline]
       path_setxattr+0x393/0x4c0 fs/xattr.c:650
       __do_sys_setxattr fs/xattr.c:666 [inline]
       __se_sys_setxattr fs/xattr.c:662 [inline]
       __x64_sys_setxattr+0xb7/0xd0 fs/xattr.c:662
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

Chain exists of:
  &type->i_mutex_dir_key#13 --> &sbi->lock --> sb_writers#25

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(sb_writers#25);
                               lock(&sbi->lock);
                               lock(sb_writers#25);
  lock(&type->i_mutex_dir_key#13);

 *** DEADLOCK ***

1 lock held by syz-executor.2/20058:
 #0: ffff8880238a0460 (sb_writers#25){.+.+}-{0:0}, at: mnt_want_write+0x3b/0x80 fs/namespace.c:508

stack backtrace:
CPU: 1 PID: 20058 Comm: syz-executor.2 Not tainted 6.2.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e3/0x2d0 lib/dump_stack.c:106
 check_noncircular+0x2f9/0x3b0 kernel/locking/lockdep.c:2177
 check_prev_add kernel/locking/lockdep.c:3097 [inline]
 check_prevs_add kernel/locking/lockdep.c:3216 [inline]
 validate_chain+0x184a/0x6470 kernel/locking/lockdep.c:3831
 __lock_acquire+0x1292/0x1f60 kernel/locking/lockdep.c:5055
 lock_acquire+0x1a7/0x400 kernel/locking/lockdep.c:5668
 down_write+0x9c/0x270 kernel/locking/rwsem.c:1562
 inode_lock include/linux/fs.h:756 [inline]
 vfs_setxattr+0x1e8/0x450 fs/xattr.c:322
 do_setxattr fs/xattr.c:608 [inline]
 setxattr fs/xattr.c:631 [inline]
 path_setxattr+0x393/0x4c0 fs/xattr.c:650
 __do_sys_setxattr fs/xattr.c:666 [inline]
 __se_sys_setxattr fs/xattr.c:662 [inline]
 __x64_sys_setxattr+0xb7/0xd0 fs/xattr.c:662
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f153aa8c0a9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f153139b168 EFLAGS: 00000246 ORIG_RAX: 00000000000000bc
RAX: ffffffffffffffda RBX: 00007f153abac1f0 RCX: 00007f153aa8c0a9
RDX: 0000000020000280 RSI: 0000000020000240 RDI: 0000000020000200
RBP: 00007f153aae7ae9 R08: 0000000000000002 R09: 0000000000000000
R10: 000000000000010c R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe487bc7ef R14: 00007f153139b300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
