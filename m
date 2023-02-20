Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1104D69C43A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 03:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjBTCqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 21:46:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjBTCql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 21:46:41 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F28D503
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 18:46:39 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id oe18-20020a17090b395200b00236a0d55d3aso324230pjb.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 18:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dh5qZ5wps91pEXqJ10IVEjmTrY4N2AqtLli/0UzD69M=;
        b=mf5cWFNvtbdPSuTWHk61wk6PPSiVX+IOFgyN+WOUW/YtdnG0SmJLovj0ZJPud8eEV5
         LQaB+M4AUsFFM1N1/DsnXd2GBupwYC3QAhhxxJZPXiSINdEOTl5zx3jwwMP01d1MlZU2
         YP8l9hL+W7n4SSiwmRaHON5myaOVZfLu1RcSl4wb2MpnhmlMVqk2UGHVp2Y/w7FclOkr
         mWPXwwYvGBmwPwDOj9P9q+RVqjxLnkMdxa7A23LrIncZ6meQmDm3HjNJgsoiR05tYtMi
         /ukEudAnE10c9e2Szh5mHCDy22nfW0+Usdn7VWY68aeDXVjb9JZ4I0x+/n5ATmLbr+Y1
         Sv+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dh5qZ5wps91pEXqJ10IVEjmTrY4N2AqtLli/0UzD69M=;
        b=eAthNUfwuK//1fOy6I84BS4SGOeUD7pAhBUe6jZsbIn41+xb7dPEbguXrnK8/3phnp
         xzbcbWXzaPW9UowZoWoC9YnPzLZXW5GRsneeKp2jFlNQ7N9oIdB/NNXXOqzNo1WEQHDW
         uKq0hN1sXuKXaHG0iDbg1bA4g5FIN2+XZS7XhrmT97x1EvqQH3hFLHYwzOPox2C03Kv0
         tES4MLI7JyOTMUq7tWJTaXGKw1qy1A3jUYGQJs4UV70CooxbFfF15Ms4aVOcQV+0m25g
         9t344qbfOIF+Y7RfVSbaqcc36Z+K2TGGzp57uWllDzocNy7zgJh3tatvvY9Sz/0EGg1+
         dgfg==
X-Gm-Message-State: AO0yUKU5ZbqAaVyztbTe7j6soqn8hvoHM7lpRSyyQxmSYxkU2xGE5Uic
        RJOeZS1IR58fgdNMAP0eihh3DDr0+Kz03p7gwsQ=
X-Google-Smtp-Source: AK7set8PbJhWdQhoSwW3hads4f/EdIs/dPSBkBaG1mtaHAiBpeBqyFpJzEn9yhGgbJvfSKVI29dSxmKedWKwBs1EiaQ=
X-Received: by 2002:a17:90b:2642:b0:236:76cb:99d7 with SMTP id
 pa2-20020a17090b264200b0023676cb99d7mr461953pjb.44.1676861198413; Sun, 19 Feb
 2023 18:46:38 -0800 (PST)
MIME-Version: 1.0
References: <CAJF2gTR5QFGseLOJqBbi9mMAVE5jXyva7o3--mV2j=OkGtp5GQ@mail.gmail.com>
 <mhng-b3cb21cc-7fc1-41d2-8396-b9605412a293@palmer-ri-x1c9a>
In-Reply-To: <mhng-b3cb21cc-7fc1-41d2-8396-b9605412a293@palmer-ri-x1c9a>
From:   Song Shuai <suagrfillet@gmail.com>
Date:   Mon, 20 Feb 2023 02:46:26 +0000
Message-ID: <CAAYs2=j+M3KhJdWJi6p=JBEPa854_CkbO-N7yQHWWDxrtK1cKg@mail.gmail.com>
Subject: Re: [PATCH -next V7 6/7] samples: ftrace: Add riscv support for SAMPLE_FTRACE_DIRECT[_MULTI]
To:     guoren@kernel.org
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, e.shatokhin@yadro.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        anup@brainfault.org, Paul Walmsley <paul.walmsley@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>, heiko@sntech.de,
        rostedt@goodmis.org, mhiramat@kernel.org, jolsa@redhat.com,
        bp@suse.de, jpoimboe@kernel.org, andy.chiu@sifive.com,
        linux@yadro.com
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

Hi,Guo:

Palmer Dabbelt <palmer@dabbelt.com> =E4=BA=8E2023=E5=B9=B42=E6=9C=8818=E6=
=97=A5=E5=91=A8=E5=85=AD 21:30=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, 18 Jan 2023 22:05:04 PST (-0800), guoren@kernel.org wrote:
> > Thx Evgenii & Song,
> >
> > I got it; it would be put into v8.
>
There were 2 problems for this patch in its V6 and V7 version:

1. build error resulted by including of nospec-branch.h file in V6
    - this common fixup patch had been sent to the linux-trace mail
list and would show up in Linux v6.3
    - here is the link:
https://lore.kernel.org/lkml/20230208015633.791198913@goodmis.org/

2. invalid code address reported by Evgenii in V7
    - for your convenience, the link to this updated patch is
      https://github.com/sugarfillet/linux/commit/95b174fb104dd970b982ee6fa=
19879393e229318

Is it time to launch the V8 with this updated patch, or waiting for
the common fixup patch to be merged?

> Sorry if I missed it, but I don't see a v8 on patchwork.  I queued up
> the first three patches onto for-next as they seem like pretty
> independent fixes/cleanups, I'll hold off on the others until v8.
>
> Thanks!
>
> >
> > On Wed, Jan 18, 2023 at 11:19 PM Evgenii Shatokhin
> > <e.shatokhin@yadro.com> wrote:
> >>
> >> On 18.01.2023 05:37, Song Shuai wrote:
> >> > Evgenii Shatokhin <e.shatokhin@yadro.com> =E4=BA=8E2023=E5=B9=B41=E6=
=9C=8817=E6=97=A5=E5=91=A8=E4=BA=8C 16:22=E5=86=99=E9=81=93=EF=BC=9A
> >> >>
> >> >> On 17.01.2023 16:16, Evgenii Shatokhin wrote:
> >> >>> Hi, Song,
> >> >>>
> >> >>> On 17.01.2023 12:32, Song Shuai wrote:
> >> >>>>
> >> >>>> Hi, Evgenii:
> >> >>>>
> >> >>>> Evgenii Shatokhin <e.shatokhin@yadro.com> =E4=BA=8E2023=E5=B9=B41=
=E6=9C=8816=E6=97=A5=E5=91=A8=E4=B8=80 14:30=E5=86=99=E9=81=93=EF=BC=9A
> >> >>>>
> >> >>>>>
> >> >>>>> Hi,
> >> >>>>>
> >> >>>>> On 12.01.2023 12:06, guoren@kernel.org wrote:
> >> >>>>>> From: Song Shuai <suagrfillet@gmail.com>
> >> >>>>>>
> >> >>>>>> select HAVE_SAMPLE_FTRACE_DIRECT and HAVE_SAMPLE_FTRACE_DIRECT_=
MULTI
> >> >>>>>> for ARCH_RV64I in arch/riscv/Kconfig. And add riscv asm code fo=
r
> >> >>>>>> the ftrace-direct*.c files in samples/ftrace/.
> >> >>>>>>
> >> >>>>>> Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> >> >>>>>> Tested-by: Guo Ren <guoren@kernel.org>
> >> >>>>>> Signed-off-by: Guo Ren <guoren@kernel.org>
> >> >>>>>> ---
> >> >>>>>>     arch/riscv/Kconfig                          |  2 ++
> >> >>>>>>     samples/ftrace/ftrace-direct-modify.c       | 33 ++++++++++=
++++++++
> >> >>>>>>     samples/ftrace/ftrace-direct-multi-modify.c | 37
> >> >>>>>> +++++++++++++++++++++
> >> >>>>>>     samples/ftrace/ftrace-direct-multi.c        | 22 ++++++++++=
++
> >> >>>>>>     samples/ftrace/ftrace-direct-too.c          | 26 ++++++++++=
+++++
> >> >>>>>>     samples/ftrace/ftrace-direct.c              | 22 ++++++++++=
++
> >> >>>>>>     6 files changed, 142 insertions(+)
> >> >>>>>
> >> >>>>> The samples were built OK now, but ftrace-direct-multi and
> >> >>>>> ftrace-direct-multi-modify report incorrect values of ip/pc it s=
eems.
> >> >>>>>
> >> >>>>> I ran 'insmod ftrace-direct-multi.ko', waited a little and then =
checked
> >> >>>>> the messages in the trace:
> >> >>>>>
> >> >>>>> #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> >> >>>>> #              | |         |   |||||     |         |
> >> >>>>>         migration/1-19      [001] .....  3858.532131: my_direct_=
func1: my
> >> >>>>> direct func1 ip 0
> >> >>>>>         migration/0-15      [000] d.s2.  3858.532136: my_direct_=
func1: my
> >> >>>>> direct func1 ip ff60000001ba9600
> >> >>>>>         migration/0-15      [000] d..2.  3858.532204: my_direct_=
func1: my
> >> >>>>> direct func1 ip ff60000003334d00
> >> >>>>>         migration/0-15      [000] .....  3858.532232: my_direct_=
func1: my
> >> >>>>> direct func1 ip 0
> >> >>>>>           rcu_sched-14      [001] .....  3858.532257: my_direct_=
func1: my
> >> >>>>> direct func1 ip 0
> >> >>>>>              insmod-415     [000] .....  3858.532270: my_direct_=
func1: my
> >> >>>>> direct func1 ip 7fffffffffffffff
> >> >>>>>              <idle>-0       [001] ..s1.  3858.539051: my_direct_=
func1: my
> >> >>>>> direct func1 ip ff60000001ba9600
> >> >>>>>              <idle>-0       [001] dns2.  3858.539124: my_direct_=
func1: my
> >> >>>>> direct func1 ip ff60000001ba9600
> >> >>>>>           rcu_sched-14      [001] .....  3858.539208: my_direct_=
func1: my
> >> >>>>> direct func1 ip 0
> >> >>>>> [...]
> >> >>>>>
> >> >>>>> If I understand it right, my_direct_func1() should print the add=
ress of
> >> >>>>> some location in the code, probably - at the beginning of the tr=
aced
> >> >>>>> functions.
> >> >>>>>
> >> >>>>> The printed values (0x0, 0x7fffffffffffffff, ...) are not valid =
code
> >> >>>>> addresses.
> >> >>>>>
> >> >>>> The invalid code address is only printed by accessing the schedul=
e()
> >> >>>> function's first argument whose address stores in a0 register.
> >> >>>> While schedule() actually has no parameter declared, so my_direct=
_func
> >> >>>> just prints the a0 in the context of the schedule()'s caller and
> >> >>>> the address maybe varies depending on the caller.
> >> >>>>
> >> >>>> I can't really understand why tracing the first argument of the
> >> >>>> schedule() function, but it seems nonsense at this point.
> >> >>>
> >> >>> The question is, what should be passed as the argument(s) of
> >> >>> my_direct_func() in this particular sample module. The kernel docs=
 and
> >> >>> commit logs seem to contain no info on that.
> >> >>>
> >> >>> With direct functions, I suppose, the trampoline can pass anything=
 it
> >> >>> wants to my_direct_func(), not just the arguments of the traced fu=
nction.
> >> >>>
> >> >>> I'd check what these sample modules do on x86 and would try to mat=
ch
> >> >>> that behaviour on RISC-V.
> >> >>
> >> >> I have checked ftrace-direct-multi.ko and ftrace-direct-multi-modif=
y.ko
> >> >> on 6.2-rc4 built for x86-64 - yes, ip/pc in the traced function sho=
uld
> >> >> be passed to my_direct_func().
> >> >>
> >> >> ftrace-direct-multi.ko:
> >> >> #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> >> >> #              | |         |   |||||     |         |
> >> >>             insmod-10829   [000] d.h1.  1719.518535: my_direct_func=
: ip
> >> >> ffffffff87332f45 // wake_up_process+0x5
> >> >>    rcu_tasks_kthre-11      [000] .....  1719.518696: my_direct_func=
: ip
> >> >> ffffffff8828d935 // schedule+0x5
> >> >>             insmod-10829   [000] .....  1719.518708: my_direct_func=
: ip
> >> >> ffffffff8828d935
> >> >>    systemd-journal-293     [001] .....  1719.518823: my_direct_func=
: ip
> >> >> ffffffff8828d935
> >> >>            systemd-1       [000] .....  1719.519141: my_direct_func=
: ip
> >> >> ffffffff8828d935
> >> >>             <idle>-0       [001] ..s1.  1719.521889: my_direct_func=
: ip
> >> >> ffffffff87332f45
> >> >>             <idle>-0       [000] d.s2.  1719.521901: my_direct_func=
: ip
> >> >> ffffffff87332f45
> >> >>        rcu_preempt-15      [001] .....  1719.521917: my_direct_func=
: ip
> >> >> ffffffff8828d935
> >> >> [...]
> >> >>
> >> >> The ip values are wake_up_process+0x5 and schedule+0x5, the locatio=
ns
> >> >> where the execution of the traced functions resumes after the Ftrac=
e
> >> >> trampoline has finished.
> >> >>
> >> >> The results with ftrace-direct-multi-modify.ko are similar to that.
> >> >>
> >> >> The samples look like a demonstration, that one can pass anything
> >> >> necessary to the handler in case of "direct" functions.
> >> >>
> >> >> I suppose, the RISC-V-specific asm code in these two sample modules
> >> >> could be updated to pass the saved pc value to my_direct_func() in =
a0.
> >> >
> >> > Yes, you're right.
> >> >
> >> > I added 'mv a0,t0' in front of `call my_direct_func` to pass the add=
ress of
> >> > traced function with mcount offset.
> >> >
> >> > Here is the updated patch for your reference.
> >> > https://github.com/sugarfillet/linux/commit/95b174fb104dd970b982ee6f=
a19879393e229318
> >>
> >> Thank you for the quick fix. This one looks good to me.
> >>
> >> ftrace-direct-multi*.ko now report the ip values corresponding to
> >> schedule+0x8 and wake_up_process+0x8, which is what was expected here.
> >>
> >> One more thing: please change my "Co-developed-by:" into "Tested-by:" =
in
> >> your patch, becase this is what I actually did: tested it and reported
> >> the results. I cannot take your credit for development of this patch ;=
-)
> >>
> >> Looking forward for v8 of the series.
> >> >
> >> >
> >> >>
> >> >>>
> >> >>>>
> >> >>>> As for this patch, it just impls a simple mcount (direct_caller) =
to
> >> >>>> trace kernel functions, and basically saves the necessary ABI,
> >> >>>> call the tracing function, and restores the ABI, just like other
> >> >>>> arches do.
> >> >>>> so It shouldn't be blamed.
> >> >>>>
> >> >>>> I started an independent patch to replace schedule with kick_proc=
ess
> >> >>>> to make these samples more reasonable. And It has no conflict wit=
h the
> >> >>>> current patch, so we can go on.
> >> >>>>
> >> >>>> Link:
> >> >>>> https://lore.kernel.org/linux-kernel/20230117091101.3669996-1-sua=
grfillet@gmail.com/T/#u
> >> >>>>
> >> >>>>> The same issue is with ftrace-direct-multi-modify.ko.
> >> >>>>>
> >> >>>>> Is anything missing here?
> >> >>>>>
> >> >>>>>>
> >> >>>>>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> >> >>>>>> index 307a9f413edd..e944af44f681 100644
> >> >>>>>> --- a/arch/riscv/Kconfig
> >> >>>>>> +++ b/arch/riscv/Kconfig
> >> >>>>>> @@ -112,6 +112,8 @@ config RISCV
> >> >>>>>>            select HAVE_POSIX_CPU_TIMERS_TASK_WORK
> >> >>>>>>            select HAVE_REGS_AND_STACK_ACCESS_API
> >> >>>>>>            select HAVE_FUNCTION_ARG_ACCESS_API
> >> >>>>>> +       select HAVE_SAMPLE_FTRACE_DIRECT
> >> >>>>>> +       select HAVE_SAMPLE_FTRACE_DIRECT_MULTI
> >> >>>>>>            select HAVE_STACKPROTECTOR
> >> >>>>>>            select HAVE_SYSCALL_TRACEPOINTS
> >> >>>>>>            select HAVE_RSEQ
> >> >>>>>> diff --git a/samples/ftrace/ftrace-direct-modify.c
> >> >>>>>> b/samples/ftrace/ftrace-direct-modify.c
> >> >>>>>> index de5a0f67f320..be7bf472c3c7 100644
> >> >>>>>> --- a/samples/ftrace/ftrace-direct-modify.c
> >> >>>>>> +++ b/samples/ftrace/ftrace-direct-modify.c
> >> >>>>>> @@ -23,6 +23,39 @@ extern void my_tramp2(void *);
> >> >>>>>>
> >> >>>>>>     static unsigned long my_ip =3D (unsigned long)schedule;
> >> >>>>>>
> >> >>>>>> +#ifdef CONFIG_RISCV
> >> >>>>>> +
> >> >>>>>> +asm (" .pushsection    .text, \"ax\", @progbits\n"
> >> >>>>>> +"      .type           my_tramp1, @function\n"
> >> >>>>>> +"      .globl          my_tramp1\n"
> >> >>>>>> +"   my_tramp1:\n"
> >> >>>>>> +"      addi sp,sp,-16\n"
> >> >>>>>> +"      sd   t0,0(sp)\n"
> >> >>>>>> +"      sd   ra,8(sp)\n"
> >> >>>>>> +"      call my_direct_func1\n"
> >> >>>>>> +"      ld   t0,0(sp)\n"
> >> >>>>>> +"      ld   ra,8(sp)\n"
> >> >>>>>> +"      addi sp,sp,16\n"
> >> >>>>>> +"      jr t0\n"
> >> >>>>>> +"      .size           my_tramp1, .-my_tramp1\n"
> >> >>>>>> +
> >> >>>>>> +"      .type           my_tramp2, @function\n"
> >> >>>>>> +"      .globl          my_tramp2\n"
> >> >>>>>> +"   my_tramp2:\n"
> >> >>>>>> +"      addi sp,sp,-16\n"
> >> >>>>>> +"      sd   t0,0(sp)\n"
> >> >>>>>> +"      sd   ra,8(sp)\n"
> >> >>>>>> +"      call my_direct_func2\n"
> >> >>>>>> +"      ld   t0,0(sp)\n"
> >> >>>>>> +"      ld   ra,8(sp)\n"
> >> >>>>>> +"      addi sp,sp,16\n"
> >> >>>>>> +"      jr t0\n"
> >> >>>>>> +"      .size           my_tramp2, .-my_tramp2\n"
> >> >>>>>> +"      .popsection\n"
> >> >>>>>> +);
> >> >>>>>> +
> >> >>>>>> +#endif /* CONFIG_RISCV */
> >> >>>>>> +
> >> >>>>>>     #ifdef CONFIG_X86_64
> >> >>>>>>
> >> >>>>>>     #include <asm/ibt.h>
> >> >>>>>> diff --git a/samples/ftrace/ftrace-direct-multi-modify.c
> >> >>>>>> b/samples/ftrace/ftrace-direct-multi-modify.c
> >> >>>>>> index d52370cad0b6..10884bf418f7 100644
> >> >>>>>> --- a/samples/ftrace/ftrace-direct-multi-modify.c
> >> >>>>>> +++ b/samples/ftrace/ftrace-direct-multi-modify.c
> >> >>>>>> @@ -21,6 +21,43 @@ void my_direct_func2(unsigned long ip)
> >> >>>>>>     extern void my_tramp1(void *);
> >> >>>>>>     extern void my_tramp2(void *);
> >> >>>>>>
> >> >>>>>> +#ifdef CONFIG_RISCV
> >> >>>>>> +
> >> >>>>>> +asm (" .pushsection    .text, \"ax\", @progbits\n"
> >> >>>>>> +"      .type           my_tramp1, @function\n"
> >> >>>>>> +"      .globl          my_tramp1\n"
> >> >>>>>> +"   my_tramp1:\n"
> >> >>>>>> +"       addi sp,sp,-24\n"
> >> >>>>>> +"       sd   a0,0(sp)\n"
> >> >>>>>> +"       sd   t0,8(sp)\n"
> >> >>>>>> +"       sd   ra,16(sp)\n"
> >> >>>>>> +"       call my_direct_func1\n"
> >> >>>>>> +"       ld   a0,0(sp)\n"
> >> >>>>>> +"       ld   t0,8(sp)\n"
> >> >>>>>> +"       ld   ra,16(sp)\n"
> >> >>>>>> +"       addi sp,sp,24\n"
> >> >>>>>> +"      jr t0\n"
> >> >>>>>> +"      .size           my_tramp1, .-my_tramp1\n"
> >> >>>>>> +
> >> >>>>>> +"      .type           my_tramp2, @function\n"
> >> >>>>>> +"      .globl          my_tramp2\n"
> >> >>>>>> +"   my_tramp2:\n"
> >> >>>>>> +"       addi sp,sp,-24\n"
> >> >>>>>> +"       sd   a0,0(sp)\n"
> >> >>>>>> +"       sd   t0,8(sp)\n"
> >> >>>>>> +"       sd   ra,16(sp)\n"
> >> >>>>>> +"       call my_direct_func2\n"
> >> >>>>>> +"       ld   a0,0(sp)\n"
> >> >>>>>> +"       ld   t0,8(sp)\n"
> >> >>>>>> +"       ld   ra,16(sp)\n"
> >> >>>>>> +"       addi sp,sp,24\n"
> >> >>>>>> +"      jr t0\n"
> >> >>>>>> +"      .size           my_tramp2, .-my_tramp2\n"
> >> >>>>>> +"      .popsection\n"
> >> >>>>>> +);
> >> >>>>>> +
> >> >>>>>> +#endif /* CONFIG_RISCV */
> >> >>>>>> +
> >> >>>>>>     #ifdef CONFIG_X86_64
> >> >>>>>>
> >> >>>>>>     #include <asm/ibt.h>
> >> >>>>>> diff --git a/samples/ftrace/ftrace-direct-multi.c
> >> >>>>>> b/samples/ftrace/ftrace-direct-multi.c
> >> >>>>>> index ec1088922517..a35bf43bf6d7 100644
> >> >>>>>> --- a/samples/ftrace/ftrace-direct-multi.c
> >> >>>>>> +++ b/samples/ftrace/ftrace-direct-multi.c
> >> >>>>>> @@ -16,6 +16,28 @@ void my_direct_func(unsigned long ip)
> >> >>>>>>
> >> >>>>>>     extern void my_tramp(void *);
> >> >>>>>>
> >> >>>>>> +#ifdef CONFIG_RISCV
> >> >>>>>> +
> >> >>>>>> +asm ("       .pushsection    .text, \"ax\", @progbits\n"
> >> >>>>>> +"       .type           my_tramp, @function\n"
> >> >>>>>> +"       .globl          my_tramp\n"
> >> >>>>>> +"   my_tramp:\n"
> >> >>>>>> +"       addi sp,sp,-24\n"
> >> >>>>>> +"       sd   a0,0(sp)\n"
> >> >>>>>> +"       sd   t0,8(sp)\n"
> >> >>>>>> +"       sd   ra,16(sp)\n"
> >> >>>>>> +"       call my_direct_func\n"
> >> >>>>>> +"       ld   a0,0(sp)\n"
> >> >>>>>> +"       ld   t0,8(sp)\n"
> >> >>>>>> +"       ld   ra,16(sp)\n"
> >> >>>>>> +"       addi sp,sp,24\n"
> >> >>>>>> +"       jr t0\n"
> >> >>>>>> +"       .size           my_tramp, .-my_tramp\n"
> >> >>>>>> +"       .popsection\n"
> >> >>>>>> +);
> >> >>>>>> +
> >> >>>>>> +#endif /* CONFIG_RISCV */
> >> >>>>>> +
> >> >>>>>>     #ifdef CONFIG_X86_64
> >> >>>>>>
> >> >>>>>>     #include <asm/ibt.h>
> >> >>>>>> diff --git a/samples/ftrace/ftrace-direct-too.c
> >> >>>>>> b/samples/ftrace/ftrace-direct-too.c
> >> >>>>>> index e13fb59a2b47..3b62e33c2e6d 100644
> >> >>>>>> --- a/samples/ftrace/ftrace-direct-too.c
> >> >>>>>> +++ b/samples/ftrace/ftrace-direct-too.c
> >> >>>>>> @@ -18,6 +18,32 @@ void my_direct_func(struct vm_area_struct *v=
ma,
> >> >>>>>>
> >> >>>>>>     extern void my_tramp(void *);
> >> >>>>>>
> >> >>>>>> +#ifdef CONFIG_RISCV
> >> >>>>>> +
> >> >>>>>> +asm ("       .pushsection    .text, \"ax\", @progbits\n"
> >> >>>>>> +"       .type           my_tramp, @function\n"
> >> >>>>>> +"       .globl          my_tramp\n"
> >> >>>>>> +"   my_tramp:\n"
> >> >>>>>> +"       addi sp,sp,-40\n"
> >> >>>>>> +"       sd   a0,0(sp)\n"
> >> >>>>>> +"       sd   a1,8(sp)\n"
> >> >>>>>> +"       sd   a2,16(sp)\n"
> >> >>>>>> +"       sd   t0,24(sp)\n"
> >> >>>>>> +"       sd   ra,32(sp)\n"
> >> >>>>>> +"       call my_direct_func\n"
> >> >>>>>> +"       ld   a0,0(sp)\n"
> >> >>>>>> +"       ld   a1,8(sp)\n"
> >> >>>>>> +"       ld   a2,16(sp)\n"
> >> >>>>>> +"       ld   t0,24(sp)\n"
> >> >>>>>> +"       ld   ra,32(sp)\n"
> >> >>>>>> +"       addi sp,sp,40\n"
> >> >>>>>> +"       jr t0\n"
> >> >>>>>> +"       .size           my_tramp, .-my_tramp\n"
> >> >>>>>> +"       .popsection\n"
> >> >>>>>> +);
> >> >>>>>> +
> >> >>>>>> +#endif /* CONFIG_RISCV */
> >> >>>>>> +
> >> >>>>>>     #ifdef CONFIG_X86_64
> >> >>>>>>
> >> >>>>>>     #include <asm/ibt.h>
> >> >>>>>> diff --git a/samples/ftrace/ftrace-direct.c
> >> >>>>>> b/samples/ftrace/ftrace-direct.c
> >> >>>>>> index 1f769d0db20f..2cfe5a7d2d70 100644
> >> >>>>>> --- a/samples/ftrace/ftrace-direct.c
> >> >>>>>> +++ b/samples/ftrace/ftrace-direct.c
> >> >>>>>> @@ -15,6 +15,28 @@ void my_direct_func(struct task_struct *p)
> >> >>>>>>
> >> >>>>>>     extern void my_tramp(void *);
> >> >>>>>>
> >> >>>>>> +#ifdef CONFIG_RISCV
> >> >>>>>> +
> >> >>>>>> +asm ("       .pushsection    .text, \"ax\", @progbits\n"
> >> >>>>>> +"       .type           my_tramp, @function\n"
> >> >>>>>> +"       .globl          my_tramp\n"
> >> >>>>>> +"   my_tramp:\n"
> >> >>>>>> +"       addi sp,sp,-24\n"
> >> >>>>>> +"       sd   a0,0(sp)\n"
> >> >>>>>> +"       sd   t0,8(sp)\n"
> >> >>>>>> +"       sd   ra,16(sp)\n"
> >> >>>>>> +"       call my_direct_func\n"
> >> >>>>>> +"       ld   a0,0(sp)\n"
> >> >>>>>> +"       ld   t0,8(sp)\n"
> >> >>>>>> +"       ld   ra,16(sp)\n"
> >> >>>>>> +"       addi sp,sp,24\n"
> >> >>>>>> +"       jr t0\n"
> >> >>>>>> +"       .size           my_tramp, .-my_tramp\n"
> >> >>>>>> +"       .popsection\n"
> >> >>>>>> +);
> >> >>>>>> +
> >> >>>>>> +#endif /* CONFIG_RISCV */
> >> >>>>>> +
> >> >>>>>>     #ifdef CONFIG_X86_64
> >> >>>>>>
> >> >>>>>>     #include <asm/ibt.h>
> >> >>>>>> --
> >> >>>>>> 2.36.1
> >> >>>>
> >> >>>> --
> >> >>>> Thanks,
> >> >>>> Song
> >> >>>>
> >> >>>
> >> >>> Regards,
> >> >>> Evgenii
> >> >>
> >> >>
> >> >
> >> >
> >> > --
> >> > Thanks,
> >> > Song
> >> >
> >>
> >>
> >
> >
> > --
> > Best Regards
> >  Guo Ren



--=20
Thanks,
Song
