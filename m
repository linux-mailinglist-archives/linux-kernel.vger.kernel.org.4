Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027585BFD0B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 13:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiIULlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 07:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiIULlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 07:41:09 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4073FA09;
        Wed, 21 Sep 2022 04:41:07 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id k10so8725504lfm.4;
        Wed, 21 Sep 2022 04:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=86WCHSlEMusoGKw0NZFAnIdqU5oTHd5cwFDGXpyQVyw=;
        b=gIxV95ew6909NSjTwq6elXTGLXbMVNr3z9Taos+ssn0KkKqswpNP7g8MUYDUYqU5j6
         sZ2jJRECLxjLRmLX8sQKqLtnRsZGI8oK0MLjJBTBY+LEoWe+vL0Wl8DHTW+BDFnMOnzi
         E2IPAmVMNaOaWxOm28Pz7QMNDZWfhjDHFB4C6iBR1IyEGLNIjUswAuvzGQCLqdr1yLEO
         A2QSsDtwP4jaGt8ScpFbIfhvRKudXrsHzxY+YD7vqE9cH7GozWgKaenjOexqVTOF8WJz
         R1eIbDK78ftJESX54HujxFP1oCvJweD0yeod8+CMYVrUU9tv+XgXYDsgBi9JXkFjibEU
         RD4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=86WCHSlEMusoGKw0NZFAnIdqU5oTHd5cwFDGXpyQVyw=;
        b=n+ali3xj53rUpZczdMmjkIBwMy8nONabJuApLA7ENnCsTBHeClFh7q4u6JD9OTBUa5
         afW1U24tLw9m68RPrb43B38TGPmD2dG7oUvRF7AIWO59vq8TWfy+wT030BsioWp3Ml4E
         jEJsCWevTP2fII2BiF65nNpx53AFpE5IigbskGcx8UHXGuQvUNkXBmnDz4nrT9vA9LHT
         BhxXtTgYurbASoCHM3tiEskvpiD0bxHo48/UzWPW24G+U1RLk+REcTm8Pxo3ctZ82Fdp
         h/NFEBK3avTGg59VOIJA4v/19RvDyo6jRJ+FI4rzxeGsvijLQqVS4pB+KaZzpBMOXcPl
         n4iw==
X-Gm-Message-State: ACrzQf1upz8Q8fnCdZ63d3txIbRdsgWG4MHrZ4YW/nPZEFKm39DYdsfG
        K2r5CVZ6M1FXTqt2Ws8njCE=
X-Google-Smtp-Source: AMsMyM68inOfsUqdE0ZItjudPLNhLECQepLbDNrTvxhVZl9fi2Jvdbn3J7IC0KrZnxqLR2LeH8CQmQ==
X-Received: by 2002:a19:ca57:0:b0:49f:52ce:d4b8 with SMTP id h23-20020a19ca57000000b0049f52ced4b8mr9171038lfj.491.1663760466079;
        Wed, 21 Sep 2022 04:41:06 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id t27-20020ac2549b000000b00494603953b6sm402614lfk.6.2022.09.21.04.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 04:41:05 -0700 (PDT)
Date:   Wed, 21 Sep 2022 14:40:33 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/5] iio: Support ROHM/Kionix kx022a
Message-ID: <cover.1663760018.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9hXad1v1HaqKVtDZ"
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


--9hXad1v1HaqKVtDZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add initial support for ROHM/Kionix kx022a accelerometer

This series is not ready for being merged as such. The first two patches
in the series (the new regulator devm interfaces) are already merged to
Mark's tree but have not yet found their way to the mainline. This is
the reason I marked series as RFC. You can also skip the reviewing of
first two patches as they are there just to make the series compile on
top of the v6.0-rc4. I will re-spin the series without the patches 0001
and 0002 and drop the RFC tag when the v6.1-rc1 is out.

About the HW:
KX022A accelerometer is a sensor which:
	- supports G-ranges of (+/-) 2, 4, 8, and 16G
	- can be connected to I2C or SPI
	- has internal HW FIFO buffer
	- supports various ODRs (output data rates)
	- support detecting special events like double tap or motion
	- can be configured to wake-up system when events are detected.

About the series:

This series adds support for only getting the accelerometer data and
configuring the G-range / ODR via IIO. Motion detection or double-tap
detection are not supported by the series. The other quite important but
still missing piece is the runtime PM. Nevertheless, the driver should be
usable and brings the basic support for getting accelerometer data.

---

Matti Vaittinen (5):
  regulator: Add devm helpers for get and enable
  regulator: Add devm helpers for get and enable
  dt-bindings: iio: Add KX022A accelerometer
  iio: accel: Support Kionix/ROHM KX022A accelerometer
  MAINTAINERS: Add KX022A maintainer entry

 .../bindings/iio/accel/kionix,kx022a.yaml     |   58 +
 MAINTAINERS                                   |    5 +
 drivers/iio/accel/Kconfig                     |   23 +
 drivers/iio/accel/Makefile                    |    3 +
 drivers/iio/accel/kionix-kx022a-i2c.c         |   52 +
 drivers/iio/accel/kionix-kx022a-spi.c         |   50 +
 drivers/iio/accel/kionix-kx022a.c             | 1149 +++++++++++++++++
 drivers/iio/accel/kionix-kx022a.h             |   76 ++
 drivers/regulator/devres.c                    |  164 +++
 include/linux/regulator/consumer.h            |   27 +
 10 files changed, 1607 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/kionix,kx02=
2a.yaml
 create mode 100644 drivers/iio/accel/kionix-kx022a-i2c.c
 create mode 100644 drivers/iio/accel/kionix-kx022a-spi.c
 create mode 100644 drivers/iio/accel/kionix-kx022a.c
 create mode 100644 drivers/iio/accel/kionix-kx022a.h

--=20
2.37.1


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

--9hXad1v1HaqKVtDZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmMq+A4ACgkQeFA3/03a
ocVaCAgAhJI49AH0X8URK5kL0bqsz/aV47yH/+4E1sHpPojIK5Qz97XKjTadAvoj
HUQevMG6/iyS3N5m36I0pDDTBiH9f1I8koBkX9hdB1LBeh9ST6aDuhUsqOpFa3yO
p0gsgJ67Gjo7JGnl662dJkqKkKcr/se2fljbXgLSdcfYmPdOFM/YSqMrdp5sAgoZ
kG/9DN40wcvn+Tv/ri5b7XYCui7IqH4hX8H8GGeWnHEUUDrAlb9ugJLltD0Vf5Kf
Vm5R8TlMtcXkQli1dEaNaEKkgIEhp8oL3I1+SJFCV+KQ0U+4g42C8be6l6VUXLXd
dTv3C8aUWJg8x8Ge0Fv8H8oVE/AwPA==
=Mpuz
-----END PGP SIGNATURE-----

--9hXad1v1HaqKVtDZ--
