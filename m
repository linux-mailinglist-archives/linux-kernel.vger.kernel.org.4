Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE39F6EA350
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 07:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbjDUFq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 01:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDUFq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 01:46:27 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283145FE6;
        Thu, 20 Apr 2023 22:46:26 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4ec8148f73eso1230854e87.1;
        Thu, 20 Apr 2023 22:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682055984; x=1684647984;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qrlfV5n8Lg9nBjvRn99BY3DeQ7uAmbc+OFU0aM7skag=;
        b=X9WSQYeo/2Y55JJv0fzWwxkRoVJm9Eay/Z7x+JK0akY2eootZI7q4Fkw/P6lDmHam7
         hZPsZTFtNMKdYKfMoPRV5hfQjwHvAxv9AknTrxiCgbfiqjwnzP6N/x0bUzTrYtN3uJWb
         LhxYLY7s8azY5pXP4gnt0UO5Xm+J4iduULrVEDlScibBFJj0ccqGAsWxng9lHnyofI3K
         oCDLJhat1lFyaDlBCuo0BXXCdazNrEq8wxrJehPc0NLus9MeqICg+N80ojvWb3c4NKA7
         4dQSDS6cXtGM8SzhmsL9k1X3Ghk84xgKCN4b1xQG2n+eBZ8cRRSkIhX991y843szLTKt
         8SwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682055984; x=1684647984;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qrlfV5n8Lg9nBjvRn99BY3DeQ7uAmbc+OFU0aM7skag=;
        b=PSIIpHw9EElXm9wqgi/F+Qa/gMDTg83XvXaeDLsABzTk7LNJ8DMgdh4n9jbysqUAYA
         GKHcDkd9IzuWsp2oBye9ZnBcmft2gfOC2WPAPGiV+CCsFLre3z/iRl6CL6SpQZmCsnLc
         lyaNYR9gnKFQRyV3tleVbeBLh7w+cJm26bsLwXMldes6ejNFmwymhYmvIYdXyBMT+9li
         Z+VQIrK6xScAuKbKY4OW14WaZd4L0edd/M7Y790uO9qUy+GVtuMxvKt5JMo0o3ANFHoW
         GCMf10ikLsjW8tw4M7FnO0qxjwthygo3VYThD7b8LFIxeMEWvm78GVBQQaOHuooJYZxc
         OLDg==
X-Gm-Message-State: AAQBX9c5nkrdfzfytaijrx1HIkz0tAxO58H0tLSNQANzoX9Ziv4/m8U2
        4NJZ/cKHNZbgXmqH00Piejw=
X-Google-Smtp-Source: AKy350bHTiYbhBuNCMi7vFNCNUKCJSXMr70qE4k+H+8Zfn7V7PleDL2lWHX9mWPwQTjwSnldA1F2UA==
X-Received: by 2002:ac2:5ddc:0:b0:4e0:b407:fdf4 with SMTP id x28-20020ac25ddc000000b004e0b407fdf4mr844334lfq.37.1682055984067;
        Thu, 20 Apr 2023 22:46:24 -0700 (PDT)
Received: from fedora (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id p3-20020a05651238c300b004ec5229092dsm447576lft.34.2023.04.20.22.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 22:46:23 -0700 (PDT)
Date:   Fri, 21 Apr 2023 08:46:11 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: fix doc for iio_gts_find_sel_by_int_time
Message-ID: <ZEIjI4YUzqPZk/9X@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Qatxs7Q+MHiWtUHL"
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


--Qatxs7Q+MHiWtUHL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The kerneldoc for iio_gts_find_sel_by_int_time() has an error.
Documentation states that function is searching a selector for a HW-gain
while it is searching a selector for an integration time.

Fix the documentation by saying the function is looking for a selector
for an integration time.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 include/linux/iio/iio-gts-helper.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/iio/iio-gts-helper.h b/include/linux/iio/iio-gts=
-helper.h
index dd64e544a3da..9cb6c80dea71 100644
--- a/include/linux/iio/iio-gts-helper.h
+++ b/include/linux/iio/iio-gts-helper.h
@@ -135,7 +135,7 @@ static inline int iio_gts_find_int_time_by_sel(struct i=
io_gts *gts, int sel)
 /**
  * iio_gts_find_sel_by_int_time - find selector matching integration time
  * @gts:	Gain time scale descriptor
- * @gain:	HW-gain for which matching selector is searched for
+ * @time:	Integration time for which matching selector is searched for
  *
  * Return:	a selector matching given integration time or -EINVAL if
  *		selector was not found.

base-commit: 52cc189b4fc6af6accc45fe7b7053d76d8724059
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

--Qatxs7Q+MHiWtUHL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmRCIwkACgkQeFA3/03a
ocVL/AgAnY0Cvk9xClN2LfnIjZccke39vN5sO+jY62eOOkjbQSePRXOzLJ1UZykj
4FSbXiHy/93F5raSNHcCxaJTtNwUwylbpad6HP4dHRIusD6ZOG7OTjUiX9hnZ3uq
yS7ZkXcPw+XNzNDfq5cvH24n4O4X8LUFjwMmISkhzzEm6W9WfPY4trj9GBseuOUD
Y+htKULsB7uiiP+Z1CAmqOLHZ+agDGWaBXmj+8WuQNsRlPwDTsOINa3Hj1q4gwHg
YPphEJdfI2kpIrnICd+cqlK8AxL6d9uzLTfBHcQ4W54WycqNexfW/EH5+YEAoZPB
LGNT15neE2Xr88b4pA7DmJ7hNsirHw==
=bgbs
-----END PGP SIGNATURE-----

--Qatxs7Q+MHiWtUHL--
