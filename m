Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA8C6AB976
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 10:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjCFJPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 04:15:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjCFJP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 04:15:29 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0801633E;
        Mon,  6 Mar 2023 01:15:27 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id s20so11737186lfb.11;
        Mon, 06 Mar 2023 01:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678094125;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=utv40n6eEz/XKwDsmLYKb5n25NOl1vGAjxXohGnDUr0=;
        b=Czwt6VqNG5WXW1nUEMckbHhLYk0vsBTAbILTFlZoMtDsaxW9zUDsm6m0oTh5BzF9q7
         aRmKYETxD4I5XKVOBgLtVElOn6AoiMAAglyQ5W0XZVnBdma69hZLofsGZGKDXQgXHH+T
         kE5qwQm4B2GXzduPow9G7T05OXINYmKsqa0NeKqb26e7PodP3j+BBoW3gTo10UHBg9xa
         Kr4gCw9vVVeoFeHbjPA1R8lxDznPBMln3FamabvXE63g+yIBrtDByopaKHQ0zJW69gVi
         NC8DHCzIWD4KVm5IZBopAphNwhQ6e3VhZmbrNmJZ8umrbRfDP8atsyZYXqoXSOxfBXsx
         GmRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678094125;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=utv40n6eEz/XKwDsmLYKb5n25NOl1vGAjxXohGnDUr0=;
        b=tk8xNjHMVouHDwk7/1tOm4ttxMaqjDL0PshNOARZjk2bVbq0nBXj9qrcdErJLrHPk5
         WQPXttmwHF/nkVRRpYtH+8FAaOYxadjaNdKlS0RBLrlOu86S6yWvtxHpD9wMYh5SUzHz
         4Wmy44TcB4PjiE7ZxnoDAOjzrg4Yd7FV3nQ7ouvbnHxhRarV/cC7Ah7YaSfWzKyBLaG0
         x4Yt+kmN5ku9mG+mxuqcOQzAlYlzhomYs36ARHGaldbgEOJ9al3JdI0vEUDxaqyBRLUO
         q4nQZW1WD1pqhX5sdgymiXBjkJbmuxpMhd7yiHqhayAv8Vm/YSlcU4SALCMxSbA+xA2K
         MOUg==
X-Gm-Message-State: AO0yUKXH9MDYlSM91kYcMLJULsZj9E7OyNwP/Qa9SZXYJOOM76UIzlpN
        k0GU+6S79hMk8IlV3gvrfMk=
X-Google-Smtp-Source: AK7set+MjJo2BckoazcHHHmEfLy2D+ph003Z0MeVus/VKW9Ab5YmP6Li2FU39pT/JyH6+ekCw1fGUg==
X-Received: by 2002:ac2:5a4c:0:b0:4dc:7ff4:83f9 with SMTP id r12-20020ac25a4c000000b004dc7ff483f9mr2973791lfn.16.1678094125211;
        Mon, 06 Mar 2023 01:15:25 -0800 (PST)
Received: from dc75zzyyyyyyyyyyyyydy-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyydy-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::6])
        by smtp.gmail.com with ESMTPSA id e27-20020ac2547b000000b004cafa01ebbfsm1559418lfn.101.2023.03.06.01.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 01:15:24 -0800 (PST)
Date:   Mon, 6 Mar 2023 11:15:10 +0200
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        devicetree@vger.kernel.org, Zhigang Shi <Zhigang.Shi@liteon.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Gazzillo <paul@pgazz.com>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liam Beguin <liambeguin@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 0/6] Support ROHM BU27034 ALS sensor
Message-ID: <cover.1678093787.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pJU8mkor76OvGB8O"
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


--pJU8mkor76OvGB8O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Support ROHM BU27034 ALS sensor

This series adds support for ROHM BU27034 Ambient Light Sensor.

The BU27034 has configurable gain and measurement (integration) time
settings. Both of these have inversely proportional relation to the
sensor's intensity channel scale.

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

2. When the integration time change - scale is tried to be maintained.
   When integration time change is requested also gain for all impacted
   channels is adjusted so that the scale is not changed, or is chaned
   as little as possible. This is different from the RFCv1 where the
   request was rejected if suitable gain couldn't be found for some
   channel(s).

This logic is simple. When total gain (either caused by time or hw-gain)
is doubled, the scale gets halved. Also, the supported times are given a
'multiplier' value which tells how much they increase the total gain.

However, when I wrote this logic in bu27034 driver, I made quite a few
errors on the way - and driver got pretty big. As I am writing drivers
for two other sensors (RGB C/IR + flicker BU27010 and RGB C/IR BU27008)
with similar gain-time-scale logic I thought that adding common helpers
for these computations might be wise. I hope this way all the bugs will
be concentrated in one place and not in every individual driver ;)

Hence, this series also intriduces IIO gain-time-scale helpers
(abbreviated as gts-helpers) + a couple of KUnit tests for the most
hairy parts.

I can't help thinking that there should've been simpler way of computing
the gain-time-scale conversions. Also, pretty good speed improvements
might be available if some of the do_div()s could be replaced by >>.
This, however, is not a priority for my light-sensor use-case where
speed demands are not that big.

Finally, these added helpers do provide some value also for drivers
which only:
 a) allow gain change
  or
 b) allow changing both the time and gain but so that the time-change is
    not reflected in register values.

For a) we provide the gain - selector (register value) table format +
selector to gain look-ups, gain <-> scale conversions and the available
scales helpers.

For latter case we also provide the time-tables, and actually all the
APIs should be usable by setting the time multiplier to 1. (not testeted
thoroughly though).

Revision history:
v2 =3D> v3: (Mostly fixes to review comments from Andy and Jonathan)
- dt-binding and maintainer patches unchanged.
- iio-gts-helper tests: Use namespaces
- iio-gts-helpers + bu27034 plenty of changes. See more comprehensive
  changelog in individual patches.

RFCv1 =3D> v2:
  dt-bindings:
	- Fix binding file name and id by using comma instead of a hyphen to
	  separate the vendor and part names.
  gts-helpers:
	- fix include guardian
	- Improve kernel doc for iio_init_iio_gts.
	- Add iio_gts_scale_to_total_gain
	- Add iio_gts_total_gain_to_scale
	- Fix review comments from Jonathan
	  - add documentation to few functions
	  - replace 0xffffffffffffffffLLU by U64_MAX
	  - some styling fixes
	  - drop unnecessary NULL checks
	  - order function arguments by  in / out purpose
	  - drop GAIN_SCALE_ITIME_MS()
	- Add helpers for available scales and times
	- Rename to iio-gts-helpers
  gts-tests:
	- add tests for available scales/times helpers
	- adapt to renamed iio-gts-helpers.h header
  bu27034-driver:
	- (really) protect read-only registers
	- fix get and set gain
	- buffered mode
	- Protect the whole sequences including meas_en/meas_dis to avoid messing
	  up the enable / disable order
	- typofixes / doc improvements
	- change dropped GAIN_SCALE_ITIME_MS() to GAIN_SCALE_ITIME_US()
	- use more accurate scale for lux channel (milli lux)
	- provide available scales / integration times (using helpers).
	- adapt to renamed iio-gts-helpers.h file
	- bu27034 - longer lines in Kconfig
	- Drop bu27034_meas_en and bu27034_meas_dis wrappers.
	- Change device-name from bu27034-als to bu27034
  MAINTAINERS:
	- Add iio-list

---

Matti Vaittinen (6):
  dt-bindings: iio: light: Support ROHM BU27034
  iio: light: Add gain-time-scale helpers
  iio: test: test gain-time-scale helpers
  MAINTAINERS: Add IIO gain-time-scale helpers
  iio: light: ROHM BU27034 Ambient Light Sensor
  MAINTAINERS: Add ROHM BU27034

 .../bindings/iio/light/rohm,bu27034.yaml      |   46 +
 MAINTAINERS                                   |   14 +
 drivers/iio/light/Kconfig                     |   17 +
 drivers/iio/light/Makefile                    |    2 +
 drivers/iio/light/iio-gts-helper.c            | 1158 +++++++++++++
 drivers/iio/light/iio-gts-helper.h            |  134 ++
 drivers/iio/light/rohm-bu27034.c              | 1501 +++++++++++++++++
 drivers/iio/test/Kconfig                      |   15 +
 drivers/iio/test/Makefile                     |    1 +
 drivers/iio/test/iio-test-gts.c               |  538 ++++++
 10 files changed, 3426 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/rohm,bu2703=
4.yaml
 create mode 100644 drivers/iio/light/iio-gts-helper.c
 create mode 100644 drivers/iio/light/iio-gts-helper.h
 create mode 100644 drivers/iio/light/rohm-bu27034.c
 create mode 100644 drivers/iio/test/iio-test-gts.c


base-commit: c9c3395d5e3dcc6daee66c6908354d47bf98cb0c
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

--pJU8mkor76OvGB8O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmQFrxgACgkQeFA3/03a
ocVuXwf/eVSgN5/9+OaCCs5aQ5Xse0q+Mkiy+CIzGsZMjrcUjaqUihBFMn3vSc+X
PKkThBvwHx0qy3iNN4HA50QBpGKstp20satCR9thIRK2rjD6AWDfSbIRJEYuju7N
uCJLAkSGP9DVQ+cW2IJesvEY24MorzYrcQy90l9M2tL8F3XX45JIEUeNy9aumqgx
hEXgxdiqjwAtd20aCKARnd9I87xfivzeBv2gYY8XJqrcBCcBCsJsjSKMz5MAFTdt
7hg7tG9k/WHC2OI0pObHX5Z3uYB0G0i/RnpQVADINPASI2VZyau9ookp40Y5SATH
+1jbyU+n9fLA25evkjICuipbvKwDtA==
=IgOh
-----END PGP SIGNATURE-----

--pJU8mkor76OvGB8O--
