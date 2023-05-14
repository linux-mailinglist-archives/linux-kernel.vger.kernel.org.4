Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F23CE702091
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 00:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235149AbjENWsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 18:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234652AbjENWsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 18:48:13 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AA510F0;
        Sun, 14 May 2023 15:48:07 -0700 (PDT)
Received: from mercury (unknown [185.209.196.239])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6066D660574D;
        Sun, 14 May 2023 23:48:06 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684104486;
        bh=Fo3DQnPl5zH+RvFgab/KAI4AhdhkkrrYtnUMGaOiDp0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NPUAo7RbdgsTN6fvrFYMtqY7xfzUDClXxp9bFq9+GyY390QnGfa03+DhCIrNdZsLl
         NeLHkqrIXSCSfip/xVIXurqX2Y+k2cy3ZOkbFlh+JQ3mupS7bAFdFU6bkts82zBDM+
         HUJKFjmrsFVd85BBfnnAp9qtpuvEKu5pTPwvE89Pc56mLYtDHyv8t1luO/7Vd1Vzlz
         O9gUReSpZYxDka2mzJ0jkUm4CXAeoZ4ZgLZWGh0665/4lLML0ZtoiqF8g9qxykz3SU
         giRItxhBpnjhMz/zH+90SSSW2nl1eBxjTpVX44V/5WoBtZfotVBPIjpR0IJz1iich3
         6tJ4MXVpPnbSw==
Received: by mercury (Postfix, from userid 1000)
        id 5B8E11061381; Mon, 15 May 2023 00:48:03 +0200 (CEST)
Date:   Mon, 15 May 2023 00:48:03 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Lee Jones <lee@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        Pavel Machek <pavel@ucw.cz>, Axel Lin <axel.lin@ingics.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Henrik Grimler <henrik@grimler.se>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v5 08/10] power: supply: rt5033_battery: Adopt status
 property from charger
Message-ID: <20230514224803.bm7bid6pl7li5kw7@mercury.elektranox.org>
References: <20230514123130.41172-1-jahau@rocketmail.com>
 <20230514123130.41172-9-jahau@rocketmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wnpndftndndgv62m"
Content-Disposition: inline
In-Reply-To: <20230514123130.41172-9-jahau@rocketmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wnpndftndndgv62m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, May 14, 2023 at 02:31:28PM +0200, Jakob Hauser wrote:
> The rt5033-battery fuelgauge can't get a status by itself. The rt5033-cha=
rger
> can, let's get this value.
>=20
> To get the charger as a "supplier" from the devicetree, the "of_node" nee=
ds
> to be initiated.
>=20
> Additionally, in the probe function replace dev_err() with dev_err_probe(=
),
> this will avoid printing an error for -EPROBE_DEFER when the battery driv=
er
> probes before the charger driver.
>=20
> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
> ---

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/power/supply/rt5033_battery.c | 29 +++++++++++++++++++++------
>  1 file changed, 23 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/power/supply/rt5033_battery.c b/drivers/power/supply=
/rt5033_battery.c
> index 91e1efd81f69..94d2dea7ef5e 100644
> --- a/drivers/power/supply/rt5033_battery.c
> +++ b/drivers/power/supply/rt5033_battery.c
> @@ -19,6 +19,21 @@ struct rt5033_battery {
>  	struct power_supply	*psy;
>  };
> =20
> +static int rt5033_battery_get_status(struct i2c_client *client)
> +{
> +	struct rt5033_battery *battery =3D i2c_get_clientdata(client);
> +	union power_supply_propval val;
> +	int ret;
> +
> +	ret =3D power_supply_get_property_from_supplier(battery->psy,
> +						POWER_SUPPLY_PROP_STATUS,
> +						&val);
> +	if (ret)
> +		val.intval =3D POWER_SUPPLY_STATUS_UNKNOWN;
> +
> +	return val.intval;
> +}
> +
>  static int rt5033_battery_get_capacity(struct i2c_client *client)
>  {
>  	struct rt5033_battery *battery =3D i2c_get_clientdata(client);
> @@ -91,6 +106,9 @@ static int rt5033_battery_get_property(struct power_su=
pply *psy,
>  	case POWER_SUPPLY_PROP_CAPACITY:
>  		val->intval =3D rt5033_battery_get_capacity(battery->client);
>  		break;
> +	case POWER_SUPPLY_PROP_STATUS:
> +		val->intval =3D rt5033_battery_get_status(battery->client);
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -103,6 +121,7 @@ static enum power_supply_property rt5033_battery_prop=
s[] =3D {
>  	POWER_SUPPLY_PROP_VOLTAGE_OCV,
>  	POWER_SUPPLY_PROP_PRESENT,
>  	POWER_SUPPLY_PROP_CAPACITY,
> +	POWER_SUPPLY_PROP_STATUS,
>  };
> =20
>  static const struct regmap_config rt5033_battery_regmap_config =3D {
> @@ -124,7 +143,6 @@ static int rt5033_battery_probe(struct i2c_client *cl=
ient)
>  	struct i2c_adapter *adapter =3D client->adapter;
>  	struct power_supply_config psy_cfg =3D {};
>  	struct rt5033_battery *battery;
> -	u32 ret;
> =20
>  	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE))
>  		return -EIO;
> @@ -142,15 +160,14 @@ static int rt5033_battery_probe(struct i2c_client *=
client)
>  	}
> =20
>  	i2c_set_clientdata(client, battery);
> +	psy_cfg.of_node =3D client->dev.of_node;
>  	psy_cfg.drv_data =3D battery;
> =20
>  	battery->psy =3D power_supply_register(&client->dev,
>  					     &rt5033_battery_desc, &psy_cfg);
> -	if (IS_ERR(battery->psy)) {
> -		dev_err(&client->dev, "Failed to register power supply\n");
> -		ret =3D PTR_ERR(battery->psy);
> -		return ret;
> -	}
> +	if (IS_ERR(battery->psy))
> +		return dev_err_probe(&client->dev, PTR_ERR(battery->psy),
> +				     "Failed to register power supply\n");
> =20
>  	return 0;
>  }
> --=20
> 2.39.2
>=20

--wnpndftndndgv62m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmRhZSMACgkQ2O7X88g7
+prXNw/9H+z2/gVY3vA17vyjAK8L2qmHtgWKoRq5zKWW7a0TYNGbPemM1Cu+xmyq
knztGQF0qjKGUlLI7h93S8frDcq8WLdzuzntvWQE1qhSq/6E1uyJnlrSKqx1MKBY
OernpgcF3MB9SxJN8qswJ3ri7aQnZWPuphYQQC38F0HzcbsO3ujsovaUTphdx46j
i2RV0LMViTyeI+6+Av+QFBWKwSKj6So2Hji6H9ophH9qUXRp3DPQVGgnWFLhkDf8
QocAZEFNTHg1qIr+vOG1rz49OzM8EptIQ65rg1AHKS+ZscoGffd5asn9IDf0RWvK
tALHtSmk4VTW+3rB1uHr/dbn7/JW57ZZ4lofuiSh1is8KRsTquSLjMxsiWwqligD
M3Hde3yoy0I3mcTcdwYTqgGPTbRHA6ShLnTD2uxb7d8IbGf19EPIcv3JG8Sushjz
v6/DkvEf7MTcK9EDdCsDbL20gpLOUoPWlbr0JaHSuVcQudtzjrTikSNjMhy/KjpM
4JbCtgI/r5vPhnw6EnDBCJiTLd/U4fwX79xkL8Ja9s2gcAHiOUMDVPTEEBgryoOH
ly8G35som/nYtJFhtg7NSEQWe81DE6nXuKnbVvQMiL+N9r6a3hdlA0aw4cMHZbrW
6+RRIrC266yMOjzWUppWopOj2HWP/CPNDul039Div7qYFZNV6zo=
=+NFK
-----END PGP SIGNATURE-----

--wnpndftndndgv62m--
