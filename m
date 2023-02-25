Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D816A2A23
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 14:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjBYNzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 08:55:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBYNzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 08:55:37 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAED11EAF;
        Sat, 25 Feb 2023 05:55:36 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id b13so1888217ljf.6;
        Sat, 25 Feb 2023 05:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y6Birj6zr+Up2uvBNon1E/yYgyj0gYX0UZuZ31HsG4w=;
        b=J50YtJj6+YLugYSEmEDy188Y1EAxh/LYAgT1+nlTQXsKrGEZT3rgbFRf6eG6hi8DZ1
         U8QSc+Y6f8T8UXlTKuVP4LbKUrNIsEPIQGwOgwjqiMBfNMgyUIauxAovBcPZHk4XfUPP
         kMkCBpgkbHTVcwMxT93QWsNLH1kFZtagcGKebGDZ13PllVYYCy+OpK5ivhh/t9nAWwuL
         JeRHxGXKEryV7EJnkrCoBCwgIWuh0wH7xw40IuPqsS5WORxlOuOvlKtpkpX0NTa1sUQu
         Alk1b/J2U3Tm6KM/BeTTeNDAanuvIy/UkRnEnKLmDH3L9JbeeT22JA5G2oGyqUPV3zh+
         92cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y6Birj6zr+Up2uvBNon1E/yYgyj0gYX0UZuZ31HsG4w=;
        b=sP+gceC6gwmNCq9kEC9y/PRAsewRF3mlgehlFX8W0jfp+oDZGM9jzQHA22St44854w
         NZosxLVE6Uy9ui4Js1XlHhVSych9e1eZmBWjfvFTCR4qO6+YucT+wcPUEyanEbMRW1K6
         /sP/tZsbqVRMPF10Gh8zx4z6GKjnHnT3LaVsJ6P5EOxVzqAhiv4wTRNFbpA7Z6sKJBkO
         EDeKvNe1cB903x3aBVR6qFanpudHyvGZQ/3n1z8dFNf6cAbizFuFGxXncrmfbSCIb95m
         eI00PNfLpHsCPvi4LSEQvy2t4KXNm+XXAbuKpgH9khX4o+XJ+vJ5NaqOhzARBGkMNluH
         bZ8A==
X-Gm-Message-State: AO0yUKU5l96DoJgWiQswvDdN5mfNv8wQcTUBP0end85eDY3dDg5IKlIj
        7tg56vDNFLzD92GLnbngnI8=
X-Google-Smtp-Source: AK7set8gOnS2wuV7hFzVXM7nPVB46pv8aRfQKrkHlNZla99hRsSAruySiYdpDmxOx4Y2vYE0J8rocA==
X-Received: by 2002:a2e:54d:0:b0:294:6d2d:c18c with SMTP id 74-20020a2e054d000000b002946d2dc18cmr6929433ljf.36.1677333334321;
        Sat, 25 Feb 2023 05:55:34 -0800 (PST)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id be40-20020a05651c172800b002959b1162f0sm172466ljb.96.2023.02.25.05.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 05:55:33 -0800 (PST)
Date:   Sat, 25 Feb 2023 15:55:25 +0200
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andrea Merello <andrea.merello@iit.it>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] iio: add documentation for iio_chan_info_enum
Message-ID: <884c8f386541ac572939b8993df7aea6ad99613b.1677331779.git.mazziesaccount@gmail.com>
References: <cover.1677331779.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oOLU5NQLSJiUk3FX"
Content-Disposition: inline
In-Reply-To: <cover.1677331779.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oOLU5NQLSJiUk3FX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Values in the iio_chan_info_enum are crucial for understanding the
characteristics of an IIO channel and the data delivered via IIO channel.
Give a hand to developers who do their first set of IIO drivers.

Add some documentation to these channel specifiers.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
Please note that I did only add documentation for entries I am familiar
with. I did still add doc placeholders for all of the enum entries to
ease seeing which entries could still be documented. Hopefully this
encourages people to add missing pieces of documentation.
---
 include/linux/iio/types.h | 46 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
index 82faa98c719a..c8e3288ca24b 100644
--- a/include/linux/iio/types.h
+++ b/include/linux/iio/types.h
@@ -35,7 +35,51 @@ enum iio_available_type {
 	IIO_AVAIL_LIST,
 	IIO_AVAIL_RANGE,
 };
-
+/**
+ * enum iio_chan_info_enum - Information related to a IIO channel
+ *
+ * Many IIO channels have extra properties. Typically these properties can=
 be
+ * read / written by user using the read_raw or write_raw callbacks in the
+ * struct iio_info.
+ *
+ * @IIO_CHAN_INFO_RAW:		Raw channel data as provided by device. Scale
+ *				and offset are often required to convert these
+ *				values to meaningful units.
+ * @IIO_CHAN_INFO_PROCESSED:	Processed data. Typically driver performs
+ *				computations to convert device data to more
+ *				meaningfull processed values.
+ * @IIO_CHAN_INFO_SCALE:	Scale to be applied to data in order to convert
+ *				it to units mandated by the channel type.
+ * @IIO_CHAN_INFO_OFFSET:	Offset to be applied to data in order to convert
+ *				it to units mandated by the channel type.
+ * @IIO_CHAN_INFO_CALIBSCALE:
+ * @IIO_CHAN_INFO_CALIBBIAS:
+ * @IIO_CHAN_INFO_PEAK:		Peak value (TODO: Since measurement start?)
+ * @IIO_CHAN_INFO_PEAK_SCALE:	Scale to be applied to the peak value in ord=
er
+ *				to convert it to units mandated by the channel
+ *				type.
+ * @IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW:
+ * @IIO_CHAN_INFO_AVERAGE_RAW:	Average of raw values (TODO: Since measurem=
ent
+ *				start or just for some undefined time?)
+ * @IIO_CHAN_INFO_SAMP_FREQ:	Sampling frequency for device.
+ * @IIO_CHAN_INFO_FREQUENCY:
+ * @IIO_CHAN_INFO_PHASE:
+ * @IIO_CHAN_INFO_HARDWAREGAIN:	Amplification applied by the hardware.
+ * @IIO_CHAN_INFO_HYSTERESIS:
+ * @IIO_CHAN_INFO_HYSTERESIS_RELATIVE:
+ * @IIO_CHAN_INFO_INT_TIME:	Integration time. Time during which the data is
+ *				accumulated by the device.
+ * @IIO_CHAN_INFO_ENABLE:
+ * @IIO_CHAN_INFO_CALIBHEIGHT:
+ * @IIO_CHAN_INFO_CALIBWEIGHT:
+ * @IIO_CHAN_INFO_DEBOUNCE_COUNT:
+ * @IIO_CHAN_INFO_DEBOUNCE_TIME:
+ * @IIO_CHAN_INFO_CALIBEMISSIVITY:
+ * @IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+ * @IIO_CHAN_INFO_THERMOCOUPLE_TYPE:
+ * @IIO_CHAN_INFO_CALIBAMBIENT:
+ * @IIO_CHAN_INFO_ZEROPOINT:
+ */
 enum iio_chan_info_enum {
 	IIO_CHAN_INFO_RAW =3D 0,
 	IIO_CHAN_INFO_PROCESSED,
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

--oOLU5NQLSJiUk3FX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmP6E0wACgkQeFA3/03a
ocUJTAf8D5EUP+9N4lVGM/lhiobc16GBGVkGu/29DObB6Y4ZaQU6EySbbOqhHpts
r9jVOVZGqNYM/tePzQU86Q+bpfieBDPbOLFNn8Pjq1EpHlSE/51HI23QMAMq5ezB
RdFxyE+SlKzxz2ScEoaLR/LUwzIEIylPZ7hzMEqzlKtWZJ+qaqrkO0jgnAR5FtaP
QlG3NpwV7mrLvt+aVIpusbtbWgvtH6WUYp3e8vK+Xevs8NeQokco0j7i3nwvOxKE
HG73YwG6JE5WM87KpEkOf29Ogx+zOeAEcfF+JvAyCLCd+OPQDyPwIC92C9AB65OH
ZxiZZkPoEZsmeq3Fa5/9CD2r7YI15A==
=J1Fh
-----END PGP SIGNATURE-----

--oOLU5NQLSJiUk3FX--
