Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5DCA63A979
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 14:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbiK1N3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 08:29:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbiK1N3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 08:29:20 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215301D678
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 05:29:18 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id t17so9459463pjo.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 05:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uBdU9MBKjL0Xadg7p+abX3ZuC4Gb0AyqB1eHg7GazfE=;
        b=VCINWH96hYF2LyLNKubViZIaiQbd8s8WBUNpDH0jKjBHGQ2ryA3XM+U+YvaM960KNY
         1XjgWvAPbtsLVmAOO9/8cZF3vLbu5Yx6pOElAAhbAa2UCE8eI/tiZGyJ0BjKi+GUAiLj
         XhgdlNXLrMk1rCnDa/Ppo/1slTy9fm8Ja3oSjkljS6tWDdmNrrp6kb4kxuorPxHUl5ui
         YLOe4hfK45AeBcIiY99PhpcxAuDQTgD+f/oCOphxl+BNeyKBNha//e4Pnxoshhm1aLAy
         DayLfXLnDwEgUErBD7Ve2vjk922foGo4dDjr9Xm5h8WKNJ5KtCzRAMbX2AicnZZ7chDg
         kdHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uBdU9MBKjL0Xadg7p+abX3ZuC4Gb0AyqB1eHg7GazfE=;
        b=pIkkrElE+2Q4KsQVIbL34H2fSnfrJln7mA+avmmbXVhWrhIJ+nvP0JSgfDFg0c2QKd
         r2Ppcdue676CbGkZpuXuMMs6aqeaKiGV3QDd6XxR709sVPXdfhEpW1XmI2NXlC6FF9uF
         WI8B/6IMkdV061G6SIdifS/45adsX7fwXB4vaJ5admTUuFhWxGS3boAt+4a+QOram8B/
         YZFJyWo7Ds/4sU51+lLi3ViDWMUXqmEk9mQS0vQIgN0+CtCkinSrTFe1NJ0jZLF7sO7z
         xT2yh4VCNj0qjW1spWcno4swNG4lEFOxLH08HLL/1AsdNs/rFd5eSbxSBWgOxKJK9gse
         7KhA==
X-Gm-Message-State: ANoB5pmGTeOI1zefV6+mi+drAWZv7bRItIWxR9zHDfvTuic7IN4kqOlp
        UkQGcSBvjXd0rkn38sJXchUYzozLLKoZCovX1xI=
X-Google-Smtp-Source: AA0mqf5DYCv1aNh5HImmu7qLjWM2lakpYzwNvqT22+jQhNJ18ws9YJ7Vhl7ZuXmX4VXoHjAsF/yh2gG4Ai1QPtrzhoQ=
X-Received: by 2002:a17:903:2351:b0:189:6574:a4b7 with SMTP id
 c17-20020a170903235100b001896574a4b7mr17567737plh.107.1669642157574; Mon, 28
 Nov 2022 05:29:17 -0800 (PST)
MIME-Version: 1.0
References: <20221123142025.1504030-1-suagrfillet@gmail.com>
 <20221123142025.1504030-2-suagrfillet@gmail.com> <CAJF2gTSbyfwdCDdUu7S3JpdFpspxVEi+t_8r6SQhaLogE1O7wg@mail.gmail.com>
In-Reply-To: <CAJF2gTSbyfwdCDdUu7S3JpdFpspxVEi+t_8r6SQhaLogE1O7wg@mail.gmail.com>
From:   Song Shuai <suagrfillet@gmail.com>
Date:   Mon, 28 Nov 2022 13:29:05 +0000
Message-ID: <CAAYs2=hKSOo9KyvXE+Nt_GWZwXV91g04187LYx7LXUZ-c9urkw@mail.gmail.com>
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

Guo Ren <guoren@kernel.org> =E4=BA=8E2022=E5=B9=B411=E6=9C=8828=E6=97=A5=E5=
=91=A8=E4=B8=80 13:17=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Nov 23, 2022 at 10:20 PM Song Shuai <suagrfillet@gmail.com> wrote=
:
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
> > ---
> >  arch/riscv/Kconfig              | 1 +
> >  arch/riscv/include/asm/ftrace.h | 6 ++++++
> >  arch/riscv/kernel/mcount-dyn.S  | 4 ++++
> >  3 files changed, 11 insertions(+)
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 39ec8d628cf6..d083ec08d0b6 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -278,6 +278,7 @@ config ARCH_RV64I
> >         select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
> >         select HAVE_DYNAMIC_FTRACE if !XIP_KERNEL && MMU && $(cc-option=
,-fpatchable-function-entry=3D8)
> >         select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
> > +       select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
> >         select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
> >         select HAVE_FUNCTION_GRAPH_TRACER
> >         select HAVE_FUNCTION_TRACER if !XIP_KERNEL && !PREEMPTION
> > diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/f=
trace.h
> > index 01bebb28eabe..be4d57566139 100644
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
> > index 466c6ef217b1..b89c85a58569 100644
> > --- a/arch/riscv/kernel/mcount-dyn.S
> > +++ b/arch/riscv/kernel/mcount-dyn.S
> > @@ -233,6 +233,7 @@ ENDPROC(ftrace_caller)
> >  #else /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
> >  ENTRY(ftrace_regs_caller)
> >         SAVE_ABI_REGS 1
> > +       REG_S   x0, PT_T1(sp)
> ENTRY(ftrace_regs_caller)
> +    move t1, zero
>       SAVE_ABI_REGS 1
>       PREPARE_ARGS
>
> Shall we use a move here, instead?
That seems ok to me. Just move it.
>
> >         PREPARE_ARGS
> >
> >  ftrace_regs_call:
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
> > 2.20.1
> >
>
>
> --
> Best Regards
>  Guo Ren



--=20
Thanks,
Song
