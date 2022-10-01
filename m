Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3893A5F1AA5
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 09:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiJAHno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 03:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJAHnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 03:43:41 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4531515515F;
        Sat,  1 Oct 2022 00:43:39 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id z4so10006660lft.2;
        Sat, 01 Oct 2022 00:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=b0K8YxHzOLYyHo4VvKo91+kAJ3r6DDnk5+tjHXHmZ/8=;
        b=NVhTLj2CYnWllRTa3+jXekeih3wEZs7pTk+FVo4Chn9pNtfsLiUwlS/qpr+ZclpvGb
         NNpaPXGQNeK5eIpWnL+j/SGwDbmtzRGOwYIBfA0RAXZn7Kydz3H/AH0bS5PKgRajjCJf
         mKvtqzuQIQ1y1aWApYz9TDMUOLY3HcWz1a2FJgaQBTj/ZPqpA85WKsSi40ph0WBJ3+EY
         fpx1b76cZvoJLIH1hMcj3FK32k/wt5OcwQkAYoKePZEsRdNxUPyE/Cu3xrx6K3Z1rTYq
         Oiw2jcIhsAZ+CYPXTHew2JFZ6Edj7V9ipof7D8XnCWJqXtY5UmzjsvrwWTA1x4S0/k52
         nZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=b0K8YxHzOLYyHo4VvKo91+kAJ3r6DDnk5+tjHXHmZ/8=;
        b=UoGVANUE8JkyatFo8lhrWK4Q7E6fKTWaw0TUBXsAzk9wUM8JLAohDNyNO1h65yw/jf
         8UOe9CTr3Grc1VYDLiBOXkk5BhkzApD9r0Bh8YQoTwVT1JBU72JwibucLi5PL4Ivcofa
         TmU9MlefOT2wbwcI25xkqWTMSP1zamMp/T9gAfajAIkj3n6rbRDomcfLf/F3djIrLxvh
         Xz0XqU7Qbr136+Y3aSqAVLzzrsM6FO0G8LZzcHGCiQ+OIvzp4anB6n+eIrNKuf8CfC4l
         /3XPxWlzy2ciWtbLiusB/gwgwABftCiqI9bIdrW0b1vakkXJXJ4F06XMIkYOcRwWnpzU
         CUyw==
X-Gm-Message-State: ACrzQf0cebY9hkrrxn3mBumkg4PSrtyR4C8bso9E/K7TE69NzudeBUfM
        Q2JmmBrvaLqWZwSsmyX0OQo=
X-Google-Smtp-Source: AMsMyM7LLnwhLHuoSKBKosxxQsVKk214LgqJsDBFfNo+oUVQfsZJjUzDwnN/iDcW8jfQiEbWnOC7Dg==
X-Received: by 2002:a05:6512:2392:b0:4a0:3180:5c40 with SMTP id c18-20020a056512239200b004a031805c40mr4228494lfv.681.1664610217445;
        Sat, 01 Oct 2022 00:43:37 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id f1-20020a05651232c100b00497ad9ae486sm668561lfg.62.2022.10.01.00.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 00:43:36 -0700 (PDT)
Date:   Sat, 1 Oct 2022 10:43:18 +0300
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
Subject: [RFT PATCH v2 0/2] iio: Fix unsafe buffer attributes
Message-ID: <cover.1664610071.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="p/1ifXIpa00LMeD9"
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


--p/1ifXIpa00LMeD9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

IIO The iio_triggered_buffer_setup_ext() has been changed to expect that
all attributes given in buffer_attrs array are device-attributes. This
expectation has not been forced by the API and not all existing users
were checked. Some drivers do register attributes created by
IIO_CONST_ATTR().

The added attribute "wrapping" does not copy the pointer to stored
string constant and when the sysfs file is read the kernel will access
to invalid address.

This series aims to address both the drivers using IIO_CONST_ATTR() and
the API. Use of IIO_CONST_ATTR() has been dropped from drivers for the
triggered buffers and the iio_triggered_buffer_setup_ext() is changed to
take an array of pointers to struct iio_dev_attr instead of an array of
pointers to struct attribute. This should fix the existing users and
also prevent similar problem to occur in the future.

I am not super happy about the new macro IIO_STATIC_CONST_DEVICE_ATTR()
which unconditionally creates a static function and a static struct
iio_dev_attr. OTOH, I do believe static function + static struct
iio_dev_attr should be the right thing to do for majority of use cases.

I did also change the struct iio_buffer to have array of pointers to
iio_dev_attr in order to avoid yet another copying in side the
iio_triggered_buffer_setup_ext(). This change appeared to be somewhat
intrusive - and as I lack the hardware to do thorough testing I added
the request for testing tag here. Especially testing of adi-axi-adc
would be highly appreciated as it is using the
industrialio-buffer-dmaengine.

Changelog v2:
  - fix also the cros_ec_sensors_core.c
  - fix also the industrialio-buffer-dmaengine.c
  - add RFT + this cover-letter.

--

Matti Vaittinen (2):
  iio: Add IIO_STATIC_CONST_DEVICE_ATTR
  iio: Fix unsafe buffer attributes

 drivers/iio/accel/adxl367.c                    | 16 ++++++++--------
 drivers/iio/accel/adxl372.c                    | 16 ++++++++--------
 drivers/iio/accel/bmc150-accel-core.c          | 18 +++++++++---------
 drivers/iio/adc/at91-sama5d2_adc.c             | 16 ++++++++--------
 .../iio/buffer/industrialio-buffer-dmaengine.c |  4 ++--
 .../iio/buffer/industrialio-triggered-buffer.c |  4 ++--
 drivers/iio/buffer/kfifo_buf.c                 |  2 +-
 .../cros_ec_sensors/cros_ec_sensors_core.c     |  6 +++---
 .../common/hid-sensors/hid-sensor-trigger.c    |  8 ++++----
 drivers/iio/industrialio-buffer.c              | 11 +++++++----
 include/linux/iio/buffer_impl.h                |  2 +-
 include/linux/iio/kfifo_buf.h                  |  3 ++-
 include/linux/iio/sysfs.h                      | 11 +++++++++++
 include/linux/iio/triggered_buffer.h           |  6 +++---
 14 files changed, 69 insertions(+), 54 deletions(-)


base-commit: f76349cf41451c5c42a99f18a9163377e4b364ff
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

--p/1ifXIpa00LMeD9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmM374kACgkQeFA3/03a
ocVTHQgAzUVSblClKdgM1OzHi45hngdIJh1Zg2mq6PgBWQn/XWc+6s5e3OYK3yS0
XliPnOk0vcf/vuyTiUdN/vhfJpnVab3jLRkPFSGfg9KwOGz8PPWvi8OafRSIRhgA
prid6wavAeZV9Zpg4F6jvYWW56fkK/2vF5wyQI1bfYf13XJD7qJG73WKv/Xj/L4p
D+LleNNcd0ntDjigScC61IoZMvQ7g/jTYsXd7LR0MudKc4eUM9ia6coznNDXumuh
CuJGjVewJbb2Wu6Aybv+gW8WPrZG0c/ctaX5F5e0mISlZ1FnRiKBlYv/dVEONdOT
xD6KakdrOYTf2Vors49vmIhO/+RIow==
=qM0L
-----END PGP SIGNATURE-----

--p/1ifXIpa00LMeD9--
