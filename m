Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60A36EA72E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 11:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbjDUJhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 05:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbjDUJhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 05:37:52 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8E9A5FF;
        Fri, 21 Apr 2023 02:37:50 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4ec81773cf7so1448512e87.2;
        Fri, 21 Apr 2023 02:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682069869; x=1684661869;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sz1OnOb0n4ydElkEDE6Ll6gkKnGXqAStKuCmUlNsLUM=;
        b=JNPU1i1i+zs2YwGELrf5uO3IjQoXrG/1jBjmt2UFd11jjG369OlmATIYpwa4tFD6PY
         l0Zmw6yVVeEBSPX7PFyanSY5oKhiibX8mPLWAzXTJLc7QpLhYXw0F/xCrEhFxcmXAWrv
         WVVVfzuJ8pCoWgy2SpqE9RIM2S+4MjZT9k78QznE829CQlRBg29ODvzsgro4oLX9WqFc
         lhFDxkBQ7oTv68WtW3cXxtlLxkJFtHTWHcqH9q2WRim/AmXlKrBnekD/gafml6rX/IkP
         /euo26e9sHW5PSJ2HOAkwK97t+zBXNVBYZVI5A6B8O65JZNwb1BTHAVjLzFJ3eihY8Ip
         E9oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682069869; x=1684661869;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sz1OnOb0n4ydElkEDE6Ll6gkKnGXqAStKuCmUlNsLUM=;
        b=PVdOI5RKOx072WhpADunhtGP4g3tB2Dgycg2N4jPIi7z52WVOjHKVUh292cForRYnl
         EDQO45eoXoYgg15/+JOV5j1ecTjqjQaDYjCHtygQTQM2mbZhhBAOEkMmVTdW92hsWBUQ
         5GnjyGI/2cmDbfea4NveFn0s0vCvE4FenX8Synupy9tanbtE5v+FUGpcdG9xfF5aM6Sa
         Ij/aM3bwTgYajPdzawu4/ie3DkX2fNC3i+64Qku8Pqhbmwr13095duzJYHeOotVo6Emn
         Ksn1Su0VB8wlZCufEXmn8nxr9HJkeIqui8KFb+PDWxbEh1INVu4M2UdfgjPh1yWCi/wi
         6LIg==
X-Gm-Message-State: AAQBX9cS3rHIiZ8oaLrmg2TtTuZdTPbToZCM6VifjBxUvnkAIbslC+W9
        +IctlNGLF25GgivP5qXLujs=
X-Google-Smtp-Source: AKy350ZYkgij7NMRbdJJzs4P118dJbAD4yRBkU1YX+XBa0+WOYL78bHqCKH5yjice+HD8MNHnif6oA==
X-Received: by 2002:ac2:5226:0:b0:4db:ebb3:b529 with SMTP id i6-20020ac25226000000b004dbebb3b529mr1224035lfl.46.1682069868926;
        Fri, 21 Apr 2023 02:37:48 -0700 (PDT)
Received: from fedora (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id y9-20020ac24e69000000b004eb44c2ab6bsm499025lfs.294.2023.04.21.02.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 02:37:48 -0700 (PDT)
Date:   Fri, 21 Apr 2023 12:37:30 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        devicetree@vger.kernel.org, Zhigang Shi <Zhigang.Shi@liteon.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Gazzillo <paul@pgazz.com>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 0/3] Support ROHM BU27008 RGB sensor
Message-ID: <cover.1682067567.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UM7lZcgq94AC909u"
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


--UM7lZcgq94AC909u
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
frameeork. However, only two of the BC+IR can be enabled at the same
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

---

Matti Vaittinen (3):
  dt-bindings: iio: light: ROHM BU27008
  iio: light: ROHM BU27008 color sensor
  MAINTAINERS: Add ROHM BU27008

 .../bindings/iio/light/rohm-bu27008.yaml      |   49 +
 MAINTAINERS                                   |    3 +-
 drivers/iio/light/Kconfig                     |   14 +
 drivers/iio/light/Makefile                    |    1 +
 drivers/iio/light/rohm-bu27008.c              | 1028 +++++++++++++++++
 5 files changed, 1094 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/iio/light/rohm-bu2700=
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

--UM7lZcgq94AC909u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmRCWUsACgkQeFA3/03a
ocU3nQgAx3r+qSawdk+Gx3wMRvVdObpdOqMgbzlCRAOJFKxdKKt9Ydpt72+6xYBL
G9OPpPVIAsO5/fEIVs1doqRAQxcEKZHj7SB0/vcIV4k9jbeApWmCCiU80VTgG+D0
SX5XXudWAxy8BE6A2SbGJ8BsVNi/f/VF/ZM5WJ8xJ/Ms4Yy5RsUymoxI/MXnDoVi
Gqc49cpWkSVPo1R+AYRgYyLlHbxWOkbuTNiAAgd9P4dytkj94VOfAdfmwAkgQOLc
kC2gN9/MJ8Y1qp5oLzL4AmlAZYuS1LwMQQEw9dBo42HyvGPcBD97uP63gSLJ3EIT
SCTAKsycPOq3Ym/Td9/JAUZXnTSLaw==
=kpWx
-----END PGP SIGNATURE-----

--UM7lZcgq94AC909u--
