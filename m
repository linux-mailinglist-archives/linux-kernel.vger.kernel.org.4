Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE5872E82C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 18:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243121AbjFMQQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 12:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243106AbjFMQQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 12:16:44 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B567E19B3;
        Tue, 13 Jun 2023 09:16:39 -0700 (PDT)
Received: from mercury (dyndsl-091-248-189-170.ewe-ip-backbone.de [91.248.189.170])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D32DA6606EF9;
        Tue, 13 Jun 2023 17:16:37 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686672997;
        bh=VE/+max2Mlkt3YpUqAw/JwuEfVkmt/4kiwUGsGiUfyM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E+ob3Lptalee4kc7E9ETGu6hl+h1NwPpV5Ryh0bPjm3T54RNe/UKAExvDPeXAj5WG
         kFv9UKt3t8oRaRJ7yA3xqHPFcRcF++JB9gNmfSKwz0583oppLSvVnHzNFLJZc9jZVn
         goY9dHQxUkQoU4tNnAwhoiWn6kV7vAkrwSNH8uF8u8/7gZ9B5K5KroigQxwkshRcCy
         C6gD/qSBtKhJnxXfiv7MY8/uKYLnLbNAV7fC4Hj9Z29zsallV4Cj3uWT77UcPqx7yq
         eqmxdjeiHJp+vJ1+dB1IBIkDCdX3LoJl/nxi/oDZws2cXOoi0VN8qb1xKf5JalnpMz
         CHIIn9IhrBuSQ==
Received: by mercury (Postfix, from userid 1000)
        id 2C4A91066FBA; Tue, 13 Jun 2023 18:16:35 +0200 (CEST)
Date:   Tue, 13 Jun 2023 18:16:35 +0200
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
Subject: Re: [PATCH v5 19/25] PM / devfreq: rockchip-dfi: add support for
 RK3588
Message-ID: <20230613161635.2rhx5eebhccg4niu@mercury.elektranox.org>
References: <20230524083153.2046084-1-s.hauer@pengutronix.de>
 <20230524083153.2046084-20-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pwxokmnhbdb7mc7y"
Content-Disposition: inline
In-Reply-To: <20230524083153.2046084-20-s.hauer@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pwxokmnhbdb7mc7y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 24, 2023 at 10:31:47AM +0200, Sascha Hauer wrote:
> Add support for the RK3588 to the driver. The RK3588 has four DDR
> channels with a register stride of 0x4000 between the channel
> registers, also it has a DDRMON_CTRL register per channel.
>=20
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/devfreq/event/rockchip-dfi.c | 30 +++++++++++++++++++++++++++-
>  include/soc/rockchip/rk3588_grf.h    | 18 +++++++++++++++++
>  2 files changed, 47 insertions(+), 1 deletion(-)
>  create mode 100644 include/soc/rockchip/rk3588_grf.h
>=20
> diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event=
/rockchip-dfi.c
> index 23d66fe737975..1410d20f3df80 100644
> --- a/drivers/devfreq/event/rockchip-dfi.c
> +++ b/drivers/devfreq/event/rockchip-dfi.c
> @@ -26,8 +26,9 @@
>  #include <soc/rockchip/rockchip_grf.h>
>  #include <soc/rockchip/rk3399_grf.h>
>  #include <soc/rockchip/rk3568_grf.h>
> +#include <soc/rockchip/rk3588_grf.h>
> =20
> -#define DMC_MAX_CHANNELS	2
> +#define DMC_MAX_CHANNELS	4
> =20
>  #define HIWORD_UPDATE(val, mask)	((val) | (mask) << 16)
> =20
> @@ -711,9 +712,36 @@ static int rk3568_dfi_init(struct rockchip_dfi *dfi)
>  	return 0;
>  };
> =20
> +static int rk3588_dfi_init(struct rockchip_dfi *dfi)
> +{
> +	struct regmap *regmap_pmu =3D dfi->regmap_pmu;
> +	u32 reg2, reg3, reg4;
> +
> +	regmap_read(regmap_pmu, RK3588_PMUGRF_OS_REG2, &reg2);
> +	regmap_read(regmap_pmu, RK3588_PMUGRF_OS_REG3, &reg3);
> +	regmap_read(regmap_pmu, RK3588_PMUGRF_OS_REG4, &reg4);
> +
> +	dfi->ddr_type =3D FIELD_GET(RK3588_PMUGRF_OS_REG2_DRAMTYPE_INFO, reg2);
> +
> +	if (FIELD_GET(RK3588_PMUGRF_OS_REG3_SYSREG_VERSION, reg3) >=3D 0x3)
> +		dfi->ddr_type |=3D FIELD_GET(RK3588_PMUGRF_OS_REG3_DRAMTYPE_INFO_V3, r=
eg3) << 3;
> +
> +	dfi->buswidth[0] =3D FIELD_GET(RK3588_PMUGRF_OS_REG2_BW_CH0, reg2) =3D=
=3D 0 ? 4 : 2;
> +	dfi->buswidth[1] =3D FIELD_GET(RK3588_PMUGRF_OS_REG2_BW_CH1, reg2) =3D=
=3D 0 ? 4 : 2;
> +	dfi->buswidth[2] =3D FIELD_GET(RK3568_PMUGRF_OS_REG2_BW_CH0, reg4) =3D=
=3D 0 ? 4 : 2;
> +	dfi->buswidth[3] =3D FIELD_GET(RK3588_PMUGRF_OS_REG2_BW_CH1, reg4) =3D=
=3D 0 ? 4 : 2;
> +	dfi->channel_mask =3D FIELD_GET(RK3588_PMUGRF_OS_REG2_CH_INFO, reg2) |
> +			    FIELD_GET(RK3588_PMUGRF_OS_REG2_CH_INFO, reg4) << 2;
> +
> +	dfi->ddrmon_stride =3D 0x4000;
> +
> +	return 0;
> +};
> +
>  static const struct of_device_id rockchip_dfi_id_match[] =3D {
>  	{ .compatible =3D "rockchip,rk3399-dfi", .data =3D rk3399_dfi_init },
>  	{ .compatible =3D "rockchip,rk3568-dfi", .data =3D rk3568_dfi_init },
> +	{ .compatible =3D "rockchip,rk3588-dfi", .data =3D rk3588_dfi_init },
>  	{ },
>  };
> =20
> diff --git a/include/soc/rockchip/rk3588_grf.h b/include/soc/rockchip/rk3=
588_grf.h
> new file mode 100644
> index 0000000000000..630b35a550640
> --- /dev/null
> +++ b/include/soc/rockchip/rk3588_grf.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +#ifndef __SOC_RK3588_GRF_H
> +#define __SOC_RK3588_GRF_H
> +
> +#define RK3588_PMUGRF_OS_REG2		0x208
> +#define RK3588_PMUGRF_OS_REG2_DRAMTYPE_INFO		GENMASK(15, 13)
> +#define RK3588_PMUGRF_OS_REG2_BW_CH0			GENMASK(3, 2)
> +#define RK3588_PMUGRF_OS_REG2_BW_CH1                    GENMASK(19, 18)
> +#define RK3588_PMUGRF_OS_REG2_CH_INFO                   GENMASK(29, 28)
> +
> +#define RK3588_PMUGRF_OS_REG3		0x20c
> +#define RK3588_PMUGRF_OS_REG3_DRAMTYPE_INFO_V3		GENMASK(13, 12)
> +#define RK3588_PMUGRF_OS_REG3_SYSREG_VERSION		GENMASK(31, 28)
> +
> +#define RK3588_PMUGRF_OS_REG4           0x210
> +#define RK3588_PMUGRF_OS_REG5           0x214
> +
> +#endif /* __SOC_RK3588_GRF_H */
> --=20
> 2.39.2
>=20

--pwxokmnhbdb7mc7y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmSIllkACgkQ2O7X88g7
+pqqxg//Ru08eJtfd7WQl/Adyz6ldiB1m34JNsRpPS3WRnpZruiK8lAjavvXFrZf
apqhFTb6MkQTDV88k63E/JxRoRZhmcj42i9UGPI+LVapbJ7P10vv1VDr2eWjLBZ8
vnOqTPI1AXvAJUK9v6aDoozrdrZD9vdOcILMwo8oO249JIov3XXN/Vi70prL11SG
4B0KCRm6JwgzXr1wYdCc6jpUu8g7K+WYgHHtpgc5h4vjQC3bQHidfJDp4RWQNB2p
E6ig/NP0hoE8IYX+fWqRL+kSFb6u5wJn0ntNogUP+pb7SfzBIh5Gyy5YKz1dvKDp
mx1s2IzGQNnvRS/bS3oQFzZAVcY6S3fNZp8QgZ9hqu6bG9n1cCRSaf2OzReQvelO
zC00ReXgZTAeF/aWYBhp7GiaTOj8C3m5Mb7qGsKfZf2dSRNJPTbML5k4NmDKO/db
w+Cqlgs0e01jl67CmvzM/DROC+Vig9RzTsylWAgJh7j5eaSFaxnqjJP1hynjeuzr
hyX/f3VzkBwxNNJYo9kD8n9mhX2JL78Hu471bCmoxUVlb3tJEcw8HlzXcxnvvhtp
PFQ0PDqHJ6EKKSEKu6rL1GbDMBy/W16qVgFPqK1LmqzBM9F5DqE1RNkc2hvko+eF
kagas9l5UlztXdu6on+knrBsF5DCbrKxMpv98HdWS6Ow6Q5Jxx8=
=qCmO
-----END PGP SIGNATURE-----

--pwxokmnhbdb7mc7y--
