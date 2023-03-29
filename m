Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C894F6CF6A3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 00:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjC2W6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 18:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjC2W6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 18:58:45 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF3346AF;
        Wed, 29 Mar 2023 15:58:44 -0700 (PDT)
Received: from mercury (unknown [185.209.196.239])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C6F386603170;
        Wed, 29 Mar 2023 23:58:42 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680130722;
        bh=y7U48RuXUJqEQN0UfcMmQ5lXGvZsqyULU9S+62lSVS0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EQz/cV4BLcpkSriuwlm9SUZ9nNVaOujc2k6wwcJNp8RAu/9dvIL9yY0fj1AFr5U5l
         fleApFlh/ENyGxmSf3d/VVK8OIyRX5//vRYtKLYATv5qB+bb41JQ7bAn+hNPcKVdu4
         IOQxyIdJVHXsLST2R4wyy9sWFLRh/oZ5+EgYFx916Ua8f8m1FYnaJ3eo+ELklk78Zl
         WRIk30HCy8GtMY7LuZpyJrTCV+QNAGReKx6eYotwh9o9ZNAnpLhMQRm2h0ALLcpA6O
         KNrw9SG/RvvpPyzD4476Cp0knWgZEg/VBQwQu6nPzRv0UDre20oi7b7xwhVMI5elXc
         Drxbbb5YUWHAw==
Received: by mercury (Postfix, from userid 1000)
        id 1BFFE1062665; Thu, 30 Mar 2023 00:58:40 +0200 (CEST)
Date:   Thu, 30 Mar 2023 00:58:40 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Hermes Zhang <chenhuiz@axis.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Davis <afd@ti.com>, linux-kernel@vger.kernel.org,
        kernel@axis.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/2] power: supply: bq256xx: Apply TS_IGNORE from
 devicetree
Message-ID: <20230329225840.26op4wdgi5cgtpkj@mercury.elektranox.org>
References: <20230323072347.438932-1-chenhuiz@axis.com>
 <20230323072347.438932-2-chenhuiz@axis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xroj6drwz4f3vnyk"
Content-Disposition: inline
In-Reply-To: <20230323072347.438932-2-chenhuiz@axis.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xroj6drwz4f3vnyk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 23, 2023 at 03:23:47PM +0800, Hermes Zhang wrote:
> TS_IGNORE is default off in bq256xx chip. For some HW which doesn't have
> the NTC, we need to set TS_IGNORE to 1 to make the charge work. The new
> "ti,no-thermistor" is introduced to toggle it.
>=20
> Signed-off-by: Hermes Zhang <chenhuiz@axis.com>
> ---

Does not apply, please rebase against latest power-supply for-next
branch.

-- Sebastian

> Notes:
>     v2: change property name to ti,no-thermistor
>    =20
>     v3: drop "|" in property description
>=20
>  drivers/power/supply/bq256xx_charger.c | 28 ++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>=20
> diff --git a/drivers/power/supply/bq256xx_charger.c b/drivers/power/suppl=
y/bq256xx_charger.c
> index 9cf4936440c9..cacaae1d559b 100644
> --- a/drivers/power/supply/bq256xx_charger.c
> +++ b/drivers/power/supply/bq256xx_charger.c
> @@ -41,6 +41,9 @@
>  #define BQ256XX_IINDPM_MAX_uA		3200000
>  #define BQ256XX_IINDPM_DEF_uA		2400000
> =20
> +#define BQ256XX_TS_IGNORE		BIT(6)
> +#define BQ256XX_TS_IGNORE_SHIFT		6
> +
>  #define BQ256XX_VINDPM_MASK		GENMASK(3, 0)
>  #define BQ256XX_VINDPM_STEP_uV		100000
>  #define BQ256XX_VINDPM_OFFSET_uV	3900000
> @@ -153,6 +156,7 @@
>   * @vindpm: input voltage limit
>   * @ichg_max: maximum fast charge current
>   * @vbatreg_max: maximum charge voltage
> + * @ts_ignore: TS_IGNORE flag
>   */
>  struct bq256xx_init_data {
>  	u32 ichg;
> @@ -163,6 +167,7 @@ struct bq256xx_init_data {
>  	u32 vindpm;
>  	u32 ichg_max;
>  	u32 vbatreg_max;
> +	bool ts_ignore;
>  };
> =20
>  /**
> @@ -259,6 +264,7 @@ struct bq256xx_device {
>   * @bq256xx_set_iterm: pointer to instance specific set_iterm function
>   * @bq256xx_set_iprechg: pointer to instance specific set_iprechg functi=
on
>   * @bq256xx_set_vindpm: pointer to instance specific set_vindpm function
> + * @bq256xx_set_ts_ignore: pointer to instance specific set_ts_ignore fu=
nction
>   *
>   * @bq256xx_def_ichg: default ichg value in microamps
>   * @bq256xx_def_iindpm: default iindpm value in microamps
> @@ -290,6 +296,7 @@ struct bq256xx_chip_info {
>  	int (*bq256xx_set_iterm)(struct bq256xx_device *bq, int iterm);
>  	int (*bq256xx_set_iprechg)(struct bq256xx_device *bq, int iprechg);
>  	int (*bq256xx_set_vindpm)(struct bq256xx_device *bq, int vindpm);
> +	int (*bq256xx_set_ts_ignore)(struct bq256xx_device *bq, bool ts_ignore);
> =20
>  	int bq256xx_def_ichg;
>  	int bq256xx_def_iindpm;
> @@ -670,6 +677,12 @@ static int bq25601d_set_chrg_volt(struct bq256xx_dev=
ice *bq, int vbatreg)
>  						BQ256XX_VBATREG_BIT_SHIFT);
>  }
> =20
> +static int bq256xx_set_ts_ignore(struct bq256xx_device *bq, bool ts_igno=
re)
> +{
> +	return regmap_update_bits(bq->regmap, BQ256XX_INPUT_CURRENT_LIMIT,
> +				BQ256XX_TS_IGNORE, (ts_ignore ? 1 : 0) << BQ256XX_TS_IGNORE_SHIFT);
> +}
> +
>  static int bq256xx_get_prechrg_curr(struct bq256xx_device *bq)
>  {
>  	unsigned int prechg_and_term_curr_lim;
> @@ -1279,6 +1292,7 @@ static const struct bq256xx_chip_info bq256xx_chip_=
info_tbl[] =3D {
>  		.bq256xx_get_iterm =3D bq256xx_get_term_curr,
>  		.bq256xx_get_iprechg =3D bq256xx_get_prechrg_curr,
>  		.bq256xx_get_vindpm =3D bq256xx_get_input_volt_lim,
> +		.bq256xx_set_ts_ignore =3D NULL,
> =20
>  		.bq256xx_set_ichg =3D bq256xx_set_ichg_curr,
>  		.bq256xx_set_iindpm =3D bq256xx_set_input_curr_lim,
> @@ -1316,6 +1330,7 @@ static const struct bq256xx_chip_info bq256xx_chip_=
info_tbl[] =3D {
>  		.bq256xx_set_iterm =3D bq256xx_set_term_curr,
>  		.bq256xx_set_iprechg =3D bq256xx_set_prechrg_curr,
>  		.bq256xx_set_vindpm =3D bq256xx_set_input_volt_lim,
> +		.bq256xx_set_ts_ignore =3D NULL,
> =20
>  		.bq256xx_def_ichg =3D BQ2560X_ICHG_DEF_uA,
>  		.bq256xx_def_iindpm =3D BQ256XX_IINDPM_DEF_uA,
> @@ -1346,6 +1361,7 @@ static const struct bq256xx_chip_info bq256xx_chip_=
info_tbl[] =3D {
>  		.bq256xx_set_iterm =3D bq256xx_set_term_curr,
>  		.bq256xx_set_iprechg =3D bq256xx_set_prechrg_curr,
>  		.bq256xx_set_vindpm =3D bq256xx_set_input_volt_lim,
> +		.bq256xx_set_ts_ignore =3D NULL,
> =20
>  		.bq256xx_def_ichg =3D BQ2560X_ICHG_DEF_uA,
>  		.bq256xx_def_iindpm =3D BQ256XX_IINDPM_DEF_uA,
> @@ -1376,6 +1392,7 @@ static const struct bq256xx_chip_info bq256xx_chip_=
info_tbl[] =3D {
>  		.bq256xx_set_iterm =3D bq256xx_set_term_curr,
>  		.bq256xx_set_iprechg =3D bq256xx_set_prechrg_curr,
>  		.bq256xx_set_vindpm =3D bq256xx_set_input_volt_lim,
> +		.bq256xx_set_ts_ignore =3D NULL,
> =20
>  		.bq256xx_def_ichg =3D BQ2560X_ICHG_DEF_uA,
>  		.bq256xx_def_iindpm =3D BQ256XX_IINDPM_DEF_uA,
> @@ -1406,6 +1423,7 @@ static const struct bq256xx_chip_info bq256xx_chip_=
info_tbl[] =3D {
>  		.bq256xx_set_iterm =3D bq256xx_set_term_curr,
>  		.bq256xx_set_iprechg =3D bq256xx_set_prechrg_curr,
>  		.bq256xx_set_vindpm =3D bq256xx_set_input_volt_lim,
> +		.bq256xx_set_ts_ignore =3D bq256xx_set_ts_ignore,
> =20
>  		.bq256xx_def_ichg =3D BQ25611D_ICHG_DEF_uA,
>  		.bq256xx_def_iindpm =3D BQ256XX_IINDPM_DEF_uA,
> @@ -1436,6 +1454,7 @@ static const struct bq256xx_chip_info bq256xx_chip_=
info_tbl[] =3D {
>  		.bq256xx_set_iterm =3D bq25618_619_set_term_curr,
>  		.bq256xx_set_iprechg =3D bq25618_619_set_prechrg_curr,
>  		.bq256xx_set_vindpm =3D bq256xx_set_input_volt_lim,
> +		.bq256xx_set_ts_ignore =3D bq256xx_set_ts_ignore,
> =20
>  		.bq256xx_def_ichg =3D BQ25618_ICHG_DEF_uA,
>  		.bq256xx_def_iindpm =3D BQ256XX_IINDPM_DEF_uA,
> @@ -1466,6 +1485,7 @@ static const struct bq256xx_chip_info bq256xx_chip_=
info_tbl[] =3D {
>  		.bq256xx_set_iterm =3D bq25618_619_set_term_curr,
>  		.bq256xx_set_iprechg =3D bq25618_619_set_prechrg_curr,
>  		.bq256xx_set_vindpm =3D bq256xx_set_input_volt_lim,
> +		.bq256xx_set_ts_ignore =3D bq256xx_set_ts_ignore,
> =20
>  		.bq256xx_def_ichg =3D BQ25618_ICHG_DEF_uA,
>  		.bq256xx_def_iindpm =3D BQ256XX_IINDPM_DEF_uA,
> @@ -1582,6 +1602,12 @@ static int bq256xx_hw_init(struct bq256xx_device *=
bq)
>  	if (ret)
>  		return ret;
> =20
> +	if (bq->chip_info->bq256xx_set_ts_ignore) {
> +		ret =3D bq->chip_info->bq256xx_set_ts_ignore(bq, bq->init_data.ts_igno=
re);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	power_supply_put_battery_info(bq->charger, bat_info);
> =20
>  	return 0;
> @@ -1616,6 +1642,8 @@ static int bq256xx_parse_dt(struct bq256xx_device *=
bq,
>  	if (ret)
>  		bq->init_data.iindpm =3D bq->chip_info->bq256xx_def_iindpm;
> =20
> +	bq->init_data.ts_ignore =3D device_property_read_bool(bq->dev, "ti,no-t=
hermistor");
> +
>  	return 0;
>  }
> =20
> --=20
> 2.30.2
>=20

--xroj6drwz4f3vnyk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmQkwpcACgkQ2O7X88g7
+po4ZA//WTfB+7L6lPnP4bLUiZeBkgF/ej0grZzJtg6bxpKU2IestEF2zvn6159o
ol+ndgwWUNjmb9PI+OhcP12pOn+rD/rpIpN5hCtPghVUyXjb7SrsX4Tvr/E/9ugm
my5ikJOCoIpDmRdju+GN/GwOLZjxHuxcOfF09Dzni4VWsOyOnDXAfNLlctPDV/1w
+2rqcXLtxnQcp6bgc3eJ1QKKOnclfhO979+SBpwYfCVBjsiebP2vsqps00oVYmvh
b3F5h3WQeUL8dbhwdJr8VhvfXfT7GGKdFZVI8LZvOggUrgHUQV7Oxd4YgLlxPEaz
XC9+1qrKjO1GCiujrspRwK8h/l62nI+3G/cT/KnutfHUO0kEYwKluwBEjwdFSwhr
OQoIVuazwtFIzhAHm5/gRhf3iCIMDp84JtbEDYMCINiTrr4omS5Dh9Svk0BUET/m
ZqlahY73Q43wUz0136eKdzALbjMi6YO5jhdiQ4Y5++/YPPdqqKLErsH/rwCTK8j2
fTwR7iU8SItNY5xuVY+9td83t2rfbog09Ua6Rpk2gz/5q6hE5L/ds/WQebwp7Vzt
JxzhqIpENUx8cBSh4ZFhNUwSwQ1/Kw2JyOunGSEUUX9VSkU4xjEMD1lDXKi7ARrj
igH544WtMs8A0iJ38dSp2Xei2kQ0+kiwWvU1rXQrgfPX3MAmIqc=
=DA45
-----END PGP SIGNATURE-----

--xroj6drwz4f3vnyk--
