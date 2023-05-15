Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555F7704111
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 00:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343539AbjEOWlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 18:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343528AbjEOWlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 18:41:51 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B9DD052;
        Mon, 15 May 2023 15:41:49 -0700 (PDT)
Received: from mercury (unknown [185.254.75.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1F5EA66031CE;
        Mon, 15 May 2023 23:41:48 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684190508;
        bh=d4WOHz/itIcllAhUmjL5igj6NblYjaugfAkGrHLzvoU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EZCijq/Hg/aDRMsWxd5pPeUO1hSaUKXSVgLZFch4NrpZlq2KgAWlzx89iK11n++yp
         sNfQ7AkrvVPVwDKtRsfWA7YwWoFKbpuCWa+9guYNZi/avzrirrwDjkO0m2lLrAbAes
         iuUpYnZoBgohF+pbF3uUKh8+AGQb/FH9UChCeR+Kn2Ia4XJhln6MZ2KSoa/OqA46Fa
         gz376SCpbEuxlkejCMR/eos2otMLIPPGRyopPivjMjkPdzq/PaNBRy/8FFYC4I88Ib
         cxnOXVe/kEtwt7A0lQoplwh28zd11/n2lBvQw7gYO997pZaYN8IH/UnRO3Qw8kiOrF
         3fmkfCY+P6cXw==
Received: by mercury (Postfix, from userid 1000)
        id A1E2E1060F7F; Tue, 16 May 2023 00:41:45 +0200 (CEST)
Date:   Tue, 16 May 2023 00:41:45 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     Iskren Chernev <me@iskren.info>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Matheus Castello <matheus@castello.eng.br>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/4] power: max17040: add passing props from supplier
Message-ID: <20230515224145.u2fos4ln3n6hb567@mercury.elektranox.org>
References: <20230308084419.11934-1-clamor95@gmail.com>
 <20230308084419.11934-4-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wzu5mul2aofxx4qc"
Content-Disposition: inline
In-Reply-To: <20230308084419.11934-4-clamor95@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wzu5mul2aofxx4qc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 08, 2023 at 10:44:18AM +0200, Svyatoslav Ryhel wrote:
> Optionally pass status and health from supplier if
> it supports those props. If cell is online assume it
> is present as well.
>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>

Charger health might be different from battery health, so it's not
safe to inherit. Otherwise LGTM.

-- Sebastian

> ---
>  drivers/power/supply/max17040_battery.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supp=
ly/max17040_battery.c
> index 2778ed5b5c14..6dfce7b1309e 100644
> --- a/drivers/power/supply/max17040_battery.c
> +++ b/drivers/power/supply/max17040_battery.c
> @@ -390,6 +390,7 @@ static int max17040_get_property(struct power_supply =
*psy,
> =20
>  	switch (psp) {
>  	case POWER_SUPPLY_PROP_ONLINE:
> +	case POWER_SUPPLY_PROP_PRESENT:
>  		val->intval =3D max17040_get_online(chip);
>  		break;
>  	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> @@ -402,6 +403,10 @@ static int max17040_get_property(struct power_supply=
 *psy,
>  		val->intval =3D chip->low_soc_alert;
>  		break;
> =20
> +	case POWER_SUPPLY_PROP_STATUS:
> +	case POWER_SUPPLY_PROP_HEALTH:
> +		power_supply_get_property_from_supplier(psy, psp, val);
> +		break;
>  	case POWER_SUPPLY_PROP_TECHNOLOGY:
>  		val->intval =3D chip->batt_info->technology;
>  		break;
> @@ -438,10 +443,13 @@ static const struct regmap_config max17040_regmap =
=3D {
> =20
>  static enum power_supply_property max17040_battery_props[] =3D {
>  	POWER_SUPPLY_PROP_ONLINE,
> +	POWER_SUPPLY_PROP_PRESENT,
>  	POWER_SUPPLY_PROP_VOLTAGE_NOW,
>  	POWER_SUPPLY_PROP_CAPACITY,
>  	POWER_SUPPLY_PROP_CAPACITY_ALERT_MIN,
>  	POWER_SUPPLY_PROP_TECHNOLOGY,
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_HEALTH,
>  	POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN,
>  	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
>  	POWER_SUPPLY_PROP_TEMP_MIN,
> --=20
> 2.37.2
>=20

--wzu5mul2aofxx4qc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmRitSkACgkQ2O7X88g7
+pq/0A/+I4vXvShMtC+fNF3QMIgpJd9z/K/fBKnBmZUVEp5QaMFjf5tDQNtu5aAi
Fif/vSRflgryt2E7/W0ijnepA+N+nuRS20M6XT6+UtEW9L93Tby74YA/C8qjJFSz
ZAKdJnh0rI00yQohehXZLMCQYhJKSiv9LkbDyAihiF/DlKRbj4we1lMdcyNF2pO6
bizrcDuFBB1uJ87kVJESuOn/Td4ToXECNHXNDjYjM3VSSMAY4JYtL6wDIfwTBX9I
R9u8f2H2UZXNulwHvpcAt7u7VyATDg2xkXDoTtb9HTOOKaTdhauKLNHyvOK8Yz1G
r3EJzuHVf2XGivD2YvVqEKD0CHuS0uAfQCkv9TND0GA1tuqonFtdUGs8Xvx0CM5q
MQT4MLeco6qQkIBa7NyZO8GvKaGOak/Ci50JCjuXaDmehZmieY0mYFbJxkq6GO9E
EsgoRVXNkMmXaofLIuuaHZJ3PBbRfmatGQNJaq8iWxixxeV4koGcshI2CbF86PEp
n0CTKzzt1WCLf8xqYnWjssnrWACyycdls+hVI7W+xR5AlyKTYl5vqh5+qxyeDu5D
WSi9vhMgxMe2P7Ol4FyZdAkKsU9xWw7M3qLBFxAKYdOGuztbcPESWB3TTf/vTrZI
5DW6jsdKqxptcK2m3kVTdDlbukjVa971k4yXkLfbQ98L52Gxw3A=
=OzHL
-----END PGP SIGNATURE-----

--wzu5mul2aofxx4qc--
