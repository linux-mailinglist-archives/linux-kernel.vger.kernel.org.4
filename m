Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B6C6879FB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 11:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbjBBKUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 05:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbjBBKUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 05:20:09 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0731E1F2;
        Thu,  2 Feb 2023 02:20:08 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id b5so1354899plz.5;
        Thu, 02 Feb 2023 02:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WYdPpwB4cqZ09UY9AZTmULgMrRnwA57uYIK5ZvUq9NU=;
        b=mPlOmdm9vhkfzx6sATpU11XjmAB9Jd4VDBNA4NNbhNiSqRoHVs+6tciuiIiI/DDJvF
         MDN1wuxqj5+CCRc95w4jdG1q4cXXOrISMucmzFglKkOICRQDyNplcxpU8uOPpqHCXbnp
         Y5Ad3S3rzZ5pEhOsdk1WJjOQ0GAo3iEDfK98FmljLHXViQ8oIKP3lvJiFk/T5hjC0KgY
         ZyC0NYUcF5bkTiCUWpW3SEsbqcgRP7XRwxygDf4BHyl11HzbHctQGuGkU7iR9qke9zsq
         CtgfjEj6XFVzVyXD1EsDyAr4lR8cq476iFqTIJX++7bVUTNvJ0IJXoF2ckfUylU/OlrI
         KTnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WYdPpwB4cqZ09UY9AZTmULgMrRnwA57uYIK5ZvUq9NU=;
        b=q5bvlO6mwcq1tp99xwPjxkZiWWRD59+0hG6IcfhqKd4X7Nc5B2Ip2ejeG36q5wBjdN
         bJ55ByDBMFE+bN4TPuprnQIaOtXOSDW8UB31ROfSrUz3wtw1jwlvZpnsVCyCSZshbHzR
         Wx6amr1jwCaRWC2lQSvb1rtOtK4szg5Nf9WmQXmpikN+LgA6wi18ejwKw4ClFD523M2z
         EkQ5DBx9pFcC7oxI7sckae/7oWn/4mh0p69s/syKUWhrpHTgovRKBe01pcA+vVZFvzbc
         jx6G62Xxy0Hxjf1SOFHrJ9IhPVgiCIvED62198ksgunMc/KqlDC5UoPBEiyU4mvb1zjG
         ShlA==
X-Gm-Message-State: AO0yUKVPG2aWBtfRDRCtHYLbRXu67LsoLR947vDQvFlf5R7z/cs+uU6H
        jLo4BYylBootJwQLAVHgV1pTHGl7ZnWmCL3uz7o=
X-Google-Smtp-Source: AK7set+/K0rn/HVvqn2fa9nmIEccZGasOamMEDNIKr0wT4QD6tc6FxdYOIl3uEH/jmSpfYTavUd3q73RPh4Kb8f4ZtU=
X-Received: by 2002:a17:90b:228a:b0:22b:ed00:176a with SMTP id
 kx10-20020a17090b228a00b0022bed00176amr443109pjb.87.1675333207750; Thu, 02
 Feb 2023 02:20:07 -0800 (PST)
MIME-Version: 1.0
References: <20230130085954.647845-1-suagrfillet@gmail.com>
In-Reply-To: <20230130085954.647845-1-suagrfillet@gmail.com>
From:   Song Shuai <suagrfillet@gmail.com>
Date:   Thu, 2 Feb 2023 10:19:46 +0000
Message-ID: <CAAYs2=jq9j9j-Qa+fexfDX_e=pETfL5j1-n4iy5=0CgDKrYukg@mail.gmail.com>
Subject: Re: [PATCH] samples: ftrace: Include the nospec-branch.h only for x86
To:     rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com,
        peterz@infradead.org, jpoimboe@kernel.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
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

Ping...

Song Shuai <suagrfillet@gmail.com> =E4=BA=8E2023=E5=B9=B41=E6=9C=8830=E6=97=
=A5=E5=91=A8=E4=B8=80 09:00=E5=86=99=E9=81=93=EF=BC=9A
>
> When other architectures without the nospec functionality write their
> direct-call functions of samples/ftrace/*.c, the including of
> asm/nospec-branch.h must be taken care to fix the no header file found
> error in building process.
>
> This commit (ee3e2469b346 "x86/ftrace: Make it call depth tracking aware"=
)
> file-globally includes asm/nospec-branch.h providing CALL_DEPTH_ACCOUNT
> for only x86 direct-call functions.
>
> It seems better to move the including to `#ifdef CONFIG_X86_64`.
>
> Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> ---
>  samples/ftrace/ftrace-direct-modify.c       | 2 +-
>  samples/ftrace/ftrace-direct-multi-modify.c | 2 +-
>  samples/ftrace/ftrace-direct-multi.c        | 2 +-
>  samples/ftrace/ftrace-direct-too.c          | 2 +-
>  samples/ftrace/ftrace-direct.c              | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/samples/ftrace/ftrace-direct-modify.c b/samples/ftrace/ftrac=
e-direct-modify.c
> index de5a0f67f320..d93abbcb1f4c 100644
> --- a/samples/ftrace/ftrace-direct-modify.c
> +++ b/samples/ftrace/ftrace-direct-modify.c
> @@ -3,7 +3,6 @@
>  #include <linux/kthread.h>
>  #include <linux/ftrace.h>
>  #include <asm/asm-offsets.h>
> -#include <asm/nospec-branch.h>
>
>  extern void my_direct_func1(void);
>  extern void my_direct_func2(void);
> @@ -26,6 +25,7 @@ static unsigned long my_ip =3D (unsigned long)schedule;
>  #ifdef CONFIG_X86_64
>
>  #include <asm/ibt.h>
> +#include <asm/nospec-branch.h>
>
>  asm (
>  "      .pushsection    .text, \"ax\", @progbits\n"
> diff --git a/samples/ftrace/ftrace-direct-multi-modify.c b/samples/ftrace=
/ftrace-direct-multi-modify.c
> index a825dbd2c9cf..b58c594efb51 100644
> --- a/samples/ftrace/ftrace-direct-multi-modify.c
> +++ b/samples/ftrace/ftrace-direct-multi-modify.c
> @@ -3,7 +3,6 @@
>  #include <linux/kthread.h>
>  #include <linux/ftrace.h>
>  #include <asm/asm-offsets.h>
> -#include <asm/nospec-branch.h>
>
>  extern void my_direct_func1(unsigned long ip);
>  extern void my_direct_func2(unsigned long ip);
> @@ -24,6 +23,7 @@ extern void my_tramp2(void *);
>  #ifdef CONFIG_X86_64
>
>  #include <asm/ibt.h>
> +#include <asm/nospec-branch.h>
>
>  asm (
>  "      .pushsection    .text, \"ax\", @progbits\n"
> diff --git a/samples/ftrace/ftrace-direct-multi.c b/samples/ftrace/ftrace=
-direct-multi.c
> index d955a2650605..c27cf130c319 100644
> --- a/samples/ftrace/ftrace-direct-multi.c
> +++ b/samples/ftrace/ftrace-direct-multi.c
> @@ -5,7 +5,6 @@
>  #include <linux/ftrace.h>
>  #include <linux/sched/stat.h>
>  #include <asm/asm-offsets.h>
> -#include <asm/nospec-branch.h>
>
>  extern void my_direct_func(unsigned long ip);
>
> @@ -19,6 +18,7 @@ extern void my_tramp(void *);
>  #ifdef CONFIG_X86_64
>
>  #include <asm/ibt.h>
> +#include <asm/nospec-branch.h>
>
>  asm (
>  "      .pushsection    .text, \"ax\", @progbits\n"
> diff --git a/samples/ftrace/ftrace-direct-too.c b/samples/ftrace/ftrace-d=
irect-too.c
> index e13fb59a2b47..8139dce2a31c 100644
> --- a/samples/ftrace/ftrace-direct-too.c
> +++ b/samples/ftrace/ftrace-direct-too.c
> @@ -4,7 +4,6 @@
>  #include <linux/mm.h> /* for handle_mm_fault() */
>  #include <linux/ftrace.h>
>  #include <asm/asm-offsets.h>
> -#include <asm/nospec-branch.h>
>
>  extern void my_direct_func(struct vm_area_struct *vma,
>                            unsigned long address, unsigned int flags);
> @@ -21,6 +20,7 @@ extern void my_tramp(void *);
>  #ifdef CONFIG_X86_64
>
>  #include <asm/ibt.h>
> +#include <asm/nospec-branch.h>
>
>  asm (
>  "      .pushsection    .text, \"ax\", @progbits\n"
> diff --git a/samples/ftrace/ftrace-direct.c b/samples/ftrace/ftrace-direc=
t.c
> index 1f769d0db20f..1d3d307ca33d 100644
> --- a/samples/ftrace/ftrace-direct.c
> +++ b/samples/ftrace/ftrace-direct.c
> @@ -4,7 +4,6 @@
>  #include <linux/sched.h> /* for wake_up_process() */
>  #include <linux/ftrace.h>
>  #include <asm/asm-offsets.h>
> -#include <asm/nospec-branch.h>
>
>  extern void my_direct_func(struct task_struct *p);
>
> @@ -18,6 +17,7 @@ extern void my_tramp(void *);
>  #ifdef CONFIG_X86_64
>
>  #include <asm/ibt.h>
> +#include <asm/nospec-branch.h>
>
>  asm (
>  "      .pushsection    .text, \"ax\", @progbits\n"
> --
> 2.20.1
>


--=20
Thanks,
Song
