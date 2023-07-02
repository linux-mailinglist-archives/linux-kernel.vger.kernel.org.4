Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C02A744BFC
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 03:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjGBB0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 21:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjGBB0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 21:26:08 -0400
Received: from mail-pl1-f205.google.com (mail-pl1-f205.google.com [209.85.214.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3C9172C
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 18:26:07 -0700 (PDT)
Received: by mail-pl1-f205.google.com with SMTP id d9443c01a7336-1b817cda09bso29559085ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jul 2023 18:26:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688261166; x=1690853166;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qutum0O9fNVxaAqpGb4Xhyzjg5jVTncuf2+NGBTwfw8=;
        b=gMN38aGGc83w97Z5KPDzeyrbcKf7wABeG4Ca2HD2NOgwb3C327do484iUT3cydi+Ft
         U4+Ab+7jIQFdD9ibwl+pD0tYrxA8KSy4kyGREqFFTR8ZsKLx2RDY8LfaKc5Q20FZiBmI
         +H4x0KypsubOFy/SF/jXT0qjdgPiRC3uLjiKY50yKrTzfpHWYDeiCH9QUCwg7e0mtLGM
         iHLYam7e6B3XwqMkrUGkBNmQ8IGdM/yd52pZIezttXkMW7/qWt3xdt88pk7F9t3HA2em
         hUeg4rEfh6xbfewI6G3VkwDL5wiyNPdMR7oD0VyLMwz9iqZhMjldYSMfzPnn7xiopBt0
         RzuQ==
X-Gm-Message-State: ABy/qLYS2V5MCcQuzTkWB59AR/1HyjrR460UJdKXJu+S7D0zJ5oy4cKf
        pH+LYVo2tyzs9xK52x1ULA88YzxFwHVdXCdH+CCwi2Mnv6go
X-Google-Smtp-Source: APBJJlEuuEP2HgySwnxRqaBq/6HAa6fKat/vbAv4V84ORvfAVD+FZXaQyAk9HTuL48WtKB6MnRG8fZs0fBosEDs6og11BBotLRDv
MIME-Version: 1.0
X-Received: by 2002:a17:902:cecf:b0:1b5:2b14:5f2c with SMTP id
 d15-20020a170902cecf00b001b52b145f2cmr5534096plg.4.1688261166668; Sat, 01 Jul
 2023 18:26:06 -0700 (PDT)
Date:   Sat, 01 Jul 2023 18:26:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000020a2f305ff76ef34@google.com>
Subject: [syzbot] [mm?] general protection fault in mt_validate
From:   syzbot <syzbot+6c0c8f9846801f6fbec0@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    f8566aa4f176 Merge tag 'x86-urgent-2023-07-01' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1776ecb8a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7406f415f386e786
dashboard link: https://syzkaller.appspot.com/bug?extid=6c0c8f9846801f6fbec0
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=131e8548a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=141ca8b8a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/afab0dafcce3/disk-f8566aa4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6b77678d9c2a/vmlinux-f8566aa4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ec2a20a04171/bzImage-f8566aa4.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/1bd3a6492d61/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6c0c8f9846801f6fbec0@syzkaller.appspotmail.com

RSP: 002b:00007f2c3f367168 EFLAGS: 00000246 ORIG_RAX: 000000000000000b
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f2c3f3bb9d7
RDX: 0000000000008000 RSI: 0000000000008000 RDI: 00007f2c36f26000
RBP: 00007f2c36f26000 R08: 0000000000000000 R09: 0000000000000280
R10: 0000000000008000 R11: 0000000000000246 R12: 00007f2c3f3676b8
R13: 00007f2c3f367180 R14: 00007f2c3f3671c0 R15: 00007f2c3f4407a8
 </TASK>
general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 PID: 5347 Comm: syz-executor152 Not tainted 6.4.0-syzkaller-10062-gf8566aa4f176 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
RIP: 0010:mas_validate_gaps lib/maple_tree.c:7002 [inline]
RIP: 0010:mt_validate+0x32ac/0x4370 lib/maple_tree.c:7224
Code: 89 ee e8 97 18 77 f7 49 83 fd 06 0f 84 a6 06 00 00 e8 48 1c 77 f7 49 01 de 48 ba 00 00 00 00 00 fc ff df 4c 89 f0 48 c1 e8 03 <80> 3c 10 00 0f 85 4b 10 00 00 4d 8b 2e 4c 89 ff 4c 89 ee e8 dc 17
RSP: 0018:ffffc9000423f940 EFLAGS: 00010256
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: dffffc0000000000 RSI: ffffffff8a0db288 RDI: 0000000000000007
RBP: ffff888028b33600 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
R13: ffff888028b33600 R14: 0000000000000000 R15: ffff800216450000
FS:  00007f2c3f367700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2c3f3fd000 CR3: 0000000015ff7000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 validate_mm+0x9d/0x470 mm/mmap.c:300
 do_vmi_align_munmap+0x1199/0x1680 mm/mmap.c:2561
 do_vmi_munmap+0x266/0x430 mm/mmap.c:2619
 __vm_munmap+0x137/0x380 mm/mmap.c:2899
 __do_sys_munmap mm/mmap.c:2916 [inline]
 __se_sys_munmap mm/mmap.c:2913 [inline]
 __x64_sys_munmap+0x62/0x80 mm/mmap.c:2913
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f2c3f3bb9d7
Code: 00 00 00 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb 85 66 2e 0f 1f 84 00 00 00 00 00 90 b8 0b 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2c3f367168 EFLAGS: 00000246 ORIG_RAX: 000000000000000b
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f2c3f3bb9d7
RDX: 0000000000008000 RSI: 0000000000008000 RDI: 00007f2c36f26000
RBP: 00007f2c36f26000 R08: 0000000000000000 R09: 0000000000000280
R10: 0000000000008000 R11: 0000000000000246 R12: 00007f2c3f3676b8
R13: 00007f2c3f367180 R14: 00007f2c3f3671c0 R15: 00007f2c3f4407a8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:mas_validate_gaps lib/maple_tree.c:7002 [inline]
RIP: 0010:mt_validate+0x32ac/0x4370 lib/maple_tree.c:7224
Code: 89 ee e8 97 18 77 f7 49 83 fd 06 0f 84 a6 06 00 00 e8 48 1c 77 f7 49 01 de 48 ba 00 00 00 00 00 fc ff df 4c 89 f0 48 c1 e8 03 <80> 3c 10 00 0f 85 4b 10 00 00 4d 8b 2e 4c 89 ff 4c 89 ee e8 dc 17
RSP: 0018:ffffc9000423f940 EFLAGS: 00010256
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: dffffc0000000000 RSI: ffffffff8a0db288 RDI: 0000000000000007
RBP: ffff888028b33600 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
R13: ffff888028b33600 R14: 0000000000000000 R15: ffff800216450000
FS:  00007f2c3f367700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2c3f3fd000 CR3: 0000000015ff7000 CR4: 0000000000350ef0
----------------
Code disassembly (best guess):
   0:	89 ee                	mov    %ebp,%esi
   2:	e8 97 18 77 f7       	callq  0xf777189e
   7:	49 83 fd 06          	cmp    $0x6,%r13
   b:	0f 84 a6 06 00 00    	je     0x6b7
  11:	e8 48 1c 77 f7       	callq  0xf7771c5e
  16:	49 01 de             	add    %rbx,%r14
  19:	48 ba 00 00 00 00 00 	movabs $0xdffffc0000000000,%rdx
  20:	fc ff df
  23:	4c 89 f0             	mov    %r14,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	80 3c 10 00          	cmpb   $0x0,(%rax,%rdx,1) <-- trapping instruction
  2e:	0f 85 4b 10 00 00    	jne    0x107f
  34:	4d 8b 2e             	mov    (%r14),%r13
  37:	4c 89 ff             	mov    %r15,%rdi
  3a:	4c 89 ee             	mov    %r13,%rsi
  3d:	e8                   	.byte 0xe8
  3e:	dc 17                	fcoml  (%rdi)


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
