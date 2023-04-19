Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29246E72D6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 08:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbjDSGFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 02:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbjDSGFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 02:05:08 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E30618A
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 23:05:07 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-760eead6a4aso191672739f.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 23:05:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681884305; x=1684476305;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kouztW6HEdVb3Wh3hzPt7Cdw/KSYIA8iEGxKFUZNtcg=;
        b=XbcTliOWixjlqopA7FbKIRaqgTkfP/5RArBuoL3Stxnm12VJjMwyTId4GgZOS5+3ds
         h+5GOiazA8MX/J7v5sWCPTnTyeDbWLaSwbQ3/XfQcyVGfk5JlJ2t6gIT1QGilXcWDd71
         cBgBgGCJeqyB8XdCnoQJRNDrl9OqNOkR0hXSQXfkY3or4Y7Ti1/X5WWYFETX89DdZucz
         6g/A3JR/fhbtti/LgDIKlVBJwpAADtjuG1A3AchbMCaUv85+FFSCRnk5Ih5gSUAjY4dT
         Qw0GINeSn20F0ISXHxpVJnNiJABX+PT9NXifFDLPKHLQ4VZGyrY56mu5gmJAzI/Nppui
         tLqQ==
X-Gm-Message-State: AAQBX9c5QG/wqxQVNv/9U82VlBL48AyRdFsO0JHjDD9ldvp9mQazhRRL
        syPxAq5SFRXe5jHjU8srD+Ha+eJr1GWD4CGOc3wzBbU+BPPE
X-Google-Smtp-Source: AKy350bTZI9wmT6d8rLs3C74F0my4WtD8gHmXBVjilfOUhe+qHbz8M0h/VKExey9ixETAplOTY7o//M7RW/snMt7eoI3vGqm7k6N
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3146:b0:760:e9b6:e6de with SMTP id
 m6-20020a056602314600b00760e9b6e6demr3156572ioy.0.1681884305405; Tue, 18 Apr
 2023 23:05:05 -0700 (PDT)
Date:   Tue, 18 Apr 2023 23:05:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000093c4d105f9aa34d6@google.com>
Subject: [syzbot] [block?] general protection fault in reset_interrupt (3)
From:   syzbot <syzbot+619e27617b2abe6b9b72@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, efremov@linux.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    95abc817ab3a Merge tag 'acpi-6.3-rc7' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10f8677bc80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=90aa79dcf599c3f1
dashboard link: https://syzkaller.appspot.com/bug?extid=619e27617b2abe6b9b72
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+619e27617b2abe6b9b72@syzkaller.appspotmail.com

c1 00                                            ..
status=80
fdc_busy=0
cont=0000000000000000
current_req=0000000000000000
command_status=-1
general protection fault, probably for non-canonical address 0xdffffc0000000002: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
CPU: 3 PID: 5216 Comm: kworker/u16:3 Not tainted 6.3.0-rc6-syzkaller-00168-g95abc817ab3a #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Workqueue: floppy floppy_work_workfn
RIP: 0010:reset_interrupt+0x17a/0x230 drivers/block/floppy.c:1789
Code: 6c d3 4a fc e9 0e ff ff ff e8 82 d8 66 fc 48 8b 1d 4b 30 ed 0c 48 b8 00 00 00 00 00 fc ff df 48 8d 7b 10 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 80 00 00 00 48 8b 73 10 48 c7 c7 c0 c6 ce 8a e8
RSP: 0018:ffffc9000375fd08 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000002 RSI: ffffffff851b338e RDI: 0000000000000010
RBP: ffffffff8d44d380 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffffc9000375fda8
R13: ffffffff8d44d390 R14: ffff88801d3d8000 R15: ffff888012479000
FS:  0000000000000000(0000) GS:ffff88802c900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fcacaedee08 CR3: 00000000496e5000 CR4: 0000000000150ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 process_one_work+0x991/0x15c0 kernel/workqueue.c:2390
 worker_thread+0x669/0x1090 kernel/workqueue.c:2537
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:reset_interrupt+0x17a/0x230 drivers/block/floppy.c:1789
Code: 6c d3 4a fc e9 0e ff ff ff e8 82 d8 66 fc 48 8b 1d 4b 30 ed 0c 48 b8 00 00 00 00 00 fc ff df 48 8d 7b 10 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 80 00 00 00 48 8b 73 10 48 c7 c7 c0 c6 ce 8a e8
RSP: 0018:ffffc9000375fd08 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000002 RSI: ffffffff851b338e RDI: 0000000000000010
RBP: ffffffff8d44d380 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffffc9000375fda8
R13: ffffffff8d44d390 R14: ffff88801d3d8000 R15: ffff888012479000
FS:  0000000000000000(0000) GS:ffff88802c900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fcacaedee08 CR3: 00000000496e5000 CR4: 0000000000150ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	6c                   	insb   (%dx),%es:(%rdi)
   1:	d3 4a fc             	rorl   %cl,-0x4(%rdx)
   4:	e9 0e ff ff ff       	jmpq   0xffffff17
   9:	e8 82 d8 66 fc       	callq  0xfc66d890
   e:	48 8b 1d 4b 30 ed 0c 	mov    0xced304b(%rip),%rbx        # 0xced3060
  15:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  1c:	fc ff df
  1f:	48 8d 7b 10          	lea    0x10(%rbx),%rdi
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 80 00 00 00    	jne    0xb4
  34:	48 8b 73 10          	mov    0x10(%rbx),%rsi
  38:	48 c7 c7 c0 c6 ce 8a 	mov    $0xffffffff8acec6c0,%rdi
  3f:	e8                   	.byte 0xe8


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
