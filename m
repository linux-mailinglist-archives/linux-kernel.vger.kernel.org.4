Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4906D70CD74
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 00:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234467AbjEVWED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 18:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbjEVWEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 18:04:01 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1159010D;
        Mon, 22 May 2023 15:03:56 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1ae3fe67980so63526315ad.3;
        Mon, 22 May 2023 15:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684793035; x=1687385035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mpHmxjgmV0Vk1MhcahhVozYr+mz8Dg9yDUvR4PtiQhM=;
        b=GpYVgcFTfPVtaDrcrVmg9epAe2ATreL0f7OffrsFLLljS11WZpR3ICOlWpPtRNiI12
         n1PuowWitFYDZEPLcwcZgpC1wkB9wNFPO+NlzjSV73Uwt02P+p5bVvYeO7cyMSYl+coN
         X2zmfqqU8J33qx4pesG5cQ9vOfo2lk786sKgFrVsiH8lg1p6pqkbAwtgyPTj/fMAyB0+
         uYr3r+ML32/oDB9jIMDZnGDNy1pwdfyR5YvSR3XGOX48Ve92+vz+YBfYfVPyKKniE4x5
         dY5wcaTJdpEjbMSxIzIdhxIfYYtY74cg83Hl8my85Ta2/F0E3EXTIgJNyOX/D2OU50qB
         Q20g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684793035; x=1687385035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mpHmxjgmV0Vk1MhcahhVozYr+mz8Dg9yDUvR4PtiQhM=;
        b=XT+1DoIKzbvfVlNe+dpK568NgZmVGZnhdtjNcUAEUK4sxwZ8VbTJHCwsHEgEV5mdhx
         6pVAuU5cmw/lwrg+ek7kaExA/RSGPFe2Spfqv1901P9pvO75DBwPcNR/ZkCHb6GR4auT
         10Q4W7ymh1ZcCNhH1WPjVZLHPYu+hXC19uzV2pKMYA8hHyyF6QsropuJbrKdxGdr61CI
         BkFPJj35Gzr1wwbuihSo+mC+HQ1gChfze6jd6a0oBRCLtIhBDCBrayCG4Tn20k1eGtDM
         TBJvRd3Kb1LhsXFzBIGSXEx5DP/opj0KQ/WhZH3LFIV/X5cIgUbjTlhfmEIjGKCDdtH/
         PGkQ==
X-Gm-Message-State: AC+VfDwMFcJJPOjuLTnj+cMBGuCl0tbx/SKDqAX7HztBVbLLjyjwpn7z
        WypaHuoPNUM5fK0WNyEM6UnRATnzYxn9VfZJxB2g0G6d+w4=
X-Google-Smtp-Source: ACHHUZ6MkS+pfCyF5lozLz9Yvb+d++T4r8l09Q4Y7Fd5NYA3FPe8potDPNRXMU3ShEv+EbEXothFGSAtXAFbZggVYOI=
X-Received: by 2002:a17:903:2343:b0:1ab:109e:a553 with SMTP id
 c3-20020a170903234300b001ab109ea553mr15447275plh.62.1684793035429; Mon, 22
 May 2023 15:03:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230519164753.72065-1-jiaxun.yang@flygoat.com>
 <20230519164753.72065-2-jiaxun.yang@flygoat.com> <CAOiHx==iku+duvBnAfu_3AXgNmY9aK+uO+t9Enzdf6qQN5m+iw@mail.gmail.com>
 <2CC0C4B4-78C4-4D93-828C-318DC1CAD479@flygoat.com>
In-Reply-To: <2CC0C4B4-78C4-4D93-828C-318DC1CAD479@flygoat.com>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Tue, 23 May 2023 00:03:43 +0200
Message-ID: <CAOiHx=mue3GPncsCH-ndyDy_+X3R5AMRE6VBKztHF=RkHBD7SQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] MIPS: Introduce WAR_4KC_LLSC config option
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 May 2023 at 22:38, Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>
>
>
> > 2023=E5=B9=B45=E6=9C=8822=E6=97=A5 19:40=EF=BC=8CJonas Gorski <jonas.go=
rski@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
> >
> > Hi,
> >
> > On Fri, 19 May 2023 at 18:49, Jiaxun Yang <jiaxun.yang@flygoat.com> wro=
te:
> >>
> >> WAR_4KC_LLSC is used to control workaround of 4KC LLSC issue
> >> that affects 4Kc up to version 0.9.
> >>
> >> Early ath25 chips are known to be affected.
> >>
> >> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> >> ---
> >> arch/mips/Kconfig                                        | 6 ++++++
> >> arch/mips/include/asm/cpu.h                              | 1 +
> >> arch/mips/include/asm/mach-ath25/cpu-feature-overrides.h | 2 +-
> >> arch/mips/kernel/cpu-probe.c                             | 7 +++++++
> >> 4 files changed, 15 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> >> index 30e90a2d53f4..354d033364ad 100644
> >> --- a/arch/mips/Kconfig
> >> +++ b/arch/mips/Kconfig
> >> @@ -230,6 +230,7 @@ config ATH25
> >>        select SYS_SUPPORTS_BIG_ENDIAN
> >>        select SYS_SUPPORTS_32BIT_KERNEL
> >>        select SYS_HAS_EARLY_PRINTK
> >> +       select WAR_4KC_LLSC if !SOC_AR5312
> >
> > Shouldn't this be "if SOC_AR5312"?
>
> Ah sorry, I misread the original code.
>
> >
> > Though since you are adding runtime detection/correction below, I
> > wonder if this would be really needed as an extra symbol, and rather
> > use the later introduced (CPU_MAY_HAVE_LLSC) directly.
>
> I bet it=E2=80=99s better to have a symbol just for tracking errata. So w=
e can easily know
> if SoC is affected by a errata and have some extra documentation.
>
> >
> > Or rather have select "CPU_HAS_LLSC if !SOC_AR5312" in that case.
> >
> >>        help
> >>          Support for Atheros AR231x and Atheros AR531x based boards
> >>
> >> @@ -2544,6 +2545,11 @@ config WAR_ICACHE_REFILLS
> >> config WAR_R10000_LLSC
> >>        bool
> >>
> >> +# On 4Kc up to version 0.9 (PRID_REV < 1) there is a bug that may cau=
se llsc
> >> +# sequences to deadlock.
> >> +config WAR_4KC_LLSC
> >> +       bool
> >> +
> >> # 34K core erratum: "Problems Executing the TLBR Instruction"
> >> config WAR_MIPS34K_MISSED_ITLB
> >>        bool
> >> diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
> >> index ecb9854cb432..84bb1931a8b4 100644
> >> --- a/arch/mips/include/asm/cpu.h
> >> +++ b/arch/mips/include/asm/cpu.h
> >> @@ -247,6 +247,7 @@
> >> #define PRID_REV_VR4122                        0x0070
> >> #define PRID_REV_VR4181A               0x0070  /* Same as VR4122 */
> >> #define PRID_REV_VR4130                        0x0080
> >> +#define PRID_REV_4KC_V1_0              0x0001
> >> #define PRID_REV_34K_V1_0_2            0x0022
> >> #define PRID_REV_LOONGSON1B            0x0020
> >> #define PRID_REV_LOONGSON1C            0x0020  /* Same as Loongson-1B =
*/
> >> diff --git a/arch/mips/include/asm/mach-ath25/cpu-feature-overrides.h =
b/arch/mips/include/asm/mach-ath25/cpu-feature-overrides.h
> >> index ec3604c44ef2..5df292b1ff04 100644
> >> --- a/arch/mips/include/asm/mach-ath25/cpu-feature-overrides.h
> >> +++ b/arch/mips/include/asm/mach-ath25/cpu-feature-overrides.h
> >> @@ -24,7 +24,7 @@
> >> #define cpu_has_counter                        1
> >> #define cpu_has_ejtag                  1
> >>
> >> -#if !defined(CONFIG_SOC_AR5312)
> >> +#if !defined(WAR_4KC_LLSC)
> >> #  define cpu_has_llsc                 1
> >
> > since the #else path defines cpu_has_llsc as 0, it means that kernels
> > targeting both SoCs would force llsc to be unavailable (not introduced
> > by you).
>
> I=E2=80=99m a little bit confused.
> The logic seems very clear to me: If a SoC is not affected by WAR_4KC_LLS=
C,
> then wire  cpu_has_llsc to 1, else wire it to 0.

ATH25 allows you building for multiple SoCs at the same time, and if
you do so, you don't know in advance on which SoC you boot. So you
need to have third path here where cpu_has_llsc isn't wired to
anything.

This is wrong in the current code already, so should be fixed there.

>
> It matches my intention.
>
> >
> > So this probably should be rather this:
> >
> > #if !defined(CONFIG_SOC_AR5312)
> > #define cpu_has_llsc 1
> > #else if !defined(CONFIG_SOC_AR5312)
> > #define cpu_has_llsc 0
> > #endif
>
> The condition on if leg seems same to the else leg, I=E2=80=99m not sure =
if it can ever work.

Sorry, I typo'd. I wanted to write

#if !defined(CONFIG_SOC_AR5312)
#define cpu_has_llsc 1
#else if !defined(CONFIG_SOC_AR2315)
#define cpu_has_llsc 0
(#else /* don't define it */)
#endif

Only SOC_AR2315 selected =3D> cpu_has_llsc =3D 1
Only SOC_AR5312 selected =3D> cpu_has_llsc =3D 0
both selected =3D> cpu_has_llsc will need to be determined at runtime
(don't set it to anything)

>
> >
> > (so if only one is enabled, set it accordingly, else let runtime
> > detection handle it).
> >
> >> #else
> >> /*
> >> diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe=
.c
> >> index 6d15a398d389..fd452e68cd90 100644
> >> --- a/arch/mips/kernel/cpu-probe.c
> >> +++ b/arch/mips/kernel/cpu-probe.c
> >> @@ -152,6 +152,13 @@ static inline void check_errata(void)
> >>        struct cpuinfo_mips *c =3D &current_cpu_data;
> >>
> >>        switch (current_cpu_type()) {
> >> +       case CPU_4KC:
> >> +               if ((c->processor_id & PRID_REV_MASK) < PRID_REV_4KC_V=
1_0) {
> >> +                       c->options &=3D ~MIPS_CPU_LLSC;
> >> +                       if (!IS_ENABLED(CONFIG_WAR_4K_LLSC))
> >> +                               pr_err("CPU have LLSC errata, please e=
nable CONFIG_WAR_4K_LLSC");
> >> +               }
> >
> > And then you don't need this error message at all, since then
> > cpu_has_llsc is 0 or follows MIPS_CPU_LLSC, unless you disabled
> > support for the relevant SoC, and then you'll have bigger problems
> > anyway.
>
> The problem is as per MIPS the affected IP core was shipped to multiple c=
ustomers
> This error message can cover other SoCs that potentially using this core.

AFAICT the core issue is if the platform hardcodes cpu_has_llsc to 1.

So the error/warning this should be then something like this

 if ((c->processor_id & PRID_REV_MASK) < PRID_REV_4KC_V1_0) {
   c->options &=3D ~MIPS_CPU_LLSC;
   if (cpu_has_llsc) { // <- should now be false, unless the platform
defines it as 1
      pr_err("CPU has LLSC erratum, but cpu_has_llsc is force enabled!\n");
   }

because clearing MIPS_CPU_LLSC does nothing if cpu_has_llsc is
#defined as 1, regardless if it selected WAR_4K_LLSC or not.

(also your error print is missing a \n at the end)

Regards,
Jonas
