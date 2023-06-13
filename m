Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8A872E855
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 18:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243134AbjFMQXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 12:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240854AbjFMQXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 12:23:45 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E09E4;
        Tue, 13 Jun 2023 09:23:44 -0700 (PDT)
Received: from mercury (dyndsl-091-248-189-170.ewe-ip-backbone.de [91.248.189.170])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 02A5A6606EF9;
        Tue, 13 Jun 2023 17:23:43 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686673423;
        bh=kpUFFhofliw9o9CoIf+1DqWTD35mdgeNwKQk9gR2ng4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RIn+xRO3MRYpHoktaHMpp80b6HJZ27r8mShn/yCuIRRweCChP2XfpL8I9t4BHDOlB
         OkcBqadUhHlctaQz4xtxl9QGXneq5egH9em3afUd6ik90xy3oy+DK0rl4xO19T1SqR
         Tw9lvj/1SXu7Y/HyJrrdkhsy+AdI9VsyrJIAhpSN989YDtRjZ2uYdNYswDb8o87OWP
         ll09jYoZKxNi1xrHSBWo1p0BPDGh+ZGfZRT1LewNeYcOko98JM3m86250W632YkPEt
         Jxek/RSkGXCHxF+dYP+Ax7qTf2zqY6bAJc40r1b0F2OIFy7g2nQdFlFYl/3ezlAeu3
         +3UeIyMJqGhaw==
Received: by mercury (Postfix, from userid 1000)
        id BAEB81066FBA; Tue, 13 Jun 2023 18:23:40 +0200 (CEST)
Date:   Tue, 13 Jun 2023 18:23:40 +0200
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
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v5 03/25] PM / devfreq: rockchip-dfi: use consistent name
 for private data struct
Message-ID: <20230613162340.b3auohjeuedyrfoi@mercury.elektranox.org>
References: <20230524083153.2046084-1-s.hauer@pengutronix.de>
 <20230524083153.2046084-4-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dgalcat5phmfgcqn"
Content-Disposition: inline
In-Reply-To: <20230524083153.2046084-4-s.hauer@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dgalcat5phmfgcqn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 24, 2023 at 10:31:31AM +0200, Sascha Hauer wrote:
> The variable name for the private data struct is 'info' in some
> functions and 'data' in others. Both names do not give a clue what
> type the variable has, so consistently use 'dfi'.
>=20
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/devfreq/event/rockchip-dfi.c | 72 ++++++++++++++--------------
>  1 file changed, 36 insertions(+), 36 deletions(-)
>=20
> diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event=
/rockchip-dfi.c
> index 467f9f42d38f7..e19e5acaa362c 100644
> --- a/drivers/devfreq/event/rockchip-dfi.c
> +++ b/drivers/devfreq/event/rockchip-dfi.c
> @@ -59,13 +59,13 @@ struct rockchip_dfi {
> =20
>  static void rockchip_dfi_start_hardware_counter(struct devfreq_event_dev=
 *edev)
>  {
> -	struct rockchip_dfi *info =3D devfreq_event_get_drvdata(edev);
> -	void __iomem *dfi_regs =3D info->regs;
> +	struct rockchip_dfi *dfi =3D devfreq_event_get_drvdata(edev);
> +	void __iomem *dfi_regs =3D dfi->regs;
>  	u32 val;
>  	u32 ddr_type;
> =20
>  	/* get ddr type */
> -	regmap_read(info->regmap_pmu, RK3399_PMUGRF_OS_REG2, &val);
> +	regmap_read(dfi->regmap_pmu, RK3399_PMUGRF_OS_REG2, &val);
>  	ddr_type =3D (val >> RK3399_PMUGRF_DDRTYPE_SHIFT) &
>  		    RK3399_PMUGRF_DDRTYPE_MASK;
> =20
> @@ -84,28 +84,28 @@ static void rockchip_dfi_start_hardware_counter(struc=
t devfreq_event_dev *edev)
> =20
>  static void rockchip_dfi_stop_hardware_counter(struct devfreq_event_dev =
*edev)
>  {
> -	struct rockchip_dfi *info =3D devfreq_event_get_drvdata(edev);
> -	void __iomem *dfi_regs =3D info->regs;
> +	struct rockchip_dfi *dfi =3D devfreq_event_get_drvdata(edev);
> +	void __iomem *dfi_regs =3D dfi->regs;
> =20
>  	writel_relaxed(SOFTWARE_DIS, dfi_regs + DDRMON_CTRL);
>  }
> =20
>  static int rockchip_dfi_get_busier_ch(struct devfreq_event_dev *edev)
>  {
> -	struct rockchip_dfi *info =3D devfreq_event_get_drvdata(edev);
> +	struct rockchip_dfi *dfi =3D devfreq_event_get_drvdata(edev);
>  	u32 tmp, max =3D 0;
>  	u32 i, busier_ch =3D 0;
> -	void __iomem *dfi_regs =3D info->regs;
> +	void __iomem *dfi_regs =3D dfi->regs;
> =20
>  	rockchip_dfi_stop_hardware_counter(edev);
> =20
>  	/* Find out which channel is busier */
>  	for (i =3D 0; i < RK3399_DMC_NUM_CH; i++) {
> -		info->ch_usage[i].access =3D readl_relaxed(dfi_regs +
> +		dfi->ch_usage[i].access =3D readl_relaxed(dfi_regs +
>  				DDRMON_CH0_DFI_ACCESS_NUM + i * 20) * 4;
> -		info->ch_usage[i].total =3D readl_relaxed(dfi_regs +
> +		dfi->ch_usage[i].total =3D readl_relaxed(dfi_regs +
>  				DDRMON_CH0_COUNT_NUM + i * 20);
> -		tmp =3D info->ch_usage[i].access;
> +		tmp =3D dfi->ch_usage[i].access;
>  		if (tmp > max) {
>  			busier_ch =3D i;
>  			max =3D tmp;
> @@ -118,20 +118,20 @@ static int rockchip_dfi_get_busier_ch(struct devfre=
q_event_dev *edev)
> =20
>  static int rockchip_dfi_disable(struct devfreq_event_dev *edev)
>  {
> -	struct rockchip_dfi *info =3D devfreq_event_get_drvdata(edev);
> +	struct rockchip_dfi *dfi =3D devfreq_event_get_drvdata(edev);
> =20
>  	rockchip_dfi_stop_hardware_counter(edev);
> -	clk_disable_unprepare(info->clk);
> +	clk_disable_unprepare(dfi->clk);
> =20
>  	return 0;
>  }
> =20
>  static int rockchip_dfi_enable(struct devfreq_event_dev *edev)
>  {
> -	struct rockchip_dfi *info =3D devfreq_event_get_drvdata(edev);
> +	struct rockchip_dfi *dfi =3D devfreq_event_get_drvdata(edev);
>  	int ret;
> =20
> -	ret =3D clk_prepare_enable(info->clk);
> +	ret =3D clk_prepare_enable(dfi->clk);
>  	if (ret) {
>  		dev_err(&edev->dev, "failed to enable dfi clk: %d\n", ret);
>  		return ret;
> @@ -149,13 +149,13 @@ static int rockchip_dfi_set_event(struct devfreq_ev=
ent_dev *edev)
>  static int rockchip_dfi_get_event(struct devfreq_event_dev *edev,
>  				  struct devfreq_event_data *edata)
>  {
> -	struct rockchip_dfi *info =3D devfreq_event_get_drvdata(edev);
> +	struct rockchip_dfi *dfi =3D devfreq_event_get_drvdata(edev);
>  	int busier_ch;
> =20
>  	busier_ch =3D rockchip_dfi_get_busier_ch(edev);
> =20
> -	edata->load_count =3D info->ch_usage[busier_ch].access;
> -	edata->total_count =3D info->ch_usage[busier_ch].total;
> +	edata->load_count =3D dfi->ch_usage[busier_ch].access;
> +	edata->total_count =3D dfi->ch_usage[busier_ch].total;
> =20
>  	return 0;
>  }
> @@ -176,47 +176,47 @@ MODULE_DEVICE_TABLE(of, rockchip_dfi_id_match);
>  static int rockchip_dfi_probe(struct platform_device *pdev)
>  {
>  	struct device *dev =3D &pdev->dev;
> -	struct rockchip_dfi *data;
> +	struct rockchip_dfi *dfi;
>  	struct devfreq_event_desc *desc;
>  	struct device_node *np =3D pdev->dev.of_node, *node;
> =20
> -	data =3D devm_kzalloc(dev, sizeof(struct rockchip_dfi), GFP_KERNEL);
> -	if (!data)
> +	dfi =3D devm_kzalloc(dev, sizeof(*dfi), GFP_KERNEL);
> +	if (!dfi)
>  		return -ENOMEM;
> =20
> -	data->regs =3D devm_platform_ioremap_resource(pdev, 0);
> -	if (IS_ERR(data->regs))
> -		return PTR_ERR(data->regs);
> +	dfi->regs =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(dfi->regs))
> +		return PTR_ERR(dfi->regs);
> =20
> -	data->clk =3D devm_clk_get(dev, "pclk_ddr_mon");
> -	if (IS_ERR(data->clk))
> -		return dev_err_probe(dev, PTR_ERR(data->clk),
> +	dfi->clk =3D devm_clk_get(dev, "pclk_ddr_mon");
> +	if (IS_ERR(dfi->clk))
> +		return dev_err_probe(dev, PTR_ERR(dfi->clk),
>  				     "Cannot get the clk pclk_ddr_mon\n");
> =20
>  	node =3D of_parse_phandle(np, "rockchip,pmu", 0);
>  	if (!node)
>  		return dev_err_probe(&pdev->dev, -ENODEV, "Can't find pmu_grf register=
s\n");
> =20
> -	data->regmap_pmu =3D syscon_node_to_regmap(node);
> +	dfi->regmap_pmu =3D syscon_node_to_regmap(node);
>  	of_node_put(node);
> -	if (IS_ERR(data->regmap_pmu))
> -		return PTR_ERR(data->regmap_pmu);
> +	if (IS_ERR(dfi->regmap_pmu))
> +		return PTR_ERR(dfi->regmap_pmu);
> =20
> -	data->dev =3D dev;
> +	dfi->dev =3D dev;
> =20
> -	desc =3D &data->desc;
> +	desc =3D &dfi->desc;
>  	desc->ops =3D &rockchip_dfi_ops;
> -	desc->driver_data =3D data;
> +	desc->driver_data =3D dfi;
>  	desc->name =3D np->name;
> =20
> -	data->edev =3D devm_devfreq_event_add_edev(&pdev->dev, desc);
> -	if (IS_ERR(data->edev)) {
> +	dfi->edev =3D devm_devfreq_event_add_edev(&pdev->dev, desc);
> +	if (IS_ERR(dfi->edev)) {
>  		dev_err(&pdev->dev,
>  			"failed to add devfreq-event device\n");
> -		return PTR_ERR(data->edev);
> +		return PTR_ERR(dfi->edev);
>  	}
> =20
> -	platform_set_drvdata(pdev, data);
> +	platform_set_drvdata(pdev, dfi);
> =20
>  	return 0;
>  }
> --=20
> 2.39.2
>=20

--dgalcat5phmfgcqn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmSImAwACgkQ2O7X88g7
+pooeg//R6QXYbOjTiT/p0zIfYz72CO2PV3O/F/JuR5GPfY929qHn5jMvKQMjF+8
/91G7GC8cdEGdBdjajaBz+9Jncyv5ZSGDOVgkmVkATSZqvrM9M+sguDHpN384q+z
TDrX0ucUA/ZtWt41bsjoxA+uHWbkS6beWapXqypEEt3zHGuTra6fkygvKx9kDfMt
MHjeqPwEpV5Ev/Ay5IyoxGhiHXbs0xJAJcmeEQzHCANR+omDjSjx2jOEiXaat1uT
J/YD1TOJ1cBF3V2U8Mo/MiOc8p4eHQHkeWueIyMWJM/SwngGXRP1UQo4nceWHpxb
r/gn7VJKsA+IIZHiBmXuHtd4wthVtNu+vq8KMLj1IzacqP/VS6oGluCz/Ys3PW8G
85UPuNBskXXdrqGUqDveRItmwIb4uPhVqDEUWIwU9CsqRHXUaZfAq8+FTEU++NeH
JaYpcWFiXeyaux7l2vBZJTSwfanGvqyOk6XfaQ58TgLG0kV7qbqr6DVgDnq8ti+7
iMagZulI6y6OXxC+klyPBR0Ip/1te8/E9BZY2Zomdq7eJWs7zXkb5G9N5ZJIJxsj
WOucHV5kLtadCuPLlitUx+0KfCxRh5brOYPgN1wmaYOcqaKPW8MA/qKlJQATRCaZ
rrQY/QMD5bq0EkZ31Oq3wbN8HSA01PpSfCFjKrZdVADyTkp8Cyo=
=I9Sj
-----END PGP SIGNATURE-----

--dgalcat5phmfgcqn--
