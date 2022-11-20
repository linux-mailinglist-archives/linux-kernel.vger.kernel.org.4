Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE3E63132D
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 10:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiKTJMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 04:12:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiKTJMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 04:12:20 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405D88F3CF
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 01:12:19 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso8379024pjt.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 01:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rekVEDKKlijw7I/2Qf31vZa1TulCD9iTi5HOGYS/PLk=;
        b=C2WZax14f5SkUzd4O3PNrmtFTC/w+YH5ebqMXfcH5DvU4TzZyyBGCzDr3AOcw3fNj5
         yJhHkijjHf+eUnb88FlsHynTlxrnXc7SEueO54KK8sr7kJHOen0hN+SYLYqUuhQGdGbG
         lXT3Ohp3KRut6/aD7erwPb2t1q5z9Te/DBjDNo5risNzwsPlW3cysG6XWJSR7UUt/WLh
         hWDd4+mNeyH8EbNto9Taj2FCa53oA5hPqlNC4UoJhi3/balQ3LnZ1FPaLf8d/aDPCrmj
         pLoOdC8hzJn+5tmKYKnE6BLOx4J2trcjpOaFeEocSSmeSErZ9Dr2cbGMtaBRXHAtEnVq
         ZaMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rekVEDKKlijw7I/2Qf31vZa1TulCD9iTi5HOGYS/PLk=;
        b=GyhbcOyeWgbnOzkB7PoUEYsk4uU08kjsikJn24Z/zorhr/gIrotKbFHfKULcfan6UH
         CCQlbOmlR2Y6pP3dOc1oe+50T3i5qxcKdL4zJuM1dkX+wzNEb7c8lstMBQTH53Vb3OPk
         zHyHSlns6aWPYJAA4cQxFU1ez2rhWL65fwrY0UpYSGzSvsxvttEg7kvdpLteJN7PcxV2
         2teT8acAIOxNGkk3iMHc9vHb0yIKMStsHRSvQfD9gKQ4ZAFqgx9PNY57DmCBn2nAb0bC
         TiTcuDGn2iw80lWoEvE51We54IHFDhVMMWuipzVE9Dlk3XnX4qRja2p9A7UDnxoX99qY
         3E1w==
X-Gm-Message-State: ANoB5pkw2UZFKtoLqM/KI6awbcTSi8+dJJkoHqUHb6+FZ8jedZ35eeYR
        trQ/0ZH0k0pCzJZ877uHJiSwgC+dwXz+wVrfB04=
X-Google-Smtp-Source: AA0mqf4vTe0Ybq/3/VHIqM7d+6C/bTPB1GxUDmLT8wRMuvBKK2ijhCybePhbgLPaIiIC6xTvBPTzc4WVdcv3mBQcRPA=
X-Received: by 2002:a17:902:6847:b0:183:6555:38ef with SMTP id
 f7-20020a170902684700b00183655538efmr6808724pln.157.1668935538643; Sun, 20
 Nov 2022 01:12:18 -0800 (PST)
MIME-Version: 1.0
References: <20221118173217.888077-1-suagrfillet@gmail.com> <CAJF2gTTHWtm-nYD0SdcvnxAXkiNOVBZAkVx8SkJL2w-K9iaWZQ@mail.gmail.com>
In-Reply-To: <CAJF2gTTHWtm-nYD0SdcvnxAXkiNOVBZAkVx8SkJL2w-K9iaWZQ@mail.gmail.com>
From:   Song Shuai <suagrfillet@gmail.com>
Date:   Sun, 20 Nov 2022 09:12:06 +0000
Message-ID: <CAAYs2=hvw0eKDpZtxmQzqXrgvfoj+XD9qCjcAmddZLQvOEqtHQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] riscv/ftrace: make function graph use ftrace directly
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

Guo Ren <guoren@kernel.org> =E4=BA=8E2022=E5=B9=B411=E6=9C=8820=E6=97=A5=E5=
=91=A8=E6=97=A5 04:26=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sat, Nov 19, 2022 at 1:32 AM Song Shuai <suagrfillet@gmail.com> wrote:
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
> > Changes since v2:
> > - line up the comments [Andrew]
> > - rename SAVE_ALL as SAVE_ABI_REGS [Guo Ren]
> > - consolidate the modifications of mcount-dyn.S into one patch [Guo Ren=
]
> > - adapt this series based on [riscv: ftrace: Fixup ftrace detour code][=
1] [Guo Ren]
> Tested-by: Guo Ren <guoren@kernel.org>
>
> https://github.com/guoren83/linux/tree/ftrace_fixup_v3
>
Thanks for your tests.

And the PREPARE_ARGS you suggested has been added in the v4 thread.
Here is the link for your convenience.
https://lore.kernel.org/linux-riscv/20221120084230.910152-1-suagrfillet@gma=
il.com/

> >
> > [1]: https://lore.kernel.org/linux-riscv/20220921034910.3142465-1-guore=
n@kernel.org/
> > v2 Link: https://lore.kernel.org/linux-riscv/20221116031305.286634-1-su=
agrfillet@gmail.com/
> >
> > Changes since v1:
> > - fix the checkpatch warnings in patch 1
> > v1 Link: https://lore.kernel.org/linux-riscv/20221115061525.112757-1-su=
agrfillet@gmail.com
> >
> > Song Shuai (2):
> >   riscv/ftrace: add ftrace_graph_func
> >   riscv/ftrace: make ftrace_caller call ftrace_graph_func
> >
> >  arch/riscv/include/asm/ftrace.h |  13 ++-
> >  arch/riscv/kernel/ftrace.c      |  30 +++----
> >  arch/riscv/kernel/mcount-dyn.S  | 143 +++++++++++++++++++++++---------
> >  3 files changed, 129 insertions(+), 57 deletions(-)
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
