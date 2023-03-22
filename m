Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462576C45BC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 10:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjCVJIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 05:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjCVJIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 05:08:02 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670335DEE7;
        Wed, 22 Mar 2023 02:07:44 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id x17so22436796lfu.5;
        Wed, 22 Mar 2023 02:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679476062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C6wWZzvyb4V9XPIYo37c660hed9C7R0G5XVms5Cu/uE=;
        b=UTVnE+ZKmDkItJeOU4LZb2Nc4AQMSoqqV6nyAGbu0D6CpzF31Dt+F28W9NNCMPXgAY
         w4Gnqql0g26hPKj1b7yZF0znNxX+CG7OcmUqBw9GOprNIkEJBbVN1GppaQniesYKS9ZK
         ygvkszsMIGgbCaUDZDvr4yY++dzptYEDfGOfm0O9f3PYQ8UgpJAsbR+F4m6cvXaEPsoR
         dL+fhbjdQJEeiwAEbT/C6liUY2X2/gLhci+B3OYbXZjKA6EIAZ4k/L7drpUExNBiIhjT
         i3Uh4/Yc2XlCeMPjbUHL4S+AfU/tm7iKVvBECM4TNTEf7dabL8JV35fXuN1EG9+boANI
         qSow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679476062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C6wWZzvyb4V9XPIYo37c660hed9C7R0G5XVms5Cu/uE=;
        b=YY60hF/C7LImkrWSZTfYa3JPWgz4vWftIBHr8y3+Fa0CiC69b1xjHgA6NZ9q2jkVET
         vEOripy/WVJo9OyAEe2+GcqrB6swX730LoOB5vj4Za99w8Uw7EHiP3jaqHdwAt7hq+wg
         dly/as9spHlIrCoU9y7E38Sp0mKknrIqCVqpOaIDnelisqDw0lW4e53PCsf5s3eO/M1l
         wxedpccZeASzEu9B5YX/kOuxYVD4EekMkf4xCLRSMFxkDZAvrc7A4XrZw9dcw3E9c098
         NV0428OUtvMIy0qqS7+EJQtpUMW9rWdEHp50zZ3pl9UkMstYwrw/1eqaUzFjjQabopvv
         gWLw==
X-Gm-Message-State: AAQBX9c6zLcRZVaZhCZVio5d15sAki0fYssgJyOtObJy3+GYYs/sSi9b
        e1lG3M64J8I2V6/MM8eL9og=
X-Google-Smtp-Source: AK7set+Lbvt5DX6aB5UPcBD8VjxemGYB2uWeH0se9JOa0so8Pm+izA22G3k6kY9QU/DTj6J/x8c6Hw==
X-Received: by 2002:a05:6512:3e2a:b0:4de:56a6:236b with SMTP id i42-20020a0565123e2a00b004de56a6236bmr500516lfv.28.1679476062002;
        Wed, 22 Mar 2023 02:07:42 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id u10-20020a2e854a000000b00295b597c8fasm2529591ljj.22.2023.03.22.02.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 02:07:41 -0700 (PDT)
Date:   Wed, 22 Mar 2023 11:07:37 +0200
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        linux-iio@vger.kernel.org
Subject: [PATCH v5 6/8] MAINTAINERS: Add IIO gain-time-scale helpers
Message-ID: <5c6a4defb6ac7d41c4ed16ff463aaece1ab37400.1679474247.git.mazziesaccount@gmail.com>
References: <cover.1679474247.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="N68Gwk0z2/zN9QWm"
Content-Disposition: inline
In-Reply-To: <cover.1679474247.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--N68Gwk0z2/zN9QWm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add myself as a maintainer for IIO light sensor helpers (helpers for
maintaining the scale while adjusting intergration time or gain) and
related Kunit tests.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
RFCv1 =3D>
- No changes
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ec57c42ed544..6ec9326f4ce9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9938,6 +9938,14 @@ F:	Documentation/ABI/testing/sysfs-bus-iio-adc-envel=
ope-detector
 F:	Documentation/devicetree/bindings/iio/adc/envelope-detector.yaml
 F:	drivers/iio/adc/envelope-detector.c
=20
+IIO LIGHT SENSOR GAIN-TIME-SCALE HELPERS
+M:	Matti Vaittinen <mazziesaccount@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	drivers/iio/light/gain-time-scale-helper.c
+F:	drivers/iio/light/gain-time-scale-helper.h
+F:	drivers/iio/test/iio-test-gts.c
+
 IIO MULTIPLEXER
 M:	Peter Rosin <peda@axentia.se>
 L:	linux-iio@vger.kernel.org
--=20
2.39.2


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

--N68Gwk0z2/zN9QWm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmQaxVkACgkQeFA3/03a
ocVoAgf/QnhysstEIAz6O0b1x0Ppwjil8vOusCfgIBoGjtOu4sLMGXMS5nTqKZ+X
r3KBqnQ48vClnqswk+ABK3vQGk/I+rPu7uGClr95o0DNbaBrNH6/nliu6y0iwWBH
gXReTCLPdUeTB6qwOJ5hTuwugIxGMIYKArjYvk5GxdvicjTSVxQsNuLR6xAl33YZ
Ub6JX22Hir72am1HMhO68I1jYc8K1hs+18WllFftueFEWEGq+F2TJrZoeXNPPZ6w
4CgA66o4NgUqzkt5kREBvcPCJvqHbmDhBxhq6xgg0cj0b8I1nLpwqw2LfjybpjVJ
W86+CsQT7KS8tWdamwzn3jXJEEF+pw==
=948O
-----END PGP SIGNATURE-----

--N68Gwk0z2/zN9QWm--
