Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF6A69BD1A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 22:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjBRVby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 16:31:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjBRVbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 16:31:52 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321E2166D4
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 13:31:14 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id cp14so659428pfb.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 13:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MT1lfEjCfiOUvawiUFadl+DzT97DO+L2fXKAmYevv0M=;
        b=RJvEhLa7CPRIrWmUoGSoeJ+0dBnGwzhjzcGg4U+FX8akPe9x7GRZDeQDdd0RY7z00L
         8fZb9w6XL/8FXgCijK1NCTLJ3x/KAg4wkkY7HmVI3RQvGdgkZy139aPK/N6Dag3dn38e
         0lm1zjv5lKB+ppgicCUQVltNA8/NJmngWgA0N6kwWs+qOeP2iPEs14Ce8RkJqsYvc/Pt
         buOMxWPyiE4lNmVfndQHZPSYWGN1C0AhdigkMcTZf9kBxcb6OK60uBbBMcr3RBTBPjRi
         dRgV5AXMHdO6KrWPXrYVZMNYxGDGtKCkmn+TV7RKdV1420QGUeQmgm/+mfr5S/OTR6Mb
         UXNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MT1lfEjCfiOUvawiUFadl+DzT97DO+L2fXKAmYevv0M=;
        b=eWY28b82YEFgWTwlY/4HXKIpTh3eNxmsCqcql6gAtqmvL+0Gj3B9rnLzEqBKi0L5cj
         1qjO8VoDutaEhOR5NfwTn1OMXgpS/t1/l2NL9Wb8KOp87ymFBBsb4aIT1GGibvuJKOr6
         DNQV6TUl/Nk5WhcZYpByuosYg/Gj5MbQ6/cV+f6T4DvBH+j5w/g1jReM07c8/tIoDtv/
         kd08fY+4hMXPp4PzK7n6LSKnlfwK4eXJHbAo9SgBHXQ4YjOeLsTrjwYPvZyD6rZrlGZS
         DPpvB5VLfwC/xTYPAsyV6Vd5L8HWdSod1mlFFzvmw62lV9IvgqBZGxD0NcFjYjAFNzPK
         WrmA==
X-Gm-Message-State: AO0yUKVcfrm49g1Jjoq6GMvB0FS3i23uMXqDEHPP3Arbulf2TfsVqM/+
        bt0FNkq1RxKTmNhCWM2V5KWCKw==
X-Google-Smtp-Source: AK7set/e7FA3HJZBGgyictXruj7ZxATESh7tfcy5Gqx7wiF4lk92LDi3+qQR7iC4/hhGtr4AuG++OQ==
X-Received: by 2002:a62:1755:0:b0:5a8:4ba7:583c with SMTP id 82-20020a621755000000b005a84ba7583cmr4768865pfx.25.1676755810417;
        Sat, 18 Feb 2023 13:30:10 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id n12-20020a62e50c000000b00581f76c1da1sm4983021pff.191.2023.02.18.13.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Feb 2023 13:30:09 -0800 (PST)
Date:   Sat, 18 Feb 2023 13:30:09 -0800 (PST)
X-Google-Original-Date: Sat, 18 Feb 2023 13:12:12 PST (-0800)
Subject:     Re: [PATCH -next V7 6/7] samples: ftrace: Add riscv support for SAMPLE_FTRACE_DIRECT[_MULTI]
In-Reply-To: <CAJF2gTR5QFGseLOJqBbi9mMAVE5jXyva7o3--mV2j=OkGtp5GQ@mail.gmail.com>
CC:     e.shatokhin@yadro.com, suagrfillet@gmail.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        anup@brainfault.org, Paul Walmsley <paul.walmsley@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>, heiko@sntech.de,
        rostedt@goodmis.org, mhiramat@kernel.org, jolsa@redhat.com,
        bp@suse.de, jpoimboe@kernel.org, andy.chiu@sifive.com,
        linux@yadro.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     guoren@kernel.org
Message-ID: <mhng-b3cb21cc-7fc1-41d2-8396-b9605412a293@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jan 2023 22:05:04 PST (-0800), guoren@kernel.org wrote:
> Thx Evgenii & Song,
>
> I got it; it would be put into v8.

Sorry if I missed it, but I don't see a v8 on patchwork.  I queued up 
the first three patches onto for-next as they seem like pretty 
independent fixes/cleanups, I'll hold off on the others until v8.

Thanks!

>
> On Wed, Jan 18, 2023 at 11:19 PM Evgenii Shatokhin
> <e.shatokhin@yadro.com> wrote:
>>
>> On 18.01.2023 05:37, Song Shuai wrote:
>> > Evgenii Shatokhin <e.shatokhin@yadro.com> 于2023年1月17日周二 16:22写道：
>> >>
>> >> On 17.01.2023 16:16, Evgenii Shatokhin wrote:
>> >>> Hi, Song,
>> >>>
>> >>> On 17.01.2023 12:32, Song Shuai wrote:
>> >>>>
>> >>>> Hi, Evgenii:
>> >>>>
>> >>>> Evgenii Shatokhin <e.shatokhin@yadro.com> 于2023年1月16日周一 14:30写道：
>> >>>>
>> >>>>>
>> >>>>> Hi,
>> >>>>>
>> >>>>> On 12.01.2023 12:06, guoren@kernel.org wrote:
>> >>>>>> From: Song Shuai <suagrfillet@gmail.com>
>> >>>>>>
>> >>>>>> select HAVE_SAMPLE_FTRACE_DIRECT and HAVE_SAMPLE_FTRACE_DIRECT_MULTI
>> >>>>>> for ARCH_RV64I in arch/riscv/Kconfig. And add riscv asm code for
>> >>>>>> the ftrace-direct*.c files in samples/ftrace/.
>> >>>>>>
>> >>>>>> Signed-off-by: Song Shuai <suagrfillet@gmail.com>
>> >>>>>> Tested-by: Guo Ren <guoren@kernel.org>
>> >>>>>> Signed-off-by: Guo Ren <guoren@kernel.org>
>> >>>>>> ---
>> >>>>>>     arch/riscv/Kconfig                          |  2 ++
>> >>>>>>     samples/ftrace/ftrace-direct-modify.c       | 33 ++++++++++++++++++
>> >>>>>>     samples/ftrace/ftrace-direct-multi-modify.c | 37
>> >>>>>> +++++++++++++++++++++
>> >>>>>>     samples/ftrace/ftrace-direct-multi.c        | 22 ++++++++++++
>> >>>>>>     samples/ftrace/ftrace-direct-too.c          | 26 +++++++++++++++
>> >>>>>>     samples/ftrace/ftrace-direct.c              | 22 ++++++++++++
>> >>>>>>     6 files changed, 142 insertions(+)
>> >>>>>
>> >>>>> The samples were built OK now, but ftrace-direct-multi and
>> >>>>> ftrace-direct-multi-modify report incorrect values of ip/pc it seems.
>> >>>>>
>> >>>>> I ran 'insmod ftrace-direct-multi.ko', waited a little and then checked
>> >>>>> the messages in the trace:
>> >>>>>
>> >>>>> #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
>> >>>>> #              | |         |   |||||     |         |
>> >>>>>         migration/1-19      [001] .....  3858.532131: my_direct_func1: my
>> >>>>> direct func1 ip 0
>> >>>>>         migration/0-15      [000] d.s2.  3858.532136: my_direct_func1: my
>> >>>>> direct func1 ip ff60000001ba9600
>> >>>>>         migration/0-15      [000] d..2.  3858.532204: my_direct_func1: my
>> >>>>> direct func1 ip ff60000003334d00
>> >>>>>         migration/0-15      [000] .....  3858.532232: my_direct_func1: my
>> >>>>> direct func1 ip 0
>> >>>>>           rcu_sched-14      [001] .....  3858.532257: my_direct_func1: my
>> >>>>> direct func1 ip 0
>> >>>>>              insmod-415     [000] .....  3858.532270: my_direct_func1: my
>> >>>>> direct func1 ip 7fffffffffffffff
>> >>>>>              <idle>-0       [001] ..s1.  3858.539051: my_direct_func1: my
>> >>>>> direct func1 ip ff60000001ba9600
>> >>>>>              <idle>-0       [001] dns2.  3858.539124: my_direct_func1: my
>> >>>>> direct func1 ip ff60000001ba9600
>> >>>>>           rcu_sched-14      [001] .....  3858.539208: my_direct_func1: my
>> >>>>> direct func1 ip 0
>> >>>>> [...]
>> >>>>>
>> >>>>> If I understand it right, my_direct_func1() should print the address of
>> >>>>> some location in the code, probably - at the beginning of the traced
>> >>>>> functions.
>> >>>>>
>> >>>>> The printed values (0x0, 0x7fffffffffffffff, ...) are not valid code
>> >>>>> addresses.
>> >>>>>
>> >>>> The invalid code address is only printed by accessing the schedule()
>> >>>> function's first argument whose address stores in a0 register.
>> >>>> While schedule() actually has no parameter declared, so my_direct_func
>> >>>> just prints the a0 in the context of the schedule()'s caller and
>> >>>> the address maybe varies depending on the caller.
>> >>>>
>> >>>> I can't really understand why tracing the first argument of the
>> >>>> schedule() function, but it seems nonsense at this point.
>> >>>
>> >>> The question is, what should be passed as the argument(s) of
>> >>> my_direct_func() in this particular sample module. The kernel docs and
>> >>> commit logs seem to contain no info on that.
>> >>>
>> >>> With direct functions, I suppose, the trampoline can pass anything it
>> >>> wants to my_direct_func(), not just the arguments of the traced function.
>> >>>
>> >>> I'd check what these sample modules do on x86 and would try to match
>> >>> that behaviour on RISC-V.
>> >>
>> >> I have checked ftrace-direct-multi.ko and ftrace-direct-multi-modify.ko
>> >> on 6.2-rc4 built for x86-64 - yes, ip/pc in the traced function should
>> >> be passed to my_direct_func().
>> >>
>> >> ftrace-direct-multi.ko:
>> >> #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
>> >> #              | |         |   |||||     |         |
>> >>             insmod-10829   [000] d.h1.  1719.518535: my_direct_func: ip
>> >> ffffffff87332f45 // wake_up_process+0x5
>> >>    rcu_tasks_kthre-11      [000] .....  1719.518696: my_direct_func: ip
>> >> ffffffff8828d935 // schedule+0x5
>> >>             insmod-10829   [000] .....  1719.518708: my_direct_func: ip
>> >> ffffffff8828d935
>> >>    systemd-journal-293     [001] .....  1719.518823: my_direct_func: ip
>> >> ffffffff8828d935
>> >>            systemd-1       [000] .....  1719.519141: my_direct_func: ip
>> >> ffffffff8828d935
>> >>             <idle>-0       [001] ..s1.  1719.521889: my_direct_func: ip
>> >> ffffffff87332f45
>> >>             <idle>-0       [000] d.s2.  1719.521901: my_direct_func: ip
>> >> ffffffff87332f45
>> >>        rcu_preempt-15      [001] .....  1719.521917: my_direct_func: ip
>> >> ffffffff8828d935
>> >> [...]
>> >>
>> >> The ip values are wake_up_process+0x5 and schedule+0x5, the locations
>> >> where the execution of the traced functions resumes after the Ftrace
>> >> trampoline has finished.
>> >>
>> >> The results with ftrace-direct-multi-modify.ko are similar to that.
>> >>
>> >> The samples look like a demonstration, that one can pass anything
>> >> necessary to the handler in case of "direct" functions.
>> >>
>> >> I suppose, the RISC-V-specific asm code in these two sample modules
>> >> could be updated to pass the saved pc value to my_direct_func() in a0.
>> >
>> > Yes, you're right.
>> >
>> > I added 'mv a0,t0' in front of `call my_direct_func` to pass the address of
>> > traced function with mcount offset.
>> >
>> > Here is the updated patch for your reference.
>> > https://github.com/sugarfillet/linux/commit/95b174fb104dd970b982ee6fa19879393e229318
>>
>> Thank you for the quick fix. This one looks good to me.
>>
>> ftrace-direct-multi*.ko now report the ip values corresponding to
>> schedule+0x8 and wake_up_process+0x8, which is what was expected here.
>>
>> One more thing: please change my "Co-developed-by:" into "Tested-by:" in
>> your patch, becase this is what I actually did: tested it and reported
>> the results. I cannot take your credit for development of this patch ;-)
>>
>> Looking forward for v8 of the series.
>> >
>> >
>> >>
>> >>>
>> >>>>
>> >>>> As for this patch, it just impls a simple mcount (direct_caller) to
>> >>>> trace kernel functions, and basically saves the necessary ABI,
>> >>>> call the tracing function, and restores the ABI, just like other
>> >>>> arches do.
>> >>>> so It shouldn't be blamed.
>> >>>>
>> >>>> I started an independent patch to replace schedule with kick_process
>> >>>> to make these samples more reasonable. And It has no conflict with the
>> >>>> current patch, so we can go on.
>> >>>>
>> >>>> Link:
>> >>>> https://lore.kernel.org/linux-kernel/20230117091101.3669996-1-suagrfillet@gmail.com/T/#u
>> >>>>
>> >>>>> The same issue is with ftrace-direct-multi-modify.ko.
>> >>>>>
>> >>>>> Is anything missing here?
>> >>>>>
>> >>>>>>
>> >>>>>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> >>>>>> index 307a9f413edd..e944af44f681 100644
>> >>>>>> --- a/arch/riscv/Kconfig
>> >>>>>> +++ b/arch/riscv/Kconfig
>> >>>>>> @@ -112,6 +112,8 @@ config RISCV
>> >>>>>>            select HAVE_POSIX_CPU_TIMERS_TASK_WORK
>> >>>>>>            select HAVE_REGS_AND_STACK_ACCESS_API
>> >>>>>>            select HAVE_FUNCTION_ARG_ACCESS_API
>> >>>>>> +       select HAVE_SAMPLE_FTRACE_DIRECT
>> >>>>>> +       select HAVE_SAMPLE_FTRACE_DIRECT_MULTI
>> >>>>>>            select HAVE_STACKPROTECTOR
>> >>>>>>            select HAVE_SYSCALL_TRACEPOINTS
>> >>>>>>            select HAVE_RSEQ
>> >>>>>> diff --git a/samples/ftrace/ftrace-direct-modify.c
>> >>>>>> b/samples/ftrace/ftrace-direct-modify.c
>> >>>>>> index de5a0f67f320..be7bf472c3c7 100644
>> >>>>>> --- a/samples/ftrace/ftrace-direct-modify.c
>> >>>>>> +++ b/samples/ftrace/ftrace-direct-modify.c
>> >>>>>> @@ -23,6 +23,39 @@ extern void my_tramp2(void *);
>> >>>>>>
>> >>>>>>     static unsigned long my_ip = (unsigned long)schedule;
>> >>>>>>
>> >>>>>> +#ifdef CONFIG_RISCV
>> >>>>>> +
>> >>>>>> +asm (" .pushsection    .text, \"ax\", @progbits\n"
>> >>>>>> +"      .type           my_tramp1, @function\n"
>> >>>>>> +"      .globl          my_tramp1\n"
>> >>>>>> +"   my_tramp1:\n"
>> >>>>>> +"      addi sp,sp,-16\n"
>> >>>>>> +"      sd   t0,0(sp)\n"
>> >>>>>> +"      sd   ra,8(sp)\n"
>> >>>>>> +"      call my_direct_func1\n"
>> >>>>>> +"      ld   t0,0(sp)\n"
>> >>>>>> +"      ld   ra,8(sp)\n"
>> >>>>>> +"      addi sp,sp,16\n"
>> >>>>>> +"      jr t0\n"
>> >>>>>> +"      .size           my_tramp1, .-my_tramp1\n"
>> >>>>>> +
>> >>>>>> +"      .type           my_tramp2, @function\n"
>> >>>>>> +"      .globl          my_tramp2\n"
>> >>>>>> +"   my_tramp2:\n"
>> >>>>>> +"      addi sp,sp,-16\n"
>> >>>>>> +"      sd   t0,0(sp)\n"
>> >>>>>> +"      sd   ra,8(sp)\n"
>> >>>>>> +"      call my_direct_func2\n"
>> >>>>>> +"      ld   t0,0(sp)\n"
>> >>>>>> +"      ld   ra,8(sp)\n"
>> >>>>>> +"      addi sp,sp,16\n"
>> >>>>>> +"      jr t0\n"
>> >>>>>> +"      .size           my_tramp2, .-my_tramp2\n"
>> >>>>>> +"      .popsection\n"
>> >>>>>> +);
>> >>>>>> +
>> >>>>>> +#endif /* CONFIG_RISCV */
>> >>>>>> +
>> >>>>>>     #ifdef CONFIG_X86_64
>> >>>>>>
>> >>>>>>     #include <asm/ibt.h>
>> >>>>>> diff --git a/samples/ftrace/ftrace-direct-multi-modify.c
>> >>>>>> b/samples/ftrace/ftrace-direct-multi-modify.c
>> >>>>>> index d52370cad0b6..10884bf418f7 100644
>> >>>>>> --- a/samples/ftrace/ftrace-direct-multi-modify.c
>> >>>>>> +++ b/samples/ftrace/ftrace-direct-multi-modify.c
>> >>>>>> @@ -21,6 +21,43 @@ void my_direct_func2(unsigned long ip)
>> >>>>>>     extern void my_tramp1(void *);
>> >>>>>>     extern void my_tramp2(void *);
>> >>>>>>
>> >>>>>> +#ifdef CONFIG_RISCV
>> >>>>>> +
>> >>>>>> +asm (" .pushsection    .text, \"ax\", @progbits\n"
>> >>>>>> +"      .type           my_tramp1, @function\n"
>> >>>>>> +"      .globl          my_tramp1\n"
>> >>>>>> +"   my_tramp1:\n"
>> >>>>>> +"       addi sp,sp,-24\n"
>> >>>>>> +"       sd   a0,0(sp)\n"
>> >>>>>> +"       sd   t0,8(sp)\n"
>> >>>>>> +"       sd   ra,16(sp)\n"
>> >>>>>> +"       call my_direct_func1\n"
>> >>>>>> +"       ld   a0,0(sp)\n"
>> >>>>>> +"       ld   t0,8(sp)\n"
>> >>>>>> +"       ld   ra,16(sp)\n"
>> >>>>>> +"       addi sp,sp,24\n"
>> >>>>>> +"      jr t0\n"
>> >>>>>> +"      .size           my_tramp1, .-my_tramp1\n"
>> >>>>>> +
>> >>>>>> +"      .type           my_tramp2, @function\n"
>> >>>>>> +"      .globl          my_tramp2\n"
>> >>>>>> +"   my_tramp2:\n"
>> >>>>>> +"       addi sp,sp,-24\n"
>> >>>>>> +"       sd   a0,0(sp)\n"
>> >>>>>> +"       sd   t0,8(sp)\n"
>> >>>>>> +"       sd   ra,16(sp)\n"
>> >>>>>> +"       call my_direct_func2\n"
>> >>>>>> +"       ld   a0,0(sp)\n"
>> >>>>>> +"       ld   t0,8(sp)\n"
>> >>>>>> +"       ld   ra,16(sp)\n"
>> >>>>>> +"       addi sp,sp,24\n"
>> >>>>>> +"      jr t0\n"
>> >>>>>> +"      .size           my_tramp2, .-my_tramp2\n"
>> >>>>>> +"      .popsection\n"
>> >>>>>> +);
>> >>>>>> +
>> >>>>>> +#endif /* CONFIG_RISCV */
>> >>>>>> +
>> >>>>>>     #ifdef CONFIG_X86_64
>> >>>>>>
>> >>>>>>     #include <asm/ibt.h>
>> >>>>>> diff --git a/samples/ftrace/ftrace-direct-multi.c
>> >>>>>> b/samples/ftrace/ftrace-direct-multi.c
>> >>>>>> index ec1088922517..a35bf43bf6d7 100644
>> >>>>>> --- a/samples/ftrace/ftrace-direct-multi.c
>> >>>>>> +++ b/samples/ftrace/ftrace-direct-multi.c
>> >>>>>> @@ -16,6 +16,28 @@ void my_direct_func(unsigned long ip)
>> >>>>>>
>> >>>>>>     extern void my_tramp(void *);
>> >>>>>>
>> >>>>>> +#ifdef CONFIG_RISCV
>> >>>>>> +
>> >>>>>> +asm ("       .pushsection    .text, \"ax\", @progbits\n"
>> >>>>>> +"       .type           my_tramp, @function\n"
>> >>>>>> +"       .globl          my_tramp\n"
>> >>>>>> +"   my_tramp:\n"
>> >>>>>> +"       addi sp,sp,-24\n"
>> >>>>>> +"       sd   a0,0(sp)\n"
>> >>>>>> +"       sd   t0,8(sp)\n"
>> >>>>>> +"       sd   ra,16(sp)\n"
>> >>>>>> +"       call my_direct_func\n"
>> >>>>>> +"       ld   a0,0(sp)\n"
>> >>>>>> +"       ld   t0,8(sp)\n"
>> >>>>>> +"       ld   ra,16(sp)\n"
>> >>>>>> +"       addi sp,sp,24\n"
>> >>>>>> +"       jr t0\n"
>> >>>>>> +"       .size           my_tramp, .-my_tramp\n"
>> >>>>>> +"       .popsection\n"
>> >>>>>> +);
>> >>>>>> +
>> >>>>>> +#endif /* CONFIG_RISCV */
>> >>>>>> +
>> >>>>>>     #ifdef CONFIG_X86_64
>> >>>>>>
>> >>>>>>     #include <asm/ibt.h>
>> >>>>>> diff --git a/samples/ftrace/ftrace-direct-too.c
>> >>>>>> b/samples/ftrace/ftrace-direct-too.c
>> >>>>>> index e13fb59a2b47..3b62e33c2e6d 100644
>> >>>>>> --- a/samples/ftrace/ftrace-direct-too.c
>> >>>>>> +++ b/samples/ftrace/ftrace-direct-too.c
>> >>>>>> @@ -18,6 +18,32 @@ void my_direct_func(struct vm_area_struct *vma,
>> >>>>>>
>> >>>>>>     extern void my_tramp(void *);
>> >>>>>>
>> >>>>>> +#ifdef CONFIG_RISCV
>> >>>>>> +
>> >>>>>> +asm ("       .pushsection    .text, \"ax\", @progbits\n"
>> >>>>>> +"       .type           my_tramp, @function\n"
>> >>>>>> +"       .globl          my_tramp\n"
>> >>>>>> +"   my_tramp:\n"
>> >>>>>> +"       addi sp,sp,-40\n"
>> >>>>>> +"       sd   a0,0(sp)\n"
>> >>>>>> +"       sd   a1,8(sp)\n"
>> >>>>>> +"       sd   a2,16(sp)\n"
>> >>>>>> +"       sd   t0,24(sp)\n"
>> >>>>>> +"       sd   ra,32(sp)\n"
>> >>>>>> +"       call my_direct_func\n"
>> >>>>>> +"       ld   a0,0(sp)\n"
>> >>>>>> +"       ld   a1,8(sp)\n"
>> >>>>>> +"       ld   a2,16(sp)\n"
>> >>>>>> +"       ld   t0,24(sp)\n"
>> >>>>>> +"       ld   ra,32(sp)\n"
>> >>>>>> +"       addi sp,sp,40\n"
>> >>>>>> +"       jr t0\n"
>> >>>>>> +"       .size           my_tramp, .-my_tramp\n"
>> >>>>>> +"       .popsection\n"
>> >>>>>> +);
>> >>>>>> +
>> >>>>>> +#endif /* CONFIG_RISCV */
>> >>>>>> +
>> >>>>>>     #ifdef CONFIG_X86_64
>> >>>>>>
>> >>>>>>     #include <asm/ibt.h>
>> >>>>>> diff --git a/samples/ftrace/ftrace-direct.c
>> >>>>>> b/samples/ftrace/ftrace-direct.c
>> >>>>>> index 1f769d0db20f..2cfe5a7d2d70 100644
>> >>>>>> --- a/samples/ftrace/ftrace-direct.c
>> >>>>>> +++ b/samples/ftrace/ftrace-direct.c
>> >>>>>> @@ -15,6 +15,28 @@ void my_direct_func(struct task_struct *p)
>> >>>>>>
>> >>>>>>     extern void my_tramp(void *);
>> >>>>>>
>> >>>>>> +#ifdef CONFIG_RISCV
>> >>>>>> +
>> >>>>>> +asm ("       .pushsection    .text, \"ax\", @progbits\n"
>> >>>>>> +"       .type           my_tramp, @function\n"
>> >>>>>> +"       .globl          my_tramp\n"
>> >>>>>> +"   my_tramp:\n"
>> >>>>>> +"       addi sp,sp,-24\n"
>> >>>>>> +"       sd   a0,0(sp)\n"
>> >>>>>> +"       sd   t0,8(sp)\n"
>> >>>>>> +"       sd   ra,16(sp)\n"
>> >>>>>> +"       call my_direct_func\n"
>> >>>>>> +"       ld   a0,0(sp)\n"
>> >>>>>> +"       ld   t0,8(sp)\n"
>> >>>>>> +"       ld   ra,16(sp)\n"
>> >>>>>> +"       addi sp,sp,24\n"
>> >>>>>> +"       jr t0\n"
>> >>>>>> +"       .size           my_tramp, .-my_tramp\n"
>> >>>>>> +"       .popsection\n"
>> >>>>>> +);
>> >>>>>> +
>> >>>>>> +#endif /* CONFIG_RISCV */
>> >>>>>> +
>> >>>>>>     #ifdef CONFIG_X86_64
>> >>>>>>
>> >>>>>>     #include <asm/ibt.h>
>> >>>>>> --
>> >>>>>> 2.36.1
>> >>>>
>> >>>> --
>> >>>> Thanks,
>> >>>> Song
>> >>>>
>> >>>
>> >>> Regards,
>> >>> Evgenii
>> >>
>> >>
>> >
>> >
>> > --
>> > Thanks,
>> > Song
>> >
>>
>>
>
>
> -- 
> Best Regards
>  Guo Ren
