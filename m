Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89F96694A4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 11:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241219AbjAMKtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 05:49:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232707AbjAMKsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 05:48:31 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E81D5B17E
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 02:48:29 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id 20so10465761pfu.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 02:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uyj3TwzBgby276fYkwjh/KxFYXe9oOyXX4g7G8kK/p0=;
        b=D4QpuR0Ek7VGnZL/h5VfnLuLlgOFi6m9LmbxoGsKQLJlCDY762eEhHU2YtKxe4mUV5
         vV9RrRnszA6U+FhJVniWPE8zG0k1mfi4G7UmbDdY+KLY1moC/ix11e1FRDrMq4vSXq7R
         RoVPPmimZYqtUCLd8g4eZrHZbcEaCJbP3Vn4U5PEUfCMAnkl/1JHrvqfkCoP2hj1SEuT
         xXy2+aIN8EOWxYcilJ0Ks9mdIcgrIZGlxn6yH3YC7OMwNIjJp3Brjs0ACEMq5vmJxwMu
         RaqpevTmr546nR27vb/kT2YUXoT4XiMfIHs/RqOphOeQFwW19zYICNl9BOrT5YagiaWM
         23hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uyj3TwzBgby276fYkwjh/KxFYXe9oOyXX4g7G8kK/p0=;
        b=BmdGnQbkn6GSgA5vS5Yylq8jHo9gT/wUHkvvRYaqv6ZklEhNd05rTTIjC9pWc22Sth
         aVUkuwzxxlM0bGMzsnZbm52oiX2OXVx5joBGlTUq4UGqd9Amxf6I9mdHb1+A09FdQLdK
         FNie+dvRW0yfvr0KJ3wv/eGyjt601HblhhnqXtGRDQt6gO57TMBvof2UHu9kc1L4mMF9
         YZvbxCPYb4bq2Qth6mZlU7uweOYz8a257ZBDtxdfuPmPI74gS5531rZ5GLZ2uIlmN4dQ
         F3898Sp3bTDjIeK1EoUCCfshsI7r8glRAD5OmPb7bg/DQB7rPkrZupiN2SdAzBJ8/tDN
         ezjQ==
X-Gm-Message-State: AFqh2kpiUl5BP5l99WZilnrK5UOvQrNkT1Qg726U9KcD0V4HRUQfzepU
        2nKV402uJmOJ6C96HVZzPgepsPrnttFsy69PhkE=
X-Google-Smtp-Source: AMrXdXuwg3u6VrpJo+EzaC/SfJAKTVt2tT3szbgEJKwiyiuqAtwsb/mgfd6FDgnoSRAN14lVv73Z/RXGl12JvH6gW34=
X-Received: by 2002:a62:3894:0:b0:58b:b0c1:5602 with SMTP id
 f142-20020a623894000000b0058bb0c15602mr297276pfa.73.1673606908950; Fri, 13
 Jan 2023 02:48:28 -0800 (PST)
MIME-Version: 1.0
References: <20230107133549.4192639-1-guoren@kernel.org> <20230107133549.4192639-8-guoren@kernel.org>
 <CAAYs2=h464Fx8ix4f_aJWBfRaz8BipfvxzAZoGDnBQkPrY_nNQ@mail.gmail.com>
In-Reply-To: <CAAYs2=h464Fx8ix4f_aJWBfRaz8BipfvxzAZoGDnBQkPrY_nNQ@mail.gmail.com>
From:   Song Shuai <suagrfillet@gmail.com>
Date:   Fri, 13 Jan 2023 10:48:17 +0000
Message-ID: <CAAYs2=jiOF8qrurRx20Hfu9e=5YSw+ONeLQPM7xV7-igiCG+7Q@mail.gmail.com>
Subject: Re: [PATCH -next V6 7/7] samples: ftrace: Add riscv support for SAMPLE_FTRACE_DIRECT[_MULTI]
To:     guoren@kernel.org
Cc:     anup@brainfault.org, e.shatokhin@yadro.com,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        conor.dooley@microchip.com, heiko@sntech.de, rostedt@goodmis.org,
        mhiramat@kernel.org, jolsa@redhat.com, bp@suse.de,
        jpoimboe@kernel.org, andy.chiu@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
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

Hi,Guo:

Song Shuai <suagrfillet@gmail.com> =E4=BA=8E2023=E5=B9=B41=E6=9C=8811=E6=97=
=A5=E5=91=A8=E4=B8=89 09:50=E5=86=99=E9=81=93=EF=BC=9A
>
> <guoren@kernel.org> =E4=BA=8E2023=E5=B9=B41=E6=9C=887=E6=97=A5=E5=91=A8=
=E5=85=AD 13:36=E5=86=99=E9=81=93=EF=BC=9A
> >
> > From: Song Shuai <suagrfillet@gmail.com>
> >
> > select HAVE_SAMPLE_FTRACE_DIRECT and HAVE_SAMPLE_FTRACE_DIRECT_MULTI
> > for ARCH_RV64I in arch/riscv/Kconfig. And add riscv asm code for
> > the ftrace-direct*.c files in samples/ftrace/.
> >
> > Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> > Tested-by: Guo Ren <guoren@kernel.org>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > ---
> Hi,Guo && Evgenii:
>
> As Evgenii comments, this patch has two problems to fix:
>
> 1. the modification of Kconfig is missing
> So we should add it back
>
> 2. the build error resulted by including of nospec-branch.h file
> This including is exclusive for x86 architecture, moving it under
> x86 #ifdef seems better to fix this error
>
> I fixed them in my GitHub repo, but I can't find a reasonable target
> branch in your repo to PR.
> So I paste the link of my branch here, you can pick the first 2
> commits in the next series.
>
> - samples: ftrace: Add riscv support for SAMPLE_FTRACE_DIRECT[_MULTI]
> - samples: ftrace: Include the nospec-branch.h only for x86
This patch for the 2nd problem mentioned above seems to be omitted in
the V7 series.
I paste the raw patch link here. Hope you can add it in the next.

https://github.com/sugarfillet/linux/commit/9539a80dc6e7d1137ec7a96ebef2ab9=
12a694bd7.patch
>
> Link: https://github.com/sugarfillet/linux/commits/song_ftrace_fix_up_v6
>
> >  samples/ftrace/ftrace-direct-modify.c       | 33 ++++++++++++++++++
> >  samples/ftrace/ftrace-direct-multi-modify.c | 37 +++++++++++++++++++++
> >  samples/ftrace/ftrace-direct-multi.c        | 22 ++++++++++++
> >  samples/ftrace/ftrace-direct-too.c          | 26 +++++++++++++++
> >  samples/ftrace/ftrace-direct.c              | 22 ++++++++++++
> >  5 files changed, 140 insertions(+)
> >
> > diff --git a/samples/ftrace/ftrace-direct-modify.c b/samples/ftrace/ftr=
ace-direct-modify.c
> > index de5a0f67f320..be7bf472c3c7 100644
> > --- a/samples/ftrace/ftrace-direct-modify.c
> > +++ b/samples/ftrace/ftrace-direct-modify.c
> > @@ -23,6 +23,39 @@ extern void my_tramp2(void *);
> >
> >  static unsigned long my_ip =3D (unsigned long)schedule;
> >
> > +#ifdef CONFIG_RISCV
> > +
> > +asm (" .pushsection    .text, \"ax\", @progbits\n"
> > +"      .type           my_tramp1, @function\n"
> > +"      .globl          my_tramp1\n"
> > +"   my_tramp1:\n"
> > +"      addi sp,sp,-16\n"
> > +"      sd   t0,0(sp)\n"
> > +"      sd   ra,8(sp)\n"
> > +"      call my_direct_func1\n"
> > +"      ld   t0,0(sp)\n"
> > +"      ld   ra,8(sp)\n"
> > +"      addi sp,sp,16\n"
> > +"      jr t0\n"
> > +"      .size           my_tramp1, .-my_tramp1\n"
> > +
> > +"      .type           my_tramp2, @function\n"
> > +"      .globl          my_tramp2\n"
> > +"   my_tramp2:\n"
> > +"      addi sp,sp,-16\n"
> > +"      sd   t0,0(sp)\n"
> > +"      sd   ra,8(sp)\n"
> > +"      call my_direct_func2\n"
> > +"      ld   t0,0(sp)\n"
> > +"      ld   ra,8(sp)\n"
> > +"      addi sp,sp,16\n"
> > +"      jr t0\n"
> > +"      .size           my_tramp2, .-my_tramp2\n"
> > +"      .popsection\n"
> > +);
> > +
> > +#endif /* CONFIG_RISCV */
> > +
> >  #ifdef CONFIG_X86_64
> >
> >  #include <asm/ibt.h>
> > diff --git a/samples/ftrace/ftrace-direct-multi-modify.c b/samples/ftra=
ce/ftrace-direct-multi-modify.c
> > index d52370cad0b6..10884bf418f7 100644
> > --- a/samples/ftrace/ftrace-direct-multi-modify.c
> > +++ b/samples/ftrace/ftrace-direct-multi-modify.c
> > @@ -21,6 +21,43 @@ void my_direct_func2(unsigned long ip)
> >  extern void my_tramp1(void *);
> >  extern void my_tramp2(void *);
> >
> > +#ifdef CONFIG_RISCV
> > +
> > +asm (" .pushsection    .text, \"ax\", @progbits\n"
> > +"      .type           my_tramp1, @function\n"
> > +"      .globl          my_tramp1\n"
> > +"   my_tramp1:\n"
> > +"       addi sp,sp,-24\n"
> > +"       sd   a0,0(sp)\n"
> > +"       sd   t0,8(sp)\n"
> > +"       sd   ra,16(sp)\n"
> > +"       call my_direct_func1\n"
> > +"       ld   a0,0(sp)\n"
> > +"       ld   t0,8(sp)\n"
> > +"       ld   ra,16(sp)\n"
> > +"       addi sp,sp,24\n"
> > +"      jr t0\n"
> > +"      .size           my_tramp1, .-my_tramp1\n"
> > +
> > +"      .type           my_tramp2, @function\n"
> > +"      .globl          my_tramp2\n"
> > +"   my_tramp2:\n"
> > +"       addi sp,sp,-24\n"
> > +"       sd   a0,0(sp)\n"
> > +"       sd   t0,8(sp)\n"
> > +"       sd   ra,16(sp)\n"
> > +"       call my_direct_func2\n"
> > +"       ld   a0,0(sp)\n"
> > +"       ld   t0,8(sp)\n"
> > +"       ld   ra,16(sp)\n"
> > +"       addi sp,sp,24\n"
> > +"      jr t0\n"
> > +"      .size           my_tramp2, .-my_tramp2\n"
> > +"      .popsection\n"
> > +);
> > +
> > +#endif /* CONFIG_RISCV */
> > +
> >  #ifdef CONFIG_X86_64
> >
> >  #include <asm/ibt.h>
> > diff --git a/samples/ftrace/ftrace-direct-multi.c b/samples/ftrace/ftra=
ce-direct-multi.c
> > index ec1088922517..a35bf43bf6d7 100644
> > --- a/samples/ftrace/ftrace-direct-multi.c
> > +++ b/samples/ftrace/ftrace-direct-multi.c
> > @@ -16,6 +16,28 @@ void my_direct_func(unsigned long ip)
> >
> >  extern void my_tramp(void *);
> >
> > +#ifdef CONFIG_RISCV
> > +
> > +asm ("       .pushsection    .text, \"ax\", @progbits\n"
> > +"       .type           my_tramp, @function\n"
> > +"       .globl          my_tramp\n"
> > +"   my_tramp:\n"
> > +"       addi sp,sp,-24\n"
> > +"       sd   a0,0(sp)\n"
> > +"       sd   t0,8(sp)\n"
> > +"       sd   ra,16(sp)\n"
> > +"       call my_direct_func\n"
> > +"       ld   a0,0(sp)\n"
> > +"       ld   t0,8(sp)\n"
> > +"       ld   ra,16(sp)\n"
> > +"       addi sp,sp,24\n"
> > +"       jr t0\n"
> > +"       .size           my_tramp, .-my_tramp\n"
> > +"       .popsection\n"
> > +);
> > +
> > +#endif /* CONFIG_RISCV */
> > +
> >  #ifdef CONFIG_X86_64
> >
> >  #include <asm/ibt.h>
> > diff --git a/samples/ftrace/ftrace-direct-too.c b/samples/ftrace/ftrace=
-direct-too.c
> > index e13fb59a2b47..3b62e33c2e6d 100644
> > --- a/samples/ftrace/ftrace-direct-too.c
> > +++ b/samples/ftrace/ftrace-direct-too.c
> > @@ -18,6 +18,32 @@ void my_direct_func(struct vm_area_struct *vma,
> >
> >  extern void my_tramp(void *);
> >
> > +#ifdef CONFIG_RISCV
> > +
> > +asm ("       .pushsection    .text, \"ax\", @progbits\n"
> > +"       .type           my_tramp, @function\n"
> > +"       .globl          my_tramp\n"
> > +"   my_tramp:\n"
> > +"       addi sp,sp,-40\n"
> > +"       sd   a0,0(sp)\n"
> > +"       sd   a1,8(sp)\n"
> > +"       sd   a2,16(sp)\n"
> > +"       sd   t0,24(sp)\n"
> > +"       sd   ra,32(sp)\n"
> > +"       call my_direct_func\n"
> > +"       ld   a0,0(sp)\n"
> > +"       ld   a1,8(sp)\n"
> > +"       ld   a2,16(sp)\n"
> > +"       ld   t0,24(sp)\n"
> > +"       ld   ra,32(sp)\n"
> > +"       addi sp,sp,40\n"
> > +"       jr t0\n"
> > +"       .size           my_tramp, .-my_tramp\n"
> > +"       .popsection\n"
> > +);
> > +
> > +#endif /* CONFIG_RISCV */
> > +
> >  #ifdef CONFIG_X86_64
> >
> >  #include <asm/ibt.h>
> > diff --git a/samples/ftrace/ftrace-direct.c b/samples/ftrace/ftrace-dir=
ect.c
> > index 1f769d0db20f..2cfe5a7d2d70 100644
> > --- a/samples/ftrace/ftrace-direct.c
> > +++ b/samples/ftrace/ftrace-direct.c
> > @@ -15,6 +15,28 @@ void my_direct_func(struct task_struct *p)
> >
> >  extern void my_tramp(void *);
> >
> > +#ifdef CONFIG_RISCV
> > +
> > +asm ("       .pushsection    .text, \"ax\", @progbits\n"
> > +"       .type           my_tramp, @function\n"
> > +"       .globl          my_tramp\n"
> > +"   my_tramp:\n"
> > +"       addi sp,sp,-24\n"
> > +"       sd   a0,0(sp)\n"
> > +"       sd   t0,8(sp)\n"
> > +"       sd   ra,16(sp)\n"
> > +"       call my_direct_func\n"
> > +"       ld   a0,0(sp)\n"
> > +"       ld   t0,8(sp)\n"
> > +"       ld   ra,16(sp)\n"
> > +"       addi sp,sp,24\n"
> > +"       jr t0\n"
> > +"       .size           my_tramp, .-my_tramp\n"
> > +"       .popsection\n"
> > +);
> > +
> > +#endif /* CONFIG_RISCV */
> > +
> >  #ifdef CONFIG_X86_64
> >
> >  #include <asm/ibt.h>
> > --
> > 2.36.1
> >
>
>
> --
> Thanks,
> Song



--=20
Thanks,
Song
