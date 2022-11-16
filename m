Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B01262B4ED
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 09:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiKPITu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 03:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbiKPITb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 03:19:31 -0500
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8EB1DF3E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 00:19:29 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id z24so20844261ljn.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 00:19:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oi4wQyO0sHcfINTeu+zblHyjJ7A67cfqXg4Mjzz9Gzg=;
        b=tZuuuxalXr8wTFz3VlmnK1hJmUlv8ABRV9tYuyMw5cvwctIaHAV+tHbhTadS8wGaQ/
         gt3ZXTc1/eeW3jrELU0BsV+u/AnHtCbJdkh8be1XSIn3m9bUzr4RgXXagefIjt6iO4sK
         nPNUYL7ayW1f3va8iyx/XNk0YU9D+ppotavgu1gPnOJjhXKJc3gtL2EfvksWYojGWN4e
         PXfYdHMNTA05CPbQhoIAiVq9WZdHcs7chDFZRGKBDijIWJfQBfjrgF9ZmOXjLt2Akusp
         zi9TVRc8EsXUtEjP3ivJjMKFIRkJi5PYqAqflCTRD7QNtvyIWVXXiqGP1of6e0d3G1XA
         GJyg==
X-Gm-Message-State: ANoB5pnVxfH/t/DHwTejP2/n5lGRRbPxK4VJlHQ4s8g+rrGXASj6nz0C
        ZMsYyeOE4tCx/96dc2dpF4M=
X-Google-Smtp-Source: AA0mqf7oVWRkEE8oTzZx67Y+WvcKAoZQiC6/6UowkTZkgdlNGSdd0+S5qXrk9TvylaxWrxPqEtX46Q==
X-Received: by 2002:a05:651c:1a13:b0:277:113d:1c38 with SMTP id by19-20020a05651c1a1300b00277113d1c38mr8185470ljb.238.1668586767728;
        Wed, 16 Nov 2022 00:19:27 -0800 (PST)
Received: from dc75zzyyyyyyyyyyyyydt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyydt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::7])
        by smtp.gmail.com with ESMTPSA id i13-20020ac25d2d000000b004b0b2212315sm2487672lfb.121.2022.11.16.00.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 00:19:26 -0800 (PST)
Date:   Wed, 16 Nov 2022 10:19:21 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Lee Jones <lee@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] mfd: bd957x: Fix Kconfig dependency
Message-ID: <Y3SdCWkRr1L64SWK@dc75zzyyyyyyyyyyyyydt-3.rev.dnainternet.fi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ByRB43tndDwb3EJ0"
Content-Disposition: inline
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ByRB43tndDwb3EJ0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The bd957x driver uses regmap-IRQ but does not SELECT ot depend on it.
This can cause build failure.

SELECT the regmap-IRQ for BD957X from Kconfig.

Fixes: 0e9692607f94 ("mfd: bd9576: Add IRQ support")
Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
Oh, found this forgotten treasure while cleaning old branches from my
local git. It seems to me this is still valid but has fallen through the
cracks.

 drivers/mfd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 8b93856de432..9940e2724c05 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -2027,6 +2027,7 @@ config MFD_ROHM_BD957XMUF
 	depends on I2C=3Dy
 	depends on OF
 	select REGMAP_I2C
+	select REGMAP_IRQ
 	select MFD_CORE
 	help
 	  Select this option to get support for the ROHM BD9576MUF and

base-commit: 094226ad94f471a9f19e8f8e7140a09c2625abaa
--=20
2.38.1


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

--ByRB43tndDwb3EJ0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmN0nN0ACgkQeFA3/03a
ocVreggAlY6wbyeLHAltIyZTQHRUD8fFO13oFPmC1cPJuoox3l+AuqOJAtv9ndzz
Lit6bOCcJv6cjaXJqG+Km9lzQL5quutwIKQhjEDcOMBP8tw12v7OxHOQNAXBkWPS
SKPzEhzVdeyOCbY0DnOQLYQaPNIA8NkvxdxnxiyRZ7Rzl4CvfVY99tbGuUzgIXUe
XSV2EMy7/FSJLEovYInZL0IYJKsAzUavfT7bfkacKvYdk0gae18X9hsNHP+z5cnk
TvyzCwOms4y9V3ng/okEpzFLRwl6XGjZ14CyKdHWwv0RF7i7FkRhlwF5MZxH06QJ
EvKCiSVGmYUWfPbdvwTJpem4aqj9dQ==
=gYZl
-----END PGP SIGNATURE-----

--ByRB43tndDwb3EJ0--
