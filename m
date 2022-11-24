Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F9F637C91
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 16:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiKXPLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 10:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiKXPLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 10:11:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D808D15B4E5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 07:11:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66724621AC
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 15:11:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA8E0C43147
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 15:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669302694;
        bh=GAJszz1anTsyFOPZYjqt7c7rfYbHUSpWhZeNuUZjPAI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ne7notNf+PN8jzn4ElQJeEAnrwqG4JNFB2vcNNYGBB09r6IHOJSzEcvrZT2Abrmw1
         3ABXhk+R3f3dWYlABWhX1oEapHMQH19LQ7yBWVzy/q4DLZ1zIEC6CpKN6PC4ypzPUO
         XaUUrcA0k/LdPM9For2dcpjHO5ddwGJcntMm7o0TJXKWBs47Pc6WkoDpSGSYsBZUPp
         lJvH0w10cpzzlL56w6ftBwlTcZG+ZLgz+U8e43Pkfn3rgJSw4e3FYb8s+EKqulxROo
         9pm76JB50dav5ngcyH5LdBKgFviDFEMvJke4MGeIpfA9u23F9ysqOwPeIE/u+qyp/9
         RxqlBtuw/2JHw==
Received: by mail-ed1-f45.google.com with SMTP id f7so2916387edc.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 07:11:34 -0800 (PST)
X-Gm-Message-State: ANoB5pmwynhfZy3v5A+XxfjJG/osBfypFVdOugH2rHMUIaXaKxw6cUng
        MEGdvoMCUmne6fDgGIcdCpr62pQnMOpvzNKkSFU=
X-Google-Smtp-Source: AA0mqf5RW0K3dXQMOm5gjhFJ6hMSmCvigSouFXI9DaTJxNgZbT9oz+pvYdrwnMdX9wy+wl6OXPuhTtkSCrLo93Bp9R0=
X-Received: by 2002:a05:6402:1a:b0:467:30ad:c4ca with SMTP id
 d26-20020a056402001a00b0046730adc4camr30794889edu.285.1669302692921; Thu, 24
 Nov 2022 07:11:32 -0800 (PST)
MIME-Version: 1.0
References: <20221123142025.1504030-1-suagrfillet@gmail.com>
 <20221123142025.1504030-2-suagrfillet@gmail.com> <CAJF2gTTwvApRaGhZJxOrdcjWUC9DN-WF_7EKcHXx5HZ9Jkd5EA@mail.gmail.com>
 <CAAYs2=ghhMmmrM4Bktvw9iGiajS5PLd1=Z61j2ZfhbhGUi4ekg@mail.gmail.com>
 <CAJF2gTTgTfGAYTWbqqrdZg9bMjbpQfx8GzFzxoq3C4r9HDpz8Q@mail.gmail.com>
 <CAAYs2=iJM3d6tqwLjCoE7S1p3JURMYVj54Vry8KiSz1bZakxcA@mail.gmail.com>
 <CAAYs2=gAOHQs2mCHYmjniJ5i8fQS1wNzeMzTx0fW-s3Z0bu_sg@mail.gmail.com>
 <CAJF2gTQ1OTL8gO-MF8OjumhRYTHtTGPV2PhksakXNO6gbTbYmg@mail.gmail.com> <CAAYs2=i8LhzhXW00tTP8pZJZ=8OOWbgRreJh_iCT4GX5qkUoww@mail.gmail.com>
In-Reply-To: <CAAYs2=i8LhzhXW00tTP8pZJZ=8OOWbgRreJh_iCT4GX5qkUoww@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 24 Nov 2022 23:11:20 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTkUG1MPJC5O6YYLxY-QyhJHJML5FGJXBSHWznt_KTDpQ@mail.gmail.com>
Message-ID: <CAJF2gTTkUG1MPJC5O6YYLxY-QyhJHJML5FGJXBSHWznt_KTDpQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] riscv/ftrace: add DYNAMIC_FTRACE_WITH_DIRECT_CALLS support
To:     Song Shuai <suagrfillet@gmail.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, rostedt@goodmis.org, mhiramat@kernel.org,
        mark.rutland@arm.com, peterz@infradead.org, jolsa@redhat.com,
        bp@suse.de, jpoimboe@kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
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

On Thu, Nov 24, 2022 at 7:49 PM Song Shuai <suagrfillet@gmail.com> wrote:
>
> Guo Ren <guoren@kernel.org> =E4=BA=8E2022=E5=B9=B411=E6=9C=8824=E6=97=A5=
=E5=91=A8=E5=9B=9B 03:40=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Thu, Nov 24, 2022 at 11:09 AM Song Shuai <suagrfillet@gmail.com> wro=
te:
> > >
> > > Song Shuai <suagrfillet@gmail.com> =E4=BA=8E2022=E5=B9=B411=E6=9C=882=
4=E6=97=A5=E5=91=A8=E5=9B=9B 02:52=E5=86=99=E9=81=93=EF=BC=9A
> > > >
> > > > Guo Ren <guoren@kernel.org> =E4=BA=8E2022=E5=B9=B411=E6=9C=8824=E6=
=97=A5=E5=91=A8=E5=9B=9B 02:08=E5=86=99=E9=81=93=EF=BC=9A
> > > > >
> > > > > On Thu, Nov 24, 2022 at 1:27 AM Song Shuai <suagrfillet@gmail.com=
> wrote:
> > > > > >
> > > > > > Guo Ren <guoren@kernel.org> =E4=BA=8E2022=E5=B9=B411=E6=9C=8823=
=E6=97=A5=E5=91=A8=E4=B8=89 23:02=E5=86=99=E9=81=93=EF=BC=9A
> > > > > > >
> > > > > > > Cool job, thx.
> > > > > > >
> > > > > > > On Wed, Nov 23, 2022 at 10:20 PM Song Shuai <suagrfillet@gmai=
l.com> wrote:
> > > > > > >>
> > > > > > >> This patch adds DYNAMIC_FTRACE_WITH_DIRECT_CALLS support for=
 RISC-V.
> > > > > > >>
> > > > > > >> select the DYNAMIC_FTRACE_WITH_DIRECT_CALLS to provide the
> > > > > > >> register_ftrace_direct[_multi] interfaces allowing users to =
register
> > > > > > >> the customed trampoline (direct_caller) as the mcount for on=
e or
> > > > > > >> more target functions. And modify_ftrace_direct[_multi] are =
also
> > > > > > >> provided for modifying direct_caller.
> > > > > > >>
> > > > > > >> To make the direct_caller and the other ftrace hooks (eg. fu=
nction/fgraph
> > > > > > >> tracer, k[ret]probes) co-exist, a temporary register is nomi=
nated to
> > > > > > >> store the address of direct_caller in ftrace_regs_caller. Af=
ter the
> > > > > > >> setting of the address direct_caller by direct_ops->func and=
 the
> > > > > > >> RESTORE_REGS in ftrace_regs_caller, direct_caller will be ju=
mped to
> > > > > > >> by the `jr` inst.
> > > > > > >>
> > > > > > >> Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> > > > > > >> ---
> > > > > > >>  arch/riscv/Kconfig              | 1 +
> > > > > > >>  arch/riscv/include/asm/ftrace.h | 6 ++++++
> > > > > > >>  arch/riscv/kernel/mcount-dyn.S  | 4 ++++
> > > > > > >>  3 files changed, 11 insertions(+)
> > > > > > >>
> > > > > > >> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > > > > >> index 39ec8d628cf6..d083ec08d0b6 100644
> > > > > > >> --- a/arch/riscv/Kconfig
> > > > > > >> +++ b/arch/riscv/Kconfig
> > > > > > >> @@ -278,6 +278,7 @@ config ARCH_RV64I
> > > > > > >>         select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
> > > > > > >>         select HAVE_DYNAMIC_FTRACE if !XIP_KERNEL && MMU && =
$(cc-option,-fpatchable-function-entry=3D8)
> > > > > > >>         select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC=
_FTRACE
> > > > > > >> +       select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
> > > > > > >>         select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
> > > > > > >>         select HAVE_FUNCTION_GRAPH_TRACER
> > > > > > >>         select HAVE_FUNCTION_TRACER if !XIP_KERNEL && !PREEM=
PTION
> > > > > > >> diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/in=
clude/asm/ftrace.h
> > > > > > >> index 01bebb28eabe..be4d57566139 100644
> > > > > > >> --- a/arch/riscv/include/asm/ftrace.h
> > > > > > >> +++ b/arch/riscv/include/asm/ftrace.h
> > > > > > >> @@ -114,6 +114,12 @@ struct ftrace_regs;
> > > > > > >>  void ftrace_graph_func(unsigned long ip, unsigned long pare=
nt_ip,
> > > > > > >>                        struct ftrace_ops *op, struct ftrace_=
regs *fregs);
> > > > > > >>  #define ftrace_graph_func ftrace_graph_func
> > > > > > >> +
> > > > > > >> +static inline void arch_ftrace_set_direct_caller(struct pt_=
regs *regs, unsigned long addr)
> > > > > > >> +{
> > > > > > >> +               regs->t1 =3D addr;
> > > > > > >
> > > > > > > How about regs->t0 =3D addr; ?
> > > > > > > And delete all mcount-dyn.S modification.
> > > > > > >
> > > > > > The direct_caller has the same program layout as the ftrace_cal=
ler, which means
> > > > > > the reg t0 will never be changed when direct_caller returns.
> > > > > >
> > > > > > If regs->t0 changes here and ftrace_regs_caller executes `jr t0=
`,
> > > > > > direct_caller will enter the dead loop.
> > > > > ?
> > > > >
> > > > > ftrace_regs_caller->call_direct_funcs->
> > > > > arch_ftrace_set_direct_caller-> ftrace_regs_caller jr t0.
> > > > >
> > > > > Only call_direct_funcs call arch_ftrace_set_direct_caller !
> > > > >
> > > > > static void call_direct_funcs(unsigned long ip, unsigned long pip=
,
> > > > >                               struct ftrace_ops *ops, struct ftra=
ce_regs *fregs)
> > > > > {
> > > > >         struct pt_regs *regs =3D ftrace_get_regs(fregs);
> > > > >         unsigned long addr;
> > > > >
> > > > >         addr =3D ftrace_find_rec_direct(ip);
> > > > >         if (!addr)
> > > > >                 return;
> > > > >
> > > > >         arch_ftrace_set_direct_caller(regs, addr);
> > > > > }
> > > > >
> > > > When direct_caller and function tracer co-hook a function, the simp=
le
> > > > diagram is like this:
> > > >
> > > > ```
> > > > func -> ftrace_regs_caller -> arch_ftrace_ops_list_func ->
> > > > function_trace_call // write ringbuffer
> > > >             |
> > > >                  -> call_direct_funcs // regs->t1 =3D direct_caller
> > > >            -> t1 !=3D0 && jr t1 // goto direct_caller
> > > > ```
> > > >
> > > ```
> > > f -- regs_caller -- list_func
> > >     |                       | -- function_trace_call
> > >     |                       | -- call_direct_funcs  // t1 =3D addr
> > >     |-- t1 !=3D0 && jr t1 // goto direct_caller
> > Cool diagram! Thx, but we still need a discussion:
> > f -- regs_caller
> >      | -- SAVE_ABI_REGS 1
> >      | -- list_func
> >      |                       | -- function_trace_call
> >      |                       | -- call_direct_funcs  // t1 =3D addr
> >      | -- RESTORE_ABI_REGS 1
> >      |-- t1 !=3D0 && jr t1 // goto direct_caller
> > If you set t1 non-zero, then we always go to direct_caller. I think
> > the code is equal to set t0=3Daddr.
> If only focusing on the whole ftrace_regs_caller code, you're right.
Yes, that's the problem I have; I didn't look at the sample code.

t0 -> ftrace caller
t1 -> my_tramp1 (direct caller)
ra -> original func return addr.

Okay, I would include these patches in v4.

Reviewed-by: Guo Ren <guoren@kernel.org>


>
> But we should also take direct_caller code into the consideration,
> if using t0 here, direct_caller will always return to itself as I
> described before.
> >      |                       | -- call_direct_funcs  // t0 =3D addr
> >      | -- RESTORE_ABI_REGS 1
> >      |-- jr t0 // goto direct_caller
> >
> > I think the only problem happens in the below non-existent situation:
> > f -- regs_caller
> >      | -- SAVE_ABI_REGS 1
> >      | -- list_func
> >      |                       | -- call_direct_funcs  // t0 =3D addr
> >      |                       | -- function_trace_call //t0 contains
> > direct_caller instead
> function_trace_call is one type of global_ops->func which doesn't take ca=
re
> of the regs->t0.
>
> But the func of IPMODIFY ops (eg. livepatch, kprobe with posthandler)
> will change regs->epc which will then be restored to t0 in ftrace_regs_ca=
ller.
> And then the address of direct_caller will be covered in this situation.
> I'm not very clear about the process of the livepatch and kprobe in RISCV
> but I think we should keep t0 for their ipmodifying.
> >      | -- RESTORE_ABI_REGS 1
> >      |-- jr t0 // goto direct_caller
> >
> > The key issue is whether going to direct_caller correctly depends on
> > call_direct_funcs called, right?
> Yes, in other words, call_direct_func informs ftrace_regs_caller that
> there is a direct caller stored in t1, please jump to it first.
> >
> > > ```
> > > This diagram looks better.
> > > > And the direct_caller has a similar implement as ftrace_caller.
> > > >
> > > > ```
> > > > direct_caller:
> > > > add sp,sp,-?
> > > > sd t0,?(sp)
> > > > sd ra,?(sp)
> > > > call foo
> > > > ld t0,?(sp)
> > > > ld ra,?(sp)
> > > > add sp,sp,?
> > > > jr t0 // <- back to function entry
> > > > ```
> > > >
> > > > If we change regs->t0 as direct_caller and execute `jr t0` directly=
,
> > > > the direct_caller will always jump to itself due to its last `jr` i=
nst.
> --- Here is what I described in the previous email.
> > > >
> > > > ```
> > > > func -> ftrace_regs_caller -> arch_ftrace_ops_list_func ->
> > > > function_trace_call // write ringbuffer
> > > >             |
> > > >                  -> call_direct_funcs // regs->t0 =3D direct_caller
> > > >            -> jr t0 // goto direct_caller
> > > >
> > > > direct_caller:
> > > > ...
> > > > sd t0,?(sp)
> > > > ...
> > > > ld t0,?(s0)
> > > > ...
> > > > jr t0 // goto direct_caller always
> > > > ```
> > > >
> > > > Hope I made it clear.
> > > > > >
> > > > > > Actually the reg t0 always saves the address of function entry =
with 8B
> > > > > > offset, it should only
> > > > > > changed by the IPMODIFY ops instead of the direct_ops.
> > > > > > >>
> > > > > > >> +}
> > > > > > >> +
> > > > > > >>  #endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
> > > > > > >>
> > > > > > >>  #endif /* __ASSEMBLY__ */
> > > > > > >> diff --git a/arch/riscv/kernel/mcount-dyn.S b/arch/riscv/ker=
nel/mcount-dyn.S
> > > > > > >> index 466c6ef217b1..b89c85a58569 100644
> > > > > > >> --- a/arch/riscv/kernel/mcount-dyn.S
> > > > > > >> +++ b/arch/riscv/kernel/mcount-dyn.S
> > > > > > >> @@ -233,6 +233,7 @@ ENDPROC(ftrace_caller)
> > > > > > >>  #else /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
> > > > > > >>  ENTRY(ftrace_regs_caller)
> > > > > > >>         SAVE_ABI_REGS 1
> > > > > > >> +       REG_S   x0, PT_T1(sp)
> > > > > > >>         PREPARE_ARGS
> > > > > > >>
> > > > > > >>  ftrace_regs_call:
> > > > > > >> @@ -241,7 +242,10 @@ ftrace_regs_call:
> > > > > > >>
> > > > > > >>
> > > > > > >>         RESTORE_ABI_REGS 1
> > > > > > >> +       bnez    t1,.Ldirect
> > > > > > >>         jr t0
> > > > > > >> +.Ldirect:
> > > > > > >> +       jr t1
> > > > > > >>  ENDPROC(ftrace_regs_caller)
> > > > > > >>
> > > > > > >>  ENTRY(ftrace_caller)
> > > > > > >> --
> > > > > > >> 2.20.1
> > > > > > >>
> > > > > > >
> > > > > > >
> > > > > > > --
> > > > > > > Best Regards
> > > > > > >  Guo Ren
> > > > >
> > > > >
> > > > >
> > > > > --
> > > > > Best Regards
> > > > >  Guo Ren
> > > > Thanks,
> > > > Song
> > > Thanks,
> > > Song
> >
> >
> >
> > --
> > Best Regards
> >  Guo Ren
> Thanks,
> Song



--=20
Best Regards
 Guo Ren
