Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0287638230
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 02:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiKYBxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 20:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKYBxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 20:53:33 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063A72AE0A
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 17:53:31 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id c21so992765pfb.10
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 17:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KXQVt0h+pcpEUzQ0rG/bapcrBmAHayOWk2YjYsGPK0c=;
        b=L6YegcttMNJWrf/sMnBsIZ2psJKiN3k0P5iY6QHS965IMIzXJFAu618/8qy70uvlnf
         yY3Uir/UEnDb1nN6vLycAulTCcBIOm7kK51BjxnGkzcmUazWTr5deEKD8Bl9uzVrKsDI
         wMaP1ogdR11PgdXJalJYWQZ6q543NMvVAuZCIFHtPXNETiF9FoRdDkGPLnWCi1PlGeyP
         zyrd05JKGjDC02xH3+lSXh95NnmBZ0IY2bnxMiXLF8P/S4YsqlrpVRazsi3cw2XCe1fE
         NMqQ5D+fswnqxXHxYvx8cPAQwbJjZMZIn6M9CzqiP3dw5SDGfFMVbi1f0IPROh18LVvc
         o8bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KXQVt0h+pcpEUzQ0rG/bapcrBmAHayOWk2YjYsGPK0c=;
        b=v284D57+TVDWF9X4UiaMdizkssY8Q1aUWsWwf32aqZaVl3H2+C+lyc0taNc1ewUhW5
         rbjLORK2iZM3on2fIg3PiTWjK/KJywc/DHTSp+ZsThdtEIT0s/AB3jkkqlY5/swZlsZG
         c2ufHFWN1A2GcpM0ZSO0FUhlqZLBRFRGhiH+zTylXNPLNEQ5kaSZQwVqgT+e1gMIICTp
         aaO13lkmsK8OAUDcDtS4CS97fzA0/qR9TUwYRflnh3dbcMFryV/a2g6gBwZaAAv+65RS
         uztJ2jHwe6XPs10166PWRef0mE2vnzrNhxMYRobgdPsTclCC7OrDLQy/aUnYoyf08YrH
         cqOg==
X-Gm-Message-State: ANoB5pmG81kavkpFAnbz5k2VSKiWBc54EFDYNhGq6IV94VtNWHyHLxZ0
        ExD671LK2tcnZ7Vs2KHZEhs+EPwAJUgte9SxScA=
X-Google-Smtp-Source: AA0mqf5d7INgWCp+sfzP40RVpZ97fEh3UJhx0EHTDJM9/wPMWwRtrnjOHWuEwxfIN8yVh23kVD1U99qz4yhnMKcUmPw=
X-Received: by 2002:aa7:824f:0:b0:56e:8ed7:569f with SMTP id
 e15-20020aa7824f000000b0056e8ed7569fmr8656515pfn.19.1669341211152; Thu, 24
 Nov 2022 17:53:31 -0800 (PST)
MIME-Version: 1.0
References: <20221123142025.1504030-1-suagrfillet@gmail.com>
 <20221123142025.1504030-2-suagrfillet@gmail.com> <CAJF2gTTwvApRaGhZJxOrdcjWUC9DN-WF_7EKcHXx5HZ9Jkd5EA@mail.gmail.com>
 <CAAYs2=ghhMmmrM4Bktvw9iGiajS5PLd1=Z61j2ZfhbhGUi4ekg@mail.gmail.com> <CAJF2gTTWSr0qYTnRORSexEHMqUt-Lj6xZd0O-fUgC+f74FfCZA@mail.gmail.com>
In-Reply-To: <CAJF2gTTWSr0qYTnRORSexEHMqUt-Lj6xZd0O-fUgC+f74FfCZA@mail.gmail.com>
From:   Song Shuai <suagrfillet@gmail.com>
Date:   Fri, 25 Nov 2022 01:53:19 +0000
Message-ID: <CAAYs2=ifvfY3QW07LXL+B6KH6b3EELMcXuz6ja_rYNE=G4+=qQ@mail.gmail.com>
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
=91=A8=E5=9B=9B 15:31=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Nov 24, 2022 at 1:27 AM Song Shuai <suagrfillet@gmail.com> wrote:
> >
> > Guo Ren <guoren@kernel.org> =E4=BA=8E2022=E5=B9=B411=E6=9C=8823=E6=97=
=A5=E5=91=A8=E4=B8=89 23:02=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > Cool job, thx.
> > >
> > > On Wed, Nov 23, 2022 at 10:20 PM Song Shuai <suagrfillet@gmail.com> w=
rote:
> > >>
> > >> This patch adds DYNAMIC_FTRACE_WITH_DIRECT_CALLS support for RISC-V.
> > >>
> > >> select the DYNAMIC_FTRACE_WITH_DIRECT_CALLS to provide the
> > >> register_ftrace_direct[_multi] interfaces allowing users to register
> > >> the customed trampoline (direct_caller) as the mcount for one or
> > >> more target functions. And modify_ftrace_direct[_multi] are also
> > >> provided for modifying direct_caller.
> > >>
> > >> To make the direct_caller and the other ftrace hooks (eg. function/f=
graph
> > >> tracer, k[ret]probes) co-exist, a temporary register is nominated to
> > >> store the address of direct_caller in ftrace_regs_caller. After the
> > >> setting of the address direct_caller by direct_ops->func and the
> > >> RESTORE_REGS in ftrace_regs_caller, direct_caller will be jumped to
> > >> by the `jr` inst.
> > >>
> > >> Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> > >> ---
> > >>  arch/riscv/Kconfig              | 1 +
> > >>  arch/riscv/include/asm/ftrace.h | 6 ++++++
> > >>  arch/riscv/kernel/mcount-dyn.S  | 4 ++++
> > >>  3 files changed, 11 insertions(+)
> > >>
> > >> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > >> index 39ec8d628cf6..d083ec08d0b6 100644
> > >> --- a/arch/riscv/Kconfig
> > >> +++ b/arch/riscv/Kconfig
> > >> @@ -278,6 +278,7 @@ config ARCH_RV64I
> > >>         select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
> > >>         select HAVE_DYNAMIC_FTRACE if !XIP_KERNEL && MMU && $(cc-opt=
ion,-fpatchable-function-entry=3D8)
> > >>         select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
> > >> +       select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
> > >>         select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
> > >>         select HAVE_FUNCTION_GRAPH_TRACER
> > >>         select HAVE_FUNCTION_TRACER if !XIP_KERNEL && !PREEMPTION
> > >> diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/as=
m/ftrace.h
> > >> index 01bebb28eabe..be4d57566139 100644
> > >> --- a/arch/riscv/include/asm/ftrace.h
> > >> +++ b/arch/riscv/include/asm/ftrace.h
> > >> @@ -114,6 +114,12 @@ struct ftrace_regs;
> > >>  void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
> > >>                        struct ftrace_ops *op, struct ftrace_regs *fr=
egs);
> > >>  #define ftrace_graph_func ftrace_graph_func
> > >> +
> > >> +static inline void arch_ftrace_set_direct_caller(struct pt_regs *re=
gs, unsigned long addr)
> > >> +{
> > >> +               regs->t1 =3D addr;
> > >
> > > How about regs->t0 =3D addr; ?
> > > And delete all mcount-dyn.S modification.
> > >
> > The direct_caller has the same program layout as the ftrace_caller, whi=
ch means
> > the reg t0 will never be changed when direct_caller returns.
> >
> > If regs->t0 changes here and ftrace_regs_caller executes `jr t0`,
> > direct_caller will enter the dead loop.
> >
> > Actually the reg t0 always saves the address of function entry with 8B
> > offset, it should only
> > changed by the IPMODIFY ops instead of the direct_ops.
> How about:
> static inline void arch_ftrace_set_direct_caller(struct pt_regs *regs,
> unsigned long addr)
> {
>                regs->t1 =3D regs->t0;
>                regs->t0 =3D addr;
>
> direct_caller:
> add sp,sp,-?
> sd t1,?(sp)
direct_caller also serves as the first trampoline as ftrace_caller, like th=
is:
```
func -- direct_caller
        -- ftrace_[regs]_caller
```
So the t1 in this line has to be t0 to save the PC.
> sd ra,?(sp)
> call foo
> ld t1,?(sp)
And this line.
> ld ra,?(sp)
> add sp,sp,?
> jr t1 // <- back to function entry
>
> And delete all mcount-dyn.S modification.
>
> > >>
> > >> +}
> > >> +
> > >>  #endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
> > >>
> > >>  #endif /* __ASSEMBLY__ */
> > >> diff --git a/arch/riscv/kernel/mcount-dyn.S b/arch/riscv/kernel/mcou=
nt-dyn.S
> > >> index 466c6ef217b1..b89c85a58569 100644
> > >> --- a/arch/riscv/kernel/mcount-dyn.S
> > >> +++ b/arch/riscv/kernel/mcount-dyn.S
> > >> @@ -233,6 +233,7 @@ ENDPROC(ftrace_caller)
> > >>  #else /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
> > >>  ENTRY(ftrace_regs_caller)
> > >>         SAVE_ABI_REGS 1
> > >> +       REG_S   x0, PT_T1(sp)
> > >>         PREPARE_ARGS
> > >>
> > >>  ftrace_regs_call:
> > >> @@ -241,7 +242,10 @@ ftrace_regs_call:
> > >>
> > >>
> > >>         RESTORE_ABI_REGS 1
> > >> +       bnez    t1,.Ldirect
> > >>         jr t0
> > >> +.Ldirect:
> > >> +       jr t1
> > >>  ENDPROC(ftrace_regs_caller)
> > >>
> > >>  ENTRY(ftrace_caller)
> > >> --
> > >> 2.20.1
> > >>
> > >
> > >
> > > --
> > > Best Regards
> > >  Guo Ren
>
>
>
> --
> Best Regards
>  Guo Ren
Thanks,
Song
