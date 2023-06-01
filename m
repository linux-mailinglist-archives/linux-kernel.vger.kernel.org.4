Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3740719320
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 08:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbjFAGXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 02:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbjFAGXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 02:23:16 -0400
Received: from forward500a.mail.yandex.net (forward500a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d500])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76569D
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 23:23:14 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:170e:0:640:d60c:0])
        by forward500a.mail.yandex.net (Yandex) with ESMTP id 835A65EAB3;
        Thu,  1 Jun 2023 09:23:12 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 8NHZtKnDcKo0-x2OmZw4k;
        Thu, 01 Jun 2023 09:23:11 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1685600591;
        bh=ki6bsIOUWk6t8+U9O/0o/525tnGGk/hTfP3gdeX9qC0=;
        h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
        b=mZMh0UflxiVGZj/n7PFjR1B+hqk7U8o1yWy/BWo2kb8rHJeE8VrUkDcp0L3UDBGbF
         PLxnct1c0hBrSn6VLsAYGyl+/KYJsXR5fKyueNFO7EwyvkGR7qaDAvS0ZQoUrgp21b
         XNUvN1NRYwXgxnTIovf2jnGstW9qvoosifwKIqFA=
Authentication-Results: mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Date:   Thu, 1 Jun 2023 09:23:08 +0300
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Conor Dooley <conor.dooley@microchip.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Yinbo Zhu <zhuyinbo@loongson.cn>,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>,
        Walker Chen <walker.chen@starfivetech.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Michael Peters <mpeters@embeddedTS.com>,
        Kris Bahnsen <kris@embeddedTS.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 03/43] soc: Add SoC driver for Cirrus ep93xx
Message-ID: <20230601092215.26d4c88f@redslave.neermore.group>
In-Reply-To: <fde8e0c8-2730-f679-d361-86fad007ee47@molgen.mpg.de>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230601053546.9574-4-nikita.shubin@maquefel.me>
 <fde8e0c8-2730-f679-d361-86fad007ee47@molgen.mpg.de>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Paul.

Thnak you for your comments.

On Thu, 1 Jun 2023 07:53:38 +0200
Paul Menzel <pmenzel@molgen.mpg.de> wrote:

> Dear Nikita,
>=20
>=20
> Thank you for your patch. Some small nit picks.
>=20
> Am 01.06.23 um 07:33 schrieb Nikita Shubin:
> > This adds an SoC driver for the ep93xx. Currently there
> > is only one thing not fitting into any other framework,
> > and that is the swlock setting. =20
>=20
> If you reflow for 75 characters per line, this would fit into two
> lines.
>=20
> > It's used for clock settings and restart. =20
>=20
> What datasheet did you use, and on what board did you test this?

Adding link to v0 series:
https://lore.kernel.org/all/20230424123522.18302-1-nikita.shubin@maquefel.m=
e/

Tested on ts7250 64 RAM/128 MiB Nand flash, edb9302.

> What datasheet did you use

ep9301/ep9302/ep9307/ep9312/ep9315 datasheet
ep93xx user guide

>=20
> > Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> > Tested-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> > Acked-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > --- =20
>=20
> [=E2=80=A6]
>=20
> >   drivers/soc/Kconfig               |   1 +
> >   drivers/soc/Makefile              |   1 +
> >   drivers/soc/cirrus/Kconfig        |  11 +++
> >   drivers/soc/cirrus/Makefile       |   2 +
> >   drivers/soc/cirrus/soc-ep93xx.c   | 134
> > ++++++++++++++++++++++++++++++ include/linux/soc/cirrus/ep93xx.h |
> > 16 +++- 6 files changed, 161 insertions(+), 4 deletions(-)
> >   create mode 100644 drivers/soc/cirrus/Kconfig
> >   create mode 100644 drivers/soc/cirrus/Makefile
> >   create mode 100644 drivers/soc/cirrus/soc-ep93xx.c
> >=20
> > diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
> > index 4e176280113a..6149f0447b61 100644
> > --- a/drivers/soc/Kconfig
> > +++ b/drivers/soc/Kconfig
> > @@ -30,5 +30,6 @@ source "drivers/soc/ti/Kconfig"
> >   source "drivers/soc/ux500/Kconfig"
> >   source "drivers/soc/versatile/Kconfig"
> >   source "drivers/soc/xilinx/Kconfig"
> > +source "drivers/soc/cirrus/Kconfig"
> >  =20
> >   endmenu
> > diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> > index 3b0f9fb3b5c8..7a8a154b8d96 100644
> > --- a/drivers/soc/Makefile
> > +++ b/drivers/soc/Makefile
> > @@ -36,3 +36,4 @@ obj-y				+=3D ti/
> >   obj-$(CONFIG_ARCH_U8500)	+=3D ux500/
> >   obj-$(CONFIG_PLAT_VERSATILE)	+=3D versatile/
> >   obj-y				+=3D xilinx/
> > +obj-$(CONFIG_EP93XX_SOC)	+=3D cirrus/
> > diff --git a/drivers/soc/cirrus/Kconfig b/drivers/soc/cirrus/Kconfig
> > new file mode 100644
> > index 000000000000..bc82c0422325
> > --- /dev/null
> > +++ b/drivers/soc/cirrus/Kconfig
> > @@ -0,0 +1,11 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +if ARCH_EP93XX
> > +
> > +config EP93XX_SOC
> > +	bool "Cirrus EP93xx chips SoC"
> > +	default y if !EP93XX_SOC_COMMON
> > +	help
> > +	  Support Soc for Cirrus EP93xx chips. =20
>=20
> Above (and more common in the whole SOC directory) you spell it SoC.
>=20
> > +
> > +endif
> > diff --git a/drivers/soc/cirrus/Makefile
> > b/drivers/soc/cirrus/Makefile new file mode 100644
> > index 000000000000..ed6752844c6f
> > --- /dev/null
> > +++ b/drivers/soc/cirrus/Makefile
> > @@ -0,0 +1,2 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +obj-y	+=3D soc-ep93xx.o
> > diff --git a/drivers/soc/cirrus/soc-ep93xx.c
> > b/drivers/soc/cirrus/soc-ep93xx.c new file mode 100644
> > index 000000000000..64842e9e2316
> > --- /dev/null
> > +++ b/drivers/soc/cirrus/soc-ep93xx.c
> > @@ -0,0 +1,134 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Soc driver for Cirrus EP93xx chips. =20
>=20
> Ditto.
>=20
> > + * Copyright (C) 2022 Nikita Shubin <nikita.shubin@maquefel.me>
> > + *
> > + * Based on a rewrite of arch/arm/mach-ep93xx/core.c
> > + * Copyright (C) 2006 Lennert Buytenhek <buytenh@wantstofly.org>
> > + * Copyright (C) 2007 Herbert Valerio Riedel <hvr@gnu.org>
> > + *
> > + * Thanks go to Michael Burian and Ray Lehtiniemi for their key
> > + * role in the ep93xx linux community =20
>=20
> If you know their email addresses, you could add those too. Maybe
> also add a dot/period at the end.
>=20
> > + */
> > +
> > +#include <linux/soc/cirrus/ep93xx.h>
> > +#include <linux/init.h>
> > +#include <linux/kernel.h>
> > +#include <linux/mfd/syscon.h>
> > +#include <linux/regmap.h>
> > +#include <linux/of.h>
> > +
> > +#define EP93XX_SYSCON_DEVCFG		0x80
> > +
> > +#define EP93XX_SWLOCK_MAGICK		0xaa
> > +#define EP93XX_SYSCON_SWLOCK		0xc0
> > +#define EP93XX_SYSCON_SYSCFG		0x9c
> > +#define EP93XX_SYSCON_SYSCFG_REV_MASK	(0xf0000000)
> > +#define EP93XX_SYSCON_SYSCFG_REV_SHIFT	(28) =20
>=20
> [=E2=80=A6]
>=20
>=20
> Kind regards,
>=20
> Paul

