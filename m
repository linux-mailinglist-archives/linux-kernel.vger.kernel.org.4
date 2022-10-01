Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336F95F1AA7
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 09:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbiJAHoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 03:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJAHoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 03:44:11 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563BF153A7C;
        Sat,  1 Oct 2022 00:44:10 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id a2so10002506lfb.6;
        Sat, 01 Oct 2022 00:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=HugR/NLJXFQfozYZ66e+YMwVjhph0I2XzzQk2oljY3o=;
        b=K6XnEKHhkISLsNnZ+PqmRwXwEmcNFDlHFiGA32RcsPN4yXexBh2371BaDigsOMFxLd
         dFCJhUMeJAdxOIOVI3jQghfhUIedvxuYMFmXQ8T/912KnMtyCmhCueNpYGiGwsR8lmXX
         Dex7gYU68FzQlAc9yU05Dv/syh0K6+m9AxLZcjsQBnSiq5Xj9PTA+jFqEtRyRBBZN0Ji
         1CfWA8YEmCxiZ1LnaX3VEkb9LeedEp4ydqBj7dlBmqerdlbL1VfM+nAlQEIbC4OP1ZT+
         yxELqRVbO3Z4w3hcmSG4La44+oHgAbHVGl5aYtJL0NnGHOJaqey3P0Y5ydhDc1I4oxj6
         3Q3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=HugR/NLJXFQfozYZ66e+YMwVjhph0I2XzzQk2oljY3o=;
        b=OWLTjMHAreTX4es+rk7DD9qLoG3zkPmWK20KCQO91O6StnKxG3Pn62AqIXKuHNZIF5
         T0wscS2pO+7E7y740de/F85sdWNNl0FeNxso4kEfZ4aO4smfDepRCbb5OeHfy9hy1w5T
         opCpuPqwCMeZ/uyXfTcEk840+VMuovco2bL28cw7xXpi3eushda8WUOyT7eppBb0Ss58
         RlgPU8+tZMonl/6ubMZRRIlBuhhJYyk9pq8wzVm1rNZXVSg3oxaY/Ony9cLNZ2ViR8OM
         DPaZTDvzIoU3xbTIRhdc02eyQmQaSwrg912h1fXtpSoBdlCMXCZb8eRpOrlyNE7oVXiH
         AD/Q==
X-Gm-Message-State: ACrzQf3+qUmKvevoeyPKtKtqeDlSNCifPt2RM00CxaTZzf10p7g77545
        mex0mVJroSQfmXWUzeOqhCI=
X-Google-Smtp-Source: AMsMyM4ByumW4JDxNyG8DNIURZfGCkHffICG/1xi8XrU8oXss1j1HhVqLqIYRmLyvTOVMP0tUbbdZA==
X-Received: by 2002:a05:6512:31c8:b0:49c:db9d:bb97 with SMTP id j8-20020a05651231c800b0049cdb9dbb97mr4300336lfe.12.1664610248572;
        Sat, 01 Oct 2022 00:44:08 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id h19-20020a056512221300b00498f67cbfa9sm671086lfu.22.2022.10.01.00.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 00:44:07 -0700 (PDT)
Date:   Sat, 1 Oct 2022 10:44:01 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Mihail Chindris <mihail.chindris@analog.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        chrome-platform@lists.linux.dev
Subject: [RFT PATCH v2 1/2] iio: Add IIO_STATIC_CONST_DEVICE_ATTR
Message-ID: <ad6753e27cfefe9ecb5db2c089d1fcee427ab7c9.1664610071.git.mazziesaccount@gmail.com>
References: <cover.1664610071.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xd5zRoFn41p0ColK"
Content-Disposition: inline
In-Reply-To: <cover.1664610071.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xd5zRoFn41p0ColK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add IIO_STATIC_CONST_DEVICE_ATTR macro for creating an read-only
iio_dev_attr which returns constant value. This macro is intended to be
used when replacing the IIO_CONST_ATTR - attributes for triggered
buffers because the triggered buffer attributes must be of type
iio_dev_attr.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 include/linux/iio/sysfs.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/iio/sysfs.h b/include/linux/iio/sysfs.h
index e51fba66de4b..de5bb125815c 100644
--- a/include/linux/iio/sysfs.h
+++ b/include/linux/iio/sysfs.h
@@ -97,6 +97,17 @@ struct iio_const_attr {
 	=3D { .string =3D _string,						\
 	    .dev_attr =3D __ATTR(_name, S_IRUGO, iio_read_const_attr, NULL)}
=20
+#define IIO_STATIC_CONST_DEVICE_ATTR(_name, _string)				\
+	static ssize_t iio_const_dev_attr_show_##_name(			\
+					struct device *dev,		\
+					struct device_attribute *attr,	\
+					char *buf)			\
+	{								\
+		return sysfs_emit(buf, "%s\n", _string);		\
+	}								\
+	static IIO_DEVICE_ATTR(_name, 0444,				\
+			       iio_const_dev_attr_show_##_name, NULL, 0)
+
 /* Generic attributes of onetype or another */
=20
 /**
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

--xd5zRoFn41p0ColK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmM378EACgkQeFA3/03a
ocXKeAf9HN002m865SDcUlmLtg0aCs/YoUrIHeUs903yq/3AedvqFTck32PpJzs5
l5Lg7yVnTVBJchAdezzNQghJuAcWqQZsoO1qT9HF+dTumrTM46zJ/vs87li1wWIP
hPMyaxcuCUyaKPTXEPYawiAihAChYcurB7bm1VLwjtoI9f9kSAYMvNIerfXi11v/
/T1kipzgSUv79MaojvGw5iYNbkcrMhi9+rZXegQl+YiicZ7dEtjHhI6o1SifTzmT
oV5x77T3dFww7/P25HfYhWyvfCPTTPuiRmzS6sHpH0H4PbFPhel9ULa2xHtr/NCy
qfQUs3ugjSq+s3gwzpehS6cAtte2GA==
=DkLa
-----END PGP SIGNATURE-----

--xd5zRoFn41p0ColK--
