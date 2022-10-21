Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD20F607602
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 13:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiJULVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 07:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiJULVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 07:21:31 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756102630B1;
        Fri, 21 Oct 2022 04:21:29 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id j4so4657325lfk.0;
        Fri, 21 Oct 2022 04:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=um8uKpr6IMLYPZN84RDHzz0+lzO39s//WE53p3bIvdI=;
        b=FF3xfEbj33nS1LmKp+sObedASgnVs/dtncTlQbMRTYrCoik48VCyqJoKYqOUlf9H3M
         1hPl3WHcMNtrznzy33c0R+THNqCuYClkPAdOTVNr7aCatn5aATN3uiIj6ByM5vQ7e7Cz
         4P/ecjWBzgNOM45hgbSDjPC49f4gEknVj6qhIBBC784JPxf6rUqKGS02SSdzUccYHgDo
         BuPYTWDGkIyc3bEIDDtHYprCR8u+va91mEV1Zr4zzUKNGNRK89wxi5Ryt+mCPvRJr7XL
         Jw+py3+8LRk1JIEezGBTve6WfH/pBt2GfFC/fvX4n1zJJAb4n4onxAmcggwPoGjOaCNl
         fyyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=um8uKpr6IMLYPZN84RDHzz0+lzO39s//WE53p3bIvdI=;
        b=cOq/RRyqMHin+s8aImF7aMyvJlZzGXBHp+UV3grAdxDvIXKiXc0bcx+KepBHmHELZa
         zcksvu3OxtxuBex3Adi5WJS1SHPpLMe7JeoZOQ4UDBbKtEymxMqtji95cvtC6qrQJrQ8
         Pc+CmMMyoqiq9iQjOAC77DZKIYlaCpFt045UdmUw9tHSpXcY/p2GkcRTzU16VzH2r348
         n460sWUSXM295PWRkovH1979JPDNbrhXGmQnHUeGAq34hKvxiL4yM4ckMoPTVO2619BH
         nD+T8CUGkmXQZ0qD6jcsrjPuk606Zq/rjd5tFUPRujI6SArooSIiUdqc3D1ua49KK3xz
         nMeQ==
X-Gm-Message-State: ACrzQf0r4nXAKWXiXMpt4nmjZeSwzJjixaMxHrAHxligJFETe/F56tJf
        RSpGrzs3E3UPcIQDhW+JpZE=
X-Google-Smtp-Source: AMsMyM6IUT5u5RwT/QXL9jAwwuXs9j9sSS2GwNx7vRxhO/Rys0XBI9stWkiRmB7h0HQsc0oSxcUgKQ==
X-Received: by 2002:a05:6512:66:b0:4a2:3c36:8c3d with SMTP id i6-20020a056512006600b004a23c368c3dmr5958346lfo.687.1666351287194;
        Fri, 21 Oct 2022 04:21:27 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyby-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::2])
        by smtp.gmail.com with ESMTPSA id y1-20020a2e95c1000000b0026dd24dc4ecsm3360262ljh.82.2022.10.21.04.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 04:21:26 -0700 (PDT)
Date:   Fri, 21 Oct 2022 14:21:13 +0300
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
Subject: [PATCH v4 0/3] iio: Support ROHM/Kionix kx022a
Message-ID: <cover.1666350457.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cDR5lV6bIY1LLPNT"
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


--cDR5lV6bIY1LLPNT
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
 drivers/iio/accel/kionix-kx022a.c             | 1145 +++++++++++++++++
 drivers/iio/accel/kionix-kx022a.h             |   82 ++
 8 files changed, 1430 insertions(+)
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

--cDR5lV6bIY1LLPNT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmNSgKEACgkQeFA3/03a
ocWPsAf8DXinC03KfZ56jd1tp0TqDZK4zaACrK8GdOnGGB90HOZ0UETHWNLTNgca
rX1ZkHH5X+uZq1SiN07qbbUgwYVJwG/bWvfI3Mw2T6UnzQ/TTtBLDi4OLtCdA5bc
iRqVzNZwyb3BUT6i9Bv2KZ7byL1Ul2gFDMWqB+ug36jtOdow9h7nS2kLbjrwA4T/
q+4v1Uall/LtwVdyimMzjJfu3LWBbIPR3qFa/88YIFnt6jaFx4MfmEiwSSNnGS1v
JpfewWxsywFQvLG9ZSwscfl5xKzVrcxT3CqIeFr5rNUmKNEeyYhLJwTYT5fEKmRj
+DuR9Dw3K0XBhzX09f1j7S86wQioJg==
=KHaD
-----END PGP SIGNATURE-----

--cDR5lV6bIY1LLPNT--
