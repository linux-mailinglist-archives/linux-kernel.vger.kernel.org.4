Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4820F6ECC9B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 15:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbjDXNHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 09:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjDXNHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 09:07:52 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D2C3A94;
        Mon, 24 Apr 2023 06:07:50 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2a8dc00ade2so42223851fa.0;
        Mon, 24 Apr 2023 06:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682341668; x=1684933668;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QTf0RKeNKXPePV5yHF77brOsHW3m/qjEZrll8GFgXrk=;
        b=PIpcB4rLBg/AphSsOvkIZwsrguM67NmqMNguDa4idmSpLffLCeFkPEU/Fr8vJHZc6w
         BIFCw5SDhanuqWCVl8oNilE55eZgu3RsG3sfmJN2wNmUL+xhy+ovMlB1goGQzOi8wV35
         Nut/1z2ca2QlWN4N5EtuyHsEdRb1fBBS1trXgPftGltqLcKqWhpNXRpi5dw07101jnSl
         aIK863PSFzIfrA54SZcTZBHHYFZCZwJ2lEZHaOO2032af29geJvt9NdMvr+66C5yPNvd
         jMyteHqgjyuWDHaeP04vZfQbRYi1RNWYDFOaWK7tCDyFslAYQ/m7iLsuppttyz/xCUKx
         HBfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682341668; x=1684933668;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QTf0RKeNKXPePV5yHF77brOsHW3m/qjEZrll8GFgXrk=;
        b=cFp5dRqIcC26fIu8JiM0zylBCF/luqvG8cOW/90a6H1rn9K8uunHfi+dlkMAsXZb6O
         p8l/kZla1w3O77/YX77Oc7SFNPlYhlC59+ywG/qiiUXl//Kk87XC8C3PYkjVPEAznfed
         Ttzn2v99cGs+RSkCvOcHOQ/pLr+kaDKmbgeJEblIajcu4wKDpc0ULU8ZsRg9fEQ7s1U9
         k+nQX0nVRrG1fN/I4526ZB+kaAfbSqzDTeU481DZwJBbpSXWRLppYEcURd2gKbfYXcwr
         R+zS/2f9GCfm2rgFlKEg+KdnXDy211XCetaoYo/JAaVcWzcjoLT3gMlxHD0QUabTIU8B
         Bqvg==
X-Gm-Message-State: AAQBX9dNA0yCDlAo2qDNixEprlt+d0YlrchJGLYSl2T/NvHE76bpArPF
        H1gxaggYPMupiEzPrcwJ8JE=
X-Google-Smtp-Source: AKy350bgruBBUhpIRaPMwHUWuC+h9jDEAbOEFbWJb7M/t7k62yXSPLPfxmNTlEtrdVQ138eJVXAtvg==
X-Received: by 2002:ac2:4346:0:b0:4ec:8fb0:9fac with SMTP id o6-20020ac24346000000b004ec8fb09facmr3937655lfl.47.1682341668273;
        Mon, 24 Apr 2023 06:07:48 -0700 (PDT)
Received: from fedora (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id f24-20020a2e9198000000b002a8c32fd2f3sm1760700ljg.89.2023.04.24.06.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 06:07:47 -0700 (PDT)
Date:   Mon, 24 Apr 2023 16:07:39 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] Support ROHM BU27008 RGB sensor
Message-ID: <cover.1682340947.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yjHSniPfoPhZjYAo"
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


--yjHSniPfoPhZjYAo
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
  iio:trigger: Add simple trigger_validation helper
  iio: kx022a: Use new iio_validate_own_trigger()
  iio: light: ROHM BU27008 color sensor
  MAINTAINERS: Add ROHM BU27008

 .../bindings/iio/light/rohm,bu27008.yaml      |  49 +
 MAINTAINERS                                   |   3 +-
 drivers/iio/accel/kionix-kx022a.c             |  13 +-
 drivers/iio/industrialio-trigger.c            |  22 +-
 drivers/iio/light/Kconfig                     |  14 +
 drivers/iio/light/Makefile                    |   1 +
 drivers/iio/light/rohm-bu27008.c              | 964 ++++++++++++++++++
 include/linux/iio/trigger.h                   |   1 +
 8 files changed, 1053 insertions(+), 14 deletions(-)
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

--yjHSniPfoPhZjYAo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmRGfxcACgkQeFA3/03a
ocWjQAf9Gsai1uv+9BTQvKAVcXAlRACQn9/q8r00z2gYjtKt+clvT1ztl+p1hjKl
6RDCMM+Hv2ZxlfICmJhqtyhRKgeNNHJ4jQA9EJHYZGvuOoWUioFpZnnwEEtN1u8x
I8XBeVVYM15li5rzU/4ft8/0wEKh9mHKf5rJvd5Rie4od5a4qCMYQEpm91Ae1oXO
Ktnuyge5SL3r23nc0Kv70THTLKgiADtu5epW7VkKlBk3p/Jrgp+7g4gAGWyBJvsr
Wtz0/mGO/LeFb9qChnBQqYQyqW9oKzr00WsaU6bbUoFGVx0NcuipEIFO53U6uPuK
U/J+G1MsxuhHlXDCs24Uu+U3T1vLqw==
=hmiY
-----END PGP SIGNATURE-----

--yjHSniPfoPhZjYAo--
