Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0035F62E8A3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 23:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240372AbiKQWpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 17:45:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbiKQWpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 17:45:32 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965901759F;
        Thu, 17 Nov 2022 14:45:31 -0800 (PST)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4CB2D660296C;
        Thu, 17 Nov 2022 22:45:30 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668725130;
        bh=BlB3Rz7T8QoXgHZVNxW0g5BDVbXnsrS8oMHHMQFi+po=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eXCjjDBReW7btfbHgLb8z4deoA3M0i/xtX1xEClolJEwKW0Cl8JNOfhiDNGCkYOVJ
         Za/TkYfNpyyGl5090h84Tjgye9jAVnrAI9BS2nz1mpyRM2khau4TLOHueaIG2tzJ4D
         6nX4FUvyk3PPpnrs3S68uxr36rolurQNqq+Re2pT8BEBtSUlTYZXhv9LMP8a/fz9XO
         BL+kuqNmForZX/qm4oW5Zo4FPV2ZR5+pYonTxSEMuP6+WwzVGADz3T5EKMi1QhecCD
         Lb5GaITeuMcTMYEkFvwxIyxOzSTeySa04YH1q/g2LhIz2mlwfyEriSdNgKD7Awhhci
         ZS2hrRXOgQrbg==
Received: by mercury (Postfix, from userid 1000)
        id 5C87B106E693; Thu, 17 Nov 2022 23:45:27 +0100 (CET)
Date:   Thu, 17 Nov 2022 23:45:27 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Denis Arefev <arefev@swemel.ru>
Cc:     Chen-Yu Tsai <wens@csie.org>, Hans de Goede <hdegoede@redhat.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-patches@linuxtesting.org, trufanov@swemel.ru, vfh@swemel.ru
Subject: Re: [PATCH] power: supply: Added check for negative values
Message-ID: <20221117224527.n5tqfsvteysw6whx@mercury.elektranox.org>
References: <20221117120140.103208-1-arefev@swemel.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mzl5mmussdd44h7g"
Content-Disposition: inline
In-Reply-To: <20221117120140.103208-1-arefev@swemel.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mzl5mmussdd44h7g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 17, 2022 at 03:01:40PM +0300, Denis Arefev wrote:
> Variable 'pirq', which may receive negative value
> in platform_get_irq().
> Used as an index in a function regmap_irq_get_virq().
>=20
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>=20
> Signed-off-by: Denis Arefev <arefev@swemel.ru>
> ---

The patch does not apply. Looks like the patch is based against
ancient code (pre 2022). Also the patch subject prefix should be
'power: supply: axp288_fuel_gauge:'

Thanks,

-- Sebastian

>  drivers/power/supply/axp288_fuel_gauge.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/sup=
ply/axp288_fuel_gauge.c
> index 148eb8105803..36c7039c99c2 100644
> --- a/drivers/power/supply/axp288_fuel_gauge.c
> +++ b/drivers/power/supply/axp288_fuel_gauge.c
> @@ -640,6 +640,8 @@ static void fuel_gauge_init_irq(struct axp288_fg_info=
 *info)
> =20
>  	for (i =3D 0; i < AXP288_FG_INTR_NUM; i++) {
>  		pirq =3D platform_get_irq(info->pdev, i);
> +		if (pirq < 0)
> +			continue;
>  		info->irq[i] =3D regmap_irq_get_virq(info->regmap_irqc, pirq);
>  		if (info->irq[i] < 0) {
>  			dev_warn(&info->pdev->dev,
> --=20
> 2.25.1
>=20

--mzl5mmussdd44h7g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmN2uYMACgkQ2O7X88g7
+po7vA//ZvLpS4SSV/Kpf9bW9GgHck/rt47/tEahbBg7u3oiuPDj0/63tGO73/w8
PyKaoSvOcXinueD7zeni5EgllS8gdq1wDSqcJlC9P2cziJPiySRiZs569XVs+bXi
i8ko9e6lJ9jgdF8mYAqrpSeH1Cmi/oOgMGA6xuZ6wPXtSn6sMFtAa2xMBanXeQo3
DgNceolOM5fj6h4GJTOi7B50CES/+n7ffp10sw0+azV5nDfslg6LXVqBMCTWYm9Q
f4J0uKhMooTiv05f8Cfidfz34DJYnDWMaPcBilCYzHfx9Pp8HZb4qEuHdXQKtU/I
jc9vQV9+PLOMMVdWiY7WlBBaM+5sdWVu7rPnue2pWaI9l2GcUFZJ21GEXiaHp2iv
5vjMEIHPLfaXKPISpw3P7PKcC6JUdv+L65icsuz/w9FkZsgCW5/yI8hEsfxXksW8
ZJOuxDra6qNOA4Nw12K73EbeDYwyvnLSVeDQV6S7gArl1JcM+oyZz8tYI7G9I5p1
9EVE4XXjC7bkRKS6WQhYw/zI3TT8u79+7r83EFFk0p539nloWWIYf2B/cbN9zev+
JNaXiSEo4IR7DDZKu/OlZ0y9U3Mo4xLPchNTWkBH21ILKLugl7kRiNSVi15PGdpS
qqUPjd+5NimBz3AUBMk7man8+7ayqO3gMjQVWjkgQJqmKtzOU3E=
=cRvJ
-----END PGP SIGNATURE-----

--mzl5mmussdd44h7g--
