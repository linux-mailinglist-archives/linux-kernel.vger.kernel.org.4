Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30BFD6AC7A3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 17:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjCFQUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 11:20:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjCFQTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 11:19:42 -0500
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D28A5D7;
        Mon,  6 Mar 2023 08:17:07 -0800 (PST)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-176d1a112bfso3086079fac.5;
        Mon, 06 Mar 2023 08:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678119349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TgdT/YtWm0g09J975wQLLJKIJx3wVMWVgah7dEH2bco=;
        b=I436onofBERXhxwZ8iyGU8YndM9/HbZKw04GlZ9RKvicO5pNTpMgmOa1D+AKT55Hzb
         UGtBF55toPolPBCNGGMUo1mjijgWdbROYLyjxq8mcTBiPePGf3Cw3jMRe6VxIOVhoKJ6
         eCZUxI8vqb5dn297zUtlQ+Yl5YjMhGc08Gu/IW/u49OTCeHo97eujy124kqNiJDmWPjo
         RBoLhKUlBODwIqen8B6EtK1J7iOFqeLR+ka1/00S68FtU0ZvR9ER0OWm2DmtCu0nFspf
         +wya8oyV+6DL+/estAnX9kYMQB8kUBVHAak2MRtIs9r952b1jEfDHPa2jQ8i8UNrxJqA
         tsQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678119349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TgdT/YtWm0g09J975wQLLJKIJx3wVMWVgah7dEH2bco=;
        b=ohcaAjsM6xRuvTkUBSFb9/GjQrquNtGR509eLNV5rOrWTuHnNauKoNxBoxZLZop4c4
         /bbZh0rS6drKVTvpPEmRqpKAH59sVuyd5WmXjG3o1AmrbMOas+i4zkTCAlFf67tsHPLM
         jK9DWpv+YgxPXD/lKyVhTppseyMYw+rp92FATmOTAjvFvbf9ggSnNfWVnPy7mmMW3Wf0
         Vz45olyvG2VMPQ3VjvenyjaG+G0OMXbkgfYYDpMt3BBI9FLqlxnuJ6VtwuJRGyAtvbhs
         2F1aaw+Pwixk8uotmsf0bbCPjp5ZIzYu9q39nt+9cZr6CdIjoug7REDTk8GPp1YHJu8E
         omYw==
X-Gm-Message-State: AO0yUKVy+eJtu7UHmdcFKPv5Ive/l8zcXu8otLdWV+F89nO/QVkrUmNo
        m2touTH1NT/zvbQyLOJt9qdungMwu+gfOURlmtYIN2WT6lDTZQ==
X-Google-Smtp-Source: AK7set9iTA9AO4Etm6Qa6BetwCKi4s9NKpG7X8X0EqbX+5L+CoaJUzr/UhCCfQS5fJIS/u7YsOAg2h5lNwb4vZhgsu4=
X-Received: by 2002:a05:6870:d346:b0:176:2168:12a2 with SMTP id
 h6-20020a056870d34600b00176216812a2mr3902807oag.2.1678119349301; Mon, 06 Mar
 2023 08:15:49 -0800 (PST)
MIME-Version: 1.0
References: <20230303002850.51858-1-arinc.unal@arinc9.com> <20230303002850.51858-6-arinc.unal@arinc9.com>
 <CAMhs-H-VGjP32AZc2cuY=Co4iqx8xPtvjr+hMg-haMMFaQzzsg@mail.gmail.com>
 <CAMhs-H8OsG-SEWigimG3fT-SGjZruH-7tnjff198Z2qhb0O=yA@mail.gmail.com>
 <2106f6d0-63cc-4656-1e52-19640994fb43@arinc9.com> <CAMhs-H869pR6CzaWfvf44w-ak+0OCyxnMEEU4kWYpw=C14ShsQ@mail.gmail.com>
 <fc6dc970-5bae-1c27-9473-8c9d90ac79a1@arinc9.com> <CAMhs-H_SryQqCZ3mB_VsO20ZSvKCMR5V9E7wrt+a-kbcqQxsWQ@mail.gmail.com>
 <00d4dd34-efe5-8bc7-031a-0f9d19a1b8e0@arinc9.com>
In-Reply-To: <00d4dd34-efe5-8bc7-031a-0f9d19a1b8e0@arinc9.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Mon, 6 Mar 2023 17:15:36 +0100
Message-ID: <CAMhs-H_nTDZMQPQ8R5JeWtgWyP1y57uhym-A4f3LcTgJYV+8pw@mail.gmail.com>
Subject: Re: [PATCH 05/20] pinctrl: ralink: move to mediatek as mtmips
To:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mediatek@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        William Dean <williamsukatube@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Daniel Santos <daniel.santos@pobox.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, erkin.bozoglu@xeront.com
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

On Mon, Mar 6, 2023 at 4:06 PM Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9=
.com> wrote:
>
> On 6.03.2023 17:07, Sergio Paracuellos wrote:
> > On Fri, Mar 3, 2023 at 3:18 PM Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@ar=
inc9.com> wrote:
> >>
> >> Heyo,
> >>
> >> On 3.03.2023 13:57, Sergio Paracuellos wrote:
> >>> Hi Ar=C4=B1n=C3=A7,
> >>>
> >>> On Fri, Mar 3, 2023 at 9:16 AM Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@=
arinc9.com> wrote:
> >>>>
> >>>> Hey Sergio,
> >>>>
> >>>> On 3.03.2023 09:34, Sergio Paracuellos wrote:
> >>>>> On Fri, Mar 3, 2023 at 7:17 AM Sergio Paracuellos
> >>>>> <sergio.paracuellos@gmail.com> wrote:
> >>>>>>
> >>>>>>     Hi Ar=C4=B1n=C3=A7,
> >>>>>>
> >>>>>> On Fri, Mar 3, 2023 at 1:30 AM <arinc9.unal@gmail.com> wrote:
> >>>>>>>
> >>>>>>> From: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
> >>>>>>>
> >>>>>>> This platform from Ralink was acquired by MediaTek in 2011. Then,=
 MediaTek
> >>>>>>> introduced new SoCs which utilise this platform. Move the driver =
to
> >>>>>>> mediatek pinctrl directory. Rename the ralink core driver to mtmi=
ps.
> >>>>>>>
> >>>>>>> Signed-off-by: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
> >>>>>>> ---
> >>>>>>>     drivers/pinctrl/Kconfig                       |  1 -
> >>>>>>>     drivers/pinctrl/Makefile                      |  1 -
> >>>>>>>     drivers/pinctrl/mediatek/Kconfig              | 51 ++++++++++=
-
> >>>>>>>     drivers/pinctrl/mediatek/Makefile             | 63 +++++++---=
---
> >>>>>>>     .../{ralink =3D> mediatek}/pinctrl-mt7620.c     | 34 +++----
> >>>>>>>     .../{ralink =3D> mediatek}/pinctrl-mt7621.c     | 30 +++----
> >>>>>>>     .../{ralink =3D> mediatek}/pinctrl-mt76x8.c     | 60 ++++++--=
-----
> >>>>>>>     .../pinctrl-mtmips.c}                         | 90 +++++++++-=
---------
> >>>>>>>     .../pinctrl-mtmips.h}                         | 16 ++--
> >>>>>>>     .../{ralink =3D> mediatek}/pinctrl-rt2880.c     | 20 ++---
> >>>>>>>     .../{ralink =3D> mediatek}/pinctrl-rt305x.c     | 44 ++++----=
-
> >>>>>>>     .../{ralink =3D> mediatek}/pinctrl-rt3883.c     | 28 +++---
> >>>>>>>     drivers/pinctrl/ralink/Kconfig                | 40 ---------
> >>>>>>>     drivers/pinctrl/ralink/Makefile               |  9 --
> >>>>>>>     14 files changed, 246 insertions(+), 241 deletions(-)
> >>>>>>>     rename drivers/pinctrl/{ralink =3D> mediatek}/pinctrl-mt7620.=
c (81%)
> >>>>>>>     rename drivers/pinctrl/{ralink =3D> mediatek}/pinctrl-mt7621.=
c (80%)
> >>>>>>>     rename drivers/pinctrl/{ralink =3D> mediatek}/pinctrl-mt76x8.=
c (81%)
> >>>>>>>     rename drivers/pinctrl/{ralink/pinctrl-ralink.c =3D> mediatek=
/pinctrl-mtmips.c} (74%)
> >>>>>>>     rename drivers/pinctrl/{ralink/pinctrl-ralink.h =3D> mediatek=
/pinctrl-mtmips.h} (75%)
> >>>>>>>     rename drivers/pinctrl/{ralink =3D> mediatek}/pinctrl-rt2880.=
c (71%)
> >>>>>>>     rename drivers/pinctrl/{ralink =3D> mediatek}/pinctrl-rt305x.=
c (75%)
> >>>>>>>     rename drivers/pinctrl/{ralink =3D> mediatek}/pinctrl-rt3883.=
c (80%)
> >>>>>>>     delete mode 100644 drivers/pinctrl/ralink/Kconfig
> >>>>>>>     delete mode 100644 drivers/pinctrl/ralink/Makefile
> >>>>>>>
> >>>>>>> diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
> >>>>>>> index dcb53c4a9584..8a6012770640 100644
> >>>>>>> --- a/drivers/pinctrl/Kconfig
> >>>>>>> +++ b/drivers/pinctrl/Kconfig
> >>>>>>> @@ -537,7 +537,6 @@ source "drivers/pinctrl/nomadik/Kconfig"
> >>>>>>>     source "drivers/pinctrl/nuvoton/Kconfig"
> >>>>>>>     source "drivers/pinctrl/pxa/Kconfig"
> >>>>>>>     source "drivers/pinctrl/qcom/Kconfig"
> >>>>>>> -source "drivers/pinctrl/ralink/Kconfig"
> >>>>>>>     source "drivers/pinctrl/renesas/Kconfig"
> >>>>>>>     source "drivers/pinctrl/samsung/Kconfig"
> >>>>>>>     source "drivers/pinctrl/spear/Kconfig"
> >>>>>>> diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
> >>>>>>> index d5939840bb2a..ada6ed1d4e91 100644
> >>>>>>> --- a/drivers/pinctrl/Makefile
> >>>>>>> +++ b/drivers/pinctrl/Makefile
> >>>>>>> @@ -66,7 +66,6 @@ obj-y                         +=3D nomadik/
> >>>>>>>     obj-y                          +=3D nuvoton/
> >>>>>>>     obj-$(CONFIG_PINCTRL_PXA)      +=3D pxa/
> >>>>>>>     obj-$(CONFIG_ARCH_QCOM)                +=3D qcom/
> >>>>>>> -obj-$(CONFIG_PINCTRL_RALINK)   +=3D ralink/
> >>>>>>>     obj-$(CONFIG_PINCTRL_RENESAS)  +=3D renesas/
> >>>>>>>     obj-$(CONFIG_PINCTRL_SAMSUNG)  +=3D samsung/
> >>>>>>>     obj-$(CONFIG_PINCTRL_SPEAR)    +=3D spear/
> >>>>>>> diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/m=
ediatek/Kconfig
> >>>>>>> index a71874fed3d6..2eeb55010563 100644
> >>>>>>> --- a/drivers/pinctrl/mediatek/Kconfig
> >>>>>>> +++ b/drivers/pinctrl/mediatek/Kconfig
> >>>>>>> @@ -1,6 +1,6 @@
> >>>>>>>     # SPDX-License-Identifier: GPL-2.0-only
> >>>>>>>     menu "MediaTek pinctrl drivers"
> >>>>>>> -       depends on ARCH_MEDIATEK || COMPILE_TEST
> >>>>>>> +       depends on ARCH_MEDIATEK || RALINK || COMPILE_TEST
> >>>>>>>
> >>>>>>>     config EINT_MTK
> >>>>>>>            tristate "MediaTek External Interrupt Support"
> >>>>>>> @@ -22,6 +22,12 @@ config PINCTRL_MTK
> >>>>>>>     config PINCTRL_MTK_V2
> >>>>>>>            tristate
> >>>>>>>
> >>>>>>> +config PINCTRL_MTK_MTMIPS
> >>>>>>> +       bool
> >>>>>>> +       depends on RALINK
> >>>>>>> +       select PINMUX
> >>>>>>> +       select GENERIC_PINCONF
> >>>>>>> +
> >>>>>>>     config PINCTRL_MTK_MOORE
> >>>>>>>            bool
> >>>>>>>            depends on OF
> >>>>>>> @@ -43,6 +49,49 @@ config PINCTRL_MTK_PARIS
> >>>>>>>            select OF_GPIO
> >>>>>>>            select PINCTRL_MTK_V2
> >>>>>>>
> >>>>>>> +# For MIPS SoCs
> >>>>>>> +config PINCTRL_MT7620
> >>>>>>> +       bool "MediaTek MT7620 pin control"
> >>>>>>> +       depends on SOC_MT7620 || COMPILE_TEST
> >>>>>>> +       depends on RALINK
> >>>>>>> +       default SOC_MT7620
> >>>>>>> +       select PINCTRL_MTK_MTMIPS
> >>>>>>> +
> >>>>>>> +config PINCTRL_MT7621
> >>>>>>> +       bool "MediaTek MT7621 pin control"
> >>>>>>> +       depends on SOC_MT7621 || COMPILE_TEST
> >>>>>>> +       depends on RALINK
> >>>>>>> +       default SOC_MT7621
> >>>>>>> +       select PINCTRL_MTK_MTMIPS
> >>>>>>> +
> >>>>>>> +config PINCTRL_MT76X8
> >>>>>>> +       bool "MediaTek MT76X8 pin control"
> >>>>>>> +       depends on SOC_MT7620 || COMPILE_TEST
> >>>>>>> +       depends on RALINK
> >>>>>>> +       default SOC_MT7620
> >>>>>>> +       select PINCTRL_MTK_MTMIPS
> >>>>>>> +
> >>>>>>> +config PINCTRL_RT2880
> >>>>>>> +       bool "Ralink RT2880 pin control"
> >>>>>>> +       depends on SOC_RT288X || COMPILE_TEST
> >>>>>>> +       depends on RALINK
> >>>>>>> +       default SOC_RT288X
> >>>>>>> +       select PINCTRL_MTK_MTMIPS
> >>>>>>> +
> >>>>>>> +config PINCTRL_RT305X
> >>>>>>> +       bool "Ralink RT305X pin control"
> >>>>>>> +       depends on SOC_RT305X || COMPILE_TEST
> >>>>>>> +       depends on RALINK
> >>>>>>> +       default SOC_RT305X
> >>>>>>> +       select PINCTRL_MTK_MTMIPS
> >>>>>>> +
> >>>>>>> +config PINCTRL_RT3883
> >>>>>>> +       bool "Ralink RT3883 pin control"
> >>>>>>> +       depends on SOC_RT3883 || COMPILE_TEST
> >>>>>>> +       depends on RALINK
> >>>>>>> +       default SOC_RT3883
> >>>>>>> +       select PINCTRL_MTK_MTMIPS
> >>>>>>> +
> >>>>>>
> >>>>>> I am not a Kconfig expert at all but...
> >>>>>>
> >>>>>> Should not all of these be depends on SOC_XXX || (COMPILE_TEST &&
> >>>>>> RALINK) and avoid the " depends on RALINK" next line in all of the=
m?
> >>>>
> >>>> This seems to do the same thing but I'm following the "either change
> >>>> them all or fit into the crowd" ideology.
> >>>>
> >>>>>>
> >>>>>> Just asking since we have yet arch read and write register operati=
ons
> >>>>>> in pinctrl common ralink code. Having in this way, when we address
> >>>>>> this arch thing  in the next series just removing the "&& RALINK" =
part
> >>>>>> makes the review pretty obvious.
> >>>>
> >>>> You'd have to change RALINK with OF since we're still depending on t=
hat.
> >>>> RALINK selects OF by default so it's currently a hidden dependency.
> >>>>
> >>>>>>
> >>>>>> Other than that, changes look good to me.
> >>>>>
> >>>>> I think "depends on SOC_XXX || (COMPILE_TEST && MIPS)" would work a=
lso
> >>>>> and might be more accurate for compile testing targets.
> >>>
> >>> Are you sure? SOC_XXX here is already being enabled only if RALINK is
> >>> already enabled, right? [0]
> >>
> >> I'm not sure who's your reply to, or what it's about here.
> >
> > Bad insertion between lines, sorry :). I was just trying to explain to
> > you that SOC_RTXX ralink stuff is only available when RALINK is
> > already selected.
>
> Makes sense. However, I believe what I said below is still true. This
> option will be available to compile if a Ralink SoC (and therefore
> RALINK) is enabled, OR, COMPILE_TEST and MIPS is enabled. The latter
> will fail to compile if the enabled MIPS platform is not RALINK.
>
> >
> >>
> >>>
> >>>>
> >>>> This is not OK in both cases. If the driver is dependent on Ralink
> >>>> architecture code, choosing any other MIPS platform will make the dr=
iver
> >>>> available to compile, which will fail.
> >>>
> >>> SOC_XXX is already dependent on RALINK for real uses but the driver i=
s
> >>> going to be selected for other MIPS platforms only for COMPILE_TEST
> >>> targets. Ideally drivers should be arch agnostic so can be selected
> >>> for any single arch build. Now we have arch dependent read and write
> >>> calls in the code, so you need the right headers to be properly found
> >>> to be able to compile testing. I think MIPS is enough dependency here
> >>> to properly find them. But if not, this should be (COMPILE_TEST &&
> >>> RALINK)
> >>
> >> I expect below to work without requiring the MIPS option.
> >>
> >> ifeq ($(CONFIG_COMPILE_TEST),y)
> >> CFLAGS_pinctrl-mtmips.o         +=3D -I$(srctree)/arch/mips/include
> >> endif
> >
> > Yes, this will work but won't be necessary at all when we get rid of
> > ralink arch dependent code in the next series.
>
> Oh, you plan to completely get rid of it, including headers. That's bette=
r!

I'd really love to get rid of all of that, yes.

>
> However, rt305x_pinctrl_probe() on pinctrl-rt305x.c needs them to find
> out the SoC to match the pinmux data. Sure, splitting the driver further
> will work but I'm wondering if you've got something else in mind to
> address this.

I know. Sharing the same compatible string makes really hard to do
this easily. One of my thoughts was to split also that in the driver
as you are pointing out here. I have also submitted this series [0] to
be able to make use of soc_match stuff instead of relying on
compatible strings for these kinds of situations. However I am not
also sure that would be a valid approach. Let's see. At the end we can
end up splitting the driver if nothing seems to work.

Thanks,
    Sergio Paracuellos

[0]: https://lore.kernel.org/linux-mips/20230227105806.2394101-1-sergio.par=
acuellos@gmail.com/T/#t

>
> Ar=C4=B1n=C3=A7
