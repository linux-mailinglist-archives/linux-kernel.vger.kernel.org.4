Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A055F6F834F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 14:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbjEEMxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 08:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbjEEMxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 08:53:43 -0400
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3E6160AC
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 05:53:42 -0700 (PDT)
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-331632be774so97925635ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 05:53:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683291221; x=1685883221;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dL1E5i940R1bG8iIWFJ5PiddhyJJIdhbvtzAz9YJk+M=;
        b=WgBPHZSZ9lAGn4svgHKTz9j861QVXbDUbOy0yCZqBjrXB4k7AsM5QmWn6QkDMHj2EN
         TALSef3w/vGYOfMFW9fdpjVA8Vxau3MFvvl/sUHBCyHT3zGP88VqLogo2gY1X8+mzRSF
         w/+/+ShCH3OqXwcDaZ+T3fi8blPWHBtE8MLzwWyc17SWYxfSBQjAlM0rrnaicrDOOEep
         ByamIuKaQ6nCbWlu8q0Kw5MJIrME8qt79riIeov6RnGkKy3c65Fq1vuOAicYQlzaupza
         r+2DnfZ9kWZP5C/nt1F7nUbqL+5OfY/Nova525Saq/JAOGR+85kZBU4WPZVjGVQH0pDf
         RlCQ==
X-Gm-Message-State: AC+VfDxNBmcnU0iOO19hy/HYUIRa3993XEbj+71ebQc3YVxX23B/Dvge
        FsvUXtg+RjWnPtNeozaWagXs1QJGbgZmb1CTLPizBzW6U4hh
X-Google-Smtp-Source: ACHHUZ5OEU4MQF9agdtSyVSzXYeFt4mTDLm02n/PJ/vM/emyiZhcR5ZBRDcMCMU/QwNMKbOPCAmKXBWspfUD5nkbMaw+Y6PYgnm/
MIME-Version: 1.0
X-Received: by 2002:a02:7355:0:b0:40f:8f07:e28e with SMTP id
 a21-20020a027355000000b0040f8f07e28emr1835271jae.1.1683291221322; Fri, 05 May
 2023 05:53:41 -0700 (PDT)
Date:   Fri, 05 May 2023 05:53:41 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004cf5c205faf1c7f3@google.com>
Subject: [syzbot] [hardening?] [mm?] BUG: bad usercopy in fpa_set
From:   syzbot <syzbot+cb76c2983557a07cdb14@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, keescook@chromium.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    457391b03803 Linux 6.3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=105b8bb0280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=385e197a58ca4afe
dashboard link: https://syzkaller.appspot.com/bug?extid=cb76c2983557a07cdb14
compiler:       arm-linux-gnueabi-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/c35b5b2731d2/non_bootable_disk-457391b0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2a1bf3bafeb6/vmlinux-457391b0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/21f1e3b4a5a9/zImage-457391b0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cb76c2983557a07cdb14@syzkaller.appspotmail.com

usercopy: Kernel memory overwrite attempt detected to SLUB object 'task_struct' (offset 96, size 116)!
------------[ cut here ]------------
kernel BUG at mm/usercopy.c:102!
Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
Modules linked in:
CPU: 1 PID: 5423 Comm: syz-executor.1 Not tainted 6.3.0-syzkaller #0
Hardware name: ARM-Versatile Express
PC is at usercopy_abort+0x98/0x9c mm/usercopy.c:102
LR is at __wake_up_klogd.part.0+0x7c/0xac kernel/printk/printk.c:3807
pc : [<817b706c>]    lr : [<802aef04>]    psr: 60000013
sp : dfe2de58  ip : dfe2dd98  fp : dfe2de7c
r10: 0000001a  r9 : 00003109  r8 : 83109760
r7 : dde67520  r6 : 00000000  r5 : 00000074  r4 : 00000060
r3 : 00000000  r2 : 00000000  r1 : ddddc584  r0 : 00000066
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 30c5387d  Table: 8671f680  DAC: 00000000
Register r0 information: non-paged memory
Register r1 information: non-slab/vmalloc memory
Register r2 information: NULL pointer
Register r3 information: NULL pointer
Register r4 information: non-paged memory
Register r5 information: non-paged memory
Register r6 information: NULL pointer
Register r7 information: non-slab/vmalloc memory
Register r8 information: slab task_struct start 83109700 pointer offset 96 size 2944
Register r9 information: non-paged memory
Register r10 information: non-paged memory
Register r11 information: 2-page vmalloc region starting at 0xdfe2c000 allocated at kernel_clone+0x9c/0x3d4 kernel/fork.c:2683
Register r12 information: 2-page vmalloc region starting at 0xdfe2c000 allocated at kernel_clone+0x9c/0x3d4 kernel/fork.c:2683
Process syz-executor.1 (pid: 5423, stack limit = 0xdfe2c000)
Stack: (0xdfe2de58 to 0xdfe2e000)
de40:                                                       81da9fcc 81d8176c
de60: 81d94abc 00000060 00000074 00003109 dfe2deac dfe2de80 804956ec 817b6fe0
de80: 00000074 dfe2de90 80216d0c 83109760 00000074 00000000 831097d4 dde67520
dea0: dfe2dee4 dfe2deb0 804b5624 80495620 00000074 0000000f dfe2ded4 83109760
dec0: 00000074 0000000f 00000000 00000000 83108b80 0000001a dfe2defc dfe2dee8
dee0: 80209fc8 804b5454 00000000 83109700 dfe2df74 dfe2df00 8020a728 80209f44
df00: 00000000 00000000 817dae24 802756e8 dfe2df74 dfe2df20 8027c28c 817dae00
df20: dfe2df3c 00000000 00000000 83108b80 80276968 60000013 8178d188 817a1de8
df40: dfe2df5c b463d43b 00000000 83109700 00000000 b463d43b 83109700 00000000
df60: 0000000f 00000000 dfe2dfa4 dfe2df78 80251188 8020a480 00000000 b463d43b
df80: 00000000 00000000 0014c2bc 0000001a 80200288 83108b80 00000000 dfe2dfa8
dfa0: 80200060 80250f20 00000000 00000000 0000000f 0000043c 00000000 00000000
dfc0: 00000000 00000000 0014c2bc 0000001a 7edab3c2 76bcb6d0 7edab534 76bcb20c
dfe0: 76bcb020 76bcb010 00017004 0004dfb0 60000010 0000000f 00000000 00000000
Backtrace: 
[<817b6fd4>] (usercopy_abort) from [<804956ec>] (__check_heap_object+0xd8/0xf4 mm/slub.c:4762)
[<80495614>] (__check_heap_object) from [<804b5624>] (check_heap_object mm/usercopy.c:196 [inline])
[<80495614>] (__check_heap_object) from [<804b5624>] (__check_object_size mm/usercopy.c:251 [inline])
[<80495614>] (__check_heap_object) from [<804b5624>] (__check_object_size+0x1dc/0x2fc mm/usercopy.c:213)
 r8:dde67520 r7:831097d4 r6:00000000 r5:00000074 r4:83109760
[<804b5448>] (__check_object_size) from [<80209fc8>] (check_object_size include/linux/thread_info.h:215 [inline])
[<804b5448>] (__check_object_size) from [<80209fc8>] (__copy_from_user include/linux/uaccess.h:79 [inline])
[<804b5448>] (__check_object_size) from [<80209fc8>] (user_regset_copyin include/linux/regset.h:268 [inline])
[<804b5448>] (__check_object_size) from [<80209fc8>] (fpa_set+0x90/0xb0 arch/arm/kernel/ptrace.c:589)
 r10:0000001a r9:83108b80 r8:00000000 r7:00000000 r6:0000000f r5:00000074
 r4:83109760
[<80209f38>] (fpa_set) from [<8020a728>] (copy_regset_from_user include/linux/regset.h:337 [inline])
[<80209f38>] (fpa_set) from [<8020a728>] (arch_ptrace+0x2b4/0x40c arch/arm/kernel/ptrace.c:764)
 r5:83109700 r4:00000000
[<8020a474>] (arch_ptrace) from [<80251188>] (__do_sys_ptrace kernel/ptrace.c:1296 [inline])
[<8020a474>] (arch_ptrace) from [<80251188>] (sys_ptrace+0x274/0x4f4 kernel/ptrace.c:1269)
 r7:00000000 r6:0000000f r5:00000000 r4:83109700
[<80250f14>] (sys_ptrace) from [<80200060>] (ret_fast_syscall+0x0/0x1c arch/arm/mm/proc-v7.S:66)
Exception stack(0xdfe2dfa8 to 0xdfe2dff0)
dfa0:                   00000000 00000000 0000000f 0000043c 00000000 00000000
dfc0: 00000000 00000000 0014c2bc 0000001a 7edab3c2 76bcb6d0 7edab534 76bcb20c
dfe0: 76bcb020 76bcb010 00017004 0004dfb0
 r9:83108b80 r8:80200288 r7:0000001a r6:0014c2bc r5:00000000 r4:00000000
Code: e3090fd0 e34801da e58dc000 ebfff87f (e7f001f2) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	e3090fd0 	movw	r0, #40912	; 0x9fd0
   4:	e34801da 	movt	r0, #33242	; 0x81da
   8:	e58dc000 	str	ip, [sp]
   c:	ebfff87f 	bl	0xffffe210
* 10:	e7f001f2 	udf	#18 <-- trapping instruction


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
