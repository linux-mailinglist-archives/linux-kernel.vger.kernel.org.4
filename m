Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68DA638404
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 07:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiKYGd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 01:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiKYGdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 01:33:55 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035C9286E9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 22:33:55 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id s196so3188041pgs.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 22:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q/ipS5xq8tqsIVw21PIGkufcYomMyPXPLWE7IUkRZsw=;
        b=SI/dYgFfr+9OU2zMBI1hOsNYAkTmDPuJsVZZHcaNui0ExAgOR2Kxa/zRdgFcSFuFL3
         OjdZCxrDhmQZaEWvooPtgNL+OwVsH9g1OwDCIR85kwDI4RCNOZ3tXLdegdu5zPt1D8SL
         Y2uTSCUagYM8DsGVw+ipysGsEV6BziO4eAE5rRL4V2P5vUltYCojl16tq5qrj0/OBLmd
         TF2gLXa6sNCxfg/zsTalss8KYj/KrNPF5l5cMWUX2NB5e7f06NgKtsnB/Yr4sWGH6H/X
         oGS/Y1XymIlkXJwsCl8w5hU1gYdOx5gKrpWlRK6/91kALYeDnl17bHIH6WzCC1Pij0VQ
         Orjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q/ipS5xq8tqsIVw21PIGkufcYomMyPXPLWE7IUkRZsw=;
        b=y+W9LRVNDzueXi5JLOgOPS1oMP9sod6if3XC5p2PK+EA3To5OAwaVIloLiXRWZB7VW
         Tuo2UdMULKW9AKMCXdyCBCHcGZVxFrHtiIVQWE+JROSKg933Cxe8rNvk1UUGQjM/1yl9
         yf8SqQ56oS2pUZ0g57mwTOuNLdeWF1MK3jxp1zdYzNgEh12J1TFPTX+xp65BOOrGQR1D
         MEo5pInhZuG9jNqlzDn2o2YkEbQKD7FGroWbtN0GrWkpCp/OR06R6xOk2MFMG/JiqXWK
         EwpsrmLy5e6f1Jf2DxEPjJuFD7XhyA8PYs4erJ67ELbknhh9yQPtY/8SKuUi0fKRqjz2
         EkTw==
X-Gm-Message-State: ANoB5plq/pJ90t1naGFC6c12pa0p5jPPTFZQZqDjYMq1anWdxgbwahx6
        GrxEIfF6dqbE4ExX7Y4jcJYqA1AHqt2kJptFT4I=
X-Google-Smtp-Source: AA0mqf7UtjXPD9jRvkIiJ1P3N7aChtWKpM/6+/dcfib8pgz8vFMVfiUE1GG8K9D6clPKaWkHKniUyuedAgS6ZpL46aU=
X-Received: by 2002:aa7:824f:0:b0:56e:8ed7:569f with SMTP id
 e15-20020aa7824f000000b0056e8ed7569fmr9538472pfn.19.1669358034402; Thu, 24
 Nov 2022 22:33:54 -0800 (PST)
MIME-Version: 1.0
References: <20221123142025.1504030-1-suagrfillet@gmail.com>
 <20221123142025.1504030-2-suagrfillet@gmail.com> <CAJF2gTTwvApRaGhZJxOrdcjWUC9DN-WF_7EKcHXx5HZ9Jkd5EA@mail.gmail.com>
 <CAAYs2=ghhMmmrM4Bktvw9iGiajS5PLd1=Z61j2ZfhbhGUi4ekg@mail.gmail.com>
 <CAJF2gTTWSr0qYTnRORSexEHMqUt-Lj6xZd0O-fUgC+f74FfCZA@mail.gmail.com>
 <CAAYs2=ifvfY3QW07LXL+B6KH6b3EELMcXuz6ja_rYNE=G4+=qQ@mail.gmail.com> <CAJF2gTQ6hEyfpo1wTUp1UwAGP1kMpEYjLqR-fz6UrCMjHN1VuQ@mail.gmail.com>
In-Reply-To: <CAJF2gTQ6hEyfpo1wTUp1UwAGP1kMpEYjLqR-fz6UrCMjHN1VuQ@mail.gmail.com>
From:   Song Shuai <suagrfillet@gmail.com>
Date:   Fri, 25 Nov 2022 06:33:42 +0000
Message-ID: <CAAYs2=hNAwDk7=F077ityNykZJCCvGVyXsxRzZO3s7rKwOPpUg@mail.gmail.com>
Subject: Re: [PATCH 1/2] riscv/ftrace: add DYNAMIC_FTRACE_WITH_DIRECT_CALLS support
To:     Guo Ren <guoren@kernel.org>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, rostedt@goodmis.org, mhiramat@kernel.org,
        mark.rutland@arm.com, peterz@infradead.org, jolsa@redhat.com,
        bp@suse.de, jpoimboe@kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
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

Guo Ren <guoren@kernel.org> =E4=BA=8E2022=E5=B9=B411=E6=9C=8825=E6=97=A5=E5=
=91=A8=E4=BA=94 03:10=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Nov 25, 2022 at 9:53 AM Song Shuai <suagrfillet@gmail.com> wrote:
> >
> > Guo Ren <guoren@kernel.org> =E4=BA=8E2022=E5=B9=B411=E6=9C=8824=E6=97=
=A5=E5=91=A8=E5=9B=9B 15:31=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Thu, Nov 24, 2022 at 1:27 AM Song Shuai <suagrfillet@gmail.com> wr=
ote:
> > > >
> > > > Guo Ren <guoren@kernel.org> =E4=BA=8E2022=E5=B9=B411=E6=9C=8823=E6=
=97=A5=E5=91=A8=E4=B8=89 23:02=E5=86=99=E9=81=93=EF=BC=9A
> > > > >
> > > > > Cool job, thx.
> > > > >
> > > > > On Wed, Nov 23, 2022 at 10:20 PM Song Shuai <suagrfillet@gmail.co=
m> wrote:
> > > > >>
> > > > >> This patch adds DYNAMIC_FTRACE_WITH_DIRECT_CALLS support for RIS=
C-V.
> > > > >>
> > > > >> select the DYNAMIC_FTRACE_WITH_DIRECT_CALLS to provide the
> > > > >> register_ftrace_direct[_multi] interfaces allowing users to regi=
ster
> > > > >> the customed trampoline (direct_caller) as the mcount for one or
> > > > >> more target functions. And modify_ftrace_direct[_multi] are also
> > > > >> provided for modifying direct_caller.
> > > > >>
> > > > >> To make the direct_caller and the other ftrace hooks (eg. functi=
on/fgraph
> > > > >> tracer, k[ret]probes) co-exist, a temporary register is nominate=
d to
> > > > >> store the address of direct_caller in ftrace_regs_caller. After =
the
> > > > >> setting of the address direct_caller by direct_ops->func and the
> > > > >> RESTORE_REGS in ftrace_regs_caller, direct_caller will be jumped=
 to
> > > > >> by the `jr` inst.
> > > > >>
> > > > >> Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> > > > >> ---
> > > > >>  arch/riscv/Kconfig              | 1 +
> > > > >>  arch/riscv/include/asm/ftrace.h | 6 ++++++
> > > > >>  arch/riscv/kernel/mcount-dyn.S  | 4 ++++
> > > > >>  3 files changed, 11 insertions(+)
> > > > >>
> > > > >> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > > >> index 39ec8d628cf6..d083ec08d0b6 100644
> > > > >> --- a/arch/riscv/Kconfig
> > > > >> +++ b/arch/riscv/Kconfig
> > > > >> @@ -278,6 +278,7 @@ config ARCH_RV64I
> > > > >>         select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
> > > > >>         select HAVE_DYNAMIC_FTRACE if !XIP_KERNEL && MMU && $(cc=
-option,-fpatchable-function-entry=3D8)
> > > > >>         select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTR=
ACE
> > > > >> +       select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
> > > > >>         select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
> > > > >>         select HAVE_FUNCTION_GRAPH_TRACER
> > > > >>         select HAVE_FUNCTION_TRACER if !XIP_KERNEL && !PREEMPTIO=
N
> > > > >> diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/includ=
e/asm/ftrace.h
> > > > >> index 01bebb28eabe..be4d57566139 100644
> > > > >> --- a/arch/riscv/include/asm/ftrace.h
> > > > >> +++ b/arch/riscv/include/asm/ftrace.h
> > > > >> @@ -114,6 +114,12 @@ struct ftrace_regs;
> > > > >>  void ftrace_graph_func(unsigned long ip, unsigned long parent_i=
p,
> > > > >>                        struct ftrace_ops *op, struct ftrace_regs=
 *fregs);
> > > > >>  #define ftrace_graph_func ftrace_graph_func
> > > > >> +
> > > > >> +static inline void arch_ftrace_set_direct_caller(struct pt_regs=
 *regs, unsigned long addr)
> > > > >> +{
> > > > >> +               regs->t1 =3D addr;
> > > > >
> > > > > How about regs->t0 =3D addr; ?
> > > > > And delete all mcount-dyn.S modification.
> > > > >
> > > > The direct_caller has the same program layout as the ftrace_caller,=
 which means
> > > > the reg t0 will never be changed when direct_caller returns.
> > > >
> > > > If regs->t0 changes here and ftrace_regs_caller executes `jr t0`,
> > > > direct_caller will enter the dead loop.
> > > >
> > > > Actually the reg t0 always saves the address of function entry with=
 8B
> > > > offset, it should only
> > > > changed by the IPMODIFY ops instead of the direct_ops.
> > > How about:
> > > static inline void arch_ftrace_set_direct_caller(struct pt_regs *regs=
,
> > > unsigned long addr)
> > > {
> > >                regs->t1 =3D regs->t0;
> > >                regs->t0 =3D addr;
> > >
> > > direct_caller:
> > > add sp,sp,-?
> > > sd t1,?(sp)
> > direct_caller also serves as the first trampoline as ftrace_caller, lik=
e this:
> > ```
> > func -- direct_caller
> >         -- ftrace_[regs]_caller
> > ```
> > So the t1 in this line has to be t0 to save the PC.
>
> direct_caller:
> add sp,sp,-?
> sd t1,?(sp)
> sd t0, ?(so)
> sd ra,?(sp)
> mov t0, t1
This foo is the tracing function along with the direct_caller,
and it has the same parameters as the target function.
So the t0 or t1 here means nothing for this foo function.

No offense, but what's the purpose of this mv inst?
> call foo
> ld t0,?(sp)
> ld t1,?(sp)
> ld ra,?(sp)
> add sp,sp,?
> jr t1 // <- back to function entry
When direct_caller works as the first trampoline
the content of t1 here means nothing for the target function, neither
PC nor PIP.
>
>
> > > sd ra,?(sp)
> > > call foo
> > > ld t1,?(sp)
> > And this line.
> > > ld ra,?(sp)
> > > add sp,sp,?
> > > jr t1 // <- back to function entry
> > >
> > > And delete all mcount-dyn.S modification.
> > >
> > > > >>
> > > > >> +}
> > > > >> +
> > > > >>  #endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
> > > > >>
> > > > >>  #endif /* __ASSEMBLY__ */
> > > > >> diff --git a/arch/riscv/kernel/mcount-dyn.S b/arch/riscv/kernel/=
mcount-dyn.S
> > > > >> index 466c6ef217b1..b89c85a58569 100644
> > > > >> --- a/arch/riscv/kernel/mcount-dyn.S
> > > > >> +++ b/arch/riscv/kernel/mcount-dyn.S
> > > > >> @@ -233,6 +233,7 @@ ENDPROC(ftrace_caller)
> > > > >>  #else /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
> > > > >>  ENTRY(ftrace_regs_caller)
> > > > >>         SAVE_ABI_REGS 1
> > > > >> +       REG_S   x0, PT_T1(sp)
> > > > >>         PREPARE_ARGS
> > > > >>
> > > > >>  ftrace_regs_call:
> > > > >> @@ -241,7 +242,10 @@ ftrace_regs_call:
> > > > >>
> > > > >>
> > > > >>         RESTORE_ABI_REGS 1
> > > > >> +       bnez    t1,.Ldirect
> > > > >>         jr t0
> > > > >> +.Ldirect:
> > > > >> +       jr t1
> > > > >>  ENDPROC(ftrace_regs_caller)
> > > > >>
> > > > >>  ENTRY(ftrace_caller)
> > > > >> --
> > > > >> 2.20.1
> > > > >>
> > > > >
> > > > >
> > > > > --
> > > > > Best Regards
> > > > >  Guo Ren
> > >
> > >
> > >
> > > --
> > > Best Regards
> > >  Guo Ren
> > Thanks,
> > Song
>
>
>
> --
> Best Regards
>  Guo Ren
