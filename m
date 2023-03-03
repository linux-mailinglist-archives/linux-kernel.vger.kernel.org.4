Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED466A95AB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 11:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjCCK54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 05:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjCCK5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 05:57:47 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC4E5F6CD;
        Fri,  3 Mar 2023 02:57:46 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id c11so1474994oiw.2;
        Fri, 03 Mar 2023 02:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677841065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7E4mZs1lSDJuZWPvckglKhTGLvAaeFuzWBmRPW2/AFs=;
        b=ek0Cq2wlLpdZEwzg3F+W55iG+xhnwmpy4haHdOXVfT4MyoBsb5VgnPQTqhyrHLOEs3
         +9C18uxO1LZQ3Yl5WVWprYFcZjlzNzU27BUJ9AfODgbobFjZAqx4XQXLp8TFmxjmzMpT
         CFQir+n9Eg6Olgm/XMtdAkxvhTJFf81ZdTPYnsMDWFrDNP0A2k0fgceh1ing0R8Ul1Ug
         DRq5dO+rFBqhEdAHdj5izltzArlrUFnuZYaBG26cVZ1gPks2TjCD9bHPUATrz1BvB9M/
         GcsxsbQwj0WImZ7DFsVt7GBsEKHQmPRo6NRiPy5rHOxi3+UsDiooE8QKCIA8haSA7O0F
         pDuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677841065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7E4mZs1lSDJuZWPvckglKhTGLvAaeFuzWBmRPW2/AFs=;
        b=lFvkTijZnblSM4S7onCO52eUJNIwGqgsBwYuFkCNTwFZR+EKGifHKuwpm3MS4wMuoz
         RIlqfquL3A4J88UeHXWqBXfxlL9WetJ/XKB3pCsYbeYgvG6qYtc09NaYuGKx0FvBm1EI
         EJGLfNqqC5UVNY1w0bHQ5U/rIRQtxXefkpBTqs+3NIgJVGASD51D9y9LM4lojxuq2M83
         +XcF4x/A6nNm3D/T1wi/nvPbMu6ASvCubwzv+QQc+9HU2w8T0oPxk3DyUsaP+i2cFoSM
         BsrD6cNl5GuMkSCt4imp6U2piBWovI7DsEiCmaSCvm88GQr+8DVW1z4gR2Gz1gmiUADO
         EeNw==
X-Gm-Message-State: AO0yUKU04cSx6aLKbIRb1pOCrROvGH1CzsyA53NcDd2GX8iQvVApbMbJ
        HcIRpe7QwNRM/HMb2lrvcKlOJjwotwUuX/jstXvlpZiKHifRsw==
X-Google-Smtp-Source: AK7set915H2RvsmyYUYEA9a1k4DJI960i6w5S9Y2V6TuLd/dBrcrKa868w7lyH7n9/AWPq6Hb8uWejWg8ER3mdz/xtI=
X-Received: by 2002:a05:6808:aa1:b0:384:2022:f9b1 with SMTP id
 r1-20020a0568080aa100b003842022f9b1mr405256oij.2.1677841065626; Fri, 03 Mar
 2023 02:57:45 -0800 (PST)
MIME-Version: 1.0
References: <20230303002850.51858-1-arinc.unal@arinc9.com> <20230303002850.51858-6-arinc.unal@arinc9.com>
 <CAMhs-H-VGjP32AZc2cuY=Co4iqx8xPtvjr+hMg-haMMFaQzzsg@mail.gmail.com>
 <CAMhs-H8OsG-SEWigimG3fT-SGjZruH-7tnjff198Z2qhb0O=yA@mail.gmail.com> <2106f6d0-63cc-4656-1e52-19640994fb43@arinc9.com>
In-Reply-To: <2106f6d0-63cc-4656-1e52-19640994fb43@arinc9.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Fri, 3 Mar 2023 11:57:33 +0100
Message-ID: <CAMhs-H869pR6CzaWfvf44w-ak+0OCyxnMEEU4kWYpw=C14ShsQ@mail.gmail.com>
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

Hi Ar=C4=B1n=C3=A7,

On Fri, Mar 3, 2023 at 9:16 AM Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9=
.com> wrote:
>
> Hey Sergio,
>
> On 3.03.2023 09:34, Sergio Paracuellos wrote:
> > On Fri, Mar 3, 2023 at 7:17 AM Sergio Paracuellos
> > <sergio.paracuellos@gmail.com> wrote:
> >>
> >>   Hi Ar=C4=B1n=C3=A7,
> >>
> >> On Fri, Mar 3, 2023 at 1:30 AM <arinc9.unal@gmail.com> wrote:
> >>>
> >>> From: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
> >>>
> >>> This platform from Ralink was acquired by MediaTek in 2011. Then, Med=
iaTek
> >>> introduced new SoCs which utilise this platform. Move the driver to
> >>> mediatek pinctrl directory. Rename the ralink core driver to mtmips.
> >>>
> >>> Signed-off-by: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
> >>> ---
> >>>   drivers/pinctrl/Kconfig                       |  1 -
> >>>   drivers/pinctrl/Makefile                      |  1 -
> >>>   drivers/pinctrl/mediatek/Kconfig              | 51 ++++++++++-
> >>>   drivers/pinctrl/mediatek/Makefile             | 63 +++++++------
> >>>   .../{ralink =3D> mediatek}/pinctrl-mt7620.c     | 34 +++----
> >>>   .../{ralink =3D> mediatek}/pinctrl-mt7621.c     | 30 +++----
> >>>   .../{ralink =3D> mediatek}/pinctrl-mt76x8.c     | 60 ++++++-------
> >>>   .../pinctrl-mtmips.c}                         | 90 +++++++++-------=
---
> >>>   .../pinctrl-mtmips.h}                         | 16 ++--
> >>>   .../{ralink =3D> mediatek}/pinctrl-rt2880.c     | 20 ++---
> >>>   .../{ralink =3D> mediatek}/pinctrl-rt305x.c     | 44 ++++-----
> >>>   .../{ralink =3D> mediatek}/pinctrl-rt3883.c     | 28 +++---
> >>>   drivers/pinctrl/ralink/Kconfig                | 40 ---------
> >>>   drivers/pinctrl/ralink/Makefile               |  9 --
> >>>   14 files changed, 246 insertions(+), 241 deletions(-)
> >>>   rename drivers/pinctrl/{ralink =3D> mediatek}/pinctrl-mt7620.c (81%=
)
> >>>   rename drivers/pinctrl/{ralink =3D> mediatek}/pinctrl-mt7621.c (80%=
)
> >>>   rename drivers/pinctrl/{ralink =3D> mediatek}/pinctrl-mt76x8.c (81%=
)
> >>>   rename drivers/pinctrl/{ralink/pinctrl-ralink.c =3D> mediatek/pinct=
rl-mtmips.c} (74%)
> >>>   rename drivers/pinctrl/{ralink/pinctrl-ralink.h =3D> mediatek/pinct=
rl-mtmips.h} (75%)
> >>>   rename drivers/pinctrl/{ralink =3D> mediatek}/pinctrl-rt2880.c (71%=
)
> >>>   rename drivers/pinctrl/{ralink =3D> mediatek}/pinctrl-rt305x.c (75%=
)
> >>>   rename drivers/pinctrl/{ralink =3D> mediatek}/pinctrl-rt3883.c (80%=
)
> >>>   delete mode 100644 drivers/pinctrl/ralink/Kconfig
> >>>   delete mode 100644 drivers/pinctrl/ralink/Makefile
> >>>
> >>> diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
> >>> index dcb53c4a9584..8a6012770640 100644
> >>> --- a/drivers/pinctrl/Kconfig
> >>> +++ b/drivers/pinctrl/Kconfig
> >>> @@ -537,7 +537,6 @@ source "drivers/pinctrl/nomadik/Kconfig"
> >>>   source "drivers/pinctrl/nuvoton/Kconfig"
> >>>   source "drivers/pinctrl/pxa/Kconfig"
> >>>   source "drivers/pinctrl/qcom/Kconfig"
> >>> -source "drivers/pinctrl/ralink/Kconfig"
> >>>   source "drivers/pinctrl/renesas/Kconfig"
> >>>   source "drivers/pinctrl/samsung/Kconfig"
> >>>   source "drivers/pinctrl/spear/Kconfig"
> >>> diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
> >>> index d5939840bb2a..ada6ed1d4e91 100644
> >>> --- a/drivers/pinctrl/Makefile
> >>> +++ b/drivers/pinctrl/Makefile
> >>> @@ -66,7 +66,6 @@ obj-y                         +=3D nomadik/
> >>>   obj-y                          +=3D nuvoton/
> >>>   obj-$(CONFIG_PINCTRL_PXA)      +=3D pxa/
> >>>   obj-$(CONFIG_ARCH_QCOM)                +=3D qcom/
> >>> -obj-$(CONFIG_PINCTRL_RALINK)   +=3D ralink/
> >>>   obj-$(CONFIG_PINCTRL_RENESAS)  +=3D renesas/
> >>>   obj-$(CONFIG_PINCTRL_SAMSUNG)  +=3D samsung/
> >>>   obj-$(CONFIG_PINCTRL_SPEAR)    +=3D spear/
> >>> diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/media=
tek/Kconfig
> >>> index a71874fed3d6..2eeb55010563 100644
> >>> --- a/drivers/pinctrl/mediatek/Kconfig
> >>> +++ b/drivers/pinctrl/mediatek/Kconfig
> >>> @@ -1,6 +1,6 @@
> >>>   # SPDX-License-Identifier: GPL-2.0-only
> >>>   menu "MediaTek pinctrl drivers"
> >>> -       depends on ARCH_MEDIATEK || COMPILE_TEST
> >>> +       depends on ARCH_MEDIATEK || RALINK || COMPILE_TEST
> >>>
> >>>   config EINT_MTK
> >>>          tristate "MediaTek External Interrupt Support"
> >>> @@ -22,6 +22,12 @@ config PINCTRL_MTK
> >>>   config PINCTRL_MTK_V2
> >>>          tristate
> >>>
> >>> +config PINCTRL_MTK_MTMIPS
> >>> +       bool
> >>> +       depends on RALINK
> >>> +       select PINMUX
> >>> +       select GENERIC_PINCONF
> >>> +
> >>>   config PINCTRL_MTK_MOORE
> >>>          bool
> >>>          depends on OF
> >>> @@ -43,6 +49,49 @@ config PINCTRL_MTK_PARIS
> >>>          select OF_GPIO
> >>>          select PINCTRL_MTK_V2
> >>>
> >>> +# For MIPS SoCs
> >>> +config PINCTRL_MT7620
> >>> +       bool "MediaTek MT7620 pin control"
> >>> +       depends on SOC_MT7620 || COMPILE_TEST
> >>> +       depends on RALINK
> >>> +       default SOC_MT7620
> >>> +       select PINCTRL_MTK_MTMIPS
> >>> +
> >>> +config PINCTRL_MT7621
> >>> +       bool "MediaTek MT7621 pin control"
> >>> +       depends on SOC_MT7621 || COMPILE_TEST
> >>> +       depends on RALINK
> >>> +       default SOC_MT7621
> >>> +       select PINCTRL_MTK_MTMIPS
> >>> +
> >>> +config PINCTRL_MT76X8
> >>> +       bool "MediaTek MT76X8 pin control"
> >>> +       depends on SOC_MT7620 || COMPILE_TEST
> >>> +       depends on RALINK
> >>> +       default SOC_MT7620
> >>> +       select PINCTRL_MTK_MTMIPS
> >>> +
> >>> +config PINCTRL_RT2880
> >>> +       bool "Ralink RT2880 pin control"
> >>> +       depends on SOC_RT288X || COMPILE_TEST
> >>> +       depends on RALINK
> >>> +       default SOC_RT288X
> >>> +       select PINCTRL_MTK_MTMIPS
> >>> +
> >>> +config PINCTRL_RT305X
> >>> +       bool "Ralink RT305X pin control"
> >>> +       depends on SOC_RT305X || COMPILE_TEST
> >>> +       depends on RALINK
> >>> +       default SOC_RT305X
> >>> +       select PINCTRL_MTK_MTMIPS
> >>> +
> >>> +config PINCTRL_RT3883
> >>> +       bool "Ralink RT3883 pin control"
> >>> +       depends on SOC_RT3883 || COMPILE_TEST
> >>> +       depends on RALINK
> >>> +       default SOC_RT3883
> >>> +       select PINCTRL_MTK_MTMIPS
> >>> +
> >>
> >> I am not a Kconfig expert at all but...
> >>
> >> Should not all of these be depends on SOC_XXX || (COMPILE_TEST &&
> >> RALINK) and avoid the " depends on RALINK" next line in all of them?
>
> This seems to do the same thing but I'm following the "either change
> them all or fit into the crowd" ideology.
>
> >>
> >> Just asking since we have yet arch read and write register operations
> >> in pinctrl common ralink code. Having in this way, when we address
> >> this arch thing  in the next series just removing the "&& RALINK" part
> >> makes the review pretty obvious.
>
> You'd have to change RALINK with OF since we're still depending on that.
> RALINK selects OF by default so it's currently a hidden dependency.
>
> >>
> >> Other than that, changes look good to me.
> >
> > I think "depends on SOC_XXX || (COMPILE_TEST && MIPS)" would work also
> > and might be more accurate for compile testing targets.

Are you sure? SOC_XXX here is already being enabled only if RALINK is
already enabled, right? [0]

>
> This is not OK in both cases. If the driver is dependent on Ralink
> architecture code, choosing any other MIPS platform will make the driver
> available to compile, which will fail.

SOC_XXX is already dependent on RALINK for real uses but the driver is
going to be selected for other MIPS platforms only for COMPILE_TEST
targets. Ideally drivers should be arch agnostic so can be selected
for any single arch build. Now we have arch dependent read and write
calls in the code, so you need the right headers to be properly found
to be able to compile testing. I think MIPS is enough dependency here
to properly find them. But if not, this should be (COMPILE_TEST &&
RALINK)

>
> If the driver is independent of Ralink architecture code, you're
> limiting the driver to be compiled only when a MIPS platform is selected.

So... how are you planning to allow compile testing of the driver in
any single arch when we get rid of all the arch dependent code? If you
make everything dependent on RALINK you cannot.

Maybe I am missing something obvious :)

Thanks,
     Sergio Paracuellos

[0]: https://elixir.bootlin.com/linux/v6.2.1/source/arch/mips/ralink/Kconfi=
g

>
> Ar=C4=B1n=C3=A7
