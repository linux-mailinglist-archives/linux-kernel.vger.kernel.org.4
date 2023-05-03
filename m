Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9886F530C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 10:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjECIWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 04:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjECIWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 04:22:01 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B6549FA
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 01:21:59 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4ecb7fe8fb8so7240e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 01:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683102117; x=1685694117;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6xTIK2FYRLTvo4iXXo3qwMi7YA1zaAXBIyujxGj+MBY=;
        b=U0CjNHrW9HyTkKqp5VK71D5Tr2qqlLh0yHyZyxsqVTvhPKhyBZ5wg3n+SISq26aICM
         UBS1Uu6EnpW1FfuetHkt2hyQD16c8X6QYajAteVRHvuYoayPdqUEssM9zVogtazp+eiZ
         JcAfki3HBTuq2BUcyEvAC/WeqRX6LEB3qDzZmQRvLAfGd+Dc2hT4xWtOHKGQ0yMwaDTe
         d3URd2EQAKUSJRgJkd/3b6Y5mKQTk3Q1YC9BUtbcERUPauri6CStGsvEvwj2tt+FvlZE
         65LZSnAHeFi11OJZ7WyUAN4BBnjB34ndLlTzfLYXJ/A2RJrLi0ygmzsAGHwTqo+L6g3E
         LbVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683102117; x=1685694117;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6xTIK2FYRLTvo4iXXo3qwMi7YA1zaAXBIyujxGj+MBY=;
        b=e2bzWYnX27qs7Eok6aYq2bL+WG0DULYQHY4ymcLPFZ8+AnKcWqSDFkNOJqF7kqTEFD
         NK6t1CTwuNP3M/WsPGS97W7msv366Zg9U2RS0eloWTWUI62RaDOv+WaKtWXn2nvAeh28
         SwtBL8cGMcU2UExZXgobkVyrc26KDe8Uam4/cmuS5lKpr/cluckwXGdRoOIC1o95+RwF
         oyu0LlNAWjo7YeBwpo0zzzoHGB6GKapKudIlrEswCwJBE0jl4IyC1NqKct3sjRo6IH0R
         gkjVj+tI6sFEhU61uyLK74JVoxK7NZXJmeTu75FMU60YfSDf4fWc5+zcojlLBeNf1Gy1
         BB2g==
X-Gm-Message-State: AC+VfDx+JVx0b7xLDapkEguxUoUeOiZQSZw6e4GwoWnyDxiZkD0hdFjV
        uQ1l6kfSJw9vv4C9bEKfv9dq6kZwfKmaFcCLcGbwvA==
X-Google-Smtp-Source: ACHHUZ4aWYCwS30Mjl8epziXoNM7UJgEDBuriL9GoYRdzTtEGX7jsxHtKGg1d8L4hskiXQNkyXbWB5Ql1Ooyn/C+npw=
X-Received: by 2002:a05:6512:3d27:b0:4f0:10e6:b51 with SMTP id
 d39-20020a0565123d2700b004f010e60b51mr170992lfv.4.1683102117234; Wed, 03 May
 2023 01:21:57 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000021ca9a05fababd21@google.com>
In-Reply-To: <00000000000021ca9a05fababd21@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 3 May 2023 10:21:44 +0200
Message-ID: <CACT4Y+bw5ymJeydvpmY-M1d2ukMbYtCnQKXBXZkWOzB_mjbYrA@mail.gmail.com>
Subject: Re: [syzbot] upstream boot error: BUG: unable to handle kernel NULL
 pointer dereference in generic_handle_domain_irq
To:     syzbot <syzbot+9ccf090539dced888489@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 May 2023 at 21:13, syzbot
<syzbot+9ccf090539dced888489@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    d7b3ffe2d7e4 Merge tag 'backlight-next-6.4' of git://git.k..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=14a288c4280000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=124f13edd5df0b0d
> dashboard link: https://syzkaller.appspot.com/bug?extid=9ccf090539dced888489
> compiler:       arm-linux-gnueabi-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: arm
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+9ccf090539dced888489@syzkaller.appspotmail.com

+arm mailing list

#syz set subsystems: arm

> 8<--- cut here ---
> Unable to handle kernel NULL pointer dereference at virtual address 0000003b when read
> [0000003b] *pgd=80000080004003, *pmd=00000000
> Internal error: Oops: 207 [#1] PREEMPT SMP ARM
> Modules linked in:
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.3.0-syzkaller #0
> Hardware name: ARM-Versatile Express
> PC is at generic_handle_irq_desc include/linux/irqdesc.h:158 [inline]
> PC is at handle_irq_desc kernel/irq/irqdesc.c:651 [inline]
> PC is at generic_handle_domain_irq+0x20/0x40 kernel/irq/irqdesc.c:707
> LR is at rcu_read_unlock include/linux/rcupdate.h:805 [inline]
> LR is at __irq_resolve_mapping+0x54/0x90 kernel/irq/irqdomain.c:973
> pc : [<802b8fb8>]    lr : [<802c0e00>]    psr: a0000193
> sp : 82601e78  ip : 82601e58  fp : 82601e84
> r10: 00000000  r9 : 8261ae40  r8 : 00000000
> r7 : df80a00c  r6 : 824aebe0  r5 : df80a000  r4 : 8260cdf4
> r3 : ffffffff  r2 : 8261ae40  r1 : 0000001b  r0 : ffffffff
> Flags: NzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
> Control: 30c5387d  Table: 84a1e300  DAC: fffffffd
> Register r0 information: non-paged memory
> Register r1 information: non-paged memory
> Register r2 information: non-slab/vmalloc memory
> Register r3 information: non-paged memory
> Register r4 information: non-slab/vmalloc memory
> Register r5 information:
> 8<--- cut here ---
> Unable to handle kernel NULL pointer dereference at virtual address 000001ff when read
> [000001ff] *pgd=80000080004003, *pmd=00000000
> Internal error: Oops: 207 [#2] PREEMPT SMP ARM
> Modules linked in:
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.3.0-syzkaller #0
> Hardware name: ARM-Versatile Express
> PC is at __find_vmap_area mm/vmalloc.c:841 [inline]
> PC is at find_vmap_area mm/vmalloc.c:1862 [inline]
> PC is at find_vm_area mm/vmalloc.c:2623 [inline]
> PC is at vmalloc_dump_obj+0x38/0xb4 mm/vmalloc.c:4221
> LR is at __raw_spin_lock include/linux/spinlock_api_smp.h:132 [inline]
> LR is at _raw_spin_lock+0x18/0x58 kernel/locking/spinlock.c:154
> pc : [<8047a1f0>]    lr : [<8180165c>]    psr: 20000193
> sp : 82601d08  ip : 82601cf0  fp : 82601d1c
> r10: 8261ae40  r9 : 8261c9a4  r8 : 8285041c
> r7 : 60000193  r6 : 00000006  r5 : df80a000  r4 : 00000207
> r3 : 80216638  r2 : 00002003  r1 : 00000000  r0 : 00000001
> Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
> Control: 30c5387d  Table: 84a1e300  DAC: fffffffd
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the bug is already fixed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want to change bug's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the bug is a duplicate of another bug, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/00000000000021ca9a05fababd21%40google.com.
