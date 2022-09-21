Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A8A5BFD22
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 13:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiIULpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 07:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiIULpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 07:45:17 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDD6883EE;
        Wed, 21 Sep 2022 04:45:15 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id j24so6149670lja.4;
        Wed, 21 Sep 2022 04:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=sX0VGnOv15V/mUkTpC6ThB5wqXUnNiQX+K/+Fn8NYpU=;
        b=fbGo9iAGa8xYTMTxsMpjRU3Uyt7r68gnZOtk8Uf3A8j3VogQDK8ujH1FdOZfpHICdX
         pka517jO91fWsth9u9H7FMl0EeLKkKjQt62/s3W/tt86wwTcHRNx6tj8dq8qo+4lk4Xw
         MhJkNOa0E/SOayM6O2bQjsH5qkZIfLY71XBoppBK6w0PgLSpKp2w6v+PFkxqAgzdSYaI
         i6fDO1tNsw8UJyzGZRfiPGIQ3LS51TPZM1umo2x11R1dRLrt5EyKt2TV/1CHll9Kn/yn
         /Q5unIy5OhZSV6o45NZ1kWqAir6wBt+kXoxr+MnnOMxMVhJv+lXKMlsISQ8tPRnPfjXG
         EqBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=sX0VGnOv15V/mUkTpC6ThB5wqXUnNiQX+K/+Fn8NYpU=;
        b=dRD4dG0j+Qe08Uk0OXLmBcmGHFCOozawVTOhlkuFWJRO3KYPxKlHVKkhxFvwUcUDkG
         5nVre3hkZQnzczHCwTblZd7YMVBY2FU8ihOn6JoqKlb8MzIG8ykbpM1AaQPRU7lCQHXS
         TI+n1LNnlaeIoX3J3rB2n/01AMvGojdqeo6LZbIDOiYGvr8nSPBQSnU/uKIZKRo7Phs9
         w+w5ZAnyNsaMv1JTr+3aAegSii0qSlyZ0fiDjP1cDPoMEojYs5yx+HR1XVbMLpk2LgZu
         wX+cHyoJIiTQ2RKznIN/EgVeQPvnll8sCV72SaKaYUipDm4uM1uIcdvhKDC6eUsT1t7d
         H1ZQ==
X-Gm-Message-State: ACrzQf0jbMIhUEQyaG2cIF4gotXdW8A2d5u6Ji7QUiMH5P9yU3vVpajC
        pgcyhfzlCs7Apl3f308Svks=
X-Google-Smtp-Source: AMsMyM6qW906SLuKhOavxtb0aSlKqzjhc/qtM3Yv4souFhWHPfMfckzX2QfJL3MKHZfk6C/o7YxZPQ==
X-Received: by 2002:a05:651c:222c:b0:25f:e654:36e3 with SMTP id y44-20020a05651c222c00b0025fe65436e3mr8445192ljq.20.1663760713051;
        Wed, 21 Sep 2022 04:45:13 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id o17-20020ac24e91000000b0049964f68457sm388161lfr.262.2022.09.21.04.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 04:45:12 -0700 (PDT)
Date:   Wed, 21 Sep 2022 14:45:06 +0300
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
Subject: [RFC PATCH 3/5] dt-bindings: iio: Add KX022A accelerometer
Message-ID: <eb3edbb63c117f93e8ec534f50d8e3cf91ab3041.1663760018.git.mazziesaccount@gmail.com>
References: <cover.1663760018.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RbbfspudEEx6WiZD"
Content-Disposition: inline
In-Reply-To: <cover.1663760018.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RbbfspudEEx6WiZD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

KX022A is a 3-axis Accelerometer from ROHM/Kionix. The senor features
include variable ODRs, I2C and SPI control, FIFO/LIFO with watermark IRQ,
tap/motion detection, wake-up & back-to-sleep events, four acceleration
ranges (2, 4, 8 and 16g) and probably some other cool fatures.

Add the basic device tree description for the accelerometer. Only basic
accelerometer features are considered as of now - new properties may or
may not be needed in the future if rest of the features are to be supported.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 .../bindings/iio/accel/kionix,kx022a.yaml     | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/kionix,kx02=
2a.yaml

diff --git a/Documentation/devicetree/bindings/iio/accel/kionix,kx022a.yaml=
 b/Documentation/devicetree/bindings/iio/accel/kionix,kx022a.yaml
new file mode 100644
index 000000000000..62a0c7991a62
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/kionix,kx022a.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/accel/kionix,kx022a.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ROHM/Kionix KX022A Accelerometer bindings
+
+maintainers:
+  - Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
+
+description: |
+  KX022A is a 3-axis accelerometer supporting +/- 2G, 4G, 8G and 16G range=
s,
+  output data-rates from 0.78Hz to 1600Hz and a hardware-fifo buffering.
+  KX022A can be accessed either via I2C or SPI.
+
+properties:
+  compatible: kionix,kx022a
+
+  reg:
+    description:
+      I2C slave address or SPI chip-select.
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  vdd-supply: true
+  io_vdd-supply: true
+
+  mount-matrix:
+    description: |
+      an optional 3x3 mounting rotation matrix.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells =3D <1>;
+        #size-cells =3D <0>;
+          accel@1f {
+            compatible =3D "kionix,kx022a";
+            reg =3D <0x1f>;
+
+            interrupt-parent =3D <&gpio1>;
+            interrupts =3D <29 IRQ_TYPE_LEVEL_LOW>;
+
+            io_vdd-supply =3D <&iovdd>;
+            vdd-supply =3D <&vdd>;
+        };
+    };
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

--RbbfspudEEx6WiZD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmMq+UIACgkQeFA3/03a
ocX/9wf/aEyDZ2Tkm81m6dzPPBdWImZn7+sq9NaBVGD8sXolz3sRxag3y60kxImT
SB3rMi2t1DFKZxbroYZ0y9c+tbxO0zMBIKpakgatVhcSaHsGxvKehuZT9XClKFai
XkE+J2OXWH4yVr/dIFFDt0eL77AteEQPIlOHYJtGE9b7/3Iqe8fc0asJZ7vaFzD1
i9k/1TpXK6NShvTsvTv+c/Z97KT1Wh70TpN/T5YKCyzWDE0fFNP0PHmEP8SN/49t
dr13OVd93RfI7mfbKphViB3nDD9o+mqQQIWynI85vXkNM0WuNRf8Ty/xugyjZ6ek
sxaRQ/UDyQLs2gQYplTPKTWUqIj4OA==
=BX82
-----END PGP SIGNATURE-----

--RbbfspudEEx6WiZD--
