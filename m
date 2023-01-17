Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC13E66DA0F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 10:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236108AbjAQJfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 04:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236587AbjAQJdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 04:33:16 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0FD2196A
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 01:32:28 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id f3so21502291pgc.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 01:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GaFckm3cgi77/ifBG0PIxmnV3pLlsdUmu89YJ7b0Tvs=;
        b=UnseMl3Jr+iNd+vh2rR6ta5NC5dj9wuZ+ijYoXi/IfwRUEqSJToCgrJ93tRv6KptJH
         kF8NXxtBTeFmzrjvaoX2c9D2DRnupUPGDEXzAMe+AeB562SbwWJUmOsP79OqB+joT7pa
         CxpMmiyRYUZ1/tcsjsaFRuJnIyP9clwOqtIWTzx9fBXpBeVGr8mPhM5w7iCKlVO1lG7J
         ztrzxXXqNi2w40GKLvU701CCkhnuRbQ1r1vBia1ZxyrIokf4kQZOdDx2mIue9yD8VhL7
         9Wax9Cl17qcB94sOF++bA7hXX7eKYV2fvg1mSvzuVXJuiL3dt3N66lqGs3DBtp3p4tbm
         B5Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GaFckm3cgi77/ifBG0PIxmnV3pLlsdUmu89YJ7b0Tvs=;
        b=FGuvyXPuFosageJzR2bfDiaufRfS6KSlAhyT+1Y7joXFmv2mcfPwfVdQPuRbIST87A
         yX9/UxlwLgfcTCrcNI1NVURAfqxzQFGNIvcLhhvwR5CVSpVUai37XlJVykWR6/gCUNqC
         ef2yeWKlr98tbYCL1FYDkC1y5RWpgEv0Ht90XteHBT3hAfaCY7azWtwcmqtYrjRg9NBY
         47Fl8zDCQrLg7sMAIeCxFbi3iFhbPJSayywgG3tRl6nZrAulPogOFYGw/5E3TaTpPKuN
         8lwtSYswnpoWzgQ5QuwGhmKLuRQ0UBBopVemOAGWGNXDms1+MxFOOiuKaEQ+I1I4y6Gv
         QUEA==
X-Gm-Message-State: AFqh2kqmv6+2ZEIUImNj8nV0ZES8oWHLX6aPtvG2SOQPKf/rVslZm+iM
        ze1rLgbAfZsJqg0AYGI7f8uUmWbfnBOpSVUMtcI=
X-Google-Smtp-Source: AMrXdXuJQnfdi5HT6ooH4UFuSWl4muO4sUS2FMDyJTqwY2ce1f/Gdl6GFB+oeNBFZC9H4LqIZHH4ZQbI5ouJ/232YKM=
X-Received: by 2002:a63:545b:0:b0:46f:c183:2437 with SMTP id
 e27-20020a63545b000000b0046fc1832437mr138983pgm.613.1673947948124; Tue, 17
 Jan 2023 01:32:28 -0800 (PST)
MIME-Version: 1.0
References: <20230112090603.1295340-1-guoren@kernel.org> <20230112090603.1295340-7-guoren@kernel.org>
 <a83dc6de-8fda-439d-b2dd-d05786e642eb@yadro.com>
In-Reply-To: <a83dc6de-8fda-439d-b2dd-d05786e642eb@yadro.com>
From:   Song Shuai <suagrfillet@gmail.com>
Date:   Tue, 17 Jan 2023 09:32:16 +0000
Message-ID: <CAAYs2=jj2uiF3P_B1tXQTHdYOmcN7dRcMyPx2tW2kg4QWvq3Lg@mail.gmail.com>
Subject: Re: [PATCH -next V7 6/7] samples: ftrace: Add riscv support for SAMPLE_FTRACE_DIRECT[_MULTI]
To:     Evgenii Shatokhin <e.shatokhin@yadro.com>
Cc:     guoren@kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, anup@brainfault.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        conor.dooley@microchip.com, heiko@sntech.de, rostedt@goodmis.org,
        mhiramat@kernel.org, jolsa@redhat.com, bp@suse.de,
        jpoimboe@kernel.org, andy.chiu@sifive.com, linux@yadro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Evgenii:

Evgenii Shatokhin <e.shatokhin@yadro.com> =E4=BA=8E2023=E5=B9=B41=E6=9C=881=
6=E6=97=A5=E5=91=A8=E4=B8=80 14:30=E5=86=99=E9=81=93=EF=BC=9A

>
> Hi,
>
> On 12.01.2023 12:06, guoren@kernel.org wrote:
> > From: Song Shuai <suagrfillet@gmail.com>
> >
> > select HAVE_SAMPLE_FTRACE_DIRECT and HAVE_SAMPLE_FTRACE_DIRECT_MULTI
> > for ARCH_RV64I in arch/riscv/Kconfig. And add riscv asm code for
> > the ftrace-direct*.c files in samples/ftrace/.
> >
> > Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> > Tested-by: Guo Ren <guoren@kernel.org>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > ---
> >   arch/riscv/Kconfig                          |  2 ++
> >   samples/ftrace/ftrace-direct-modify.c       | 33 ++++++++++++++++++
> >   samples/ftrace/ftrace-direct-multi-modify.c | 37 ++++++++++++++++++++=
+
> >   samples/ftrace/ftrace-direct-multi.c        | 22 ++++++++++++
> >   samples/ftrace/ftrace-direct-too.c          | 26 +++++++++++++++
> >   samples/ftrace/ftrace-direct.c              | 22 ++++++++++++
> >   6 files changed, 142 insertions(+)
>
> The samples were built OK now, but ftrace-direct-multi and
> ftrace-direct-multi-modify report incorrect values of ip/pc it seems.
>
> I ran 'insmod ftrace-direct-multi.ko', waited a little and then checked
> the messages in the trace:
>
> #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> #              | |         |   |||||     |         |
>       migration/1-19      [001] .....  3858.532131: my_direct_func1: my
> direct func1 ip 0
>       migration/0-15      [000] d.s2.  3858.532136: my_direct_func1: my
> direct func1 ip ff60000001ba9600
>       migration/0-15      [000] d..2.  3858.532204: my_direct_func1: my
> direct func1 ip ff60000003334d00
>       migration/0-15      [000] .....  3858.532232: my_direct_func1: my
> direct func1 ip 0
>         rcu_sched-14      [001] .....  3858.532257: my_direct_func1: my
> direct func1 ip 0
>            insmod-415     [000] .....  3858.532270: my_direct_func1: my
> direct func1 ip 7fffffffffffffff
>            <idle>-0       [001] ..s1.  3858.539051: my_direct_func1: my
> direct func1 ip ff60000001ba9600
>            <idle>-0       [001] dns2.  3858.539124: my_direct_func1: my
> direct func1 ip ff60000001ba9600
>         rcu_sched-14      [001] .....  3858.539208: my_direct_func1: my
> direct func1 ip 0
> [...]
>
> If I understand it right, my_direct_func1() should print the address of
> some location in the code, probably - at the beginning of the traced
> functions.
>
> The printed values (0x0, 0x7fffffffffffffff, ...) are not valid code
> addresses.
>
The invalid code address is only printed by accessing the schedule()
function's first argument whose address stores in a0 register.
While schedule() actually has no parameter declared, so my_direct_func
just prints the a0 in the context of the schedule()'s caller and
the address maybe varies depending on the caller.

I can't really understand why tracing the first argument of the
schedule() function, but it seems nonsense at this point.

As for this patch, it just impls a simple mcount (direct_caller) to
trace kernel functions, and basically saves the necessary ABI,
call the tracing function, and restores the ABI, just like other arches do.
so It shouldn't be blamed.

I started an independent patch to replace schedule with kick_process
to make these samples more reasonable. And It has no conflict with the
current patch, so we can go on.

Link: https://lore.kernel.org/linux-kernel/20230117091101.3669996-1-suagrfi=
llet@gmail.com/T/#u

> The same issue is with ftrace-direct-multi-modify.ko.
>
> Is anything missing here?
>
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 307a9f413edd..e944af44f681 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -112,6 +112,8 @@ config RISCV
> >          select HAVE_POSIX_CPU_TIMERS_TASK_WORK
> >          select HAVE_REGS_AND_STACK_ACCESS_API
> >          select HAVE_FUNCTION_ARG_ACCESS_API
> > +       select HAVE_SAMPLE_FTRACE_DIRECT
> > +       select HAVE_SAMPLE_FTRACE_DIRECT_MULTI
> >          select HAVE_STACKPROTECTOR
> >          select HAVE_SYSCALL_TRACEPOINTS
> >          select HAVE_RSEQ
> > diff --git a/samples/ftrace/ftrace-direct-modify.c b/samples/ftrace/ftr=
ace-direct-modify.c
> > index de5a0f67f320..be7bf472c3c7 100644
> > --- a/samples/ftrace/ftrace-direct-modify.c
> > +++ b/samples/ftrace/ftrace-direct-modify.c
> > @@ -23,6 +23,39 @@ extern void my_tramp2(void *);
> >
> >   static unsigned long my_ip =3D (unsigned long)schedule;
> >
> > +#ifdef CONFIG_RISCV
> > +
> > +asm (" .pushsection    .text, \"ax\", @progbits\n"
> > +"      .type           my_tramp1, @function\n"
> > +"      .globl          my_tramp1\n"
> > +"   my_tramp1:\n"
> > +"      addi sp,sp,-16\n"
> > +"      sd   t0,0(sp)\n"
> > +"      sd   ra,8(sp)\n"
> > +"      call my_direct_func1\n"
> > +"      ld   t0,0(sp)\n"
> > +"      ld   ra,8(sp)\n"
> > +"      addi sp,sp,16\n"
> > +"      jr t0\n"
> > +"      .size           my_tramp1, .-my_tramp1\n"
> > +
> > +"      .type           my_tramp2, @function\n"
> > +"      .globl          my_tramp2\n"
> > +"   my_tramp2:\n"
> > +"      addi sp,sp,-16\n"
> > +"      sd   t0,0(sp)\n"
> > +"      sd   ra,8(sp)\n"
> > +"      call my_direct_func2\n"
> > +"      ld   t0,0(sp)\n"
> > +"      ld   ra,8(sp)\n"
> > +"      addi sp,sp,16\n"
> > +"      jr t0\n"
> > +"      .size           my_tramp2, .-my_tramp2\n"
> > +"      .popsection\n"
> > +);
> > +
> > +#endif /* CONFIG_RISCV */
> > +
> >   #ifdef CONFIG_X86_64
> >
> >   #include <asm/ibt.h>
> > diff --git a/samples/ftrace/ftrace-direct-multi-modify.c b/samples/ftra=
ce/ftrace-direct-multi-modify.c
> > index d52370cad0b6..10884bf418f7 100644
> > --- a/samples/ftrace/ftrace-direct-multi-modify.c
> > +++ b/samples/ftrace/ftrace-direct-multi-modify.c
> > @@ -21,6 +21,43 @@ void my_direct_func2(unsigned long ip)
> >   extern void my_tramp1(void *);
> >   extern void my_tramp2(void *);
> >
> > +#ifdef CONFIG_RISCV
> > +
> > +asm (" .pushsection    .text, \"ax\", @progbits\n"
> > +"      .type           my_tramp1, @function\n"
> > +"      .globl          my_tramp1\n"
> > +"   my_tramp1:\n"
> > +"       addi sp,sp,-24\n"
> > +"       sd   a0,0(sp)\n"
> > +"       sd   t0,8(sp)\n"
> > +"       sd   ra,16(sp)\n"
> > +"       call my_direct_func1\n"
> > +"       ld   a0,0(sp)\n"
> > +"       ld   t0,8(sp)\n"
> > +"       ld   ra,16(sp)\n"
> > +"       addi sp,sp,24\n"
> > +"      jr t0\n"
> > +"      .size           my_tramp1, .-my_tramp1\n"
> > +
> > +"      .type           my_tramp2, @function\n"
> > +"      .globl          my_tramp2\n"
> > +"   my_tramp2:\n"
> > +"       addi sp,sp,-24\n"
> > +"       sd   a0,0(sp)\n"
> > +"       sd   t0,8(sp)\n"
> > +"       sd   ra,16(sp)\n"
> > +"       call my_direct_func2\n"
> > +"       ld   a0,0(sp)\n"
> > +"       ld   t0,8(sp)\n"
> > +"       ld   ra,16(sp)\n"
> > +"       addi sp,sp,24\n"
> > +"      jr t0\n"
> > +"      .size           my_tramp2, .-my_tramp2\n"
> > +"      .popsection\n"
> > +);
> > +
> > +#endif /* CONFIG_RISCV */
> > +
> >   #ifdef CONFIG_X86_64
> >
> >   #include <asm/ibt.h>
> > diff --git a/samples/ftrace/ftrace-direct-multi.c b/samples/ftrace/ftra=
ce-direct-multi.c
> > index ec1088922517..a35bf43bf6d7 100644
> > --- a/samples/ftrace/ftrace-direct-multi.c
> > +++ b/samples/ftrace/ftrace-direct-multi.c
> > @@ -16,6 +16,28 @@ void my_direct_func(unsigned long ip)
> >
> >   extern void my_tramp(void *);
> >
> > +#ifdef CONFIG_RISCV
> > +
> > +asm ("       .pushsection    .text, \"ax\", @progbits\n"
> > +"       .type           my_tramp, @function\n"
> > +"       .globl          my_tramp\n"
> > +"   my_tramp:\n"
> > +"       addi sp,sp,-24\n"
> > +"       sd   a0,0(sp)\n"
> > +"       sd   t0,8(sp)\n"
> > +"       sd   ra,16(sp)\n"
> > +"       call my_direct_func\n"
> > +"       ld   a0,0(sp)\n"
> > +"       ld   t0,8(sp)\n"
> > +"       ld   ra,16(sp)\n"
> > +"       addi sp,sp,24\n"
> > +"       jr t0\n"
> > +"       .size           my_tramp, .-my_tramp\n"
> > +"       .popsection\n"
> > +);
> > +
> > +#endif /* CONFIG_RISCV */
> > +
> >   #ifdef CONFIG_X86_64
> >
> >   #include <asm/ibt.h>
> > diff --git a/samples/ftrace/ftrace-direct-too.c b/samples/ftrace/ftrace=
-direct-too.c
> > index e13fb59a2b47..3b62e33c2e6d 100644
> > --- a/samples/ftrace/ftrace-direct-too.c
> > +++ b/samples/ftrace/ftrace-direct-too.c
> > @@ -18,6 +18,32 @@ void my_direct_func(struct vm_area_struct *vma,
> >
> >   extern void my_tramp(void *);
> >
> > +#ifdef CONFIG_RISCV
> > +
> > +asm ("       .pushsection    .text, \"ax\", @progbits\n"
> > +"       .type           my_tramp, @function\n"
> > +"       .globl          my_tramp\n"
> > +"   my_tramp:\n"
> > +"       addi sp,sp,-40\n"
> > +"       sd   a0,0(sp)\n"
> > +"       sd   a1,8(sp)\n"
> > +"       sd   a2,16(sp)\n"
> > +"       sd   t0,24(sp)\n"
> > +"       sd   ra,32(sp)\n"
> > +"       call my_direct_func\n"
> > +"       ld   a0,0(sp)\n"
> > +"       ld   a1,8(sp)\n"
> > +"       ld   a2,16(sp)\n"
> > +"       ld   t0,24(sp)\n"
> > +"       ld   ra,32(sp)\n"
> > +"       addi sp,sp,40\n"
> > +"       jr t0\n"
> > +"       .size           my_tramp, .-my_tramp\n"
> > +"       .popsection\n"
> > +);
> > +
> > +#endif /* CONFIG_RISCV */
> > +
> >   #ifdef CONFIG_X86_64
> >
> >   #include <asm/ibt.h>
> > diff --git a/samples/ftrace/ftrace-direct.c b/samples/ftrace/ftrace-dir=
ect.c
> > index 1f769d0db20f..2cfe5a7d2d70 100644
> > --- a/samples/ftrace/ftrace-direct.c
> > +++ b/samples/ftrace/ftrace-direct.c
> > @@ -15,6 +15,28 @@ void my_direct_func(struct task_struct *p)
> >
> >   extern void my_tramp(void *);
> >
> > +#ifdef CONFIG_RISCV
> > +
> > +asm ("       .pushsection    .text, \"ax\", @progbits\n"
> > +"       .type           my_tramp, @function\n"
> > +"       .globl          my_tramp\n"
> > +"   my_tramp:\n"
> > +"       addi sp,sp,-24\n"
> > +"       sd   a0,0(sp)\n"
> > +"       sd   t0,8(sp)\n"
> > +"       sd   ra,16(sp)\n"
> > +"       call my_direct_func\n"
> > +"       ld   a0,0(sp)\n"
> > +"       ld   t0,8(sp)\n"
> > +"       ld   ra,16(sp)\n"
> > +"       addi sp,sp,24\n"
> > +"       jr t0\n"
> > +"       .size           my_tramp, .-my_tramp\n"
> > +"       .popsection\n"
> > +);
> > +
> > +#endif /* CONFIG_RISCV */
> > +
> >   #ifdef CONFIG_X86_64
> >
> >   #include <asm/ibt.h>
> > --
> > 2.36.1
> >
> >
>
> Regards,
> Evgenii
>
>


--
Thanks,
Song
