Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D73572DDD4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 11:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237306AbjFMJfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 05:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241941AbjFMJfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 05:35:04 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8803610DE;
        Tue, 13 Jun 2023 02:35:01 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f642a24568so6432082e87.2;
        Tue, 13 Jun 2023 02:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686648900; x=1689240900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oKSIUrG32f08MFv02xTotJtCAWI/Mr97EQR5Ga4cpVM=;
        b=B+2aL3qmIsa0vDLr8SiPBpJu3gqTyGGPDdEiyfLAm7ojIxcfDdzb99Kk56so0Eeg4E
         LaHsApWadMm6oFEXfO4lBw5Agao1TwdPwCCbjYdPRenb8iS8VbSa5DL3lQGkBT7r3dSZ
         sEYsIY82nIqPnqdu5EEFtp5aTHIjLMTuraU6hta77AHC5t4T3gZRMGJYJTRK1Rfvpy61
         f5+J6diqQ3nO51s0xNXOE4jiePyf+TPWak8VEMyR1Z6wALxvIdmCuYtPRzQqxLm/7786
         YpEdebJXAwPQjgA4fW2xMAinzF+ha4QqSNgAe1kmgmqxQ2vw0gqSE4bPtC325yAwpzOq
         f3lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686648900; x=1689240900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oKSIUrG32f08MFv02xTotJtCAWI/Mr97EQR5Ga4cpVM=;
        b=SMV9qJwlZ0XPPvMhryPKMjYMG9sZFa2MVfjbW81mw+W9PJ88THMcCf6AoAHWrmn7jC
         n6hVmVtTxZAnO+eD56CA460KBDavP6RIsehUUqo5/RQGQgEn3PIF/KIGPtEdKpGXeVVb
         tcsT5ywgL3+7HfHeEEGb02gkB9OdYDz/zR+r0vMtNLjOlRQbomPa3rAsDB0ELnxJXr9m
         Nm9iIM87cHg/kAhEGCwxsG20OWCWS4+8b7v+K9HtaMWZLpd8Wo1lbYAVKFpix7Y2DpgA
         Nf5cSL1x/8b7EMVrYSEJN18XNWigsNUHEXRlwJV5U9F7OfMktNBbxVzT6hyROkgskHKJ
         9Itw==
X-Gm-Message-State: AC+VfDzKbqMdfpeVcNIwSTtfqg62Oq9inlH+hWJGV5JQb4/p3YDhqJOV
        JUKnFREk4MwIF1Qf5GP10Q9zO7KLdPk=
X-Google-Smtp-Source: ACHHUZ45oIsxO/H3gPCB+qwNMtRcE1YV78oGM+P6l/w8IlLjKFyyKh+xcyOfBkPDq0FxghLosuGmtg==
X-Received: by 2002:ac2:464a:0:b0:4f6:1160:b956 with SMTP id s10-20020ac2464a000000b004f61160b956mr5067416lfo.54.1686648899686;
        Tue, 13 Jun 2023 02:34:59 -0700 (PDT)
Received: from dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::1])
        by smtp.gmail.com with ESMTPSA id q28-20020ac24a7c000000b004f00189e1dcsm1707261lfp.117.2023.06.13.02.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 02:34:59 -0700 (PDT)
Date:   Tue, 13 Jun 2023 12:34:55 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] iio: light: bu27008: Fix scale format
Message-ID: <e4778b74cde41431f77bc8dd88ec18605da0b400.1686648422.git.mazziesaccount@gmail.com>
References: <cover.1686648422.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8eb3CYBD1iP+J9nU"
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


--8eb3CYBD1iP+J9nU
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

---
Fixes tag not added because AFACS the bu27008 is not yet in any releases.
---
 drivers/iio/light/rohm-bu27008.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/rohm-bu27008.c b/drivers/iio/light/rohm-bu27=
008.c
index 489902bed7f0..80eb14ea8193 100644
--- a/drivers/iio/light/rohm-bu27008.c
+++ b/drivers/iio/light/rohm-bu27008.c
@@ -633,7 +633,7 @@ static int bu27008_try_find_new_time_gain(struct bu2700=
8_data *data, int val,
 	for (i =3D 0; i < data->gts.num_itime; i++) {
 		new_time_sel =3D data->gts.itime_table[i].sel;
 		ret =3D iio_gts_find_gain_sel_for_scale_using_time(&data->gts,
-					new_time_sel, val, val2 * 1000, gain_sel);
+					new_time_sel, val, val2, gain_sel);
 		if (!ret)
 			break;
 	}
@@ -662,7 +662,7 @@ static int bu27008_set_scale(struct bu27008_data *data,
 		goto unlock_out;
=20
 	ret =3D iio_gts_find_gain_sel_for_scale_using_time(&data->gts, time_sel,
-						val, val2 * 1000, &gain_sel);
+						val, val2, &gain_sel);
 	if (ret) {
 		ret =3D bu27008_try_find_new_time_gain(data, val, val2, &gain_sel);
 		if (ret)
@@ -677,6 +677,21 @@ static int bu27008_set_scale(struct bu27008_data *data,
 	return ret;
 }
=20
+static int bu27008_write_raw_get_fmt(struct iio_dev *indio_dev,
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
 static int bu27008_write_raw(struct iio_dev *idev,
 			     struct iio_chan_spec const *chan,
 			     int val, int val2, long mask)
@@ -756,6 +771,7 @@ static int bu27008_update_scan_mode(struct iio_dev *ide=
v,
 static const struct iio_info bu27008_info =3D {
 	.read_raw =3D &bu27008_read_raw,
 	.write_raw =3D &bu27008_write_raw,
+	.write_raw_get_fmt =3D &bu27008_write_raw_get_fmt,
 	.read_avail =3D &bu27008_read_avail,
 	.update_scan_mode =3D bu27008_update_scan_mode,
 	.validate_trigger =3D iio_validate_own_trigger,
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

--8eb3CYBD1iP+J9nU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmSIOD8ACgkQeFA3/03a
ocWAnwf/QwkW5XP56+q9/tOHL6thmq5bbQeoCwKDeWcLMuj9HiOQ7WQ67ekPswtI
aj2b/g0btom6/OY6kGxcHMFlGQ85MI/tFekupitxGrGnB+u7z6lRneh3d0ZSOp+j
oPF1PbUjC7pLDdv2udeFhWrlRNg0zAD+g40eAlDZcLwCKdqbvnWebJq6eka3gZaP
NFVucs8oC1eJHhuVRcW9o82+neadTfDljGxpG+Kiv/pxA6MXbUCH0TSB5eoOBBBt
C5/YtZTpbPE3BCDAuyEoW9eE1rdRszdZErD8Tdgjqp6HC4hUoBy3ymHokgmYuy5n
GiaLoLgDa9MGpyO6RJEO58kaYFzUcA==
=uMZ4
-----END PGP SIGNATURE-----

--8eb3CYBD1iP+J9nU--
