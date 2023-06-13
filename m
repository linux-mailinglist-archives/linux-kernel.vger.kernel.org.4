Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C6372DDD3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 11:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240873AbjFMJfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 05:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240727AbjFMJeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 05:34:44 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC3310C6;
        Tue, 13 Jun 2023 02:34:42 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f5f728c4aaso6180723e87.0;
        Tue, 13 Jun 2023 02:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686648881; x=1689240881;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o6Psb5RzioVdv/upXxW5xP0CZJnFju9Mn7noJG9metU=;
        b=U0qFk2NHmdFHLVYK1fC29dJoOLEi5nDNoxvVWPiYdXeeJcOK6yjfONOq90JJ95jKis
         NKPJtFtJzZwCSdiR4kcOVURutAlHbK3eStqyD9xMpChTMmjlpxIvmEshZS941a78iPBw
         1SKkileQ/L4oOiDbM24gdHR5PeapqxGzJB64mnMd29sja9F3qpjZVY+CIEFQnVg7YJLG
         mq+0uUzvwPuC1TkHZFX13EAQME75E5FnJ9B5SNoIH8YlHH2z3Lmve13S0vLFSJFIWquQ
         2E/k7eFT9tJXimdIl/dQG1EihPnlhf+MR0i/+Wyf55boBoqh8tgN8CgyEi1oqGNQ2ymz
         tW5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686648881; x=1689240881;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o6Psb5RzioVdv/upXxW5xP0CZJnFju9Mn7noJG9metU=;
        b=BaemCsn4vnIUWskAOcyPaPkcBDViz0adpeVoDUOHdqauvjl51yNO5lCY1GU4Ns4PKQ
         O7C9ZnQhr4pXeK7iJA9NNgBw4vrne21MERBQtQueGdDjGRHhIZoqAT5/DgteOHcZyaXU
         dNUpVP6eQzpVEe5T0CEq2GRY3zvt/5UUmE3wMvWmcSQez3pV39MpzCwAVfnsj96F83U8
         xB5QgazxK6YqjYc9tmMFI9P6+731a5Ow0mwVSfJ5//UByflzRP/WCOjrYfgSNfxH8RDO
         Nd7QUQr3lhDLGlktvHqKuo3ixDrlVU5GvVyxwjK0JDCF5013lPnxIOPOlzSZ1RS4xW3f
         su3g==
X-Gm-Message-State: AC+VfDwxXbPTbZans3QZ3xe6864R1pgfb2/wz3aX1f5EnFaU42bg6nZX
        1QFd8vwrKX7ScyuAzgVU26A=
X-Google-Smtp-Source: ACHHUZ4DvdS43yV7tz2knsJSxTI8isfz/lmehbyv4sDn9SZb2UJ6w/yaUUDhDu6nTh9DrolxDEKvhw==
X-Received: by 2002:a19:4f15:0:b0:4f6:5473:7bf0 with SMTP id d21-20020a194f15000000b004f654737bf0mr3802608lfb.21.1686648880585;
        Tue, 13 Jun 2023 02:34:40 -0700 (PDT)
Received: from dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::1])
        by smtp.gmail.com with ESMTPSA id o14-20020a056512050e00b004f517c21ef0sm1722501lfb.82.2023.06.13.02.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 02:34:39 -0700 (PDT)
Date:   Tue, 13 Jun 2023 12:34:36 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] iio: light: bu27034: Fix scale format
Message-ID: <5369117315cf05b88cf0ccb87373fd77190f6ca2.1686648422.git.mazziesaccount@gmail.com>
References: <cover.1686648422.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nu5zW1gmaBLRAMXS"
Content-Disposition: inline
In-Reply-To: <cover.1686648422.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nu5zW1gmaBLRAMXS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The driver is expecting accuracy of NANOs for intensity scale in
raw_write. The IIO core is however defaulting to MICROs. This leads the
raw-write of smallest scales to never succeed as correct selector(s) are
not found.

Fix this by implementing the .write_raw_get_fmt callback to use NANO
accuracy for writes of IIO_CHAN_INFO_SCALE.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Fixes: e52afbd61039 ("iio: light: ROHM BU27034 Ambient Light Sensor")
---
 drivers/iio/light/rohm-bu27034.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/rohm-bu27034.c b/drivers/iio/light/rohm-bu27=
034.c
index 846c3d43aa34..f737d62bdf92 100644
--- a/drivers/iio/light/rohm-bu27034.c
+++ b/drivers/iio/light/rohm-bu27034.c
@@ -572,7 +572,7 @@ static int bu27034_set_scale(struct bu27034_data *data,=
 int chan,
 		return -EINVAL;
=20
 	if (chan =3D=3D BU27034_CHAN_ALS) {
-		if (val =3D=3D 0 && val2 =3D=3D 1000)
+		if (val =3D=3D 0 && val2 =3D=3D 1000000)
 			return 0;
=20
 		return -EINVAL;
@@ -584,7 +584,7 @@ static int bu27034_set_scale(struct bu27034_data *data,=
 int chan,
 		goto unlock_out;
=20
 	ret =3D iio_gts_find_gain_sel_for_scale_using_time(&data->gts, time_sel,
-						val, val2 * 1000, &gain_sel);
+						val, val2, &gain_sel);
 	if (ret) {
 		/*
 		 * Could not support scale with given time. Need to change time.
@@ -621,7 +621,7 @@ static int bu27034_set_scale(struct bu27034_data *data,=
 int chan,
=20
 			/* Can we provide requested scale with this time? */
 			ret =3D iio_gts_find_gain_sel_for_scale_using_time(
-				&data->gts, new_time_sel, val, val2 * 1000,
+				&data->gts, new_time_sel, val, val2,
 				&gain_sel);
 			if (ret)
 				continue;
@@ -1213,6 +1213,21 @@ static int bu27034_read_raw(struct iio_dev *idev,
 	}
 }
=20
+static int bu27034_write_raw_get_fmt(struct iio_dev *indio_dev,
+				     struct iio_chan_spec const *chan,
+				     long mask)
+{
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		return IIO_VAL_INT_PLUS_NANO;
+	case IIO_CHAN_INFO_INT_TIME:
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+}
+
 static int bu27034_write_raw(struct iio_dev *idev,
 			     struct iio_chan_spec const *chan,
 			     int val, int val2, long mask)
@@ -1260,6 +1275,7 @@ static int bu27034_read_avail(struct iio_dev *idev,
 static const struct iio_info bu27034_info =3D {
 	.read_raw =3D &bu27034_read_raw,
 	.write_raw =3D &bu27034_write_raw,
+	.write_raw_get_fmt =3D &bu27034_write_raw_get_fmt,
 	.read_avail =3D &bu27034_read_avail,
 };
=20
--=20
2.40.1


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

--nu5zW1gmaBLRAMXS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmSIOCwACgkQeFA3/03a
ocXCAAf9ERi4KO6rwKLhEuFdPFdT/FdFqLaO52sZGLctWan4v97H2FXMfxftrlIF
qwpKynSIi8iXl4FHVqxqw6JfCjKbYhb77DOsxKiHdbGNRDDr2TtVzffT5iLZgUSY
vLnnA/QLdjYx1w9oRdP3TOWBW3rz+9oyhyvRerhYYbc2t3pq9Z6dLENHJ+nvvfD4
yN4i7EGiX/T1hEbTakYp142ZIv9eaLex4PV0yjpaCoTNwZPbYBZFrvAunAeJrnJB
HmczDnxqxn2YQc2Iiyb3ETv1qlqZgf1ata7edS3po8XAUPrxuP9bvlTA6Yzpl/ZH
TsoO/9EnLc2PCK1kt5cpCqe1+McSlg==
=jbbw
-----END PGP SIGNATURE-----

--nu5zW1gmaBLRAMXS--
