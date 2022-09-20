Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4F75BE947
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 16:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiITOqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 10:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbiITOq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 10:46:27 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FAC58DD1;
        Tue, 20 Sep 2022 07:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1663685183; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sPXtRxL0JOmcLE/AO78qFFS6PyAI3+iNoi2WhTmlh7M=;
        b=aIWJi1dl4CEN8T5befE49ZnkPl8vnsCfWScZmQUmepvnvMAlLBhkkHUC0n9HhjPdXK2XwU
        BiXn75H1fUNMvPuLZIDWUVbMoKc7gpR41/jajMzqTqfyOKXrzuFaPuKIzBSAZlHd/bTlY5
        zXOZlbmbR8Q6/ffx8vtY4fyALzShtaw=
Date:   Tue, 20 Sep 2022 15:46:13 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: Usefulness of CONFIG_MACH_JZ47*
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mips <linux-mips@vger.kernel.org>,
        MIPS Creator CI20 Development 
        <mips-creator-ci20-dev@googlegroups.com>
Message-Id: <1PJIIR.05HV5SPX2S6E2@crapouillou.net>
In-Reply-To: <8F8B1125-40FA-464B-B662-F29C3F0AA5E2@goldelico.com>
References: <af10570000d7e103d70bbea590ce8df4f8902b67.1661330532.git.christophe.jaillet@wanadoo.fr>
        <UC07HR.REF39SO0Y5PG2@crapouillou.net>
        <CDEACE3D-5433-457B-AF77-E41F39A04CA4@goldelico.com>
        <H34IIR.IGTU7CQ36OZK3@crapouillou.net>
        <F21B5D44-94D8-4BDB-BB34-9CBFC5F2B891@goldelico.com>
        <DBGIIR.8W0JWG83D6FE2@crapouillou.net>
        <8F8B1125-40FA-464B-B662-F29C3F0AA5E2@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le mar., sept. 20 2022 at 16:19:41 +0200, H. Nikolaus Schaller=20
<hns@goldelico.com> a =E9crit :
> Hi Paul,
>=20
>>  Am 20.09.2022 um 15:33 schrieb Paul Cercueil <paul@crapouillou.net>:
>>=20
>>=20
>>=20
>>  Le mar., sept. 20 2022 at 14:31:38 +0200, H. Nikolaus Schaller=20
>> <hns@goldelico.com> a =E9crit :
>>>  Hi Paul,
>>>>  Am 20.09.2022 um 11:09 schrieb Paul Cercueil=20
>>>> <paul@crapouillou.net>:
>>>>  Hi Nikolaus,
>>>>  Le mar., sept. 20 2022 at 08:31:30 +0200, H. Nikolaus Schaller=20
>>>> <hns@goldelico.com> a =E9crit :
>>>>>  Hi Paul,
>>>>>  it seems as if there aren't many places left over where the=20
>>>>> MACH_JZ47* configs are still in use:
>>>>>  drivers/char/hw_ramdom/Kconfig
>>>>>  drivers/clk/ingenic/Kconfig
>>>>>  drivers/gpu/drm/ingenic/Kconfig
>>>>>  drivers/pinctrl/pinctrl-ingenic.c
>>>>>  Is it possible to get rid of them and just have=20
>>>>> CONFIG_MACH_INGENIC_GENERIC?
>>>>>  This might simplify my defconfig for multiple machines.
>>>>  CONFIG_MIPS_GENERIC_KERNEL=3Dy
>>>  This breaks compilation for me, e.g.
>>>  arch/mips/mm/cache.c:203:6: error: 'cpu_has_tx39_cache' undeclared=20
>>> (first use in this function)
>>=20
>>  v6.0-rc does not have 'cpu_has_tx39_cache' anywhere in that file,=20
>> or in arch/mips/ for that matter. It was removed in v5.18.
>>=20
>>  And a v5.17 kernel compiles fine here with these options enabled.=20
>> So it's a problem on your side, I guess.
>=20
> Ah, you were right.
>=20
> I have a patch included which was provided by=20
> zhouyanjie@wanyeetech.com
> ("MIPS: mm: Add Ingenic XBurst SoCs specific cache driver.").
>=20
> It is intended to improve caching and is part of jz4780 SMP support=20
> which we wanted to have.
> AFAIR it was either not posted to lkml or rejected or superseded.
>=20
>>=20
>>>>  CONFIG_BOARD_INGENIC=3Dy
>>>  This config option does not exist (at least in v6.0-rc). Probably=20
>>> you refer to CONFIG_INGENIC_GENERIC_BOARD.
>>=20
>>  No, I do not, and yes, it exists.
>=20
> Ah, I grepped for CONFIG_BOARD_INGENIC but it exists only in one=20
> Kconfig as BOARD_INGENIC.
> But what is then the difference to CONFIG_INGENIC_GENERIC_BOARD and=20
> CONFIG_MACH_INGENIC_GENERIC?

CONFIG_BOARD_INGENIC=3Dy means you are building a generic MIPS kernel=20
that happens to support Ingenic boards. In this case, the kernel has a=20
lot of features enabled that might not be useful on specific Ingenic=20
boards, because the kernel needs to support other SoCs. This option=20
selects CONFIG_MACH_INGENIC_GENERIC=3Dy, which in turn selects=20
MACH_INGENIC=3Dy and every MACH_JZ* and MACH_X* there is.

If you instead set MACH_INGENIC_SOC=3Dy as your "Machine Selection ->=20
System Type", this means your kernel will run specifically on Ingenic=20
SoCs and isn't expected to work anywhere else. By default the "Machine=20
Type" will be CONFIG_INGENIC_GENERIC_BOARD=3Dy aka. "Generic board",=20
which can be used to support any board with an Ingenic SoC. This option=20
also selects CONFIG_MACH_INGENIC_GENERIC=3Dy. If you choose a different=20
"machine type", for instance JZ4780_CI20=3Dy, then only MACH_JZ4780=3Dy=20
will be selected, and all the code unrelated to the JZ4780 SoC will be=20
disabled.

Cheers,
-Paul

>=20
>>=20
>>>  As far as I see, this does not choose to build any device tree=20
>>> blob.
>>>  I tried some patch to get the .dtb built, but the resulting kernel=20
>>> does not show any activity.
>>>  If I e.g. switch back from CONFIG_INGENIC_GENERIC_BOARD=3Dy to=20
>>> CONFIG_JZ4780_CI20=3Dy the kernel works.
>>=20
>>  Because in the first case you build a generic kernel, which does=20
>> not embed any .dtb, and you are responsible for providing the kernel=20
>> with the blob at boot time; while if you build with=20
>> CONFIG_JZ4780_CI20=3Dy it embeds the .dtb inside the kernel.
>>=20
>>  You can embed the .dtb into the generic kernel at compile-time too,=20
>> have a look at "Kernel type -> Kernel appended dtb support." Not=20
>> sure why you'd want that for a generic kernel, though.
>=20
> Ah, I remember. Since I usually code 99% of my time for ARM systems=20
> with separate .dtb files chosen by the boot loader, I forgot that we=20
> have to append the .dtb on the CI20 and Alpha400. So there is no good=20
> solution for a "universal" kernel binary either.
>=20
>>=20
>>>>  Then you can support all Ingenic-based boards alongside other=20
>>>> MIPS boards.
>>>  Yes, I know, but why are the MACH_JZ47* not replaced by=20
>>> CONFIG_MACH_INGENIC_GENERIC if they are almost unused or completely=20
>>> removed?
>>=20
>>  They *are* used.
>=20
> Well, only in a handful of places as it looks like.
>=20
>>=20
>>>  BTW: there are also seems to be some board specific CONFIGs in=20
>>> processor specific code (e.g. CONFIG_JZ4780_CI20 in irqchip code).
>>=20
>>  rgrep CI20 drivers/irqchip/
>>=20
>>  returns nothing for me.
>=20
> Ah, again an inofficial patch which is part of the SMP stuff=20
> ("irqchip: Ingenic: Add percpu IRQ support for X2000.").
>=20
>>=20
>>>  So selecting a MACH is not sufficient to get these features.
>>>  All this looks a little fragile and incomplete... Maybe if I find=20
>>> some time (which is unfortunately quite unlikely) I can propose=20
>>> some fixes.
>>=20
>>  It is not "fragile and incomplete", it works as intended, and it's=20
>> a feature I use often.
>=20
> Yes, seems as if you are right. We may have added too many useful=20
> patches which did not go upstreamand get in conflict with upstream=20
> features.
>=20
> BR and thanks for helping to better understand,
> Nikolaus
>=20
>>=20
>>  -Paul
>>=20
>=20


