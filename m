Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D466C5F69B2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 16:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbiJFOgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 10:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiJFOg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 10:36:29 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3EA8321A;
        Thu,  6 Oct 2022 07:36:28 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id f37so2989207lfv.8;
        Thu, 06 Oct 2022 07:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=0LJXSAjlHYI55JFfwv9jIlyOz6bdbyg6pzb/vBLLAuQ=;
        b=it6nQNjj6nwzVKrb6vdVfbDEgN/Sh75cV7D4H+Md/7z1ErKQ2ctHRwpgeoLRXo3zHI
         x5yZT7jiLhjRXRFZQMn7jxXDL6pZstwIwqNTBDv1zsfAAiR0EkS3q75+bqXflso77YAg
         k+dj06ZohaOn8qxz+0IDc4khCVLZlfyOFyVu9GPLtBodv94RlzrmLnw7W4vs7noF384I
         nk7yIL1QOU+aJoCwzTX0aINY9xVPbBFPXMJJzRm4DCgITqcwEyinLGO9bzJWyg5GwJlC
         sVYBHZvluhOMnMtJcXo5qvSTmQdZGtu2gG5Xnnvaktt5xJfof3/MoO4QdbFUH17NL3Xk
         4iRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=0LJXSAjlHYI55JFfwv9jIlyOz6bdbyg6pzb/vBLLAuQ=;
        b=IW61gWjKZoQzdNeDpSUodu1jg5VKRHhJEn1G476u6+4frVywLbvzfJsDVnKylh0Yda
         HpNkgNajO7dqGbGegqe3uE4J5mzj/W+ND7ODAsyeMluRcFCM0SBCl2pp5n4fCMYqx0bq
         hykIOp4AUM1hEP5WlUUiG8Ixn2O3bFewj4r4U2qlPu7dkp5OHX6Hm5ybWUrBA20w3VC2
         2jkqNp7bqPOk2BN7TI+lL5tlmLLGpH9Sly78GGOwk6sifCFdJVxdFz9mUQA19URxw9ZH
         sMaGFgZoL/H7ts+vlt0PxFQezEmiT0UCjlbSdSbQchV0LxttlaHkJoYAkqjgKuy/MWRh
         MJpQ==
X-Gm-Message-State: ACrzQf37XrkSzIjgWzU4ZXPcDud/zTbT9bd78IZW9lfJ6esSMISXkLFB
        9QzOEgfyyRQ+SRoKwb5LHU4=
X-Google-Smtp-Source: AMsMyM5hZz4rcnE9KS/Vf4honsSr9PBWYwEHs7zy/SU9UJUqDfBq8mcApoutvCkeYne/j/2eX0pASA==
X-Received: by 2002:a05:6512:110f:b0:4a2:697f:c39a with SMTP id l15-20020a056512110f00b004a2697fc39amr80467lfg.685.1665066986544;
        Thu, 06 Oct 2022 07:36:26 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id a18-20020a05651c031200b0026c5579c64csm1918271ljp.89.2022.10.06.07.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 07:36:25 -0700 (PDT)
Date:   Thu, 6 Oct 2022 17:35:51 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 0/5] iio: Support ROHM/Kionix kx022a
Message-ID: <cover.1665066397.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eZgmlIT6Mrxax5mW"
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


--eZgmlIT6Mrxax5mW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add initial support for ROHM/Kionix kx022a accelerometer

This series is not ready for being merged as such. The first two patches
in the series (the new regulator devm interfaces) are already merged to
Mark's tree but have not yet found their way to the mainline. This is
the reason I marked series as RFC. You can also skip the reviewing of
first two patches as they are there just to make the series compile on
top of the v6.0-rc7. I will re-spin the series without the patches 0001
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

Changelog v2: (More detailed log in individual patches)
	- dt-bindings: fixed as suggested by Krzysztof
	- dt-bindings: support both INT1 and INT2
	- KX022A: multiple fixes as suggested by Jonathan
	- fixed SPI driver after some testing

---

Matti Vaittinen (5):
  regulator: Add devm helpers for get and enable
  regulator: Add devm helpers for get and enable
  dt-bindings: iio: Add KX022A accelerometer
  iio: accel: Support Kionix/ROHM KX022A accelerometer
  MAINTAINERS: Add KX022A maintainer entry

 .../bindings/iio/accel/kionix,kx022a.yaml     |   67 +
 MAINTAINERS                                   |    5 +
 drivers/iio/accel/Kconfig                     |   21 +
 drivers/iio/accel/Makefile                    |    3 +
 drivers/iio/accel/kionix-kx022a-i2c.c         |   53 +
 drivers/iio/accel/kionix-kx022a-spi.c         |   59 +
 drivers/iio/accel/kionix-kx022a.c             | 1138 +++++++++++++++++
 drivers/iio/accel/kionix-kx022a.h             |   81 ++
 drivers/regulator/devres.c                    |  164 +++
 include/linux/regulator/consumer.h            |   27 +
 10 files changed, 1618 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/kionix,kx02=
2a.yaml
 create mode 100644 drivers/iio/accel/kionix-kx022a-i2c.c
 create mode 100644 drivers/iio/accel/kionix-kx022a-spi.c
 create mode 100644 drivers/iio/accel/kionix-kx022a.c
 create mode 100644 drivers/iio/accel/kionix-kx022a.h


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

--eZgmlIT6Mrxax5mW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmM+58cACgkQeFA3/03a
ocW74wf/UScbIFFV++c7ox1gTL7wfFXO0Po5iiYPNMlkYBcP1vKzqg8XdKuC5Io5
nhrJkmQ3CDDZdJsS8aoyPQ1j9F7Cu5dRBllg0zWRCYqflfmHRL5O0yg07Twx/G70
cHzPvR09qmPyNAidNqOeP+gbjr8A5XKlOWqYGSK2wXe2nu8B0H/4VOiIsP1c9zKE
RpBKpJxpurhQDvc+SvuZr+tqpvpUwSvhuB8SX6U3mIz/N68PUBr7T2ASq6gfWZoT
x/4xxbjjKm4ciWvG8gULCN8J377MjmPm6b3MGRl2RzG2VIdLsqIdXRnc9UZiSsul
KoYxjVESAJluqdooB2nZVqHwl0M+Eg==
=f9p5
-----END PGP SIGNATURE-----

--eZgmlIT6Mrxax5mW--
