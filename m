Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFDA654B1F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 03:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbiLWCei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 21:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiLWCeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 21:34:36 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C111581B
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 18:34:35 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id z19-20020a921a53000000b0030b90211df1so1983727ill.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 18:34:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l06fwy6JsDLjyC/xnL6GsbLE0AfCddjpOW4hS1TjxTI=;
        b=W3Xnf0cfA+NVfa5Qr97QUjogUaq8/46zBgsKKE7ntYFsrTwj2MnI4m0isf/H+reJVR
         /rJhXTYZdXHw8W//j88suYG36AKBklkG7HajGASjj2flpiatXuMdPYwzcxjx/O/e0Qnl
         9JkKAK2c6FaACspMIx5Q0EfEU+ZGEghi9U1k0HnT8koHvIbIIUJsQA0OJ+U6I2YqIm7Z
         7vrlr5EhMtnTgNMrybxr9LaH3kAU7ynprReu+HBcWF/LzqDDVMrU3GChUvzOAQMKs5+c
         c2K+WHB9QAn/w+6gVC6uiOXSm2DnD8TYJt6rJ3rKo6SDPJcsdjyYsZ9SYOmKQbwS43GY
         lxEQ==
X-Gm-Message-State: AFqh2kpo+ARVTLzS4Kosl2KqE/zurv6OcW0hBtMReiMRAPe3Exk4JIfk
        4UbR+Ou089yUcROIBtyZoiKzYkCLW+jacwWx/BCdd/Yx7os/
X-Google-Smtp-Source: AMrXdXuQeH/mYIb2I8idE3iOaKNjUawgvv5EHfPChxi0418GPQHs5AF8EculVLcYH80Vv8lmPQ2UGhBPh3EB3nNN/H2UL7P4a/co
MIME-Version: 1.0
X-Received: by 2002:a6b:dc10:0:b0:6e0:2b9e:b1c4 with SMTP id
 s16-20020a6bdc10000000b006e02b9eb1c4mr574624ioc.186.1671762875122; Thu, 22
 Dec 2022 18:34:35 -0800 (PST)
Date:   Thu, 22 Dec 2022 18:34:35 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000520d3405f075a026@google.com>
Subject: [syzbot] [reiserfs?] divide error in do_journal_end (3)
From:   syzbot <syzbot+74b838cfa47fc9554471@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, bvanassche@acm.org, jlayton@kernel.org,
        linux-kernel@vger.kernel.org, reiserfs-devel@vger.kernel.org,
        song@kernel.org, syzkaller-bugs@googlegroups.com,
        willy@infradead.org, yi.zhang@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    f9ff5644bcc0 Merge tag 'hsi-for-6.2' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13ee69e7880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c163713cf9186fe7
dashboard link: https://syzkaller.appspot.com/bug?extid=74b838cfa47fc9554471
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/95eb66f6b569/disk-f9ff5644.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fb05e1a5a9de/vmlinux-f9ff5644.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e2f1f698973a/bzImage-f9ff5644.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+74b838cfa47fc9554471@syzkaller.appspotmail.com

divide error: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 8065 Comm: syz-executor.4 Not tainted 6.1.0-syzkaller-13139-gf9ff5644bcc0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:do_journal_end+0x1822/0x4a30 fs/reiserfs/journal.c:4091
Code: 04 28 84 c0 0f 85 f7 2b 00 00 4a 8d 5c 33 01 4c 89 e0 48 c1 e8 03 42 8a 04 28 84 c0 0f 85 ff 2b 00 00 41 8b 0f 48 89 d8 31 d2 <48> f7 f1 48 89 d3 48 03 5c 24 20 48 8b 84 24 d8 00 00 00 42 80 3c
RSP: 0018:ffffc90003c5fae0 EFLAGS: 00010246
RAX: 0000000000000003 RBX: 0000000000000003 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff888026c42000
RBP: ffffc90003c5fd50 R08: dffffc0000000000 R09: ffff888026c42000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff888037308017
R13: dffffc0000000000 R14: 0000000000000002 R15: ffff888037308014
FS:  00007f623dd00700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000002012d000 CR3: 0000000018049000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 reiserfs_sync_fs+0xbb/0x130 fs/reiserfs/super.c:78
 iterate_supers+0x137/0x1f0 fs/super.c:724
 ksys_sync+0xc6/0x1c0 fs/sync.c:103
 __do_sys_sync+0xa/0x10 fs/sync.c:113
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f623d08c0d9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f623dd00168 EFLAGS: 00000246 ORIG_RAX: 00000000000000a2
RAX: ffffffffffffffda RBX: 00007f623d1abf80 RCX: 00007f623d08c0d9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007f623d0e7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fffa3f7577f R14: 00007f623dd00300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:do_journal_end+0x1822/0x4a30 fs/reiserfs/journal.c:4091
Code: 04 28 84 c0 0f 85 f7 2b 00 00 4a 8d 5c 33 01 4c 89 e0 48 c1 e8 03 42 8a 04 28 84 c0 0f 85 ff 2b 00 00 41 8b 0f 48 89 d8 31 d2 <48> f7 f1 48 89 d3 48 03 5c 24 20 48 8b 84 24 d8 00 00 00 42 80 3c
RSP: 0018:ffffc90003c5fae0 EFLAGS: 00010246
RAX: 0000000000000003 RBX: 0000000000000003 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff888026c42000
RBP: ffffc90003c5fd50 R08: dffffc0000000000 R09: ffff888026c42000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff888037308017
R13: dffffc0000000000 R14: 0000000000000002 R15: ffff888037308014
FS:  00007f623dd00700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000021000000 CR3: 0000000018049000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	04 28                	add    $0x28,%al
   2:	84 c0                	test   %al,%al
   4:	0f 85 f7 2b 00 00    	jne    0x2c01
   a:	4a 8d 5c 33 01       	lea    0x1(%rbx,%r14,1),%rbx
   f:	4c 89 e0             	mov    %r12,%rax
  12:	48 c1 e8 03          	shr    $0x3,%rax
  16:	42 8a 04 28          	mov    (%rax,%r13,1),%al
  1a:	84 c0                	test   %al,%al
  1c:	0f 85 ff 2b 00 00    	jne    0x2c21
  22:	41 8b 0f             	mov    (%r15),%ecx
  25:	48 89 d8             	mov    %rbx,%rax
  28:	31 d2                	xor    %edx,%edx
* 2a:	48 f7 f1             	div    %rcx <-- trapping instruction
  2d:	48 89 d3             	mov    %rdx,%rbx
  30:	48 03 5c 24 20       	add    0x20(%rsp),%rbx
  35:	48 8b 84 24 d8 00 00 	mov    0xd8(%rsp),%rax
  3c:	00
  3d:	42                   	rex.X
  3e:	80                   	.byte 0x80
  3f:	3c                   	.byte 0x3c


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
