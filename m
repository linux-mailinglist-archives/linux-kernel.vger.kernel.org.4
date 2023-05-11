Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10FB36FEE8F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 11:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237652AbjEKJTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 05:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237493AbjEKJTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 05:19:17 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69169A5EC;
        Thu, 11 May 2023 02:18:33 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-64389a44895so6766831b3a.1;
        Thu, 11 May 2023 02:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683796712; x=1686388712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i6U9uGUr88pwOkY4LrqlN7HlhZaxZaBxyK1VEGjXGAo=;
        b=OS//Vh11EEv2pGSkeRLlqnJLTlOW5TJGhs3rLBeTcNVdkcic6iBLPL9Fn6RdPmOM6V
         zCK2oulh9Kb1YGuv6W1jBADS5lnSMnj1dNT7GW4Or0906FuRNjrkl7N/ZQ9iOEqQvpcR
         DpcQdwrUEX6ghH3jdKX9JXzjMmCaecmqwx/l+cUq8oy33lI1pYigcCAmvHx3FiMKe0vQ
         35LoPTwhQZHB9NaUWt5sjGaq/QnmGb9TINVFwOyWc/teIlGRxwyq60cUojFvAHpZzhwF
         2OIVE+dcScqo3cGGi8YXR9SI5LnFG5YSoKoiDhsENGTs3szAkIeuSstLr6RVro62/ln8
         +aZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683796712; x=1686388712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i6U9uGUr88pwOkY4LrqlN7HlhZaxZaBxyK1VEGjXGAo=;
        b=dyFpiMDPVGIxMlCIJoKQSd7EilU/Ox66YuHUzmuDBZoElijJWkmfmwRt9DxGjeFHgN
         pUUM6Ulemf1DQ8Da3PRtyYONgz1T8sK/mWgBiCcnZAvlzGs2o+hzCsAK6dfv9ST/6jTR
         Af1pd2AxlgwZ+DfREhuwN5xeEOXgypzV7KgCoTu29H3od2IgBttiy4kMaOt2OLMxKoOw
         gv66CiW0H6Bdi2gZ/d5Be7Fb9VpgTh2s/png3IwWTmSSUndpkCQGu2VtHrP4uhBhsFLg
         46coFSBtXSjxE2taLKm89eljOY7hiNmWBTUAj6+Ajsn1P6eWP0CWub4NGy8ZLKGHAjBG
         ARPw==
X-Gm-Message-State: AC+VfDzmJXGbidASlVswM+2wLR/pvPDC3EoPee6wL+N1On0vo0AgATQf
        HEPsH7wmcd1mPAI867fVoamwMYpIB4AIUN7940k=
X-Google-Smtp-Source: ACHHUZ4qGTyyG/l/JoJuljrxfO4gxHgyL+Cw8GqS43DRhxvfyaXfQcEQGAOjOTqiR4fmrPdGmFx+hH1GryJ1IAa64So=
X-Received: by 2002:a17:902:8348:b0:1ac:9890:1c49 with SMTP id
 z8-20020a170902834800b001ac98901c49mr10124636pln.15.1683796711999; Thu, 11
 May 2023 02:18:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230510101857.2953955-1-suagrfillet@gmail.com>
 <20230510101857.2953955-4-suagrfillet@gmail.com> <87ttwjjpx8.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87ttwjjpx8.fsf@all.your.base.are.belong.to.us>
From:   Song Shuai <suagrfillet@gmail.com>
Date:   Thu, 11 May 2023 09:18:19 +0000
Message-ID: <CAAYs2=gKa71k81NfvbHknQuSgOTNXqTaGPVghjU__WvVDq_8uA@mail.gmail.com>
Subject: Re: [PATCH V9 3/4] riscv: ftrace: Add DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 support
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, rostedt@goodmis.org, mhiramat@kernel.org,
        mark.rutland@arm.com, guoren@kernel.org, jszhang@kernel.org,
        e.shatokhin@yadro.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
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

Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> =E4=BA=8E2023=E5=B9=B45=E6=9C=8811=
=E6=97=A5=E5=91=A8=E5=9B=9B 07:19=E5=86=99=E9=81=93=EF=BC=9A

>
> Song Shuai <suagrfillet@gmail.com> writes:
>
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
> >  arch/riscv/Kconfig              |  1 +
> >  arch/riscv/include/asm/ftrace.h |  8 ++++++++
> >  arch/riscv/kernel/mcount-dyn.S  | 10 ++++++++++
> >  3 files changed, 19 insertions(+)
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index e0632493482f..fdf0b219a02c 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -144,6 +144,7 @@ config RISCV
> >       select UACCESS_MEMCPY if !MMU
> >       select ZONE_DMA32 if 64BIT
> >       select HAVE_DYNAMIC_FTRACE if !XIP_KERNEL && MMU && (CLANG_SUPPOR=
TS_DYNAMIC_FTRACE || GCC_SUPPORTS_DYNAMIC_FTRACE)
> > +     select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
> >       select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
> >       select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
> >       select HAVE_FUNCTION_GRAPH_TRACER
> > diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/f=
trace.h
> > index 84f856a3286e..84904c1e4369 100644
> > --- a/arch/riscv/include/asm/ftrace.h
> > +++ b/arch/riscv/include/asm/ftrace.h
> > @@ -114,6 +114,14 @@ struct ftrace_regs;
> >  void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
> >                      struct ftrace_ops *op, struct ftrace_regs *fregs);
> >  #define ftrace_graph_func ftrace_graph_func
> > +
> > +static inline void
> > +__arch_ftrace_set_direct_caller(struct pt_regs *regs, unsigned long ad=
dr)
> > +{
> > +             regs->t1 =3D addr;
> > +}
> > +#define arch_ftrace_set_direct_caller(fregs, addr) \
> > +     __arch_ftrace_set_direct_caller(&(fregs)->regs, addr)
> >  #endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
> >
> >  #endif /* __ASSEMBLY__ */
> > diff --git a/arch/riscv/kernel/mcount-dyn.S b/arch/riscv/kernel/mcount-=
dyn.S
> > index f26e9f6e2fed..9d405baedb52 100644
> > --- a/arch/riscv/kernel/mcount-dyn.S
> > +++ b/arch/riscv/kernel/mcount-dyn.S
> > @@ -231,6 +231,7 @@ ENDPROC(ftrace_caller)
> >
> >  #else /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
> >  ENTRY(ftrace_regs_caller)
> > +     move    t1, zero
>
> Please use "mv", and not "move" [1].
Will fix it up in the next version
>
> >       SAVE_ABI_REGS 1
> >       PREPARE_ARGS
> >
> > @@ -239,7 +240,10 @@ ftrace_regs_call:
> >       call    ftrace_stub
> >
> >       RESTORE_ABI_REGS 1
> > +     bnez    t1,.Ldirect
> >       jr t0
> > +.Ldirect:
> > +     jr t1
>
> Again, while you're doing changes here, please try to align op/operands.
>
> Wearing my BPF hat, I'm happy to finally get DIRECT_CALLS support!
>
> This does not take the WITH_CALL_OPS approach Mark suggested in the v7
> threads, but given that text patching story on RISC-V is still a bit sad
> (inconsistency in the RV tree, no specification, cannot work with
> preempt, ...) I'd say this approach is OK for now, and we can change to
> WITH_CALL_OPS later in a wider "let's improve RISC-V textpatching" work.
>
> Thoughts?
>
>
> Bj=C3=B6rn
>
> [1] https://github.com/riscv-non-isa/riscv-asm-manual/blob/master/riscv-a=
sm.md#-a-listing-of-standard-risc-v-pseudoinstructions



--
Thanks,
Song
