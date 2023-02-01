Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81366860E9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 08:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbjBAHrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 02:47:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjBAHqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 02:46:43 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5243B5D12B;
        Tue, 31 Jan 2023 23:46:09 -0800 (PST)
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 1500CE0003;
        Wed,  1 Feb 2023 07:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1675237567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z25cfYozFGO7GRW7aRvp/LnRji5Y6L8B9ioccgyMGOo=;
        b=FVczT2DdcQRv21R6CZfD8lXiI6mt72zNv/4Dsv1FyVceB+PrtVgU3PeLgVGrLg2otMRWqe
        hR4dxyxdOb+hwvssL6bMIjIeajlHUISohPD3bvgqjMmplFkgaw0aUcOQ+AuaJgiGJjVhFY
        hUIIehahUdvRMoUx1F5FXX8IZZxu6hip3gzHuXxAbYQ7KG6h3rq6+siyp+CHGKbLPITWYY
        4igq1MEU9EzThXmhOeM9BKwX8T3FL2fe6vhBXiEIpsFK9+48TiZGUm2k28ZlQuo6dVK+wU
        WVOB85Jl9inH8Vnak10doHqSRMhMCGtIa6KS15Zl39TNPUoBoSBKiJOegpwE+Q==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: marvell: Fix compatible strings for Armada
 3720 boards
In-Reply-To: <20220713125644.3117-1-pali@kernel.org>
References: <20220713125644.3117-1-pali@kernel.org>
Date:   Wed, 01 Feb 2023 08:46:05 +0100
Message-ID: <87h6w5bzgi.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pali Roh=C3=A1r <pali@kernel.org> writes:

> All Armada 3720 boards have Armada 3720 processor which is of Armada 3700
> family and do not have Armada 3710 processor. So none of them should have
> compatible string for Armada 3710 processor.
>
> Fix compatible string for all these boards by removing wrong processor
> string "marvell,armada3710" and adding family string "marvell,armada3700"
> as the last one. (Note that this is same way how are defined Armada 3710
> DTS files).
>
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>


Fixedd a marge conflict and applied on mvebu/dt64

Thanks,

Gregory

> ---
>  arch/arm64/boot/dts/marvell/armada-3720-db.dts                  | 2 +-
>  arch/arm64/boot/dts/marvell/armada-3720-espressobin-emmc.dts    | 2 +-
>  arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts   | 2 +-
>  arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts | 2 +-
>  arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts      | 2 +-
>  arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts         | 2 +-
>  arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts          | 2 +-
>  arch/arm64/boot/dts/marvell/armada-372x.dtsi                    | 2 +-
>  8 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-db.dts b/arch/arm64/=
boot/dts/marvell/armada-3720-db.dts
> index bd4e61d5448e..0cfb38492021 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-db.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
> @@ -18,7 +18,7 @@
>=20=20
>  / {
>  	model =3D "Marvell Armada 3720 Development Board DB-88F3720-DDR3";
> -	compatible =3D "marvell,armada-3720-db", "marvell,armada3720", "marvell=
,armada3710";
> +	compatible =3D "marvell,armada-3720-db", "marvell,armada3720", "marvell=
,armada3700";
>=20=20
>  	chosen {
>  		stdout-path =3D "serial0:115200n8";
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-emmc.dts=
 b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-emmc.dts
> index 5c4d8f379704..6715a19c1483 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-emmc.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-emmc.dts
> @@ -18,7 +18,7 @@
>  / {
>  	model =3D "Globalscale Marvell ESPRESSOBin Board (eMMC)";
>  	compatible =3D "globalscale,espressobin-emmc", "globalscale,espressobin=
",
> -		     "marvell,armada3720", "marvell,armada3710";
> +		     "marvell,armada3720", "marvell,armada3700";
>  };
>=20=20
>  &sdhci0 {
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dt=
s b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
> index 070725b81be5..447760b69850 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
> @@ -13,7 +13,7 @@
>  / {
>  	model =3D "Globalscale Marvell ESPRESSOBin Ultra Board";
>  	compatible =3D "globalscale,espressobin-ultra", "marvell,armada3720",
> -		     "marvell,armada3710";
> +		     "marvell,armada3700";
>=20=20
>  	aliases {
>  		/* ethernet1 is WAN port */
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.=
dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
> index 75401eab4d42..2a8aa3901a9f 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
> @@ -19,7 +19,7 @@
>  	model =3D "Globalscale Marvell ESPRESSOBin Board V7 (eMMC)";
>  	compatible =3D "globalscale,espressobin-v7-emmc", "globalscale,espresso=
bin-v7",
>  		     "globalscale,espressobin", "marvell,armada3720",
> -		     "marvell,armada3710";
> +		     "marvell,armada3700";
>=20=20
>  	aliases {
>  		/* ethernet1 is wan port */
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts b=
/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts
> index 48a7f50fb427..b03af87611a9 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts
> @@ -18,7 +18,7 @@
>  / {
>  	model =3D "Globalscale Marvell ESPRESSOBin Board V7";
>  	compatible =3D "globalscale,espressobin-v7", "globalscale,espressobin",
> -		     "marvell,armada3720", "marvell,armada3710";
> +		     "marvell,armada3720", "marvell,armada3700";
>=20=20
>  	aliases {
>  		/* ethernet1 is wan port */
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts b/ar=
ch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
> index 1542d836c090..c5a834b33b77 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
> @@ -16,5 +16,5 @@
>=20=20
>  / {
>  	model =3D "Globalscale Marvell ESPRESSOBin Board";
> -	compatible =3D "globalscale,espressobin", "marvell,armada3720", "marvel=
l,armada3710";
> +	compatible =3D "globalscale,espressobin", "marvell,armada3720", "marvel=
l,armada3700";
>  };
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts b/arc=
h/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> index caf9c8529fca..5840ed129309 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> @@ -14,7 +14,7 @@
>  / {
>  	model =3D "CZ.NIC Turris Mox Board";
>  	compatible =3D "cznic,turris-mox", "marvell,armada3720",
> -		     "marvell,armada3710";
> +		     "marvell,armada3700";
>=20=20
>  	aliases {
>  		spi0 =3D &spi0;
> diff --git a/arch/arm64/boot/dts/marvell/armada-372x.dtsi b/arch/arm64/bo=
ot/dts/marvell/armada-372x.dtsi
> index 5ce55bdbb995..02ae1e153288 100644
> --- a/arch/arm64/boot/dts/marvell/armada-372x.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-372x.dtsi
> @@ -13,7 +13,7 @@
>=20=20
>  / {
>  	model =3D "Marvell Armada 3720 SoC";
> -	compatible =3D "marvell,armada3720", "marvell,armada3710";
> +	compatible =3D "marvell,armada3720", "marvell,armada3700";
>=20=20
>  	cpus {
>  		cpu1: cpu@1 {
> --=20
> 2.20.1
>

--=20
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
