Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBF769703F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 23:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbjBNV76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 16:59:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233147AbjBNV7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 16:59:52 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7FC117148;
        Tue, 14 Feb 2023 13:59:51 -0800 (PST)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B8686660217C;
        Tue, 14 Feb 2023 21:59:49 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676411989;
        bh=umvdnlXK8Q8qXfGxRr+LD6ap94ksE0y9IEQyzzsAy6U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VpkL/3XYODBw1rF2g5Hc+oIqQsICsxE717FhTvFsNxWyBaKfD3HiM9oraLfkqU8Vb
         52CY+lGFye9YgNI5DunztvaW0oT7U1zMVYddaZQ7I+maLdtPRzsOYhj2Z7McWtAY1v
         EqJjajMDz0Re/E0GyoPrV2CHMeDSccmkkIO+ZRa/wKvPABvdE3ZKjrg6KVl3RmZEYT
         oz0X84WPkXsXZ8JkrpbZ4VXmkc5ZeC2T3qtEoy0WpT0F7cKtpwKQ8BUXA1StGW0cwc
         +xcvc6KDdYCgw+7aGGTF8SpZLKd8T/rxKnuwyK0Yw/YX1j2w4GxaC+PWU6Hm+yF63F
         CI10EvlmkA8gQ==
Received: by mercury (Postfix, from userid 1000)
        id BF2BF10603FE; Tue, 14 Feb 2023 22:59:46 +0100 (CET)
Date:   Tue, 14 Feb 2023 22:59:46 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] power: supply: fix spelling mistake "charing" ->
 "charging"
Message-ID: <20230214215946.m4r73dy5fxds7p3g@mercury.elektranox.org>
References: <20230214092425.265553-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="64xkbddsvhgi7vvf"
Content-Disposition: inline
In-Reply-To: <20230214092425.265553-1-colin.i.king@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--64xkbddsvhgi7vvf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 14, 2023 at 09:24:25AM +0000, Colin Ian King wrote:
> There are spelling mistakes in dev_err_probe messages. Fix them.
>=20
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---

Needs to go through the Qualcomm tree:

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/power/supply/qcom_battmgr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/q=
com_battmgr.c
> index ec31f887184f..5c2353241099 100644
> --- a/drivers/power/supply/qcom_battmgr.c
> +++ b/drivers/power/supply/qcom_battmgr.c
> @@ -1367,7 +1367,7 @@ static int qcom_battmgr_probe(struct auxiliary_devi=
ce *adev,
>  		battmgr->wls_psy =3D devm_power_supply_register(dev, &sc8280xp_wls_psy=
_desc, &psy_cfg_supply);
>  		if (IS_ERR(battmgr->wls_psy))
>  			return dev_err_probe(dev, PTR_ERR(battmgr->wls_psy),
> -					     "failed to register wireless charing power supply\n");
> +					     "failed to register wireless charging power supply\n");
>  	} else {
>  		battmgr->bat_psy =3D devm_power_supply_register(dev, &sm8350_bat_psy_d=
esc, &psy_cfg);
>  		if (IS_ERR(battmgr->bat_psy))
> @@ -1382,7 +1382,7 @@ static int qcom_battmgr_probe(struct auxiliary_devi=
ce *adev,
>  		battmgr->wls_psy =3D devm_power_supply_register(dev, &sm8350_wls_psy_d=
esc, &psy_cfg_supply);
>  		if (IS_ERR(battmgr->wls_psy))
>  			return dev_err_probe(dev, PTR_ERR(battmgr->wls_psy),
> -					     "failed to register wireless charing power supply\n");
> +					     "failed to register wireless charging power supply\n");
>  	}
> =20
>  	battmgr->client =3D devm_pmic_glink_register_client(dev,
> --=20
> 2.30.2
>=20

--64xkbddsvhgi7vvf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmPsBE8ACgkQ2O7X88g7
+pp6SQ//Yall0DcVWRKFJsRKGh1EUrBGE3zpYpHcs4eYWIWI4jn4gQIT5uFObKwJ
tmZVhKeLl0797SN+kLdvbbGoJPxXu5wlDqdQJ91H/BX/1JrsaTxwX/IHZPjfB8WG
0zA1ZWN4MV5L4ZBpDTWuWG5AD2417Uw2MGaW61lEOQssySadSfT+jFiG/ugKR6qC
42CU6/J64NrMaKcRIVOt6a/a/LovaZuwmN/hxLIxKB8t0i7ThdUZSYRmBpRFVkaQ
1JGxrCa8VvYDxdqNX2no2O0hWMTSWMrKdDGIY3BAm051HeSoDrtqVmz0Uecn5Eg5
moiGGRxHZIX6d+xxMUfgSvDZH4oi39SVXcsX3BdfcWgcI8I+OeDFd4Ow9YIyiCI1
aE27egTmuRX0a5zgPjB2emNv63/y3FaDwfQFsXZyyjgxCCwo4Qwkzsfukf/yuobq
G6nOb0q183J8cpoT2HFXP08O0CSH+d4FsV6P5MYzefXU6NbLsP5oNLG51jbarr0z
cxm5X831lrh1JOy0Rgs6HZ7uhiE9ujMChoCGAmI34Ec6FqgjGw3HHBEHsl88+xMr
yZJMGP3FrTnU/FWRlogdGLgj4p4p8QxyReDSCX0bWphbCAi7LUUzNYBk+S34BaJ5
GbsFSQq7dCUz5Y0aESKaO/QBA8ZN5no75jrHO1ZX5RV6/sCzPOc=
=fExG
-----END PGP SIGNATURE-----

--64xkbddsvhgi7vvf--
