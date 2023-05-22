Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9176E70CB53
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 22:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234553AbjEVUil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 16:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234543AbjEVUik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 16:38:40 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DCECA;
        Mon, 22 May 2023 13:38:18 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 89A6A5C00CB;
        Mon, 22 May 2023 16:38:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 22 May 2023 16:38:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1684787896; x=1684874296; bh=Z04sWrILKepz2jskPeHWi28H8+f7r6q83E+
        7n4rVA1U=; b=r8QoZ8GkpCGPzQOiaN0oVpMWufriYLpYhmf+GFlUl0Ftril+G5n
        tdQZm3LrLc4UbnTjGNyEgZK2XFkQL60lHZnAHfjK/sFGACUpbtzPML/EZuxE5a7J
        ZoO6uYnAiN5dQRSLox48bzwyPmPAc6IuC3fAFfTeb6T+yQnKUCR82W0C5V3xzktN
        cWB078wk7eJOKPLoYvVGm2Wl1S3eujz/feNKxoHV1dgMb+Jb1xJ0Df525Z2PhaZE
        6/e0W4AhdiT8pWZ4IfS75ufIyoVqRaq8h1Q6AI8mfTpxHoWiJDAKSkY+G17ojoNR
        aNrHnnjYDZSyEYKCyeNzsJTnU92aD7mvDlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1684787896; x=1684874296; bh=Z04sWrILKepz2jskPeHWi28H8+f7r6q83E+
        7n4rVA1U=; b=GQepVgHG1mNJtXdVvGUbo7MD+oBoZ9213Eh3PXU0ZLT3W2Sm2yO
        Nh1s1zFq3WhPkRjNB2KIYlYK5yGLZz2uuyCotqUuG8/yxgSzoT93W7yh7wb0QGKW
        Anga/Zoa8+KlK1YjHc33OEXCWqHKXkzGPljKVbIsJVFGaeah9sks9dvOh6ssuNKQ
        kye2IiIao2dl5jREnUsoX1BbBLbgvYFb+MPqGfGSj1BZNq8GDCGfIsUQ/4yUJgF7
        hNURLf5AU7z2nrd9aXQDKWKqODTYt5PvVP/9zLwut8t8+hi8nSymkGwPpb0iKe+Z
        1bDmauQHf2W+VIFGkzILQQxQtyIjGPtqSxw==
X-ME-Sender: <xms:uNJrZHb3ILeEM-0q_2i8rpSqz_OzFPtH0lZ512rA8asS3mKfe_Rn2A>
    <xme:uNJrZGZ9G1SiyEKCV3NTTigddLfqaW1luPz6CUz3Ayy-7geLr_8ehfS7pHUivkuCN
    bgVMdCQBaPBDY8KT7k>
X-ME-Received: <xmr:uNJrZJ9gxofwwr70kpykHsNYMiUOUuxPDV-IS3nlof2O7CLsbBhbnI1mFDztaWP9z7LT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejuddgudefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpegtggfuhfgjffevgffkfhfvofesthhqmhdthhdtjeenucfhrhhomheplfhi
    rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
    enucggtffrrghtthgvrhhnpedutdejffetteefkeejieehfeeuieeguedtveeijeeviefh
    ffelvdfgudeihfdvtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:uNJrZNppvUMYSkXY3VKiCF2UTVRwMdhZMcvrb2sLsgdZ8nhCrwREGQ>
    <xmx:uNJrZCqy--GtsuZyvxmVnbKaXp3P2lCBaGYMv9xCRwn25Cpf5pnyaA>
    <xmx:uNJrZDQ024UadKf5zcBVQBw-ttLZD9uQlvU4oEgAgSjqt-WEBgmHvg>
    <xmx:uNJrZJ0a9web8LwN7U7atHEegzPnerYXbh4ezxBnjQGoUJ3gZN2o3Q>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 May 2023 16:38:15 -0400 (EDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: [PATCH 1/3] MIPS: Introduce WAR_4KC_LLSC config option
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <CAOiHx==iku+duvBnAfu_3AXgNmY9aK+uO+t9Enzdf6qQN5m+iw@mail.gmail.com>
Date:   Mon, 22 May 2023 21:38:04 +0100
Cc:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2CC0C4B4-78C4-4D93-828C-318DC1CAD479@flygoat.com>
References: <20230519164753.72065-1-jiaxun.yang@flygoat.com>
 <20230519164753.72065-2-jiaxun.yang@flygoat.com>
 <CAOiHx==iku+duvBnAfu_3AXgNmY9aK+uO+t9Enzdf6qQN5m+iw@mail.gmail.com>
To:     Jonas Gorski <jonas.gorski@gmail.com>
X-Mailer: Apple Mail (2.3731.500.231)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> 2023=E5=B9=B45=E6=9C=8822=E6=97=A5 19:40=EF=BC=8CJonas Gorski =
<jonas.gorski@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Hi,
>=20
> On Fri, 19 May 2023 at 18:49, Jiaxun Yang <jiaxun.yang@flygoat.com> =
wrote:
>>=20
>> WAR_4KC_LLSC is used to control workaround of 4KC LLSC issue
>> that affects 4Kc up to version 0.9.
>>=20
>> Early ath25 chips are known to be affected.
>>=20
>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> ---
>> arch/mips/Kconfig                                        | 6 ++++++
>> arch/mips/include/asm/cpu.h                              | 1 +
>> arch/mips/include/asm/mach-ath25/cpu-feature-overrides.h | 2 +-
>> arch/mips/kernel/cpu-probe.c                             | 7 +++++++
>> 4 files changed, 15 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
>> index 30e90a2d53f4..354d033364ad 100644
>> --- a/arch/mips/Kconfig
>> +++ b/arch/mips/Kconfig
>> @@ -230,6 +230,7 @@ config ATH25
>>        select SYS_SUPPORTS_BIG_ENDIAN
>>        select SYS_SUPPORTS_32BIT_KERNEL
>>        select SYS_HAS_EARLY_PRINTK
>> +       select WAR_4KC_LLSC if !SOC_AR5312
>=20
> Shouldn't this be "if SOC_AR5312"?

Ah sorry, I misread the original code.

>=20
> Though since you are adding runtime detection/correction below, I
> wonder if this would be really needed as an extra symbol, and rather
> use the later introduced (CPU_MAY_HAVE_LLSC) directly.

I bet it=E2=80=99s better to have a symbol just for tracking errata. So =
we can easily know
if SoC is affected by a errata and have some extra documentation.

>=20
> Or rather have select "CPU_HAS_LLSC if !SOC_AR5312" in that case.
>=20
>>        help
>>          Support for Atheros AR231x and Atheros AR531x based boards
>>=20
>> @@ -2544,6 +2545,11 @@ config WAR_ICACHE_REFILLS
>> config WAR_R10000_LLSC
>>        bool
>>=20
>> +# On 4Kc up to version 0.9 (PRID_REV < 1) there is a bug that may =
cause llsc
>> +# sequences to deadlock.
>> +config WAR_4KC_LLSC
>> +       bool
>> +
>> # 34K core erratum: "Problems Executing the TLBR Instruction"
>> config WAR_MIPS34K_MISSED_ITLB
>>        bool
>> diff --git a/arch/mips/include/asm/cpu.h =
b/arch/mips/include/asm/cpu.h
>> index ecb9854cb432..84bb1931a8b4 100644
>> --- a/arch/mips/include/asm/cpu.h
>> +++ b/arch/mips/include/asm/cpu.h
>> @@ -247,6 +247,7 @@
>> #define PRID_REV_VR4122                        0x0070
>> #define PRID_REV_VR4181A               0x0070  /* Same as VR4122 */
>> #define PRID_REV_VR4130                        0x0080
>> +#define PRID_REV_4KC_V1_0              0x0001
>> #define PRID_REV_34K_V1_0_2            0x0022
>> #define PRID_REV_LOONGSON1B            0x0020
>> #define PRID_REV_LOONGSON1C            0x0020  /* Same as Loongson-1B =
*/
>> diff --git a/arch/mips/include/asm/mach-ath25/cpu-feature-overrides.h =
b/arch/mips/include/asm/mach-ath25/cpu-feature-overrides.h
>> index ec3604c44ef2..5df292b1ff04 100644
>> --- a/arch/mips/include/asm/mach-ath25/cpu-feature-overrides.h
>> +++ b/arch/mips/include/asm/mach-ath25/cpu-feature-overrides.h
>> @@ -24,7 +24,7 @@
>> #define cpu_has_counter                        1
>> #define cpu_has_ejtag                  1
>>=20
>> -#if !defined(CONFIG_SOC_AR5312)
>> +#if !defined(WAR_4KC_LLSC)
>> #  define cpu_has_llsc                 1
>=20
> since the #else path defines cpu_has_llsc as 0, it means that kernels
> targeting both SoCs would force llsc to be unavailable (not introduced
> by you).

I=E2=80=99m a little bit confused.
The logic seems very clear to me: If a SoC is not affected by =
WAR_4KC_LLSC,
then wire  cpu_has_llsc to 1, else wire it to 0.

It matches my intention.

>=20
> So this probably should be rather this:
>=20
> #if !defined(CONFIG_SOC_AR5312)
> #define cpu_has_llsc 1
> #else if !defined(CONFIG_SOC_AR5312)
> #define cpu_has_llsc 0
> #endif

The condition on if leg seems same to the else leg, I=E2=80=99m not sure =
if it can ever work.

>=20
> (so if only one is enabled, set it accordingly, else let runtime
> detection handle it).
>=20
>> #else
>> /*
>> diff --git a/arch/mips/kernel/cpu-probe.c =
b/arch/mips/kernel/cpu-probe.c
>> index 6d15a398d389..fd452e68cd90 100644
>> --- a/arch/mips/kernel/cpu-probe.c
>> +++ b/arch/mips/kernel/cpu-probe.c
>> @@ -152,6 +152,13 @@ static inline void check_errata(void)
>>        struct cpuinfo_mips *c =3D &current_cpu_data;
>>=20
>>        switch (current_cpu_type()) {
>> +       case CPU_4KC:
>> +               if ((c->processor_id & PRID_REV_MASK) < =
PRID_REV_4KC_V1_0) {
>> +                       c->options &=3D ~MIPS_CPU_LLSC;
>> +                       if (!IS_ENABLED(CONFIG_WAR_4K_LLSC))
>> +                               pr_err("CPU have LLSC errata, please =
enable CONFIG_WAR_4K_LLSC");
>> +               }
>=20
> And then you don't need this error message at all, since then
> cpu_has_llsc is 0 or follows MIPS_CPU_LLSC, unless you disabled
> support for the relevant SoC, and then you'll have bigger problems
> anyway.

The problem is as per MIPS the affected IP core was shipped to multiple =
customers
This error message can cover other SoCs that potentially using this =
core.

Thanks
- Jiaxun

>=20
> Regards,
> Jonas


