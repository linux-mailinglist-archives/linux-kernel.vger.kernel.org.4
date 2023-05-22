Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D2F70CDE5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 00:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234777AbjEVW1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 18:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234769AbjEVW1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 18:27:02 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE5B10D;
        Mon, 22 May 2023 15:26:51 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 08B405C0178;
        Mon, 22 May 2023 18:26:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 22 May 2023 18:26:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1684794409; x=1684880809; bh=CtWo2nHbm2EGyWys8ynF1KcFouDF1bJFUee
        lWmk78ec=; b=Zb5lxSN0/itluIb1eIFB7lle5LjbqKJJlfUtED8yh+YPow+/lxf
        xTVHgUvvos6+LksNIWvM+AZ8zv8XdKngD5dAf7WXGYXIlwDwl2pQoP1qSJhrXvZd
        110eC5G2dquhO0TZXMi9CUTWz7O/BLA9DiNGimpai8dkDCSXcgiyDp/4Tjf+Zklg
        sd5spllSLppCvi4LF5oC7UJEUigzsl7sM+r3Q/Zvw43WYgTIvOb/KyNSPQPIgkJg
        H06DKvsHPrRGGvSB1AslUpAFL5UkZ0tU3YI3AnulV8lZIXcF1MJ/m3tY1IZ9ztQ8
        uci5FWZI1haF1/ffV9CshlfKqHLYsOXq5Kg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1684794409; x=1684880809; bh=CtWo2nHbm2EGyWys8ynF1KcFouDF1bJFUee
        lWmk78ec=; b=lTzRW+Kae5xQOf8BC9AZJFwRm1mpIL8RqadT74yes3voKaFtp5r
        qCi85D9DO6zNqToThp950iryrE2lPAFb5poAwJJo213mpgidqgXPSMRWc2gSicg2
        UtKW5UgIshvVkC/raDFF8Ru6RG44wdeSKiPYlkMyczdaYcXYBwbqL64kLadnAef9
        XZZSuQZcD6dPk/SOc3UZt30MVXN2AwQpV/GfGk4h5sdY1D+e/tsePqdlUm6gwH9l
        6Q2Vi4ROeS6I/G1nhLKVBXT5yPNy2jk9BsZFnsUaYLh7gYwSIVWQXipjR7Z5Uzzj
        SE5Ru9g5+8tzeHoHzBPPzEIuWDhY26w2wSQ==
X-ME-Sender: <xms:KOxrZJaTThBu4FS7bJEnscm7Q1TYSN5k7Ojh98Qx-AzbKFmov5dTGQ>
    <xme:KOxrZAa3S_Q8HrAWbst2xNy70w1OyaKD7Y9qTM1MKmPyY7KHvignRUvLQEcbL9DUY
    -Ukld_pRHpu7alIl1M>
X-ME-Received: <xmr:KOxrZL-plO9QZAPJGlg4n6uniGMfne93D1mTS6AJIcrCNK5s3eJuM6vxi6iBZ2Rzp-lj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejvddguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurheptggguffhjgffvefgkfhfvffosehtqhhmtdhhtdejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepuddtjeffteetfeekjeeiheefueeigeeutdevieejveeihfff
    ledvgfduiefhvddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:KOxrZHpMxfU01IVzanFGWcpTJDF3mypfDUPayeYzcXrzjSuHaxlo7A>
    <xmx:KOxrZErwcnBkw69ER9IVa2RfcfOylIUehswKssLH5ESa26R7xi7ExQ>
    <xmx:KOxrZNRn8VXYo1DhltQF9Qq0mB9p13HVIv_FtSHCM-Ca5PYOtQM1lw>
    <xmx:KexrZL38i08YSIl1tcmi4iJNa5ku-5rICzC-uwC8kOrAroRg4k9kmA>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 May 2023 18:26:47 -0400 (EDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: [PATCH 1/3] MIPS: Introduce WAR_4KC_LLSC config option
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <CAOiHx=mue3GPncsCH-ndyDy_+X3R5AMRE6VBKztHF=RkHBD7SQ@mail.gmail.com>
Date:   Mon, 22 May 2023 23:26:36 +0100
Cc:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <32D47527-3EC3-4AB3-BD65-BB1FB848E7DC@flygoat.com>
References: <20230519164753.72065-1-jiaxun.yang@flygoat.com>
 <20230519164753.72065-2-jiaxun.yang@flygoat.com>
 <CAOiHx==iku+duvBnAfu_3AXgNmY9aK+uO+t9Enzdf6qQN5m+iw@mail.gmail.com>
 <2CC0C4B4-78C4-4D93-828C-318DC1CAD479@flygoat.com>
 <CAOiHx=mue3GPncsCH-ndyDy_+X3R5AMRE6VBKztHF=RkHBD7SQ@mail.gmail.com>
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



> 2023=E5=B9=B45=E6=9C=8822=E6=97=A5 23:03=EF=BC=8CJonas Gorski =
<jonas.gorski@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Mon, 22 May 2023 at 22:38, Jiaxun Yang <jiaxun.yang@flygoat.com> =
wrote:
>>=20
>>=20
>>=20
>>> 2023=E5=B9=B45=E6=9C=8822=E6=97=A5 19:40=EF=BC=8CJonas Gorski =
<jonas.gorski@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
>>>=20
>>> Hi,
>>>=20
>>> On Fri, 19 May 2023 at 18:49, Jiaxun Yang <jiaxun.yang@flygoat.com> =
wrote:
>>>>=20
>>>> WAR_4KC_LLSC is used to control workaround of 4KC LLSC issue
>>>> that affects 4Kc up to version 0.9.
>>>>=20
>>>> Early ath25 chips are known to be affected.
>>>>=20
>>>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>>>> ---
>>>> arch/mips/Kconfig                                        | 6 ++++++
>>>> arch/mips/include/asm/cpu.h                              | 1 +
>>>> arch/mips/include/asm/mach-ath25/cpu-feature-overrides.h | 2 +-
>>>> arch/mips/kernel/cpu-probe.c                             | 7 =
+++++++
>>>> 4 files changed, 15 insertions(+), 1 deletion(-)
>>>>=20
>>>> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
>>>> index 30e90a2d53f4..354d033364ad 100644
>>>> --- a/arch/mips/Kconfig
>>>> +++ b/arch/mips/Kconfig
>>>> @@ -230,6 +230,7 @@ config ATH25
>>>>       select SYS_SUPPORTS_BIG_ENDIAN
>>>>       select SYS_SUPPORTS_32BIT_KERNEL
>>>>       select SYS_HAS_EARLY_PRINTK
>>>> +       select WAR_4KC_LLSC if !SOC_AR5312
>>>=20
>>> Shouldn't this be "if SOC_AR5312"?
>>=20
>> Ah sorry, I misread the original code.
>>=20
>>>=20
>>> Though since you are adding runtime detection/correction below, I
>>> wonder if this would be really needed as an extra symbol, and rather
>>> use the later introduced (CPU_MAY_HAVE_LLSC) directly.
>>=20
>> I bet it=E2=80=99s better to have a symbol just for tracking errata. =
So we can easily know
>> if SoC is affected by a errata and have some extra documentation.
>>=20
>>>=20
>>> Or rather have select "CPU_HAS_LLSC if !SOC_AR5312" in that case.
>>>=20
>>>>       help
>>>>         Support for Atheros AR231x and Atheros AR531x based boards
>>>>=20
>>>> @@ -2544,6 +2545,11 @@ config WAR_ICACHE_REFILLS
>>>> config WAR_R10000_LLSC
>>>>       bool
>>>>=20
>>>> +# On 4Kc up to version 0.9 (PRID_REV < 1) there is a bug that may =
cause llsc
>>>> +# sequences to deadlock.
>>>> +config WAR_4KC_LLSC
>>>> +       bool
>>>> +
>>>> # 34K core erratum: "Problems Executing the TLBR Instruction"
>>>> config WAR_MIPS34K_MISSED_ITLB
>>>>       bool
>>>> diff --git a/arch/mips/include/asm/cpu.h =
b/arch/mips/include/asm/cpu.h
>>>> index ecb9854cb432..84bb1931a8b4 100644
>>>> --- a/arch/mips/include/asm/cpu.h
>>>> +++ b/arch/mips/include/asm/cpu.h
>>>> @@ -247,6 +247,7 @@
>>>> #define PRID_REV_VR4122                        0x0070
>>>> #define PRID_REV_VR4181A               0x0070  /* Same as VR4122 */
>>>> #define PRID_REV_VR4130                        0x0080
>>>> +#define PRID_REV_4KC_V1_0              0x0001
>>>> #define PRID_REV_34K_V1_0_2            0x0022
>>>> #define PRID_REV_LOONGSON1B            0x0020
>>>> #define PRID_REV_LOONGSON1C            0x0020  /* Same as =
Loongson-1B */
>>>> diff --git =
a/arch/mips/include/asm/mach-ath25/cpu-feature-overrides.h =
b/arch/mips/include/asm/mach-ath25/cpu-feature-overrides.h
>>>> index ec3604c44ef2..5df292b1ff04 100644
>>>> --- a/arch/mips/include/asm/mach-ath25/cpu-feature-overrides.h
>>>> +++ b/arch/mips/include/asm/mach-ath25/cpu-feature-overrides.h
>>>> @@ -24,7 +24,7 @@
>>>> #define cpu_has_counter                        1
>>>> #define cpu_has_ejtag                  1
>>>>=20
>>>> -#if !defined(CONFIG_SOC_AR5312)
>>>> +#if !defined(WAR_4KC_LLSC)
>>>> #  define cpu_has_llsc                 1
>>>=20
>>> since the #else path defines cpu_has_llsc as 0, it means that =
kernels
>>> targeting both SoCs would force llsc to be unavailable (not =
introduced
>>> by you).
>>=20
>> I=E2=80=99m a little bit confused.
>> The logic seems very clear to me: If a SoC is not affected by =
WAR_4KC_LLSC,
>> then wire  cpu_has_llsc to 1, else wire it to 0.
>=20
> ATH25 allows you building for multiple SoCs at the same time, and if
> you do so, you don't know in advance on which SoC you boot. So you
> need to have third path here where cpu_has_llsc isn't wired to
> anything.

Thanks for pointing out the missing piece, I thought ATH25 can only be
built for a single SoC :-)

>=20
> This is wrong in the current code already, so should be fixed there.
>=20

[...]

> AFAICT the core issue is if the platform hardcodes cpu_has_llsc to 1.
>=20
> So the error/warning this should be then something like this
>=20
> if ((c->processor_id & PRID_REV_MASK) < PRID_REV_4KC_V1_0) {
>   c->options &=3D ~MIPS_CPU_LLSC;
>   if (cpu_has_llsc) { // <- should now be false, unless the platform
> defines it as 1
>      pr_err("CPU has LLSC erratum, but cpu_has_llsc is force =
enabled!\n");
>   }
>=20
> because clearing MIPS_CPU_LLSC does nothing if cpu_has_llsc is
> #defined as 1, regardless if it selected WAR_4K_LLSC or not.
>=20
> (also your error print is missing a \n at the end)

Ah, thanks.
I=E2=80=99m planning to replace this pr_err with WARN_TAINT_ONCE.

Thanks
- Jiaxun

>=20
> Regards,
> Jonas


