Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5738063C33C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 15:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235792AbiK2O5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 09:57:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235813AbiK2O4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 09:56:50 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1983426C2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 06:56:49 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-3b10392c064so141474557b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 06:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dlBI7JXO/yZNTOf9+g6hWuYtBT4RvD857Ua81F7bQPo=;
        b=m+Sacno7nSjUYECPh8npXs7b5BIoQB+c12GnRRpcTfnCOmS/lNEczTpqhhPq7ZySaN
         CQtRZSQ0ga52UQBrsu2d/DGO8TX3ihVfj4FFeQjcuU8KZ7uUxpv1P8Cg12cUYfmNBSwH
         xoLLpJHGkbAaLheunR7MouJr56E0CTtkxIXwca5rbQXXt/B0vUcynxsWBfBsPIJzWIL8
         KH77cxFb/9kyENq8rG6vsDf7y3iwMFwvWk9CigHEV3+bf++eQGJ9y9uPIQah/ot+uahy
         oysys0csx3jn7FIBIKXu5PDXd6I31hcNpHIvM7AOiSXvwoCvdh9+iY7+5Gu6cIskYK5H
         qV8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dlBI7JXO/yZNTOf9+g6hWuYtBT4RvD857Ua81F7bQPo=;
        b=bxwaNyJisxdMtRoqqZSezddinJMPgEozJO/Y8XyR7FpfjXgtHJqRJkvBLbx05/j67G
         8L6eZTNL97bonEqpgum9YUVe9U6ix54Gf2fW7S29rd1GGddhgcmYVDOWrge0zTcTrcqp
         oYdErIM1i/Xq0u78dNx6W0ENiDINWlJI5hZr+kYz2AEEqFzkqVN/46oY8VA7AHgVobGs
         5NEWRx/UDPm+1YP76JV6AKLuf4YcxcMkvwKyZNaWeu33HTTJTVKi/uAxCKDz1yjke1Ef
         7izEWujII6l8Yr2/s9loHl39a+tTR2QtKoiwmFMTpyWk3qlIr2JHuwQujVri9lKmfoQl
         Ldjw==
X-Gm-Message-State: ANoB5pmAYaXGJEL4avSNC96PMC+ysS9WJa9WkNSofBjZJG1xVzZf7KfB
        m2whJ9VvdERilnktnLbZhUNY3K96XuHtnOlM30c=
X-Google-Smtp-Source: AA0mqf6x6r20d3z+8LG0xfEYl/Nw5aJtldlgFygQAwGzqyc/kJaWhWO/grx+xHtGp2kX5cYqdAZm7zH7qCSZdvHydZ8=
X-Received: by 2002:a81:8684:0:b0:360:7f0a:1620 with SMTP id
 w126-20020a818684000000b003607f0a1620mr34800694ywf.192.1669733808207; Tue, 29
 Nov 2022 06:56:48 -0800 (PST)
MIME-Version: 1.0
References: <20221104124546.196077-1-ubizjak@gmail.com> <Y4U0GwlLgAuxu3WF@zn.tnic>
 <CAFULd4Yjp+sNqZrt9kq2orodNckQOWAGi84ZZeXRFPLyE65HPQ@mail.gmail.com>
 <Y4XDVbuYtFUYCrur@zn.tnic> <CAFULd4Yv9ZYu_mWwFBGheJ7_XsP6Ok1uCCPDr-ChDK4yzOK3qA@mail.gmail.com>
 <Y4YbQHKbl1BVZKMX@zn.tnic>
In-Reply-To: <Y4YbQHKbl1BVZKMX@zn.tnic>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Tue, 29 Nov 2022 15:56:37 +0100
Message-ID: <CAFULd4bkvBAELPLALrKFV=wX4pNzWPwCg9dQ_C_WJZ2H1cbPMw@mail.gmail.com>
Subject: Re: [PATCH] x86/boot: Remove x86_32 PIC using ebx workaround
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 3:46 PM Borislav Petkov <bp@alien8.de> wrote:
>
> Ok,
>
> I tried to summarize what we talked on the thread and have the whole
> deal explained in greater detail.
>
> Holler if something's missing:
>
> ---
> From: Uros Bizjak <ubizjak@gmail.com>
> Date: Fri, 4 Nov 2022 13:45:46 +0100
> Subject: [PATCH] x86/boot: Remove x86_32 PIC using %ebx workaround
>
> The currently supported minimum gcc version is 5.1. Before that, the
> PIC register, when generating Position Independent Code, was considered
> "fixed" in the sense that it wasn't in the set of registers available to
> the compiler's register allocator. Which, on x86-32, is already a very
> small set.
>
> What is more, the register allocator was unable to satisfy extended asm
> "=b" constraints. (Yes, PIC code uses %ebx on 32-bit as the base reg.)
>
> With gcc5:

Please say gcc 5.1 here.

Otherwise a really comprehensive and detailed explanation of the issue!

Uros.

>
> "Reuse of the PIC hard register, instead of using a fixed register,
> was implemented on x86/x86-64 targets. This improves generated PIC
> code performance as more hard registers can be used. Shared libraries
> can significantly benefit from this optimization. Currently it is
> switched on only for x86/x86-64 targets. As RA infrastructure is already
> implemented for PIC register reuse, other targets might follow this in
> the future."
>
>   (from: https://gcc.gnu.org/gcc-5/changes.html)
>
> which basically means that the register allocator has a higher degree
> of freedom when handling %ebx, including reloading it with the correct
> value before a PIC access.
>
> Furthermore:
>
>   arch/x86/Makefile:
>           # Never want PIC in a 32-bit kernel, prevent breakage with GCC built
>           # with nonstandard options
>           KBUILD_CFLAGS += -fno-pic
>
>   $ gcc -Wp,-MMD,arch/x86/boot/.cpuflags.o.d ... -fno-pic ... -D__KBUILD_MODNAME=kmod_cpuflags -c -o arch/x86/boot/cpuflags.o arch/x86/boot/cpuflags.c
>
> so the 32-bit workaround in cpuid_count() is fixing exactly nothing
> because 32-bit configs don't even allow PIC builds.
>
> As to 64-bit builds: they're done using -mcmodel=kernel which produces
> RIP-relative addressing for PIC builds and thus does not apply here
> either.
>
> So get rid of the thing and make cpuid_count() nice and simple.
>
> There should be no functional changes resulting from this.
>
>   [ bp: Expand commit message. ]
>
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Link: https://lore.kernel.org/r/20221104124546.196077-1-ubizjak@gmail.com
> ---
>  arch/x86/boot/cpuflags.c | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
>
> diff --git a/arch/x86/boot/cpuflags.c b/arch/x86/boot/cpuflags.c
> index a83d67ec627d..d75237ba7ce9 100644
> --- a/arch/x86/boot/cpuflags.c
> +++ b/arch/x86/boot/cpuflags.c
> @@ -64,20 +64,11 @@ int has_eflag(unsigned long mask)
>         return !!((f0^f1) & mask);
>  }
>
> -/* Handle x86_32 PIC using ebx. */
> -#if defined(__i386__) && defined(__PIC__)
> -# define EBX_REG "=r"
> -#else
> -# define EBX_REG "=b"
> -#endif
> -
>  void cpuid_count(u32 id, u32 count, u32 *a, u32 *b, u32 *c, u32 *d)
>  {
> -       asm volatile(".ifnc %%ebx,%3 ; movl  %%ebx,%3 ; .endif  \n\t"
> -                    "cpuid                                     \n\t"
> -                    ".ifnc %%ebx,%3 ; xchgl %%ebx,%3 ; .endif  \n\t"
> -                   : "=a" (*a), "=c" (*c), "=d" (*d), EBX_REG (*b)
> -                   : "a" (id), "c" (count)
> +       asm volatile("cpuid"
> +                    : "=a" (*a), "=b" (*b), "=c" (*c), "=d" (*d)
> +                    : "0" (id), "2" (count)
>         );
>  }
>
> --
> 2.35.1
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
