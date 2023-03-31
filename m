Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139A36D208C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 14:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbjCaMlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 08:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjCaMkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 08:40:55 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70AE20D9A;
        Fri, 31 Mar 2023 05:40:16 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id e9so7594094ljq.4;
        Fri, 31 Mar 2023 05:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680266415;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q3mXImHtz4EhEyCxB6WItdSZ6XGw4IxolKz3UfYfk7I=;
        b=I//N7Ueb4GIdvflyZ4vk8MA+amZ8el1uu0ng8BAqAEsquX+4VIS59JU/jKnnSfSt8G
         MpFnfpEiCI13b0bHqbxGyLlY9hiZmuw584cc/1JGq1qQEMZ84ivEPPdgywrtLopGMHyn
         d1BBl1URKjByux/q9Zx9RfFfhxG0QVI8w2IvQan0CjXURYcwByfC98KrPE7XA9kMeEQV
         3BUdxWSnC+L2tpCdil8V9y7Us6UcLtYAlkxdsd2NE0M59CnHugm9HQHCykNIqiYJf5rT
         MTSt4Fk4H5CCGeXTePCZH7O0rDXBlZ9m2128Tr4LMb3ZPAcVRgIRgmiBnVqw+NLK/F+Q
         wx1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680266415;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q3mXImHtz4EhEyCxB6WItdSZ6XGw4IxolKz3UfYfk7I=;
        b=6pBDnjjEeNFsl45vcLdq5cPpPPXJrfzAOxHKCIf8Dh/SYqyksPdL7HkrET+F2CZZbt
         pyfTxYq30a9BJ+jzBpDyE/8Z4OSyuu4h7Z6so5A2cpGIyBiFvLqydD19KM7yC2b96cCk
         +T41LNiK8RpJoIY3Ghv/U4vp3XDTpr4qouLJP57aPSpbtGy/7mruySI+JMTDfw4eB8T2
         lOFRGTcMv3D7Ec2p4OSn6JgyVgx3DIiK4boAyGFfTd5OPrdF11rf/6FyZHiw9MfwjLcl
         k54/g8iAbV4mfyFUKN+8VSl5hiXEY4jj9Zs6XITu+FR3y17nmVrDWLND09GHjxFUi2gN
         FaXg==
X-Gm-Message-State: AAQBX9eBLMJUGQobi7L2/ZCCPr/sqtAuMqJ9bbP6zV3e5oBxiOYm7mWe
        xn7xIeDQQdINR/89mzgZVD8=
X-Google-Smtp-Source: AKy350bZR7rBYb7S5oiAFk+Tn6FuMVRcHowjyz+9VRgHiwalno0zyEjol0tbXs9qQoRdzS9p2NHgIQ==
X-Received: by 2002:a2e:990a:0:b0:2a6:1b80:1ff3 with SMTP id v10-20020a2e990a000000b002a61b801ff3mr1602482lji.0.1680266414743;
        Fri, 31 Mar 2023 05:40:14 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id y21-20020a2eb015000000b00295d62f0a0fsm343723ljk.122.2023.03.31.05.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 05:40:14 -0700 (PDT)
Date:   Fri, 31 Mar 2023 15:40:02 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     linux-iio@vger.kernel.org,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Paul Gazzillo <paul@pgazz.com>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v7 0/5] Support ROHM BU27034 ALS sensor
Message-ID: <cover.1680263956.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ulRrG+4uwaZbKenN"
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ulRrG+4uwaZbKenN
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
(abbreviated as gts-helpers). I have also written  a couple of KUnit tests
for the most hairy parts but those are not part of this series as they
depend on kunit_devices which are not yet supported in-tree. I'll send
those tests as a separate patch (or series) when the Kunit dependencies
are merged in-tree. Meanwhile the interested people can find the tests
=66rom my private playground:
https://github.com/M-Vaittinen/linux/tree/iio-gts-tests
(Tests are not maintained there so some porting may be needed if/when
things change in mainline.

Finally, these added helpers do provide some value also for drivers
which only:
 a) allow gain change
  or
 b) allow changing both the time and gain while trying to maintain the
    scale.

For a) we provide the gain - selector (register value) table format +
selector to gain look-ups, gain <-> scale conversions and the available
scales helpers.

For latter case we also provide the time-tables, and actually all the
APIs should be usable by setting the time multiplier to 1. (not testeted
thoroughly though).

Revision history:
v6 =3D> v7:
- Drop Kunit tests for gts-helpers. These will be sent as a follow-up
  when dependencies get in-tree.
- BU27034 driver:
  - Prevent use of a "bogus" gain value in integration time setting.
  - Minor styling
- GTS helpers:
  - Let caller know whether the iio_gts_find_new_gain_by_old_gain_time()
    or iio_gts_find_new_gain_sel_by_old_gain_time() updated the new_gain
    in a case where the call fails. This can be relevant to callers like
    can be seen in BU27034 integration time setting.
v5 =3D> v6:
- Just a minor fixes in iio-gts-helpers and bu27034 driver.
- Kunit device helper for a test device creation.
- IIO GTS tests use kunit device helper.

v4 =3D> v5: Mostly fixes to review comments from Andy and Jonathan.
- more accurate change-log in individual patches
- copy code from DRM test helper instead of moving it to simplify
  merging
- document all exported GTS helpers.
- inline a few GTS helpers
- use again Milli lux for the bu27034 with RAW IIO_LIGHT channel and scale
- Fix bug from added in v4 bu27034 time setting.

v3 =3D> v4: (Still mostly fixes to review comments from Andy and Jonathan)
- more accurate change-log in individual patches
- dt-binding and maintainer patches unchanged.
- dropped unused helpers and converted ones currently used only internally
  to static.
- extracted "dummy device" creation helpers from DRM tests.
- added tests for devm APIs
- dropped scale for PROCESSED channel in BU27034 and converted mLux
  values to luxes
- dropped channel 2 GAIN setting which can't be done due to HW
  limitations.

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

Matti Vaittinen (5):
  iio: light: Add gain-time-scale helpers
  MAINTAINERS: Add IIO gain-time-scale helpers
  dt-bindings: iio: light: Support ROHM BU27034
  iio: light: ROHM BU27034 Ambient Light Sensor
  MAINTAINERS: Add ROHM BU27034

 .../bindings/iio/light/rohm,bu27034.yaml      |   46 +
 MAINTAINERS                                   |   14 +
 drivers/iio/Kconfig                           |    3 +
 drivers/iio/Makefile                          |    1 +
 drivers/iio/industrialio-gts-helper.c         | 1077 ++++++++++++
 drivers/iio/light/Kconfig                     |   14 +
 drivers/iio/light/Makefile                    |    1 +
 drivers/iio/light/rohm-bu27034.c              | 1498 +++++++++++++++++
 include/linux/iio/iio-gts-helper.h            |  206 +++
 9 files changed, 2860 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/rohm,bu2703=
4.yaml
 create mode 100644 drivers/iio/industrialio-gts-helper.c
 create mode 100644 drivers/iio/light/rohm-bu27034.c
 create mode 100644 include/linux/iio/iio-gts-helper.h


base-commit: eeac8ede17557680855031c6f305ece2378af326
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

--ulRrG+4uwaZbKenN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmQm1J0ACgkQeFA3/03a
ocWNAAf9G6XQyppJP/JhtThezj5hIBC7TrtJPo0cDM8BKxR4P1kqUsmNcfY1UyVf
lKgZqizivqnjJzVHse7IScQTK6/TnDDsJ4Y2faIZyAlIkeuNDPGNckx7c1q/5W97
OVWSBxn7J1tPMHr9plIYLkwYbCFxm0OSZHpI9i01Vc6joGWw99nxfwjmMFKYqcXi
XYSNKuNoySM9tRmZQZC9LaoHaujqNh87ApG8isjOx0CyuCRi2eO15rLhGtDzeEDt
DNRKuYoGCPSCLafNPoosEr1myt0gwzD78qSFjHyQcwC7AycccBgFUM3lRoTrVlEE
Y3qQ1ntCFPACI8cFCPcaH3juFb9D8g==
=D5t7
-----END PGP SIGNATURE-----

--ulRrG+4uwaZbKenN--
