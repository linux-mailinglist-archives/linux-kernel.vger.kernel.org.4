Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 797A2645417
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 07:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiLGGiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 01:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiLGGin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 01:38:43 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB7D2BE1
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 22:38:42 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id bf14-20020a056602368e00b006ce86e80414so13025830iob.7
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 22:38:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RXsdEwM6VKjQ3v18RXqjJN8uOxY6ZcgZPa+lfvwNQGA=;
        b=HFmkXNDSx2Tbr1V/XrTw6d2BsfonWby5FwFJ0YICwrTnDzYv6ClQFZsqEmlzijsrFt
         BaOihpjISwOVzQNBDlfbdVC3lChGVjx82dCMYc1FWOqHur7gxNUIVpO3DiD58pmujo4E
         K1FEayPkXdmxOAZQd90r6gqPWjOM44wZZSQnei4K6urx7sew4A2MNYUM7w1j1nAqUf/U
         LFXyreQDduJa1NerGiOg+f6c8n8fYKhBHv3UOLyRjwDdR/YNx4zZrDFEWbmEGHYV5SrK
         O06nXgEBBtuWL8fTzC2Ho0/UrF/pXskOKeE7zn95HaFuZCMz2fQM1GHeu/2FCGzM+Kbq
         hNRg==
X-Gm-Message-State: ANoB5pn1OzbVmF5LKKZBl/v1ba6BBx/pzgy5+s09qh5oE9TgyX3BzqdL
        I7z+fnM4fGf+tvLbbpR2+foAUpO2NKN8EeO27cpKaaqIsQPR
X-Google-Smtp-Source: AA0mqf78nDci7ud65OBetX9jxxwxQeHdvXgDGAh/6cP6FwBvH1KcoKEfciRO03CegBK1KCzmw0wO4Vl7UdODypgVzhSpFckVgQPR
MIME-Version: 1.0
X-Received: by 2002:a02:5403:0:b0:38a:6adf:48d1 with SMTP id
 t3-20020a025403000000b0038a6adf48d1mr752439jaa.24.1670395121812; Tue, 06 Dec
 2022 22:38:41 -0800 (PST)
Date:   Tue, 06 Dec 2022 22:38:41 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000decafe05ef372b92@google.com>
Subject: [syzbot] possible deadlock in ovl_fallocate
From:   syzbot <syzbot+38a94e1872470e3450a6@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
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

HEAD commit:    591cd61541b9 Add linux-next specific files for 20221207
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1509b2f5880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8b2d3e63e054c24f
dashboard link: https://syzkaller.appspot.com/bug?extid=38a94e1872470e3450a6
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bc862c01ec56/disk-591cd615.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8f9b93f8ed2f/vmlinux-591cd615.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9d5cb636d548/bzImage-591cd615.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+38a94e1872470e3450a6@syzkaller.appspotmail.com

============================================
WARNING: possible recursive locking detected
6.1.0-rc8-next-20221207-syzkaller #0 Not tainted
--------------------------------------------
syz-executor.5/21743 is trying to acquire lock:
ffff888058fdd340 (&ovl_i_mutex_key[depth]#2){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:756 [inline]
ffff888058fdd340 (&ovl_i_mutex_key[depth]#2){+.+.}-{3:3}, at: ovl_remove_privs_unlocked fs/overlayfs/file.c:519 [inline]
ffff888058fdd340 (&ovl_i_mutex_key[depth]#2){+.+.}-{3:3}, at: ovl_fallocate+0x15c/0x270 fs/overlayfs/file.c:546

but task is already holding lock:
ffff888058fdd340 (&ovl_i_mutex_key[depth]#2){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:756 [inline]
ffff888058fdd340 (&ovl_i_mutex_key[depth]#2){+.+.}-{3:3}, at: ovl_fallocate+0x9f/0x270 fs/overlayfs/file.c:535

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&ovl_i_mutex_key[depth]#2);
  lock(&ovl_i_mutex_key[depth]#2);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

2 locks held by syz-executor.5/21743:
 #0: ffff88801cc94460 (sb_writers#14){.+.+}-{0:0}, at: ksys_fallocate fs/open.c:346 [inline]
 #0: ffff88801cc94460 (sb_writers#14){.+.+}-{0:0}, at: __do_sys_fallocate fs/open.c:354 [inline]
 #0: ffff88801cc94460 (sb_writers#14){.+.+}-{0:0}, at: __se_sys_fallocate fs/open.c:352 [inline]
 #0: ffff88801cc94460 (sb_writers#14){.+.+}-{0:0}, at: __x64_sys_fallocate+0xd3/0x140 fs/open.c:352
 #1: ffff888058fdd340 (&ovl_i_mutex_key[depth]#2){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:756 [inline]
 #1: ffff888058fdd340 (&ovl_i_mutex_key[depth]#2){+.+.}-{3:3}, at: ovl_fallocate+0x9f/0x270 fs/overlayfs/file.c:535

stack backtrace:
CPU: 1 PID: 21743 Comm: syz-executor.5 Not tainted 6.1.0-rc8-next-20221207-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd1/0x138 lib/dump_stack.c:106
 print_deadlock_bug kernel/locking/lockdep.c:2990 [inline]
 check_deadlock kernel/locking/lockdep.c:3033 [inline]
 validate_chain kernel/locking/lockdep.c:3818 [inline]
 __lock_acquire.cold+0x116/0x3a7 kernel/locking/lockdep.c:5055
 lock_acquire kernel/locking/lockdep.c:5668 [inline]
 lock_acquire+0x1e3/0x630 kernel/locking/lockdep.c:5633
 down_write+0x94/0x220 kernel/locking/rwsem.c:1562
 inode_lock include/linux/fs.h:756 [inline]
 ovl_remove_privs_unlocked fs/overlayfs/file.c:519 [inline]
 ovl_fallocate+0x15c/0x270 fs/overlayfs/file.c:546
 vfs_fallocate+0x48b/0xe00 fs/open.c:323
 ksys_fallocate fs/open.c:346 [inline]
 __do_sys_fallocate fs/open.c:354 [inline]
 __se_sys_fallocate fs/open.c:352 [inline]
 __x64_sys_fallocate+0xd3/0x140 fs/open.c:352
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fbb9608c0d9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fbb96dc6168 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
RAX: ffffffffffffffda RBX: 00007fbb961abf80 RCX: 00007fbb9608c0d9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007fbb960e7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000001000f4 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffee8cc3bef R14: 00007fbb96dc6300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
