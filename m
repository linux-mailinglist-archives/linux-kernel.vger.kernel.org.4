Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3E962E87F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 23:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235083AbiKQWdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 17:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239416AbiKQWdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 17:33:04 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC83786CC;
        Thu, 17 Nov 2022 14:33:03 -0800 (PST)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A340A6602962;
        Thu, 17 Nov 2022 22:33:01 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668724381;
        bh=epnCKNUlH0R3RJaT5zJGgxObsgQEztLgwiepWgoiwP0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DVmosnixqHbgx4dwxCPlSTNy3sMHjExl8eYqjiNZZSPRvhnAUhfMbAD4AxH6R12dW
         5FvgcF6bvrpJxYy2+cUgJlHj5imEHMp1r6MQADKohrjhvdKr9AnCDwIRWdC/tQNFdr
         SwYdQwAkJKG+4zhukBu9ejJiz/g9M2eZz+TmmFUjhx4Ioed3gejtUO+5qRyiSF1Sj/
         isjpXB0qJkJv6gu0s/zsCVL5Ts49q2UOEdIZ66rL+SHDpguusQ1Nj16erw2EQ5nEHE
         7+pvAtyHz2syttlllVnSI7eudvNa/zcJjS4i3eTfalF6WE3NFISN3uQCVoTzKrChh2
         crL7JCwgy8RWg==
Received: by mercury (Postfix, from userid 1000)
        id 6B172106E691; Thu, 17 Nov 2022 23:32:59 +0100 (CET)
Date:   Thu, 17 Nov 2022 23:32:59 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     ye.xingchen@zte.com.cn
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-next] power: supply: core: Use
 device_match_of_node()
Message-ID: <20221117223259.h75ufpadvt2prkfh@mercury.elektranox.org>
References: <202211171530030836446@zte.com.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6icx7neanzbhtjyn"
Content-Disposition: inline
In-Reply-To: <202211171530030836446@zte.com.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6icx7neanzbhtjyn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 17, 2022 at 03:30:03PM +0800, ye.xingchen@zte.com.cn wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
>=20
> Replace the open-code with device_match_of_node().
>=20
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---

struct power_supply !=3D struct device

-- Sebastian

>  drivers/power/supply/power_supply_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/sup=
ply/power_supply_core.c
> index 9035e349bf53..46d0cb0c5026 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -203,7 +203,7 @@ static int  __power_supply_find_supply_from_node(stru=
ct device *dev,
>  	struct power_supply *epsy =3D dev_get_drvdata(dev);
>=20
>  	/* returning non-zero breaks out of class_for_each_device loop */
> -	if (epsy->of_node =3D=3D np)
> +	if (device_match_of_node(epsy, np))
>  		return 1;
>=20
>  	return 0;
> --=20
> 2.25.1

--6icx7neanzbhtjyn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmN2tpcACgkQ2O7X88g7
+przJQ//UGDAianBUJQmAEgTIa11D/+3eSxBgYsecFwCvXo3snBFw5pxGUjwdl0R
OlpwUDuMd+ed+KqN4eI2QpFuTA97/oXgQ+9xW/O5/WepCZuSboLa3ZBUsll/nKVi
g8ybM2VWQAe+oAmhr4dSFRMSmc48Mh+ero1EDqgoPXnda4fOKepgwxwvuaFESEXg
jC4rnGGL9Cik9KEJBX2jsAjVwQuV6Sqx3LN1OIBNdUktJk6pjejbYcFW2PqbdL6S
Z3ijf/P5MXM3HZFJVlEtC/C7hBQE8gqmagraqZwhLhlSlxB4VGZUJxabzaa2DtfO
Z9a9gIqP1L73YJZdl2ydbguPOReWLePABX5VT3SxGAxyGZkZdPJ1O2lmNBtds5L3
lR73GhE38fgt3KFxFcUMz+Wl28ONgOUO9YvYRB2x+p8CISpy70Zktxt2/2mA6ZMM
92jRpwc71LJjMMPEEc+T+Xn2LFLpbosXF7uyPFL9ZrrEfP3GeFuhE0hqhNFa4sY9
4vNjhNODBLLnFm1X7kS3aNc6sK9sVoZUnzQSTcqXO4Slt8kBMqYiu+dDd/uzthQN
deG17rQeq91kyS8jNqwx6uzi/s4AVQLBVjdw/C47fUh33phhpBR23dcReJmWheXL
buMpvZvdVxfhQpdfzHRwcbr7OlCCeBOEa4GtttomH8sPFpPrdbk=
=nUPa
-----END PGP SIGNATURE-----

--6icx7neanzbhtjyn--
