Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00EFF6377EF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 12:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbiKXLtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 06:49:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiKXLtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 06:49:05 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FA32A70F
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 03:49:04 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso4972616pjt.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 03:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z/j7wIVLMDR3Qr8oxnr7AVj9yFeOJFzyI0HFj0y0Gfs=;
        b=HvFvsOI1+0f16xSw7lxQDAoXV95EEmkAROBGbn9F8NT5YU1pVpoVNl9pS+edfY9YOj
         s+55BISANPKHw8ivs+o5bvY4eVPz+erFjm/WKRAu62rusmBo0Ehk3mk59csovbb7VXaZ
         pO/SZ2t0zV8BOmgByDrDry636iezG8rGQ0AgbMuRxTd49jBnsuXiHIUZCbtPe7PO3297
         VBeoIi0vSKeO/9A88LmgRbkQaGgaM8vBn6Bb78Ks4O1Hr6uRdYkTeNb+sV1QeLAlwCeF
         kI2Pu1S7jrENeSA+5/8YVMX4NyZK3K8axrZOTlikKC+VlDG2JfYa56wyIjxKBG290L9w
         JU+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z/j7wIVLMDR3Qr8oxnr7AVj9yFeOJFzyI0HFj0y0Gfs=;
        b=H1jy3igCBrGQCZNerf41/x7h+2rE2JUaHw+7L0vrjFTso8XcQi/8eWFFzZ/TBmSsEt
         XJkgibI2OuwuPuf7ONxOXsQt1hXi8STm7QzExfiHYSh7UhukZgCP0i7/VW7XMgSZ6E7S
         dXCyDTVOCixpGEsrBoqIWr4Xdm0aLUFHropQiyeMLH0nIVNIjVFTeW7iRXrgDTeCyy4G
         KY7DZrOnrHYaMUyk1CPTn3MuqtYggvaR+y4ViKMLoWCUoFzVKyKZpzsA+IWMOPbx+qSD
         it6+1fdOWzv7+sHPVMaQiWqA4sCgRI8sns4KPotgSqy1DrTgUTLIeLeqht+uuWJ7a4jD
         d0Fw==
X-Gm-Message-State: ANoB5pm/gzSlkFda4eQvA4endQ6Tk3GZIVTY2HRfUj3ipNGdrrjPv5y7
        VNZ1IJ2i3vvyLqV2NUBzb5m0WPRUUCOvpAorEng=
X-Google-Smtp-Source: AA0mqf4jUEZdf+pSctKP7d1WvkVqotqsnj4gm6PltKzSb0Don8S8uM0NR5rGmwrnTSHlsH0Ota4t9bBNs/cxVTpRnvM=
X-Received: by 2002:a17:903:4111:b0:189:596a:1499 with SMTP id
 r17-20020a170903411100b00189596a1499mr2826520pld.157.1669290543679; Thu, 24
 Nov 2022 03:49:03 -0800 (PST)
MIME-Version: 1.0
References: <20221123142025.1504030-1-suagrfillet@gmail.com>
 <20221123142025.1504030-2-suagrfillet@gmail.com> <CAJF2gTTwvApRaGhZJxOrdcjWUC9DN-WF_7EKcHXx5HZ9Jkd5EA@mail.gmail.com>
 <CAAYs2=ghhMmmrM4Bktvw9iGiajS5PLd1=Z61j2ZfhbhGUi4ekg@mail.gmail.com>
 <CAJF2gTTgTfGAYTWbqqrdZg9bMjbpQfx8GzFzxoq3C4r9HDpz8Q@mail.gmail.com>
 <CAAYs2=iJM3d6tqwLjCoE7S1p3JURMYVj54Vry8KiSz1bZakxcA@mail.gmail.com>
 <CAAYs2=gAOHQs2mCHYmjniJ5i8fQS1wNzeMzTx0fW-s3Z0bu_sg@mail.gmail.com> <CAJF2gTQ1OTL8gO-MF8OjumhRYTHtTGPV2PhksakXNO6gbTbYmg@mail.gmail.com>
In-Reply-To: <CAJF2gTQ1OTL8gO-MF8OjumhRYTHtTGPV2PhksakXNO6gbTbYmg@mail.gmail.com>
From:   Song Shuai <suagrfillet@gmail.com>
Date:   Thu, 24 Nov 2022 11:48:51 +0000
Message-ID: <CAAYs2=i8LhzhXW00tTP8pZJZ=8OOWbgRreJh_iCT4GX5qkUoww@mail.gmail.com>
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

Guo Ren <guoren@kernel.org> =E4=BA=8E2022=E5=B9=B411=E6=9C=8824=E6=97=A5=E5=
=91=A8=E5=9B=9B 03:40=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Nov 24, 2022 at 11:09 AM Song Shuai <suagrfillet@gmail.com> wrote=
:
> >
> > Song Shuai <suagrfillet@gmail.com> =E4=BA=8E2022=E5=B9=B411=E6=9C=8824=
=E6=97=A5=E5=91=A8=E5=9B=9B 02:52=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > Guo Ren <guoren@kernel.org> =E4=BA=8E2022=E5=B9=B411=E6=9C=8824=E6=97=
=A5=E5=91=A8=E5=9B=9B 02:08=E5=86=99=E9=81=93=EF=BC=9A
> > > >
> > > > On Thu, Nov 24, 2022 at 1:27 AM Song Shuai <suagrfillet@gmail.com> =
wrote:
> > > > >
> > > > > Guo Ren <guoren@kernel.org> =E4=BA=8E2022=E5=B9=B411=E6=9C=8823=
=E6=97=A5=E5=91=A8=E4=B8=89 23:02=E5=86=99=E9=81=93=EF=BC=9A
> > > > > >
> > > > > > Cool job, thx.
> > > > > >
> > > > > > On Wed, Nov 23, 2022 at 10:20 PM Song Shuai <suagrfillet@gmail.=
com> wrote:
> > > > > >>
> > > > > >> This patch adds DYNAMIC_FTRACE_WITH_DIRECT_CALLS support for R=
ISC-V.
> > > > > >>
> > > > > >> select the DYNAMIC_FTRACE_WITH_DIRECT_CALLS to provide the
> > > > > >> register_ftrace_direct[_multi] interfaces allowing users to re=
gister
> > > > > >> the customed trampoline (direct_caller) as the mcount for one =
or
> > > > > >> more target functions. And modify_ftrace_direct[_multi] are al=
so
> > > > > >> provided for modifying direct_caller.
> > > > > >>
> > > > > >> To make the direct_caller and the other ftrace hooks (eg. func=
tion/fgraph
> > > > > >> tracer, k[ret]probes) co-exist, a temporary register is nomina=
ted to
> > > > > >> store the address of direct_caller in ftrace_regs_caller. Afte=
r the
> > > > > >> setting of the address direct_caller by direct_ops->func and t=
he
> > > > > >> RESTORE_REGS in ftrace_regs_caller, direct_caller will be jump=
ed to
> > > > > >> by the `jr` inst.
> > > > > >>
> > > > > >> Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> > > > > >> ---
> > > > > >>  arch/riscv/Kconfig              | 1 +
> > > > > >>  arch/riscv/include/asm/ftrace.h | 6 ++++++
> > > > > >>  arch/riscv/kernel/mcount-dyn.S  | 4 ++++
> > > > > >>  3 files changed, 11 insertions(+)
> > > > > >>
> > > > > >> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > > > >> index 39ec8d628cf6..d083ec08d0b6 100644
> > > > > >> --- a/arch/riscv/Kconfig
> > > > > >> +++ b/arch/riscv/Kconfig
> > > > > >> @@ -278,6 +278,7 @@ config ARCH_RV64I
> > > > > >>         select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
> > > > > >>         select HAVE_DYNAMIC_FTRACE if !XIP_KERNEL && MMU && $(=
cc-option,-fpatchable-function-entry=3D8)
> > > > > >>         select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_F=
TRACE
> > > > > >> +       select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
> > > > > >>         select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
> > > > > >>         select HAVE_FUNCTION_GRAPH_TRACER
> > > > > >>         select HAVE_FUNCTION_TRACER if !XIP_KERNEL && !PREEMPT=
ION
> > > > > >> diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/incl=
ude/asm/ftrace.h
> > > > > >> index 01bebb28eabe..be4d57566139 100644
> > > > > >> --- a/arch/riscv/include/asm/ftrace.h
> > > > > >> +++ b/arch/riscv/include/asm/ftrace.h
> > > > > >> @@ -114,6 +114,12 @@ struct ftrace_regs;
> > > > > >>  void ftrace_graph_func(unsigned long ip, unsigned long parent=
_ip,
> > > > > >>                        struct ftrace_ops *op, struct ftrace_re=
gs *fregs);
> > > > > >>  #define ftrace_graph_func ftrace_graph_func
> > > > > >> +
> > > > > >> +static inline void arch_ftrace_set_direct_caller(struct pt_re=
gs *regs, unsigned long addr)
> > > > > >> +{
> > > > > >> +               regs->t1 =3D addr;
> > > > > >
> > > > > > How about regs->t0 =3D addr; ?
> > > > > > And delete all mcount-dyn.S modification.
> > > > > >
> > > > > The direct_caller has the same program layout as the ftrace_calle=
r, which means
> > > > > the reg t0 will never be changed when direct_caller returns.
> > > > >
> > > > > If regs->t0 changes here and ftrace_regs_caller executes `jr t0`,
> > > > > direct_caller will enter the dead loop.
> > > > ?
> > > >
> > > > ftrace_regs_caller->call_direct_funcs->
> > > > arch_ftrace_set_direct_caller-> ftrace_regs_caller jr t0.
> > > >
> > > > Only call_direct_funcs call arch_ftrace_set_direct_caller !
> > > >
> > > > static void call_direct_funcs(unsigned long ip, unsigned long pip,
> > > >                               struct ftrace_ops *ops, struct ftrace=
_regs *fregs)
> > > > {
> > > >         struct pt_regs *regs =3D ftrace_get_regs(fregs);
> > > >         unsigned long addr;
> > > >
> > > >         addr =3D ftrace_find_rec_direct(ip);
> > > >         if (!addr)
> > > >                 return;
> > > >
> > > >         arch_ftrace_set_direct_caller(regs, addr);
> > > > }
> > > >
> > > When direct_caller and function tracer co-hook a function, the simple
> > > diagram is like this:
> > >
> > > ```
> > > func -> ftrace_regs_caller -> arch_ftrace_ops_list_func ->
> > > function_trace_call // write ringbuffer
> > >             |
> > >                  -> call_direct_funcs // regs->t1 =3D direct_caller
> > >            -> t1 !=3D0 && jr t1 // goto direct_caller
> > > ```
> > >
> > ```
> > f -- regs_caller -- list_func
> >     |                       | -- function_trace_call
> >     |                       | -- call_direct_funcs  // t1 =3D addr
> >     |-- t1 !=3D0 && jr t1 // goto direct_caller
> Cool diagram! Thx, but we still need a discussion:
> f -- regs_caller
>      | -- SAVE_ABI_REGS 1
>      | -- list_func
>      |                       | -- function_trace_call
>      |                       | -- call_direct_funcs  // t1 =3D addr
>      | -- RESTORE_ABI_REGS 1
>      |-- t1 !=3D0 && jr t1 // goto direct_caller
> If you set t1 non-zero, then we always go to direct_caller. I think
> the code is equal to set t0=3Daddr.
If only focusing on the whole ftrace_regs_caller code, you're right.

But we should also take direct_caller code into the consideration,
if using t0 here, direct_caller will always return to itself as I
described before.
>      |                       | -- call_direct_funcs  // t0 =3D addr
>      | -- RESTORE_ABI_REGS 1
>      |-- jr t0 // goto direct_caller
>
> I think the only problem happens in the below non-existent situation:
> f -- regs_caller
>      | -- SAVE_ABI_REGS 1
>      | -- list_func
>      |                       | -- call_direct_funcs  // t0 =3D addr
>      |                       | -- function_trace_call //t0 contains
> direct_caller instead
function_trace_call is one type of global_ops->func which doesn't take care
of the regs->t0.

But the func of IPMODIFY ops (eg. livepatch, kprobe with posthandler)
will change regs->epc which will then be restored to t0 in ftrace_regs_call=
er.
And then the address of direct_caller will be covered in this situation.
I'm not very clear about the process of the livepatch and kprobe in RISCV
but I think we should keep t0 for their ipmodifying.
>      | -- RESTORE_ABI_REGS 1
>      |-- jr t0 // goto direct_caller
>
> The key issue is whether going to direct_caller correctly depends on
> call_direct_funcs called, right?
Yes, in other words, call_direct_func informs ftrace_regs_caller that
there is a direct caller stored in t1, please jump to it first.
>
> > ```
> > This diagram looks better.
> > > And the direct_caller has a similar implement as ftrace_caller.
> > >
> > > ```
> > > direct_caller:
> > > add sp,sp,-?
> > > sd t0,?(sp)
> > > sd ra,?(sp)
> > > call foo
> > > ld t0,?(sp)
> > > ld ra,?(sp)
> > > add sp,sp,?
> > > jr t0 // <- back to function entry
> > > ```
> > >
> > > If we change regs->t0 as direct_caller and execute `jr t0` directly,
> > > the direct_caller will always jump to itself due to its last `jr` ins=
t.
--- Here is what I described in the previous email.
> > >
> > > ```
> > > func -> ftrace_regs_caller -> arch_ftrace_ops_list_func ->
> > > function_trace_call // write ringbuffer
> > >             |
> > >                  -> call_direct_funcs // regs->t0 =3D direct_caller
> > >            -> jr t0 // goto direct_caller
> > >
> > > direct_caller:
> > > ...
> > > sd t0,?(sp)
> > > ...
> > > ld t0,?(s0)
> > > ...
> > > jr t0 // goto direct_caller always
> > > ```
> > >
> > > Hope I made it clear.
> > > > >
> > > > > Actually the reg t0 always saves the address of function entry wi=
th 8B
> > > > > offset, it should only
> > > > > changed by the IPMODIFY ops instead of the direct_ops.
> > > > > >>
> > > > > >> +}
> > > > > >> +
> > > > > >>  #endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
> > > > > >>
> > > > > >>  #endif /* __ASSEMBLY__ */
> > > > > >> diff --git a/arch/riscv/kernel/mcount-dyn.S b/arch/riscv/kerne=
l/mcount-dyn.S
> > > > > >> index 466c6ef217b1..b89c85a58569 100644
> > > > > >> --- a/arch/riscv/kernel/mcount-dyn.S
> > > > > >> +++ b/arch/riscv/kernel/mcount-dyn.S
> > > > > >> @@ -233,6 +233,7 @@ ENDPROC(ftrace_caller)
> > > > > >>  #else /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
> > > > > >>  ENTRY(ftrace_regs_caller)
> > > > > >>         SAVE_ABI_REGS 1
> > > > > >> +       REG_S   x0, PT_T1(sp)
> > > > > >>         PREPARE_ARGS
> > > > > >>
> > > > > >>  ftrace_regs_call:
> > > > > >> @@ -241,7 +242,10 @@ ftrace_regs_call:
> > > > > >>
> > > > > >>
> > > > > >>         RESTORE_ABI_REGS 1
> > > > > >> +       bnez    t1,.Ldirect
> > > > > >>         jr t0
> > > > > >> +.Ldirect:
> > > > > >> +       jr t1
> > > > > >>  ENDPROC(ftrace_regs_caller)
> > > > > >>
> > > > > >>  ENTRY(ftrace_caller)
> > > > > >> --
> > > > > >> 2.20.1
> > > > > >>
> > > > > >
> > > > > >
> > > > > > --
> > > > > > Best Regards
> > > > > >  Guo Ren
> > > >
> > > >
> > > >
> > > > --
> > > > Best Regards
> > > >  Guo Ren
> > > Thanks,
> > > Song
> > Thanks,
> > Song
>
>
>
> --
> Best Regards
>  Guo Ren
Thanks,
Song
