Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB816FB54E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 18:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbjEHQiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 12:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjEHQhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 12:37:40 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28A36A71;
        Mon,  8 May 2023 09:37:35 -0700 (PDT)
Received: from mercury (195-23-45-170.net.novis.pt [195.23.45.170])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7FD3E66056CE;
        Mon,  8 May 2023 17:37:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683563852;
        bh=fO5izScTRyVHPTwMk7OYZEtF1VDwquhA8HkOV2kHXhc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ftpf01dKkf7sbhbMyc2k9a9Mt2fNy1kkx9WJil8XtjzEuP4lHtiQk2a8VKW0DtZZb
         tcFIqaB5xLmyvY8uSFfoTiKfPsJ0spZ7g6LmDMltzX+yvkpf0zTyVj36xkrnv0MLFy
         YrsNRhVmTYgcxsZvCLbZLU4KMfNuMrMwTeYV+r9OzhB/78itYSZz5UEC6G5RJUizt9
         AShnXFEfrXcKR4wrRaa6FrsCW860lfVKYgmWKqXE7FwBb+K4rntFX9Ga+pm0E4ID9W
         kXENeoe6A6GKengjGktbwjqORKGsyLTVmAo2kAMqlABHIGEqnCc0NquhW+oGkA+2a3
         PKHpmMjn55ihg==
Received: by mercury (Postfix, from userid 1000)
        id BF2471066FA0; Mon,  8 May 2023 13:35:18 +0200 (CEST)
Date:   Mon, 8 May 2023 13:35:18 +0200
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
Subject: Re: [PATCH v4 7/8] power: supply: rt5033_battery: Adopt status
 property from charger
Message-ID: <20230508113518.nfwchl5wusmnkjp6@mercury.elektranox.org>
References: <20230506155435.3005-1-jahau@rocketmail.com>
 <20230506155435.3005-8-jahau@rocketmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="62exsovixfg2cfix"
Content-Disposition: inline
In-Reply-To: <20230506155435.3005-8-jahau@rocketmail.com>
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--62exsovixfg2cfix
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, May 06, 2023 at 05:54:34PM +0200, Jakob Hauser wrote:
> The rt5033-battery fuelgauge can't get a status by itself. The rt5033-cha=
rger
> can, let's get this value.
>=20
> Tested-by: Raymond Hackley <raymondhackley@protonmail.com>
> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
> ---
>  drivers/power/supply/rt5033_battery.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>=20
> diff --git a/drivers/power/supply/rt5033_battery.c b/drivers/power/supply=
/rt5033_battery.c
> index 5c04cf305219..a6520716d813 100644
> --- a/drivers/power/supply/rt5033_battery.c
> +++ b/drivers/power/supply/rt5033_battery.c
> @@ -12,6 +12,26 @@
>  #include <linux/mfd/rt5033-private.h>
>  #include <linux/mfd/rt5033.h>
> =20
> +static int rt5033_battery_get_status(struct i2c_client *client)
> +{
> +	struct power_supply *charger;
> +	union power_supply_propval val;
> +	int ret;
> +
> +	charger =3D power_supply_get_by_name("rt5033-charger");
> +	if (!charger)
> +		return POWER_SUPPLY_STATUS_UNKNOWN;
> +
> +	ret =3D power_supply_get_property(charger, POWER_SUPPLY_PROP_STATUS, &v=
al);
> +	if (ret) {
> +		power_supply_put(charger);
> +		return POWER_SUPPLY_STATUS_UNKNOWN;
> +	}

struct rt5033_battery *battery =3D i2c_get_clientdata(client);
ret =3D power_supply_get_property_from_supplier(battery->psy, POWER_SUPPLY_=
PROP_STATUS, &val);
if (ret)
    val.intval =3D POWER_SUPPLY_STATUS_UNKNOWN;

> +
> +	power_supply_put(charger);
> +	return val.intval;
> +}
> +
>  static int rt5033_battery_get_capacity(struct i2c_client *client)
>  {
>  	struct rt5033_battery *battery =3D i2c_get_clientdata(client);
> @@ -84,6 +104,9 @@ static int rt5033_battery_get_property(struct power_su=
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
> @@ -96,6 +119,7 @@ static enum power_supply_property rt5033_battery_props=
[] =3D {
>  	POWER_SUPPLY_PROP_VOLTAGE_OCV,
>  	POWER_SUPPLY_PROP_PRESENT,
>  	POWER_SUPPLY_PROP_CAPACITY,
> +	POWER_SUPPLY_PROP_STATUS,
>  };
> =20
>  static const struct regmap_config rt5033_battery_regmap_config =3D {
> --=20
> 2.39.2
>=20

Otherwise LGTM.

-- Sebastian

--62exsovixfg2cfix
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmRY3nMACgkQ2O7X88g7
+ppbow/+Jb4FCPWzC6F8Q70mCz+KMOZJtpuJD1RsXNBzsnYaI5lcQjbBZJZbSbi2
ojoT8X2yOaqtpMejD9eAqjWO6xXUDge161AojcuiBo7c5Fs7v5WMU/+QrhWn3moG
kSAGxS2FI+0YhduSXNqm++MuTVTmYvNVkLRcX2lDGtSOEbx8Wb9kYiKsqDFCf3Af
JsorEUTCqB6HCPip3I3YfgOcYRps/DFKgcggeZIXNiNwYEpza+vcE5oHXLXzzk+R
HBQcvg9HPC1iCbFYIb79wgtOzKd3t9qrVJDL579zy8620cfDytm/soIZcFBqQEZV
GM8MtyL8VvMQk7qujXY7V9PDoFTNWhY5fAX41hJkw6LCvPIfgzSEMWSSlZgdR4bc
m8yctkujP4rvSe1dsaZzwI+d4+Yer1e4ECYG6p8jOalkMzwjTZNUVmNdTUH+i4oO
dfmi2uxIvdW3xl5Uhd4/Mnobzi+z8WEGkfkRhrOd4UKmyUFP3s6hZ0lIniZMiqnF
iF5AlorDb3ExNVOH3hWNGUyKlmPr/JKCh0vgRinQ47IDFxyynMtOPU9NHwKarF9J
uQGvwQaPnpyRwXw9fqWLyW42NjKtKdIn9H8A1aQqLq3LlYPGWOes38kgqW1+coaV
WIB2J/rhlHiT8hHTbQ8tI0vDpryg8Q1RvTrF8LITUXGgEU+7tcA=
=OyXU
-----END PGP SIGNATURE-----

--62exsovixfg2cfix--
