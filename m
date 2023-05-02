Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081E26F4A2A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 21:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjEBTNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 15:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjEBTNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 15:13:49 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA981BD4
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 12:13:48 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-76359b8d29dso625003539f.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 12:13:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683054827; x=1685646827;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=InXp03jLWyDtxQmsmM2EOXI+3RqTMph3NW+J+ZQs6Ro=;
        b=RWDLmvp3LLKv/xorpSZxT7CuIZ9+NbWeUAIsVvsm7Bq050etOTpWzlzlHAZtpX3osE
         Z75pzNnpommVQ3lHHQO1U1SY7smosKkh0DrScjOrAKS3+eQF21ZAIefhOM5hjG+0ItM9
         uSExcCHYucaGCLpsW9yi+oUeM6GQzEt6vlqNTv2V1FObe4pzAC3taXR39MhAguZRmrR7
         pG7IOy3abPBG0ufsAdzZ33O38b+UigCjhF5/Ot3/LNlM3wn57nYTGB9iVCrPgvOW3uVy
         f1+ltuPfPO/EtepKYumH4gpTuUhosCQyL3NQBQoDUpQRYRuyp298rcBaQolpCWOyAMHI
         L+4g==
X-Gm-Message-State: AC+VfDxqkmgeAmgo4tuXQUxp+RkCUjbW/7SMOXOlosQ2a0QYIYe5YZEe
        WcYrfXYxlv8pSzc+V9ep1dPXCs56MDuoNErOlbeHcDj1eEzqW8Y=
X-Google-Smtp-Source: ACHHUZ5Ub85TDA4S/kF+Xv7sjF5yHLduMPPk7luRElDiVhjmrPYuZTl/HzGkO3MyUTZ67Qx+nH6/Ctm84A40/Fu5ZX961GTUYzbp
MIME-Version: 1.0
X-Received: by 2002:a6b:ed0f:0:b0:760:9d4c:814 with SMTP id
 n15-20020a6bed0f000000b007609d4c0814mr8574571iog.4.1683054827518; Tue, 02 May
 2023 12:13:47 -0700 (PDT)
Date:   Tue, 02 May 2023 12:13:47 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000021ca9a05fababd21@google.com>
Subject: [syzbot] upstream boot error: BUG: unable to handle kernel NULL
 pointer dereference in generic_handle_domain_irq
From:   syzbot <syzbot+9ccf090539dced888489@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
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

HEAD commit:    d7b3ffe2d7e4 Merge tag 'backlight-next-6.4' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14a288c4280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=124f13edd5df0b0d
dashboard link: https://syzkaller.appspot.com/bug?extid=9ccf090539dced888489
compiler:       arm-linux-gnueabi-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9ccf090539dced888489@syzkaller.appspotmail.com

8<--- cut here ---
Unable to handle kernel NULL pointer dereference at virtual address 0000003b when read
[0000003b] *pgd=80000080004003, *pmd=00000000
Internal error: Oops: 207 [#1] PREEMPT SMP ARM
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.3.0-syzkaller #0
Hardware name: ARM-Versatile Express
PC is at generic_handle_irq_desc include/linux/irqdesc.h:158 [inline]
PC is at handle_irq_desc kernel/irq/irqdesc.c:651 [inline]
PC is at generic_handle_domain_irq+0x20/0x40 kernel/irq/irqdesc.c:707
LR is at rcu_read_unlock include/linux/rcupdate.h:805 [inline]
LR is at __irq_resolve_mapping+0x54/0x90 kernel/irq/irqdomain.c:973
pc : [<802b8fb8>]    lr : [<802c0e00>]    psr: a0000193
sp : 82601e78  ip : 82601e58  fp : 82601e84
r10: 00000000  r9 : 8261ae40  r8 : 00000000
r7 : df80a00c  r6 : 824aebe0  r5 : df80a000  r4 : 8260cdf4
r3 : ffffffff  r2 : 8261ae40  r1 : 0000001b  r0 : ffffffff
Flags: NzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 30c5387d  Table: 84a1e300  DAC: fffffffd
Register r0 information: non-paged memory
Register r1 information: non-paged memory
Register r2 information: non-slab/vmalloc memory
Register r3 information: non-paged memory
Register r4 information: non-slab/vmalloc memory
Register r5 information:
8<--- cut here ---
Unable to handle kernel NULL pointer dereference at virtual address 000001ff when read
[000001ff] *pgd=80000080004003, *pmd=00000000
Internal error: Oops: 207 [#2] PREEMPT SMP ARM
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.3.0-syzkaller #0
Hardware name: ARM-Versatile Express
PC is at __find_vmap_area mm/vmalloc.c:841 [inline]
PC is at find_vmap_area mm/vmalloc.c:1862 [inline]
PC is at find_vm_area mm/vmalloc.c:2623 [inline]
PC is at vmalloc_dump_obj+0x38/0xb4 mm/vmalloc.c:4221
LR is at __raw_spin_lock include/linux/spinlock_api_smp.h:132 [inline]
LR is at _raw_spin_lock+0x18/0x58 kernel/locking/spinlock.c:154
pc : [<8047a1f0>]    lr : [<8180165c>]    psr: 20000193
sp : 82601d08  ip : 82601cf0  fp : 82601d1c
r10: 8261ae40  r9 : 8261c9a4  r8 : 8285041c
r7 : 60000193  r6 : 00000006  r5 : df80a000  r4 : 00000207
r3 : 80216638  r2 : 00002003  r1 : 00000000  r0 : 00000001
Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 30c5387d  Table: 84a1e300  DAC: fffffffd


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
