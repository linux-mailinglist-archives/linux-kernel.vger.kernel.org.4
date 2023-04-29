Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1056F6F2213
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 03:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347262AbjD2BaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 21:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347074AbjD2BaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 21:30:03 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED6B10F9;
        Fri, 28 Apr 2023 18:30:01 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-957dbae98b4so67933766b.1;
        Fri, 28 Apr 2023 18:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682731800; x=1685323800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w/mrCSfSQUswJQokY5CKe1DjsNNVB/tC9yPgcDgjPVo=;
        b=Cp4k0SnPzmRX1iwhjYK30jpCdKDz57EBRJZZYFlktyGQWgBSy6nlL8hURnvSx4dEyB
         Q+N7Qi0fX/m2buLh2I0molv6vsrWhZC8/VHB50IcESuVgAEmKInA9EP0T7Ehfpu4FKjb
         0gKDGqUe6aXE6+ZxqRJ/ljudqP5f9xSCZ8yRsizxXrpiLp1R8czlkEFQcAQuB1V1hiKu
         wzvJg0gck0puRog6789hw7gK1KVM0AAYWPixExdBeLYBDuKqJgWRvjVbfAVt+XxZiChR
         67N1Q5nSB3FQKAg2iyEGpoZL9HGyeq7IrX1eIWOjzlj0qHqHtcJ6KdeXA772jcBCQ0zA
         d0Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682731800; x=1685323800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w/mrCSfSQUswJQokY5CKe1DjsNNVB/tC9yPgcDgjPVo=;
        b=N3NHgyd+pBusCfmJeVCLgCWxx58jnyW/3yaetGYD+i2aAkYaSOv8onwBrrLpErImK+
         3Qfq8PCmTvafe3LC8R1/nX38FI/W+JIjknoIoMCIZNdYJt3SoVeyL2m0VSso1OaZd7vo
         b4/EcTxRRfFRiTYtE8CkgTyjcMBV63UvCrlL8K1HQpYBBmj5Wr02cssi9+CmA/votpHJ
         e3GDFA6NTQQx50YjI58nu2ID6Ijp+PSk4jxdERkO6b0T+AZx0sSGMS2+muTBsdBQfSjl
         GraFoYqVNXIjMbiFTisGmLNEbCrfFkVZiQ4/BcIJnPh4nrFcaBVr0GFPJgDidmFc3tER
         UXIA==
X-Gm-Message-State: AC+VfDweFKFL+4wXGyH+xiFq7NZhhvqfWqR7Cg9VP23B8YnujUE8pDXK
        8Wqy27xFUXDi6v0xMkwd1UAt3khnyYccOJXS7Ew=
X-Google-Smtp-Source: ACHHUZ4tn3uoqQTzU663ftvRQvBpWuwX1A024mthR/ReUBQJwotPmbEgI8aqQv/HHmfQY9f/171eYQMnKj9G4RB+bT4=
X-Received: by 2002:a17:907:a40d:b0:94e:f969:fb3e with SMTP id
 sg13-20020a170907a40d00b0094ef969fb3emr6848366ejc.43.1682731799969; Fri, 28
 Apr 2023 18:29:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230428013738.30735-1-cnsztl@gmail.com> <20230428013738.30735-2-cnsztl@gmail.com>
 <32911b1c-7f32-7078-27e8-7b168d295993@linaro.org>
In-Reply-To: <32911b1c-7f32-7078-27e8-7b168d295993@linaro.org>
From:   Tianling Shen <cnsztl@gmail.com>
Date:   Sat, 29 Apr 2023 09:29:47 +0800
Message-ID: <CAOP2_TjXKk8KrD7Ur2pAGa-8pCMJcZjbw1opKYzFEfO4weJzhw@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: dts: rockchip: Add Lunzn Fastrhino R66S
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Peter Geis <pgwipeout@gmail.com>, Andy Yan <andyshrk@163.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        Brian Norris <briannorris@chromium.org>,
        Andrew Lunn <andrew@lunn.ch>, Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
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

Hi Krzysztof,

On Fri, Apr 28, 2023 at 9:34=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 28/04/2023 03:37, Tianling Shen wrote:
> > Lunzn Fastrhino R66S is a high-performance mini router.
> >
> > Specification:
> > - Rockchip RK3568
> > - 1/2GB LPDDR4 RAM
> > - SD card slot
> > - M.2 Connector
> > - 2x USB 3.0 Port
> > - 2x 2500 Base-T (PCIe, r8125b)
> > - 12v DC Jack
> >
> > Signed-off-by: Tianling Shen <cnsztl@gmail.com>
> > ---
> >  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
> >  .../dts/rockchip/rk3568-fastrhino-r66s.dts    |  27 +
> >  .../dts/rockchip/rk3568-fastrhino-r66s.dtsi   | 507 ++++++++++++++++++
> >  3 files changed, 535 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.=
dts
> >  create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.=
dtsi
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dt=
s/rockchip/Makefile
> > index 2d585bbb8f3a..15089a78555a 100644
> > --- a/arch/arm64/boot/dts/rockchip/Makefile
> > +++ b/arch/arm64/boot/dts/rockchip/Makefile
> > @@ -85,6 +85,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3566-box-demo.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3566-lubancat-1.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3568-bpi-r2-pro.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3568-evb1-v10.dtb
> > +dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3568-fastrhino-r66s.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3568-lubancat-2.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3568-nanopi-r5c.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3568-nanopi-r5s.dtb
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dts b/a=
rch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dts
> > new file mode 100644
> > index 000000000000..fc9e1bdab128
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dts
> > @@ -0,0 +1,27 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> > +
> > +#include "rk3568-fastrhino-r66s.dtsi"
> > +
> > +/ {
> > +     model =3D "Lunzn FastRhino R66S";
> > +     compatible =3D "lunzn,fastrhino-r66s", "rockchip,rk3568";
> > +
> > +     aliases {
> > +             mmc0 =3D &sdmmc0;
> > +     };
> > +};
> > +
> > +&sdmmc0 {
> > +     max-frequency =3D <150000000>;
> > +     no-sdio;
> > +     no-mmc;
> > +     bus-width =3D <4>;
> > +     cap-mmc-highspeed;
> > +     cap-sd-highspeed;
> > +     disable-wp;
> > +     vmmc-supply =3D <&vcc3v3_sd>;
> > +     vqmmc-supply =3D <&vccio_sd>;
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&sdmmc0_bus4 &sdmmc0_clk &sdmmc0_cmd &sdmmc0_det>;
> > +     status =3D "okay";
> > +};
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dtsi b/=
arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dtsi
> > new file mode 100644
> > index 000000000000..a58592b2f13b
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dtsi
> > @@ -0,0 +1,507 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> > +
> > +/dts-v1/;
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/input/input.h>
> > +#include <dt-bindings/leds/common.h>
> > +#include <dt-bindings/pinctrl/rockchip.h>
> > +#include <dt-bindings/soc/rockchip,vop2.h>
> > +#include "rk3568.dtsi"
> > +
> > +/ {
> > +     aliases {
> > +             led-boot =3D &status_led;
> > +             led-failsafe =3D &status_led;
> > +             led-running =3D &status_led;
> > +             led-upgrade =3D &status_led;
>
> Why do you need these? Which upstream kernel driver parses these?

Oh sorry these aliases are used for OpenWrt and I forgot to remove them
when submitting patches. Will send v2 for it.

Thanks,
Tianling.

>
>
> Best regards,
> Krzysztof
>
