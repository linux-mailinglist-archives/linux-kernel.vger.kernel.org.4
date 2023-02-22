Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88FF769F8BC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 17:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbjBVQN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 11:13:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbjBVQNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 11:13:54 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17792124;
        Wed, 22 Feb 2023 08:13:52 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id s22so10610383lfi.9;
        Wed, 22 Feb 2023 08:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O8HKJupUxTafko/9EYvv7Sk7sddF/f4G5xflzazxXqk=;
        b=ayN+whCq+85Uy9GNDyl7tj63JhOiNXdqgvL721uCLLUFWMQ1P/MsgqOWTQYj3at6wI
         KVbFQQpsvJKmRKQUsV6BdJGtEZLwFDBXTEJ4YM5Cqfizimhgfx1bctXLi+soh41quVz5
         yS3wOem5ICtGGjYwq5gepGORdu/uxWgbtdv7EbrilYxJ9r8W4Hb8cOKSV7bTrVeAOEpH
         fV0VMECyfBPEfYqyBik+feOZj8KtDz0WK+DSMLg0/L5j9QdFve8C7GSMpYThzkgRWMlo
         ZhnAlV1NIuq5ve1PT9S3R+yPoRMuyDDWh9o4+/gDuPrqjScgTx6e7GqzClfiMJkPo6gR
         D/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O8HKJupUxTafko/9EYvv7Sk7sddF/f4G5xflzazxXqk=;
        b=Twbmkc1t0rVTwvAFcLZqIGhv4qQmZjg4j/w32z250TimEtw5J2kjueS29cRoFLfvbf
         AMal4Ek5wGPkAjMDEDmOJfWsUjjYt1uq34LwOfqiwy8mZziNNruwUYED2Ufts9pzB52b
         O+qMOgvTuZevm13FxfPnpnICPTkjdTvACO3aWN8o0c3nx3xAugF/DM2pZo38eTG/Cmut
         lxY3wvYuHK+Kk0NTCNQO5CDFLR14DHTA6NsyKkLs19ajqEF5iIJmzHA9h+46wNrrHgj4
         nW3xqgH3NHri/SFX0gXFLleFTuiGzPfY25fZfZ6Lk431h5pBfFPm/RCNAJPopUwi9dmc
         TJlA==
X-Gm-Message-State: AO0yUKVuOCezOLZPFUv62wDsVFDzLuEcHWJQxxdath9pUH9kBWTdM4UC
        49QDVBYnkKqXxI54scYx6pRf8qCEIbA=
X-Google-Smtp-Source: AK7set+Bkxe/dNStb4QzNgsxhE1AuJ3i0LAbRneKND0gCBVBoxsML2ZXfX+OH8t+ZOdq2OvD6V1Fuw==
X-Received: by 2002:ac2:51c9:0:b0:4db:2aaf:7367 with SMTP id u9-20020ac251c9000000b004db2aaf7367mr2823794lfm.33.1677082430191;
        Wed, 22 Feb 2023 08:13:50 -0800 (PST)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id e6-20020ac25466000000b004db4fe8fd0bsm697953lfn.87.2023.02.22.08.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 08:13:49 -0800 (PST)
Date:   Wed, 22 Feb 2023 18:13:43 +0200
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Liam Beguin <liambeguin@gmail.com>,
        Peter Rosin <peda@axentia.se>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/6] Support ROHM BU27034 ALS sensor
Message-ID: <cover.1677080089.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BlRpAQ1HKTL4mi9A"
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


--BlRpAQ1HKTL4mi9A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Support ROHM BU27034 ALS sensor

This series adds support for ROHM BU27034 Ambient Light Sensor.

The BU27034 has configurable gain and measurement (integration) time
settings. Both of these have direct, inversely proportional relation to
the sensor's intensity channel scale.

Many users only set the scale, which means that many drivers attempt to
'guess' the best gain+time combination to meet the scale. Usually this
is the biggest integration time which allows setting the requested
scale. Typically, increasing the integration time has better accuracy
than increasing the gain, which often amplifies the noise as well as the
real signal.

However, there may be cases where more responsive sensors are needed.
So, in some cases the longest integration times may not be what the user
prefers. The driver has no way of knowing this.

Hence, the approach taken by this series is to allow user to set both
the scale and the integration time with following logic:

1. When scale is set, the existing integration time is tried to be
   maintained as a first priority.
   1a) If the requested scale can't be met by current time, then also
       other time + gain combinations are searched. If scale can be met
       by some other integration time, then the new time may be applied.
       If the time setting is common for all channels, then also other
       channels must be able to maintain their scale with this new time
       (by changing their gain). The new times are scanned in the order
       of preference (typically the longest times first).
   1b) If the requested scale can be met using current time, then only
       the gain for the channel is changed.

2. When the integration time change - scale is maintained.
   When integration time change is requested also gain for all impacted
   channels is adjusted so that the scale is not changed. If gain can't
   be changed for some channel, then the request is rejected.

I think this fits the existing 'modes' where scale setting 'guesses' the
best scale + integration time config - and integration time setting does
not change the scale.

This logic is really simple. When total gain (either caused by time or
hw-gain) is doubled, the scale gets halved. Also, the supported times
are given a 'multiplier' value which tells how much they increase the
total gain. However, when I wrote this logic in bu27034 driver, I made
quite a few errors on the way - and driver got pretty big. As I am
writing drivers for two other sensors (RGB C/IR + flicker BU27010 and RGB
C/IR BU27008) with similar gain-time-scale logic I thought that adding
common helpers for these computations might be wise. I hope this way all
the bugs will be concentrated in one place and not in every individual
driver ;) Hence, this RFC also intriduces IIO gain-time-scale helpers +
couple of KUnit tests for the most hairy parts.

I can't help thinking that there should've been simpler way of computing
the gain-time-scale conversions. Also, pretty good speed improvements
might be available if some of the do_div()s could be replaced by >>.
This, however, is not a priority for my light-sensor use-case where
speed demands are not that big. I am open to all improvements and
suggestions though!

What is still missing is advertising the available scales / integration
times. The list of available integration times is not static but depend
on channel gain configurations. Hence, I wonder if there is a way to
not only advertise available integration times with current gain
configuration - but also the available scales with different gains?

Finally, this patch series is an RFC becasue the helper logic could
benefit from extra pairs of eyes - and because the sensor has been
only very limitedly tested this far.


Matti Vaittinen (6):
  dt-bindings: iio: light: Support ROHM BU27034
  iio: light: Add gain-time-scale helpers
  iio: test: test gain-time-scale helpers
  MAINTAINERS: Add IIO gain-time-scale helpers
  iio: light: ROHM BU27034 Ambient Light Sensor
  MAINTAINERS: Add ROHM BU27034

 .../bindings/iio/light/rohm-bu27034.yaml      |   46 +
 MAINTAINERS                                   |   13 +
 drivers/iio/light/Kconfig                     |   16 +
 drivers/iio/light/Makefile                    |    2 +
 drivers/iio/light/gain-time-scale-helper.c    |  446 ++++++
 drivers/iio/light/gain-time-scale-helper.h    |  111 ++
 drivers/iio/light/rohm-bu27034.c              | 1212 +++++++++++++++++
 drivers/iio/test/Kconfig                      |   15 +
 drivers/iio/test/Makefile                     |    1 +
 drivers/iio/test/iio-test-gts.c               |  331 +++++
 10 files changed, 2193 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/rohm-bu2703=
4.yaml
 create mode 100644 drivers/iio/light/gain-time-scale-helper.c
 create mode 100644 drivers/iio/light/gain-time-scale-helper.h
 create mode 100644 drivers/iio/light/rohm-bu27034.c
 create mode 100644 drivers/iio/test/iio-test-gts.c


base-commit: 5dc4c995db9eb45f6373a956eb1f69460e69e6d4
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

--BlRpAQ1HKTL4mi9A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmP2Px4ACgkQeFA3/03a
ocUekggAtHqlwM8oq5roJKnU8YHnIE8rkZ/Bwd84+gt5erAyM1vdn4TTe5u9Z/ws
sOL5ffbKdbJWMwsNQG2D4Bl+QgvTl4Sr2/mW53OL4hWBr6KosIvMnoXyl4MBFvuD
pbpfca39xzmT5qUyrxWrsCfOOQ6wWW2C4opH8XGEt3w829TOIU9Bm8TOOxHO2jYX
msfZ+3hMOFahaInsYiGKkk+LFHTNM/aaFiqEVe7+jYr5n5m8D8EwzJaQP/RUWy/E
qaGhIKJz+/I53C2OnqcQkZKCw6gS/P9hVvzSimilTfAdE8ua2eWP5+a30wd/fXTd
0r0h3Gr74MYBo33HCWwXAZeIoebKag==
=Ye4V
-----END PGP SIGNATURE-----

--BlRpAQ1HKTL4mi9A--
