Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5933E5FD60B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 10:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiJMIQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 04:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJMIQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 04:16:39 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80EC11C27C
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 01:16:38 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id s2-20020a056e02216200b002f9de38e484so959541ilv.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 01:16:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5/rjiqK5kQOfJLoV8xW4Jx0LB9fiOiRBlADM5JZWwQg=;
        b=f3H1XCvJrH+RcZDXCOHSifTo3XBKCDHnmNAMX2wE7DOBmAjJGsHqGmSpgz7yqQPzB4
         AD1sbvh0gi6N1VL+I3AprE3ebYYIPzr8b6zdoonQlIdW75oydtTVKHjtcmu8+ADRP7HX
         TXILpFE2zs/BS4ygHagfyuGGnGAwox2zZTKDvWR00/mjb2VKMBR1HBnFI3jWqjfO0089
         bSR0n52bKJ1fSbgZkvhIyDV7p0hHg46Gg5T8R4b6COMVMhdkgUk3xKUM/6rUFOhPoUaO
         FK6SQ/85/pCIq0TbuXu2zeMoXJJSoJS/Tht3LcCDB1JYiT61dmaGmfP8nSfYxbQ8iVDq
         KeKQ==
X-Gm-Message-State: ACrzQf3l6NI59hP/JEp54nil1qQyG3/F4H6OtE9nXpSwwpxL5Kzt0cJf
        /9JICnnBmel5MCsJSSEgtaCEXaHZLd66QmifTQc/iE+5ngPl
X-Google-Smtp-Source: AMsMyM6yAO2d8zQcuYpmKxvxf5DkGckDSRM+1OG2zXvRviebrgOKgj7ssmYn/bF7ynh3eHrAMGJYGY6FbZLC8jtsXkdFPBapa1ok
MIME-Version: 1.0
X-Received: by 2002:a92:c74d:0:b0:2f8:dcf1:2797 with SMTP id
 y13-20020a92c74d000000b002f8dcf12797mr16392178ilp.199.1665648998170; Thu, 13
 Oct 2022 01:16:38 -0700 (PDT)
Date:   Thu, 13 Oct 2022 01:16:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000db47da05eae620bc@google.com>
Subject: [syzbot] general protection fault in dtInsert
From:   syzbot <syzbot+f2cb7e5fa4043ec4ebde@syzkaller.appspotmail.com>
To:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    493ffd6605b2 Merge tag 'ucount-rlimits-cleanups-for-v5.19'..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10afbfcc880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d19f5d16783f901
dashboard link: https://syzkaller.appspot.com/bug?extid=f2cb7e5fa4043ec4ebde
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=176e96dc880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1206468a880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f1ff6481e26f/disk-493ffd66.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/101bd3c7ae47/vmlinux-493ffd66.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/f1a297a3e97e/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f2cb7e5fa4043ec4ebde@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 PID: 3606 Comm: syz-executor277 Not tainted 6.0.0-syzkaller-09423-g493ffd6605b2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
RIP: 0010:dtExtendPage fs/jfs/jfs_dtree.c:1661 [inline]
RIP: 0010:dtSplitUp fs/jfs/jfs_dtree.c:1034 [inline]
RIP: 0010:dtInsert+0x30cc/0x6b80 fs/jfs/jfs_dtree.c:863
Code: 55 88 fe 49 83 c7 e8 42 80 3c 23 00 74 08 4c 89 f7 e8 38 c0 db fe 4d 89 3e eb 08 e8 fe 54 88 fe 45 31 ff 4d 89 fe 49 c1 ee 03 <43> 80 3c 26 00 74 08 4c 89 ff e8 95 bf db fe 49 8b 1f 31 ff 48 89
RSP: 0018:ffffc90003cbf6a0 EFLAGS: 00010246
RAX: ffffffff82fe2c52 RBX: 1ffff92000797f7c RCX: ffff888021b51d80
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90003cbfb10 R08: ffffffff82fe125b R09: fffff9400038ebbf
R10: fffff9400038ebbf R11: 1ffffd400038ebbe R12: dffffc0000000000
R13: ffff88807497b7e8 R14: 0000000000000000 R15: 0000000000000000
FS:  000055555738c300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000005d84c8 CR3: 0000000071d83000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 jfs_create+0x736/0xb10 fs/jfs/namei.c:137
 vfs_create+0x302/0x490 fs/namei.c:3115
 do_mknodat+0x412/0x6b0 fs/namei.c:3942
 __do_sys_mknodat fs/namei.c:3970 [inline]
 __se_sys_mknodat fs/namei.c:3967 [inline]
 __x64_sys_mknodat+0xa5/0xc0 fs/namei.c:3967
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f18ca9e4eb9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffefc41f358 EFLAGS: 00000246 ORIG_RAX: 0000000000000103
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00007f18ca9e4eb9
RDX: 0000000000000008 RSI: 0000000020000180 RDI: 0000000000000003
RBP: 00007f18ca9a4680 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000103 R11: 0000000000000246 R12: 00000000f8008000
R13: 0000000000000000 R14: 00083878000000f8 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:dtExtendPage fs/jfs/jfs_dtree.c:1661 [inline]
RIP: 0010:dtSplitUp fs/jfs/jfs_dtree.c:1034 [inline]
RIP: 0010:dtInsert+0x30cc/0x6b80 fs/jfs/jfs_dtree.c:863
Code: 55 88 fe 49 83 c7 e8 42 80 3c 23 00 74 08 4c 89 f7 e8 38 c0 db fe 4d 89 3e eb 08 e8 fe 54 88 fe 45 31 ff 4d 89 fe 49 c1 ee 03 <43> 80 3c 26 00 74 08 4c 89 ff e8 95 bf db fe 49 8b 1f 31 ff 48 89
RSP: 0018:ffffc90003cbf6a0 EFLAGS: 00010246
RAX: ffffffff82fe2c52 RBX: 1ffff92000797f7c RCX: ffff888021b51d80
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90003cbfb10 R08: ffffffff82fe125b R09: fffff9400038ebbf
R10: fffff9400038ebbf R11: 1ffffd400038ebbe R12: dffffc0000000000
R13: ffff88807497b7e8 R14: 0000000000000000 R15: 0000000000000000
FS:  000055555738c300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005593a690d0b8 CR3: 0000000071d83000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	55                   	push   %rbp
   1:	88 fe                	mov    %bh,%dh
   3:	49 83 c7 e8          	add    $0xffffffffffffffe8,%r15
   7:	42 80 3c 23 00       	cmpb   $0x0,(%rbx,%r12,1)
   c:	74 08                	je     0x16
   e:	4c 89 f7             	mov    %r14,%rdi
  11:	e8 38 c0 db fe       	callq  0xfedbc04e
  16:	4d 89 3e             	mov    %r15,(%r14)
  19:	eb 08                	jmp    0x23
  1b:	e8 fe 54 88 fe       	callq  0xfe88551e
  20:	45 31 ff             	xor    %r15d,%r15d
  23:	4d 89 fe             	mov    %r15,%r14
  26:	49 c1 ee 03          	shr    $0x3,%r14
* 2a:	43 80 3c 26 00       	cmpb   $0x0,(%r14,%r12,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	4c 89 ff             	mov    %r15,%rdi
  34:	e8 95 bf db fe       	callq  0xfedbbfce
  39:	49 8b 1f             	mov    (%r15),%rbx
  3c:	31 ff                	xor    %edi,%edi
  3e:	48                   	rex.W
  3f:	89                   	.byte 0x89


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
