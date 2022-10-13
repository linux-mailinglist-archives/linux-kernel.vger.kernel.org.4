Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080015FD8BE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 14:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbiJMMFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 08:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJMMFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 08:05:00 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE7B303F2;
        Thu, 13 Oct 2022 05:04:58 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id a25so2098591ljk.0;
        Thu, 13 Oct 2022 05:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xKC63qt3cm6YXRHgcntnH0PvtZLR9kcs/isijApz+ls=;
        b=e7XsURb1RcZi3Nh/LAiEeEg1Ck5uv1klfPu0FDyuB+c6O2VvSpgaaaR+rWiLHAG98D
         medPItFI58F6F31FmgihXNuTasYDNf56dI6AzsHI5SzsmVqJfjhBbkeMdVnuhsiZIjAB
         aZsgwozFcen0t9cIFS4LOwv3ruR9/c8eXRo7Xd3QETCc5zhJxQO+0TJKHQ/wNS14A2N6
         WfDWq0E9Lk6OIPJOwim2h1UvUWGmzc3nlvA4qxW5+FcPDgY/aLJX8C+cZUMJGmf5UWkO
         WbFPiMBYtJv7xkYSfJ0Ey1BP01eOv4pMqNK78on2wWupxrFn3F7UulxFyChavfJThCzg
         qN+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xKC63qt3cm6YXRHgcntnH0PvtZLR9kcs/isijApz+ls=;
        b=RtSEBqjWyoEGvG/XrjsO4BH+vi7ghkDd5lypKUC7VAsuX+pG5eKVZbv1r/GJ0jwbcl
         IacNpuKdV2ngnyfC/iAOi17Xef+SDP2G9BRcoGlxTpe8O7nzduY0vPytvOd76Rq9zaJ1
         rSpDVrqNb3C/U6sTikYuk6poyo3TJd/p1Jkp4wez7DJ+NL+1hVN/LKdEkqumqcHdkicG
         snntjgxbSq6WNEGAt4SYTJn2jmYQT5dRIUeFAHfKbWd1Smcsg/ImEjW5O7Ti8CM2f1/i
         gquw6KZBdMMrcrGiqUKwEavNgUhls2z92vzJqwNbP0eristv2W/GzE7xIg+1zkwjbNKR
         GYGw==
X-Gm-Message-State: ACrzQf28deBbWtZqHL2Tl2vukNWUrsSG4C4gHZMcMRUTotEeRRWUQViz
        p+00VLMsxtQya9KtsDJVUtM=
X-Google-Smtp-Source: AMsMyM5JU59fwYy1esJ9Glo11YJMsAj/PzOiJ4OmVTqXxu80LcZQflZHyLPKeCV6+9mrR94wlku0GQ==
X-Received: by 2002:a2e:6d02:0:b0:26a:cf02:40c4 with SMTP id i2-20020a2e6d02000000b0026acf0240c4mr13103360ljc.513.1665662665868;
        Thu, 13 Oct 2022 05:04:25 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyycy-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::4])
        by smtp.gmail.com with ESMTPSA id 5-20020ac25f05000000b0049d83646ce7sm378761lfq.110.2022.10.13.05.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 05:04:24 -0700 (PDT)
Date:   Thu, 13 Oct 2022 15:04:04 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tools: iio: iio_utils: fix digit calculation
Message-ID: <Y0f+tKCz+ZAIoroQ@dc75zzyyyyyyyyyyyyycy-3.rev.dnainternet.fi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="AeOA1JcKrLrt2PA9"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AeOA1JcKrLrt2PA9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The iio_utils uses a digit calculation in order to know length of the
file name containing a buffer number. The digit calculation does not
work for number 0.

This leads to allocation of one character too small buffer for the
file-name when file name contains value '0'. (Eg. buffer0).

Fix digit calculation by returning one digit to be present for number
'0'.

Fixes: 096f9b862e60 ("tools:iio:iio_utils: implement digit calculation")
Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 tools/iio/iio_utils.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
index aadee6d34c74..8d35893b2fa8 100644
--- a/tools/iio/iio_utils.c
+++ b/tools/iio/iio_utils.c
@@ -547,6 +547,10 @@ static int calc_digits(int num)
 {
 	int count =3D 0;
=20
+	/* It takes a digit to represent zero */
+	if (!num)
+		return 1;
+
 	while (num !=3D 0) {
 		num /=3D 10;
 		count++;

base-commit: 4fe89d07dcc2804c8b562f6c7896a45643d34b2f
--=20
2.37.3


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

--AeOA1JcKrLrt2PA9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmNH/qQACgkQeFA3/03a
ocWOFAgAwiW7uYbSJ2Q68k9t5UV7f8QSoBscJBXXNQJxnpIJMQgGPHMkwHdXw71u
ICNrglVe+pTZw96rEoOAXrng4L1Z5Ce4rw9q1V2AQ3ROjDK2pXf+eGlhvzxy9KYI
pMc3x5AcsJ6QtCWRyZAaZVAW9LvIXuqpiUvC8Pay4V02kw8fwkeyMMZEqDv3Y8b0
naCEM6Y0kJG+oxDrPQWQeD6QgXYLhjgoHGiHaLet3Rcia+JA975DCW/pxpNO1jeX
ijhiLYUXOf1ZS/ZpjBnFv+UwEtxdn8211l1MV/Gm6LW2SoFBwIsroEHidTnCKFzk
ERhGgqlRszhEv7lQsXpeCpR52Sj/hw==
=U0FS
-----END PGP SIGNATURE-----

--AeOA1JcKrLrt2PA9--
