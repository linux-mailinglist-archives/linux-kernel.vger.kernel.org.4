Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D776A90D3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 07:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjCCGRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 01:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjCCGRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 01:17:35 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DAA33D923;
        Thu,  2 Mar 2023 22:17:31 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id l15-20020a9d7a8f000000b0069447f0db6fso923869otn.4;
        Thu, 02 Mar 2023 22:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677824250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yACy8rWvHo1CLHpfrEMxzk2dSzYlYr2RRSQRQjSMUoM=;
        b=MBSQ894nIDYvBP3sqvnDoVN5ZE77WvfS116Xfabii0KFprH0BuVLaxu5EBiqy2RutO
         U7o7apJ5D6aX+MKkuP3duFkOdT1gKyMqyIHBrcyVuMJRtxxPI6k3FcPclK0R4sTzb/44
         OdiQkQTvtxovWFkaIjNz9E5xT6/GPSQxL3+B9Nmf8S09UhD86+o3lwa2KparnvGO+PZe
         Emib6/U+BYvJV+AcFApQk54ZKW0ge5aMS8HAhCokglvjScLvoBPoIWox0XFuTq3Xsy/0
         SeGXrcspyMGV0EV2QTrab+pJkuY1L3mPTqVZ05zzzHhPprhK/LTfECOHdqjQR6WIbFKM
         zczA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677824250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yACy8rWvHo1CLHpfrEMxzk2dSzYlYr2RRSQRQjSMUoM=;
        b=WAT70oFX3t8Ph4xDcdIUxz4kF9RSoXylcbt2y8vT/CtCI4EpKBRPcIBq18qn6G1ZQk
         EJIyhNUfC6eQ7Sj2pXlTwxCTUPxLeaogKY7QTRuMzjLemEofHY4gsuSqMCGgXHbQq00i
         tQtAkvokyIHrdor94iz5oMoOWN9hV3mTmTwmp7qyqxSrs5TG73Gc0S2KPHT9qsFDZR6C
         VEXQpo7Gqy/jppRY/thY4bpLjus83zxoEPZWpw7sEl3MpIrb382B2rbBu8+0AvjbfTHS
         2fm8PX8QHsbsqt+3L4cDudVpm4+e5deZeD3PkhFQDqZ8CcZHBQKF4bv6jVS9udiax6Xu
         I+Dw==
X-Gm-Message-State: AO0yUKVSa38i4W5sC3vWRIGMOZB3/GN4/Kv2L7yVSzFtFaynY194Wme/
        KAVQtGR8WR0UQViEfGKDFSZSw/u/8b9oaSmEX8/vve9UlFctIQ==
X-Google-Smtp-Source: AK7set89OsqmRj2bLsebNB00h2KDGvPFEri5UxzBHCnMLLdVX6mIl488uCtztelsc+VyKz9czYzBMUJzsL1VuW0X77k=
X-Received: by 2002:a05:6830:26d8:b0:690:e6eb:d8a9 with SMTP id
 m24-20020a05683026d800b00690e6ebd8a9mr89898otu.6.1677824250285; Thu, 02 Mar
 2023 22:17:30 -0800 (PST)
MIME-Version: 1.0
References: <20230303002850.51858-1-arinc.unal@arinc9.com> <20230303002850.51858-6-arinc.unal@arinc9.com>
In-Reply-To: <20230303002850.51858-6-arinc.unal@arinc9.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Fri, 3 Mar 2023 07:17:17 +0100
Message-ID: <CAMhs-H-VGjP32AZc2cuY=Co4iqx8xPtvjr+hMg-haMMFaQzzsg@mail.gmail.com>
Subject: Re: [PATCH 05/20] pinctrl: ralink: move to mediatek as mtmips
To:     arinc9.unal@gmail.com
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
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

On Fri, Mar 3, 2023 at 1:30 AM <arinc9.unal@gmail.com> wrote:
>
> From: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
>
> This platform from Ralink was acquired by MediaTek in 2011. Then, MediaTe=
k
> introduced new SoCs which utilise this platform. Move the driver to
> mediatek pinctrl directory. Rename the ralink core driver to mtmips.
>
> Signed-off-by: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
> ---
>  drivers/pinctrl/Kconfig                       |  1 -
>  drivers/pinctrl/Makefile                      |  1 -
>  drivers/pinctrl/mediatek/Kconfig              | 51 ++++++++++-
>  drivers/pinctrl/mediatek/Makefile             | 63 +++++++------
>  .../{ralink =3D> mediatek}/pinctrl-mt7620.c     | 34 +++----
>  .../{ralink =3D> mediatek}/pinctrl-mt7621.c     | 30 +++----
>  .../{ralink =3D> mediatek}/pinctrl-mt76x8.c     | 60 ++++++-------
>  .../pinctrl-mtmips.c}                         | 90 +++++++++----------
>  .../pinctrl-mtmips.h}                         | 16 ++--
>  .../{ralink =3D> mediatek}/pinctrl-rt2880.c     | 20 ++---
>  .../{ralink =3D> mediatek}/pinctrl-rt305x.c     | 44 ++++-----
>  .../{ralink =3D> mediatek}/pinctrl-rt3883.c     | 28 +++---
>  drivers/pinctrl/ralink/Kconfig                | 40 ---------
>  drivers/pinctrl/ralink/Makefile               |  9 --
>  14 files changed, 246 insertions(+), 241 deletions(-)
>  rename drivers/pinctrl/{ralink =3D> mediatek}/pinctrl-mt7620.c (81%)
>  rename drivers/pinctrl/{ralink =3D> mediatek}/pinctrl-mt7621.c (80%)
>  rename drivers/pinctrl/{ralink =3D> mediatek}/pinctrl-mt76x8.c (81%)
>  rename drivers/pinctrl/{ralink/pinctrl-ralink.c =3D> mediatek/pinctrl-mt=
mips.c} (74%)
>  rename drivers/pinctrl/{ralink/pinctrl-ralink.h =3D> mediatek/pinctrl-mt=
mips.h} (75%)
>  rename drivers/pinctrl/{ralink =3D> mediatek}/pinctrl-rt2880.c (71%)
>  rename drivers/pinctrl/{ralink =3D> mediatek}/pinctrl-rt305x.c (75%)
>  rename drivers/pinctrl/{ralink =3D> mediatek}/pinctrl-rt3883.c (80%)
>  delete mode 100644 drivers/pinctrl/ralink/Kconfig
>  delete mode 100644 drivers/pinctrl/ralink/Makefile
>
> diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
> index dcb53c4a9584..8a6012770640 100644
> --- a/drivers/pinctrl/Kconfig
> +++ b/drivers/pinctrl/Kconfig
> @@ -537,7 +537,6 @@ source "drivers/pinctrl/nomadik/Kconfig"
>  source "drivers/pinctrl/nuvoton/Kconfig"
>  source "drivers/pinctrl/pxa/Kconfig"
>  source "drivers/pinctrl/qcom/Kconfig"
> -source "drivers/pinctrl/ralink/Kconfig"
>  source "drivers/pinctrl/renesas/Kconfig"
>  source "drivers/pinctrl/samsung/Kconfig"
>  source "drivers/pinctrl/spear/Kconfig"
> diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
> index d5939840bb2a..ada6ed1d4e91 100644
> --- a/drivers/pinctrl/Makefile
> +++ b/drivers/pinctrl/Makefile
> @@ -66,7 +66,6 @@ obj-y                         +=3D nomadik/
>  obj-y                          +=3D nuvoton/
>  obj-$(CONFIG_PINCTRL_PXA)      +=3D pxa/
>  obj-$(CONFIG_ARCH_QCOM)                +=3D qcom/
> -obj-$(CONFIG_PINCTRL_RALINK)   +=3D ralink/
>  obj-$(CONFIG_PINCTRL_RENESAS)  +=3D renesas/
>  obj-$(CONFIG_PINCTRL_SAMSUNG)  +=3D samsung/
>  obj-$(CONFIG_PINCTRL_SPEAR)    +=3D spear/
> diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/=
Kconfig
> index a71874fed3d6..2eeb55010563 100644
> --- a/drivers/pinctrl/mediatek/Kconfig
> +++ b/drivers/pinctrl/mediatek/Kconfig
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  menu "MediaTek pinctrl drivers"
> -       depends on ARCH_MEDIATEK || COMPILE_TEST
> +       depends on ARCH_MEDIATEK || RALINK || COMPILE_TEST
>
>  config EINT_MTK
>         tristate "MediaTek External Interrupt Support"
> @@ -22,6 +22,12 @@ config PINCTRL_MTK
>  config PINCTRL_MTK_V2
>         tristate
>
> +config PINCTRL_MTK_MTMIPS
> +       bool
> +       depends on RALINK
> +       select PINMUX
> +       select GENERIC_PINCONF
> +
>  config PINCTRL_MTK_MOORE
>         bool
>         depends on OF
> @@ -43,6 +49,49 @@ config PINCTRL_MTK_PARIS
>         select OF_GPIO
>         select PINCTRL_MTK_V2
>
> +# For MIPS SoCs
> +config PINCTRL_MT7620
> +       bool "MediaTek MT7620 pin control"
> +       depends on SOC_MT7620 || COMPILE_TEST
> +       depends on RALINK
> +       default SOC_MT7620
> +       select PINCTRL_MTK_MTMIPS
> +
> +config PINCTRL_MT7621
> +       bool "MediaTek MT7621 pin control"
> +       depends on SOC_MT7621 || COMPILE_TEST
> +       depends on RALINK
> +       default SOC_MT7621
> +       select PINCTRL_MTK_MTMIPS
> +
> +config PINCTRL_MT76X8
> +       bool "MediaTek MT76X8 pin control"
> +       depends on SOC_MT7620 || COMPILE_TEST
> +       depends on RALINK
> +       default SOC_MT7620
> +       select PINCTRL_MTK_MTMIPS
> +
> +config PINCTRL_RT2880
> +       bool "Ralink RT2880 pin control"
> +       depends on SOC_RT288X || COMPILE_TEST
> +       depends on RALINK
> +       default SOC_RT288X
> +       select PINCTRL_MTK_MTMIPS
> +
> +config PINCTRL_RT305X
> +       bool "Ralink RT305X pin control"
> +       depends on SOC_RT305X || COMPILE_TEST
> +       depends on RALINK
> +       default SOC_RT305X
> +       select PINCTRL_MTK_MTMIPS
> +
> +config PINCTRL_RT3883
> +       bool "Ralink RT3883 pin control"
> +       depends on SOC_RT3883 || COMPILE_TEST
> +       depends on RALINK
> +       default SOC_RT3883
> +       select PINCTRL_MTK_MTMIPS
> +

I am not a Kconfig expert at all but...

Should not all of these be depends on SOC_XXX || (COMPILE_TEST &&
RALINK) and avoid the " depends on RALINK" next line in all of them?

Just asking since we have yet arch read and write register operations
in pinctrl common ralink code. Having in this way, when we address
this arch thing  in the next series just removing the "&& RALINK" part
makes the review pretty obvious.

Other than that, changes look good to me.


>  # For ARMv7 SoCs
>  config PINCTRL_MT2701
>         bool "MediaTek MT2701 pin control"
> diff --git a/drivers/pinctrl/mediatek/Makefile b/drivers/pinctrl/mediatek=
/Makefile
> index 44d197af516a..680f7e8526e0 100644
> --- a/drivers/pinctrl/mediatek/Makefile
> +++ b/drivers/pinctrl/mediatek/Makefile
> @@ -1,32 +1,39 @@
>  # SPDX-License-Identifier: GPL-2.0
>  # Core
> -obj-$(CONFIG_EINT_MTK)         +=3D mtk-eint.o
> -obj-$(CONFIG_PINCTRL_MTK)      +=3D pinctrl-mtk-common.o
> -obj-$(CONFIG_PINCTRL_MTK_V2)   +=3D pinctrl-mtk-common-v2.o
> -obj-$(CONFIG_PINCTRL_MTK_MOORE) +=3D pinctrl-moore.o
> -obj-$(CONFIG_PINCTRL_MTK_PARIS) +=3D pinctrl-paris.o
> +obj-$(CONFIG_EINT_MTK)                 +=3D mtk-eint.o
> +obj-$(CONFIG_PINCTRL_MTK)              +=3D pinctrl-mtk-common.o
> +obj-$(CONFIG_PINCTRL_MTK_V2)           +=3D pinctrl-mtk-common-v2.o
> +obj-$(CONFIG_PINCTRL_MTK_MTMIPS)       +=3D pinctrl-mtmips.o
> +obj-$(CONFIG_PINCTRL_MTK_MOORE)                +=3D pinctrl-moore.o
> +obj-$(CONFIG_PINCTRL_MTK_PARIS)                +=3D pinctrl-paris.o
>
>  # SoC Drivers
> -obj-$(CONFIG_PINCTRL_MT2701)   +=3D pinctrl-mt2701.o
> -obj-$(CONFIG_PINCTRL_MT2712)   +=3D pinctrl-mt2712.o
> -obj-$(CONFIG_PINCTRL_MT8135)   +=3D pinctrl-mt8135.o
> -obj-$(CONFIG_PINCTRL_MT8127)   +=3D pinctrl-mt8127.o
> -obj-$(CONFIG_PINCTRL_MT6765)   +=3D pinctrl-mt6765.o
> -obj-$(CONFIG_PINCTRL_MT6779)   +=3D pinctrl-mt6779.o
> -obj-$(CONFIG_PINCTRL_MT6795)   +=3D pinctrl-mt6795.o
> -obj-$(CONFIG_PINCTRL_MT6797)   +=3D pinctrl-mt6797.o
> -obj-$(CONFIG_PINCTRL_MT7622)   +=3D pinctrl-mt7622.o
> -obj-$(CONFIG_PINCTRL_MT7623)   +=3D pinctrl-mt7623.o
> -obj-$(CONFIG_PINCTRL_MT7629)   +=3D pinctrl-mt7629.o
> -obj-$(CONFIG_PINCTRL_MT7981)   +=3D pinctrl-mt7981.o
> -obj-$(CONFIG_PINCTRL_MT7986)   +=3D pinctrl-mt7986.o
> -obj-$(CONFIG_PINCTRL_MT8167)   +=3D pinctrl-mt8167.o
> -obj-$(CONFIG_PINCTRL_MT8173)   +=3D pinctrl-mt8173.o
> -obj-$(CONFIG_PINCTRL_MT8183)   +=3D pinctrl-mt8183.o
> -obj-$(CONFIG_PINCTRL_MT8186)   +=3D pinctrl-mt8186.o
> -obj-$(CONFIG_PINCTRL_MT8188)   +=3D pinctrl-mt8188.o
> -obj-$(CONFIG_PINCTRL_MT8192)   +=3D pinctrl-mt8192.o
> -obj-$(CONFIG_PINCTRL_MT8195)    +=3D pinctrl-mt8195.o
> -obj-$(CONFIG_PINCTRL_MT8365)   +=3D pinctrl-mt8365.o
> -obj-$(CONFIG_PINCTRL_MT8516)   +=3D pinctrl-mt8516.o
> -obj-$(CONFIG_PINCTRL_MT6397)   +=3D pinctrl-mt6397.o
> +obj-$(CONFIG_PINCTRL_MT7620)           +=3D pinctrl-mt7620.o
> +obj-$(CONFIG_PINCTRL_MT7621)           +=3D pinctrl-mt7621.o
> +obj-$(CONFIG_PINCTRL_MT76X8)           +=3D pinctrl-mt76x8.o
> +obj-$(CONFIG_PINCTRL_RT2880)           +=3D pinctrl-rt2880.o
> +obj-$(CONFIG_PINCTRL_RT305X)           +=3D pinctrl-rt305x.o
> +obj-$(CONFIG_PINCTRL_RT3883)           +=3D pinctrl-rt3883.o
> +obj-$(CONFIG_PINCTRL_MT2701)           +=3D pinctrl-mt2701.o
> +obj-$(CONFIG_PINCTRL_MT2712)           +=3D pinctrl-mt2712.o
> +obj-$(CONFIG_PINCTRL_MT8135)           +=3D pinctrl-mt8135.o
> +obj-$(CONFIG_PINCTRL_MT8127)           +=3D pinctrl-mt8127.o
> +obj-$(CONFIG_PINCTRL_MT6765)           +=3D pinctrl-mt6765.o
> +obj-$(CONFIG_PINCTRL_MT6779)           +=3D pinctrl-mt6779.o
> +obj-$(CONFIG_PINCTRL_MT6795)           +=3D pinctrl-mt6795.o
> +obj-$(CONFIG_PINCTRL_MT6797)           +=3D pinctrl-mt6797.o
> +obj-$(CONFIG_PINCTRL_MT7622)           +=3D pinctrl-mt7622.o
> +obj-$(CONFIG_PINCTRL_MT7623)           +=3D pinctrl-mt7623.o
> +obj-$(CONFIG_PINCTRL_MT7629)           +=3D pinctrl-mt7629.o
> +obj-$(CONFIG_PINCTRL_MT7981)           +=3D pinctrl-mt7981.o
> +obj-$(CONFIG_PINCTRL_MT7986)           +=3D pinctrl-mt7986.o
> +obj-$(CONFIG_PINCTRL_MT8167)           +=3D pinctrl-mt8167.o
> +obj-$(CONFIG_PINCTRL_MT8173)           +=3D pinctrl-mt8173.o
> +obj-$(CONFIG_PINCTRL_MT8183)           +=3D pinctrl-mt8183.o
> +obj-$(CONFIG_PINCTRL_MT8186)           +=3D pinctrl-mt8186.o
> +obj-$(CONFIG_PINCTRL_MT8188)           +=3D pinctrl-mt8188.o
> +obj-$(CONFIG_PINCTRL_MT8192)           +=3D pinctrl-mt8192.o
> +obj-$(CONFIG_PINCTRL_MT8195)           +=3D pinctrl-mt8195.o
> +obj-$(CONFIG_PINCTRL_MT8365)           +=3D pinctrl-mt8365.o
> +obj-$(CONFIG_PINCTRL_MT8516)           +=3D pinctrl-mt8516.o
> +obj-$(CONFIG_PINCTRL_MT6397)           +=3D pinctrl-mt6397.o
> diff --git a/drivers/pinctrl/ralink/pinctrl-mt7620.c b/drivers/pinctrl/me=
diatek/pinctrl-mt7620.c
> similarity index 81%
> rename from drivers/pinctrl/ralink/pinctrl-mt7620.c
> rename to drivers/pinctrl/mediatek/pinctrl-mt7620.c
> index b2245fd65c72..1a2dbbdd25f1 100644
> --- a/drivers/pinctrl/ralink/pinctrl-mt7620.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-mt7620.c
> @@ -3,7 +3,7 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/of.h>
> -#include "pinctrl-ralink.h"
> +#include "pinctrl-mtmips.h"
>
>  #define MT7620_GPIO_MODE_UART0_SHIFT   2
>  #define MT7620_GPIO_MODE_UART0_MASK    0x7
> @@ -52,20 +52,20 @@
>  #define MT7620_GPIO_MODE_EPHY          15
>  #define MT7620_GPIO_MODE_PA            20
>
> -static struct ralink_pmx_func i2c_grp[] =3D  { FUNC("i2c", 0, 1, 2) };
> -static struct ralink_pmx_func spi_grp[] =3D { FUNC("spi", 0, 3, 4) };
> -static struct ralink_pmx_func uartlite_grp[] =3D { FUNC("uartlite", 0, 1=
5, 2) };
> -static struct ralink_pmx_func mdio_grp[] =3D {
> +static struct mtmips_pmx_func i2c_grp[] =3D  { FUNC("i2c", 0, 1, 2) };
> +static struct mtmips_pmx_func spi_grp[] =3D { FUNC("spi", 0, 3, 4) };
> +static struct mtmips_pmx_func uartlite_grp[] =3D { FUNC("uartlite", 0, 1=
5, 2) };
> +static struct mtmips_pmx_func mdio_grp[] =3D {
>         FUNC("mdio", MT7620_GPIO_MODE_MDIO, 22, 2),
>         FUNC("refclk", MT7620_GPIO_MODE_MDIO_REFCLK, 22, 2),
>  };
> -static struct ralink_pmx_func rgmii1_grp[] =3D { FUNC("rgmii1", 0, 24, 1=
2) };
> -static struct ralink_pmx_func refclk_grp[] =3D { FUNC("spi refclk", 0, 3=
7, 3) };
> -static struct ralink_pmx_func ephy_grp[] =3D { FUNC("ephy", 0, 40, 5) };
> -static struct ralink_pmx_func rgmii2_grp[] =3D { FUNC("rgmii2", 0, 60, 1=
2) };
> -static struct ralink_pmx_func wled_grp[] =3D { FUNC("wled", 0, 72, 1) };
> -static struct ralink_pmx_func pa_grp[] =3D { FUNC("pa", 0, 18, 4) };
> -static struct ralink_pmx_func uartf_grp[] =3D {
> +static struct mtmips_pmx_func rgmii1_grp[] =3D { FUNC("rgmii1", 0, 24, 1=
2) };
> +static struct mtmips_pmx_func refclk_grp[] =3D { FUNC("spi refclk", 0, 3=
7, 3) };
> +static struct mtmips_pmx_func ephy_grp[] =3D { FUNC("ephy", 0, 40, 5) };
> +static struct mtmips_pmx_func rgmii2_grp[] =3D { FUNC("rgmii2", 0, 60, 1=
2) };
> +static struct mtmips_pmx_func wled_grp[] =3D { FUNC("wled", 0, 72, 1) };
> +static struct mtmips_pmx_func pa_grp[] =3D { FUNC("pa", 0, 18, 4) };
> +static struct mtmips_pmx_func uartf_grp[] =3D {
>         FUNC("uartf", MT7620_GPIO_MODE_UARTF, 7, 8),
>         FUNC("pcm uartf", MT7620_GPIO_MODE_PCM_UARTF, 7, 8),
>         FUNC("pcm i2s", MT7620_GPIO_MODE_PCM_I2S, 7, 8),
> @@ -74,20 +74,20 @@ static struct ralink_pmx_func uartf_grp[] =3D {
>         FUNC("gpio uartf", MT7620_GPIO_MODE_GPIO_UARTF, 7, 4),
>         FUNC("gpio i2s", MT7620_GPIO_MODE_GPIO_I2S, 7, 4),
>  };
> -static struct ralink_pmx_func wdt_grp[] =3D {
> +static struct mtmips_pmx_func wdt_grp[] =3D {
>         FUNC("wdt rst", 0, 17, 1),
>         FUNC("wdt refclk", 0, 17, 1),
>         };
> -static struct ralink_pmx_func pcie_rst_grp[] =3D {
> +static struct mtmips_pmx_func pcie_rst_grp[] =3D {
>         FUNC("pcie rst", MT7620_GPIO_MODE_PCIE_RST, 36, 1),
>         FUNC("pcie refclk", MT7620_GPIO_MODE_PCIE_REF, 36, 1)
>  };
> -static struct ralink_pmx_func nd_sd_grp[] =3D {
> +static struct mtmips_pmx_func nd_sd_grp[] =3D {
>         FUNC("nand", MT7620_GPIO_MODE_NAND, 45, 15),
>         FUNC("sd", MT7620_GPIO_MODE_SD, 47, 13)
>  };
>
> -static struct ralink_pmx_group mt7620a_pinmux_data[] =3D {
> +static struct mtmips_pmx_group mt7620a_pinmux_data[] =3D {
>         GRP("i2c", i2c_grp, 1, MT7620_GPIO_MODE_I2C),
>         GRP("uartf", uartf_grp, MT7620_GPIO_MODE_UART0_MASK,
>                 MT7620_GPIO_MODE_UART0_SHIFT),
> @@ -112,7 +112,7 @@ static struct ralink_pmx_group mt7620a_pinmux_data[] =
=3D {
>
>  static int mt7620_pinctrl_probe(struct platform_device *pdev)
>  {
> -       return ralink_pinctrl_init(pdev, mt7620a_pinmux_data);
> +       return mtmips_pinctrl_init(pdev, mt7620a_pinmux_data);
>  }
>
>  static const struct of_device_id mt7620_pinctrl_match[] =3D {
> diff --git a/drivers/pinctrl/ralink/pinctrl-mt7621.c b/drivers/pinctrl/me=
diatek/pinctrl-mt7621.c
> similarity index 80%
> rename from drivers/pinctrl/ralink/pinctrl-mt7621.c
> rename to drivers/pinctrl/mediatek/pinctrl-mt7621.c
> index 2128a94f6d1b..96c5ef942cf4 100644
> --- a/drivers/pinctrl/ralink/pinctrl-mt7621.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-mt7621.c
> @@ -3,7 +3,7 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/of.h>
> -#include "pinctrl-ralink.h"
> +#include "pinctrl-mtmips.h"
>
>  #define MT7621_GPIO_MODE_UART1         1
>  #define MT7621_GPIO_MODE_I2C           2
> @@ -34,40 +34,40 @@
>  #define MT7621_GPIO_MODE_SDHCI_SHIFT   18
>  #define MT7621_GPIO_MODE_SDHCI_GPIO    1
>
> -static struct ralink_pmx_func uart1_grp[] =3D  { FUNC("uart1", 0, 1, 2) =
};
> -static struct ralink_pmx_func i2c_grp[] =3D  { FUNC("i2c", 0, 3, 2) };
> -static struct ralink_pmx_func uart3_grp[] =3D {
> +static struct mtmips_pmx_func uart1_grp[] =3D  { FUNC("uart1", 0, 1, 2) =
};
> +static struct mtmips_pmx_func i2c_grp[] =3D  { FUNC("i2c", 0, 3, 2) };
> +static struct mtmips_pmx_func uart3_grp[] =3D {
>         FUNC("uart3", 0, 5, 4),
>         FUNC("i2s", 2, 5, 4),
>         FUNC("spdif3", 3, 5, 4),
>  };
> -static struct ralink_pmx_func uart2_grp[] =3D {
> +static struct mtmips_pmx_func uart2_grp[] =3D {
>         FUNC("uart2", 0, 9, 4),
>         FUNC("pcm", 2, 9, 4),
>         FUNC("spdif2", 3, 9, 4),
>  };
> -static struct ralink_pmx_func jtag_grp[] =3D { FUNC("jtag", 0, 13, 5) };
> -static struct ralink_pmx_func wdt_grp[] =3D {
> +static struct mtmips_pmx_func jtag_grp[] =3D { FUNC("jtag", 0, 13, 5) };
> +static struct mtmips_pmx_func wdt_grp[] =3D {
>         FUNC("wdt rst", 0, 18, 1),
>         FUNC("wdt refclk", 2, 18, 1),
>  };
> -static struct ralink_pmx_func pcie_rst_grp[] =3D {
> +static struct mtmips_pmx_func pcie_rst_grp[] =3D {
>         FUNC("pcie rst", MT7621_GPIO_MODE_PCIE_RST, 19, 1),
>         FUNC("pcie refclk", MT7621_GPIO_MODE_PCIE_REF, 19, 1)
>  };
> -static struct ralink_pmx_func mdio_grp[] =3D { FUNC("mdio", 0, 20, 2) };
> -static struct ralink_pmx_func rgmii2_grp[] =3D { FUNC("rgmii2", 0, 22, 1=
2) };
> -static struct ralink_pmx_func spi_grp[] =3D {
> +static struct mtmips_pmx_func mdio_grp[] =3D { FUNC("mdio", 0, 20, 2) };
> +static struct mtmips_pmx_func rgmii2_grp[] =3D { FUNC("rgmii2", 0, 22, 1=
2) };
> +static struct mtmips_pmx_func spi_grp[] =3D {
>         FUNC("spi", 0, 34, 7),
>         FUNC("nand1", 2, 34, 7),
>  };
> -static struct ralink_pmx_func sdhci_grp[] =3D {
> +static struct mtmips_pmx_func sdhci_grp[] =3D {
>         FUNC("sdhci", 0, 41, 8),
>         FUNC("nand2", 2, 41, 8),
>  };
> -static struct ralink_pmx_func rgmii1_grp[] =3D { FUNC("rgmii1", 0, 49, 1=
2) };
> +static struct mtmips_pmx_func rgmii1_grp[] =3D { FUNC("rgmii1", 0, 49, 1=
2) };
>
> -static struct ralink_pmx_group mt7621_pinmux_data[] =3D {
> +static struct mtmips_pmx_group mt7621_pinmux_data[] =3D {
>         GRP("uart1", uart1_grp, 1, MT7621_GPIO_MODE_UART1),
>         GRP("i2c", i2c_grp, 1, MT7621_GPIO_MODE_I2C),
>         GRP_G("uart3", uart3_grp, MT7621_GPIO_MODE_UART3_MASK,
> @@ -92,7 +92,7 @@ static struct ralink_pmx_group mt7621_pinmux_data[] =3D=
 {
>
>  static int mt7621_pinctrl_probe(struct platform_device *pdev)
>  {
> -       return ralink_pinctrl_init(pdev, mt7621_pinmux_data);
> +       return mtmips_pinctrl_init(pdev, mt7621_pinmux_data);
>  }
>
>  static const struct of_device_id mt7621_pinctrl_match[] =3D {
> diff --git a/drivers/pinctrl/ralink/pinctrl-mt76x8.c b/drivers/pinctrl/me=
diatek/pinctrl-mt76x8.c
> similarity index 81%
> rename from drivers/pinctrl/ralink/pinctrl-mt76x8.c
> rename to drivers/pinctrl/mediatek/pinctrl-mt76x8.c
> index 5a6a82a58180..1d463bcfb1bd 100644
> --- a/drivers/pinctrl/ralink/pinctrl-mt76x8.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-mt76x8.c
> @@ -3,7 +3,7 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/of.h>
> -#include "pinctrl-ralink.h"
> +#include "pinctrl-mtmips.h"
>
>  #define MT76X8_GPIO_MODE_MASK          0x3
>
> @@ -35,173 +35,173 @@
>  #define MT76X8_GPIO_MODE_SPIS          2
>  #define MT76X8_GPIO_MODE_GPIO          0
>
> -static struct ralink_pmx_func pwm1_grp[] =3D {
> +static struct mtmips_pmx_func pwm1_grp[] =3D {
>         FUNC("sdxc d6", 3, 19, 1),
>         FUNC("utif", 2, 19, 1),
>         FUNC("gpio", 1, 19, 1),
>         FUNC("pwm1", 0, 19, 1),
>  };
>
> -static struct ralink_pmx_func pwm0_grp[] =3D {
> +static struct mtmips_pmx_func pwm0_grp[] =3D {
>         FUNC("sdxc d7", 3, 18, 1),
>         FUNC("utif", 2, 18, 1),
>         FUNC("gpio", 1, 18, 1),
>         FUNC("pwm0", 0, 18, 1),
>  };
>
> -static struct ralink_pmx_func uart2_grp[] =3D {
> +static struct mtmips_pmx_func uart2_grp[] =3D {
>         FUNC("sdxc d5 d4", 3, 20, 2),
>         FUNC("pwm", 2, 20, 2),
>         FUNC("gpio", 1, 20, 2),
>         FUNC("uart2", 0, 20, 2),
>  };
>
> -static struct ralink_pmx_func uart1_grp[] =3D {
> +static struct mtmips_pmx_func uart1_grp[] =3D {
>         FUNC("sw_r", 3, 45, 2),
>         FUNC("pwm", 2, 45, 2),
>         FUNC("gpio", 1, 45, 2),
>         FUNC("uart1", 0, 45, 2),
>  };
>
> -static struct ralink_pmx_func i2c_grp[] =3D {
> +static struct mtmips_pmx_func i2c_grp[] =3D {
>         FUNC("-", 3, 4, 2),
>         FUNC("debug", 2, 4, 2),
>         FUNC("gpio", 1, 4, 2),
>         FUNC("i2c", 0, 4, 2),
>  };
>
> -static struct ralink_pmx_func refclk_grp[] =3D { FUNC("refclk", 0, 37, 1=
) };
> -static struct ralink_pmx_func perst_grp[] =3D { FUNC("perst", 0, 36, 1) =
};
> -static struct ralink_pmx_func wdt_grp[] =3D { FUNC("wdt", 0, 38, 1) };
> -static struct ralink_pmx_func spi_grp[] =3D { FUNC("spi", 0, 7, 4) };
> +static struct mtmips_pmx_func refclk_grp[] =3D { FUNC("refclk", 0, 37, 1=
) };
> +static struct mtmips_pmx_func perst_grp[] =3D { FUNC("perst", 0, 36, 1) =
};
> +static struct mtmips_pmx_func wdt_grp[] =3D { FUNC("wdt", 0, 38, 1) };
> +static struct mtmips_pmx_func spi_grp[] =3D { FUNC("spi", 0, 7, 4) };
>
> -static struct ralink_pmx_func sd_mode_grp[] =3D {
> +static struct mtmips_pmx_func sd_mode_grp[] =3D {
>         FUNC("jtag", 3, 22, 8),
>         FUNC("utif", 2, 22, 8),
>         FUNC("gpio", 1, 22, 8),
>         FUNC("sdxc", 0, 22, 8),
>  };
>
> -static struct ralink_pmx_func uart0_grp[] =3D {
> +static struct mtmips_pmx_func uart0_grp[] =3D {
>         FUNC("-", 3, 12, 2),
>         FUNC("-", 2, 12, 2),
>         FUNC("gpio", 1, 12, 2),
>         FUNC("uart0", 0, 12, 2),
>  };
>
> -static struct ralink_pmx_func i2s_grp[] =3D {
> +static struct mtmips_pmx_func i2s_grp[] =3D {
>         FUNC("antenna", 3, 0, 4),
>         FUNC("pcm", 2, 0, 4),
>         FUNC("gpio", 1, 0, 4),
>         FUNC("i2s", 0, 0, 4),
>  };
>
> -static struct ralink_pmx_func spi_cs1_grp[] =3D {
> +static struct mtmips_pmx_func spi_cs1_grp[] =3D {
>         FUNC("-", 3, 6, 1),
>         FUNC("refclk", 2, 6, 1),
>         FUNC("gpio", 1, 6, 1),
>         FUNC("spi cs1", 0, 6, 1),
>  };
>
> -static struct ralink_pmx_func spis_grp[] =3D {
> +static struct mtmips_pmx_func spis_grp[] =3D {
>         FUNC("pwm_uart2", 3, 14, 4),
>         FUNC("utif", 2, 14, 4),
>         FUNC("gpio", 1, 14, 4),
>         FUNC("spis", 0, 14, 4),
>  };
>
> -static struct ralink_pmx_func gpio_grp[] =3D {
> +static struct mtmips_pmx_func gpio_grp[] =3D {
>         FUNC("pcie", 3, 11, 1),
>         FUNC("refclk", 2, 11, 1),
>         FUNC("gpio", 1, 11, 1),
>         FUNC("gpio", 0, 11, 1),
>  };
>
> -static struct ralink_pmx_func p4led_kn_grp[] =3D {
> +static struct mtmips_pmx_func p4led_kn_grp[] =3D {
>         FUNC("jtag", 3, 30, 1),
>         FUNC("utif", 2, 30, 1),
>         FUNC("gpio", 1, 30, 1),
>         FUNC("p4led_kn", 0, 30, 1),
>  };
>
> -static struct ralink_pmx_func p3led_kn_grp[] =3D {
> +static struct mtmips_pmx_func p3led_kn_grp[] =3D {
>         FUNC("jtag", 3, 31, 1),
>         FUNC("utif", 2, 31, 1),
>         FUNC("gpio", 1, 31, 1),
>         FUNC("p3led_kn", 0, 31, 1),
>  };
>
> -static struct ralink_pmx_func p2led_kn_grp[] =3D {
> +static struct mtmips_pmx_func p2led_kn_grp[] =3D {
>         FUNC("jtag", 3, 32, 1),
>         FUNC("utif", 2, 32, 1),
>         FUNC("gpio", 1, 32, 1),
>         FUNC("p2led_kn", 0, 32, 1),
>  };
>
> -static struct ralink_pmx_func p1led_kn_grp[] =3D {
> +static struct mtmips_pmx_func p1led_kn_grp[] =3D {
>         FUNC("jtag", 3, 33, 1),
>         FUNC("utif", 2, 33, 1),
>         FUNC("gpio", 1, 33, 1),
>         FUNC("p1led_kn", 0, 33, 1),
>  };
>
> -static struct ralink_pmx_func p0led_kn_grp[] =3D {
> +static struct mtmips_pmx_func p0led_kn_grp[] =3D {
>         FUNC("jtag", 3, 34, 1),
>         FUNC("rsvd", 2, 34, 1),
>         FUNC("gpio", 1, 34, 1),
>         FUNC("p0led_kn", 0, 34, 1),
>  };
>
> -static struct ralink_pmx_func wled_kn_grp[] =3D {
> +static struct mtmips_pmx_func wled_kn_grp[] =3D {
>         FUNC("rsvd", 3, 35, 1),
>         FUNC("rsvd", 2, 35, 1),
>         FUNC("gpio", 1, 35, 1),
>         FUNC("wled_kn", 0, 35, 1),
>  };
>
> -static struct ralink_pmx_func p4led_an_grp[] =3D {
> +static struct mtmips_pmx_func p4led_an_grp[] =3D {
>         FUNC("jtag", 3, 39, 1),
>         FUNC("utif", 2, 39, 1),
>         FUNC("gpio", 1, 39, 1),
>         FUNC("p4led_an", 0, 39, 1),
>  };
>
> -static struct ralink_pmx_func p3led_an_grp[] =3D {
> +static struct mtmips_pmx_func p3led_an_grp[] =3D {
>         FUNC("jtag", 3, 40, 1),
>         FUNC("utif", 2, 40, 1),
>         FUNC("gpio", 1, 40, 1),
>         FUNC("p3led_an", 0, 40, 1),
>  };
>
> -static struct ralink_pmx_func p2led_an_grp[] =3D {
> +static struct mtmips_pmx_func p2led_an_grp[] =3D {
>         FUNC("jtag", 3, 41, 1),
>         FUNC("utif", 2, 41, 1),
>         FUNC("gpio", 1, 41, 1),
>         FUNC("p2led_an", 0, 41, 1),
>  };
>
> -static struct ralink_pmx_func p1led_an_grp[] =3D {
> +static struct mtmips_pmx_func p1led_an_grp[] =3D {
>         FUNC("jtag", 3, 42, 1),
>         FUNC("utif", 2, 42, 1),
>         FUNC("gpio", 1, 42, 1),
>         FUNC("p1led_an", 0, 42, 1),
>  };
>
> -static struct ralink_pmx_func p0led_an_grp[] =3D {
> +static struct mtmips_pmx_func p0led_an_grp[] =3D {
>         FUNC("jtag", 3, 43, 1),
>         FUNC("rsvd", 2, 43, 1),
>         FUNC("gpio", 1, 43, 1),
>         FUNC("p0led_an", 0, 43, 1),
>  };
>
> -static struct ralink_pmx_func wled_an_grp[] =3D {
> +static struct mtmips_pmx_func wled_an_grp[] =3D {
>         FUNC("rsvd", 3, 44, 1),
>         FUNC("rsvd", 2, 44, 1),
>         FUNC("gpio", 1, 44, 1),
>         FUNC("wled_an", 0, 44, 1),
>  };
>
> -static struct ralink_pmx_group mt76x8_pinmux_data[] =3D {
> +static struct mtmips_pmx_group mt76x8_pinmux_data[] =3D {
>         GRP_G("pwm1", pwm1_grp, MT76X8_GPIO_MODE_MASK,
>                                 1, MT76X8_GPIO_MODE_PWM1),
>         GRP_G("pwm0", pwm0_grp, MT76X8_GPIO_MODE_MASK,
> @@ -257,7 +257,7 @@ static struct ralink_pmx_group mt76x8_pinmux_data[] =
=3D {
>
>  static int mt76x8_pinctrl_probe(struct platform_device *pdev)
>  {
> -       return ralink_pinctrl_init(pdev, mt76x8_pinmux_data);
> +       return mtmips_pinctrl_init(pdev, mt76x8_pinmux_data);
>  }
>
>  static const struct of_device_id mt76x8_pinctrl_match[] =3D {
> diff --git a/drivers/pinctrl/ralink/pinctrl-ralink.c b/drivers/pinctrl/me=
diatek/pinctrl-mtmips.c
> similarity index 74%
> rename from drivers/pinctrl/ralink/pinctrl-ralink.c
> rename to drivers/pinctrl/mediatek/pinctrl-mtmips.c
> index 770862f45b3f..efd77b6c56a1 100644
> --- a/drivers/pinctrl/ralink/pinctrl-ralink.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-mtmips.c
> @@ -19,23 +19,23 @@
>  #include <asm/mach-ralink/ralink_regs.h>
>  #include <asm/mach-ralink/mt7620.h>
>
> -#include "pinctrl-ralink.h"
> +#include "pinctrl-mtmips.h"
>  #include "../core.h"
>  #include "../pinctrl-utils.h"
>
>  #define SYSC_REG_GPIO_MODE     0x60
>  #define SYSC_REG_GPIO_MODE2    0x64
>
> -struct ralink_priv {
> +struct mtmips_priv {
>         struct device *dev;
>
>         struct pinctrl_pin_desc *pads;
>         struct pinctrl_desc *desc;
>
> -       struct ralink_pmx_func **func;
> +       struct mtmips_pmx_func **func;
>         int func_count;
>
> -       struct ralink_pmx_group *groups;
> +       struct mtmips_pmx_group *groups;
>         const char **group_names;
>         int group_count;
>
> @@ -43,27 +43,27 @@ struct ralink_priv {
>         int max_pins;
>  };
>
> -static int ralink_get_group_count(struct pinctrl_dev *pctrldev)
> +static int mtmips_get_group_count(struct pinctrl_dev *pctrldev)
>  {
> -       struct ralink_priv *p =3D pinctrl_dev_get_drvdata(pctrldev);
> +       struct mtmips_priv *p =3D pinctrl_dev_get_drvdata(pctrldev);
>
>         return p->group_count;
>  }
>
> -static const char *ralink_get_group_name(struct pinctrl_dev *pctrldev,
> +static const char *mtmips_get_group_name(struct pinctrl_dev *pctrldev,
>                                          unsigned int group)
>  {
> -       struct ralink_priv *p =3D pinctrl_dev_get_drvdata(pctrldev);
> +       struct mtmips_priv *p =3D pinctrl_dev_get_drvdata(pctrldev);
>
>         return (group >=3D p->group_count) ? NULL : p->group_names[group]=
;
>  }
>
> -static int ralink_get_group_pins(struct pinctrl_dev *pctrldev,
> +static int mtmips_get_group_pins(struct pinctrl_dev *pctrldev,
>                                  unsigned int group,
>                                  const unsigned int **pins,
>                                  unsigned int *num_pins)
>  {
> -       struct ralink_priv *p =3D pinctrl_dev_get_drvdata(pctrldev);
> +       struct mtmips_priv *p =3D pinctrl_dev_get_drvdata(pctrldev);
>
>         if (group >=3D p->group_count)
>                 return -EINVAL;
> @@ -74,35 +74,35 @@ static int ralink_get_group_pins(struct pinctrl_dev *=
pctrldev,
>         return 0;
>  }
>
> -static const struct pinctrl_ops ralink_pctrl_ops =3D {
> -       .get_groups_count       =3D ralink_get_group_count,
> -       .get_group_name         =3D ralink_get_group_name,
> -       .get_group_pins         =3D ralink_get_group_pins,
> +static const struct pinctrl_ops mtmips_pctrl_ops =3D {
> +       .get_groups_count       =3D mtmips_get_group_count,
> +       .get_group_name         =3D mtmips_get_group_name,
> +       .get_group_pins         =3D mtmips_get_group_pins,
>         .dt_node_to_map         =3D pinconf_generic_dt_node_to_map_all,
>         .dt_free_map            =3D pinconf_generic_dt_free_map,
>  };
>
> -static int ralink_pmx_func_count(struct pinctrl_dev *pctrldev)
> +static int mtmips_pmx_func_count(struct pinctrl_dev *pctrldev)
>  {
> -       struct ralink_priv *p =3D pinctrl_dev_get_drvdata(pctrldev);
> +       struct mtmips_priv *p =3D pinctrl_dev_get_drvdata(pctrldev);
>
>         return p->func_count;
>  }
>
> -static const char *ralink_pmx_func_name(struct pinctrl_dev *pctrldev,
> +static const char *mtmips_pmx_func_name(struct pinctrl_dev *pctrldev,
>                                         unsigned int func)
>  {
> -       struct ralink_priv *p =3D pinctrl_dev_get_drvdata(pctrldev);
> +       struct mtmips_priv *p =3D pinctrl_dev_get_drvdata(pctrldev);
>
>         return p->func[func]->name;
>  }
>
> -static int ralink_pmx_group_get_groups(struct pinctrl_dev *pctrldev,
> +static int mtmips_pmx_group_get_groups(struct pinctrl_dev *pctrldev,
>                                        unsigned int func,
>                                        const char * const **groups,
>                                        unsigned int * const num_groups)
>  {
> -       struct ralink_priv *p =3D pinctrl_dev_get_drvdata(pctrldev);
> +       struct mtmips_priv *p =3D pinctrl_dev_get_drvdata(pctrldev);
>
>         if (p->func[func]->group_count =3D=3D 1)
>                 *groups =3D &p->group_names[p->func[func]->groups[0]];
> @@ -114,10 +114,10 @@ static int ralink_pmx_group_get_groups(struct pinct=
rl_dev *pctrldev,
>         return 0;
>  }
>
> -static int ralink_pmx_group_enable(struct pinctrl_dev *pctrldev,
> +static int mtmips_pmx_group_enable(struct pinctrl_dev *pctrldev,
>                                    unsigned int func, unsigned int group)
>  {
> -       struct ralink_priv *p =3D pinctrl_dev_get_drvdata(pctrldev);
> +       struct mtmips_priv *p =3D pinctrl_dev_get_drvdata(pctrldev);
>         u32 mode =3D 0;
>         u32 reg =3D SYSC_REG_GPIO_MODE;
>         int i;
> @@ -158,11 +158,11 @@ static int ralink_pmx_group_enable(struct pinctrl_d=
ev *pctrldev,
>         return 0;
>  }
>
> -static int ralink_pmx_group_gpio_request_enable(struct pinctrl_dev *pctr=
ldev,
> +static int mtmips_pmx_group_gpio_request_enable(struct pinctrl_dev *pctr=
ldev,
>                                                 struct pinctrl_gpio_range=
 *range,
>                                                 unsigned int pin)
>  {
> -       struct ralink_priv *p =3D pinctrl_dev_get_drvdata(pctrldev);
> +       struct mtmips_priv *p =3D pinctrl_dev_get_drvdata(pctrldev);
>
>         if (!p->gpio[pin]) {
>                 dev_err(p->dev, "pin %d is not set to gpio mux\n", pin);
> @@ -172,28 +172,28 @@ static int ralink_pmx_group_gpio_request_enable(str=
uct pinctrl_dev *pctrldev,
>         return 0;
>  }
>
> -static const struct pinmux_ops ralink_pmx_group_ops =3D {
> -       .get_functions_count    =3D ralink_pmx_func_count,
> -       .get_function_name      =3D ralink_pmx_func_name,
> -       .get_function_groups    =3D ralink_pmx_group_get_groups,
> -       .set_mux                =3D ralink_pmx_group_enable,
> -       .gpio_request_enable    =3D ralink_pmx_group_gpio_request_enable,
> +static const struct pinmux_ops mtmips_pmx_group_ops =3D {
> +       .get_functions_count    =3D mtmips_pmx_func_count,
> +       .get_function_name      =3D mtmips_pmx_func_name,
> +       .get_function_groups    =3D mtmips_pmx_group_get_groups,
> +       .set_mux                =3D mtmips_pmx_group_enable,
> +       .gpio_request_enable    =3D mtmips_pmx_group_gpio_request_enable,
>  };
>
> -static struct pinctrl_desc ralink_pctrl_desc =3D {
> +static struct pinctrl_desc mtmips_pctrl_desc =3D {
>         .owner          =3D THIS_MODULE,
> -       .name           =3D "ralink-pinctrl",
> -       .pctlops        =3D &ralink_pctrl_ops,
> -       .pmxops         =3D &ralink_pmx_group_ops,
> +       .name           =3D "mtmips-pinctrl",
> +       .pctlops        =3D &mtmips_pctrl_ops,
> +       .pmxops         =3D &mtmips_pmx_group_ops,
>  };
>
> -static struct ralink_pmx_func gpio_func =3D {
> +static struct mtmips_pmx_func gpio_func =3D {
>         .name =3D "gpio",
>  };
>
> -static int ralink_pinctrl_index(struct ralink_priv *p)
> +static int mtmips_pinctrl_index(struct mtmips_priv *p)
>  {
> -       struct ralink_pmx_group *mux =3D p->groups;
> +       struct mtmips_pmx_group *mux =3D p->groups;
>         int i, j, c =3D 0;
>
>         /* count the mux functions */
> @@ -248,7 +248,7 @@ static int ralink_pinctrl_index(struct ralink_priv *p=
)
>         return 0;
>  }
>
> -static int ralink_pinctrl_pins(struct ralink_priv *p)
> +static int mtmips_pinctrl_pins(struct mtmips_priv *p)
>  {
>         int i, j;
>
> @@ -313,10 +313,10 @@ static int ralink_pinctrl_pins(struct ralink_priv *=
p)
>         return 0;
>  }
>
> -int ralink_pinctrl_init(struct platform_device *pdev,
> -                       struct ralink_pmx_group *data)
> +int mtmips_pinctrl_init(struct platform_device *pdev,
> +                       struct mtmips_pmx_group *data)
>  {
> -       struct ralink_priv *p;
> +       struct mtmips_priv *p;
>         struct pinctrl_dev *dev;
>         int err;
>
> @@ -324,23 +324,23 @@ int ralink_pinctrl_init(struct platform_device *pde=
v,
>                 return -ENOTSUPP;
>
>         /* setup the private data */
> -       p =3D devm_kzalloc(&pdev->dev, sizeof(struct ralink_priv), GFP_KE=
RNEL);
> +       p =3D devm_kzalloc(&pdev->dev, sizeof(struct mtmips_priv), GFP_KE=
RNEL);
>         if (!p)
>                 return -ENOMEM;
>
>         p->dev =3D &pdev->dev;
> -       p->desc =3D &ralink_pctrl_desc;
> +       p->desc =3D &mtmips_pctrl_desc;
>         p->groups =3D data;
>         platform_set_drvdata(pdev, p);
>
>         /* init the device */
> -       err =3D ralink_pinctrl_index(p);
> +       err =3D mtmips_pinctrl_index(p);
>         if (err) {
>                 dev_err(&pdev->dev, "failed to load index\n");
>                 return err;
>         }
>
> -       err =3D ralink_pinctrl_pins(p);
> +       err =3D mtmips_pinctrl_pins(p);
>         if (err) {
>                 dev_err(&pdev->dev, "failed to load pins\n");
>                 return err;
> diff --git a/drivers/pinctrl/ralink/pinctrl-ralink.h b/drivers/pinctrl/me=
diatek/pinctrl-mtmips.h
> similarity index 75%
> rename from drivers/pinctrl/ralink/pinctrl-ralink.h
> rename to drivers/pinctrl/mediatek/pinctrl-mtmips.h
> index e6037be1e153..a7c3dd724431 100644
> --- a/drivers/pinctrl/ralink/pinctrl-ralink.h
> +++ b/drivers/pinctrl/mediatek/pinctrl-mtmips.h
> @@ -3,8 +3,8 @@
>   *  Copyright (C) 2012 John Crispin <john@phrozen.org>
>   */
>
> -#ifndef _PINCTRL_RALINK_H__
> -#define _PINCTRL_RALINK_H__
> +#ifndef _PINCTRL_MTMIPS_H__
> +#define _PINCTRL_MTMIPS_H__
>
>  #define FUNC(name, value, pin_first, pin_count) \
>         { name, value, pin_first, pin_count }
> @@ -19,9 +19,9 @@
>           .func =3D _func, .gpio =3D _gpio, \
>           .func_count =3D ARRAY_SIZE(_func) }
>
> -struct ralink_pmx_group;
> +struct mtmips_pmx_group;
>
> -struct ralink_pmx_func {
> +struct mtmips_pmx_func {
>         const char *name;
>         const char value;
>
> @@ -35,7 +35,7 @@ struct ralink_pmx_func {
>         int enabled;
>  };
>
> -struct ralink_pmx_group {
> +struct mtmips_pmx_group {
>         const char *name;
>         int enabled;
>
> @@ -43,11 +43,11 @@ struct ralink_pmx_group {
>         const char mask;
>         const char gpio;
>
> -       struct ralink_pmx_func *func;
> +       struct mtmips_pmx_func *func;
>         int func_count;
>  };
>
> -int ralink_pinctrl_init(struct platform_device *pdev,
> -                       struct ralink_pmx_group *data);
> +int mtmips_pinctrl_init(struct platform_device *pdev,
> +                       struct mtmips_pmx_group *data);
>
>  #endif
> diff --git a/drivers/pinctrl/ralink/pinctrl-rt2880.c b/drivers/pinctrl/me=
diatek/pinctrl-rt2880.c
> similarity index 71%
> rename from drivers/pinctrl/ralink/pinctrl-rt2880.c
> rename to drivers/pinctrl/mediatek/pinctrl-rt2880.c
> index d7a65fcc7755..e0366721a515 100644
> --- a/drivers/pinctrl/ralink/pinctrl-rt2880.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-rt2880.c
> @@ -4,7 +4,7 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/of.h>
> -#include "pinctrl-ralink.h"
> +#include "pinctrl-mtmips.h"
>
>  #define RT2880_GPIO_MODE_I2C           BIT(0)
>  #define RT2880_GPIO_MODE_UART0         BIT(1)
> @@ -15,15 +15,15 @@
>  #define RT2880_GPIO_MODE_SDRAM         BIT(6)
>  #define RT2880_GPIO_MODE_PCI           BIT(7)
>
> -static struct ralink_pmx_func i2c_grp[] =3D { FUNC("i2c", 0, 1, 2) };
> -static struct ralink_pmx_func spi_grp[] =3D { FUNC("spi", 0, 3, 4) };
> -static struct ralink_pmx_func uartlite_grp[] =3D { FUNC("uartlite", 0, 7=
, 8) };
> -static struct ralink_pmx_func jtag_grp[] =3D { FUNC("jtag", 0, 17, 5) };
> -static struct ralink_pmx_func mdio_grp[] =3D { FUNC("mdio", 0, 22, 2) };
> -static struct ralink_pmx_func sdram_grp[] =3D { FUNC("sdram", 0, 24, 16)=
 };
> -static struct ralink_pmx_func pci_grp[] =3D { FUNC("pci", 0, 40, 32) };
> +static struct mtmips_pmx_func i2c_grp[] =3D { FUNC("i2c", 0, 1, 2) };
> +static struct mtmips_pmx_func spi_grp[] =3D { FUNC("spi", 0, 3, 4) };
> +static struct mtmips_pmx_func uartlite_grp[] =3D { FUNC("uartlite", 0, 7=
, 8) };
> +static struct mtmips_pmx_func jtag_grp[] =3D { FUNC("jtag", 0, 17, 5) };
> +static struct mtmips_pmx_func mdio_grp[] =3D { FUNC("mdio", 0, 22, 2) };
> +static struct mtmips_pmx_func sdram_grp[] =3D { FUNC("sdram", 0, 24, 16)=
 };
> +static struct mtmips_pmx_func pci_grp[] =3D { FUNC("pci", 0, 40, 32) };
>
> -static struct ralink_pmx_group rt2880_pinmux_data_act[] =3D {
> +static struct mtmips_pmx_group rt2880_pinmux_data_act[] =3D {
>         GRP("i2c", i2c_grp, 1, RT2880_GPIO_MODE_I2C),
>         GRP("spi", spi_grp, 1, RT2880_GPIO_MODE_SPI),
>         GRP("uartlite", uartlite_grp, 1, RT2880_GPIO_MODE_UART0),
> @@ -36,7 +36,7 @@ static struct ralink_pmx_group rt2880_pinmux_data_act[]=
 =3D {
>
>  static int rt2880_pinctrl_probe(struct platform_device *pdev)
>  {
> -       return ralink_pinctrl_init(pdev, rt2880_pinmux_data_act);
> +       return mtmips_pinctrl_init(pdev, rt2880_pinmux_data_act);
>  }
>
>  static const struct of_device_id rt2880_pinctrl_match[] =3D {
> diff --git a/drivers/pinctrl/ralink/pinctrl-rt305x.c b/drivers/pinctrl/me=
diatek/pinctrl-rt305x.c
> similarity index 75%
> rename from drivers/pinctrl/ralink/pinctrl-rt305x.c
> rename to drivers/pinctrl/mediatek/pinctrl-rt305x.c
> index fa3743c7680f..77bd4d1f6122 100644
> --- a/drivers/pinctrl/ralink/pinctrl-rt305x.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-rt305x.c
> @@ -5,7 +5,7 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/of.h>
> -#include "pinctrl-ralink.h"
> +#include "pinctrl-mtmips.h"
>
>  #define RT305X_GPIO_MODE_UART0_SHIFT   2
>  #define RT305X_GPIO_MODE_UART0_MASK    0x7
> @@ -31,9 +31,9 @@
>  #define RT3352_GPIO_MODE_LNA           18
>  #define RT3352_GPIO_MODE_PA            20
>
> -static struct ralink_pmx_func i2c_grp[] =3D  { FUNC("i2c", 0, 1, 2) };
> -static struct ralink_pmx_func spi_grp[] =3D { FUNC("spi", 0, 3, 4) };
> -static struct ralink_pmx_func uartf_grp[] =3D {
> +static struct mtmips_pmx_func i2c_grp[] =3D  { FUNC("i2c", 0, 1, 2) };
> +static struct mtmips_pmx_func spi_grp[] =3D { FUNC("spi", 0, 3, 4) };
> +static struct mtmips_pmx_func uartf_grp[] =3D {
>         FUNC("uartf", RT305X_GPIO_MODE_UARTF, 7, 8),
>         FUNC("pcm uartf", RT305X_GPIO_MODE_PCM_UARTF, 7, 8),
>         FUNC("pcm i2s", RT305X_GPIO_MODE_PCM_I2S, 7, 8),
> @@ -42,28 +42,28 @@ static struct ralink_pmx_func uartf_grp[] =3D {
>         FUNC("gpio uartf", RT305X_GPIO_MODE_GPIO_UARTF, 7, 4),
>         FUNC("gpio i2s", RT305X_GPIO_MODE_GPIO_I2S, 7, 4),
>  };
> -static struct ralink_pmx_func uartlite_grp[] =3D { FUNC("uartlite", 0, 1=
5, 2) };
> -static struct ralink_pmx_func jtag_grp[] =3D { FUNC("jtag", 0, 17, 5) };
> -static struct ralink_pmx_func mdio_grp[] =3D { FUNC("mdio", 0, 22, 2) };
> -static struct ralink_pmx_func rt5350_led_grp[] =3D { FUNC("led", 0, 22, =
5) };
> -static struct ralink_pmx_func rt5350_cs1_grp[] =3D {
> +static struct mtmips_pmx_func uartlite_grp[] =3D { FUNC("uartlite", 0, 1=
5, 2) };
> +static struct mtmips_pmx_func jtag_grp[] =3D { FUNC("jtag", 0, 17, 5) };
> +static struct mtmips_pmx_func mdio_grp[] =3D { FUNC("mdio", 0, 22, 2) };
> +static struct mtmips_pmx_func rt5350_led_grp[] =3D { FUNC("led", 0, 22, =
5) };
> +static struct mtmips_pmx_func rt5350_cs1_grp[] =3D {
>         FUNC("spi_cs1", 0, 27, 1),
>         FUNC("wdg_cs1", 1, 27, 1),
>  };
> -static struct ralink_pmx_func sdram_grp[] =3D { FUNC("sdram", 0, 24, 16)=
 };
> -static struct ralink_pmx_func rt3352_rgmii_grp[] =3D {
> +static struct mtmips_pmx_func sdram_grp[] =3D { FUNC("sdram", 0, 24, 16)=
 };
> +static struct mtmips_pmx_func rt3352_rgmii_grp[] =3D {
>         FUNC("rgmii", 0, 24, 12)
>  };
> -static struct ralink_pmx_func rgmii_grp[] =3D { FUNC("rgmii", 0, 40, 12)=
 };
> -static struct ralink_pmx_func rt3352_lna_grp[] =3D { FUNC("lna", 0, 36, =
2) };
> -static struct ralink_pmx_func rt3352_pa_grp[] =3D { FUNC("pa", 0, 38, 2)=
 };
> -static struct ralink_pmx_func rt3352_led_grp[] =3D { FUNC("led", 0, 40, =
5) };
> -static struct ralink_pmx_func rt3352_cs1_grp[] =3D {
> +static struct mtmips_pmx_func rgmii_grp[] =3D { FUNC("rgmii", 0, 40, 12)=
 };
> +static struct mtmips_pmx_func rt3352_lna_grp[] =3D { FUNC("lna", 0, 36, =
2) };
> +static struct mtmips_pmx_func rt3352_pa_grp[] =3D { FUNC("pa", 0, 38, 2)=
 };
> +static struct mtmips_pmx_func rt3352_led_grp[] =3D { FUNC("led", 0, 40, =
5) };
> +static struct mtmips_pmx_func rt3352_cs1_grp[] =3D {
>         FUNC("spi_cs1", 0, 45, 1),
>         FUNC("wdg_cs1", 1, 45, 1),
>  };
>
> -static struct ralink_pmx_group rt3050_pinmux_data[] =3D {
> +static struct mtmips_pmx_group rt3050_pinmux_data[] =3D {
>         GRP("i2c", i2c_grp, 1, RT305X_GPIO_MODE_I2C),
>         GRP("spi", spi_grp, 1, RT305X_GPIO_MODE_SPI),
>         GRP("uartf", uartf_grp, RT305X_GPIO_MODE_UART0_MASK,
> @@ -76,7 +76,7 @@ static struct ralink_pmx_group rt3050_pinmux_data[] =3D=
 {
>         { 0 }
>  };
>
> -static struct ralink_pmx_group rt3352_pinmux_data[] =3D {
> +static struct mtmips_pmx_group rt3352_pinmux_data[] =3D {
>         GRP("i2c", i2c_grp, 1, RT305X_GPIO_MODE_I2C),
>         GRP("spi", spi_grp, 1, RT305X_GPIO_MODE_SPI),
>         GRP("uartf", uartf_grp, RT305X_GPIO_MODE_UART0_MASK,
> @@ -92,7 +92,7 @@ static struct ralink_pmx_group rt3352_pinmux_data[] =3D=
 {
>         { 0 }
>  };
>
> -static struct ralink_pmx_group rt5350_pinmux_data[] =3D {
> +static struct mtmips_pmx_group rt5350_pinmux_data[] =3D {
>         GRP("i2c", i2c_grp, 1, RT305X_GPIO_MODE_I2C),
>         GRP("spi", spi_grp, 1, RT305X_GPIO_MODE_SPI),
>         GRP("uartf", uartf_grp, RT305X_GPIO_MODE_UART0_MASK,
> @@ -107,11 +107,11 @@ static struct ralink_pmx_group rt5350_pinmux_data[]=
 =3D {
>  static int rt305x_pinctrl_probe(struct platform_device *pdev)
>  {
>         if (soc_is_rt5350())
> -               return ralink_pinctrl_init(pdev, rt5350_pinmux_data);
> +               return mtmips_pinctrl_init(pdev, rt5350_pinmux_data);
>         else if (soc_is_rt305x() || soc_is_rt3350())
> -               return ralink_pinctrl_init(pdev, rt3050_pinmux_data);
> +               return mtmips_pinctrl_init(pdev, rt3050_pinmux_data);
>         else if (soc_is_rt3352())
> -               return ralink_pinctrl_init(pdev, rt3352_pinmux_data);
> +               return mtmips_pinctrl_init(pdev, rt3352_pinmux_data);
>         else
>                 return -EINVAL;
>  }
> diff --git a/drivers/pinctrl/ralink/pinctrl-rt3883.c b/drivers/pinctrl/me=
diatek/pinctrl-rt3883.c
> similarity index 80%
> rename from drivers/pinctrl/ralink/pinctrl-rt3883.c
> rename to drivers/pinctrl/mediatek/pinctrl-rt3883.c
> index 5f766d76bafa..eeaf344c3647 100644
> --- a/drivers/pinctrl/ralink/pinctrl-rt3883.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-rt3883.c
> @@ -3,7 +3,7 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/of.h>
> -#include "pinctrl-ralink.h"
> +#include "pinctrl-mtmips.h"
>
>  #define RT3883_GPIO_MODE_UART0_SHIFT   2
>  #define RT3883_GPIO_MODE_UART0_MASK    0x7
> @@ -39,9 +39,9 @@
>  #define RT3883_GPIO_MODE_LNA_G_GPIO    0x3
>  #define RT3883_GPIO_MODE_LNA_G         _RT3883_GPIO_MODE_LNA_G(RT3883_GP=
IO_MODE_LNA_G_MASK)
>
> -static struct ralink_pmx_func i2c_grp[] =3D  { FUNC("i2c", 0, 1, 2) };
> -static struct ralink_pmx_func spi_grp[] =3D { FUNC("spi", 0, 3, 4) };
> -static struct ralink_pmx_func uartf_grp[] =3D {
> +static struct mtmips_pmx_func i2c_grp[] =3D  { FUNC("i2c", 0, 1, 2) };
> +static struct mtmips_pmx_func spi_grp[] =3D { FUNC("spi", 0, 3, 4) };
> +static struct mtmips_pmx_func uartf_grp[] =3D {
>         FUNC("uartf", RT3883_GPIO_MODE_UARTF, 7, 8),
>         FUNC("pcm uartf", RT3883_GPIO_MODE_PCM_UARTF, 7, 8),
>         FUNC("pcm i2s", RT3883_GPIO_MODE_PCM_I2S, 7, 8),
> @@ -50,21 +50,21 @@ static struct ralink_pmx_func uartf_grp[] =3D {
>         FUNC("gpio uartf", RT3883_GPIO_MODE_GPIO_UARTF, 7, 4),
>         FUNC("gpio i2s", RT3883_GPIO_MODE_GPIO_I2S, 7, 4),
>  };
> -static struct ralink_pmx_func uartlite_grp[] =3D { FUNC("uartlite", 0, 1=
5, 2) };
> -static struct ralink_pmx_func jtag_grp[] =3D { FUNC("jtag", 0, 17, 5) };
> -static struct ralink_pmx_func mdio_grp[] =3D { FUNC("mdio", 0, 22, 2) };
> -static struct ralink_pmx_func lna_a_grp[] =3D { FUNC("lna a", 0, 32, 3) =
};
> -static struct ralink_pmx_func lna_g_grp[] =3D { FUNC("lna g", 0, 35, 3) =
};
> -static struct ralink_pmx_func pci_grp[] =3D {
> +static struct mtmips_pmx_func uartlite_grp[] =3D { FUNC("uartlite", 0, 1=
5, 2) };
> +static struct mtmips_pmx_func jtag_grp[] =3D { FUNC("jtag", 0, 17, 5) };
> +static struct mtmips_pmx_func mdio_grp[] =3D { FUNC("mdio", 0, 22, 2) };
> +static struct mtmips_pmx_func lna_a_grp[] =3D { FUNC("lna a", 0, 32, 3) =
};
> +static struct mtmips_pmx_func lna_g_grp[] =3D { FUNC("lna g", 0, 35, 3) =
};
> +static struct mtmips_pmx_func pci_grp[] =3D {
>         FUNC("pci-dev", 0, 40, 32),
>         FUNC("pci-host2", 1, 40, 32),
>         FUNC("pci-host1", 2, 40, 32),
>         FUNC("pci-fnc", 3, 40, 32)
>  };
> -static struct ralink_pmx_func ge1_grp[] =3D { FUNC("ge1", 0, 72, 12) };
> -static struct ralink_pmx_func ge2_grp[] =3D { FUNC("ge2", 0, 84, 12) };
> +static struct mtmips_pmx_func ge1_grp[] =3D { FUNC("ge1", 0, 72, 12) };
> +static struct mtmips_pmx_func ge2_grp[] =3D { FUNC("ge2", 0, 84, 12) };
>
> -static struct ralink_pmx_group rt3883_pinmux_data[] =3D {
> +static struct mtmips_pmx_group rt3883_pinmux_data[] =3D {
>         GRP("i2c", i2c_grp, 1, RT3883_GPIO_MODE_I2C),
>         GRP("spi", spi_grp, 1, RT3883_GPIO_MODE_SPI),
>         GRP("uartf", uartf_grp, RT3883_GPIO_MODE_UART0_MASK,
> @@ -83,7 +83,7 @@ static struct ralink_pmx_group rt3883_pinmux_data[] =3D=
 {
>
>  static int rt3883_pinctrl_probe(struct platform_device *pdev)
>  {
> -       return ralink_pinctrl_init(pdev, rt3883_pinmux_data);
> +       return mtmips_pinctrl_init(pdev, rt3883_pinmux_data);
>  }
>
>  static const struct of_device_id rt3883_pinctrl_match[] =3D {
> diff --git a/drivers/pinctrl/ralink/Kconfig b/drivers/pinctrl/ralink/Kcon=
fig
> deleted file mode 100644
> index c5fe4c31aaea..000000000000
> --- a/drivers/pinctrl/ralink/Kconfig
> +++ /dev/null
> @@ -1,40 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0-only
> -menu "Ralink pinctrl drivers"
> -        depends on RALINK
> -
> -config PINCTRL_RALINK
> -        bool "Ralink pinctrl driver"
> -        select PINMUX
> -        select GENERIC_PINCONF
> -
> -config PINCTRL_MT7620
> -        bool "MT7620 pinctrl subdriver"
> -        depends on RALINK && SOC_MT7620
> -        select PINCTRL_RALINK
> -
> -config PINCTRL_MT7621
> -        bool "MT7621 pinctrl subdriver"
> -        depends on RALINK && SOC_MT7621
> -        select PINCTRL_RALINK
> -
> -config PINCTRL_MT76X8
> -        bool "MT76X8 pinctrl subdriver"
> -        depends on RALINK && SOC_MT7620
> -        select PINCTRL_RALINK
> -
> -config PINCTRL_RT2880
> -        bool "RT2880 pinctrl subdriver"
> -        depends on RALINK && SOC_RT288X
> -        select PINCTRL_RALINK
> -
> -config PINCTRL_RT305X
> -        bool "RT305X pinctrl subdriver"
> -        depends on RALINK && SOC_RT305X
> -        select PINCTRL_RALINK
> -
> -config PINCTRL_RT3883
> -        bool "RT3883 pinctrl subdriver"
> -        depends on RALINK && SOC_RT3883
> -        select PINCTRL_RALINK
> -
> -endmenu
> diff --git a/drivers/pinctrl/ralink/Makefile b/drivers/pinctrl/ralink/Mak=
efile
> deleted file mode 100644
> index be9acf2e27fd..000000000000
> --- a/drivers/pinctrl/ralink/Makefile
> +++ /dev/null
> @@ -1,9 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0
> -obj-$(CONFIG_PINCTRL_RALINK)   +=3D pinctrl-ralink.o
> -
> -obj-$(CONFIG_PINCTRL_MT7620)   +=3D pinctrl-mt7620.o
> -obj-$(CONFIG_PINCTRL_MT7621)   +=3D pinctrl-mt7621.o
> -obj-$(CONFIG_PINCTRL_MT76X8)   +=3D pinctrl-mt76x8.o
> -obj-$(CONFIG_PINCTRL_RT2880)   +=3D pinctrl-rt2880.o
> -obj-$(CONFIG_PINCTRL_RT305X)   +=3D pinctrl-rt305x.o
> -obj-$(CONFIG_PINCTRL_RT3883)   +=3D pinctrl-rt3883.o
> --
> 2.37.2
>
