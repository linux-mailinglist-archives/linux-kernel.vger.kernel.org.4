Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2D964EE21
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 16:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbiLPPsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 10:48:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbiLPPr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 10:47:59 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EFE60377;
        Fri, 16 Dec 2022 07:47:58 -0800 (PST)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net [192.222.136.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E88A16602C94;
        Fri, 16 Dec 2022 15:47:54 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671205676;
        bh=OpeibgDASJdMkvfrIt2wc5RhxgM/1AD0m55P+Z6hsDI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=DheIvro7Qj7OkGFB8YtfY1/OyrDKi9FDrq8eceDFfmnR+6THk1cazJa01O0U4pRom
         6SmN02ZLRF2HNWSD48DjRkH/gbn9DTPvQ2NpAUTXshn6lxYOvzHZ1aMxJJpsGF2t5g
         eHEvq6KE2HF57mNz5I90o6cYramUWKjjFibKLrHx6rn6kqpCcM5ck8HZ79bsTMgmVg
         Rp4l2JD8InGiCqjwOJ79V0JDda+a4u2C0pGpUCJONb3HwmIYmhLECwRMICTiax7quM
         1yL8q6LL+7R9uciTVjAy8bNtwLrIUICr9rbZ5ageiF8+lSRs2FqnU4M7jhhWxUW1JV
         Xq9vzEw61wtJg==
Message-ID: <e3c73d1c20e12ab351a74ef1abc949810fc1ba77.camel@collabora.com>
Subject: Re: [PATCHv7 7/7] arm64: dts: rockchip: Add rock-5b board
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marc Zyngier <maz@kernel.org>, Jagan Teki <jagan@edgeble.ai>,
        Linus Walleij <linus.walleij@linaro.org>,
        Christopher Obbard <chris.obbard@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Michael Riesch <michael.riesch@wolfvision.net>
Date:   Fri, 16 Dec 2022 10:47:44 -0500
In-Reply-To: <20221215183002.211081-8-sebastian.reichel@collabora.com>
References: <20221215183002.211081-1-sebastian.reichel@collabora.com>
         <20221215183002.211081-8-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian and Christopher,

Le jeudi 15 d=C3=A9cembre 2022 =C3=A0 19:30 +0100, Sebastian Reichel a =C3=
=A9crit=C2=A0:
> From: Christopher Obbard <chris.obbard@collabora.com>
>=20
> Add board file for the RK3588 Rock 5B board. This is a basic
> implementation which just brings up the eMMC and UART which is
> enough to successfully boot Linux.
>=20
> The ethernet controller is connected via PCIe so support will
> come in a follow-up patch.
>=20
> Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>
> Reviewed-by: Michael Riesch <michael.riesch@wolfvision.net>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  arch/arm64/boot/dts/rockchip/Makefile         |  1 +
>  .../boot/dts/rockchip/rk3588-rock-5b.dts      | 44 +++++++++++++++++++
>  2 files changed, 45 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
>=20
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/=
rockchip/Makefile
> index 87a853435142..c5bdd0176ce0 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -83,4 +83,5 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3568-evb1-v10.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3568-odroid-m1.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3568-rock-3a.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3588-evb1-v10.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3588-rock-5b.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3588s-rock-5a.dtb
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64=
/boot/dts/rockchip/rk3588-rock-5b.dts
> new file mode 100644
> index 000000000000..baf46bd30b38
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> @@ -0,0 +1,44 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +/dts-v1/;
> +
> +#include "rk3588.dtsi"
> +
> +/ {
> +	model =3D "Radxa Rock 5B Board";
> +	compatible =3D "radxa,rock-5b", "rockchip,rk3588";
> +
> +	aliases {
> +		mmc1 =3D &sdhci;

I have no useful knowledge, but it seems the mmc alias don't match the vend=
or.
When I run your branch on Rock5B, the EMMC endup on /dev/mmcblk1 (aka mmc1 =
alias
I think) while when I boot the vendor kernel, it is always mmcblk0 (aka mmc=
0
alias?). Perhaps the vendor didn't add aliases ?

There could also be mainline rules to number based on the boot order. In th=
is
case, the difference would be acceptable, since SPL boot order is (usb?) > =
SD
Card > EMMC > SPI NOR. Though, the SPL is picked from the opposite order (s=
pi,
emmc, sd card). Anyway, I'm just trying to express that I noticed a differe=
nce,
and its not guarantied to be a bug.

> +		serial2 =3D &uart2;
> +	};
> +
> +	chosen {
> +		stdout-path =3D "serial2:1500000n8";
> +	};
> +
> +	vcc5v0_sys: vcc5v0-sys-regulator {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "vcc5v0_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt =3D <5000000>;
> +		regulator-max-microvolt =3D <5000000>;
> +	};
> +};
> +
> +&sdhci {
> +	bus-width =3D <8>;
> +	no-sdio;
> +	no-sd;
> +	non-removable;
> +	max-frequency =3D <200000000>;
> +	mmc-hs400-1_8v;
> +	mmc-hs400-enhanced-strobe;
> +	status =3D "okay";
> +};
> +
> +&uart2 {
> +	pinctrl-0 =3D <&uart2m0_xfer>;
> +	status =3D "okay";
> +};
> --=20
> 2.39.0
>=20
>=20

