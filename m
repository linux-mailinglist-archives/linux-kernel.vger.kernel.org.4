Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9CC5B5865
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 12:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbiILK26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 06:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbiILK2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 06:28:41 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B513A143;
        Mon, 12 Sep 2022 03:28:39 -0700 (PDT)
Received: from mercury (unknown [185.122.133.20])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B80DC6601FE2;
        Mon, 12 Sep 2022 11:28:37 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662978518;
        bh=AUZz39MJ1TeMrO4UonNRGTYrTySFcK2Xxja2yoOcdUY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cCAqdNUzKRPhRMsYUWUvEc+f9clkxmKbENWgdhvwcT0u1G9+WOv7cNSOrrQnLpDgo
         Bh5gUbsL+n39kZ0DEjO1vhClP9b20uHeyEJkbS+6FVeEkUs46lUi/ZjoR10W+UoYna
         ncwwVdgZfDBzrHx8VqpuoF/ryoAhZiGhQA0MEqzTf2Qw2/Dmb/Dqqww+g+JJI9H3T4
         08lv1XV/lKZq8f6RwYt8gxgL1CZxcHb4BYoOSpKcr5QHvcfOIZxf2+TNikghn/DFKz
         gXe34l60LEk9p/woI3fcCApOL3A6EdyAB2PUiNoKlQb8OADK3Ga8BYz9BYsauacuTf
         Q/LPrGBO923Sg==
Received: by mercury (Postfix, from userid 1000)
        id C83D81063359; Sun, 11 Sep 2022 14:20:41 +0200 (CEST)
Date:   Sun, 11 Sep 2022 14:20:41 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Jules Maselbas <jmaselbas@kalray.eu>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] power: supply: Fix repeated word in comments
Message-ID: <20220911122041.jkbk6isfq2aw25oz@mercury.elektranox.org>
References: <20220826100052.22945-17-jmaselbas@kalray.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dnnejhrv6sb2um4s"
Content-Disposition: inline
In-Reply-To: <20220826100052.22945-17-jmaselbas@kalray.eu>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dnnejhrv6sb2um4s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Aug 26, 2022 at 12:00:45PM +0200, Jules Maselbas wrote:
> Remove redundant word `the`.
>=20
> CC: Sebastian Reichel <sre@kernel.org>
> CC: linux-pm@vger.kernel.org
> Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/power_supply_sysfs.c | 2 +-
>  drivers/power/supply/tps65217_charger.c   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/su=
pply/power_supply_sysfs.c
> index 4239591e1522..5369abaceb5c 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -442,7 +442,7 @@ static int add_prop_uevent(struct device *dev, struct=
 kobj_uevent_env *env,
>  	if (ret =3D=3D -ENODEV || ret =3D=3D -ENODATA) {
>  		/*
>  		 * When a battery is absent, we expect -ENODEV. Don't abort;
> -		 * send the uevent with at least the the PRESENT=3D0 property
> +		 * send the uevent with at least the PRESENT=3D0 property
>  		 */
>  		return 0;
>  	}
> diff --git a/drivers/power/supply/tps65217_charger.c b/drivers/power/supp=
ly/tps65217_charger.c
> index ba33d1617e0b..a4bc9f2a10bc 100644
> --- a/drivers/power/supply/tps65217_charger.c
> +++ b/drivers/power/supply/tps65217_charger.c
> @@ -50,7 +50,7 @@ static int tps65217_config_charger(struct tps65217_char=
ger *charger)
>  	 * tps65217 rev. G, p. 31 (see p. 32 for NTC schematic)
>  	 *
>  	 * The device can be configured to support a 100k NTC (B =3D 3960) by
> -	 * setting the the NTC_TYPE bit in register CHGCONFIG1 to 1. However it
> +	 * setting the NTC_TYPE bit in register CHGCONFIG1 to 1. However it
>  	 * is not recommended to do so. In sleep mode, the charger continues
>  	 * charging the battery, but all register values are reset to default
>  	 * values. Therefore, the charger would get the wrong temperature
> --=20
> 2.17.1
>=20

--dnnejhrv6sb2um4s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmMd0pkACgkQ2O7X88g7
+pr9RA//Xthmi4TJMX9nmjPVDeCfXAh1/Xw+yn7udjk+Ne5VHSJr+PtaIzlVyghq
6mRGcZv1lqTcyyutCmMeWieDIWVoGid4ncYQd8kWF/8BAN/rwxu0ChfYmQPugv6V
yOcl+gTBChypuMYGPI7HixPqwkjBrNum+P9Yk5icW1O3m/R2tgIPaivtFsOhm9VU
nbowHrLQKi2GXSOOnPZgGRpu9DhrTZt+K4i+zMAiQofrC/1IPhFrMXjSKhxr6jJj
reCh5DAyMRX9i+K1ci91mlVMZnhGNEwIKf/dP9ZSLYu5dSnwr3K1+EkmTUXMzz0y
dLzMVCWVNgqv+n7NUXOXpiPQosOeG0BpoaSPeZ1qc3V4BFaAMZh0ZbFW1/4t8UX3
OroO+uEE8482XFTMzFhks2lvkYCNbhvgDm2e5hELO026jmrtkGB6o8CKvogJIiWQ
RT2U1S8e7VaRZhUfyp9WoqZq1+G+mAUNG6Y8wMhORGKkrgH4Yi1UYNqcWhMolie9
ceb+uvVPum1ZcJtQdsSFeLvvjLb1UuMq5tXfdAWuQIxrw3q1WyKYsXMznVH9m8fC
0Z/Djc+siR/oiiUpAhHBqQ2JF2GPWqcfzAhR1rwIBsLTLVQ8s4nGtETZjeM4otg6
ahaRUx65V3WWRnpv00GJUqFmk9QUbR32yfY6pXErEtlYxRDOKk4=
=5Tyf
-----END PGP SIGNATURE-----

--dnnejhrv6sb2um4s--
