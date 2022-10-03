Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484CA5F2C1A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 10:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbiJCIj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 04:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiJCIin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 04:38:43 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91976273D;
        Mon,  3 Oct 2022 01:12:56 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 25so5188504lft.9;
        Mon, 03 Oct 2022 01:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=UMNEw7AgUh6ajeyzrA1GuUtXPh6a1JamMlxbjeOzpbk=;
        b=hfm4nX+sk6VY/Wn7Qen6OsNSteSqazo02JNzObtmrxTGDGKHxtGksOX303/ZXDRzrR
         d9dNw+7kEEsSXdei5DGSCETX5G1Wt+8NxzZJNFvLkpIwsy8TE2dBr76s30L8u7sw8h/h
         VnEhDUCqvhJ3UcyLNAIyc3Yqg3f+lNLASsuuXGD69uOIfoSseNgi6cn7BhPlUspqf2G8
         XHw7GZWix4C8XunOTEBn7vLqCj4K8tTbBXl7psw2AOHG82/3LmuR0agpmAJT3OQkAptv
         MVJFldwu++6kQb7YrsjcTRiFml3Wlnc9UEVMeasaedRWacjGVRZH4kNSkihvHp2s7haA
         JX2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=UMNEw7AgUh6ajeyzrA1GuUtXPh6a1JamMlxbjeOzpbk=;
        b=hadUzam6sjJ+tXVvhyuU921K3mHWS/idVXJp/vzubJrjwFMsCETIu50z/S6lLTetT7
         I9yXUfmrGU7xQjMEtAD1QHI0vfrEeE2Oq6g82bu+uw6Os9sF3htNghHa16xgXvwQAaym
         rnuRl5G/8T49ADZVzyq4xWY6paNakHYkcCu/skOFhCYYiwQeAKm9PDT2wYbJdWV/T3Sn
         oUKp4XhtBJdECVhjhecwgtJDZcFs1CNAu4SWe5bCTlq/1fvCr0M7If1NBmEbabuhM02g
         sYtbpyx5PMFucyS/Njxtze22FlMa/HcvqR+o4MiaKM/qoj2IBhwZ05lOsgB4No3I3tVu
         AMNw==
X-Gm-Message-State: ACrzQf2oZm4Zipy0g12dtQramJicKyOuicsp1s2iia4FV94Sx9iCegAp
        l7v3D2wk4M+bum46gqNSAIo=
X-Google-Smtp-Source: AMsMyM5nI2/CFfR3eBNUm0neqCbUE1MFdZpFGyJ2vwi0KNeRIGXC1Y3NGP/VQteZ6nH0gMvxp0+HFQ==
X-Received: by 2002:a05:6512:32b8:b0:4a2:3a87:39b8 with SMTP id q24-20020a05651232b800b004a23a8739b8mr1721170lfe.6.1664784774744;
        Mon, 03 Oct 2022 01:12:54 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id o1-20020ac24c41000000b00494792ea34esm1352141lfk.273.2022.10.03.01.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 01:12:54 -0700 (PDT)
Date:   Mon, 3 Oct 2022 11:12:48 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/10] iio: adxl372: Use IIO_STATIC_CONST_DEVICE_ATTR()
Message-ID: <3632af8849ef101c54ec1f739596f22c773b067c.1664782676.git.mazziesaccount@gmail.com>
References: <cover.1664782676.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XuUgAxgMaJpJE9CR"
Content-Disposition: inline
In-Reply-To: <cover.1664782676.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XuUgAxgMaJpJE9CR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Slightly simplify by dropping open-coded constant data iio_dev_attr
functions and using the IIO_STATIC_CONST_DEVICE_ATTR() instead.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 drivers/iio/accel/adxl372.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index bc53af809d5d..90e1d726b9c5 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -998,22 +998,9 @@ static ssize_t adxl372_get_fifo_watermark(struct devic=
e *dev,
 	return sprintf(buf, "%d\n", st->watermark);
 }
=20
-static ssize_t hwfifo_watermark_min_show(struct device *dev,
-					 struct device_attribute *attr,
-					 char *buf)
-{
-	return sysfs_emit(buf, "%s\n", "1");
-}
-
-static ssize_t hwfifo_watermark_max_show(struct device *dev,
-					 struct device_attribute *attr,
-					 char *buf)
-{
-	return sysfs_emit(buf, "%s\n", __stringify(ADXL372_FIFO_SIZE));
-}
-
-static IIO_DEVICE_ATTR_RO(hwfifo_watermark_min, 0);
-static IIO_DEVICE_ATTR_RO(hwfifo_watermark_max, 0);
+IIO_STATIC_CONST_DEVICE_ATTR(hwfifo_watermark_min, "1");
+IIO_STATIC_CONST_DEVICE_ATTR(hwfifo_watermark_max,
+			     __stringify(ADXL372_FIFO_SIZE));
 static IIO_DEVICE_ATTR(hwfifo_watermark, 0444,
 		       adxl372_get_fifo_watermark, NULL, 0);
 static IIO_DEVICE_ATTR(hwfifo_enabled, 0444,
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

--XuUgAxgMaJpJE9CR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmM6mYAACgkQeFA3/03a
ocU2gwgAkOPhUFnwfMrlQb3od5kWMJo89ybAyGvd2e2UMAkXkRX+k8K4sFGd0dm9
hUDw+LXJKyKD6g6bOf5AwpRbFBvd9xwP6F5CeObYpyMhG1TGlBk2qUwd+SQqyOq8
xzZjBhigg2jjWrrcbsEJNAwPjPdp5nwAdu7rzOSuZD4ZsyUTbwslqoF3v+Yf/Jaj
GOWKkhAPYy/AdmyC4nqvkvfWHgY5pV41TPFZfs6+XH6bAvyBk4PqOj4Mkgyzz+Pp
X+dL8SUOF24WQnlDY3uJuyGoBOoF9Adm9Ml77BDHssw5Yxtlc95D0f11tGwGO5A5
Mq3v5lgJb/Bd+FpNP9oV0+5Dex32aA==
=8Ee9
-----END PGP SIGNATURE-----

--XuUgAxgMaJpJE9CR--
