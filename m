Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7676F4074
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 11:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbjEBJyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 05:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233705AbjEBJyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 05:54:13 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6873B4C1D;
        Tue,  2 May 2023 02:54:12 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5050497df77so5473163a12.1;
        Tue, 02 May 2023 02:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683021251; x=1685613251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fi6J4KktggFcxnTEbWmu1afVM0xa1hdx8FHvCQmU9C8=;
        b=aENdbdjcKslaPIybJGalRlEvwHOgbxCv3xJtL1zdiu0a4QAcNWsiypx6kZK+xoEgew
         Q/XeA0xdxsX5wDuy9IEXE3Na6+DisgJ/K1ixcD+g+Mq2b6t39czXtlksk2BKk67DI8kx
         OS1/Z2u2buAPoOD5oRW1iSesRc854xFkV5VcXP0n/D05BYBHJBiJq5+PYPx/cXAUlQnW
         w2RBaLZHbz2+rp53RxOZhUNu0FGxzXeQ/i98gZwOIuYH9hkj7TsQKA7frmO0tA1/+YH0
         3A5/jh3liPiucZW4YWAkRYnKtFOf0deXxaja6mwfBcv/SFi2UFcgT1ezaklewy0kzXNH
         d8Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683021251; x=1685613251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fi6J4KktggFcxnTEbWmu1afVM0xa1hdx8FHvCQmU9C8=;
        b=D+8Qw7IKfX4ZuqtGKpvmSLxog+KA9tDP47HjsSx0c/2v/lZhRTi7ExdLsZN+TapUFK
         HB90qBLG6GVfeN4kMuGAF3GT4XLviodGpoBO1FpHmLcQIukkKiFjQn5xyTOplsuQBOLV
         UfFO3cHU6Q0CXxi+NqEIb6X+D/uWggoEeLxie+FW9MlBtTld3gq5++SIihkFz8n6cgYZ
         uI8J6aDoJaZhIcaY9pw2LShldXzkIZDCeVWqHB/ijiN0WClZ1NQXFuxIqVZJT2n+GMXK
         e3VGP/oHFxrpQagGJNCPCAsohS28e/DUqyzxAkFrTCpWLVqmHuhIXbfC5xF6HbvGZlDU
         huSA==
X-Gm-Message-State: AC+VfDw7ATXsYsZ7CJaN8VRysWbTf1yGrcXCXZi2zBAioikkTKR8xOHe
        fc2g9GHU0yDLl1coCqUiClqOyd8CNwwLHy7owOnLORG65H/BgQ==
X-Google-Smtp-Source: ACHHUZ7svlRvA55nkpdE794hBgL518IElYm2XPpx/QO5NG5LAo06fq1XPXcimfK5puW6XORWHdgIbu0atovrR1HJ4mg=
X-Received: by 2002:aa7:dc14:0:b0:506:bc26:d6a9 with SMTP id
 b20-20020aa7dc14000000b00506bc26d6a9mr7941344edu.8.1683021250531; Tue, 02 May
 2023 02:54:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230428013738.30735-1-cnsztl@gmail.com> <20230428013738.30735-2-cnsztl@gmail.com>
 <5782501.VdNmn5OnKV@diego> <4763863.6tgchFWduM@diego>
In-Reply-To: <4763863.6tgchFWduM@diego>
From:   Tianling Shen <cnsztl@gmail.com>
Date:   Tue, 2 May 2023 17:53:58 +0800
Message-ID: <CAOP2_TgrPwvkXayyWkb5H-+X-Nr85G65YoAfs4_+zUfK=_+VHA@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: dts: rockchip: Add Lunzn Fastrhino R66S
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
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

Hi Heiko,

On Tue, May 2, 2023 at 5:30=E2=80=AFPM Heiko St=C3=BCbner <heiko@sntech.de>=
 wrote:
>
> Am Dienstag, 2. Mai 2023, 11:28:22 CEST schrieb Heiko St=C3=BCbner:
> > Hi,
> >
> > Am Freitag, 28. April 2023, 03:37:37 CEST schrieb Tianling Shen:
> > > Lunzn Fastrhino R66S is a high-performance mini router.
> > >
> > > Specification:
> > > - Rockchip RK3568
> > > - 1/2GB LPDDR4 RAM
> > > - SD card slot
> > > - M.2 Connector
> > > - 2x USB 3.0 Port
> > > - 2x 2500 Base-T (PCIe, r8125b)
> > > - 12v DC Jack
> > >
> > > Signed-off-by: Tianling Shen <cnsztl@gmail.com>
> > > ---
> > >  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
> > >  .../dts/rockchip/rk3568-fastrhino-r66s.dts    |  27 +
> > >  .../dts/rockchip/rk3568-fastrhino-r66s.dtsi   | 507 ++++++++++++++++=
++
> > >  3 files changed, 535 insertions(+)
> > >  create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66=
s.dts
> > >  create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66=
s.dtsi
> > >
> > > diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/=
dts/rockchip/Makefile
> > > index 2d585bbb8f3a..15089a78555a 100644
> > > --- a/arch/arm64/boot/dts/rockchip/Makefile
> > > +++ b/arch/arm64/boot/dts/rockchip/Makefile
> > > @@ -85,6 +85,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3566-box-demo.dt=
b
> > >  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3566-lubancat-1.dtb
> > >  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3568-bpi-r2-pro.dtb
> > >  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3568-evb1-v10.dtb
> > > +dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3568-fastrhino-r66s.dtb
> > >  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3568-lubancat-2.dtb
> > >  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3568-nanopi-r5c.dtb
> > >  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3568-nanopi-r5s.dtb
> > > diff --git a/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dts b=
/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dts
> > > new file mode 100644
> > > index 000000000000..fc9e1bdab128
> > > --- /dev/null
> > > +++ b/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dts
> > > @@ -0,0 +1,27 @@
> > > +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> > > +
> > > +#include "rk3568-fastrhino-r66s.dtsi"
> > > +
> > > +/ {
> > > +   model =3D "Lunzn FastRhino R66S";
> > > +   compatible =3D "lunzn,fastrhino-r66s", "rockchip,rk3568";
> > > +
> > > +   aliases {
> > > +           mmc0 =3D &sdmmc0;
> > > +   };
> > > +};
> > > +
> > > +&sdmmc0 {
> >
> > that whole element seems to be duplicated from rk3568-fastrhino-r66s.dt=
si?
> > I don't think we need to declare that twice. If something really change=
s,
> > please only declare the new properties when going from dtsi to dts.
>
> Looking at patch3 I see the explanation :-) .
>
> The base dtsi should not contain the &sdmmc0 node, and it should
> only be included in the rk3568-fastrhino-r66s.dts, right?
>

Yes, nice catch!

And I found another error in the R68S dts file (gmac pcfg pull type).
Unfortunately I don't have this board right now, and I'm still waiting
for the test result from my friend. Suppose sending v2 in the next few
days.

Thanks,
Tianling.

>
> Heiko
>
>
