Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBE660AF82
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 17:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbiJXPv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 11:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbiJXPv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 11:51:26 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC651285FF;
        Mon, 24 Oct 2022 07:45:47 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id g7so17097821lfv.5;
        Mon, 24 Oct 2022 07:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Up4S/hVV0kLQg/D9TNI+HPJ2RPqfxzB+SgfT5grdfG0=;
        b=aF+RVcp/p846yrEwDo18u/MoLxbvaC4nP8e12JY/UqR2akb91I8ncLfsMSopqOsO2M
         lLdQRIfeV+JAt9/h4q6PMqUZH9RvcSSJ10IBQXehkhQzN0rp9Cka+jdCqg6NCA3ZB00S
         496lZDFyPEnchwaGPVQg1Q1ZGiDY9duhdC3trDu/Gndnlrf+ctPB/Tx7AmS2g2YSYSEY
         tegfiFSM6rKevf45D+jKdpiVlvrJLuoVnBtstP6MDlG7TcqBP/Jb8RCobMDPOB/ojDDR
         c5hTpditkziuzcP8DMSm2xfN/9Z9hNVtWArW2iuIw1q31San6MtJjJBmjB1LLb1cP6RL
         zRug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Up4S/hVV0kLQg/D9TNI+HPJ2RPqfxzB+SgfT5grdfG0=;
        b=znxjFjGZ3nEpu+Tk26kQrdshSiX5rQkg4J1qnE2ClbQCYHGjqVRVnsvkg0/NRqhOO3
         Y3eZUKVj+5IVvLhoXB6n2z7ONXWO3vgpeDfkhq8D5ecRYz48vqZg6w1srpOhNYN5Fcjz
         7wmN7KezoIXWYlPB4YYskRE7hQbAgitKlBGojsFAB2oYfMbCBIXydXohg3GdGsRUo+uQ
         kN/8NbmrpzLWW9M+7eqey99JJIZa1xMU33z+W7SxAWszMe9qVyKKuS2+ievjgbVNSQnY
         I1KJ9f4/fxLFFr0W6xYfs990/h75t9Yy297GNtz5Lp+81nd/ESOoABsUh0w5eJKHv78l
         c6WQ==
X-Gm-Message-State: ACrzQf0EJY2IvReG8prXomHk/G7JTX4P2ESXqmhv9K+1gM3ldFicXT+P
        XvAS8cHsgcP/wPgtg5sLsn2RyGO2Y3Q=
X-Google-Smtp-Source: AMsMyM6anC+og1Rf5mrzppeAOAY0z/pGd3LzLwE0Qr20JvQ4nwSkNZRIGebFRvkZsDeVUNBrRoP4Ew==
X-Received: by 2002:a2e:9b17:0:b0:26e:367c:c904 with SMTP id u23-20020a2e9b17000000b0026e367cc904mr12866498lji.326.1666615216640;
        Mon, 24 Oct 2022 05:40:16 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyby-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::2])
        by smtp.gmail.com with ESMTPSA id s12-20020a05651c200c00b00277045dcb5bsm1046319ljo.97.2022.10.24.05.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 05:40:15 -0700 (PDT)
Date:   Mon, 24 Oct 2022 15:40:11 +0300
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
Subject: [PATCH v5 1/3] dt-bindings: iio: Add KX022A accelerometer
Message-ID: <06f8e1ab29d02ed216db10091a269df4b6abad9a.1666614295.git.mazziesaccount@gmail.com>
References: <cover.1666614295.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PUm9g8VtnvOCYrix"
Content-Disposition: inline
In-Reply-To: <cover.1666614295.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PUm9g8VtnvOCYrix
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---
v3 =3D> No changes.

v2 =3D> v3 as suggested by Krzysztof:
- better check for the interrupt-names

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

--PUm9g8VtnvOCYrix
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmNWh6oACgkQeFA3/03a
ocWBqggAh/7f8qUFMNo9U9ODZuO/2i42J4loF9hvUgdvxD+AX/Hu1VOwrzolHO04
CZnb9/SqkqPvuXIYCMjMVryfpeVgu0eTFdXcZKhKDaPC1rWyAz+Or3GyBRwahaVD
HEyA2AVQuoKvX9EG7QtNfytYUjlvXCzeVW0CCTTwAqNh5n5xIwn/SvmX9BdSGF6l
gJllIKeRXaNp8v7azR6PjrkLnsZer2u+U9orbl0KfEB9IrFGFGP7uku9HmnhEGGS
y7WBix0+kohzLolscb8lOiMyZrhX7LOB4WB4cKPpOMHGeMQk0HLEy80/FoKHg4dh
4fXo4BMI9MitDPtKL74Aj/oBWrws3A==
=fqJl
-----END PGP SIGNATURE-----

--PUm9g8VtnvOCYrix--
