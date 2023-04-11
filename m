Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520AF6DE63F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 23:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjDKVPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 17:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjDKVPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 17:15:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCF8449A;
        Tue, 11 Apr 2023 14:15:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E865B62B96;
        Tue, 11 Apr 2023 21:15:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E05AC4339E;
        Tue, 11 Apr 2023 21:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681247751;
        bh=5utrGhW38HkoFEGqEf8o5TKntYH8lTNsjVLTn6Y7/CE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ADGZT1oAr0eMBerDMo2GwFSO6ntEnCVEi3CA6ynTF8RowoM3mxM21P0utx1ScKF58
         qQCYUFaPDk/2fEAAmfzU5HoDp8G1D+wvmupqxzkbyRifxJCLpqD+LdjrizW8rBkmK/
         0EPoJrD2zWTbUvWobpyNURCm2bdh8g2y4Msl7IgRbz3kXXAAYEK38Eez7YG+sYfgx9
         v9/n27T3RC/Jf6oPcKYVAUkXkMvWhpcFy2UO/ECno1CmayFyVw5QVdMaHKtFrKfVZB
         alXxAu17+KvG4h2zYUpz1AnTA66uwGgvtVl5rDn0aVHQo6Zc9JuEcA9AxEdW87GPm6
         j9nKZLp7CJT/w==
Date:   Tue, 11 Apr 2023 22:15:46 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Changhuang Liang <changhuang.liang@starfivetech.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Walker Chen <walker.chen@starfivetech.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v1 6/7] soc: starfive: Add dphy pmu support
Message-ID: <20230411-iron-everybody-70b78e94aee5@spud>
References: <20230411064743.273388-1-changhuang.liang@starfivetech.com>
 <20230411064743.273388-7-changhuang.liang@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Xr1omY7vI0HCAtOr"
Content-Disposition: inline
In-Reply-To: <20230411064743.273388-7-changhuang.liang@starfivetech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Xr1omY7vI0HCAtOr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 10, 2023 at 11:47:42PM -0700, Changhuang Liang wrote:
> Add dphy pmu to turn on/off the dphy power switch.
>=20
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> ---
>  MAINTAINERS                       |  1 +
>  drivers/soc/starfive/jh71xx_pmu.c | 65 +++++++++++++++++++++++++++++++
>  2 files changed, 66 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0b2170e1e4ff..4d958f02403e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19944,6 +19944,7 @@ F:	include/dt-bindings/reset/starfive?jh71*.h
> =20
>  STARFIVE JH71XX PMU CONTROLLER DRIVER
>  M:	Walker Chen <walker.chen@starfivetech.com>
> +M:	Changhuang Liang <changhuang.liang@starfivetech.com>

Unmentioned in the commit message, plus I would like an R-b or an Ack
=66rom Walker.

>  S:	Supported
>  F:	Documentation/devicetree/bindings/power/starfive*
>  F:	drivers/soc/starfive/jh71xx_pmu.c
> diff --git a/drivers/soc/starfive/jh71xx_pmu.c b/drivers/soc/starfive/jh7=
1xx_pmu.c
> index 990db6735c48..d4092ca4dccf 100644
> --- a/drivers/soc/starfive/jh71xx_pmu.c
> +++ b/drivers/soc/starfive/jh71xx_pmu.c
> @@ -24,6 +24,9 @@
>  #define JH71XX_PMU_EVENT_STATUS		0x88
>  #define JH71XX_PMU_INT_STATUS		0x8C
> =20
> +/* DPHY pmu register offset */
> +#define JH71XX_PMU_DPHY_SWITCH		0x00
> +
>  /* sw encourage cfg */
>  #define JH71XX_PMU_SW_ENCOURAGE_EN_LO	0x05
>  #define JH71XX_PMU_SW_ENCOURAGE_EN_HI	0x50
> @@ -94,6 +97,8 @@ static int jh71xx_pmu_get_state(struct jh71xx_pmu_dev *=
pmd, u32 mask, bool *is_o
> =20
>  	if (pmu->match_data->pmu_type =3D=3D JH71XX_PMU_GENERAL)
>  		offset =3D JH71XX_PMU_CURR_POWER_MODE;
> +	else if (pmu->match_data->pmu_type =3D=3D JH71XX_PMU_DPHY)

There are only two options for this "enum", so why `else if`?

> +		offset =3D JH71XX_PMU_DPHY_SWITCH;
> =20
>  	regmap_read(pmu->base, offset, &val);
> =20
> @@ -170,6 +175,23 @@ static int jh71xx_pmu_general_set_state(struct jh71x=
x_pmu_dev *pmd, u32 mask, bo
>  	return 0;
>  }
> =20
> +static int jh71xx_pmu_dphy_set_state(struct jh71xx_pmu_dev *pmd, u32 mas=
k, bool on)
> +{
> +	struct jh71xx_pmu *pmu =3D pmd->pmu;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&pmu->lock, flags);
> +
> +	if (on)
> +		regmap_update_bits(pmu->base, JH71XX_PMU_DPHY_SWITCH, mask, mask);
> +	else
> +		regmap_update_bits(pmu->base, JH71XX_PMU_DPHY_SWITCH, mask, 0);
> +
> +	spin_unlock_irqrestore(&pmu->lock, flags);
> +
> +	return 0;
> +}
> +
>  static int jh71xx_pmu_set_state(struct jh71xx_pmu_dev *pmd, u32 mask, bo=
ol on)
>  {
>  	struct jh71xx_pmu *pmu =3D pmd->pmu;
> @@ -191,6 +213,8 @@ static int jh71xx_pmu_set_state(struct jh71xx_pmu_dev=
 *pmd, u32 mask, bool on)
> =20
>  	if (pmu->match_data->pmu_type =3D=3D JH71XX_PMU_GENERAL)
>  		ret =3D jh71xx_pmu_general_set_state(pmd, mask, on);
> +	else if (pmu->match_data->pmu_type =3D=3D JH71XX_PMU_DPHY)
> +		ret =3D jh71xx_pmu_dphy_set_state(pmd, mask, on);

Perhaps I am verging on over-complication, but I dislike this carry on.
Is this the only time we'll see a power domain provider coming out of
a syscon, or are there likely to be more?
Either way, I think having an ops struct w/ both parse_dt() and the
set_state() implementations would be neater than what you have here.

Very much open to dissenting opinions there though. Emil? Walker?

Cheers,
Conor.

> =20
>  	return ret;
>  }
> @@ -280,6 +304,25 @@ static int jh7110_pmu_general_parse_dt(struct platfo=
rm_device *pdev,
>  	return 0;
>  }
> =20
> +static int jh7110_pmu_dphy_parse_dt(struct platform_device *pdev,
> +				    struct jh71xx_pmu *pmu)
> +{
> +	struct device *parent;
> +	struct device *dev =3D &pdev->dev;
> +
> +	parent =3D pdev->dev.parent;
> +	if (!parent) {
> +		dev_err(dev, "No parent for syscon pmu\n");
> +		return -ENODEV;
> +	}
> +
> +	pmu->base =3D syscon_node_to_regmap(parent->of_node);
> +	if (IS_ERR(pmu->base))
> +		return PTR_ERR(pmu->base);
> +
> +	return 0;
> +}
> +
>  static int jh71xx_pmu_init_domain(struct jh71xx_pmu *pmu, int index)
>  {
>  	struct jh71xx_pmu_dev *pmd;
> @@ -409,10 +452,31 @@ static const struct jh71xx_pmu_match_data jh7110_pm=
u =3D {
>  	.pmu_parse_dt =3D jh7110_pmu_general_parse_dt,
>  };
> =20
> +static const struct jh71xx_domain_info jh7110_dphy_power_domains[] =3D {
> +	[JH7110_PD_DPHY_TX] =3D {
> +		.name =3D "DPHY-TX",
> +		.bit =3D 30,
> +	},
> +	[JH7110_PD_DPHY_RX] =3D {
> +		.name =3D "DPHY-RX",
> +		.bit =3D 31,
> +	},
> +};
> +
> +static const struct jh71xx_pmu_match_data jh7110_pmu_dphy =3D {
> +	.num_domains =3D ARRAY_SIZE(jh7110_dphy_power_domains),
> +	.domain_info =3D jh7110_dphy_power_domains,
> +	.pmu_type =3D JH71XX_PMU_DPHY,
> +	.pmu_parse_dt =3D jh7110_pmu_dphy_parse_dt,
> +};
> +
>  static const struct of_device_id jh71xx_pmu_of_match[] =3D {
>  	{
>  		.compatible =3D "starfive,jh7110-pmu",
>  		.data =3D (void *)&jh7110_pmu,
> +	}, {
> +		.compatible =3D "starfive,jh7110-pmu-dphy",
> +		.data =3D (void *)&jh7110_pmu_dphy,
>  	}, {
>  		/* sentinel */
>  	}
> @@ -429,5 +493,6 @@ static struct platform_driver jh71xx_pmu_driver =3D {
>  builtin_platform_driver(jh71xx_pmu_driver);
> =20
>  MODULE_AUTHOR("Walker Chen <walker.chen@starfivetech.com>");
> +MODULE_AUTHOR("Changhuang Liang <changhuang.liang@starfivetech.com>");
>  MODULE_DESCRIPTION("StarFive JH71XX PMU Driver");
>  MODULE_LICENSE("GPL");
> --=20
> 2.25.1
>=20

--Xr1omY7vI0HCAtOr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZDXOAgAKCRB4tDGHoIJi
0muRAQCRXx5SEVKeJdwy6ees0QA7i97tZDRPO26TmTzuFhmyagD/Xd0OesD2v+P9
fzylrvgYbIioDk+jBC7VGTEeqry7/gg=
=hxzn
-----END PGP SIGNATURE-----

--Xr1omY7vI0HCAtOr--
