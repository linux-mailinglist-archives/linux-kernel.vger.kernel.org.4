Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5344F6643A5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 15:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238706AbjAJOug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 09:50:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238697AbjAJOuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 09:50:22 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928B44FCF2;
        Tue, 10 Jan 2023 06:50:21 -0800 (PST)
Received: from [IPv6:2a00:23c7:6883:e501:329c:8425:8e97:eae9] (unknown [IPv6:2a00:23c7:6883:e501:329c:8425:8e97:eae9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: obbardc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 333C76602D2B;
        Tue, 10 Jan 2023 14:50:20 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673362220;
        bh=PuiPwo9HwFOEDukFjeBEsAsNhLoAsOISooyAzQZgE/w=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=UivahFaqCKHK7Q4kYjRZ0yMLGxV6O43ZLqbqa963ojOEkNEB00rZgasESwe0l2Yly
         agYPc543Wp1sa0jIwBe4BxXlXGHhhD4xouGAZkfnF0uoy83jcy+UJ6QQrYPljyA8A9
         GDt73mfiVhgocAEv/1rD30/SaT3QWBl43/pSQMXLmEOSXLsurpEw9X3tmC0kxGNMut
         KhQ1woUZVdY9zEDahM92UaQ076g8q6MnGLwLgt16OKCyWbBuxR+hnhD1dnbbm9H8y3
         IOjnSmv0h+2rLVVXJoSLArvVme9SsqJGkFc4cZ7SIug/VkbEkT+e6q7r6orOwlJu8X
         Sl2MxGQHm8uEw==
Message-ID: <996e39448350d4f6318f7ff59c6a2ca249fb30a7.camel@collabora.com>
Subject: Re: [PATCHv8 7/7] arm64: dts: rockchip: Add rock-5b board
From:   Christopher Obbard <chris.obbard@collabora.com>
To:     Jagan Teki <jagan@edgeble.ai>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Michael Riesch <michael.riesch@wolfvision.net>
Date:   Tue, 10 Jan 2023 14:50:17 +0000
In-Reply-To: <CA+VMnFxb1P4tP5sef5ME3jCcCq2Y3rD-0bpv1B0TsUZ3RXXuqg@mail.gmail.com>
References: <20230109155801.51642-1-sebastian.reichel@collabora.com>
         <20230109155801.51642-8-sebastian.reichel@collabora.com>
         <CA+VMnFxb1P4tP5sef5ME3jCcCq2Y3rD-0bpv1B0TsUZ3RXXuqg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2-1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-01-10 at 19:30 +0530, Jagan Teki wrote:
> On Mon, 9 Jan 2023 at 21:28, Sebastian Reichel
> <sebastian.reichel@collabora.com> wrote:
> >=20
> > From: Christopher Obbard <chris.obbard@collabora.com>
> >=20
> > Add board file for the RK3588 Rock 5B board. This is a basic
> > implementation which just brings up the eMMC and UART which is
> > enough to successfully boot Linux.
> >=20
> > The ethernet controller is connected via PCIe so support will
> > come in a follow-up patch.
> >=20
> > Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>
> > Reviewed-by: Michael Riesch <michael.riesch@wolfvision.net>
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > ---
> > =C2=A0arch/arm64/boot/dts/rockchip/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> > =C2=A0.../boot/dts/rockchip/rk3588-rock-5b.dts=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 44
> > +++++++++++++++++++
> > =C2=A02 files changed, 45 insertions(+)
> > =C2=A0create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dt=
s
> >=20
> > diff --git a/arch/arm64/boot/dts/rockchip/Makefile
> > b/arch/arm64/boot/dts/rockchip/Makefile
> > index 87a853435142..c5bdd0176ce0 100644
> > --- a/arch/arm64/boot/dts/rockchip/Makefile
> > +++ b/arch/arm64/boot/dts/rockchip/Makefile
> > @@ -83,4 +83,5 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3568-evb1-
> > v10.dtb
> > =C2=A0dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3568-odroid-m1.dtb
> > =C2=A0dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3568-rock-3a.dtb
> > =C2=A0dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3588-evb1-v10.dtb
> > +dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3588-rock-5b.dtb
> > =C2=A0dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3588s-rock-5a.dtb
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> > b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> > new file mode 100644
> > index 000000000000..d2f1e963ce06
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> > @@ -0,0 +1,44 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +
> > +/dts-v1/;
> > +
> > +#include "rk3588.dtsi"
> > +
> > +/ {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 model =3D "Radxa ROCK 5 Model B";
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "radxa,rock-5b", "=
rockchip,rk3588";
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aliases {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 mmc1 =3D &sdhci;
>=20
> I think sdhci - emmc has to be mmc0 due to boot priority.

Hi Jagan,

We kept eMMC as mmc1 for both ROCK 5 Model A and B to keep
compatibility with vendor kernel:
https://github.com/radxa/kernel/blob/stable-5.10-rock5/arch/arm64/boot/dts/=
rockchip/rk3588-rock-5b.dts#L31

But I am happy to change the alias to mmc0, @Sebastian what do you
think?

Thanks
Chris
