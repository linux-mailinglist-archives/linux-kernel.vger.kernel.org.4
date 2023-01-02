Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582B265B794
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 23:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbjABWTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 17:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbjABWSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 17:18:33 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205529592;
        Mon,  2 Jan 2023 14:18:33 -0800 (PST)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E51366600363;
        Mon,  2 Jan 2023 22:18:30 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1672697911;
        bh=0amRXnfzb0pQLiOY33KR64KEmTduWus+T8fx3ll8nJ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ib6AHzaT/9euV+/tfans/k6+v0EbtHd8qiVIbL22r7j4IXYqZz5qMCieJgYF6y3Ht
         RWsT/pPsL9wq3dj74Lb75h1VSRlcTbk0mhgPWTk2ckvHCVUIUuN0F7u21nG0tiHc5b
         wKbCsjIek7Kt2sLQZZKicIOZyKZM1PJZoUH3KyltTU4eNZCDvD7toUd5kro5HidjJC
         eUBdUgtTPuLfx0s1KSCK8MBxpG5xOWQChf0+onNv/JqRRz9o6Ac+rXdf42REMXlBE2
         VWlB3VXo27olYQGbPcUGfg3XavA0AoiA8CHpmNVkpKMnDcuoQU196Ek+PwF0HjBNU6
         e2U/PJsYCLXSA==
Received: by mercury (Postfix, from userid 1000)
        id 7CA55106076E; Mon,  2 Jan 2023 23:18:28 +0100 (CET)
Date:   Mon, 2 Jan 2023 23:18:28 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Chris Morgan <macroalpha82@gmail.com>
Cc:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH v2] power: supply: rk817: Fix unsigned comparison with
 less than zero
Message-ID: <20230102221828.wmg74fbdnlwpxy7i@mercury.elektranox.org>
References: <20221214032316.22392-1-jiapeng.chong@linux.alibaba.com>
 <639b6fb0.4a0a0220.f7fcf.0b2f@mx.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ce24dtn3dyfggawa"
Content-Disposition: inline
In-Reply-To: <639b6fb0.4a0a0220.f7fcf.0b2f@mx.google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ce24dtn3dyfggawa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Dec 15, 2022 at 01:04:14PM -0600, Chris Morgan wrote:
> On Wed, Dec 14, 2022 at 11:23:16AM +0800, Jiapeng Chong wrote:
> > The tmp is defined as u32 type, which results in invalid processing of
> > tmp<0 in function rk817_read_or_set_full_charge_on_boot(). Therefore,
> > drop the comparison.
> >=20
> > drivers/power/supply/rk817_charger.c:828 rk817_read_or_set_full_charge_=
on_boot() warn: unsigned 'tmp' is never less than zero.
> > drivers/power/supply/rk817_charger.c:788 rk817_read_or_set_full_charge_=
on_boot() warn: unsigned 'tmp' is never less than zero.
> >=20
> > Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D3444
> > Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> > Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
>=20
> Looks good to me, thank you.
>=20
> Tested-by: Chris Morgan <macromorgan@hotmail.com>

Thanks, queued to power-supply's fixes branch.

-- Sebastian

> > ---
> > Changes in v2:
> >   -Drop the comparison 'tmp<0'.
> >=20
> >  drivers/power/supply/rk817_charger.c | 4 ----
> >  1 file changed, 4 deletions(-)
> >=20
> > diff --git a/drivers/power/supply/rk817_charger.c b/drivers/power/suppl=
y/rk817_charger.c
> > index 4f9c1c417916..36f807b5ec44 100644
> > --- a/drivers/power/supply/rk817_charger.c
> > +++ b/drivers/power/supply/rk817_charger.c
> > @@ -785,8 +785,6 @@ rk817_read_or_set_full_charge_on_boot(struct rk817_=
charger *charger,
> >  		regmap_bulk_read(rk808->regmap, RK817_GAS_GAUGE_Q_PRES_H3,
> >  				 bulk_reg, 4);
> >  		tmp =3D get_unaligned_be32(bulk_reg);
> > -		if (tmp < 0)
> > -			tmp =3D 0;
> >  		boot_charge_mah =3D ADC_TO_CHARGE_UAH(tmp,
> >  						    charger->res_div) / 1000;
> >  		/*
> > @@ -825,8 +823,6 @@ rk817_read_or_set_full_charge_on_boot(struct rk817_=
charger *charger,
> >  	regmap_bulk_read(rk808->regmap, RK817_GAS_GAUGE_Q_PRES_H3,
> >  			 bulk_reg, 4);
> >  	tmp =3D get_unaligned_be32(bulk_reg);
> > -	if (tmp < 0)
> > -		tmp =3D 0;
> >  	boot_charge_mah =3D ADC_TO_CHARGE_UAH(tmp, charger->res_div) / 1000;
> >  	regmap_bulk_read(rk808->regmap, RK817_GAS_GAUGE_OCV_VOL_H,
> >  			 bulk_reg, 2);
> > --=20
> > 2.20.1.7.g153144c
> >=20

--ce24dtn3dyfggawa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmOzWDAACgkQ2O7X88g7
+prDzQ/8CY7BRhDxv+rq7IHt6D4LQv2wGWqvocdMglHGshROTuTR4lkJUe/hIQt8
TB7XzOXKcexze7CPTu1SH4cjEytwIsTuAkL3XU/YzIjrZK5iuobS7uYKBBUqgj8t
Umo82aaHrbjBHKhjoQXwMc7xIX3m5PgLAcMTjYVQ+Rd5LVZK3yHyK9AHjUQxYCxU
UhPINXDAbts3SCMnp8d6PGv0bUD0Tt1GSoFZfu6hc2QEN15SaR/sacDxwqmWqYTS
jAJ/Y8+aF6OrGQ4rRFjcLKeSqROETzC+4L+sdyjZ1Wd6MlMWbgAmquwZHJtHZpyg
cf2uW0dTK6yPD8YHbjmLRE+2n6pkK0RL9pnM3xyEapKIsPJfbBdDeT0CDtErR8M8
BLSzYB6iBM1f2FFVdCC+bCg8ucB0KkOTFUfoDqI7sF8DnTSqGee2nfB6+qJABELy
JsrMs0s6isrSfyVt5U1xNXk2GP9/C9i+jr9QaN0wm8p/aqkjd22cCv6Z26A67cyn
bqdzHe2ejJAAWa6GFqxDWPkboxjCZ5MKRlfSJ6WLRPSlnShnXJ1X2+I1Qrc1XWuc
z0LoKNSaO2ln/p1Dc1VLM/5gB25IOisU3nhvZ5Ioeh5hhZTZofmJviG2u2I5mFFl
FPBnP3EBRR1C5J66HF37L9C/stV3IaP2mHCFcldg4tP14tbqQbY=
=+Cwj
-----END PGP SIGNATURE-----

--ce24dtn3dyfggawa--
