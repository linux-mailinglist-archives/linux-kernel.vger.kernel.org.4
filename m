Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0B16F5588
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 12:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjECKBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 06:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjECKBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 06:01:40 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD08F1A7;
        Wed,  3 May 2023 03:01:38 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2ac70c975fcso7007581fa.3;
        Wed, 03 May 2023 03:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683108097; x=1685700097;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cbLddoF+dAfHfXpgdlmLObjxEgG+kEshDJTymk4l9ms=;
        b=gI5XkbYsbtK/jwU0afMsdo76wKVXF4M7QiDt3zprFZQ28XDkIjmMXMD2kenFHE65yV
         ohgIcOOnH11dknn3BhPL7HkLAE7ZcO65CyNqAINsi5rBHTRyTaj8SC/B+HOSlRT15CBF
         l2juIQliZwBDGP32kNlp9QmTm7coAlGYJIlZlfYg7mFb6mLf0jUNhj3Lnz/6eXu7Qhry
         wfWvoJZsr2eWay/PnYJyGZ93nFKA5xPxB/I43OjbaT9t0x/XGWIoq/pOavFebqYBL/Ue
         baCm2WRe++NvNI3LW8GsvRP71O9YFt0UWpPmCEMEyxak1vRVWl6nLb8o+Ngp2Iw1iSzk
         tzoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683108097; x=1685700097;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cbLddoF+dAfHfXpgdlmLObjxEgG+kEshDJTymk4l9ms=;
        b=Hc4L9YO3y2IBNL3mVL2L/9/xH2zc8mmKm8OpkkKmh/VvykPbT+10gPKb0oI0LypyW8
         trozfL1pOmxkzjbjPjfs5vh+YeU6zD2O63kQGyhA/u2xhgYYdNJJLsji84EOGmmOv23J
         xQrGfRYMDzXgX+1J+AxKEtgFeAgT0YRyEdYXhpaQ5qTWF/LNFQWbjMyeDEWo3ksk8vzD
         wuZ8DTfoTfoLd/Hc9zc19UI4elJARsanXgTb66Tli0HcUUHrxMHVFb/Ei8Fg2qxt8wyE
         j8zMFAcRY+/NUutPS/Fpov6+v3rjo117bC2cX1an+WPInZsqgOPQ8/wu0PsiY7G8Pypz
         maGg==
X-Gm-Message-State: AC+VfDx0xsVWtPDWRYjVr5Sa/Jxx0rDwKwbpfJnWSL2aoJyzTHNniM57
        mjXs3GL21FkG+5m9eGYB3OWb9n5QDGE=
X-Google-Smtp-Source: ACHHUZ5/8w8sJORF5OVUQCO9GUOzJsjUQD5v0q7aRSE4TjHmG1bFAR+zVnBsXA3gDK7W2HI1v0mARQ==
X-Received: by 2002:a2e:8295:0:b0:2a6:1682:3a1e with SMTP id y21-20020a2e8295000000b002a616823a1emr5224079ljg.31.1683108096971;
        Wed, 03 May 2023 03:01:36 -0700 (PDT)
Received: from fedora (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id y11-20020a05651c020b00b002a8a8f2dc89sm5907418ljn.72.2023.05.03.03.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 03:01:36 -0700 (PDT)
Date:   Wed, 3 May 2023 13:01:32 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: bu27034: Ensure reset is written
Message-ID: <ZFIw/KdApZe1euN8@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Ru/DL4Tb+YxI3Pq5"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Ru/DL4Tb+YxI3Pq5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The reset bit must be always written to the hardware no matter what value
is in a cache or register. Ensure this by using regmap_write_bits()
instead of the regmap_update_bits(). Furthermore, the RESET bit may be
self-clearing, so mark the SYSTEM_CONTROL register volatile to guarantee
we do also read the right state - should we ever need to read it.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Fixes: e52afbd61039 ("iio: light: ROHM BU27034 Ambient Light Sensor")

---
Changelog:
v1 =3D> v2:
  - Fix SoB tag


I haven't verified if the reset bit is self-clearin as I did temporarily
give away the HW.

In worst case the bit is not self clearing - but we don't really
get performance penalty even if we set the register volatile because the
SYSTEM_CONTROL register only has the part-ID and the reset fields. The
part-id is only read once at probe.

---
 drivers/iio/light/rohm-bu27034.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/light/rohm-bu27034.c b/drivers/iio/light/rohm-bu27=
034.c
index 25c9b79574a5..740ebd86b6e5 100644
--- a/drivers/iio/light/rohm-bu27034.c
+++ b/drivers/iio/light/rohm-bu27034.c
@@ -231,6 +231,9 @@ struct bu27034_result {
=20
 static const struct regmap_range bu27034_volatile_ranges[] =3D {
 	{
+		.range_min =3D BU27034_REG_SYSTEM_CONTROL,
+		.range_max =3D BU27034_REG_SYSTEM_CONTROL,
+	}, {
 		.range_min =3D BU27034_REG_MODE_CONTROL4,
 		.range_max =3D BU27034_REG_MODE_CONTROL4,
 	}, {
@@ -1272,7 +1275,7 @@ static int bu27034_chip_init(struct bu27034_data *dat=
a)
 	int ret, sel;
=20
 	/* Reset */
-	ret =3D regmap_update_bits(data->regmap, BU27034_REG_SYSTEM_CONTROL,
+	ret =3D regmap_write_bits(data->regmap, BU27034_REG_SYSTEM_CONTROL,
 			   BU27034_MASK_SW_RESET, BU27034_MASK_SW_RESET);
 	if (ret)
 		return dev_err_probe(data->dev, ret, "Sensor reset failed\n");

base-commit: 7fcbd72176076c44b47e8f68f0223c02c411f420
--=20
2.40.0


--=20
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =3D]=20

--Ru/DL4Tb+YxI3Pq5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmRSMOkACgkQeFA3/03a
ocUcfAf/Z0/YZjlVoNVlpuQQ0nWdANGKI+QVVvyOJXPMWBMVHDlpQjoy3F0xaLjb
CYEoY5n8d8pSCC5M37MVAX7p2inmk7FbW5jPU1vh5/BDmEN9GSaN2QJ0xrXYl0NY
SWep2kHeFwLoPk5wHFP0Fs2V/ZaLPqSEm12rM4asfFfJec9EwBv89peV21N/0Uj2
Y9QYKgqGfHZ6GtYUmMMRXRzmcALSf+YuIPy42XSAmfV929GX0I/aIX351J6hPJZ0
ktBTdzOlneh9zrB97bc/ycuEMUL0dKzcWYaBIdBuq3Gglii2+ZJZkdn4VdchhCbL
OWekHVo/i0gdRJq7jAnAiO6I4Hj3FA==
=1Gqg
-----END PGP SIGNATURE-----

--Ru/DL4Tb+YxI3Pq5--
