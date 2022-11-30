Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A611363CFBA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 08:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbiK3HaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 02:30:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiK3HaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 02:30:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD2C30F5C
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 23:30:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27D3161A43
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 07:30:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D353C43146
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 07:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669793406;
        bh=24uFz0b68v5+VVJUu/He47zj/7dJG9dq467p9XypaeM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=th8ebr7fQaM8gfHn5sGm3/QvcQB8h3WdL04sQNGRkPWKvb9f/mdCmG0hvCSEVxHvK
         S96BK9md45sShploOxsGWeDBC39wsi5BLntrB8STf2pbPP1qtIKC4vgk1PGlOHehCq
         zUpDLtYeHweDLQB/aYsIYB/x+jjpPcecEEvCIO9o38p/PFwREaFvz3w59JMQ1keUXn
         EQzSjnlb6MNLAcgEcSbblCi4FjM53gF+4C/0FQUNf0jxwzDWiVmb64Fnsdn6VbZUue
         E9uvdIm9QS7TI9HNJDF7wZAy7NsjQntLN1JBbjBU87xNe9+PQoruVc1se3m3f48AWf
         MgoFvEaKNRr2Q==
Received: by mail-ed1-f53.google.com with SMTP id l11so22864147edb.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 23:30:06 -0800 (PST)
X-Gm-Message-State: ANoB5pnArRGsEGih3JNZL0x4oCus1pFUhNz9TYvhPSj5QQ/rNnFwaD6Z
        C3j3lwqj52GHKdVZeggrOgXNZ59A/ohSGLfvqw4=
X-Google-Smtp-Source: AA0mqf5MN2g4IJe4JEA/IqpLTHs5+DQIGo50jetRn/E+i2xurtRBNwDC/YOvpVHzxRcGhHpTzZHvXsmBqgGu6aEjoio=
X-Received: by 2002:aa7:c046:0:b0:461:54f0:f7dc with SMTP id
 k6-20020aa7c046000000b0046154f0f7dcmr54770572edo.117.1669793404614; Tue, 29
 Nov 2022 23:30:04 -0800 (PST)
MIME-Version: 1.0
References: <20221129033230.255947-1-guoren@kernel.org> <20221129033230.255947-7-guoren@kernel.org>
 <CAAYs2=hOY+ib_OYwUfnM10kwyqte7C7=efTL00VkVKHWM9HbAw@mail.gmail.com>
In-Reply-To: <CAAYs2=hOY+ib_OYwUfnM10kwyqte7C7=efTL00VkVKHWM9HbAw@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 30 Nov 2022 15:29:52 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSTMqcF4zYXOCK2zccwqkqPdgttK00XXWq3YQubaB5XAw@mail.gmail.com>
Message-ID: <CAJF2gTSTMqcF4zYXOCK2zccwqkqPdgttK00XXWq3YQubaB5XAw@mail.gmail.com>
Subject: Re: [PATCH V4 6/7] riscv: ftrace: Add DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 support
To:     Song Shuai <suagrfillet@gmail.com>
Cc:     anup@brainfault.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        conor.dooley@microchip.com, heiko@sntech.de, rostedt@goodmis.org,
        mhiramat@kernel.org, jolsa@redhat.com, bp@suse.de,
        jpoimboe@kernel.org, andy.chiu@sifive.com, mark.rutland@arm.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 8:03 PM Song Shuai <suagrfillet@gmail.com> wrote:
>
> <guoren@kernel.org> =E4=BA=8E2022=E5=B9=B411=E6=9C=8829=E6=97=A5=E5=91=A8=
=E4=BA=8C 03:33=E5=86=99=E9=81=93=EF=BC=9A
> >
> > From: Song Shuai <suagrfillet@gmail.com>
> >
> > This patch adds DYNAMIC_FTRACE_WITH_DIRECT_CALLS support for RISC-V.
> >
> > select the DYNAMIC_FTRACE_WITH_DIRECT_CALLS to provide the
> > register_ftrace_direct[_multi] interfaces allowing users to register
> > the customed trampoline (direct_caller) as the mcount for one or
> > more target functions. And modify_ftrace_direct[_multi] are also
> > provided for modifying direct_caller.
> >
> > To make the direct_caller and the other ftrace hooks (eg. function/fgra=
ph
> > tracer, k[ret]probes) co-exist, a temporary register is nominated to
> > store the address of direct_caller in ftrace_regs_caller. After the
> > setting of the address direct_caller by direct_ops->func and the
> > RESTORE_REGS in ftrace_regs_caller, direct_caller will be jumped to
> > by the `jr` inst.
> >
> > Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> > Tested-by: Guo Ren <guoren@kernel.org>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > ---
> >  arch/riscv/Kconfig              | 1 +
> >  arch/riscv/include/asm/ftrace.h | 6 ++++++
> >  arch/riscv/kernel/mcount-dyn.S  | 4 ++++
> >  3 files changed, 11 insertions(+)
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 1d0e5838b11b..2828537abfcd 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -278,6 +278,7 @@ config ARCH_RV64I
> >         select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
> >         select HAVE_DYNAMIC_FTRACE if !XIP_KERNEL && MMU && $(cc-option=
,-fpatchable-function-entry=3D8)
> I noticed this cc-option uses the '-fpatchable-function-entry=3D8' to
> judge if the compiler supports this option.
> Should we keep up with the CC_FLAGS_FTRACE modified in ("riscv:
> ftrace: Reduce the detour code size to half"),
> or follow the parisc architecture to set the value as '1,1' in the
> case of the CC_FLAGS_FTRACE is not constant.
> ```
> ./arch/parisc/Makefile:75:CC_FLAGS_FTRACE :=3D
> -fpatchable-function-entry=3D$(NOP_COUNT),$(shell echo
> $$(($(NOP_COUNT)-1)))
> ./arch/parisc/Kconfig:70:       select HAVE_DYNAMIC_FTRACE if
> $(cc-option,-fpatchable-function-entry=3D1,1)
The -fpatchable-function-entry=3D8 is still okay for riscv because it's
big enough. Your proposal could be another optimization patch, not a
fixup (No bug happens :).

> ```
> >         select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
> > +       select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
> >         select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
> >         select HAVE_FUNCTION_GRAPH_TRACER
> >         select HAVE_FUNCTION_TRACER if !XIP_KERNEL && !PREEMPTION
> > diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/f=
trace.h
> > index 84f856a3286e..4539f10fea56 100644
> > --- a/arch/riscv/include/asm/ftrace.h
> > +++ b/arch/riscv/include/asm/ftrace.h
> > @@ -114,6 +114,12 @@ struct ftrace_regs;
> >  void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
> >                        struct ftrace_ops *op, struct ftrace_regs *fregs=
);
> >  #define ftrace_graph_func ftrace_graph_func
> > +
> > +static inline void arch_ftrace_set_direct_caller(struct pt_regs *regs,=
 unsigned long addr)
> > +{
> > +               regs->t1 =3D addr;
> > +}
> > +
> >  #endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
> >
> >  #endif /* __ASSEMBLY__ */
> > diff --git a/arch/riscv/kernel/mcount-dyn.S b/arch/riscv/kernel/mcount-=
dyn.S
> > index 466c6ef217b1..fef7c460f991 100644
> > --- a/arch/riscv/kernel/mcount-dyn.S
> > +++ b/arch/riscv/kernel/mcount-dyn.S
> > @@ -232,6 +232,7 @@ ENDPROC(ftrace_caller)
> >
> >  #else /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
> >  ENTRY(ftrace_regs_caller)
> > +       move    t1, zero
> >         SAVE_ABI_REGS 1
> >         PREPARE_ARGS
> >
> > @@ -241,7 +242,10 @@ ftrace_regs_call:
> >
> >
> >         RESTORE_ABI_REGS 1
> > +       bnez    t1,.Ldirect
> >         jr t0
> > +.Ldirect:
> > +       jr t1
> >  ENDPROC(ftrace_regs_caller)
> >
> >  ENTRY(ftrace_caller)
> > --
> > 2.36.1
> >
>
>
> --
> Thanks,
> Song



--=20
Best Regards
 Guo Ren
