Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F805F2C1B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 10:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbiJCIjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 04:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbiJCIi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 04:38:56 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1B15809C;
        Mon,  3 Oct 2022 01:13:17 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id j16so15477703lfg.1;
        Mon, 03 Oct 2022 01:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=Tekt/RnJ+zIgFhpYKf/cWAp1pjbrAJzGXVEGdH+XotQ=;
        b=XvDd2wQDa9wGCTlOXwSZgSlQyMeuu2qRFeDZjqC6hyQTZ14j6aPw0wOPW508aU4zXl
         fucA/vz+WYkwNR+ImdTWUKH54YhVWlXwnXvQowVu/6WUX0x7PH7kLYRX2+X/oMdTHG8n
         4TJrHsqL8jBLKjzjSrSjMYVbsj5i/q3FP6KfSc0nE5s9zGnfe9vI1uNEZNg/QzIM96BY
         FjzCq4Z3MOwv9Xrj8wkjzcedyDhhU1/ThwiVYqaPRkFEgwxsVPSb28oPQR5eAd7vz6G5
         kuKCDWXjHUh7XTO5sGdtAh0nLMKWCVwu76qaj+K4YRjrsbe2g2Zp/o/6bYhEPecaD1N2
         VDAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Tekt/RnJ+zIgFhpYKf/cWAp1pjbrAJzGXVEGdH+XotQ=;
        b=6Dihwx2Hc7skq17VVzyvp6jZ2ewIs56RNayZ2MzvU6UU+4bpr0GzNKT3LPrIH4XbBR
         o3e6pKJil93LakMI7LhLmMOxsJNzczOCVOeK0URUiFoLcad1rPGYYE2oehv991CH1bLE
         hZyITT7ETLmG1yqPWk4LI04jO67bsNmZWgb7jdhUHnaynxUUiRow37aTE7b06GHtRM81
         RJ5wnHcp6Akl7aLhCuTffiNI3/feFRVkxkdBBzsZxf811DIu4iyy1FostP3VKDBN1OEM
         Foi/UO/Xz8js2iwrNLfOuVpKTaTbo6T1syn5zCW3JCsxnu3HlYATcoS1Pci8lVYrrOY6
         XejA==
X-Gm-Message-State: ACrzQf1M2hJU1eSprV9JybZuzecIKmaZnCcrQvZw9shrBc/xxnX3H3OT
        UqYecAUjUgdmpvDIiSgWNRU=
X-Google-Smtp-Source: AMsMyM6tM7WUp1ADznzqSBkE1K+34Y2IKArp0i6WbRGSGJRfEJo+qF9FUnSCGm7si0/5OkcASgLvOQ==
X-Received: by 2002:a05:6512:3f1c:b0:4a1:d76f:ff4 with SMTP id y28-20020a0565123f1c00b004a1d76f0ff4mr7376248lfa.292.1664784796120;
        Mon, 03 Oct 2022 01:13:16 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id g14-20020a056512118e00b0049e9122bd1bsm1361635lfr.164.2022.10.03.01.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 01:13:15 -0700 (PDT)
Date:   Mon, 3 Oct 2022 11:13:10 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Miaoqian Lin <linmq006@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/10] iio: bmc150-accel-core: Use
 IIO_STATIC_CONST_DEVICE_ATTR()
Message-ID: <b1b0d662705b43d68594639fb7719bc431101f79.1664782676.git.mazziesaccount@gmail.com>
References: <cover.1664782676.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Ji24NF+5H9PFnyEA"
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


--Ji24NF+5H9PFnyEA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Slightly simplify by dropping open-coded constant data iio_dev_attr
functions and using the IIO_STATIC_CONST_DEVICE_ATTR() instead.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 drivers/iio/accel/bmc150-accel-core.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc1=
50-accel-core.c
index 92f8b139acce..b4a077944896 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -925,22 +925,9 @@ static const struct iio_chan_spec_ext_info bmc150_acce=
l_ext_info[] =3D {
 	{ }
 };
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
-	return sysfs_emit(buf, "%s\n", __stringify(BMC150_ACCEL_FIFO_LENGTH));
-}
-
-static IIO_DEVICE_ATTR_RO(hwfifo_watermark_min, 0);
-static IIO_DEVICE_ATTR_RO(hwfifo_watermark_max, 0);
+IIO_STATIC_CONST_DEVICE_ATTR(hwfifo_watermark_min, "1");
+IIO_STATIC_CONST_DEVICE_ATTR(hwfifo_watermark_max,
+			     __stringify(BMC150_ACCEL_FIFO_LENGTH));
 static IIO_DEVICE_ATTR(hwfifo_enabled, S_IRUGO,
 		       bmc150_accel_get_fifo_state, NULL, 0);
 static IIO_DEVICE_ATTR(hwfifo_watermark, S_IRUGO,
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

--Ji24NF+5H9PFnyEA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmM6mZYACgkQeFA3/03a
ocUehQf+IGz38D+aCE7j3lLkm+gNNvU1LaWGFVKkBtqeDCb6CPOvwUBr6Vlb/uWO
w+Lor/RmUgc3vTjpPc3GivTQkWmXtRfqR+gHPGoZ3g+bMHJiJzaANjDoIYD3T8uS
b31EGJbcE4dmGgox+gvEcHb62ho6g+cczIrlFWHTw9hnZZ0QgDWn7QlUrbf4C/uX
pPzjIxdIBOhjSpmHQrnVrQAzQb6j4xaU01CS3Ny9bHeX15od5LYbXzT8LOvRltX0
g9s1S5g09ul+J5YKBMq/Fx/RUiU83zLyYq+/ZyfESj2/QMA+ap0zVS5YKgHvYh9v
ixvNSdNbgQrvaBhyJeGP6hwbf1Xphw==
=Ze+P
-----END PGP SIGNATURE-----

--Ji24NF+5H9PFnyEA--
