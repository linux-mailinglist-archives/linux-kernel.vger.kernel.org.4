Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E106693659
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 08:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjBLHMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 02:12:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjBLHMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 02:12:00 -0500
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23C0126F1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 23:11:56 -0800 (PST)
Received: by mail-io1-f77.google.com with SMTP id g6-20020a6b7606000000b007297c4996c7so6609252iom.13
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 23:11:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zUPtEVM7t9nCmhssBCz2v1DpyQU0s3fiEsKPzMp+Z9w=;
        b=hcuh/wgrtbDEX1iAdqus5c4EgSG4IhDzogHrtQoGXkXD+/HgtaxcHpUL1i/3HtJSrD
         v3avCkfvYFPFC2BK9wCT/yBm2Wd8iEgmDKdsj4IhLlWdgaNUSuhFIQh6KiZ9jo4YNoLB
         3P0zkz2HVUgsi5T3rqhH16Zuth1ua8PZao8TpnT25LZDOztl76qLf6VMf9EFAZGICuPr
         W7LTV6QpAHBhrL3x4aGgDIJnT2eLIZ61pMlILHOo0omr3AKkB4+F3MRwvObHaVp2FLpA
         2Q0fMmPkagvHNnaP8sR+VWaxL+fiZBIDyO0WocglG9oyRI7/3pnrPMu0gOoSo4hxWzy9
         ndrg==
X-Gm-Message-State: AO0yUKXDQnN1fW/2AQa3D4hlowjyBqaC9RFB/hBg9uIDFGnmskk0Dmqp
        LDazXHX6trlCoC/iAJoOKkr51hiRLkRU0Cmp2H/zOxyba9Eglmnd+Q==
X-Google-Smtp-Source: AK7set+AwD/NMLVY9KMs03mbvIXvUcGf9fdJBuIHYh033nb1eHfkgm+qZU/LbXaTZ+dwY8DMIIiO02S1aDquL9hpEkXL/m5oTcCm
MIME-Version: 1.0
X-Received: by 2002:a05:6638:118f:b0:3a9:7683:bf3b with SMTP id
 f15-20020a056638118f00b003a97683bf3bmr12143516jas.101.1676185916117; Sat, 11
 Feb 2023 23:11:56 -0800 (PST)
Date:   Sat, 11 Feb 2023 23:11:56 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001b987605f47b72d3@google.com>
Subject: [syzbot] WARNING: locking bug in take_dentry_name_snapshot
From:   syzbot <syzbot+5a195884ee3ad761db4e@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    38d2b86a665b Add linux-next specific files for 20230208
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11f5e56b480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3691b32dd4410e01
dashboard link: https://syzkaller.appspot.com/bug?extid=5a195884ee3ad761db4e
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0a9d60e90514/disk-38d2b86a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/71311be5f1a1/vmlinux-38d2b86a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a242870cc8eb/bzImage-38d2b86a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5a195884ee3ad761db4e@syzkaller.appspotmail.com

reiserfs: enabling write barrier flush mode
REISERFS (device loop2): Created .reiserfs_priv - reserved for xattr storage.
overlayfs: upper fs needs to support d_type.
overlayfs: upper fs does not support tmpfile.
------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(1)
WARNING: CPU: 1 PID: 5500 at kernel/locking/lockdep.c:232 hlock_class kernel/locking/lockdep.c:232 [inline]
WARNING: CPU: 1 PID: 5500 at kernel/locking/lockdep.c:232 hlock_class kernel/locking/lockdep.c:221 [inline]
WARNING: CPU: 1 PID: 5500 at kernel/locking/lockdep.c:232 check_wait_context kernel/locking/lockdep.c:4746 [inline]
WARNING: CPU: 1 PID: 5500 at kernel/locking/lockdep.c:232 __lock_acquire+0x1664/0x5df0 kernel/locking/lockdep.c:5024
Modules linked in:
CPU: 1 PID: 5500 Comm: syz-executor.2 Not tainted 6.2.0-rc7-next-20230208-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/12/2023
RIP: 0010:hlock_class kernel/locking/lockdep.c:232 [inline]
RIP: 0010:hlock_class kernel/locking/lockdep.c:221 [inline]
RIP: 0010:check_wait_context kernel/locking/lockdep.c:4746 [inline]
RIP: 0010:__lock_acquire+0x1664/0x5df0 kernel/locking/lockdep.c:5024
Code: 08 84 d2 0f 85 8c 3a 00 00 8b 0d 93 4e 10 0d 85 c9 0f 85 33 fb ff ff 48 c7 c6 80 6f 4c 8a 48 c7 c7 c0 63 4c 8a e8 9c 58 e6 ff <0f> 0b 31 ed e9 b3 ed ff ff e8 1e d6 b0 02 85 c0 0f 84 c3 fa ff ff
RSP: 0000:ffffc900059cf7f0 EFLAGS: 00010086
RAX: 0000000000000000 RBX: ffffffff92000c7f RCX: ffffc90005f61000
RDX: 0000000000040000 RSI: ffffffff814bfdd7 RDI: 0000000000000001
RBP: 0000000000001100 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 000000002d2d2d2d R12: ffff888028100ab0
R13: ffff888028100000 R14: 0000000000040000 R15: 0000000000041100
FS:  00007f8fab92e700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000200de030 CR3: 00000000717c5000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lock_acquire.part.0+0x11c/0x370 kernel/locking/lockdep.c:5691
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:350 [inline]
 take_dentry_name_snapshot+0x2b/0x170 fs/dcache.c:315
 ovl_check_rename_whiteout fs/overlayfs/super.c:1207 [inline]
 ovl_make_workdir fs/overlayfs/super.c:1329 [inline]
 ovl_get_workdir fs/overlayfs/super.c:1444 [inline]
 ovl_fill_super+0x2090/0x7270 fs/overlayfs/super.c:2000
 mount_nodev+0x64/0x120 fs/super.c:1418
 legacy_get_tree+0x109/0x220 fs/fs_context.c:610
 vfs_get_tree+0x8d/0x350 fs/super.c:1502
 do_new_mount fs/namespace.c:3042 [inline]
 path_mount+0x1342/0x1e40 fs/namespace.c:3372
 do_mount fs/namespace.c:3385 [inline]
 __do_sys_mount fs/namespace.c:3594 [inline]
 __se_sys_mount fs/namespace.c:3571 [inline]
 __x64_sys_mount+0x283/0x300 fs/namespace.c:3571
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f8faac8c0f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8fab92e168 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f8faadabf80 RCX: 00007f8faac8c0f9
RDX: 0000000020000080 RSI: 0000000020000040 RDI: 0000000000000000
RBP: 00007f8faace7ae9 R08: 0000000020000480 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff1f6e324f R14: 00007f8fab92e300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
