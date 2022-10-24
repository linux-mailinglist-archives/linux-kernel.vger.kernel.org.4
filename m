Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34ED260B444
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 19:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbiJXRdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 13:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232904AbiJXRdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 13:33:23 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DE21217C8;
        Mon, 24 Oct 2022 09:08:23 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id o12so17499950lfq.9;
        Mon, 24 Oct 2022 09:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SZ31JYmFe9OeMvl31YJl/+jDyOyYGwS2gqipXqgE/JY=;
        b=a8QiwcnfvpSSkOBFc+YL0WGUUJN3LaaE6tQs7Oqyh+fF6YhbQMxwlFRT9RvL1gCa2H
         NdYb4KIcxIBLt2K2+UvwckUXzBPFPRWh/HSEoHREhbkKnvcHLNB8QOjpq0/GSvXTjjKA
         7dPaacxyXYZPrQvZwWHeXKkK8LkXLBc/19HYlXLsyGNdf3Yx0HNNhNgRs4ygOR4As5pn
         IjuI7tC03qpKDrgSPdoEEr8Gvp8v7uMs7r3eWMKn/UT3L3LxOzFdLYKXxE/7sdpUY1Ql
         fqTPl+LUd6UCI1athJTnYUqePNd4GB1xq3I4hH4er3Y50Ia6S39UAx3d0DftGTIg00aB
         eHrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SZ31JYmFe9OeMvl31YJl/+jDyOyYGwS2gqipXqgE/JY=;
        b=p+ni1VQMI1bKDF4mCV0wYIzt6kMa6ZV0olK80k2o0nCqxnklKygTwcllpJj6skyrZ3
         zQXxv62pSlu0tvyu+1VrjE3lVW84NV/BEHzWlj7zjYVSvWuIii9QW0BJjvEXLVvG5oGN
         C5YBzI5THjYTc/GHl+ubgHCOpe8y3NzTZgj92jPGPN7n0jpeHBAGpoEss2+eMBQuak6c
         YSsVh87oMItWrrJQoOCkCwL7/eIXMPdv5yUI+HSfv+HJJDrsP6rOpqERDLaAKHRBvX2E
         5ReHHSsus17UCkbDR64OeFhoQaNSubGjXa/9BfaFHg3YdcWwKX6gJKZZ1FX12h5IqNiD
         X3IQ==
X-Gm-Message-State: ACrzQf10ySI+fxG9fZbembWETjt2HA+6xUyV9uFChFpj6Csho+jcWRg7
        Y0XSV64g6Hga+aZ//c0jIKqLszPusAs=
X-Google-Smtp-Source: AMsMyM6jrtptf470/Tn9hAMyX1rEqScRqGCQPpLB+WzCKvrgv6JBMzws3gKuWiMtFg96No723ThLKA==
X-Received: by 2002:a2e:7a17:0:b0:277:139b:27db with SMTP id v23-20020a2e7a17000000b00277139b27dbmr112812ljc.222.1666615101139;
        Mon, 24 Oct 2022 05:38:21 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyby-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::2])
        by smtp.gmail.com with ESMTPSA id f23-20020a19ae17000000b00497b198987bsm387887lfc.26.2022.10.24.05.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 05:38:20 -0700 (PDT)
Date:   Mon, 24 Oct 2022 15:37:57 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/3] iio: Support ROHM/Kionix kx022a
Message-ID: <cover.1666614295.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jUY4LDj/bI9JgXEy"
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


--jUY4LDj/bI9JgXEy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add initial support for ROHM/Kionix kx022a accelerometer

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

Changelog v5:
	- KX022A: styling/print fixes.
	- KX022A: fix race for requesting IRQ/populating user-space
	  entries.
	- KX022A: fix few variable types
	- KX022A: drop unnecessary udelay()
	- MAINTAINERS: Change myself to be a maintainer.

Changelog v4: (More detailed log in individual patches)
	- KX022A: mostly styling/print fixes.
	- KX022A: fix return value from IRQ thread handler.

Changelog v3: (More detailed log in individual patches)
	- dt-bindings: fixed as suggested by Krzysztof
	- KX022A: multiple fixes as suggested by Andy
		- Fair to mention that couple of suggested changes are
		  not done (Some styling, boilerplate text in KConfig)
		  as there has been no consensus whether the suggested
		  changes improve situation. Ultimately the decision
		  whether these changes are mandatory lay on the
		  shoulders of the maintainers... Sorry for that.
	- Enable the FIFO without module param now that the "FIFO stuck"
	  issue can be prevented.
	- Fix potential race with time-stamp calculation when user-space
	  invokes the fifo flush.
	- Drop the already merged regulator patches.

Changelog v2: (More detailed log in individual patches)
	- dt-bindings: fixed as suggested by Krzysztof
	- dt-bindings: support both INT1 and INT2
	- KX022A: multiple fixes as suggested by Jonathan
	- fixed SPI driver after some testing

---

Matti Vaittinen (3):
  dt-bindings: iio: Add KX022A accelerometer
  iio: accel: Support Kionix/ROHM KX022A accelerometer
  MAINTAINERS: Add KX022A maintainer entry

 .../bindings/iio/accel/kionix,kx022a.yaml     |   65 +
 MAINTAINERS                                   |    5 +
 drivers/iio/accel/Kconfig                     |   21 +
 drivers/iio/accel/Makefile                    |    3 +
 drivers/iio/accel/kionix-kx022a-i2c.c         |   51 +
 drivers/iio/accel/kionix-kx022a-spi.c         |   58 +
 drivers/iio/accel/kionix-kx022a.c             | 1142 +++++++++++++++++
 drivers/iio/accel/kionix-kx022a.h             |   82 ++
 8 files changed, 1427 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/kionix,kx02=
2a.yaml
 create mode 100644 drivers/iio/accel/kionix-kx022a-i2c.c
 create mode 100644 drivers/iio/accel/kionix-kx022a-spi.c
 create mode 100644 drivers/iio/accel/kionix-kx022a.c
 create mode 100644 drivers/iio/accel/kionix-kx022a.h


base-commit: 9abf2313adc1ca1b6180c508c25f22f9395cc780
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

--jUY4LDj/bI9JgXEy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmNWhx8ACgkQeFA3/03a
ocWtfQf5AV1LhBWY8aZonAtnM8Y6OngeEhTglKXFzkZ4Zz22156KTohauQAi/NqT
0JYVIaT/gCvIpr0vmBn52Ku5PhYfOFJe6xBuU8Z/AyleruQrGPRXubYEEqybj7Y3
sr3IOiSLEM/LyT4tkeAK9idOG1qVzKC71AYSxDDrT3Iy4hDQ0Wv3iV6pAO2mOE9I
0mRXyhi3jJkthWLk/Gxyn0IKDcDxFsK5HSE8Wwgtfyg65sGwjDxnofg69GxoMrRS
iX/U8PcBC2cMLIwShKH4Y/GDNojZhw7j3llbA8SHtvEcqu+sQnOl02ZaMVReDAux
hM5D5W0DakOIGtTl0ZRsjq4D9MM9AQ==
=XRNC
-----END PGP SIGNATURE-----

--jUY4LDj/bI9JgXEy--
