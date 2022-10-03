Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9754A5F2C06
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 10:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbiJCIiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 04:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiJCIhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 04:37:38 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6C42BB2F;
        Mon,  3 Oct 2022 01:10:58 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id d26so2642529ljl.2;
        Mon, 03 Oct 2022 01:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=OsCc64eJJaHmezFY3+fQiaWmA0ACCwHkFNgq4FVgBCc=;
        b=DAre7PP/V/+fUXyIU1cVixP9l/aP21f7MmWrs5BlDuQHOjVYs5zQNQju1G0BKejp17
         3yOuaZg3eNGlqkQi5hzyrR2pNWVTcY5LCMz9t67FNlEfhU1Ntx7MEghFUjdFUCML2KZN
         cqei7DtadFE2fJXq8jk3A7Qcs2wqM3qIxIGs9GjUfOAQNyid660KdXHnR581z9/Q0wXi
         1YFn3sS/TUqc0wBXgMCwzWQZkv3hgCmAC+XkXJtb1qD2yVrqFSOL9SVa35EamZcVaQNv
         z2ba6f21zKcBE3cpXB82msGQ3M5N3quKJQFZCqwye5ZCNGckwMD6efVu1q8kMe6ZcS9S
         B9sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=OsCc64eJJaHmezFY3+fQiaWmA0ACCwHkFNgq4FVgBCc=;
        b=6rn/pwXoyidO3tS38H7jd6/ha4+0nQqmfabOj5mJgDQGLzmJYEWgCRTOtwtGvNRwoN
         Vgewt/53ixc5I03hKw61sEVgVB5VQJCe/v79t+H7nTjTIRM8pNxXvpzI+QgemtfBQN9n
         312EG0SsORZxISNw5KWo9h07Fmo6E+2fHsWjylK4BsxG0mgRKB315t6iM3RRwoVSa99q
         OSrzCreKljLuPvzH5d+UEAdYvRatnCBEa/+QVcAji2mMTNRjD1EOB9qFC0HoxZuMkSL2
         ztt6+/+DPC9fDnsCB8HcPuOlUWDOSQdEiDHsbH4000UNwkfpc6iViP1Qzef6ah/PJX2t
         M56A==
X-Gm-Message-State: ACrzQf3Te2kBe9PeLa9F+eT0UVVak7hDyPGLgedi2ptNafUBNa1eQtw8
        Te+5NMJSmNA9P++GzrBq+Ag=
X-Google-Smtp-Source: AMsMyM6uc0eNJtN8QqJCwTQjeVHMxQDOI6LjcF/gvHiW8I234MpMvkfANbKpUwDFPnadktT5W++a2A==
X-Received: by 2002:a2e:585:0:b0:26d:d39b:19d3 with SMTP id 127-20020a2e0585000000b0026dd39b19d3mr1549181ljf.345.1664784656981;
        Mon, 03 Oct 2022 01:10:56 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id br32-20020a056512402000b0049465afdd38sm1363358lfb.108.2022.10.03.01.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 01:10:56 -0700 (PDT)
Date:   Mon, 3 Oct 2022 11:10:51 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/10] iio: adxl372: Fix unsafe buffer attributes
Message-ID: <19158499623cdf7f9c5efae1f13c9f1a918ff75f.1664782676.git.mazziesaccount@gmail.com>
References: <cover.1664782676.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="o7EBbn06x8oYoLLd"
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


--o7EBbn06x8oYoLLd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The iio_triggered_buffer_setup_ext() was changed by
commit 15097c7a1adc ("iio: buffer: wrap all buffer attributes into iio_dev_=
attr")
to silently expect that all attributes given in buffer_attrs array are
device-attributes. This expectation was not forced by the API - and some
drivers did register attributes created by IIO_CONST_ATTR().

The added attribute "wrapping" does not copy the pointer to stored
string constant and when the sysfs file is read the kernel will access
to invalid location.

Change the IIO_CONST_ATTRs from the driver to IIO_DEVICE_ATTR in order
to prevent the invalid memory access.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Fixes: 15097c7a1adc ("iio: buffer: wrap all buffer attributes into iio_dev_=
attr")

---

v2 =3D> v3:
Split change to own patch for simpler fix backporting.
---
 drivers/iio/accel/adxl372.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index e3ecbaee61f7..bc53af809d5d 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -998,17 +998,30 @@ static ssize_t adxl372_get_fifo_watermark(struct devi=
ce *dev,
 	return sprintf(buf, "%d\n", st->watermark);
 }
=20
-static IIO_CONST_ATTR(hwfifo_watermark_min, "1");
-static IIO_CONST_ATTR(hwfifo_watermark_max,
-		      __stringify(ADXL372_FIFO_SIZE));
+static ssize_t hwfifo_watermark_min_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	return sysfs_emit(buf, "%s\n", "1");
+}
+
+static ssize_t hwfifo_watermark_max_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	return sysfs_emit(buf, "%s\n", __stringify(ADXL372_FIFO_SIZE));
+}
+
+static IIO_DEVICE_ATTR_RO(hwfifo_watermark_min, 0);
+static IIO_DEVICE_ATTR_RO(hwfifo_watermark_max, 0);
 static IIO_DEVICE_ATTR(hwfifo_watermark, 0444,
 		       adxl372_get_fifo_watermark, NULL, 0);
 static IIO_DEVICE_ATTR(hwfifo_enabled, 0444,
 		       adxl372_get_fifo_enabled, NULL, 0);
=20
 static const struct attribute *adxl372_fifo_attributes[] =3D {
-	&iio_const_attr_hwfifo_watermark_min.dev_attr.attr,
-	&iio_const_attr_hwfifo_watermark_max.dev_attr.attr,
+	&iio_dev_attr_hwfifo_watermark_min.dev_attr.attr,
+	&iio_dev_attr_hwfifo_watermark_max.dev_attr.attr,
 	&iio_dev_attr_hwfifo_watermark.dev_attr.attr,
 	&iio_dev_attr_hwfifo_enabled.dev_attr.attr,
 	NULL,
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

--o7EBbn06x8oYoLLd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmM6mQsACgkQeFA3/03a
ocUJRgf/aJ6es/VTOfcqi0G8LrKzVj0qRcFmr134K5dHlmpuBQJg/0hzYz9otBWP
FSwc25jJHZDmZG5KY0jnKPw6iM7zTGMq8BOjj0FVNFpWD92WFr24+Dbav9jyyOr5
1zP2Ix3GKY1M6UxpjYrehoUviXH6XPiEdvYZbDMpjksoalT1Rm++uKzuSZIZmYYS
6L82HoyJkQ9nkLAnKqRHHTrrC9ejxQPaRI+040vVaBzJfqE0H/gT2Vsij79fsbSW
DC1bC62Yvn3liv2Tlxlqc+MuHSBjV5l8m30H1rggy8ZMmEk6jic/ff8tto2qdNzG
YFtSgXrNUrRuJT+Hch85cVXukAS4iQ==
=E+UK
-----END PGP SIGNATURE-----

--o7EBbn06x8oYoLLd--
