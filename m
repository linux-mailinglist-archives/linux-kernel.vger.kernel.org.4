Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D354655A17
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 13:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbiLXMOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 07:14:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiLXMOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 07:14:45 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145FDF5B2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 04:14:43 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id a13-20020a056e0208ad00b003034c36b8b5so4072507ilt.9
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 04:14:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vqc9f9Vxv70dQk8xOQ5SSQ0P940FUSAHcOuYAro0kSo=;
        b=klmNS1+EdVZdu71N/fM4/pfcplAwwiIzTYOd+36igllGw0n8xYx3GJr9ahWGWiH3Ob
         mC3CpiNfeEWqs7OgHaTcaQR21OKbOvcpz4Edy2tteLL2hFG7wrXwKeRtRk/xY6GPCxjQ
         mJ1LtpMWa/ymJKgJvXEKIKzdBv5Sj8wocjohWD91WPC/kTkWvPq+8ha7uiRAN8v6rFu1
         igSCzO3X6FQrhzmVB5ud6zYB/pF+TVno6lrX5TPC8dQF52XCVDU3ETGxSFkOsvsHILoY
         hkysIiYIAvRxBH+kEcrGdpHYmClhw19Vws0usnM3VYQlFVnp9LMX7Oj0GZ32aJYFUNzw
         0O7A==
X-Gm-Message-State: AFqh2kqUa1Hhz3NnyHTjfm5ElPAREFZun33Nir6pLDIg2k9+XZIs9OUk
        SrQKLBEq6XaUOl9vcjNX5piGJC/4sFMn9TiULSlCRSJUiRaz
X-Google-Smtp-Source: AMrXdXs1Fd25NFn5XSnYwA3RHO7oTMCDkicCx3NpaO6GG0Q0ZWmwTsBDgDdY0cCzL0qPesNPVhRneUzr+5Qb9xO/3sPB56gwCavD
MIME-Version: 1.0
X-Received: by 2002:a02:cb10:0:b0:363:b3c4:5c47 with SMTP id
 j16-20020a02cb10000000b00363b3c45c47mr1015182jap.237.1671884082422; Sat, 24
 Dec 2022 04:14:42 -0800 (PST)
Date:   Sat, 24 Dec 2022 04:14:42 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d6ae9205f091d8d7@google.com>
Subject: [syzbot] [reiserfs?] possible deadlock in iterate_dir
From:   syzbot <syzbot+435320768a3c52aa94b6@syzkaller.appspotmail.com>
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

HEAD commit:    6feb57c2fd7c Merge tag 'kbuild-v6.2' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1012ba27880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8ca07260bb631fb4
dashboard link: https://syzkaller.appspot.com/bug?extid=435320768a3c52aa94b6
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9ebad0b8683b/disk-6feb57c2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/18fd8f90d2d6/vmlinux-6feb57c2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/841ab00c6df1/bzImage-6feb57c2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+435320768a3c52aa94b6@syzkaller.appspotmail.com

REISERFS (device loop4): Using r5 hash to sort names
REISERFS (device loop4): Created .reiserfs_priv - reserved for xattr storage.
======================================================
WARNING: possible circular locking dependency detected
6.1.0-syzkaller-13822-g6feb57c2fd7c #0 Not tainted
------------------------------------------------------
syz-executor.4/9537 is trying to acquire lock:
ffff8880767ab090 (&sbi->lock){+.+.}-{3:3}, at: reiserfs_write_lock+0x79/0x100 fs/reiserfs/lock.c:27

but task is already holding lock:
ffff88801d266460 (sb_writers#19){.+.+}-{0:0}, at: file_accessed include/linux/fs.h:2516 [inline]
ffff88801d266460 (sb_writers#19){.+.+}-{0:0}, at: iterate_dir+0x45d/0x6f0 fs/readdir.c:70

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (sb_writers#19){.+.+}-{0:0}:
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1811 [inline]
       sb_start_write include/linux/fs.h:1886 [inline]
       mnt_want_write_file+0x92/0x590 fs/namespace.c:552
       reiserfs_ioctl+0x1a2/0x330 fs/reiserfs/ioctl.c:103
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:870 [inline]
       __se_sys_ioctl fs/ioctl.c:856 [inline]
       __x64_sys_ioctl+0x197/0x210 fs/ioctl.c:856
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
       reiserfs_dirty_inode+0xd2/0x260 fs/reiserfs/super.c:704
       __mark_inode_dirty+0x247/0x11e0 fs/fs-writeback.c:2419
       generic_update_time fs/inode.c:1859 [inline]
       inode_update_time fs/inode.c:1872 [inline]
       touch_atime+0x641/0x700 fs/inode.c:1944
       file_accessed include/linux/fs.h:2516 [inline]
       iterate_dir+0x45d/0x6f0 fs/readdir.c:70
       __do_sys_getdents fs/readdir.c:286 [inline]
       __se_sys_getdents fs/readdir.c:271 [inline]
       __x64_sys_getdents+0x13e/0x2c0 fs/readdir.c:271
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(sb_writers#19);
                               lock(&sbi->lock);
                               lock(sb_writers#19);
  lock(&sbi->lock);

 *** DEADLOCK ***

3 locks held by syz-executor.4/9537:
 #0: ffff88801d6b6fe8 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe7/0x100 fs/file.c:1046
 #1: ffff888031b80980 (&type->i_mutex_dir_key#13){++++}-{3:3}, at: iterate_dir+0xd1/0x6f0 fs/readdir.c:55
 #2: ffff88801d266460 (sb_writers#19){.+.+}-{0:0}, at: file_accessed include/linux/fs.h:2516 [inline]
 #2: ffff88801d266460 (sb_writers#19){.+.+}-{0:0}, at: iterate_dir+0x45d/0x6f0 fs/readdir.c:70

stack backtrace:
CPU: 0 PID: 9537 Comm: syz-executor.4 Not tainted 6.1.0-syzkaller-13822-g6feb57c2fd7c #0
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
 reiserfs_dirty_inode+0xd2/0x260 fs/reiserfs/super.c:704
 __mark_inode_dirty+0x247/0x11e0 fs/fs-writeback.c:2419
 generic_update_time fs/inode.c:1859 [inline]
 inode_update_time fs/inode.c:1872 [inline]
 touch_atime+0x641/0x700 fs/inode.c:1944
 file_accessed include/linux/fs.h:2516 [inline]
 iterate_dir+0x45d/0x6f0 fs/readdir.c:70
 __do_sys_getdents fs/readdir.c:286 [inline]
 __se_sys_getdents fs/readdir.c:271 [inline]
 __x64_sys_getdents+0x13e/0x2c0 fs/readdir.c:271
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f93e5e8c0d9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f93e6baa168 EFLAGS: 00000246 ORIG_RAX: 000000000000004e
RAX: ffffffffffffffda RBX: 00007f93e5fabf80 RCX: 00007f93e5e8c0d9
RDX: 0000000000000072 RSI: 0000000020000000 RDI: 0000000000000004
RBP: 00007f93e5ee7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff02abfe4f R14: 00007f93e6baa300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
