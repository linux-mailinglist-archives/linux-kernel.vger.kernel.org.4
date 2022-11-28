Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E26463A5E5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 11:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiK1KR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 05:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiK1KR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 05:17:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05EB19C15
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 02:17:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F54F61062
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 10:17:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9B78C43470
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 10:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669630675;
        bh=0MUn60ZEBcS5ItrYkuHz15fNwlGisqMA6Q9B68kzkho=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DUAk5Hl3ZB0p/Rs/T64RSJLj24Zzi9FHFPDnWNtw6NrZbEA4X6qq7xpOX1quiEyGQ
         j0qEEVjJ93KAdM/H5q96swt08D5+kAGTVZ9/yA5om2qC4RmKarRKRzk1uTBUP87KNG
         ArgC5fwUtuKAuYaXeOT6H7ORm4GeUILtZn2lZ0wA3IuL7yh9H5WbCNoe24Y0/HyPs7
         a6mgUmO6siOOcysTbUYclIY7xaPuKAkWGWwYlDrqK5P7bEFb8g6cAL9hDCUgeGyEj7
         D61kpfCx8/6ndZbgrbhVy4+7WgOsQjFsokPwAQmVbzSZt2/swm0o78cfS0gNuwAgqE
         JoRbIlVOgu+2Q==
Received: by mail-ej1-f43.google.com with SMTP id ha10so24552885ejb.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 02:17:55 -0800 (PST)
X-Gm-Message-State: ANoB5pna1RBDIeVDxwzPbrVCK+d2JKbqC2DdUPFYsEiQLgBn6jvm7OHv
        vSZsyZAJmKguafn/PM7vdVjC+/68YZkIyimB9NU=
X-Google-Smtp-Source: AA0mqf6ikWF1asQF3YBC10JQHUtfmR19FRsRbSUoFqzTAFxrMPIMVdTdOt5yAqAwLuas9ZFHTyAc264LtVoXwfKQUlU=
X-Received: by 2002:a17:906:1546:b0:741:5c0e:1058 with SMTP id
 c6-20020a170906154600b007415c0e1058mr41905543ejd.472.1669630673952; Mon, 28
 Nov 2022 02:17:53 -0800 (PST)
MIME-Version: 1.0
References: <20221123142025.1504030-1-suagrfillet@gmail.com>
 <20221123142025.1504030-2-suagrfillet@gmail.com> <CAJF2gTTwvApRaGhZJxOrdcjWUC9DN-WF_7EKcHXx5HZ9Jkd5EA@mail.gmail.com>
 <CAAYs2=ghhMmmrM4Bktvw9iGiajS5PLd1=Z61j2ZfhbhGUi4ekg@mail.gmail.com>
 <CAJF2gTTWSr0qYTnRORSexEHMqUt-Lj6xZd0O-fUgC+f74FfCZA@mail.gmail.com>
 <CAAYs2=ifvfY3QW07LXL+B6KH6b3EELMcXuz6ja_rYNE=G4+=qQ@mail.gmail.com>
 <CAJF2gTQ6hEyfpo1wTUp1UwAGP1kMpEYjLqR-fz6UrCMjHN1VuQ@mail.gmail.com> <CAAYs2=hNAwDk7=F077ityNykZJCCvGVyXsxRzZO3s7rKwOPpUg@mail.gmail.com>
In-Reply-To: <CAAYs2=hNAwDk7=F077ityNykZJCCvGVyXsxRzZO3s7rKwOPpUg@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 28 Nov 2022 18:17:42 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTLuXKKRw7UOmZB4qkVhcLFkQUiFAcKouX7DLAy-SsWNg@mail.gmail.com>
Message-ID: <CAJF2gTTLuXKKRw7UOmZB4qkVhcLFkQUiFAcKouX7DLAy-SsWNg@mail.gmail.com>
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

On Fri, Nov 25, 2022 at 2:33 PM Song Shuai <suagrfillet@gmail.com> wrote:
>
> Guo Ren <guoren@kernel.org> =E4=BA=8E2022=E5=B9=B411=E6=9C=8825=E6=97=A5=
=E5=91=A8=E4=BA=94 03:10=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Fri, Nov 25, 2022 at 9:53 AM Song Shuai <suagrfillet@gmail.com> wrot=
e:
> > >
> > > Guo Ren <guoren@kernel.org> =E4=BA=8E2022=E5=B9=B411=E6=9C=8824=E6=97=
=A5=E5=91=A8=E5=9B=9B 15:31=E5=86=99=E9=81=93=EF=BC=9A
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
> > > > >
> > > > > Actually the reg t0 always saves the address of function entry wi=
th 8B
> > > > > offset, it should only
> > > > > changed by the IPMODIFY ops instead of the direct_ops.
> > > > How about:
> > > > static inline void arch_ftrace_set_direct_caller(struct pt_regs *re=
gs,
> > > > unsigned long addr)
> > > > {
> > > >                regs->t1 =3D regs->t0;
> > > >                regs->t0 =3D addr;
> > > >
> > > > direct_caller:
> > > > add sp,sp,-?
> > > > sd t1,?(sp)
> > > direct_caller also serves as the first trampoline as ftrace_caller, l=
ike this:
> > > ```
> > > func -- direct_caller
> > >         -- ftrace_[regs]_caller
> > > ```
> > > So the t1 in this line has to be t0 to save the PC.
> >
> > direct_caller:
> > add sp,sp,-?
> > sd t1,?(sp)
> > sd t0, ?(so)
> > sd ra,?(sp)
> > mov t0, t1
> This foo is the tracing function along with the direct_caller,
> and it has the same parameters as the target function.
> So the t0 or t1 here means nothing for this foo function.
>
> No offense, but what's the purpose of this mv inst?
Here is my modification: [1]
[1]: https://lore.kernel.org/linux-riscv/20221128101201.4144527-1-guoren@ke=
rnel.org/

I've tested like this:
mount -t debugfs none /sys/kernel/debug/
cd /sys/kernel/debug/tracing/
echo handle_mm_fault > set_ftrace_filter
echo 'r:myr handle_mm_fault' > kprobe_events
echo function > current_tracer
echo 1 > events/kprobes/myr/enable
insmod /root/ftrace/ftrace-direct-too.ko
cat trace

             cat-137     [000] .....  3132.231948: handle_mm_fault
<-do_page_fault
             cat-137     [000] .....  3132.231973: my_direct_func:
handle mm fault vma=3D000000001ba58b17 address=3Daaaaaaaab689c8 flags=3D254
             cat-137     [000] .....  3132.232622: myr:
(do_page_fault+0x176/0x424 <- handle_mm_fault)
             cat-137     [000] .....  3132.232724: handle_mm_fault
<-do_page_fault
             cat-137     [000] .....  3132.232750: my_direct_func:
handle mm fault vma=3D000000001ba58b17 address=3Daaaaaaaab7df9c flags=3D254
             cat-137     [000] .....  3132.233385: myr:
(do_page_fault+0x176/0x424 <- handle_mm_fault)
             cat-137     [000] .....  3132.233744: handle_mm_fault
<-do_page_fault
             cat-137     [000] .....  3132.233772: my_direct_func:
handle mm fault vma=3D000000001ba58b17 address=3Daaaaaaaab2b2c8 flags=3D354
             cat-137     [000] .....  3132.234392: myr:
(do_page_fault+0x176/0x424 <- handle_mm_fault)
             cat-137     [000] .....  3132.234480: handle_mm_fault
<-do_page_fault
             cat-137     [000] .....  3132.234505: my_direct_func:
handle mm fault vma=3D000000001ba58b17 address=3Daaaaaaaab5afc0 flags=3D354
             cat-137     [000] .....  3132.235149: myr:
(do_page_fault+0x176/0x424 <- handle_mm_fault)
             cat-137     [000] .....  3132.235263: handle_mm_fault
<-do_page_fault
             cat-137     [000] .....  3132.235289: my_direct_func:
handle mm fault vma=3D0000000071a096de address=3Dfffffff7fac530 flags=3D254
             cat-137     [000] .....  3132.235893: myr:
(do_page_fault+0x176/0x424 <- handle_mm_fault)


> > call foo
> > ld t0,?(sp)
> > ld t1,?(sp)
> > ld ra,?(sp)
> > add sp,sp,?
> > jr t1 // <- back to function entry
> When direct_caller works as the first trampoline
> the content of t1 here means nothing for the target function, neither
> PC nor PIP.
> >
> >
> > > > sd ra,?(sp)
> > > > call foo
> > > > ld t1,?(sp)
> > > And this line.
> > > > ld ra,?(sp)
> > > > add sp,sp,?
> > > > jr t1 // <- back to function entry
> > > >
> > > > And delete all mcount-dyn.S modification.
> > > >
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
> >
> >
> >
> > --
> > Best Regards
> >  Guo Ren



--=20
Best Regards
 Guo Ren
