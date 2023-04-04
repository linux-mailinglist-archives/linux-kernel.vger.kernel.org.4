Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2AA6D6042
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 14:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234708AbjDDMZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 08:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234795AbjDDMZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 08:25:26 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2ABE75;
        Tue,  4 Apr 2023 05:25:22 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id y20so42220863lfj.2;
        Tue, 04 Apr 2023 05:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680611121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZDU+F1pTEz7orAogZEYM3SSlzH/hcRZ96/r/Tq0s37o=;
        b=aEOeBsszZH5JlFbVpcoaCviRe6tzX+l5bNSKVkKnFp1dTe2+iLJ2yPKc/QY9kBo1j1
         XBXnTdZp4dqzgFFN2ZxdfXHBc+4wK0OVkK9WH99+uoq6tfmkbqefMKKk9pIOg7K4CuEF
         7BlZiIvcAPPKSjdDTVrETXxDL/DQeHCwsQjkp1JsHVXPO4xxQpMEhAxGvQqU7XB+l4Iu
         F0j5kCVqEKzg5mIMmmiKYonSDZnylfeB+kpTeku/euwmYSPnZ6lQBfiz/uFvpoEm45vu
         THVbnjNtphm7hmvUJbYvXc0xJitzEpRy3X3cnrBHnnmkj5ivZrlflEsKGM2j0pNkIlFy
         V64g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680611121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZDU+F1pTEz7orAogZEYM3SSlzH/hcRZ96/r/Tq0s37o=;
        b=BnKJLrnjt0J0Cw2g4bEAHVSOrSl6aGuYVLupxG8Sle5eKAPiwNj5fgQO+e70umW6ZQ
         SzuK5iR8ZQlDtwr5hseKsgxI5vBHmbswFtHyZKqNqxqp0dKngtFGmganI/n/DflTTBk8
         F9aSNU35wd2iPSs0WE6KGeG8XYfnGULKzZVh6sMNP+M7qkihXIPU9eitUVUHVZ62zQaA
         bgFqfsd0tQinATmWiDogDnBHezNH/mUj+oU8C+XboiRpJki0SXhAvpGGGbIuF3kQ08z3
         8xBXxzbPap7qUC7normlwZqHuvIKGkOji/EmjyIo4GOFnIvungNwuCHXxeiC/NSIsOkd
         crkA==
X-Gm-Message-State: AAQBX9dxDNukAADdMEhKMBAx6sCzLXlSaoPLR95FiWblfpzbDHhqSZr9
        NB9rSw3v2vf2h3GXHr19udU=
X-Google-Smtp-Source: AKy350bai4lN1Sv512f7kHwLIM9QmUZCR1nqpnxjVoPGbJfzS0xnYeUWH9y/Oidfg7c/LQMI1mebLQ==
X-Received: by 2002:a05:6512:410:b0:4e1:36a:eda5 with SMTP id u16-20020a056512041000b004e1036aeda5mr481748lfk.30.1680611121261;
        Tue, 04 Apr 2023 05:25:21 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id h27-20020ac2597b000000b004eae73a0530sm2295410lfp.39.2023.04.04.05.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 05:25:20 -0700 (PDT)
Date:   Tue, 4 Apr 2023 15:25:17 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v2 2/3] iio: add documentation for iio_chan_info_enum
Message-ID: <799dfdbe77ed562c400d76a0728153263e769198.1680610554.git.mazziesaccount@gmail.com>
References: <cover.1680610554.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lBi0XkC13I/LZcNg"
Content-Disposition: inline
In-Reply-To: <cover.1680610554.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lBi0XkC13I/LZcNg
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

--lBi0XkC13I/LZcNg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmQsFy0ACgkQeFA3/03a
ocXoywgAzsR0B43axXDOoR+qEh8v0y+HkEDO8BKW2snO4h4QNl2Rxsq+J9hLKBlJ
QRRYYYRu4AVYgAeNNpl53bVWWVH88t9ZA4DuEhYhhsRf8iakJ3GPRljQevDR6Dgu
C+CDMlf3BRMGZ5+74Tto3cj0+HOIyDJf4EULlEgWBXAxrC0y3uTN2NZ9VFjoBxyC
HOXBwP5KlW6XTgBQ7JxirbSXmg3eDPNkFG6O7ixwNC2PYOly4CiaUXcO/8bIXPZj
L4Gg1bquWuURRBLX+msQJ96/Uwj56e8FQPxYv8aARS64e6GO+YzbDj/D55j2rwta
m5cCHubP91q4letgXkcZgbiu3POPRg==
=VFSj
-----END PGP SIGNATURE-----

--lBi0XkC13I/LZcNg--
