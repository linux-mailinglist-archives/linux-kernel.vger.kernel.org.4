Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7FA674A8D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 05:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjATE2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 23:28:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjATE21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 23:28:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EDEA95BC
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 20:28:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BEC3CB82544
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 15:32:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B669C433EF;
        Thu, 19 Jan 2023 15:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674142321;
        bh=QoPNuODGj6XDT3N+WFle3ns42zhE4shUpt9pFCuQY1k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NQ8HJAyivLD3sashVo5rHIEaGLBxziNN83QC1IPNteCjyMHgPl6LraKL7968FL+7f
         G/V0AmaSLfW2xFl1RyDPP2vCIjeUAAiiFJq0Q9ohabqrtKW9tizYysuEHtCO4wmUBY
         Mr1r34PBkaBfOOqP7qG2xae4G4CK0k+/mtjkwXpD3aj7QoZVgvw/1GjHH1EZzRhBuc
         Y93gEbVBLT5L1cQYo9V7R7PN9abHxKmM3I9WOIeMpziVUNZytILmSbA1F7AGMdERS+
         h03DUk8pAo85rCOG5ZP351OXo5gY3RMerg0ek5xhhfc/qRAJs1pJQhmUfCUVI5woGp
         aQYM/WJ7Smc7w==
Date:   Fri, 20 Jan 2023 00:31:56 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>,
        WANG Xuerui <kernel@xen0n.name>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 4/5] LoongArch: Mark some assembler symbols as
 non-kprobe-able
Message-Id: <20230120003156.48ca16ea2a6f73398e568358@kernel.org>
In-Reply-To: <CAAhV-H7KJTtZPC9=OZEZfQvMjd6Gw37Q3kZODk=wk9pt6VZuAQ@mail.gmail.com>
References: <1674007261-9198-1-git-send-email-yangtiezhu@loongson.cn>
        <1674007261-9198-5-git-send-email-yangtiezhu@loongson.cn>
        <CAAhV-H7Dt5MhaMU1=D9HxPFR+xjjoQG6RguaYMydy=v_jvrtiA@mail.gmail.com>
        <48f0508f-3908-c6ca-c8ba-7c12dd6b3f11@loongson.cn>
        <7f518dec-fd72-a73c-3f23-6372a83d65c2@loongson.cn>
        <6879b948-2d61-8e09-a9d4-bc2ede31c52b@loongson.cn>
        <CAAhV-H7KJTtZPC9=OZEZfQvMjd6Gw37Q3kZODk=wk9pt6VZuAQ@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jan 2023 15:17:00 +0800
Huacai Chen <chenhuacai@kernel.org> wrote:

> On Wed, Jan 18, 2023 at 2:24 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
> >
> >
> >
> > On 01/18/2023 02:05 PM, Jinyang He wrote:
> > >
> > > On 2023-01-18 12:23, Tiezhu Yang wrote:
> > >>
> > >>
> > >> On 01/18/2023 12:14 PM, Huacai Chen wrote:
> > >>> If memcpy should be blacklisted, then what about memset and memmove?
> > >>
> > >> According to the test results, there are no problems to probe
> > >> memset and memmove, so no need to blacklist them for now,
> > >> blacklist memcpy is because it may cause recursive exceptions,
> > >> there is a detailed discussion in the following link:
> > >>
> > >> https://lore.kernel.org/lkml/20230114143859.7ccc45c1c5d9ce302113ab0a@kernel.org/
> > >>
> > >
> > > Hi, Tiezhu,
> > >
> > > I cannot reproduce the results when kprobe memcpy. Could you please give
> > > some details. Emm, I just replace "kernel_clone" with "memcpy" in
> > > kprobe_example.c.
> >
> > Please remove the related "_ASM_NOKPROBE(memcpy)" code in
> > arch/loongarch/lib/memcpy.S, and then compile and update kernel,
> > execute the following cmd after reboot, I can reproduce the hang
> > problem easily (it will take a few minutes).
> >
> > modprobe kprobe_example symbol="memcpy"
> Then, why is handle_syscall different from other exception handlers?

I need to check the loongarch implementation of handle_syscall() but
I guess in that handler the register set is not completely set as
kernel one. In that case, the software breakpoint handler may not
possible to handle it correctly. So it is better to avoid probing such
"border" function by kprobes.

Thank you,

> 
> Huacai
> >
> > >
> > > And for your call trace,
> > >
> > >  handler_pre()
> > >    pr_info()
> > >      printk()
> > >       _printk()
> > >         vprintk()
> > >           vprintk_store()
> > >             memcpy()
> > >
> > > I think when we should skip this time kprobe which triggered in
> > > handler_{pre, post}. That means this time kprobe will not call
> > > handler_{pre, post} agian, and not cause recursion. I remember
> > > your codes had done this skip action. So, that's so strange if
> > > recursion in handler_{pre, post}.
> > >
> > >
> > > Thanks,
> > >
> > > Jinyang
> > >
> > >
> > >>
> > >> Thanks,
> > >> Tiezhu
> > >>
> > >>>
> > >>> Huacai
> > >>>
> > >>> On Wed, Jan 18, 2023 at 10:01 AM Tiezhu Yang <yangtiezhu@loongson.cn>
> > >>> wrote:
> > >>>>
> > >>>> Some assembler symbols are not kprobe safe, such as handle_syscall
> > >>>> (used as syscall exception handler), *memcpy* (may cause recursive
> > >>>> exceptions), they can not be instrumented, just blacklist them for
> > >>>> kprobing.
> > >>>>
> > >>>> Here is a related problem and discussion:
> > >>>> Link:
> > >>>> https://lore.kernel.org/lkml/20230114143859.7ccc45c1c5d9ce302113ab0a@kernel.org/
> > >>>>
> > >>>>
> > >>>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> > >>>> ---
> > >>>>  arch/loongarch/include/asm/asm.h | 10 ++++++++++
> > >>>>  arch/loongarch/kernel/entry.S    |  1 +
> > >>>>  arch/loongarch/lib/memcpy.S      |  3 +++
> > >>>>  3 files changed, 14 insertions(+)
> > >>>>
> > >>>> diff --git a/arch/loongarch/include/asm/asm.h
> > >>>> b/arch/loongarch/include/asm/asm.h
> > >>>> index 40eea6a..f591b32 100644
> > >>>> --- a/arch/loongarch/include/asm/asm.h
> > >>>> +++ b/arch/loongarch/include/asm/asm.h
> > >>>> @@ -188,4 +188,14 @@
> > >>>>  #define PTRLOG         3
> > >>>>  #endif
> > >>>>
> > >>>> +/* Annotate a function as being unsuitable for kprobes. */
> > >>>> +#ifdef CONFIG_KPROBES
> > >>>> +#define _ASM_NOKPROBE(name)                            \
> > >>>> +       .pushsection "_kprobe_blacklist", "aw";         \
> > >>>> +       .quad   name;                                   \
> > >>>> +       .popsection
> > >>>> +#else
> > >>>> +#define _ASM_NOKPROBE(name)
> > >>>> +#endif
> > >>>> +
> > >>>>  #endif /* __ASM_ASM_H */
> > >>>> diff --git a/arch/loongarch/kernel/entry.S
> > >>>> b/arch/loongarch/kernel/entry.S
> > >>>> index d53b631..55e23b1 100644
> > >>>> --- a/arch/loongarch/kernel/entry.S
> > >>>> +++ b/arch/loongarch/kernel/entry.S
> > >>>> @@ -67,6 +67,7 @@ SYM_FUNC_START(handle_syscall)
> > >>>>
> > >>>>         RESTORE_ALL_AND_RET
> > >>>>  SYM_FUNC_END(handle_syscall)
> > >>>> +_ASM_NOKPROBE(handle_syscall)
> > >>>>
> > >>>>  SYM_CODE_START(ret_from_fork)
> > >>>>         bl      schedule_tail           # a0 = struct task_struct *prev
> > >>>> diff --git a/arch/loongarch/lib/memcpy.S b/arch/loongarch/lib/memcpy.S
> > >>>> index 7c07d59..3b7e1de 100644
> > >>>> --- a/arch/loongarch/lib/memcpy.S
> > >>>> +++ b/arch/loongarch/lib/memcpy.S
> > >>>> @@ -17,6 +17,7 @@ SYM_FUNC_START(memcpy)
> > >>>>         ALTERNATIVE     "b __memcpy_generic", \
> > >>>>                         "b __memcpy_fast", CPU_FEATURE_UAL
> > >>>>  SYM_FUNC_END(memcpy)
> > >>>> +_ASM_NOKPROBE(memcpy)
> > >>>>
> > >>>>  EXPORT_SYMBOL(memcpy)
> > >>>>
> > >>>> @@ -41,6 +42,7 @@ SYM_FUNC_START(__memcpy_generic)
> > >>>>  2:     move    a0, a3
> > >>>>         jr      ra
> > >>>>  SYM_FUNC_END(__memcpy_generic)
> > >>>> +_ASM_NOKPROBE(__memcpy_generic)
> > >>>>
> > >>>>  /*
> > >>>>   * void *__memcpy_fast(void *dst, const void *src, size_t n)
> > >>>> @@ -93,3 +95,4 @@ SYM_FUNC_START(__memcpy_fast)
> > >>>>  3:     move    a0, a3
> > >>>>         jr      ra
> > >>>>  SYM_FUNC_END(__memcpy_fast)
> > >>>> +_ASM_NOKPROBE(__memcpy_fast)
> > >>>> --
> > >>>> 2.1.0
> > >>>>
> > >>
> >
> >


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
