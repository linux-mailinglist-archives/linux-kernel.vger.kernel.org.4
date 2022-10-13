Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9586D5FD5D7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 10:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiJMIAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 04:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiJMIAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 04:00:40 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E527F09A
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 01:00:38 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id x21-20020a5d9455000000b006bc1172e639so611803ior.18
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 01:00:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KfNmjLJ2nCCl/6BP47MdEd5Fupmyoh7/veDA+PeHAuY=;
        b=1CMEMUFaIiwMl5iiqfkWgyXUx5eGUZRvGVMZWRituyWo8ZWwEITX4Nq5v9dln8dO3L
         Q1owkTZ/lQQMOuZYP7JHVAQgD2r+VdQJ6QVy/gOLDJtK1AnWpWdbyGYRRj5sHFTKDcK0
         69svaADxHkw+MRV48Ipklv6lXq2YRDW/jy8KyZCmhg8/rEzSDDdLPBXZ2+96GC80lhEA
         GIsIA6rLOVp+an6uBqU6dqx68IrXqVd9R3o+UGjKb7idnTZBFW/46M02ghO4UWWUY3Qo
         JTrkohjCBfLYII1Cydsz17PXD7w3H8ogZYooiC0PsPnUwWQeSpOqMecWrP5d/Db+HBnC
         3ppg==
X-Gm-Message-State: ACrzQf3uOvMDHrRZ/SL4DT19c0fSu9ILitL8zLSRgZHkCfVTcL0Wm5y4
        RtJoWcTH1+gIHCBlr81+zZZk46w6YciaBfJSEf8n6muWmhWE
X-Google-Smtp-Source: AMsMyM6rzn6LRvyL52Ijsefu63bbuMoHtUTK58VlD+Rju+fKv8WruYItV0HMDeeGg0ErRJRc4NM9YE7cP9C1IyfJECe1xFuVu8p3
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2ac8:b0:6bc:c044:ba63 with SMTP id
 m8-20020a0566022ac800b006bcc044ba63mr2113127iov.142.1665648038106; Thu, 13
 Oct 2022 01:00:38 -0700 (PDT)
Date:   Thu, 13 Oct 2022 01:00:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a1dfaf05eae5e72c@google.com>
Subject: [syzbot] general protection fault in mutex_optimistic_spin
From:   syzbot <syzbot+f587f14d28021bea6455@syzkaller.appspotmail.com>
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

HEAD commit:    55be6084c8e0 Merge tag 'timers-core-2022-10-05' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=127fc1a4880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c29b6436e994d72e
dashboard link: https://syzkaller.appspot.com/bug?extid=f587f14d28021bea6455
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c8f5131ab57d/disk-55be6084.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/77167f226f35/vmlinux-55be6084.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f587f14d28021bea6455@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 64
general protection fault, probably for non-canonical address 0xe0017c0000000006: 0000 [#1] PREEMPT SMP KASAN
KASAN: maybe wild-memory-access in range [0x000c000000000030-0x000c000000000037]
CPU: 1 PID: 13181 Comm: syz-executor.0 Not tainted 6.0.0-syzkaller-09589-g55be6084c8e0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
RIP: 0010:owner_on_cpu include/linux/sched.h:2283 [inline]
RIP: 0010:mutex_can_spin_on_owner kernel/locking/mutex.c:409 [inline]
RIP: 0010:mutex_optimistic_spin+0x12d/0x2d0 kernel/locking/mutex.c:452
Code: 89 d8 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 08 99 75 00 4c 8b 23 49 83 e4 f8 74 72 49 8d 6c 24 34 48 89 e8 48 c1 e8 03 <42> 8a 04 28 84 c0 0f 85 4f 01 00 00 83 7d 00 00 74 78 49 83 c4 14
RSP: 0018:ffffc90004bf77e8 EFLAGS: 00010207
RAX: 0001800000000006 RBX: ffff88801dc69228 RCX: ffffffff81676b52
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff88801dc69228
RBP: 000c000000000034 R08: dffffc0000000000 R09: ffffed1003b8d246
R10: ffffed1003b8d246 R11: 1ffff11003b8d245 R12: 000c000000000000
R13: dffffc0000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  00007fed86ab8700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fed85913e09 CR3: 000000007cedc000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __mutex_lock_common+0x210/0x26c0 kernel/locking/mutex.c:607
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x17/0x20 kernel/locking/mutex.c:799
 reiserfs_write_lock+0x77/0xd0 fs/reiserfs/lock.c:27
 reiserfs_readdir_inode+0x170/0x1470 fs/reiserfs/dir.c:79
 iterate_dir+0x257/0x5f0
 __do_sys_getdents fs/readdir.c:286 [inline]
 __se_sys_getdents+0x1e9/0x4a0 fs/readdir.c:271
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fed8588b5a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fed86ab8168 EFLAGS: 00000246 ORIG_RAX: 000000000000004e
RAX: ffffffffffffffda RBX: 00007fed859abf80 RCX: 00007fed8588b5a9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007fed858e6580 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd3696e99f R14: 00007fed86ab8300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:owner_on_cpu include/linux/sched.h:2283 [inline]
RIP: 0010:mutex_can_spin_on_owner kernel/locking/mutex.c:409 [inline]
RIP: 0010:mutex_optimistic_spin+0x12d/0x2d0 kernel/locking/mutex.c:452
Code: 89 d8 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 08 99 75 00 4c 8b 23 49 83 e4 f8 74 72 49 8d 6c 24 34 48 89 e8 48 c1 e8 03 <42> 8a 04 28 84 c0 0f 85 4f 01 00 00 83 7d 00 00 74 78 49 83 c4 14
RSP: 0018:ffffc90004bf77e8 EFLAGS: 00010207
RAX: 0001800000000006 RBX: ffff88801dc69228 RCX: ffffffff81676b52
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff88801dc69228
RBP: 000c000000000034 R08: dffffc0000000000 R09: ffffed1003b8d246
R10: ffffed1003b8d246 R11: 1ffff11003b8d245 R12: 000c000000000000
R13: dffffc0000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  00007fed86ab8700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fed85913e09 CR3: 000000007cedc000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	89 d8                	mov    %ebx,%eax
   2:	48 c1 e8 03          	shr    $0x3,%rax
   6:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1)
   b:	74 08                	je     0x15
   d:	48 89 df             	mov    %rbx,%rdi
  10:	e8 08 99 75 00       	callq  0x75991d
  15:	4c 8b 23             	mov    (%rbx),%r12
  18:	49 83 e4 f8          	and    $0xfffffffffffffff8,%r12
  1c:	74 72                	je     0x90
  1e:	49 8d 6c 24 34       	lea    0x34(%r12),%rbp
  23:	48 89 e8             	mov    %rbp,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 8a 04 28          	mov    (%rax,%r13,1),%al <-- trapping instruction
  2e:	84 c0                	test   %al,%al
  30:	0f 85 4f 01 00 00    	jne    0x185
  36:	83 7d 00 00          	cmpl   $0x0,0x0(%rbp)
  3a:	74 78                	je     0xb4
  3c:	49 83 c4 14          	add    $0x14,%r12


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
