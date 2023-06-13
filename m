Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B689472E83F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 18:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243056AbjFMQTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 12:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242815AbjFMQTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 12:19:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D461B5;
        Tue, 13 Jun 2023 09:19:37 -0700 (PDT)
Received: from mercury (dyndsl-091-248-189-170.ewe-ip-backbone.de [91.248.189.170])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E56766606EF9;
        Tue, 13 Jun 2023 17:19:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686673176;
        bh=rm+xEAF9m8EKLIV/91S2iZERE1DFe3KIxCEU2gBO/jc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CVrEKkAppmYrbOq1v8+sQA+Rr8M1nfY9ODmNgd8urU6UbcRElqhCzA4YjpRqX4X2i
         E2JfFWLg6CBa9lj3EGV21uJhbf9FcxvWav+VmnVE3t/bvPbGv1AXo+VnoH83VwFlHg
         WM9ydUlNuP4H9UoaUNFSgrRFirVUmld41SGL/2if5tgOh3Qw3MPvCDPsSo5s5vCSv8
         KJtBUct6oWfnwi0gBvqVwItDMf5HS335idMr5fnuVQEO73EUsj9oaX+0pFQ8XezAR1
         pkU/aFs9aN0ODF3QHqEA9MgG0gSGnyRARteP8oii//nn4k+mjeP+NKY2/6kCJV4BUJ
         TcMha1dYPsY+A==
Received: by mercury (Postfix, from userid 1000)
        id 8A4761066FBA; Tue, 13 Jun 2023 18:19:33 +0200 (CEST)
Date:   Tue, 13 Jun 2023 18:19:33 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, kernel@pengutronix.de,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Robin Murphy <robin.murphy@arm.com>,
        Vincent Legoll <vincent.legoll@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 25/25] arm64: dts: rockchip: rk3588s: Add DFI
Message-ID: <20230613161933.qy3qh7ybf3azl3aa@mercury.elektranox.org>
References: <20230524083153.2046084-1-s.hauer@pengutronix.de>
 <20230524083153.2046084-26-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mrx4igmyearfat7p"
Content-Disposition: inline
In-Reply-To: <20230524083153.2046084-26-s.hauer@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mrx4igmyearfat7p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 24, 2023 at 10:31:53AM +0200, Sascha Hauer wrote:
> The DFI unit can be used to measure DRAM utilization using perf. Add the
> node to the device tree. The DFI needs a rockchip,pmu phandle to the pmu
> containing registers for SDRAM configuration details. This is added in
> this patch as well.
>=20
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>=20
> Notes:
>     Changes since v4:
>     - new patch
>=20
>  arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/=
dts/rockchip/rk3588s.dtsi
> index 657c019d27fa9..4a445d8704c8f 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> @@ -388,6 +388,11 @@ scmi_shmem: sram@0 {
>  		};
>  	};
> =20
> +	pmu1grf: syscon@fd58a000 {
> +		compatible =3D "rockchip,rk3588-pmugrf", "syscon", "simple-mfd";
                      ^^^^^^^^^^^^^^^^^^^^^^

Must be added in Documentation/devicetree/bindings/soc/rockchip/grf.yaml

Otherwise the patch is

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

> +		reg =3D <0x0 0xfd58a000 0x0 0x10000>;
> +	};
> +
>  	sys_grf: syscon@fd58c000 {
>  		compatible =3D "rockchip,rk3588-sys-grf", "syscon";
>  		reg =3D <0x0 0xfd58c000 0x0 0x1000>;
> @@ -1112,6 +1117,17 @@ qos_vop_m1: qos@fdf82200 {
>  		reg =3D <0x0 0xfdf82200 0x0 0x20>;
>  	};
> =20
> +	dfi: dfi@fe060000 {
> +		reg =3D <0x00 0xfe060000 0x00 0x10000>;
> +		compatible =3D "rockchip,rk3588-dfi";
> +		interrupts =3D <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH 0>,
> +			     <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH 0>,
> +			     <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH 0>,
> +			     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH 0>;
> +		interrupt-names =3D "ch0", "ch1", "ch2", "ch3";
> +		rockchip,pmu =3D <&pmu1grf>;
> +	};
> +
>  	gmac1: ethernet@fe1c0000 {
>  		compatible =3D "rockchip,rk3588-gmac", "snps,dwmac-4.20a";
>  		reg =3D <0x0 0xfe1c0000 0x0 0x10000>;
> --=20
> 2.39.2
>=20

--mrx4igmyearfat7p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmSIlxUACgkQ2O7X88g7
+ppIDA//WR0R31t307KcfvZ9jJLxYNQIh7CaH3HbyqW7+sNvWtE+rXSagxXNxkL8
VNpRElARVtbqfT0tNeK2zjrbjU5zl2ZuBtEWDlFHpBvLmO66ArdjKuKb1Qk4NgZJ
SkYWFcNgzNNqoZfhbrADBuBlCBzr0cHHTScqYTcCMMgcrHyed0EsFZ4wJyhxVQUc
cWen5lS7J/fEiyKJmhZtvd3n0NnlAhtNjT0EzI1Mod+otdxfCuWE1ePB3rRcsK6D
S26j8KM98N/B05+nmbKSmpNpsLswyraLkb8KrgtVSRqhifAG2/+Wr+jIOQGurnAJ
0Vn/i3tXy38W1POgE5yXhoIT0hu86hlhtvHuKe8n3ryVbtCEtKVxyjBGLcrnQX9z
xZMCYtMBppHaapVg0HwPlqDozRLFKOWDXiW30eWqqYBWzPVwS18SQa4TivqQ1lsx
L3LFYpdX2QFUIGKq2cOoGDYNXhOiaNH6nGsEhdlggvEuzLdAmPNK17DNQZO8eMO2
FIjEl5/K1jMSV/uP95SUWhUMjUHf+Lokby2KgQbpVNE0qmalWv8vga824k+t38Sr
Q14OSHO+8GXo6xvQhVFjJf0IOnb7mTWBZGMnGpEO5oKBt7XngH9G1sx/ohRNMSs+
0KAr2sXEvP7bsWb+nQdNL6ZhowQIWu14LSVxD0MWHKjNRXs5Yh0=
=jDvv
-----END PGP SIGNATURE-----

--mrx4igmyearfat7p--
