Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDC672E87F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 18:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238560AbjFMQ0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 12:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbjFMQ0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 12:26:31 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3849E4A;
        Tue, 13 Jun 2023 09:26:29 -0700 (PDT)
Received: from mercury (dyndsl-091-248-189-170.ewe-ip-backbone.de [91.248.189.170])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 90CD56606F02;
        Tue, 13 Jun 2023 17:26:28 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686673588;
        bh=PJNaA82l3h2YK+IyLkBxAuI/hFHUcU8f0OMwwfGkI6E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LdtJCgZb4TWILwc4v0I226TaYUr8ygIMXSFatfDGtMACWF81B7tlFHZONFxVQowJX
         xIwsaqMdyPZ2QM4kga6bIHnx6AqWzOpljKQjpA0cB7Zn6kzM+gSuZFitmijD6Pym7g
         U0rGhPJu5np+9IVVPGjpFrBy8aq2okjWy5/PI7xuaPRXivfFIwcWaRoUjMWErCKPHM
         2gIzn/Jw5TrEyS0paXr5AzM226ddzd5l5xgcUUYl4JGuNVo5ppkvdxRrVQpKq/t7qz
         K3H2ME6VY2KKkWXA8JB1KAQgk6TZwv4Jl+GrJnTXtBvJyHDb0OK5I/iAem/LZyyIES
         cpICz54sf3Svg==
Received: by mercury (Postfix, from userid 1000)
        id 2F5FD1066FBA; Tue, 13 Jun 2023 18:26:26 +0200 (CEST)
Date:   Tue, 13 Jun 2023 18:26:26 +0200
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
Subject: Re: [PATCH v5 04/25] PM / devfreq: rockchip-dfi: Add SoC specific
 init function
Message-ID: <20230613162626.s7ijyg7iu6jcrvbq@mercury.elektranox.org>
References: <20230524083153.2046084-1-s.hauer@pengutronix.de>
 <20230524083153.2046084-5-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rx6ubjn2sztmbvp2"
Content-Disposition: inline
In-Reply-To: <20230524083153.2046084-5-s.hauer@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rx6ubjn2sztmbvp2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 24, 2023 at 10:31:32AM +0200, Sascha Hauer wrote:
> Move the RK3399 specifics to a SoC specific init function to make
> the way free for supporting other SoCs later.
>=20
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>=20
> Notes:
>     Changes since v4:
>     - use of_device_get_match_data()
>     - use a callback rather than a struct type as driver data
>=20
>  drivers/devfreq/event/rockchip-dfi.c | 48 +++++++++++++++++++---------
>  1 file changed, 33 insertions(+), 15 deletions(-)
>=20

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

> diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event=
/rockchip-dfi.c
> index e19e5acaa362c..6b1ef29df7048 100644
> --- a/drivers/devfreq/event/rockchip-dfi.c
> +++ b/drivers/devfreq/event/rockchip-dfi.c
> @@ -17,6 +17,7 @@
>  #include <linux/slab.h>
>  #include <linux/list.h>
>  #include <linux/of.h>
> +#include <linux/of_device.h>
> =20
>  #include <soc/rockchip/rk3399_grf.h>
> =20
> @@ -55,27 +56,21 @@ struct rockchip_dfi {
>  	void __iomem *regs;
>  	struct regmap *regmap_pmu;
>  	struct clk *clk;
> +	u32 ddr_type;
>  };
> =20
>  static void rockchip_dfi_start_hardware_counter(struct devfreq_event_dev=
 *edev)
>  {
>  	struct rockchip_dfi *dfi =3D devfreq_event_get_drvdata(edev);
>  	void __iomem *dfi_regs =3D dfi->regs;
> -	u32 val;
> -	u32 ddr_type;
> -
> -	/* get ddr type */
> -	regmap_read(dfi->regmap_pmu, RK3399_PMUGRF_OS_REG2, &val);
> -	ddr_type =3D (val >> RK3399_PMUGRF_DDRTYPE_SHIFT) &
> -		    RK3399_PMUGRF_DDRTYPE_MASK;
> =20
>  	/* clear DDRMON_CTRL setting */
>  	writel_relaxed(CLR_DDRMON_CTRL, dfi_regs + DDRMON_CTRL);
> =20
>  	/* set ddr type to dfi */
> -	if (ddr_type =3D=3D RK3399_PMUGRF_DDRTYPE_LPDDR3)
> +	if (dfi->ddr_type =3D=3D RK3399_PMUGRF_DDRTYPE_LPDDR3)
>  		writel_relaxed(LPDDR3_EN, dfi_regs + DDRMON_CTRL);
> -	else if (ddr_type =3D=3D RK3399_PMUGRF_DDRTYPE_LPDDR4)
> +	else if (dfi->ddr_type =3D=3D RK3399_PMUGRF_DDRTYPE_LPDDR4)
>  		writel_relaxed(LPDDR4_EN, dfi_regs + DDRMON_CTRL);
> =20
>  	/* enable count, use software mode */
> @@ -167,8 +162,26 @@ static const struct devfreq_event_ops rockchip_dfi_o=
ps =3D {
>  	.set_event =3D rockchip_dfi_set_event,
>  };
> =20
> +static int rk3399_dfi_init(struct rockchip_dfi *dfi)
> +{
> +	struct regmap *regmap_pmu =3D dfi->regmap_pmu;
> +	u32 val;
> +
> +	dfi->clk =3D devm_clk_get(dfi->dev, "pclk_ddr_mon");
> +	if (IS_ERR(dfi->clk))
> +		return dev_err_probe(dfi->dev, PTR_ERR(dfi->clk),
> +				     "Cannot get the clk pclk_ddr_mon\n");
> +
> +	/* get ddr type */
> +	regmap_read(regmap_pmu, RK3399_PMUGRF_OS_REG2, &val);
> +	dfi->ddr_type =3D (val >> RK3399_PMUGRF_DDRTYPE_SHIFT) &
> +			RK3399_PMUGRF_DDRTYPE_MASK;
> +
> +	return 0;
> +};
> +
>  static const struct of_device_id rockchip_dfi_id_match[] =3D {
> -	{ .compatible =3D "rockchip,rk3399-dfi" },
> +	{ .compatible =3D "rockchip,rk3399-dfi", .data =3D rk3399_dfi_init },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, rockchip_dfi_id_match);
> @@ -179,6 +192,12 @@ static int rockchip_dfi_probe(struct platform_device=
 *pdev)
>  	struct rockchip_dfi *dfi;
>  	struct devfreq_event_desc *desc;
>  	struct device_node *np =3D pdev->dev.of_node, *node;
> +	int (*soc_init)(struct rockchip_dfi *dfi);
> +	int ret;
> +
> +	soc_init =3D of_device_get_match_data(&pdev->dev);
> +	if (!soc_init)
> +		return -EINVAL;
> =20
>  	dfi =3D devm_kzalloc(dev, sizeof(*dfi), GFP_KERNEL);
>  	if (!dfi)
> @@ -188,11 +207,6 @@ static int rockchip_dfi_probe(struct platform_device=
 *pdev)
>  	if (IS_ERR(dfi->regs))
>  		return PTR_ERR(dfi->regs);
> =20
> -	dfi->clk =3D devm_clk_get(dev, "pclk_ddr_mon");
> -	if (IS_ERR(dfi->clk))
> -		return dev_err_probe(dev, PTR_ERR(dfi->clk),
> -				     "Cannot get the clk pclk_ddr_mon\n");
> -
>  	node =3D of_parse_phandle(np, "rockchip,pmu", 0);
>  	if (!node)
>  		return dev_err_probe(&pdev->dev, -ENODEV, "Can't find pmu_grf register=
s\n");
> @@ -209,6 +223,10 @@ static int rockchip_dfi_probe(struct platform_device=
 *pdev)
>  	desc->driver_data =3D dfi;
>  	desc->name =3D np->name;
> =20
> +	ret =3D soc_init(dfi);
> +	if (ret)
> +		return ret;
> +
>  	dfi->edev =3D devm_devfreq_event_add_edev(&pdev->dev, desc);
>  	if (IS_ERR(dfi->edev)) {
>  		dev_err(&pdev->dev,
> --=20
> 2.39.2
>=20

--rx6ubjn2sztmbvp2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmSImLEACgkQ2O7X88g7
+pqZDQ/+OZcf2EIUTPKqg4spvMldvlmYCa6HcWP2PYnPewWBlAOGuuKx0gsCfIRL
BDskxrVjEgblfAU6TGbH9L/gtCK+Mo2YQcPIeGOANIupI/j4Lq510CTzxvtTRcV+
QlxqCMqnynE3lR3RfDfxHT2u391X7axmzyLXGEhyHlWOQnMrNBM2hDt4v7/hP+Rf
KAaj+c+OuZvucZsgbx2qL+1GldDtYI01LwWp1hpofgwt3s8K2LBumaJyu1HrkfFk
C2XOrVFD+yHLl+iZaN0U/0+36Ncep1IdY0ytJI1USJO4CI3KzZ8q3d5Uz+vHvjV8
T9S1onvR9iiFvSHxsEo82ABJ/hjXUnXH5Xy7xTEpUE92Xc+8otb3xJc+0kFKDF6E
kgWwOuIL2xM1iItYZdMXtAS48a75DyM+2RpNuioyReDS2sNowbJK86WoLwucU3PM
gp6v06jfPbq6PrHy/KVKdjb+sDkYggatA9XgNa3zkOYZ8+EC7fMdu1ZHcvKxnDYO
N5ZoDbYtqISN6x3kGda/67ViEjh7l1qLMl0ujFq8tRA2EcY/IKvoc9dyko+N85ml
rv5gVzJxKZbRvL4lBFzHrQkAbMru3BLk7WcuhDsPq/CoffTWddlhJiKVKsPpK+06
uvsCvubIt/p5bfzTJklQm3oG02bfyH4UimNIwRaf59WWnDphEac=
=jgR8
-----END PGP SIGNATURE-----

--rx6ubjn2sztmbvp2--
