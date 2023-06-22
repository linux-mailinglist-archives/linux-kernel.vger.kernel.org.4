Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0905373A581
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 18:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjFVQEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 12:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjFVQEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 12:04:20 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75961199E
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 09:04:18 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b46d4e1b0aso82698661fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 09:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687449856; x=1690041856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a/SgzXZ0TBTm01FfDbwTvq8OddR5KKABN33CLsqMtaU=;
        b=sxamR5onssyylFvA1MF7+5wyf3UJPbIAxPO7DH3Ivx+Bqp2m+fpOOQ2BC62lAqTBw1
         UmdK0q6I04voD/UVrQni5ltCKwwqEXI6UfBcnoo6tNRhvEqYeZ1BplegAVTxmgPKdDHg
         1MbRr2BqQDwBezc1NAam6Ri7MINNtRCnwcgTxl/ZBihsLgBZYuAN+Wf4he7XCxkC3q6m
         QszSNlWhLFtU7MvNpmBUK8m/JiwLbqcC3+INEi9krDwFB7LORR7UgmeFU0+c7g5neVem
         JMEZGksSf1G3d+VJOysF3vY8I+GQ4egdvAbXzQsMdNUtu6iqwS1B+6YyyV3n6b/CQ8QK
         ECkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687449856; x=1690041856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a/SgzXZ0TBTm01FfDbwTvq8OddR5KKABN33CLsqMtaU=;
        b=SNrwZ1o1EOFYO5cpU5RJJjvXZcD7XNzAaBQYg6QsyJonGu6KaAhF0P+PAuhrtkyrVP
         toZNrAH16qIxUFRP6HS8F7U7BcMOVdvz2jZ4uHvxKXFLv5acfSDLO5/9MczRjrYPkN7E
         rrby/JNS1Bzly/MbVmKRuglZaPTizcNBVltPEMpJMY8Rs81vJueGwWTEK06L8XPSxzpo
         ubWPSINqkQF1RR4+V/YN273VDR2KHrpo8GF+qXANIaasblBSDXgty0gB5VKTcipj67KP
         EW/ZCzFAmYfQypri3I4ci2dg0/rjgopsT90U5kSm1BYJf0dZ/RWbuMemFwh5cuoRv4lc
         LgxA==
X-Gm-Message-State: AC+VfDzTtnBFe/gLOU2P91Px8I52aDV1ZZWoQnyjvCthAJhQeWFtaCfC
        exwT2mAOcjCJgmwXO8KoqElNrGjzX94o6LCPP8pth86g6g==
X-Google-Smtp-Source: ACHHUZ7J0/L/HtJ91WqImUdKoWUxd1IoMl4x6dBaC4+KMDNIHw3So0z+4z3Zk0zkUADVabIizlnJ7vCeJeqcaed//2k=
X-Received: by 2002:a2e:9bd9:0:b0:2af:29d2:2ffe with SMTP id
 w25-20020a2e9bd9000000b002af29d22ffemr12469594ljj.15.1687449856208; Thu, 22
 Jun 2023 09:04:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230622120750.5549-1-brgerst@gmail.com> <20230622120750.5549-3-brgerst@gmail.com>
 <20230622132904.GR4253@hirez.programming.kicks-ass.net>
In-Reply-To: <20230622132904.GR4253@hirez.programming.kicks-ass.net>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Thu, 22 Jun 2023 12:04:03 -0400
Message-ID: <CAMzpN2gpT-TN8Ffbhd1Frw3Yui=JMbW6jnELVQ6GKbY_+5=ctg@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86: Rewrite ret_from_fork() in C
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        alyssa.milburn@linux.intel.com, keescook@chromium.org,
        jpoimboe@kernel.org, joao@overdrivepizza.com,
        tim.c.chen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 9:29=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Thu, Jun 22, 2023 at 08:07:50AM -0400, Brian Gerst wrote:
> > When kCFI is enabled, special handling is needed for the indirect call
> > to the kernel thread function.  Rewrite the ret_from_fork() function in
> > C so that the compiler can properly handle the indirect call.
> >
> > Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Signed-off-by: Brian Gerst <brgerst@gmail.com>
>
> This is much nicer indeed. I'll take these patches into my series and
> repost later today if you don't mind.

Yes, that's fine.

> One little niggle below..
>
> > ---
>
> > diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> > index f31e286c2977..5ee32e7e29e8 100644
> > --- a/arch/x86/entry/entry_64.S
> > +++ b/arch/x86/entry/entry_64.S
> > @@ -284,36 +284,21 @@ SYM_FUNC_END(__switch_to_asm)
> >   * r12: kernel thread arg
> >   */
> >  .pushsection .text, "ax"
> > +SYM_CODE_START(ret_from_fork_asm)
> >       UNWIND_HINT_END_OF_STACK
> >       ANNOTATE_NOENDBR // copy_thread
> >       CALL_DEPTH_ACCOUNT
> >
> > +     /* return address for the stack unwinder */
> > +     pushq   $swapgs_restore_regs_and_return_to_usermode
> > +     UNWIND_HINT_FUNC
> >
> > +     movq    %rax, %rdi              /* prev */
> > +     movq    %rsp, %rsi              /* regs */
> > +     movq    %rbx, %rdx              /* fn */
> > +     movq    %r12, %rcx              /* fn_arg */
> > +     jmp     ret_from_fork
> > +SYM_CODE_END(ret_from_fork_asm)
> >  .popsection
> >
> >  .macro DEBUG_ENTRY_ASSERT_IRQS_OFF
>
> > diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> > index dac41a0072ea..f5dbfebac076 100644
> > --- a/arch/x86/kernel/process.c
> > +++ b/arch/x86/kernel/process.c
> > @@ -28,6 +28,7 @@
> >  #include <linux/static_call.h>
> >  #include <trace/events/power.h>
> >  #include <linux/hw_breakpoint.h>
> > +#include <linux/entry-common.h>
> >  #include <asm/cpu.h>
> >  #include <asm/apic.h>
> >  #include <linux/uaccess.h>
> > @@ -134,6 +135,25 @@ static int set_new_tls(struct task_struct *p, unsi=
gned long tls)
> >               return do_set_thread_area_64(p, ARCH_SET_FS, tls);
> >  }
> >
> > +__visible noinstr void ret_from_fork(struct task_struct *prev, struct =
pt_regs *regs,
> > +                                  int (*fn)(void *), void *fn_arg)
>
> So I had noinstr in my initial patch, but it leads to objtool
> complaints. I suppose we can actually handle tracing and all the other
> gunk at this point, so I've removed it.

I'm not an expert on noinstr usage, but looking at the other syscall
functions, instrumentation needs to be disabled before
syscall_exit_to_user_mode() is called.  Perhaps adding an
instrumentation_begin()/instrumentation_end() pair to this function is
needed?

Brian Gerst
