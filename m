Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399975F2C18
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 10:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiJCIjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 04:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiJCIil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 04:38:41 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B2C58B71;
        Mon,  3 Oct 2022 01:12:32 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 10so15487195lfy.5;
        Mon, 03 Oct 2022 01:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=1VL7/yuPd6dY59LBZEQg+8bOscEZhQxd1APG+bQxTu4=;
        b=iTNxFcosyV0bHcaDP9/bCx2GD74MZ3NEzw3sT5t3OG/HJ+3nf4WIeFFUqHGx7sNzlB
         0/c5pmk+c33A4HX1vxyW05xHXEaRvGyTaKqe9rNMvDp6aFjJ+TYJ9Yp1TWcewkF9loez
         NY26CUyia0mpCIMjOwZCs4ajaCRxtIJlckVAMu0frOZzZeemZFyuiMCC4URggQdnhbrd
         XiYJzmVNPq5/HT7hBhnHKAyfW4jwTwHTuqW09F88pURKWDnG/EQFU2XseFICuUqwoZqU
         30oCwrBgviPo6Wm7J/8xRAUdlhBP2wVpGu7npX1+zyyQ8g2kRXRowTzQt3HQGKrpOC4K
         xj1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=1VL7/yuPd6dY59LBZEQg+8bOscEZhQxd1APG+bQxTu4=;
        b=4tyjYo7lGpxMMNopTxzkSHjzIwTmC9yndpi8NN57p0YM9WXXy9IDk5ET+/3B1zDCZe
         J7U3cDBxReUWBEeEvSBTpDVx3dRmxH4fbVGNfLuMvG1SBMQt3CWF1wUc5UxGeD9Ou1k9
         gUIeXr05JmD3AVMMx//GaBciSag9P9G9etIx+t8CguNgqVggEQ6R1pRnrpfoynN+YXm2
         zL6ENQ2TNWnJ3T9nzl6lVRTpOz4pBUE/s1jqOsRGAJWZ2dglxXdtcjX/SLxe3T3trM/K
         1XbYh2lrsWz02VI50ro0zj+xxJqYH1t8j/kSyDucIjkVRFalqYGm5L7iKxHb+1iqUdSa
         SHdA==
X-Gm-Message-State: ACrzQf03/H5kaQHFeojFwvo+yqlyKXXew00nqqBxAMPO8AKyLJQ8Ve9e
        IkptbEgPR7C7iKyxT7ZnmYs=
X-Google-Smtp-Source: AMsMyM4eShZMW3PyTO2nuS457Lz4v0vi/TX1qkD2BVWOdQMgnUiTJUf2ZLnzpyxeDx1/ZN2OhCLNeA==
X-Received: by 2002:a05:6512:3f10:b0:4a1:fa44:6690 with SMTP id y16-20020a0565123f1000b004a1fa446690mr7795167lfa.152.1664784750520;
        Mon, 03 Oct 2022 01:12:30 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id o1-20020ac24c41000000b00494792ea34esm1352021lfk.273.2022.10.03.01.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 01:12:29 -0700 (PDT)
Date:   Mon, 3 Oct 2022 11:12:25 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 06/10] iio: adxl367: Use IIO_STATIC_CONST_DEVICE_ATTR()
Message-ID: <c96c55363b8f36017ef7f18fdfe810cd3990e2a4.1664782676.git.mazziesaccount@gmail.com>
References: <cover.1664782676.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="x0D0mIEVFPsVmKoF"
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


--x0D0mIEVFPsVmKoF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Slightly simplify by dropping open-coded constant data iio_dev_attr
functions and using the IIO_STATIC_CONST_DEVICE_ATTR() instead.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 drivers/iio/accel/adxl367.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/accel/adxl367.c b/drivers/iio/accel/adxl367.c
index 7c7d78040793..47cddd4e98b2 100644
--- a/drivers/iio/accel/adxl367.c
+++ b/drivers/iio/accel/adxl367.c
@@ -1185,22 +1185,9 @@ static ssize_t adxl367_get_fifo_watermark(struct dev=
ice *dev,
 	return sysfs_emit(buf, "%d\n", fifo_watermark);
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
-	return sysfs_emit(buf, "%s\n", __stringify(ADXL367_FIFO_MAX_WATERMARK));
-}
-
-static IIO_DEVICE_ATTR_RO(hwfifo_watermark_min, 0);
-static IIO_DEVICE_ATTR_RO(hwfifo_watermark_max, 0);
+IIO_STATIC_CONST_DEVICE_ATTR(hwfifo_watermark_min, "1");
+IIO_STATIC_CONST_DEVICE_ATTR(hwfifo_watermark_max,
+			     __stringify(ADXL367_FIFO_MAX_WATERMARK));
 static IIO_DEVICE_ATTR(hwfifo_watermark, 0444,
 		       adxl367_get_fifo_watermark, NULL, 0);
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

--x0D0mIEVFPsVmKoF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmM6mWkACgkQeFA3/03a
ocVt3Qf/aG04QFU7nLTwoPijteeqL5jPlQAqaR1Fi/GtB8VuobNW8/WHJPtmN/bx
c67raGHPBJJXcYWLDImi/eLIqPk7lNBK/92+HqYQKqjJPB/mqpVx/JGL3xkKnxtK
vKjEaM2lQABCUR/Rr/znPnTSA5eSImEaDTd/kU8kAdizApLVLwjc8LPG61TFqTTz
5zEkZOdQ2NZegW4ruKA4sMgIX5VxhDCNyEyZMVoPq/QgLFCvPqg2hpiE02yUaXnR
inwUNhZ/rvomK48Jik+mTcweWl3h8SVTQKLfdW8guyoYJ8qgL8XJ+Y2LVDZAh9Pa
F0h2ceYXstSJB9BDmjC+/wAz5lV92A==
=f2sE
-----END PGP SIGNATURE-----

--x0D0mIEVFPsVmKoF--
