Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D7E73A751
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 19:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjFVRdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 13:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjFVRde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 13:33:34 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2E5195
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 10:33:33 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f8775126d3so5851644e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 10:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687455211; x=1690047211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LRjv2b09/awotCwJr+A0WsOWPteUeNaeRbJxg7FJsfk=;
        b=CKqcy1Ri/3so3+e+dJ6OzxjuXREPFUUxzJPS12sap6711zPgQyeYhCNNDLpArzOUUA
         IC8tpl2dkZKOBSDLohAinz/NVXU89G3PF6q6ZZ08JJSxZBD2S8lHE8JjrhaHUtUi5KGN
         E7PBk/ggAD4d7pdiggnrZJygNUiURBr+WV9268a337hJk3bM5sxuvQ/4Fql+WpT5hksg
         FH2Q/uUSk6w/UTThZ34jC5t02hL9zBakd2TOhuv6ntmHTbrnaapDc76D+sYAAzdL/3d6
         1LuWiYWcVs1OGE7AQZDE793p/ksTUxj/4JagNVjkIJt2yTujwSSApopLmYPT5guaulFh
         HFtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687455211; x=1690047211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LRjv2b09/awotCwJr+A0WsOWPteUeNaeRbJxg7FJsfk=;
        b=d3JAMh3In7v1YX8qg4g08KP20i+cnEKWmJRreV+qUTHCzoFABtH2nLwIbo9QQ5m5MC
         kx/RYt01fiVXMR7ItSRyx/SYu7aLp1lzRtC6V31bqwTQ0ZP3SBD123nVNpy029aKSsLV
         zsDnxFoC+nBHtx7My1TvtypXz4rlhhBn7+z54negMw7GIvle05UZE9NvZb3qXXdK8+5w
         MdOsvHU4XZ1j+EdrKYIMg0Hw966o8QO8qIjDJd6+uxqU1qRHlAucpyvQqTo4IhZKV6EQ
         ZWgb+TgT/aCUfwG4/MJJ/lW1Tg4780mid7cUcyT8temjiNAt1LUDGrI3Frl2bswbgo1k
         4iUw==
X-Gm-Message-State: AC+VfDzXYSIVoyMKJrvmSy6sBYIQYavHQYfbwKLitP608gbjaV7B2+Lv
        6d5ld2dzvq3qouEwpjcimOmCB2PvcYl8zV1lWQ==
X-Google-Smtp-Source: ACHHUZ4vd6Eu4qeAMREN+umbc3HAjHSsqrvHEekBJWjjHdqwUFQ+HkEsYd5dGJdCwpdphHZTgmYkNbZ9Uo4Z6yhnM2o=
X-Received: by 2002:a05:6512:b08:b0:4f8:5b23:5287 with SMTP id
 w8-20020a0565120b0800b004f85b235287mr6081281lfu.62.1687455211279; Thu, 22 Jun
 2023 10:33:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230622120750.5549-1-brgerst@gmail.com> <20230622120750.5549-3-brgerst@gmail.com>
 <20230622132904.GR4253@hirez.programming.kicks-ass.net> <CAMzpN2gpT-TN8Ffbhd1Frw3Yui=JMbW6jnELVQ6GKbY_+5=ctg@mail.gmail.com>
 <A3B8E321-A218-4B4A-BE05-F6FE15E34D7F@zytor.com>
In-Reply-To: <A3B8E321-A218-4B4A-BE05-F6FE15E34D7F@zytor.com>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Thu, 22 Jun 2023 13:33:19 -0400
Message-ID: <CAMzpN2gpM10We-shVFLuR_rSLt3sJMJgz5pSG614tDoSrgVbRA@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86: Rewrite ret_from_fork() in C
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, xin3.li@intel.com,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
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

On Thu, Jun 22, 2023 at 12:33=E2=80=AFPM H. Peter Anvin <hpa@zytor.com> wro=
te:
>
> On June 22, 2023 9:04:03 AM PDT, Brian Gerst <brgerst@gmail.com> wrote:
> >On Thu, Jun 22, 2023 at 9:29=E2=80=AFAM Peter Zijlstra <peterz@infradead=
.org> wrote:
> >>
> >> On Thu, Jun 22, 2023 at 08:07:50AM -0400, Brian Gerst wrote:
> >> > When kCFI is enabled, special handling is needed for the indirect ca=
ll
> >> > to the kernel thread function.  Rewrite the ret_from_fork() function=
 in
> >> > C so that the compiler can properly handle the indirect call.
> >> >
> >> > Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> >> > Signed-off-by: Brian Gerst <brgerst@gmail.com>
> >>
> >> This is much nicer indeed. I'll take these patches into my series and
> >> repost later today if you don't mind.
> >
> >Yes, that's fine.
> >
> >> One little niggle below..
> >>
> >> > ---
> >>
> >> > diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> >> > index f31e286c2977..5ee32e7e29e8 100644
> >> > --- a/arch/x86/entry/entry_64.S
> >> > +++ b/arch/x86/entry/entry_64.S
> >> > @@ -284,36 +284,21 @@ SYM_FUNC_END(__switch_to_asm)
> >> >   * r12: kernel thread arg
> >> >   */
> >> >  .pushsection .text, "ax"
> >> > +SYM_CODE_START(ret_from_fork_asm)
> >> >       UNWIND_HINT_END_OF_STACK
> >> >       ANNOTATE_NOENDBR // copy_thread
> >> >       CALL_DEPTH_ACCOUNT
> >> >
> >> > +     /* return address for the stack unwinder */
> >> > +     pushq   $swapgs_restore_regs_and_return_to_usermode
> >> > +     UNWIND_HINT_FUNC
> >> >
> >> > +     movq    %rax, %rdi              /* prev */
> >> > +     movq    %rsp, %rsi              /* regs */
> >> > +     movq    %rbx, %rdx              /* fn */
> >> > +     movq    %r12, %rcx              /* fn_arg */
> >> > +     jmp     ret_from_fork
> >> > +SYM_CODE_END(ret_from_fork_asm)
> >> >  .popsection
> >> >
> >> >  .macro DEBUG_ENTRY_ASSERT_IRQS_OFF
> >>
> >> > diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> >> > index dac41a0072ea..f5dbfebac076 100644
> >> > --- a/arch/x86/kernel/process.c
> >> > +++ b/arch/x86/kernel/process.c
> >> > @@ -28,6 +28,7 @@
> >> >  #include <linux/static_call.h>
> >> >  #include <trace/events/power.h>
> >> >  #include <linux/hw_breakpoint.h>
> >> > +#include <linux/entry-common.h>
> >> >  #include <asm/cpu.h>
> >> >  #include <asm/apic.h>
> >> >  #include <linux/uaccess.h>
> >> > @@ -134,6 +135,25 @@ static int set_new_tls(struct task_struct *p, u=
nsigned long tls)
> >> >               return do_set_thread_area_64(p, ARCH_SET_FS, tls);
> >> >  }
> >> >
> >> > +__visible noinstr void ret_from_fork(struct task_struct *prev, stru=
ct pt_regs *regs,
> >> > +                                  int (*fn)(void *), void *fn_arg)
> >>
> >> So I had noinstr in my initial patch, but it leads to objtool
> >> complaints. I suppose we can actually handle tracing and all the other
> >> gunk at this point, so I've removed it.
> >
> >I'm not an expert on noinstr usage, but looking at the other syscall
> >functions, instrumentation needs to be disabled before
> >syscall_exit_to_user_mode() is called.  Perhaps adding an
> >instrumentation_begin()/instrumentation_end() pair to this function is
> >needed?
> >
> >Brian Gerst
> >
>
> I don't have the code in front of me right now, but how does this affect =
FRED enabling? In the case of FRED, the exit path is much simpler; in the F=
RED enabling patchset we simply deal with it by alternatives-patching the t=
erminal jump after resetting the stack pointer to the standard FRED user sp=
ace exit stub (which simply pops the user space registers and executes ERET=
U.)
>
> I'm assuming this is still valid/possible after your patches, since reset=
ting the stack pointer isn't possible in C, but I wanted to double check.

It should just need to change the "pushq
$swapgs_restore_regs_and_return_to_usermode" to some other address via
an alternative.

Brian Gerst
