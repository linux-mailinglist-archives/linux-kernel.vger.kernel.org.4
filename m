Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631C2665827
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 10:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238694AbjAKJyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 04:54:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238744AbjAKJx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 04:53:27 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBD4DFF
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 01:51:00 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id o1-20020a17090a678100b00219cf69e5f0so19444433pjj.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 01:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PvauAULTGHDDM01t1B6xwNHBXd8Wxx3xbcaI5oFHlbE=;
        b=VqZ4o13kIAtOkmX1LWi45u2QFus5b8RA9oifV5+1v3/hVhAp6geLsKUsJuBoERKoV1
         kLqxN4mzuacBMPbLQz4PnM4A4c/txDyEHSacd2K1GsRFh6Dgg7U7ZuqEAwMf21RGS1lT
         bThlWtsw2wq4Ypw1OR7F+l9q+zd82bjQzEu2ax5h34shCLycu2SeXFo0ew/WfQ3Di94u
         kSP2ehfaeLM1jKz8hedXoElF/JJIpPvs9QL025GOf+SWIiO5bb1JT8bRoN4rN0yNzkJj
         z4qxE473yOBOT9fgJ8+KH5CXjDjKme++pPClZniss1SqgwyfzGlQBD2GM0EEhZKQGqjG
         Aw2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PvauAULTGHDDM01t1B6xwNHBXd8Wxx3xbcaI5oFHlbE=;
        b=becQBDgOqrYHUeU4YLR4bzgRPLTFCJG+A0Ws9sPiWsntRpfju3Kk8W65nJw7lSDvLB
         fCS/6nXpAd1YeHHl1hdZfQQZjz5klCbnU/CIPniOMhyiVll8utUs5HVCWt0ePVE1Blba
         VqIkzrXnd6zJXy2m0SXet40BKkIsJ6XVVqyy3Bu5PT0V0INIx1aPfrgLK0yjKbpgMkKg
         gmmtjJql5emkNbJUG/p61UEP0RzOt/uhD5x2pcJZr6zv/FjOdWH2BKHD5Bcoxf8VeMVR
         2TkezAMQBTTFm7SWeOU0oj0oo5PjlVDSDLy2cI9qg3fSDwS4X6EvpmRI7lCZi6mf2l6u
         Xn3A==
X-Gm-Message-State: AFqh2kqJaMgGrLABtFRMf9D739L14jkigDZxsuPr/hLEZ31VHyM9vnZS
        5dGgWFJQy/ybiHiRuCQSrz//fknpesB7hhLAGgs=
X-Google-Smtp-Source: AMrXdXvavpDaKE90Om52//d2BptEFQSI9XAPIOIIZL0hOwHqLhpmhysA0UaWVZv9PZ9iIdW4eaDoAkI2u5lf/HoXNwQ=
X-Received: by 2002:a17:90b:1c0c:b0:226:6f60:8cf7 with SMTP id
 oc12-20020a17090b1c0c00b002266f608cf7mr3447446pjb.71.1673430659878; Wed, 11
 Jan 2023 01:50:59 -0800 (PST)
MIME-Version: 1.0
References: <20230107133549.4192639-1-guoren@kernel.org> <20230107133549.4192639-8-guoren@kernel.org>
In-Reply-To: <20230107133549.4192639-8-guoren@kernel.org>
From:   Song Shuai <suagrfillet@gmail.com>
Date:   Wed, 11 Jan 2023 09:50:46 +0000
Message-ID: <CAAYs2=h464Fx8ix4f_aJWBfRaz8BipfvxzAZoGDnBQkPrY_nNQ@mail.gmail.com>
Subject: Re: [PATCH -next V6 7/7] samples: ftrace: Add riscv support for SAMPLE_FTRACE_DIRECT[_MULTI]
To:     guoren@kernel.org, e.shatokhin@yadro.com
Cc:     anup@brainfault.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
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

<guoren@kernel.org> =E4=BA=8E2023=E5=B9=B41=E6=9C=887=E6=97=A5=E5=91=A8=E5=
=85=AD 13:36=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Song Shuai <suagrfillet@gmail.com>
>
> select HAVE_SAMPLE_FTRACE_DIRECT and HAVE_SAMPLE_FTRACE_DIRECT_MULTI
> for ARCH_RV64I in arch/riscv/Kconfig. And add riscv asm code for
> the ftrace-direct*.c files in samples/ftrace/.
>
> Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> Tested-by: Guo Ren <guoren@kernel.org>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> ---
Hi,Guo && Evgenii:

As Evgenii comments, this patch has two problems to fix:

1. the modification of Kconfig is missing
So we should add it back

2. the build error resulted by including of nospec-branch.h file
This including is exclusive for x86 architecture, moving it under
x86 #ifdef seems better to fix this error

I fixed them in my GitHub repo, but I can't find a reasonable target
branch in your repo to PR.
So I paste the link of my branch here, you can pick the first 2
commits in the next series.

- samples: ftrace: Add riscv support for SAMPLE_FTRACE_DIRECT[_MULTI]
- samples: ftrace: Include the nospec-branch.h only for x86

Link: https://github.com/sugarfillet/linux/commits/song_ftrace_fix_up_v6

>  samples/ftrace/ftrace-direct-modify.c       | 33 ++++++++++++++++++
>  samples/ftrace/ftrace-direct-multi-modify.c | 37 +++++++++++++++++++++
>  samples/ftrace/ftrace-direct-multi.c        | 22 ++++++++++++
>  samples/ftrace/ftrace-direct-too.c          | 26 +++++++++++++++
>  samples/ftrace/ftrace-direct.c              | 22 ++++++++++++
>  5 files changed, 140 insertions(+)
>
> diff --git a/samples/ftrace/ftrace-direct-modify.c b/samples/ftrace/ftrac=
e-direct-modify.c
> index de5a0f67f320..be7bf472c3c7 100644
> --- a/samples/ftrace/ftrace-direct-modify.c
> +++ b/samples/ftrace/ftrace-direct-modify.c
> @@ -23,6 +23,39 @@ extern void my_tramp2(void *);
>
>  static unsigned long my_ip =3D (unsigned long)schedule;
>
> +#ifdef CONFIG_RISCV
> +
> +asm (" .pushsection    .text, \"ax\", @progbits\n"
> +"      .type           my_tramp1, @function\n"
> +"      .globl          my_tramp1\n"
> +"   my_tramp1:\n"
> +"      addi sp,sp,-16\n"
> +"      sd   t0,0(sp)\n"
> +"      sd   ra,8(sp)\n"
> +"      call my_direct_func1\n"
> +"      ld   t0,0(sp)\n"
> +"      ld   ra,8(sp)\n"
> +"      addi sp,sp,16\n"
> +"      jr t0\n"
> +"      .size           my_tramp1, .-my_tramp1\n"
> +
> +"      .type           my_tramp2, @function\n"
> +"      .globl          my_tramp2\n"
> +"   my_tramp2:\n"
> +"      addi sp,sp,-16\n"
> +"      sd   t0,0(sp)\n"
> +"      sd   ra,8(sp)\n"
> +"      call my_direct_func2\n"
> +"      ld   t0,0(sp)\n"
> +"      ld   ra,8(sp)\n"
> +"      addi sp,sp,16\n"
> +"      jr t0\n"
> +"      .size           my_tramp2, .-my_tramp2\n"
> +"      .popsection\n"
> +);
> +
> +#endif /* CONFIG_RISCV */
> +
>  #ifdef CONFIG_X86_64
>
>  #include <asm/ibt.h>
> diff --git a/samples/ftrace/ftrace-direct-multi-modify.c b/samples/ftrace=
/ftrace-direct-multi-modify.c
> index d52370cad0b6..10884bf418f7 100644
> --- a/samples/ftrace/ftrace-direct-multi-modify.c
> +++ b/samples/ftrace/ftrace-direct-multi-modify.c
> @@ -21,6 +21,43 @@ void my_direct_func2(unsigned long ip)
>  extern void my_tramp1(void *);
>  extern void my_tramp2(void *);
>
> +#ifdef CONFIG_RISCV
> +
> +asm (" .pushsection    .text, \"ax\", @progbits\n"
> +"      .type           my_tramp1, @function\n"
> +"      .globl          my_tramp1\n"
> +"   my_tramp1:\n"
> +"       addi sp,sp,-24\n"
> +"       sd   a0,0(sp)\n"
> +"       sd   t0,8(sp)\n"
> +"       sd   ra,16(sp)\n"
> +"       call my_direct_func1\n"
> +"       ld   a0,0(sp)\n"
> +"       ld   t0,8(sp)\n"
> +"       ld   ra,16(sp)\n"
> +"       addi sp,sp,24\n"
> +"      jr t0\n"
> +"      .size           my_tramp1, .-my_tramp1\n"
> +
> +"      .type           my_tramp2, @function\n"
> +"      .globl          my_tramp2\n"
> +"   my_tramp2:\n"
> +"       addi sp,sp,-24\n"
> +"       sd   a0,0(sp)\n"
> +"       sd   t0,8(sp)\n"
> +"       sd   ra,16(sp)\n"
> +"       call my_direct_func2\n"
> +"       ld   a0,0(sp)\n"
> +"       ld   t0,8(sp)\n"
> +"       ld   ra,16(sp)\n"
> +"       addi sp,sp,24\n"
> +"      jr t0\n"
> +"      .size           my_tramp2, .-my_tramp2\n"
> +"      .popsection\n"
> +);
> +
> +#endif /* CONFIG_RISCV */
> +
>  #ifdef CONFIG_X86_64
>
>  #include <asm/ibt.h>
> diff --git a/samples/ftrace/ftrace-direct-multi.c b/samples/ftrace/ftrace=
-direct-multi.c
> index ec1088922517..a35bf43bf6d7 100644
> --- a/samples/ftrace/ftrace-direct-multi.c
> +++ b/samples/ftrace/ftrace-direct-multi.c
> @@ -16,6 +16,28 @@ void my_direct_func(unsigned long ip)
>
>  extern void my_tramp(void *);
>
> +#ifdef CONFIG_RISCV
> +
> +asm ("       .pushsection    .text, \"ax\", @progbits\n"
> +"       .type           my_tramp, @function\n"
> +"       .globl          my_tramp\n"
> +"   my_tramp:\n"
> +"       addi sp,sp,-24\n"
> +"       sd   a0,0(sp)\n"
> +"       sd   t0,8(sp)\n"
> +"       sd   ra,16(sp)\n"
> +"       call my_direct_func\n"
> +"       ld   a0,0(sp)\n"
> +"       ld   t0,8(sp)\n"
> +"       ld   ra,16(sp)\n"
> +"       addi sp,sp,24\n"
> +"       jr t0\n"
> +"       .size           my_tramp, .-my_tramp\n"
> +"       .popsection\n"
> +);
> +
> +#endif /* CONFIG_RISCV */
> +
>  #ifdef CONFIG_X86_64
>
>  #include <asm/ibt.h>
> diff --git a/samples/ftrace/ftrace-direct-too.c b/samples/ftrace/ftrace-d=
irect-too.c
> index e13fb59a2b47..3b62e33c2e6d 100644
> --- a/samples/ftrace/ftrace-direct-too.c
> +++ b/samples/ftrace/ftrace-direct-too.c
> @@ -18,6 +18,32 @@ void my_direct_func(struct vm_area_struct *vma,
>
>  extern void my_tramp(void *);
>
> +#ifdef CONFIG_RISCV
> +
> +asm ("       .pushsection    .text, \"ax\", @progbits\n"
> +"       .type           my_tramp, @function\n"
> +"       .globl          my_tramp\n"
> +"   my_tramp:\n"
> +"       addi sp,sp,-40\n"
> +"       sd   a0,0(sp)\n"
> +"       sd   a1,8(sp)\n"
> +"       sd   a2,16(sp)\n"
> +"       sd   t0,24(sp)\n"
> +"       sd   ra,32(sp)\n"
> +"       call my_direct_func\n"
> +"       ld   a0,0(sp)\n"
> +"       ld   a1,8(sp)\n"
> +"       ld   a2,16(sp)\n"
> +"       ld   t0,24(sp)\n"
> +"       ld   ra,32(sp)\n"
> +"       addi sp,sp,40\n"
> +"       jr t0\n"
> +"       .size           my_tramp, .-my_tramp\n"
> +"       .popsection\n"
> +);
> +
> +#endif /* CONFIG_RISCV */
> +
>  #ifdef CONFIG_X86_64
>
>  #include <asm/ibt.h>
> diff --git a/samples/ftrace/ftrace-direct.c b/samples/ftrace/ftrace-direc=
t.c
> index 1f769d0db20f..2cfe5a7d2d70 100644
> --- a/samples/ftrace/ftrace-direct.c
> +++ b/samples/ftrace/ftrace-direct.c
> @@ -15,6 +15,28 @@ void my_direct_func(struct task_struct *p)
>
>  extern void my_tramp(void *);
>
> +#ifdef CONFIG_RISCV
> +
> +asm ("       .pushsection    .text, \"ax\", @progbits\n"
> +"       .type           my_tramp, @function\n"
> +"       .globl          my_tramp\n"
> +"   my_tramp:\n"
> +"       addi sp,sp,-24\n"
> +"       sd   a0,0(sp)\n"
> +"       sd   t0,8(sp)\n"
> +"       sd   ra,16(sp)\n"
> +"       call my_direct_func\n"
> +"       ld   a0,0(sp)\n"
> +"       ld   t0,8(sp)\n"
> +"       ld   ra,16(sp)\n"
> +"       addi sp,sp,24\n"
> +"       jr t0\n"
> +"       .size           my_tramp, .-my_tramp\n"
> +"       .popsection\n"
> +);
> +
> +#endif /* CONFIG_RISCV */
> +
>  #ifdef CONFIG_X86_64
>
>  #include <asm/ibt.h>
> --
> 2.36.1
>


--=20
Thanks,
Song
