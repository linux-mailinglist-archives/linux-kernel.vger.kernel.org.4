Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446106A3BEF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 09:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjB0IDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 03:03:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjB0IDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 03:03:07 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E4930F3;
        Mon, 27 Feb 2023 00:03:05 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id i3so5853781plg.6;
        Mon, 27 Feb 2023 00:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677484985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ELMqyzmsqH5VpTpmMJ9hkNwEUZyxC4PRNxK4KhG86nM=;
        b=hm7wf9EBP0j6pUVmUJ8GbX6Zan2fPy8DxC08Db0mosJD4hZhJ/Q6Y7R7u35RSlLmhe
         SLXSVwcenEB07/NkaY/sVVicZzW++uYRhzQM7nT9zkSqyK/4NPpmwj97rfdDbqOFS+Ir
         AIkBoNprcESRIDMWyxkvQTrVgavDMjV9VrfBJcZg+sYgAoXWVgmstnNPOkYAob7/whal
         Ed0pVpvWCiJeHrv/Qfylp2ie1Fir6QXG1s+ZoqvE0YifV6i0AHBwPYwfBjIGjosSONHN
         xkVfmXqV6SZhBl6m11HACI5quGacDD5KK4HhLAW/dalAMgNW50tIXkHVXMUBmIVxh9l4
         bnmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677484985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ELMqyzmsqH5VpTpmMJ9hkNwEUZyxC4PRNxK4KhG86nM=;
        b=XoHvdfLLtFYuguSJattzl05VzopIf3zdONpOjw6prjlgIn8AVmDh7uJr+ODrMKwuu/
         6/W7GecTpyqTgxYNiZOKFRYWkb7w1lgol5TKOZ0AxSU6/4LB3p2IeMZOujOPjr/osnqI
         lo1qs5l5MzjXkB47fZPNUEKc41KiffbFQjonilV2pg9p4ngRSS1XrHQBr6PQxBc2721E
         SYOxjAd22BPDozo45pt9XAL4eaGrmpk9WIM4uTdDsmpqjKJuhiwQVV97q6W8b6WHFvmw
         usulswFXuPvUgnyk2g8EQaqJVWsFbN3dyNKWZDjfMs9y1LLC+OJI6ISnu9P1CF3H+9O8
         CAWA==
X-Gm-Message-State: AO0yUKXQL/aJz2cpYjuwecC6E1fWRhvG9C+wRgbJVtkhXKt25lawMI9f
        r71EPYUBzViIUB0AhtMaXTkHAh2lJuJhGGW+o2A=
X-Google-Smtp-Source: AK7set/n3GKuwPNrAHCAGiQGBF97jO3gwCZ4eVFdDWmOSpYQWy5yXsVMwa+tJ3vJDXdo3wcvzqrjYFV3pf3uPCF56og=
X-Received: by 2002:a17:902:f816:b0:19a:985c:9e35 with SMTP id
 ix22-20020a170902f81600b0019a985c9e35mr5788872plb.12.1677484984885; Mon, 27
 Feb 2023 00:03:04 -0800 (PST)
MIME-Version: 1.0
References: <IA1PR07MB983057EE02C56A3FF3E0ED1BABAF9@IA1PR07MB9830.namprd07.prod.outlook.com>
In-Reply-To: <IA1PR07MB983057EE02C56A3FF3E0ED1BABAF9@IA1PR07MB9830.namprd07.prod.outlook.com>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Mon, 27 Feb 2023 16:02:53 +0800
Message-ID: <CAABZP2z+Hk_w7nAhhyhJA9zidQViibMUO_xYianfm3xcG1QQwQ@mail.gmail.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in rcu_core
To:     Sanan Hasanov <sanan.hasanov@knights.ucf.edu>
Cc:     "paulmck@kernel.org" <paulmck@kernel.org>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
        "contact@pgazz.com" <contact@pgazz.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NORMAL_HTTP_TO_IP,
        NUMERIC_HTTP_ADDR,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,WEIRD_PORT
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Mon, Feb 27, 2023 at 2:30=E2=80=AFPM Sanan Hasanov
<sanan.hasanov@knights.ucf.edu> wrote:
>
> Good day, dear maintainers,
>
> We found a bug using a modified kernel configuration file used by syzbot.
>
> We enhanced the coverage of the configuration file using our tool, klocal=
izer.
>
> Kernel Branch: 6.2.0-next-20230221
> Kernel config: https://drive.google.com/file/d/1QKAQV11zjOwISifUc-skRBoTo=
3EXhutY/view?usp=3Dshare_link
> C Reproducer: Unfortunately, there is no reproducer yet.
I downloaded 6.2.0-next-20230221 (wget
https://kernel.source.codeaurora.cn/pub/scm/linux/kernel/git/next/linux-nex=
t.git/snapshot/linux-next-next-20230221.tar.gz)
and compile the kernel using above kernel config, and started syzkaller:
http://154.220.3.120:56700/

Hope I can reproduce the bug and chase down the cause of the bug.

You are welcome ;-)
Thanks
Zhouyi
>
> Thank you!
>
> Best regards,
> Sanan Hasanov
>
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> #PF: supervisor instruction fetch in kernel mode
> #PF: error_code(0x0010) - not-present page
> PGD 53756067 P4D 53756067 PUD 0
> Oops: 0010 [#1] PREEMPT SMP KASAN
> CPU: 7 PID: 0 Comm: swapper/7 Not tainted 6.2.0-next-20230221 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/0=
1/2014
> RIP: 0010:0x0
> Code: Unable to access opcode bytes at 0xffffffffffffffd6.
> RSP: 0018:ffffc900003f8e48 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: ffff888100833900 RCX: 00000000b9582f6c
> RDX: 1ffff11020106853 RSI: ffffffff816b2769 RDI: ffff888043f64708
> RBP: 000000000000000c R08: 0000000000000000 R09: ffffffff900b895f
> R10: fffffbfff201712b R11: 000000000008e001 R12: dffffc0000000000
> R13: ffffc900003f8ec8 R14: ffff888043f64708 R15: 000000000000000b
> FS:  0000000000000000(0000) GS:ffff888119f80000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffffffffffffd6 CR3: 0000000054e64000 CR4: 0000000000350ee0
> Call Trace:
>  <IRQ>
>  rcu_core+0x85d/0x1960
>  __do_softirq+0x2e5/0xae2
>  __irq_exit_rcu+0x11d/0x190
>  irq_exit_rcu+0x9/0x20
>  sysvec_apic_timer_interrupt+0x97/0xc0
>  </IRQ>
>  <TASK>
>  asm_sysvec_apic_timer_interrupt+0x1a/0x20
> RIP: 0010:default_idle+0xf/0x20
> Code: 89 07 49 c7 c0 08 00 00 00 4d 29 c8 4c 01 c7 4c 29 c2 e9 76 ff ff f=
f cc cc cc cc f3 0f 1e fa eb 07 0f 00 2d e3 8a 34 00 fb f4 <fa> c3 66 66 2e=
 0f 1f 84 00 00 00 00 00 0f 1f 40 00 f3 0f 1e fa 65
> RSP: 0018:ffffc9000017fe00 EFLAGS: 00000202
> RAX: 0000000000dfbea1 RBX: dffffc0000000000 RCX: ffffffff89b1da9c
> RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
> RBP: 0000000000000007 R08: 0000000000000001 R09: ffff888119fb6c23
> R10: ffffed10233f6d84 R11: dffffc0000000000 R12: 0000000000000003
> R13: ffff888100833900 R14: ffffffff8e112850 R15: 0000000000000000
>  default_idle_call+0x67/0xa0
>  do_idle+0x361/0x440
>  cpu_startup_entry+0x18/0x20
>  start_secondary+0x256/0x300
>  secondary_startup_64_no_verify+0xce/0xdb
>  </TASK>
> Modules linked in:
> CR2: 0000000000000000
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:0x0
> Code: Unable to access opcode bytes at 0xffffffffffffffd6.
> RSP: 0018:ffffc900003f8e48 EFLAGS: 00010246
>
> RAX: 0000000000000000 RBX: ffff888100833900 RCX: 00000000b9582f6c
> RDX: 1ffff11020106853 RSI: ffffffff816b2769 RDI: ffff888043f64708
> RBP: 000000000000000c R08: 0000000000000000 R09: ffffffff900b895f
> R10: fffffbfff201712b R11: 000000000008e001 R12: dffffc0000000000
> R13: ffffc900003f8ec8 R14: ffff888043f64708 R15: 000000000000000b
> FS:  0000000000000000(0000) GS:ffff888119f80000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffffffffffffd6 CR3: 0000000054e64000 CR4: 0000000000350ee0
> ----------------
> Code disassembly (best guess):
>    0:   89 07                   mov    %eax,(%rdi)
>    2:   49 c7 c0 08 00 00 00    mov    $0x8,%r8
>    9:   4d 29 c8                sub    %r9,%r8
>    c:   4c 01 c7                add    %r8,%rdi
>    f:   4c 29 c2                sub    %r8,%rdx
>   12:   e9 76 ff ff ff          jmp    0xffffff8d
>   17:   cc                      int3
>   18:   cc                      int3
>   19:   cc                      int3
>   1a:   cc                      int3
>   1b:   f3 0f 1e fa             endbr64
>   1f:   eb 07                   jmp    0x28
>   21:   0f 00 2d e3 8a 34 00    verw   0x348ae3(%rip)        # 0x348b0b
>   28:   fb                      sti
>   29:   f4                      hlt
> * 2a:   fa                      cli <-- trapping instruction
>   2b:   c3                      ret
>   2c:   66 66 2e 0f 1f 84 00    data16 cs nopw 0x0(%rax,%rax,1)
>   33:   00 00 00 00
>   37:   0f 1f 40 00             nopl   0x0(%rax)
>   3b:   f3 0f 1e fa             endbr64
>   3f:   65                      gs
>
