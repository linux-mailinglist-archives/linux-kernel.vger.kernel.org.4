Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B25A6BCD48
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 11:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjCPKwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 06:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjCPKvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 06:51:53 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9153D4C26
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 03:51:51 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id u23-20020a6be917000000b007532ab65c70so551555iof.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 03:51:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678963910;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wlZsmgoHP0KFVkPcMplNL5BB8+emSwJ8ox1cxUzm6Ho=;
        b=1BYhHpQwI7LBz48NP8wM/b5rxGj0s0fJt4PCq0oXRO683UbxU5A8XYP4l9SLdiJa50
         Btc24pkKWM/rjfcvSoh6MUod0sZ2vnVsbQvuFXbZ1U2aSx5W2FpdT3S0mgNXsD2MiCRr
         cRuRLCUl69+qMaj3bN/D2SfN6J8ZGkX3vN+XIh9+IdoLjVfT61ui4BaEOa7eX0EgCSX9
         o2v8X0w2dqdtv8Y9pYse8Qxn33zi+/2LEBHJL6NjKc5Fc0WDZpZtllv27SLrUMs8ruIE
         WVYYTvp6w/RqbQPsqxR1lpiStZESrImaDUw45/huVA5pWyXTlNfR2O9VQ7dQuDt9HLlC
         gjQg==
X-Gm-Message-State: AO0yUKVyMdYD7+zDA9Pc1QzY5t9abId4UcVHstetPl8FJkfR9Ynz+b8u
        P44SqUTdnot6h2GsXIDE11QvtnvI73oRGGBvfrXRZS2LNnw3
X-Google-Smtp-Source: AK7set8qR157/5/BdoPXi2VFvXhsr1z8JFosdJN4laZIpbD1DOFpXUsH3JegSIZkzTJWJnhJppa7+trIn0f1qlEK/m+iFbmGMnjF
MIME-Version: 1.0
X-Received: by 2002:a92:da48:0:b0:314:24e2:5189 with SMTP id
 p8-20020a92da48000000b0031424e25189mr4675569ilq.0.1678963910794; Thu, 16 Mar
 2023 03:51:50 -0700 (PDT)
Date:   Thu, 16 Mar 2023 03:51:50 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007e653f05f7023f88@google.com>
Subject: [syzbot] [ext4?] WARNING: bad unlock balance in ext4_rename
From:   syzbot <syzbot+636aeec054650b49a379@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
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

HEAD commit:    9c1bec9c0b08 Merge tag 'linux-kselftest-fixes-6.3-rc3' of ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12d6a556c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6c84f77790aba2eb
dashboard link: https://syzkaller.appspot.com/bug?extid=636aeec054650b49a379
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e27b04dd32d0/disk-9c1bec9c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7b5061fb1ef2/vmlinux-9c1bec9c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f36752323820/bzImage-9c1bec9c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+636aeec054650b49a379@syzkaller.appspotmail.com

ext4 filesystem being mounted at /root/syzkaller-testdir1527489572/syzkaller.Uw8Ert/4184/file0 supports timestamps until 2038 (0x7fffffff)
EXT4-fs error (device loop4): ext4_get_first_dir_block:3520: inode #12: block 32: comm syz-executor.4: bad entry in directory: rec_len is smaller than minimal - offset=0, inode=67174412, rec_len=0, size=2048 fake=1
EXT4-fs error (device loop4): ext4_get_first_dir_block:3524: inode #12: comm syz-executor.4: directory missing '.'
=====================================
WARNING: bad unlock balance detected!
6.3.0-rc2-syzkaller-00050-g9c1bec9c0b08 #0 Not tainted
-------------------------------------
syz-executor.4/25678 is trying to release lock (&type->i_mutex_dir_key) at:
[<ffffffff8230b319>] inode_unlock include/linux/fs.h:763 [inline]
[<ffffffff8230b319>] ext4_rename+0x569/0x27c0 fs/ext4/namei.c:4029
but there are no more locks to release!

other info that might help us debug this:
2 locks held by syz-executor.4/25678:
 #0: ffff88807a162460 (sb_writers#4){.+.+}-{0:0}, at: do_renameat2+0x37f/0xc90 fs/namei.c:4859
 #1: ffff888084013628 (&type->i_mutex_dir_key#3/1){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:793 [inline]
 #1: ffff888084013628 (&type->i_mutex_dir_key#3/1){+.+.}-{3:3}, at: lock_rename+0x229/0x280 fs/namei.c:2991

stack backtrace:
CPU: 0 PID: 25678 Comm: syz-executor.4 Not tainted 6.3.0-rc2-syzkaller-00050-g9c1bec9c0b08 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 __lock_release kernel/locking/lockdep.c:5346 [inline]
 lock_release+0x4f1/0x670 kernel/locking/lockdep.c:5689
 up_write+0x2a/0x520 kernel/locking/rwsem.c:1625
 inode_unlock include/linux/fs.h:763 [inline]
 ext4_rename+0x569/0x27c0 fs/ext4/namei.c:4029
 ext4_rename2+0x1c7/0x270 fs/ext4/namei.c:4202
 vfs_rename+0xef6/0x17a0 fs/namei.c:4772
 do_renameat2+0xb62/0xc90 fs/namei.c:4923
 __do_sys_renameat2 fs/namei.c:4956 [inline]
 __se_sys_renameat2 fs/namei.c:4953 [inline]
 __x64_sys_renameat2+0xe8/0x120 fs/namei.c:4953
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f762388c0f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7624588168 EFLAGS: 00000246 ORIG_RAX: 000000000000013c
RAX: ffffffffffffffda RBX: 00007f76239abf80 RCX: 00007f762388c0f9
RDX: 0000000000000004 RSI: 00000000200001c0 RDI: 0000000000000004
RBP: 00007f76238e7b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000020000200 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd99195a8f R14: 00007f7624588300 R15: 0000000000022000
 </TASK>
------------[ cut here ]------------
DEBUG_RWSEMS_WARN_ON((rwsem_owner(sem) != current) && !rwsem_test_oflags(sem, RWSEM_NONSPINNABLE)): count = 0x0, magic = 0xffff8880870a0390, owner = 0x0, curr 0xffff88802506ba80, list empty
WARNING: CPU: 1 PID: 25678 at kernel/locking/rwsem.c:1369 __up_write kernel/locking/rwsem.c:1369 [inline]
WARNING: CPU: 1 PID: 25678 at kernel/locking/rwsem.c:1369 up_write+0x425/0x520 kernel/locking/rwsem.c:1626
Modules linked in:
CPU: 1 PID: 25678 Comm: syz-executor.4 Not tainted 6.3.0-rc2-syzkaller-00050-g9c1bec9c0b08 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
RIP: 0010:__up_write kernel/locking/rwsem.c:1369 [inline]
RIP: 0010:up_write+0x425/0x520 kernel/locking/rwsem.c:1626
Code: 3c 02 00 0f 85 da 00 00 00 48 8b 55 00 4d 89 f1 53 4d 89 f8 4c 89 e9 48 c7 c6 60 51 4c 8a 48 c7 c7 00 50 4c 8a e8 7b 1b e8 ff <0f> 0b 59 e9 dd fc ff ff 48 89 df e8 eb aa 70 00 e9 1a fc ff ff 48
RSP: 0018:ffffc9000319f9a0 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffffffff8a4c4f40 RCX: ffffc9000c5aa000
RDX: 0000000000040000 RSI: ffffffff814b6037 RDI: 0000000000000001
RBP: ffff8880870a0390 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 57525f4755424544 R12: ffff8880870a0398
R13: ffff8880870a0390 R14: ffff88802506ba80 R15: 0000000000000000
FS:  00007f7624588700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020526000 CR3: 000000001cfeb000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 inode_unlock include/linux/fs.h:763 [inline]
 ext4_rename+0x569/0x27c0 fs/ext4/namei.c:4029
 ext4_rename2+0x1c7/0x270 fs/ext4/namei.c:4202
 vfs_rename+0xef6/0x17a0 fs/namei.c:4772
 do_renameat2+0xb62/0xc90 fs/namei.c:4923
 __do_sys_renameat2 fs/namei.c:4956 [inline]
 __se_sys_renameat2 fs/namei.c:4953 [inline]
 __x64_sys_renameat2+0xe8/0x120 fs/namei.c:4953
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f762388c0f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7624588168 EFLAGS: 00000246 ORIG_RAX: 000000000000013c
RAX: ffffffffffffffda RBX: 00007f76239abf80 RCX: 00007f762388c0f9
RDX: 0000000000000004 RSI: 00000000200001c0 RDI: 0000000000000004
RBP: 00007f76238e7b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000020000200 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd99195a8f R14: 00007f7624588300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
