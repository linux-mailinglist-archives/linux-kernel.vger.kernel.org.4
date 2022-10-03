Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF37B5F2BF4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 10:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbiJCIhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 04:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiJCIgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 04:36:51 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B77AEE13;
        Mon,  3 Oct 2022 01:10:06 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id j16so15467357lfg.1;
        Mon, 03 Oct 2022 01:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=c0YyeUojy1jbeCZ2/7r3YgN/g1XESLH2vjvNlGUsJKw=;
        b=LdFHIt0zUAjh3H7rheITvmy7LWOUL0dCkwyGSmp/8iPWlwthEVrWAiaPryTwyiqzuw
         a3lokmpUSA4dhqav4vFyeLd/g7nqpBVD4O1yM+nrWq5r7cF5yr134JmBIFBEBsz30xWe
         vj55VTL/xGLLmEYBwqjnkMHCmA13LdF2kRkoPB9NqlSF7vspZu/bA4TOo/XyZx7VJTWB
         q4j4Xcxq0kOXVik+kViRKpX1OHJbpla01W0CBmlL40xAxTFY6Bei5Ju8G22WAv8GUubA
         tW5lmtBuSphFTse3r72m7QQ01RiizP9x1IzEPWE4V/fmFyW2XKybYNhTqdk+SgCx3ZfR
         G12w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=c0YyeUojy1jbeCZ2/7r3YgN/g1XESLH2vjvNlGUsJKw=;
        b=S6Hm+Inuxrxc6vfJjzcTKuiFRg7y7zGzUKmrQg9IOzn/RqPdn3ze3ZE8EnGHGLMYBJ
         tt0UxeK68d+jiWXmCaU4dQAZ9zG1XDv5hsyjqH6Y19z1DY7HzF5GQJ/IG/FdtKQk/nam
         8uU1D+/18YutXGujEEpC5ImkdnDmxM/4qfP0E9QkBv92h2V6hcurhidE7HxMPK6gEU9L
         7nKbn/7dRLpBKDdu5QOEDCaSSFdEyl9JnoCMTXWHqo/87FD8z3eU5i3LmmvPYAq3PEm8
         G76vusMXkapb+midlMBbk+Ib5QxXs1ZQUuRyoVQm30b5EiybXOzUPP2Vx5EPLCmE/aQJ
         7WaA==
X-Gm-Message-State: ACrzQf08L1FJk4dfG7yNrsAoPh39jDnYJa4Lg4F8TRAaK9q1tDroksCA
        g2I5dg1Jyh3an3imGrkRJPs=
X-Google-Smtp-Source: AMsMyM4w/Ky5VFLFmELVHCsaLO1XIDKk2TKBlWRSHy002zjVdSF8UTaBCYQvdkrze6qxyd9FfuRQfA==
X-Received: by 2002:a05:6512:66:b0:4a2:3c36:8c3d with SMTP id i6-20020a056512006600b004a23c368c3dmr1399015lfo.687.1664784605012;
        Mon, 03 Oct 2022 01:10:05 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id f5-20020a056512228500b0049c86ca95bfsm1358912lfu.52.2022.10.03.01.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 01:10:04 -0700 (PDT)
Date:   Mon, 3 Oct 2022 11:09:51 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Miaoqian Lin <linmq006@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Mihail Chindris <mihail.chindris@analog.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        chrome-platform@lists.linux.dev
Subject: [PATCH v3 00/10] iio: Fix unsafe buffer attributes
Message-ID: <cover.1664782676.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="t/4fi5Jmm2ZTy01t"
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


--t/4fi5Jmm2ZTy01t
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

First 4 patches in the series aim to address both the drivers using
IIO_CONST_ATTR(). These patches should be backportable. Please note that
these patches have not been tested in the HW so testing/reviewing is
highly appreciated.

Following 4 (patches 5 ... 9) contain a minor simplification adding a
macro for omitting open-coding of dummy attribute show functions.

I am not super happy about the new macro IIO_STATIC_CONST_DEVICE_ATTR()
which unconditionally creates a static function and a static struct
iio_dev_attr. OTOH, I do believe static function + static struct
iio_dev_attr should be the right thing to do for majority of use cases.

The last patch in the series (patch 10) aims to change the function
signatures so that similar issues would be avoided in the future.

Here we also change the struct iio_buffer to have array of pointers to
iio_dev_attr in order to avoid yet another copying in side the
iio_triggered_buffer_setup_ext(). This change appeared to be somewhat
intrusive - and as I lack the hardware to do thorough testing I added
the request for testing tag here. Especially testing of adi-axi-adc
would be highly appreciated as it is using the
industrialio-buffer-dmaengine.

Changelog v3:
  - Split the series to allow easier backport and review. This also
    allows merging the smaller fixes with less of a risk for crashing
    and burning everything :)

Changelog v2:
  - fix also the cros_ec_sensors_core.c
  - fix also the industrialio-buffer-dmaengine.c
  - add RFT + this cover-letter.

--


Matti Vaittinen (10):
  iio: adxl367: Fix unsafe buffer attributes
  iio: adxl372: Fix unsafe buffer attributes
  iio: bmc150-accel-core: Fix unsafe buffer attributes
  iio: at91-sama5d2_adc: Fix unsafe buffer attributes
  iio: Add IIO_STATIC_CONST_DEVICE_ATTR
  iio: adxl367: Use IIO_STATIC_CONST_DEVICE_ATTR()
  iio: adxl372: Use IIO_STATIC_CONST_DEVICE_ATTR()
  iio: bmc150-accel-core: Use IIO_STATIC_CONST_DEVICE_ATTR()
  iio: at91-sama5d2_adc: Use IIO_STATIC_CONST_DEVICE_ATTR()
  iio: Don't silently expect attribute types

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

--t/4fi5Jmm2ZTy01t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmM6mMIACgkQeFA3/03a
ocWpdAgAyy6b0J6xt2mjtw7DX1VuVjI6cvnBict6lYVhU9CAqbWuSqEhgKMHwS3d
u3Jt/eKGOozOBJMqhVkvV1cq4RtDqWyRzp2iuOFXw8Ud2oJCViiSuNTCdplodQvq
K8XrCSM0xdkSGaeA3HXmjZ/JpSYglA+jXABexWmwc/PdFmhH7V+y6DXQaC/bAoFa
tRcaS99EOnS0OpDkMqp/WjwR6Te2GimUfb0wDz29oWQZd3KENrtBxCyuxFu5TOJB
MzsR4J9b+IyJ7VTnfU0mLWjTYKx5bhl1SvONulJQnJfVHPVVPWuVwx9/yNlQ8KKS
VhLUslqRJwAxvqz47n9s2NRQMGB/IQ==
=ypCI
-----END PGP SIGNATURE-----

--t/4fi5Jmm2ZTy01t--
