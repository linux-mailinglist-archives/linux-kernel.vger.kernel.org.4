Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43EF6618B11
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 23:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbiKCWCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 18:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbiKCWCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 18:02:47 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C023022528
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 15:02:45 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id h6-20020a92c266000000b00300624bf414so2567376ild.14
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 15:02:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GVARKb7zF83xm+IZ/oAc3ebiPFtdApDZn5ViNG7PZuU=;
        b=RhPXjBpul8gAgdybBKYdcPFuXpafxsuAWrwS8y9rn0Cp2EiywtVg70LvLyW2t0ekcq
         2WfGDQ/zoDPDnFkBzfpxl3dsVDKkq4J0TCyiNetwtYqZuj8yQ5V2Tinq2uajeEZAUy5a
         kaoslUA/0EQB6FITbhSvGX9SYSMPeFX+52B7g3j2nSrG3H+cT9STv4AeDk6FREFrtAmW
         RsdPsMoRwhs+aUMYSi+SRjQXGL1nrIUPYMaWx5vmMfwAGIOx5kTdQhwd28IaXPHI10e0
         A9Q6w7rudV3QYbm5ikyUraPHB/FCahNayxoSG1YNqwYmd4pbdn29yEZlczLxFD82vSji
         l6oA==
X-Gm-Message-State: ACrzQf1NxsHenoQYuWj0xOI3eiph9vhNNyIRKwToGMM0KoJb+CuQwDVT
        irCfwJ69U/KxauDtN7Q14oWHnJO04bhPDFIB2Iz0HO9WwM3K
X-Google-Smtp-Source: AMsMyM5dk0ij5Ze9fjmvR02E92/3zeBKTNYXcghNYFbR+40i5JMZdsJ2Er+gkWH9V3w6OksQ6/Nmy32mtRdbJ6bnG0u8NZm+TcGK
MIME-Version: 1.0
X-Received: by 2002:a05:6602:378a:b0:6d3:a804:7912 with SMTP id
 be10-20020a056602378a00b006d3a8047912mr8757189iob.25.1667512965154; Thu, 03
 Nov 2022 15:02:45 -0700 (PDT)
Date:   Thu, 03 Nov 2022 15:02:45 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f250a605ec981d41@google.com>
Subject: [syzbot] possible deadlock in mnt_want_write_file
From:   syzbot <syzbot+1047e42179f502f2b0a2@syzkaller.appspotmail.com>
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

HEAD commit:    f2f32f8af2b0 Merge tag 'for-6.1-rc3-tag' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=164d52ca880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f7e100ed8aaa828e
dashboard link: https://syzkaller.appspot.com/bug?extid=1047e42179f502f2b0a2
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ea126f52b953/disk-f2f32f8a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/815b36048854/vmlinux-f2f32f8a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b7d04bb936fd/bzImage-f2f32f8a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1047e42179f502f2b0a2@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.1.0-rc3-syzkaller-00152-gf2f32f8af2b0 #0 Not tainted
------------------------------------------------------
syz-executor.3/17174 is trying to acquire lock:
ffff88807eba6460 (sb_writers#30){.+.+}-{0:0}, at: mnt_want_write_file+0x5a/0x1f0 fs/namespace.c:437

but task is already holding lock:
ffff88804aba9090 (&sbi->lock){+.+.}-{3:3}, at: reiserfs_write_lock+0x77/0xd0 fs/reiserfs/lock.c:27

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&sbi->lock){+.+.}-{3:3}:
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
       __mutex_lock_common+0x1bd/0x26e0 kernel/locking/mutex.c:603
       __mutex_lock kernel/locking/mutex.c:747 [inline]
       mutex_lock_nested+0x17/0x20 kernel/locking/mutex.c:799
       reiserfs_write_lock+0x77/0xd0 fs/reiserfs/lock.c:27
       reiserfs_lookup+0x147/0x490 fs/reiserfs/namei.c:364
       __lookup_hash+0x115/0x240 fs/namei.c:1601
       filename_create+0x25f/0x4f0 fs/namei.c:3807
       do_mkdirat+0xb5/0x550 fs/namei.c:4050
       __do_sys_mkdirat fs/namei.c:4075 [inline]
       __se_sys_mkdirat fs/namei.c:4073 [inline]
       __x64_sys_mkdirat+0x85/0x90 fs/namei.c:4073
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #1 (&type->i_mutex_dir_key#21/1){+.+.}-{3:3}:
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
       down_write_nested+0xa2/0x280 kernel/locking/rwsem.c:1672
       inode_lock_nested include/linux/fs.h:791 [inline]
       filename_create+0x22a/0x4f0 fs/namei.c:3806
       do_mkdirat+0xb5/0x550 fs/namei.c:4050
       __do_sys_mkdirat fs/namei.c:4075 [inline]
       __se_sys_mkdirat fs/namei.c:4073 [inline]
       __x64_sys_mkdirat+0x85/0x90 fs/namei.c:4073
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (sb_writers#30){.+.+}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3097 [inline]
       check_prevs_add kernel/locking/lockdep.c:3216 [inline]
       validate_chain+0x1898/0x6ae0 kernel/locking/lockdep.c:3831
       __lock_acquire+0x1292/0x1f60 kernel/locking/lockdep.c:5055
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1826 [inline]
       sb_start_write+0x4d/0x1a0 include/linux/fs.h:1901
       mnt_want_write_file+0x5a/0x1f0 fs/namespace.c:437
       reiserfs_ioctl+0x16e/0x340 fs/reiserfs/ioctl.c:103
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:870 [inline]
       __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:856
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

Chain exists of:
  sb_writers#30 --> &type->i_mutex_dir_key#21/1 --> &sbi->lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sbi->lock);
                               lock(&type->i_mutex_dir_key#21/1);
                               lock(&sbi->lock);
  lock(sb_writers#30);

 *** DEADLOCK ***

1 lock held by syz-executor.3/17174:
 #0: ffff88804aba9090 (&sbi->lock){+.+.}-{3:3}, at: reiserfs_write_lock+0x77/0xd0 fs/reiserfs/lock.c:27

stack backtrace:
CPU: 0 PID: 17174 Comm: syz-executor.3 Not tainted 6.1.0-rc3-syzkaller-00152-gf2f32f8af2b0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
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
 percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
 __sb_start_write include/linux/fs.h:1826 [inline]
 sb_start_write+0x4d/0x1a0 include/linux/fs.h:1901
 mnt_want_write_file+0x5a/0x1f0 fs/namespace.c:437
 reiserfs_ioctl+0x16e/0x340 fs/reiserfs/ioctl.c:103
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f7f6ee8b5a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7f6e1de168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f7f6efac050 RCX: 00007f7f6ee8b5a9
RDX: 0000000020000080 RSI: 0000000040087602 RDI: 0000000000000007
RBP: 00007f7f6eee67b0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffdcec8c8df R14: 00007f7f6e1de300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
