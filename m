Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8883F6370D0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 04:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiKXDLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 22:11:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiKXDLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 22:11:15 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DBFBEB56
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 19:11:13 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id p12so312649plq.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 19:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4p5Gx8CNV7c00YAWsz5Qh2wQkyKnAcz7nfw8EBTc62k=;
        b=cP9pgP63hO9qaGyGyeGTxU5xQXkPubj6XNgjkWNsPQXUySPMG2OqZtxokk9qZoj7cx
         Sole6gn3xGirLEX4eCz8J95YrEHc17tn6K3d7Byo/4+65VSPJjtT9CyCjhxCvWhl58c3
         UUFOjeRRt167P6QaKliNHjIOLhSgZdigI88pXrx/A/7djjWNjrWn/qbsmfl+Q1k/g3G7
         5yfkpsShRMnmNnCOcnCdlwyRLFO9Tx8uEJRzKhfPLCWFW9NZ0euCli1m4Ao+uXvnfcGM
         wXoM9VApm2YvmQr1z9Ohc6ZLhwWZHMnwExYfkTOl3qHLln3HGAi8PjB+CkYwu1Md2rn1
         P75Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4p5Gx8CNV7c00YAWsz5Qh2wQkyKnAcz7nfw8EBTc62k=;
        b=AC5XqjW3SSaSI8Y7lnhFASMjWv0s3kChrAhjQ+lkwcA4g9537JAse5H7RB/+B5JKFW
         M+clj+5xHBKD67U9nuTNBLUTE+nwvahSnWTZ4SX6+S9ICTD4ii62U7NPETsPYbvJHxc5
         hpgJ6YN37is0NBfldXBkCcX7S3N52K7bHjJheM7Z053R3ZV/WDk2bD3+9oo/4EUtMmtB
         pylh/mDAoIi1uMp9U5vvYH90x360cL4ngWrSpBWxUnaK60cszrqpOaS0/DSlSD+ZSyje
         l9K1yUGBn/e4zCipucoBRxKCd5efWZgrpCa3257Ahv8TPWsmlYAFxLUjDW+NhiAW6Sxq
         vjtw==
X-Gm-Message-State: ANoB5plQCsMxDopDQfmRcXtHW2JT4EOKU6k386v/z31Yz7Qc+bZxd1Tp
        iYkJ/AwATVaYGij3m/7MvygTgRtvWyB5xZ30nWc=
X-Google-Smtp-Source: AA0mqf54dv7umnaUcFN2mCJ1/swrOTVRoadMME8UYKM0s0Co8F4PJtO+MOQJH8/kgFlYuxPFS0ZO/oviZsxgCq8LYuc=
X-Received: by 2002:a17:903:130c:b0:186:85c3:98af with SMTP id
 iy12-20020a170903130c00b0018685c398afmr15165713plb.101.1669259380623; Wed, 23
 Nov 2022 19:09:40 -0800 (PST)
MIME-Version: 1.0
References: <20221123142025.1504030-1-suagrfillet@gmail.com>
 <20221123142025.1504030-2-suagrfillet@gmail.com> <CAJF2gTTwvApRaGhZJxOrdcjWUC9DN-WF_7EKcHXx5HZ9Jkd5EA@mail.gmail.com>
 <CAAYs2=ghhMmmrM4Bktvw9iGiajS5PLd1=Z61j2ZfhbhGUi4ekg@mail.gmail.com>
 <CAJF2gTTgTfGAYTWbqqrdZg9bMjbpQfx8GzFzxoq3C4r9HDpz8Q@mail.gmail.com> <CAAYs2=iJM3d6tqwLjCoE7S1p3JURMYVj54Vry8KiSz1bZakxcA@mail.gmail.com>
In-Reply-To: <CAAYs2=iJM3d6tqwLjCoE7S1p3JURMYVj54Vry8KiSz1bZakxcA@mail.gmail.com>
From:   Song Shuai <suagrfillet@gmail.com>
Date:   Thu, 24 Nov 2022 03:09:29 +0000
Message-ID: <CAAYs2=gAOHQs2mCHYmjniJ5i8fQS1wNzeMzTx0fW-s3Z0bu_sg@mail.gmail.com>
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

Song Shuai <suagrfillet@gmail.com> =E4=BA=8E2022=E5=B9=B411=E6=9C=8824=E6=
=97=A5=E5=91=A8=E5=9B=9B 02:52=E5=86=99=E9=81=93=EF=BC=9A
>
> Guo Ren <guoren@kernel.org> =E4=BA=8E2022=E5=B9=B411=E6=9C=8824=E6=97=A5=
=E5=91=A8=E5=9B=9B 02:08=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Thu, Nov 24, 2022 at 1:27 AM Song Shuai <suagrfillet@gmail.com> wrot=
e:
> > >
> > > Guo Ren <guoren@kernel.org> =E4=BA=8E2022=E5=B9=B411=E6=9C=8823=E6=97=
=A5=E5=91=A8=E4=B8=89 23:02=E5=86=99=E9=81=93=EF=BC=9A
> > > >
> > > > Cool job, thx.
> > > >
> > > > On Wed, Nov 23, 2022 at 10:20 PM Song Shuai <suagrfillet@gmail.com>=
 wrote:
> > > >>
> > > >> This patch adds DYNAMIC_FTRACE_WITH_DIRECT_CALLS support for RISC-=
V.
> > > >>
> > > >> select the DYNAMIC_FTRACE_WITH_DIRECT_CALLS to provide the
> > > >> register_ftrace_direct[_multi] interfaces allowing users to regist=
er
> > > >> the customed trampoline (direct_caller) as the mcount for one or
> > > >> more target functions. And modify_ftrace_direct[_multi] are also
> > > >> provided for modifying direct_caller.
> > > >>
> > > >> To make the direct_caller and the other ftrace hooks (eg. function=
/fgraph
> > > >> tracer, k[ret]probes) co-exist, a temporary register is nominated =
to
> > > >> store the address of direct_caller in ftrace_regs_caller. After th=
e
> > > >> setting of the address direct_caller by direct_ops->func and the
> > > >> RESTORE_REGS in ftrace_regs_caller, direct_caller will be jumped t=
o
> > > >> by the `jr` inst.
> > > >>
> > > >> Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> > > >> ---
> > > >>  arch/riscv/Kconfig              | 1 +
> > > >>  arch/riscv/include/asm/ftrace.h | 6 ++++++
> > > >>  arch/riscv/kernel/mcount-dyn.S  | 4 ++++
> > > >>  3 files changed, 11 insertions(+)
> > > >>
> > > >> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > >> index 39ec8d628cf6..d083ec08d0b6 100644
> > > >> --- a/arch/riscv/Kconfig
> > > >> +++ b/arch/riscv/Kconfig
> > > >> @@ -278,6 +278,7 @@ config ARCH_RV64I
> > > >>         select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
> > > >>         select HAVE_DYNAMIC_FTRACE if !XIP_KERNEL && MMU && $(cc-o=
ption,-fpatchable-function-entry=3D8)
> > > >>         select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRAC=
E
> > > >> +       select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
> > > >>         select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
> > > >>         select HAVE_FUNCTION_GRAPH_TRACER
> > > >>         select HAVE_FUNCTION_TRACER if !XIP_KERNEL && !PREEMPTION
> > > >> diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/=
asm/ftrace.h
> > > >> index 01bebb28eabe..be4d57566139 100644
> > > >> --- a/arch/riscv/include/asm/ftrace.h
> > > >> +++ b/arch/riscv/include/asm/ftrace.h
> > > >> @@ -114,6 +114,12 @@ struct ftrace_regs;
> > > >>  void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
> > > >>                        struct ftrace_ops *op, struct ftrace_regs *=
fregs);
> > > >>  #define ftrace_graph_func ftrace_graph_func
> > > >> +
> > > >> +static inline void arch_ftrace_set_direct_caller(struct pt_regs *=
regs, unsigned long addr)
> > > >> +{
> > > >> +               regs->t1 =3D addr;
> > > >
> > > > How about regs->t0 =3D addr; ?
> > > > And delete all mcount-dyn.S modification.
> > > >
> > > The direct_caller has the same program layout as the ftrace_caller, w=
hich means
> > > the reg t0 will never be changed when direct_caller returns.
> > >
> > > If regs->t0 changes here and ftrace_regs_caller executes `jr t0`,
> > > direct_caller will enter the dead loop.
> > ?
> >
> > ftrace_regs_caller->call_direct_funcs->
> > arch_ftrace_set_direct_caller-> ftrace_regs_caller jr t0.
> >
> > Only call_direct_funcs call arch_ftrace_set_direct_caller !
> >
> > static void call_direct_funcs(unsigned long ip, unsigned long pip,
> >                               struct ftrace_ops *ops, struct ftrace_reg=
s *fregs)
> > {
> >         struct pt_regs *regs =3D ftrace_get_regs(fregs);
> >         unsigned long addr;
> >
> >         addr =3D ftrace_find_rec_direct(ip);
> >         if (!addr)
> >                 return;
> >
> >         arch_ftrace_set_direct_caller(regs, addr);
> > }
> >
> When direct_caller and function tracer co-hook a function, the simple
> diagram is like this:
>
> ```
> func -> ftrace_regs_caller -> arch_ftrace_ops_list_func ->
> function_trace_call // write ringbuffer
>             |
>                  -> call_direct_funcs // regs->t1 =3D direct_caller
>            -> t1 !=3D0 && jr t1 // goto direct_caller
> ```
>
```
f -- regs_caller -- list_func
    |                       | -- function_trace_call
    |                       | -- call_direct_funcs  // t1 =3D addr
    |-- t1 !=3D0 && jr t1 // goto direct_caller
```
This diagram looks better.
> And the direct_caller has a similar implement as ftrace_caller.
>
> ```
> direct_caller:
> add sp,sp,-?
> sd t0,?(sp)
> sd ra,?(sp)
> call foo
> ld t0,?(sp)
> ld ra,?(sp)
> add sp,sp,?
> jr t0 // <- back to function entry
> ```
>
> If we change regs->t0 as direct_caller and execute `jr t0` directly,
> the direct_caller will always jump to itself due to its last `jr` inst.
>
> ```
> func -> ftrace_regs_caller -> arch_ftrace_ops_list_func ->
> function_trace_call // write ringbuffer
>             |
>                  -> call_direct_funcs // regs->t0 =3D direct_caller
>            -> jr t0 // goto direct_caller
>
> direct_caller:
> ...
> sd t0,?(sp)
> ...
> ld t0,?(s0)
> ...
> jr t0 // goto direct_caller always
> ```
>
> Hope I made it clear.
> > >
> > > Actually the reg t0 always saves the address of function entry with 8=
B
> > > offset, it should only
> > > changed by the IPMODIFY ops instead of the direct_ops.
> > > >>
> > > >> +}
> > > >> +
> > > >>  #endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
> > > >>
> > > >>  #endif /* __ASSEMBLY__ */
> > > >> diff --git a/arch/riscv/kernel/mcount-dyn.S b/arch/riscv/kernel/mc=
ount-dyn.S
> > > >> index 466c6ef217b1..b89c85a58569 100644
> > > >> --- a/arch/riscv/kernel/mcount-dyn.S
> > > >> +++ b/arch/riscv/kernel/mcount-dyn.S
> > > >> @@ -233,6 +233,7 @@ ENDPROC(ftrace_caller)
> > > >>  #else /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
> > > >>  ENTRY(ftrace_regs_caller)
> > > >>         SAVE_ABI_REGS 1
> > > >> +       REG_S   x0, PT_T1(sp)
> > > >>         PREPARE_ARGS
> > > >>
> > > >>  ftrace_regs_call:
> > > >> @@ -241,7 +242,10 @@ ftrace_regs_call:
> > > >>
> > > >>
> > > >>         RESTORE_ABI_REGS 1
> > > >> +       bnez    t1,.Ldirect
> > > >>         jr t0
> > > >> +.Ldirect:
> > > >> +       jr t1
> > > >>  ENDPROC(ftrace_regs_caller)
> > > >>
> > > >>  ENTRY(ftrace_caller)
> > > >> --
> > > >> 2.20.1
> > > >>
> > > >
> > > >
> > > > --
> > > > Best Regards
> > > >  Guo Ren
> >
> >
> >
> > --
> > Best Regards
> >  Guo Ren
> Thanks,
> Song
Thanks,
Song
