Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799E55F09B7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 13:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbiI3LPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 07:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbiI3LO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 07:14:29 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D33DBF1D8;
        Fri, 30 Sep 2022 03:54:27 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id g1so6284096lfu.12;
        Fri, 30 Sep 2022 03:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=vt4anCeshQmpiBAIkV+85GsPhIKG979bY2xHCX0TUWI=;
        b=Wa+S+q8QyCffEYBzox4w4HqnuUEYeyAkthi5BEHLLCnyCWTL4PHBMGJW4BLsWMW8Xx
         gcysaVyAizRveM48sYPDkQXlxV5fZXbPEbwdIWPtb/ukp2ICABCeRHWcTK2idn8rhVUQ
         cAyBK20q5Hn7qmzgZ8YLq+zf1khAr4dV0ZQ59GqOshhVYPi5qCYa0hT63BOGsJPfCuDO
         XB1PAcA/mubqnYvDqC5Hc0X+b/eOySLFWSMxYdaEQB/bzpWbH/RjeBSgfEz8ICp80HaJ
         +Is23YZsiEB+Mm+pWlgTA+uaPIEl06FxWJ/HzTCW7xlaomssg3xbQqJ8kbLsUSk+lR19
         KECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=vt4anCeshQmpiBAIkV+85GsPhIKG979bY2xHCX0TUWI=;
        b=i4io4aW+eKxLT80T+LDrmyoao/1nvi96gl0Sd7xsAqAjIqObZdgQDxVclSMdQtH71z
         I++sZZLQc1YKdup1Ng3S8VZdB58qB1EsDTHvNg7N0OCCtYw1EmPSygHt+PRUSEi2VZF9
         cSL8YLSgxZDzfSvKy2VuAsGCtCSzdCva5OxMNu1PHsqUdisq+YzRDQMyFY9KI4Vbacog
         8G7uSQ+DKyoyxYZ3TQxL8+1J8eRr1+kLQNdsrYhJSlq3klEpJq3qNGjJ8ALXUvk2ZWZ5
         K7kmohWVzSY72+qf2e+A3gqsdSr7AUCMEn50YpxfBqEhdzDuj51gr7UBGA+Jan4fuQDW
         Jj5A==
X-Gm-Message-State: ACrzQf0JeMaJgdsyfbRwXO3ci/F4hqOyeYEEqK6r/JnPgr08nPJh1q41
        wdwdJ5muyNX+a1HWK0cHQfA=
X-Google-Smtp-Source: AMsMyM50tO3mQSdFG6Os81ZjoAEmNUS6e26q/o86wVvr0FXiZYyQ52RLD1uEmRsDyyrRPR686qpTWA==
X-Received: by 2002:ac2:4945:0:b0:498:eb8d:e283 with SMTP id o5-20020ac24945000000b00498eb8de283mr3210641lfi.192.1664535265313;
        Fri, 30 Sep 2022 03:54:25 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id u1-20020a056512128100b0049b8c0571e5sm258565lfs.113.2022.09.30.03.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 03:54:24 -0700 (PDT)
Date:   Fri, 30 Sep 2022 13:54:08 +0300
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
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Mihail Chindris <mihail.chindris@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] iio: Add IIO_STATIC_CONST_DEVICE_ATTR
Message-ID: <57fa292756e187d104249f39a655ae736cbcaa76.1664534676.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2YvFr+H0AS5yMMpx"
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


--2YvFr+H0AS5yMMpx
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
I am not thrilled about how keyword 'static' is handled here but in my
calendar this day seems to be called the day of the developer without
working ideas. Feel free to suggest something if you guys have more
luck with ideas. :) And I still think this macro is better than adding
the summy 'show' callback in each individual driver :/

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

--2YvFr+H0AS5yMMpx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmM2yr4ACgkQeFA3/03a
ocV+IQf+KnlB/0pYgeZf3Rc8bquy7j39FdT601xZPf43MK3TyyP6SaiPW1eRDLzo
D4NP8eDYp4RO8ceMgzodKKNoKsDc7HTH/KGUmnc3Eo3SF7m7knL6peIXgB8mWbFx
C44Nj4OINEnB+DshtqzBZjNCzICa2bUq7ZQ8Xb3Qi4OUuUrXZbrgQuYiU4kmoa9j
UZ7VN+fiYurFa7/Fq8NYXNk4uNt/EtbA0J7wzzDfg5aplM0b4Qz2d8d4By26mXUm
H1ik3qMvxMNfI3yMbRy1tVQry3CrHGdTEjZoCSxXp8yzlR+lsu2hH9HUhYuKvcUL
joLoK0nBy7/Fm3k7yh606lQERdepMA==
=sil0
-----END PGP SIGNATURE-----

--2YvFr+H0AS5yMMpx--
