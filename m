Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9844605F05
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 13:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiJTLgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 07:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbiJTLge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 07:36:34 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93EE617651C;
        Thu, 20 Oct 2022 04:36:31 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id i17so24967193lja.3;
        Thu, 20 Oct 2022 04:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gZoVF05Q2xZgx3y72bMOuq/IRllwtgg80T41Y5gIALE=;
        b=FWJgVvXqzr0lJCjJx+U29KrVBkJXspt70ojqE/VRcwueis8vNY41xu0FT0AII4rHz9
         Ndf5FsIuLdDg1aJGYuuS7bpvhLdgZZDyoLiDI0EP97/6nLz44y6HzS5NjlMuEZnsar8R
         fnTO2MQTnb+oNH2MD0J9CnTZeNTDLTMEjBJnKCVhC9LOdN5HFoqBarH7na4OOmrs7cQ6
         eGBMUg53DwMZ6BWHgoZa+jiOw8Co2Yo585iFVwy0NKidfzWFKdUZg7cI6/x3xROjqgiy
         Y0y9HwOKcsmzVN0MCIODFirN05i0q67A7zcE2q7a5sPUWzjXmvNbHqbxCoxmUSNb4c0I
         TwKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gZoVF05Q2xZgx3y72bMOuq/IRllwtgg80T41Y5gIALE=;
        b=L2sd2l7NLm+zTs2odaVpMmwqQCfpyS6FalUy494FN23CqYjo9w8q9JwOCXoYYxanbt
         t50RCm/svUwy7Q4XmxMeYTpIfoDiAfqqojGu+5F6g2X7B/eW8NaCcWrs/DlnyiJ/pvmi
         Mzk0Zm+s1y+opvq/c0ncZdI/3ZgFyVFukWWx3XD6tzcjSKIjRRbhk4VrdAxkP9ROeBkk
         W88g4E6oQEe4Q0svZgmY9lTDkDC/jnPyvjR5HCaLNVS87LWeEhoN9GJWd+D786dp0dy0
         bDfMH1dO9oy1/tFjt+/lhuYveeSr7REjDRHXPAlak6BEAp7EKtjcOyoDdlgZELiTBpbQ
         WvGQ==
X-Gm-Message-State: ACrzQf0AC0I2SDf0FdaxyprckCOzoGgmD3mt4t3K+uNu/Q0Sar73rskl
        5wRShAf10cJd7qafioz6m80zXAh8pKo=
X-Google-Smtp-Source: AMsMyM7pfv+3U0D2awTUfxF/YUO/sMrsauOdaDwhoycBtXutWfHjh5uLFC5DssfiugZvfKGZTMp6KQ==
X-Received: by 2002:a2e:b989:0:b0:26f:b595:d428 with SMTP id p9-20020a2eb989000000b0026fb595d428mr4529036ljp.169.1666265789012;
        Thu, 20 Oct 2022 04:36:29 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyycy-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::4])
        by smtp.gmail.com with ESMTPSA id 11-20020a05651c128b00b0026fa9e19197sm2874548ljc.36.2022.10.20.04.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 04:36:28 -0700 (PDT)
Date:   Thu, 20 Oct 2022 14:36:23 +0300
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
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] dt-bindings: iio: Add KX022A accelerometer
Message-ID: <aaf22c800b90f4eed1986782c8549bec5c9c72f5.1666263249.git.mazziesaccount@gmail.com>
References: <cover.1666263249.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XLJOO2dPuPGVM4/U"
Content-Disposition: inline
In-Reply-To: <cover.1666263249.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XLJOO2dPuPGVM4/U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

KX022A is a 3-axis Accelerometer from ROHM/Kionix. The sensor features
include variable ODRs, I2C and SPI control, FIFO/LIFO with watermark IRQ,
tap/motion detection, wake-up & back-to-sleep events, four acceleration
ranges (2, 4, 8 and 16g) and probably some other cool features.

Add the basic device tree description for the accelerometer. Only basic
accelerometer features are considered as of now - new properties may or
may not be needed in the future when rest of the features are supported.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
v2 =3D> v3 as suggested by Krzysztof:
- better check interrupt-names

RFCv1 =3D> v2:
Based on a review by Krzysztof:
- fix a typo from commit message
- const compatible
- drop unnecessary descriptions/words
- io_vdd-supply =3D> io-vdd-supply
- fix the binding example indentiation
Also,
- change my email address
- support both INT pins
---
 .../bindings/iio/accel/kionix,kx022a.yaml     | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/kionix,kx02=
2a.yaml

diff --git a/Documentation/devicetree/bindings/iio/accel/kionix,kx022a.yaml=
 b/Documentation/devicetree/bindings/iio/accel/kionix,kx022a.yaml
new file mode 100644
index 000000000000..986df1a6ff0a
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/kionix,kx022a.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/accel/kionix,kx022a.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ROHM/Kionix KX022A Accelerometer
+
+maintainers:
+  - Matti Vaittinen <mazziesaccount@gmail.com>
+
+description: |
+  KX022A is a 3-axis accelerometer supporting +/- 2G, 4G, 8G and 16G range=
s,
+  output data-rates from 0.78Hz to 1600Hz and a hardware-fifo buffering.
+  KX022A can be accessed either via I2C or SPI.
+
+properties:
+  compatible:
+    const: kionix,kx022a
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 1
+    maxItems: 2
+
+  interrupt-names:
+    minItems: 1
+    items:
+      - enum: [INT1, INT2]
+      - const: INT2
+
+  vdd-supply: true
+  io-vdd-supply: true
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
+        accel@1f {
+            compatible =3D "kionix,kx022a";
+            reg =3D <0x1f>;
+
+            interrupt-parent =3D <&gpio1>;
+            interrupts =3D <29 IRQ_TYPE_LEVEL_LOW>;
+            interrupt-names =3D "INT1";
+
+            io-vdd-supply =3D <&iovdd>;
+            vdd-supply =3D <&vdd>;
+        };
+    };
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

--XLJOO2dPuPGVM4/U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmNRMrcACgkQeFA3/03a
ocXpFQf+I04E2yKJdnbmjnJ5fA2gyOf93BBGvKDqsTDS7MxiDlRJrBl6KZN5iw39
VxTzp77wSaH6NE+l0K+FNp6uCm2mZ7gWm71kltPqZvsE6JeOZr6u6O/mgmd06khV
2Q+CwmtvfdJsNp/6+4tmfeP535+IlfYrnLyytIvdzi1f+qGIoafjiaFEys3lAnIV
hqHC9kwxAOwmfrR1UKNHFQwlqHAHUC5eorYOIbnXT/BE7gLCouQbHqzwCXa44z/h
eeoJSP/e0sbW9ISXngAstoLtZUVQ9zRS27k/86zLSkT/P/xW11qk/X0x3+yN17cU
O32xZIPqmrazLIk4ObQm14IDGvhCLQ==
=Kxy0
-----END PGP SIGNATURE-----

--XLJOO2dPuPGVM4/U--
