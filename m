Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29487614213
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 01:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiKAAEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 20:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiKAAEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 20:04:43 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F95211A1A;
        Mon, 31 Oct 2022 17:04:42 -0700 (PDT)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3B65766015AC;
        Tue,  1 Nov 2022 00:04:41 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667261081;
        bh=GJXPC4Tp+MoQiGSwNLFc+YOVd5slpPRDx22xYNSXWP0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GePL/uIRZThj291Kv6goIGMVdlQhEMMvxre0ClMjIjjeOoNhvDYnJU/CGUeFEUzyi
         0gcALsqyIJ3Fz2vP1UvHamsO+z/Q/HKdWgqNnDwNP6UD17CwZtY8VrZ99aYV8U/Put
         lf93GF94JRxR74jUxQjxJHuAV30EwJY13AfkHmsulTDyRd1rHJ0HHhKo1N1d8mP6QP
         jkerQPv9+FL5E/DV3T1okZJZvX2GukLvIT1V8v0AvoaWRU7OJ6L7S5aKHVYMgA6JLe
         Dr+Vz2G1GG+IYStCM9YpxrJcSJj/FG+QiwJoTeO/cWE3fNyOK1K+MOJ+ftBLh+koQE
         2LNUTne5upY7w==
Received: by mercury (Postfix, from userid 1000)
        id 4BC8D1061C6F; Tue,  1 Nov 2022 01:04:38 +0100 (CET)
Date:   Tue, 1 Nov 2022 01:04:38 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: mt6360: Use LINEAR_RANGE_IDX()
Message-ID: <20221101000438.yfqhkvdplbbylp67@mercury.elektranox.org>
References: <2c6267efae04a3f64d88baf2e34ea309af438d40.1667208242.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="begqrocyqlrn62m2"
Content-Disposition: inline
In-Reply-To: <2c6267efae04a3f64d88baf2e34ea309af438d40.1667208242.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--begqrocyqlrn62m2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 31, 2022 at 11:25:00AM +0200, Matti Vaittinen wrote:
> Do minor clean-up by using the newly inroduced LINEAR_RANGE_IDX()
> initialization macro.
>=20
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>=20
> ---
> Sorry, this one evaded my original grep so sending an individual patch.
> Would've squashed this with bd99954 one if I spotted it right away.
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/mt6360_charger.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/power/supply/mt6360_charger.c b/drivers/power/supply=
/mt6360_charger.c
> index 3abaa72e0668..92e48e3a4853 100644
> --- a/drivers/power/supply/mt6360_charger.c
> +++ b/drivers/power/supply/mt6360_charger.c
> @@ -113,16 +113,13 @@ enum {
>  	MT6360_RANGE_MAX,
>  };
> =20
> -#define MT6360_LINEAR_RANGE(idx, _min, _min_sel, _max_sel, _step) \
> -	[idx] =3D REGULATOR_LINEAR_RANGE(_min, _min_sel, _max_sel, _step)
> -
>  static const struct linear_range mt6360_chg_range[MT6360_RANGE_MAX] =3D {
> -	MT6360_LINEAR_RANGE(MT6360_RANGE_VMIVR, 3900000, 0, 0x5F, 100000),
> -	MT6360_LINEAR_RANGE(MT6360_RANGE_ICHG, 100000, 0, 0x31, 100000),
> -	MT6360_LINEAR_RANGE(MT6360_RANGE_VOREG, 3900000, 0, 0x51, 10000),
> -	MT6360_LINEAR_RANGE(MT6360_RANGE_AICR, 100000, 0, 0x3F, 50000),
> -	MT6360_LINEAR_RANGE(MT6360_RANGE_IPREC, 100000, 0, 0x0F, 50000),
> -	MT6360_LINEAR_RANGE(MT6360_RANGE_IEOC, 100000, 0, 0x0F, 50000),
> +	LINEAR_RANGE_IDX(MT6360_RANGE_VMIVR, 3900000, 0, 0x5F, 100000),
> +	LINEAR_RANGE_IDX(MT6360_RANGE_ICHG, 100000, 0, 0x31, 100000),
> +	LINEAR_RANGE_IDX(MT6360_RANGE_VOREG, 3900000, 0, 0x51, 10000),
> +	LINEAR_RANGE_IDX(MT6360_RANGE_AICR, 100000, 0, 0x3F, 50000),
> +	LINEAR_RANGE_IDX(MT6360_RANGE_IPREC, 100000, 0, 0x0F, 50000),
> +	LINEAR_RANGE_IDX(MT6360_RANGE_IEOC, 100000, 0, 0x0F, 50000),
>  };
> =20
>  struct mt6360_chg_info {
> --=20
> 2.37.3
>=20
>=20
> --=20
> Matti Vaittinen, Linux device drivers
> ROHM Semiconductors, Finland SWDC
> Kiviharjunlenkki 1E
> 90220 OULU
> FINLAND
>=20
> ~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
> Simon says - in Latin please.
> ~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
> Thanks to Simon Glass for the translation =3D]=20



--begqrocyqlrn62m2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmNgYpUACgkQ2O7X88g7
+ppvhw/9HhHEJFlLPw/VXTLlqn8FyQy11CMGL3NEmgdQg9B07eFCUHyOG1rp8igg
yS4Kdfadh7UYUnUlHgsKqw8M+7vKdDlWGQobgDBpFWettX5gBzf00rXFsv7C8AXP
ZrzTbGeNkGIg305kmmo9dFwNsocW9PfDxjXYtVVDIX2YwVS6NkzOTGVSOE4P3zaz
PIEzeyaucVrJRHCQTPZ7DDdFEN+wvxPBLcCwAoZ6QjTh3LAlnzi52Yd+jzXdHEgS
QUIh96yyueneWYhDTBA2jCkHcMFwDHlqGF0icuLvSTKcm9zf/p/MNhVHoZuvPq36
pj6Q8SYj76+JSahQQ0zcyaIQWtACAoXU9BWKrIaxyEkpoTqmLusOjhHDRo4l/Wye
Jm1Zz83eCRxfFQjpGLbtuM4XyxChwcKpr1uu8ykyGqWoiHAjK2Z+WWIaPviBTpdG
vcdOZWvmLJboM2XmZPo9gpJOgyRDxrRLh1wid0CHZd2BFldmT9wn/kV+vf67Rglw
QVZOTas+Xwab6yGha6yP8ZLCIgTS8FmCuD2hqANQ+zWkgnDPHYdxiSLmfRWSLnST
SE4gM+5BPugVS28fmwKnTRyM5pm9eRqK+LAFSuD1ey+ZXPBvWbbSX2K9+Nk3ejcu
UD2qIzvfI1rTbEmGgW4t1hu+nPR4kTYrV4QZsN+4XqFMA86nz+A=
=jARa
-----END PGP SIGNATURE-----

--begqrocyqlrn62m2--
