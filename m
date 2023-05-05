Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27296F8C39
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 00:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbjEEWF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 18:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjEEWFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 18:05:53 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0B15BA8
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 15:05:24 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3315ccc1c08so32395675ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 15:05:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683324281; x=1685916281;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+J7+yfO9iQwowOb2fU+8cvAwvoeNrgcUFoMqgj6QFPQ=;
        b=R4uxqnWqXgS1sdB1cTBlG67UUFTqq6BCZNGd/kxA0wgIDed1+xKqBkW7BLb4qZrSNo
         jXMoPfSfW/EQ4VD7mLFLjeBIxTA89ri35MRncMQzNr6Pqu/cb/K7BCOJXgJv5egqbi6L
         l3POecmac3bZayf4fAYbEHmLTy1u+zEf7MyfMyQsMgzGQXofgjQXUlW38O7UaYtKdJRv
         pdb8Y7PGrkVLA93GjUsjgIfV4zABupBkrP4sijFPB9rp+J4emx8lO7MsWWz9hega0Uct
         UUO+2EKqsqRQU7Nb7gQ+xXYcrxhdNaSzdq3R4xSAt0viotnNpOkmMdQfcpTQKDBxd7ai
         Tybw==
X-Gm-Message-State: AC+VfDz3IZygBrObcBNRqkjb3zt+275KCsZxXUNYxs2+mGy0N8+ukxxN
        7aC0NvPon+mbKMEp7LrX5IdwCJYdUtGJlDjyx0ogt3OhgR/H
X-Google-Smtp-Source: ACHHUZ4J4pOqeQDTsw8ooN6ROqhe8y6M7rcf444td77qiJnU0II0J00mwuV7uUjJHR+VAbb92MndJmO10oWu7foLCP3bop22exMD
MIME-Version: 1.0
X-Received: by 2002:a92:cf05:0:b0:326:61cb:5f3b with SMTP id
 c5-20020a92cf05000000b0032661cb5f3bmr1405761ilo.3.1683324281223; Fri, 05 May
 2023 15:04:41 -0700 (PDT)
Date:   Fri, 05 May 2023 15:04:41 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d3001a05faf979c8@google.com>
Subject: [syzbot] upstream boot error: BUG: unable to handle kernel NULL
 pointer dereference in load_balance
From:   syzbot <syzbot+d4b00edc2d0c910d4bf4@syzkaller.appspotmail.com>
To:     andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org,
        linux@rasmusvillemoes.dk, syzkaller-bugs@googlegroups.com,
        yury.norov@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    1a5304fecee5 Merge tag 'parisc-for-6.4-1' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=125e1e5c280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=124f13edd5df0b0d
dashboard link: https://syzkaller.appspot.com/bug?extid=d4b00edc2d0c910d4bf4
compiler:       arm-linux-gnueabi-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d4b00edc2d0c910d4bf4@syzkaller.appspotmail.com

8<--- cut here ---
Unable to handle kernel NULL pointer dereference at virtual address 00000018 when read
[00000018] *pgd=80000080004003, *pmd=00000000
Internal error: Oops: 207 [#1] PREEMPT SMP ARM
Modules linked in:
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.3.0-syzkaller #0
Hardware name: ARM-Versatile Express
PC is at find_next_and_bit include/linux/find.h:93 [inline]
PC is at should_we_balance kernel/sched/fair.c:10717 [inline]
PC is at load_balance+0x130/0xcdc kernel/sched/fair.c:10760
LR is at load_balance+0x78/0xcdc kernel/sched/fair.c:10743
pc : [<8028b604>]    lr : [<8028b54c>]    psr: 80000113
sp : df805df8  ip : df805e84  fp : df805ebc
r10: 8309a800  r9 : df805e84  r8 : 00000001
r7 : 8309a800  r6 : ddddb400  r5 : 830b4640  r4 : 00000001
r3 : 00000000  r2 : ddddb400  r1 : 00000000  r0 : df805e48
Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 30c5387d  Table: 847ac040  DAC: 00000000
Register r0 information:
8<--- cut here ---
Unable to handle kernel paging request at virtual address df96bff8 when read
[df96bff8] *pgd=80000080007003, *pmd=83093003, *pte=8261d0a800000000
Internal error: Oops: 207 [#2] PREEMPT SMP ARM
Modules linked in:
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.3.0-syzkaller #0
Hardware name: ARM-Versatile Express
PC is at __find_vmap_area mm/vmalloc.c:841 [inline]
PC is at find_vmap_area mm/vmalloc.c:1862 [inline]
PC is at find_vm_area mm/vmalloc.c:2623 [inline]
PC is at vmalloc_dump_obj+0x38/0xb4 mm/vmalloc.c:4221
LR is at __raw_spin_lock include/linux/spinlock_api_smp.h:132 [inline]
LR is at _raw_spin_lock+0x18/0x58 kernel/locking/spinlock.c:154
pc : [<8047a200>]    lr : [<818015f4>]    psr: a0000193
sp : df805c88  ip : df805c70  fp : df805c9c
r10: 831f4680  r9 : 8261c9a4  r8 : 8285041c
r7 : 60000113  r6 : 00000001  r5 : df806000  r4 : df96c000
r3 : 00000000  r2 : 00002268  r1 : 00000000  r0 : 00000001
Flags: NzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 30c5387d  Table: 847ac040  DAC: 00000000


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
