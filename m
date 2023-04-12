Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03CC66DF52F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 14:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjDLM1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 08:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbjDLM1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 08:27:36 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5017030EE;
        Wed, 12 Apr 2023 05:27:26 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id t20so14439552lfd.5;
        Wed, 12 Apr 2023 05:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681302444;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sgOwPu+FboPmTEq+F0N4Fog/45+TxGJHI0yCy72fcPY=;
        b=bUGFSLOHSf8IOPs0vBg4h3142MTO/Uar2S7LbKDhUcqBXArUyeIogzmCBzqZpLXbOv
         6LEcsgmaK5Iz536y7HqVscXtUbwLtyt6isKczHv7M851ZqYxFF2C1PLxawMExL1/rJtx
         cXQJ1wkeyR4oiJNPQX/aoYi5FapO4QAG/EyARlWXGnLD5ZUrUe9jOznW2cmp7hVS1u7A
         g+dZaNUjXBPvbBlef8wczMA5/f7iyn0hByjFS4Yw+aeL2O6vt3I/VBiQHPdJ06vbJv7n
         UJprE3rDrj7y9Ud3K/iJDpBQ/NGBuzJtbkyPoutOGfEePpFB9DeLjzsmIW0y7dHDflxU
         e8/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681302444;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sgOwPu+FboPmTEq+F0N4Fog/45+TxGJHI0yCy72fcPY=;
        b=TS5j7l6NxcNnqz7+K/xK1agVy9J4dTwwwwTjmylQyXSAhk6npRxGPNdhrx8jSaSCCp
         thfYXXYHqeufASOMljDSVHz7vrAZniuXhNXxyQBZAiV7CTcbuv9dSWHAUJyYiwPmN2Cm
         NfVl5aRVFEDLJDBrcHvGEnojVemmRB1Uq/7+hyOBq/T2YwY5mJnNxlWNHaCqDDOyqmxn
         f3+O5NPGsRkk3dXGRBHrm82EjFCFipmknU3I/OwctaQiX7vrk0bXqPappjodRS5x452G
         e1No0WMoT6T2fQudhCiSBOclc9uZviIPPViBZjV7x9Ymd4K9mKj7bsmuPRsQkSs7+fWc
         hC2w==
X-Gm-Message-State: AAQBX9cGY4msQ/gspEF4jkcUs1KFw6f0jbUhXAOGg5Eue6rexyrJys/w
        6WupzRcNq/2H95rZM9LQkuc=
X-Google-Smtp-Source: AKy350aBtZqbgVz7RlRlx7n4YpwLva9wu/Kfqr4nf7VKOrm3wlO+oRyizn3t5nCyVXo4+TKAfWEffw==
X-Received: by 2002:ac2:44a3:0:b0:4e9:bf52:7898 with SMTP id c3-20020ac244a3000000b004e9bf527898mr566918lfm.37.1681302444438;
        Wed, 12 Apr 2023 05:27:24 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id z20-20020ac25df4000000b004d85895d7e0sm2984411lfq.147.2023.04.12.05.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 05:27:23 -0700 (PDT)
Date:   Wed, 12 Apr 2023 15:27:14 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] iio: core: add IIO_VAL_INT_MICRO
Message-ID: <d31f2ebf08837337d3bbc6a00fd4b5eb3c86a04e.1681301472.git.mazziesaccount@gmail.com>
References: <cover.1681301472.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gz1hgTNomGVmMv2T"
Content-Disposition: inline
In-Reply-To: <cover.1681301472.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gz1hgTNomGVmMv2T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

There are a few cases like light sensor integration times, where values
returned from *_available() and read_raw() are smaller than 1 and often
in the units of micro. (Like micro second scale integration times,
always smaller than 1 second). Currently those are often handled using
IIO_VAL_INT_PLUS_MICRO, which requires drivers to initialize the integer
part to zero. Furthermore, using IIO_VAL_INT_PLUS_MICRO in iio lists
requires one to always allocate the 'dummy' integer part too.

Introduce IIO_VAL_INT_MICRO which allows omitting the always zero integer.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 drivers/iio/industrialio-core.c | 4 ++++
 include/linux/iio/types.h       | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-cor=
e.c
index c117f50d0cf3..c5ae965e9961 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -628,6 +628,8 @@ static ssize_t __iio_format_value(char *buf, size_t off=
set, unsigned int type,
 	switch (type) {
 	case IIO_VAL_INT:
 		return sysfs_emit_at(buf, offset, "%d", vals[0]);
+	case IIO_VAL_INT_MICRO:
+		return sysfs_emit_at(buf, offset, "0.%06u", vals[0]);
 	case IIO_VAL_INT_PLUS_MICRO_DB:
 		scale_db =3D true;
 		fallthrough;
@@ -758,6 +760,7 @@ static ssize_t iio_format_list(char *buf, const int *va=
ls, int type, int length,
=20
 	switch (type) {
 	case IIO_VAL_INT:
+	case IIO_VAL_INT_MICRO:
 		stride =3D 1;
 		break;
 	default:
@@ -952,6 +955,7 @@ static ssize_t iio_write_channel_info(struct device *de=
v,
 		case IIO_VAL_INT_PLUS_MICRO_DB:
 			scale_db =3D true;
 			fallthrough;
+		case IIO_VAL_INT_MICRO:
 		case IIO_VAL_INT_PLUS_MICRO:
 			fract_mult =3D 100000;
 			break;
diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
index 82faa98c719a..b4e316172c7f 100644
--- a/include/linux/iio/types.h
+++ b/include/linux/iio/types.h
@@ -30,6 +30,7 @@ enum iio_event_info {
 #define IIO_VAL_FRACTIONAL 10
 #define IIO_VAL_FRACTIONAL_LOG2 11
 #define IIO_VAL_CHAR 12
+#define IIO_VAL_INT_MICRO 13 /* val is micro <units>. Integer part is 0 */
=20
 enum iio_available_type {
 	IIO_AVAIL_LIST,
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

--gz1hgTNomGVmMv2T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmQ2o6IACgkQeFA3/03a
ocW9dwgAm5gXd6P5IM7E20MDnCZ13JMqH+T+CaLy/qNgH/Omql1WMqmx10qCE5rV
ORaDYyfQlC5T9S8I0aGhttmkY/DFmaRF+lvFWPJa53331PZ9LfHKfIGOzzOivdGR
RjNFHICWrdqKMHthTNw859gSQcn5Hs6U7+4YPWLiDAlvPzG5eyPCv0PmYiZMQQIy
l/kwweLcycCJLy8j9Nc9WIU0CJDCjEktf+vkfRBCRFmfAyf0etQrzoNzY1J+cAGp
Lat0xH7PTRerwIOdvt4RMM+M1SVGxJ7JDaenrlMvbe3GhY5jcaWh0hIUWJ4J+Q8P
vuHeQ5NUV1/mzn19tpLkeTO0ysUC+Q==
=e+OH
-----END PGP SIGNATURE-----

--gz1hgTNomGVmMv2T--
