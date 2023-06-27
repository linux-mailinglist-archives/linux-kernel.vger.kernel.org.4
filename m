Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF3274019A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 18:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbjF0QuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 12:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbjF0Qtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 12:49:52 -0400
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E74B187
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 09:49:51 -0700 (PDT)
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-77d89a08a50so282320639f.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 09:49:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687884590; x=1690476590;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6mpZdZ8TrOnclUhJKMMDYdLhV/Dq74p7v3SXnx8ZNxU=;
        b=hKfYKk8rX4mX0ohnSDvE5uaVdTrP9xXLV6KXwrUDO4vYl24EShzxhe62hSTmR9p3XI
         C4+4A8Ihp5xgtPNIglTFaEo44xW6wr/GigDdtKJmsYfhBHjp4lq2EwKPrfoxAEOAq8Pm
         ItRSIKRsWdJXDza1N0s4A+QpmqV/izZkyIh6CbUxV8iaxtyu5Slhqr1cGnPN4whzkyxJ
         SeOVt2L5OCzXbW8GUsAN1kVtqaeNoYYYIvOhqU1jfJoyeb1nOEMp1rDAfK49R/CZiNGi
         KDbK2uVUI8QWiQg/sLwIV8vbEvi7qQ+XDZTIAneFtylYh/VhtLGqdobWo0lXlsuggBTQ
         GNEQ==
X-Gm-Message-State: AC+VfDwlbQN7tn2KKNkhPFOzME/IqUxJhen9zVpa8/izC5TvVXJ1WDlr
        OlEQw60GnPzflXlBRfD2OojWvVOFk3CjKoVX9qkhMvyILMRa
X-Google-Smtp-Source: ACHHUZ6K4fTRg1aJoktZfWUx3piitS706bwAfMtZae9Pg1xcnunjeDo3auk7auRAcwMbD+VzQPdQHMOQazliyLwMu30tgV8tazQI
MIME-Version: 1.0
X-Received: by 2002:a5e:aa19:0:b0:783:c1b2:3ae0 with SMTP id
 s25-20020a5eaa19000000b00783c1b23ae0mr621608ioe.0.1687884590538; Tue, 27 Jun
 2023 09:49:50 -0700 (PDT)
Date:   Tue, 27 Jun 2023 09:49:50 -0700
In-Reply-To: <000000000000b1076405f9818f92@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000070ed0005ff1f4120@google.com>
Subject: Re: [syzbot] [block?] WARNING in floppy_interrupt (2)
From:   syzbot <syzbot+aa45f3927a085bc1b242@syzkaller.appspotmail.com>
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    1ef6663a587b Merge tag 'tag-chrome-platform-for-v6.5' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=124a5670a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=319f18de2a0a8640
dashboard link: https://syzkaller.appspot.com/bug?extid=aa45f3927a085bc1b242
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=127d41e0a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=145f1ee0a80000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-1ef6663a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1600540a0cdf/vmlinux-1ef6663a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/36ac12d50d01/bzImage-1ef6663a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+aa45f3927a085bc1b242@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 4921 at drivers/block/floppy.c:999 schedule_bh drivers/block/floppy.c:999 [inline]
WARNING: CPU: 1 PID: 4921 at drivers/block/floppy.c:999 floppy_interrupt+0x3cc/0x440 drivers/block/floppy.c:1765
Modules linked in:
CPU: 1 PID: 4921 Comm: kworker/u16:2 Not tainted 6.4.0-syzkaller-01224-g1ef6663a587b #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Workqueue: floppy floppy_work_workfn
RIP: 0010:schedule_bh drivers/block/floppy.c:999 [inline]
RIP: 0010:floppy_interrupt+0x3cc/0x440 drivers/block/floppy.c:1765
Code: 4d d0 8a 89 c6 89 05 73 c4 ea 0c e8 8e 27 ff ff 8b 1d 68 c4 ea 0c e9 9c fd ff ff e8 ce 56 b1 fc e9 66 fd ff ff e8 24 67 5f fc <0f> 0b e9 c9 fe ff ff 48 c7 c7 00 f2 40 8c e8 71 56 b1 fc e9 5a fc
RSP: 0018:ffffc90000aa8e58 EFLAGS: 00010046
RAX: 0000000080010000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: ffff888031a98800 RSI: ffffffff852425ac RDI: 0000000000000001
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: ffffc90000aa8ff8 R12: ffffffff85239f60
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000006
FS:  0000000000000000(0000) GS:ffff88806b700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055cd072ef000 CR3: 000000000c571000 CR4: 0000000000350ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 floppy_hardint+0x1b1/0x200 arch/x86/include/asm/floppy.h:66
 __handle_irq_event_percpu+0x22b/0x730 kernel/irq/handle.c:158
 handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
 handle_irq_event+0xab/0x1e0 kernel/irq/handle.c:210
 handle_edge_irq+0x263/0xd00 kernel/irq/chip.c:834
 generic_handle_irq_desc include/linux/irqdesc.h:161 [inline]
 handle_irq arch/x86/kernel/irq.c:238 [inline]
 __common_interrupt+0xa1/0x220 arch/x86/kernel/irq.c:257
 common_interrupt+0xa8/0xd0 arch/x86/kernel/irq.c:247
 </IRQ>
 <TASK>
 asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:636
RIP: 0010:outb_p arch/x86/include/asm/io.h:296 [inline]
RIP: 0010:fdc_outb drivers/block/floppy.c:602 [inline]
RIP: 0010:reset_fdc+0x185/0x400 drivers/block/floppy.c:1817
Code: ba 00 00 00 00 00 fc ff df 48 89 f9 48 c1 e9 03 80 3c 11 00 0f 85 8a 01 00 00 48 8d 14 9b 48 8b 14 d5 f0 c0 0e 92 83 c2 04 ee <e8> 56 ec ff ff 48 83 c4 08 5b 5d e9 9b 1f 60 fc e8 96 1f 60 fc 48
RSP: 0018:ffffc9000308fc70 EFLAGS: 00000202
RAX: 00000000ffffff81 RBX: 0000000000000000 RCX: 1ffffffff241d81e
RDX: 00000000000003f4 RSI: ffffffff85236c9c RDI: ffffffff920ec0f0
RBP: 0000000000000062 R08: 0000000000000001 R09: 0000000000000044
R10: 0000000000000062 R11: 0000000032393454 R12: 0000000000000001
R13: 0000000000000000 R14: 0000000000000020 R15: 0000ffff88800010
 floppy_ready+0x67c/0x1b60 drivers/block/floppy.c:1929
 redo_format+0x545/0x6f0 drivers/block/floppy.c:2214
 process_one_work+0x99a/0x15e0 kernel/workqueue.c:2408
 worker_thread+0x67d/0x10c0 kernel/workqueue.c:2555
 kthread+0x344/0x440 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
----------------
Code disassembly (best guess):
   0:	ba 00 00 00 00       	mov    $0x0,%edx
   5:	00 fc                	add    %bh,%ah
   7:	ff                   	(bad)
   8:	df 48 89             	fisttps -0x77(%rax)
   b:	f9                   	stc
   c:	48 c1 e9 03          	shr    $0x3,%rcx
  10:	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1)
  14:	0f 85 8a 01 00 00    	jne    0x1a4
  1a:	48 8d 14 9b          	lea    (%rbx,%rbx,4),%rdx
  1e:	48 8b 14 d5 f0 c0 0e 	mov    -0x6df13f10(,%rdx,8),%rdx
  25:	92
  26:	83 c2 04             	add    $0x4,%edx
  29:	ee                   	out    %al,(%dx)
* 2a:	e8 56 ec ff ff       	callq  0xffffec85 <-- trapping instruction
  2f:	48 83 c4 08          	add    $0x8,%rsp
  33:	5b                   	pop    %rbx
  34:	5d                   	pop    %rbp
  35:	e9 9b 1f 60 fc       	jmpq   0xfc601fd5
  3a:	e8 96 1f 60 fc       	callq  0xfc601fd5
  3f:	48                   	rex.W


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
