Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4497040DD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 00:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343492AbjEOWV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 18:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245707AbjEOWVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 18:21:17 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB73283CF;
        Mon, 15 May 2023 15:21:12 -0700 (PDT)
Received: from mercury (unknown [185.209.196.239])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E820966031F6;
        Mon, 15 May 2023 23:21:10 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684189271;
        bh=TljpJuryyNUQm+r5oLFgy7IGcSJ+Q9wT05wsiU65Aw8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l5tcLAf4N5zEwsMORMvOFHVHWsYTdiFzxns8WMwhHXsOpqVOdtccj7HZ3QsOe9eWX
         bDAck7J6tjdNMksodrmGOIMC9mgFAbizNjjPwwLwISSwB+w5Egbt4TXvgSd9gsOYGY
         0bjD569lCcaUYtaPoy6ToJ/CssJxY5l+F61JkBNqxTcQ2Gjdzvduw2oDgjon1WvirK
         SxlgvN1NTEAYwYdN12mbxVszflgXfs5iKz6jUlofh3/hMeMN1upA+lBWNcz5QHNRZ/
         fHsFiLQwkkvS/QqN96r+jzqPkbynGwWNpFUPnnIhsV0vtm6e4/veFIlrIEfWHHy2Yj
         8Zcz3vuBXy/JA==
Received: by mercury (Postfix, from userid 1000)
        id 5A7971060F7F; Tue, 16 May 2023 00:21:07 +0200 (CEST)
Date:   Tue, 16 May 2023 00:21:07 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     Iskren Chernev <me@iskren.info>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Matheus Castello <matheus@castello.eng.br>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/4] power: max17040: add simple battery cell support
Message-ID: <20230515222107.kwcb6astisbmdcwe@mercury.elektranox.org>
References: <20230308084419.11934-1-clamor95@gmail.com>
 <20230308084419.11934-3-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hkrjka3iyhxlb5qx"
Content-Disposition: inline
In-Reply-To: <20230308084419.11934-3-clamor95@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hkrjka3iyhxlb5qx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 08, 2023 at 10:44:17AM +0200, Svyatoslav Ryhel wrote:
> Simple battery cell allows to pass some constant data
> about battery controlled by this fuel gauge.
>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---

This patch is no longer needed, since the core should automatically
expose the properties with the latest kernel:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D27a2195efa8d26447c40dd4a6299ea0247786d75

-- Sebastian

>  drivers/power/supply/max17040_battery.c | 34 +++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>=20
> diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supp=
ly/max17040_battery.c
> index d1075959dd46..2778ed5b5c14 100644
> --- a/drivers/power/supply/max17040_battery.c
> +++ b/drivers/power/supply/max17040_battery.c
> @@ -141,6 +141,7 @@ struct max17040_chip {
>  	struct regmap			*regmap;
>  	struct delayed_work		work;
>  	struct power_supply		*battery;
> +	struct power_supply_battery_info	*batt_info;
>  	struct chip_data		data;
> =20
>  	/* battery capacity */
> @@ -400,6 +401,28 @@ static int max17040_get_property(struct power_supply=
 *psy,
>  	case POWER_SUPPLY_PROP_CAPACITY_ALERT_MIN:
>  		val->intval =3D chip->low_soc_alert;
>  		break;
> +
> +	case POWER_SUPPLY_PROP_TECHNOLOGY:
> +		val->intval =3D chip->batt_info->technology;
> +		break;
> +	case POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN:
> +		val->intval =3D chip->batt_info->energy_full_design_uwh;
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
> +		val->intval =3D chip->batt_info->charge_full_design_uah;
> +		break;
> +	case POWER_SUPPLY_PROP_TEMP_MIN:
> +		if (chip->batt_info->temp_min =3D=3D INT_MIN)
> +			return -ENODATA;
> +
> +		val->intval =3D chip->batt_info->temp_min * 10;
> +		break;
> +	case POWER_SUPPLY_PROP_TEMP_MAX:
> +		if (chip->batt_info->temp_max =3D=3D INT_MAX)
> +			return -ENODATA;
> +
> +		val->intval =3D chip->batt_info->temp_max * 10;
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -418,6 +441,11 @@ static enum power_supply_property max17040_battery_p=
rops[] =3D {
>  	POWER_SUPPLY_PROP_VOLTAGE_NOW,
>  	POWER_SUPPLY_PROP_CAPACITY,
>  	POWER_SUPPLY_PROP_CAPACITY_ALERT_MIN,
> +	POWER_SUPPLY_PROP_TECHNOLOGY,
> +	POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN,
> +	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
> +	POWER_SUPPLY_PROP_TEMP_MIN,
> +	POWER_SUPPLY_PROP_TEMP_MAX,
>  };
> =20
>  static const struct power_supply_desc max17040_battery_desc =3D {
> @@ -470,6 +498,12 @@ static int max17040_probe(struct i2c_client *client)
>  		return PTR_ERR(chip->battery);
>  	}
> =20
> +	if (client->dev.of_node) {
> +		if (power_supply_get_battery_info(chip->battery, &chip->batt_info))
> +			dev_warn(&client->dev,
> +				 "No monitored battery, some properties will be missing\n");
> +	}
> +
>  	ret =3D max17040_get_version(chip);
>  	if (ret < 0)
>  		return ret;
> --=20
> 2.37.2
>=20

--hkrjka3iyhxlb5qx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmRisFMACgkQ2O7X88g7
+poBdQ//W4rRMW3jBCMvd0Ift+Be0vCAjMBzuaI/dNcZDI50E0Mvm0xFQXm6hgCQ
S1tjwQ3iNsF3eYn+nUZlcOqyT/jk3AMOLipUmqbcsHIck1Yn1gaIp44K0/S6z96z
rpFwYfge7CAE3JSZdfz3iSDlMeOSMX7gzdLuPAcL6rjF22bl54plFh7gCgD1URCr
6ZBrdtEEgYlvT5wMyM0CTf0uctirG4LgULPPVd7gSJ4nQ8KalJ0M67fhvntGKAxP
zAFM+VOKZVhFuQtxExjbUzKZ6kB9MNAtBhFfZ5Wbk5n8IzBn/X4j0aovfc3mJGPE
PitJceG5YrbUaVrQ05Z8b0mkspoHLtOBkC+X4aMRWKh1rvmdYd4U7Ht6fMqB8W/v
RGz9OlNdinkckrypi1UdP9Na3IqWpTR2m/QW8AGkz/E1dkcjUkl1tNDwsKj5Ff1W
0K0WsDj13U2nCsDmAPEj3xkwBtpj0u1oh35EYpA87DEE58YmOUqQf+nESjaUt/U4
KArMCBBWyUwQJJs1DCI/oHV5mrczHwU9HAkXTT+fla29NkJVoZ1ffg//skc5dgfY
XJAdFZS5LueJcHrSifKKxWZDIcka7/e52Tt9dNIaPieWmLtWo7GYNPEE7S27UFiM
6TNzt0C1orsvvKLeiYt5WeMlwtF1Av0rBq1PZ1nM7VfH3KPPz9k=
=IFJn
-----END PGP SIGNATURE-----

--hkrjka3iyhxlb5qx--
