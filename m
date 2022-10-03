Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34EDC5F2C04
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 10:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbiJCIhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 04:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbiJCIhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 04:37:19 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE201B9EC;
        Mon,  3 Oct 2022 01:10:36 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id l14so811755lja.8;
        Mon, 03 Oct 2022 01:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=nOkVEk86RlnSvneK2M2/d2avn4QLOYInnC7Sn7/Aa4Y=;
        b=iGVN5uSENQe5tR2hCcKkU/on+VkLHOlg5c8ZkAfpQGRXO+HRBiVO/8pY0At1PqDkZF
         F38xtcx88o9d0l0kNYlQ2DaA0yzXh5Xlqh6spPITD7pYNscmj1KYKPVNlPsWoPcgZKYu
         EXPcdIO8lSkRyrCpioF9yYpjwb/l84IfgAvrQ7S3VpBmWnlk1gGAi6M68hY4Z/nAdNys
         Rz35YfF4jacenrxzhpWKSIhzbjLiN34UiZggWNmugA23Z2nji+jlRn3FcAoypAkUiqyi
         nA5tfybay3hmknDOTgmnbiGDC0cBfvTZagQnRC0+FmGGv1cdLvyh3ezAST583pMw5ML4
         dSGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=nOkVEk86RlnSvneK2M2/d2avn4QLOYInnC7Sn7/Aa4Y=;
        b=L+V3FoDpBIqH/bBhyT5epdewgnYScOi2dIqlGbALBEjfLZdXD/8XCa3Ds2koSrPakD
         3XEFq6GWHz5f5e5EZRAq4HBhDQLEOOp4nJjZ9V62B1wwjOonFKV/2M6qf/Lguvzanm5k
         zAF+zz9S1Zm9kZvlMVB5C99CKnyxLjtQKW3lhvfzN1jgynWAH9RqyQPI8I6geJOC8BY/
         BIVP+HBK8KjFrJIPpwGudKB+xdJGN4AElVIJRQuYCN8tCRtxExL6kkq+ND/wJoDoy/vp
         SYmy91v3UMTG00HMLaECzzNN/3taUr5TQbnAminOMTwfR82wNrriUuUm4HRwZINXGNV9
         t2rg==
X-Gm-Message-State: ACrzQf0VqOAkZIOVhL439TbdkYr3vWKzEV3dcRQ4CBOj0XIOos0rtmGj
        N8Z590eSUHMHFnixhjGUs6vz5qAj6R4=
X-Google-Smtp-Source: AMsMyM7uCPaquYdMYoQjOcZdrLtxRNuoioVRa5lD7PEkHG9rl+d+EzraH25LsJHIfjODepyItB3W/A==
X-Received: by 2002:a2e:a783:0:b0:26d:cdf8:5e02 with SMTP id c3-20020a2ea783000000b0026dcdf85e02mr2735806ljf.125.1664784634770;
        Mon, 03 Oct 2022 01:10:34 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id o20-20020a056512231400b0049f9c732858sm1358373lfu.254.2022.10.03.01.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 01:10:34 -0700 (PDT)
Date:   Mon, 3 Oct 2022 11:10:29 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/10] iio: adxl367: Fix unsafe buffer attributes
Message-ID: <2e2d9ec34fb1df8ab8e2749199822db8cc91d302.1664782676.git.mazziesaccount@gmail.com>
References: <cover.1664782676.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Xgug5I7dGIdahUZo"
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


--Xgug5I7dGIdahUZo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The devm_iio_kfifo_buffer_setup_ext() was changed by
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
 drivers/iio/accel/adxl367.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/adxl367.c b/drivers/iio/accel/adxl367.c
index 47feb375b70b..7c7d78040793 100644
--- a/drivers/iio/accel/adxl367.c
+++ b/drivers/iio/accel/adxl367.c
@@ -1185,17 +1185,30 @@ static ssize_t adxl367_get_fifo_watermark(struct de=
vice *dev,
 	return sysfs_emit(buf, "%d\n", fifo_watermark);
 }
=20
-static IIO_CONST_ATTR(hwfifo_watermark_min, "1");
-static IIO_CONST_ATTR(hwfifo_watermark_max,
-		      __stringify(ADXL367_FIFO_MAX_WATERMARK));
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
+	return sysfs_emit(buf, "%s\n", __stringify(ADXL367_FIFO_MAX_WATERMARK));
+}
+
+static IIO_DEVICE_ATTR_RO(hwfifo_watermark_min, 0);
+static IIO_DEVICE_ATTR_RO(hwfifo_watermark_max, 0);
 static IIO_DEVICE_ATTR(hwfifo_watermark, 0444,
 		       adxl367_get_fifo_watermark, NULL, 0);
 static IIO_DEVICE_ATTR(hwfifo_enabled, 0444,
 		       adxl367_get_fifo_enabled, NULL, 0);
=20
 static const struct attribute *adxl367_fifo_attributes[] =3D {
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

--Xgug5I7dGIdahUZo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmM6mPUACgkQeFA3/03a
ocXPRQf/cHmSscn3lUzKBHxWr1NgH4owE2JRRybLa/NWcPibDhDYrmUj7H+wYEvP
hiZBmnOOvMkRPnl2+EcgDpobQXDVUhMEsBCX1wLlkIZ7VN6JK2Dvh4sIwcjz3s2A
1otMeY8XE3i04NqDIUnKZvy0RnfbEweAhopO4oJwVYifU3mmKzSPTvkdg6o7pYlA
JKZ4iXT5cpuGoYNf+o1XShvDyopTNQyYh3xiynffS8WT0jelxJCpZCpTB2h/7nZU
swyrTeGkAXdB8uBHTOSC0MXBu6t5knQ7j50p1+n2Ehoi02hbazSrwpYEfl6KtdJf
BzidNS6ZWSU4Cld+ooBtcTQa/XD8ag==
=g5y1
-----END PGP SIGNATURE-----

--Xgug5I7dGIdahUZo--
