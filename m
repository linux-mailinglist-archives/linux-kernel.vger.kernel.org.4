Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC3E6E438C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 11:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjDQJUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 05:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjDQJUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 05:20:43 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE2010E7;
        Mon, 17 Apr 2023 02:20:26 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2a8b8c80db9so11599531fa.1;
        Mon, 17 Apr 2023 02:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681723224; x=1684315224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8b+q13nOOBtyDIGmwslVX6ZI5LmXIGzDuTS6Q5xdYVU=;
        b=swybqH6ujpUgYy6FrANHlG+F64x8pQ+8ITmzZB5kBHu0pBn5FczbQ4/WTQ0MgkIwyq
         LVZ6j3h0MiZdETdryg34CJ3tE1noLFpRC2Lo7Uqy0qdSxEVkCYmkjnd6qiSGOutlfme7
         0007psIpqa8Jaw8oaBREtrCmq9meogBU9suALO4GW5dBDn5abkVBg/4RheliP00kRTLI
         9NmxvnQEhsXq0QiU93M7kqB4QUoq5DONSS84uBfNkFu469nj2DnhT6Fj5NGl9Sw8AyNI
         9pp6LUrIl/HsO7qqbQgnbeQlbJfweOCYKzRXKKCoHIZbN4z9uF27o5z5zmz+OgenMNYa
         2zLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681723224; x=1684315224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8b+q13nOOBtyDIGmwslVX6ZI5LmXIGzDuTS6Q5xdYVU=;
        b=MSIVwh7p7s8lmo8CrNL/fJ0DXhlHemmfmaYlb/DiPyvKSFbfW2I8l7xD21dQ/oFKhu
         vUizOG6vz5n+DeI1l8p3oc2S1i/Lda8+wEC0w6BzxYWOw7X3ILnV/fy52JdBJfbfyl9G
         hzcxVAj/26H4VYk7J+6ziHChjaN5xWzRvh8l9Ztzib+mhIkJKB7KmhzvzoXL2EW8XIm7
         Q7x2KUTP7yHgWQ06VgdKjHiIs70WHwwzA5rr6CZgBQ1j1LVE9qasDMSnKHKfHNoJfvgu
         H/K4A9Ax1Akcsk9Ro25xq18dEt+gBzF2Q4Dch3wRLzCJD9bqwh/+u8xqH2hbrXQ6li2b
         Uaxw==
X-Gm-Message-State: AAQBX9cbYXxZs7UwH6O5hQzZZZIT1MM+tr/0uUgCQoRXSV4tx43qsfhX
        CJ0pdUOjVpZVtE9Q2fcHPlirnBLOZOw=
X-Google-Smtp-Source: AKy350Y9pqjKy4+i0byTFJuew9nA4Ou8wrb6zzGnvmYOIKikh+S6EDuU2WfjMGRU5d15Yw3h4Z68rg==
X-Received: by 2002:a19:7608:0:b0:4eb:1495:44ee with SMTP id c8-20020a197608000000b004eb149544eemr1459094lff.48.1681723224373;
        Mon, 17 Apr 2023 02:20:24 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id p9-20020a2e8049000000b002a8c7bd0798sm426456ljg.86.2023.04.17.02.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 02:20:23 -0700 (PDT)
Date:   Mon, 17 Apr 2023 12:20:18 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iio: gts-helpers: fix integration time units
Message-ID: <eeacd192c259e885850b5a2dd8b776bccfc44fa8.1681722914.git.mazziesaccount@gmail.com>
References: <cover.1681722914.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UVr4ML6isnaPQ+Co"
Content-Disposition: inline
In-Reply-To: <cover.1681722914.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UVr4ML6isnaPQ+Co
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The IIO ABI mandates expressing integration times in seconds. The GTS
helper errorneously uses micro seconds in integration_times_available.
Fix this by converting the lists to IIO_VAL_INT_PLUS_MICRO.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 drivers/iio/industrialio-gts-helper.c | 43 ++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrial=
io-gts-helper.c
index 8bb68975b259..2ab8d2dce019 100644
--- a/drivers/iio/industrialio-gts-helper.c
+++ b/drivers/iio/industrialio-gts-helper.c
@@ -337,6 +337,17 @@ static int iio_gts_build_avail_scale_table(struct iio_=
gts *gts)
 	return ret;
 }
=20
+static void iio_gts_us_to_int_micro(int *time_us, int *int_micro_times,
+				    int num_times)
+{
+	int i;
+
+	for (i =3D 0; i < num_times; i++) {
+		int_micro_times[i * 2] =3D time_us[i] / 1000000;
+		int_micro_times[i * 2 + 1] =3D time_us[i] % 1000000;
+	}
+}
+
 /**
  * iio_gts_build_avail_time_table - build table of available integration t=
imes
  * @gts:	Gain time scale descriptor
@@ -351,7 +362,7 @@ static int iio_gts_build_avail_scale_table(struct iio_g=
ts *gts)
  */
 static int iio_gts_build_avail_time_table(struct iio_gts *gts)
 {
-	int *times, i, j, idx =3D 0;
+	int *times, i, j, idx =3D 0, *int_micro_times;
=20
 	if (!gts->num_itime)
 		return 0;
@@ -360,6 +371,7 @@ static int iio_gts_build_avail_time_table(struct iio_gt=
s *gts)
 	if (!times)
 		return -ENOMEM;
=20
+
 	/* Sort times from all tables to one and remove duplicates */
 	for (i =3D gts->num_itime - 1; i >=3D 0; i--) {
 		int new =3D gts->itime_table[i].time_us;
@@ -378,13 +390,24 @@ static int iio_gts_build_avail_time_table(struct iio_=
gts *gts)
 			}
 		}
 	}
-	gts->avail_time_tables =3D times;
-	/*
-	 * This is just to survive a unlikely corner-case where times in the
-	 * given time table were not unique. Else we could just trust the
-	 * gts->num_itime.
-	 */
-	gts->num_avail_time_tables =3D idx;
+
+	/* create a list of times formatted as list of IIO_VAL_INT_PLUS_MICRO */
+	int_micro_times =3D kcalloc(idx, sizeof(int) * 2, GFP_KERNEL);
+	if (int_micro_times) {
+		/*
+		 * This is just to survive a unlikely corner-case where times in
+		 * the given time table were not unique. Else we could just
+		 * trust the gts->num_itime.
+		 */
+		gts->num_avail_time_tables =3D idx;
+		iio_gts_us_to_int_micro(times, int_micro_times, idx);
+	}
+
+	gts->avail_time_tables =3D int_micro_times;
+	kfree(times);
+
+	if (!int_micro_times)
+		return -ENOMEM;
=20
 	return 0;
 }
@@ -683,8 +706,8 @@ int iio_gts_avail_times(struct iio_gts *gts,  const int=
 **vals, int *type,
 		return -EINVAL;
=20
 	*vals =3D gts->avail_time_tables;
-	*type =3D IIO_VAL_INT;
-	*length =3D gts->num_avail_time_tables;
+	*type =3D IIO_VAL_INT_PLUS_MICRO;
+	*length =3D gts->num_avail_time_tables * 2;
=20
 	return IIO_AVAIL_LIST;
 }
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

--UVr4ML6isnaPQ+Co
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmQ9D1IACgkQeFA3/03a
ocUjfQf/dufR2mfyjCq3mWntJ0bmsQuSCWRZdwOY2KayWtdyzuCFCKVhQJuhFh1+
Iyci9B+g62lrrw7lRvqo771plKsJaHlok+uHQN9bAA1cmy3pe8ajETc4btXQVFYf
coLM6F1nI23X/pAaGJx+DPeebHqfJdyCXwn12O9wpD4omztYjKfEx1zWqBNqJfCL
XqPPQMvwAHXqQo/Bae8EV30ETP85Q9Wev8BFNKMEZXYZUkA2oj6x3vdeGtBWsxIJ
62k4uuLwKY+s8Pi167k6O4UaTL+JihtOryEwATANEUQL7fdcptZwW68oC+LVUDxk
Tw50sXtbsPFSpXWuo8ODCWaUC4APZg==
=K+89
-----END PGP SIGNATURE-----

--UVr4ML6isnaPQ+Co--
