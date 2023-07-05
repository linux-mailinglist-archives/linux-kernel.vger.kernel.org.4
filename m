Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB7774917D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 01:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbjGEXQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 19:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjGEXQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 19:16:09 -0400
Received: from mail-pf1-f208.google.com (mail-pf1-f208.google.com [209.85.210.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD3F1989
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 16:16:07 -0700 (PDT)
Received: by mail-pf1-f208.google.com with SMTP id d2e1a72fcca58-6687281b767so219917b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 16:16:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688598967; x=1691190967;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XPZrTMhPOVSDzXqq2LiTwwbAu0oIwjDmxkMqyLNS5/U=;
        b=koTC2h00m7aSak7ucYukmg+04NcCjliGkemU+LpzjnB+mDSZtKUlMhTkODiCBqYr1i
         a7t2+e9WdkcdJ4oiu5FxLDHVNKGKeiCmYOdryX2thsVG3EmplIOTxhhdxtyqStk+5ITv
         gsAHOP/qg64UQ3aQpkNN6E9JdLOxsFlnD2fUfuiAAzBBJZjB8itLJ5s2tjLtz1JrzudX
         wb2rbDDGYJx06kkDprQiV+/FhT0XWunTkOGsHh4KQEhUjn+mRD/vEJaEP+ciney7pf+s
         +0wwHpmyxtzEjXVTMMbcQ1rB/6vSQVjfBQVJmxcJemZqwDbsJK8TeXTTiu8olYaN+bvv
         mgEw==
X-Gm-Message-State: ABy/qLa/SlWco29YjYtrZyscm54bxTZxXTYuMJx+cEGjb51jfSK5vYjU
        K2IxPtVev6FWFtkqSByMJ5lXopgqvn0K/7PCWkGyVA3FQo8K
X-Google-Smtp-Source: APBJJlGkFGKZrNGNxSCynuRZQ5e8wgK1BjuycfRNtlk/cd5+YOZoBMSbm5ZU7tsQdza/OYA4ZfwmHfjEbCciuLKF/BpV0BLmFsGH
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:1889:b0:682:5980:a0e0 with SMTP id
 x9-20020a056a00188900b006825980a0e0mr428479pfh.5.1688598967363; Wed, 05 Jul
 2023 16:16:07 -0700 (PDT)
Date:   Wed, 05 Jul 2023 16:16:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009e2dd805ffc595a3@google.com>
Subject: [syzbot] [serial?] general protection fault in serial8250_tx_chars
From:   syzbot <syzbot+837b8c9032c053262db8@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    6cd06ab12d1a gup: make the stack expansion warning a bit m..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13fdf29ca80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9b64180aaf312512
dashboard link: https://syzkaller.appspot.com/bug?extid=837b8c9032c053262db8
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6b9ac6b68fe1/disk-6cd06ab1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/694d14350cd9/vmlinux-6cd06ab1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0344e65f0f1c/bzImage-6cd06ab1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+837b8c9032c053262db8@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 PID: 12722 Comm: kworker/1:25 Not tainted 6.4.0-syzkaller-11479-g6cd06ab12d1a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
Workqueue: pm pm_runtime_work
RIP: 0010:serial8250_tx_chars+0x299/0x8b0 drivers/tty/serial/8250/8250_port.c:1813
Code: 5d 36 26 fd 48 8b 2b 48 8b 44 24 20 42 0f b6 04 38 84 c0 0f 85 8f 02 00 00 48 8b 04 24 48 63 00 48 01 c5 48 89 e8 48 c1 e8 03 <42> 0f b6 04 38 84 c0 0f 85 91 02 00 00 0f b6 6d 00 48 8b 44 24 60
RSP: 0018:ffffc9000abdf8d0 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff88801f1c0fd0 RCX: 1ffffffff246560f
RDX: 1ffffffff2465659 RSI: 0000000000000000 RDI: ffffffff9232b2d0
RBP: 0000000000000000 R08: ffffffff84be7c90 R09: fffff5200157bf14
R10: dffffc0000000000 R11: fffff5200157bf14 R12: 0000000000000010
R13: ffffffff9232b120 R14: ffffffff9232b020 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020404030 CR3: 000000000d130000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __start_tx+0x312/0x450 drivers/tty/serial/8250/8250_port.c:1547
 serial_port_runtime_resume+0x1ec/0x2a0 drivers/tty/serial/serial_port.c:40
 __rpm_callback+0x2b9/0x7a0 drivers/base/power/runtime.c:392
 rpm_callback drivers/base/power/runtime.c:446 [inline]
 rpm_resume+0x10b1/0x1af0 drivers/base/power/runtime.c:912
 pm_runtime_work+0x147/0x210 drivers/base/power/runtime.c:977
 process_one_work+0x92c/0x12c0 kernel/workqueue.c:2597
 worker_thread+0xa63/0x1210 kernel/workqueue.c:2748
 kthread+0x2b8/0x350 kernel/kthread.c:389
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:serial8250_tx_chars+0x299/0x8b0 drivers/tty/serial/8250/8250_port.c:1813
Code: 5d 36 26 fd 48 8b 2b 48 8b 44 24 20 42 0f b6 04 38 84 c0 0f 85 8f 02 00 00 48 8b 04 24 48 63 00 48 01 c5 48 89 e8 48 c1 e8 03 <42> 0f b6 04 38 84 c0 0f 85 91 02 00 00 0f b6 6d 00 48 8b 44 24 60
RSP: 0018:ffffc9000abdf8d0 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff88801f1c0fd0 RCX: 1ffffffff246560f
RDX: 1ffffffff2465659 RSI: 0000000000000000 RDI: ffffffff9232b2d0
RBP: 0000000000000000 R08: ffffffff84be7c90 R09: fffff5200157bf14
R10: dffffc0000000000 R11: fffff5200157bf14 R12: 0000000000000010
R13: ffffffff9232b120 R14: ffffffff9232b020 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020404030 CR3: 000000000d130000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	5d                   	pop    %rbp
   1:	36 26 fd             	ss es std
   4:	48 8b 2b             	mov    (%rbx),%rbp
   7:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
   c:	42 0f b6 04 38       	movzbl (%rax,%r15,1),%eax
  11:	84 c0                	test   %al,%al
  13:	0f 85 8f 02 00 00    	jne    0x2a8
  19:	48 8b 04 24          	mov    (%rsp),%rax
  1d:	48 63 00             	movslq (%rax),%rax
  20:	48 01 c5             	add    %rax,%rbp
  23:	48 89 e8             	mov    %rbp,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 0f b6 04 38       	movzbl (%rax,%r15,1),%eax <-- trapping instruction
  2f:	84 c0                	test   %al,%al
  31:	0f 85 91 02 00 00    	jne    0x2c8
  37:	0f b6 6d 00          	movzbl 0x0(%rbp),%ebp
  3b:	48 8b 44 24 60       	mov    0x60(%rsp),%rax


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
