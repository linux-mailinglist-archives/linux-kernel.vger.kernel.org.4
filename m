Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B0A6EEFDA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 10:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239777AbjDZIHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 04:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239381AbjDZIHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 04:07:18 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1A3E56;
        Wed, 26 Apr 2023 01:07:16 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2a8ba693f69so64882711fa.0;
        Wed, 26 Apr 2023 01:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682496434; x=1685088434;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tzzoRLo0w1wYBW0EXQgbIxvGcotJBTsNWBHhgr/dyhU=;
        b=Y3vGtUAIuhj8lvkDak/OGN0SkNa6X3K7O/N4E8g8hZvYv7auxSQFeezaPcEAQohdZT
         plK+F58FqC4jpGDKy/Yqig20YlR7HLy8BlMrARr4cEZ4dOvngU8cYosvLXW0Nz+cPy6n
         V8zckC2Hb0H4w9X2gHEcb8V1EvDgCObuz5roLBgnkTNEiZFaU8nyc33ARQjmdi9MFsGL
         WPV8pQgCF+g+kA4vf6NzNsg1Aitz6h9pf2mnwu2mN0P7KnTrwECv6va3jVuC4EMtiEI+
         ZUGo7knK/xAIdj2BjchqIKvEfoLM+QS7x/ZJ+kbsaA2Qzvf1CVTDQ2PCDZDkPh9+6eY8
         TKRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682496434; x=1685088434;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tzzoRLo0w1wYBW0EXQgbIxvGcotJBTsNWBHhgr/dyhU=;
        b=PiF0kAkmCo9KDyrd/uueuAmMkcJeWQIx/bTwK+RwRCpqMPZjV9cAfd8Cf20v/2XxJy
         segGDQn5p/a3+JKFRmBGBNHhAZMBBCybLm0HkwPhAJmWKbB4whhGWZsxmqlZGcHq0meG
         1yf/NNdtwkqyAKvwG4OtTBEypeQjWEHWjDgzk/N4oTUNs7T5Vr7BI8IpJyqjSR9NympR
         ZxReFK6YbhxodaFPluR83b56Y3XKBVwM9roRDqqZkZloKg78kfe8G924n2AnCN0GKGKl
         0R/+rVd73wEgmDzNfS10Li9EMzOvwhF//9E8kNPa1+ZQ8vFWsLN8oNKjXUvFdZ3oC9jv
         3Wag==
X-Gm-Message-State: AAQBX9dWRl+pwtAt7qY9pgVjlU+Z8D/gAvwHVztnUesp/jXkvt26ruzg
        VeoYNf+9RtN2LugAaDKWIxY=
X-Google-Smtp-Source: AKy350ZSVW16F541ONooQI/NsDaWsDBLxQ5sOqatbh+QuECsp8YNUDJNSyY9QDgIMHvJVZjyoFLYjQ==
X-Received: by 2002:a2e:848d:0:b0:293:4b91:eb44 with SMTP id b13-20020a2e848d000000b002934b91eb44mr3933755ljh.38.1682496433985;
        Wed, 26 Apr 2023 01:07:13 -0700 (PDT)
Received: from fedora (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id y11-20020a05651c020b00b002a8a8f2dc89sm2420438ljn.72.2023.04.26.01.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 01:07:13 -0700 (PDT)
Date:   Wed, 26 Apr 2023 11:06:58 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Paul Gazzillo <paul@pgazz.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andi Shyti <andi.shyti@kernel.org>
Subject: [PATCH v3 0/5] Support ROHM BU27008 RGB sensor
Message-ID: <cover.1682495921.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kg3SGXwHxrIlbFR+"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kg3SGXwHxrIlbFR+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add support for ROHM BU27008 RGB sensor.

The ROHM BU27008 is a sensor with 5 photodiodes (red, green, blue, clear
and IR) with four configurable channels. Red and green being always
available and two out of the rest three (blue, clear, IR) can be
selected to be simultaneously measured. Typical application is adjusting
LCD backlight of TVs, mobile phones and tablet PCs.

This series supports reading the RGBC and IR channels using IIO
framework. However, only two of the BC+IR can be enabled at the same
time. Series adds also support for scale and integration time
configuration, where scale consists of impact of both the integration
time and hardware gain. The gain and time support is backed by the newly
introduced IIO GTS helper. This series depends on GTS helper patches
added in BU27034 support series which is already merged in iio/togreg
which this series is based on.

The hardware allows configuring gain setting by writing a 5-bit gain
selector value to a register. Part of the gain setting is common for all
channels (RGBC + IR) but part of the selector value can be set
separately for RGBC and IR:

MODE_CONTROL2 REG:
bit 7	    6	    5	    4	    3	    2	    1	    0
-----------------------------------------------------------------
|	RGB	selector		|
+---------------------------------------+
-----------------------------------------------------------------
| high bits IR	|			| low bits IR selector	|
+---------------+			+-----------------------+

In theory it would be possible to set certain separate gain values for
RGBC and IR channels, but this gets pretty confusing because there are a
few 'unsupported' selector values. If only RGBC or IR was set, some
extra handling should be done to prevent the other channel from getting
unsupported value due to change in high-bits. Furthermore, allowing the
channels to be set different gain values (in some cases when gains are
such the HW supports it) would make the cases where also integration
time is changed to achieve correct scale ... interesting. It might also
be confusing for user to try predicting when setting different scales
succeeds and when it does not. Furthermore, if for example the scale
setting for RGBC caused IR selector to be invalid - it could also cause
the IR scale to "jump" very far from previous value.

To make the code simpler and more predictable for users, the current
logic is as follows:

1. Prevent setting IR scale. (My assumption is IR is less used than
RGBC)
2. When RGBC scale is set, set also the IR-selector to the same value.
This prevents unsupported selector values and makes the IR scale changes
predictable.

The 2) could mean we effectively have the same scale for all channels.
Unfortunately, the HW design is slightly peculiar and selector 0 means
gain 1X on RGBC but gain 2X on IR. Rest of the selectors equal same gain
values on RGBC and IR. The result is that while changin selector from 0
=3D> 1 causes RGBC gain to go from 1X =3D> 4X, it causes IR gain to go from
2X =3D> 4X.

So, the driver provides separate scale entries for all channels (also
RGB and C will have separate gain entries because these channels are of
same type as IR channel). This makes it possible for user applications
to go read the scales for all channels after setting scale for one (in
order to detect the IR scale difference).

Having the separate IR scale entry which applications can read to detect
"arbitrary scale changes" makes it possible for applications to be
written so they can cope if we need to implement the 'allow setting some
different gains for IR and RGBC' - later.

Finally, the scales_available is also provided for all other channels
except the IR channel, which does not allow the scale to be changed.

The sensor provides a data-ready IRQ and the driver implements a
triggered buffer mode using this IRQ as a trigger.

Finally, the series introduces generic iio_validate_own_trigger() helper
which can be used as a validate_trigger callback for drivers which
require the trigger and iio-device to be parented by same device. The
KX022A driver is converted to use this new callback instead of rolling
it's own function. The new helper and KX022A can be merged in as
independent changes if need be.


Revision history
v2 =3D> v3:
  dt-bindings:
    - No changes
  iio_validate_own_trigger:
    - subject fix
  bu27008:
    - Mostly styling based on comments from Andy and Andi

  More accurate changelog in individual patches

v1 =3D> v2:
  dt-bindings:
    - Fix issues pointed by Krzysztof.
  bu27008 driver:
    - Fix issues pointed by Jonathan
  Add new helper for validating own trigger

  More accurate changelog in individual patches

---

Matti Vaittinen (5):
  dt-bindings: iio: light: ROHM BU27008
  iio: trigger: Add simple trigger_validation helper
  iio: kx022a: Use new iio_validate_own_trigger()
  iio: light: ROHM BU27008 color sensor
  MAINTAINERS: Add ROHM BU27008

 .../bindings/iio/light/rohm,bu27008.yaml      |  49 +
 MAINTAINERS                                   |   3 +-
 drivers/iio/accel/kionix-kx022a.c             |  13 +-
 drivers/iio/industrialio-trigger.c            |  22 +-
 drivers/iio/light/Kconfig                     |  14 +
 drivers/iio/light/Makefile                    |   1 +
 drivers/iio/light/rohm-bu27008.c              | 963 ++++++++++++++++++
 include/linux/iio/trigger.h                   |   1 +
 8 files changed, 1052 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/light/rohm,bu2700=
8.yaml
 create mode 100644 drivers/iio/light/rohm-bu27008.c


base-commit: 52cc189b4fc6af6accc45fe7b7053d76d8724059
--=20
2.40.0


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

--kg3SGXwHxrIlbFR+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmRI26IACgkQeFA3/03a
ocWsqQgAx9WyWk3k8uUYAO+vvlVaKn7RhtnwI3xR8DQazKIz4LdjWt1N9/MslPOu
lHTzJVqT5t/ID7S67dBeV6PSVeA2TcNQQkPsOBCERDjwCuRbfWWmr4vWNFPlyLdf
7m1kONiCmj37OiNsRSHL999Pu8jPdmIR4JVG4q4RdJqAU7MpuvR9od9HFBGiw4RB
Uc/qs80TlYRnS2Lw29y3hr7pJj3+aG5en7G0//VCOIdDymKkxLYIodhL8Eyb7ClW
3J+boC4K/LZ2jAAC9P8CmZcwlaWr2uS5LHx+i2Toxqv84XMW+mZqoOZUjeTDJr0h
22ULW8S89ptYQLh2RzqSI6EvwcJ2eg==
=V0ZS
-----END PGP SIGNATURE-----

--kg3SGXwHxrIlbFR+--
