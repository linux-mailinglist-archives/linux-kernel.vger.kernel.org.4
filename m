Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8E662F234
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 11:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241396AbiKRKLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 05:11:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241634AbiKRKLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 05:11:05 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE0C90382
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 02:11:03 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id f3so4620358pgc.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 02:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eEtO4CCEimDC+Nu/x59xP/BnLVUUH7IsIaxLuiVF9wI=;
        b=mmP1E48vDI/X6tezRg8p/ZlNubcRrcm4WHeJ7wSSfUF3NYd6AGBizR0AX5Wt/oNkMl
         FHvzd4KGnYL4v8Bd3+N8H3/yJel61rYiPU0e1gQrNlMPJBaRV7yDrlXDbXM/5SsZK1a+
         OI8Q84ZQjc3exqCgsetx/l9ssMFQLebvh56fFwsEjbYIYIXTXUZGMLYzHUbyXPyUkTf9
         mz+FprZXs7gAazbSVn0lTVBHu6+dFsmRJn12EcitUnnupOVjH8Z2B1n5dBDWji3fGXsw
         YaxEHpp3T+ypYNjcQgbcc7n9uoGL8opSU0sGWV2gkT7+e4l5tPK/bQ9xCf/MW64yz23m
         Kslw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eEtO4CCEimDC+Nu/x59xP/BnLVUUH7IsIaxLuiVF9wI=;
        b=f03Uf5f0ldJxwLh74QbWG4gDtEZOjX645fuJbYnX+WDJzLUmjOQvbK91akyElgQUz7
         +u4JdESh5PGI6oQkWbbcCKdnfAaAqDbYiiG0DJ3+eVUVWN0aVCmQ1VYAakB3LzWpfCs0
         VNsPZ6Gh9XrEugJ4K2v4LdnCXo9uSZXGynaQqMAGA4aXKvgTwcvKMG16MtLsJoscLwW+
         DpGiU753Rw/ARerbOgeTdZMuMW3o9+uHrvWdaypNifxxtBp2z8R9CKLUO30PEszWqL9H
         jSHAPOipz7RnNorYE/gRIgZmSuegYSs1FF7QnR2qu7sF+E30KGYo1pzl+oE3+yAqlPJf
         r/Lw==
X-Gm-Message-State: ANoB5pmuB1Lp+aMZWGBxpF0ttdU0Mhcvkw2BS8ABHiRMreeyewpYCF2T
        /dRXmDzDq3epw2gvMMyErEg/LW0v/sXXbwg0Coc=
X-Google-Smtp-Source: AA0mqf57B6397TWze0+q8Eft0ytEgpTVA4uXE2s8DlX7b/KXQhKGXAhj8gXafrGehZRzZ6ysmROS5/2jHviaeCMD2do=
X-Received: by 2002:aa7:8a0c:0:b0:56c:2a86:d74 with SMTP id
 m12-20020aa78a0c000000b0056c2a860d74mr7021501pfa.73.1668766263192; Fri, 18
 Nov 2022 02:11:03 -0800 (PST)
MIME-Version: 1.0
References: <20221116031305.286634-1-suagrfillet@gmail.com> <CAJF2gTS0jFkynErVVnQPoqzo-_cWRPRCYZLwRyTpuaxu7NVdWQ@mail.gmail.com>
In-Reply-To: <CAJF2gTS0jFkynErVVnQPoqzo-_cWRPRCYZLwRyTpuaxu7NVdWQ@mail.gmail.com>
From:   Song Shuai <suagrfillet@gmail.com>
Date:   Fri, 18 Nov 2022 10:10:00 +0000
Message-ID: <CAAYs2=iW=SOXhT__95ezV_J89wPR_dySLnWgS-dRCMizGJGGcA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] riscv/ftrace: make function graph use ftrace directly
To:     Guo Ren <guoren@kernel.org>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
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

Guo Ren <guoren@kernel.org> =E4=BA=8E2022=E5=B9=B411=E6=9C=8817=E6=97=A5=E5=
=91=A8=E5=9B=9B 01:46=E5=86=99=E9=81=93=EF=BC=9A
>
> I hope this series could base on the following:
> https://lore.kernel.org/linux-riscv/20220921034910.3142465-4-guoren@kerne=
l.org/
>
> They all modified the mcount-dyn.S.
Ok, I'll adapt these patches based on the series you mentioned.
>
>
> On Wed, Nov 16, 2022 at 11:13 AM Song Shuai <suagrfillet@gmail.com> wrote=
:
> >
> > In RISC-V architecture, when we enable the ftrace_graph tracer on some
> > functions, the function tracings on other functions will suffer extra
> > graph tracing work. In essence, graph_ops isn't limited by its func_has=
h
> > due to the global ftrace_graph_[regs]_call label. That should be correc=
ted.
> >
> > What inspires me is the commit 0c0593b45c9b ("x86/ftrace: Make function
> > graph use ftrace directly") that uses graph_ops::func function to insta=
ll
> > return_hooker and makes the function called against its func_hash.
> >
> > This series of patches makes function graph use ftrace directly for ris=
cv.
> >
> > If FTRACE_WITH_REGS isn't defined, ftrace_caller keeps ftrace_graph_cal=
l
> > so that it can be replaced with the calling of prepare_ftrace_return by
> > the enable/disable helper.
> >
> > As for defining FTRACE_WITH_REGS, ftrace_caller is adjusted to save the
> > necessary regs against the pt_regs layout, so it can reasonably call th=
e
> > graph_ops::func function - ftrace_graph_func. And ftrace_graph_[regs]_c=
all
> > and its enable/disable helper aren't needed.
> >
> > The tests generated by CONFIG_FTRACE_STARTUP_TEST have passed in the lo=
cal
> > qemu-system-riscv64 virt machine. The following is the log during start=
up.
> >
> > ```
> > Nov 15 03:07:13 stage4 kernel: Testing tracer function: PASSED
> > Nov 15 03:07:13 stage4 kernel: Testing dynamic ftrace: PASSED
> > Nov 15 03:07:13 stage4 kernel: Testing dynamic ftrace ops #1:
> > Nov 15 03:07:13 stage4 kernel: (1 0 1 0 0)
> > Nov 15 03:07:13 stage4 kernel: (1 1 2 0 0)
> > Nov 15 03:07:13 stage4 kernel: (2 1 3 0 365)
> > Nov 15 03:07:13 stage4 kernel: (2 2 4 0 399)
> > Nov 15 03:07:13 stage4 kernel: (3 2 4 0 146071)
> > Nov 15 03:07:13 stage4 kernel: (3 3 5 0 146105) PASSED
> > Nov 15 03:07:13 stage4 kernel: Testing dynamic ftrace ops #2:
> > Nov 15 03:07:13 stage4 kernel: (1 0 1 589 0)
> > Nov 15 03:07:13 stage4 kernel: (1 1 2 635 0)
> > Nov 15 03:07:13 stage4 kernel: (2 1 3 1 2)
> > Nov 15 03:07:13 stage4 kernel: (2 2 4 125 126)
> > Nov 15 03:07:13 stage4 kernel: (3 2 4 146001 146078)
> > Nov 15 03:07:13 stage4 kernel: (3 3 5 146035 146112) PASSED
> > Nov 15 03:07:13 stage4 kernel: Testing ftrace recursion: PASSED
> > Nov 15 03:07:13 stage4 kernel: Testing ftrace recursion safe: PASSED
> > Nov 15 03:07:13 stage4 kernel: Testing ftrace regs: PASSED
> > Nov 15 03:07:13 stage4 kernel: Testing tracer nop: PASSED
> > Nov 15 03:07:13 stage4 kernel: Testing tracer irqsoff: PASSED
> > Nov 15 03:07:13 stage4 kernel: Testing tracer wakeup:
> > Nov 15 03:07:13 stage4 kernel: sched: DL replenish lagged too much
> > Nov 15 03:07:13 stage4 kernel: PASSED
> > Nov 15 03:07:13 stage4 kernel: Testing tracer wakeup_rt: PASSED
> > Nov 15 03:07:13 stage4 kernel: Testing tracer wakeup_dl: PASSED
> > Nov 15 03:07:13 stage4 kernel: Testing tracer function_graph: PASSED
> > ```
> >
> > Note that the changes of mcount-dyn.S conflicts with this unmerged
> > commit (riscv: entry: consolidate general regs saving/restoring).
> > https://lore.kernel.org/linux-riscv/20221103075047.1634923-15-guoren@ke=
rnel.org
> >
> > Changes since v1
> > -  fixed the checkpatch warnings in patch 1
> > Link: https://lore.kernel.org/linux-riscv/20221115061525.112757-1-suagr=
fillet@gmail.com
> >
> > Song Shuai (3):
> >   riscv/ftrace: add ftrace_graph_func
> >   riscv/ftrace: SAVE_ALL supports lightweight save
> >   riscv/ftrace: cleanup ftrace_caller and ftrace_regs_caller
> >
> >  arch/riscv/include/asm/ftrace.h |  13 ++-
> >  arch/riscv/kernel/ftrace.c      |  35 ++++----
> >  arch/riscv/kernel/mcount-dyn.S  | 145 +++++++++++++++++++++++---------
> >  3 files changed, 136 insertions(+), 57 deletions(-)
> >
> > --
> > 2.20.1
> >
>
>
> --
> Best Regards
>  Guo Ren

Thanks,
Song
