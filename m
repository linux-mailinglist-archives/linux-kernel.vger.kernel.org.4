Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0AF5F69BF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 16:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbiJFOhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 10:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiJFOht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 10:37:49 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41B2A7AAB;
        Thu,  6 Oct 2022 07:37:48 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id b2so3007870lfp.6;
        Thu, 06 Oct 2022 07:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=nSpHlKnMonBGCDJ4nQk2Ue66OCa5K5+vPeWv3/hFJOE=;
        b=IXpggGVZYtF/+damtbWsP1tHFm88rn7TRHulZROeeO126QYxYrSpVxYfP5Xk0t9vg8
         hlxOdp1w85VXaT5Z93hs7p8IuHZDsr5oapeSmWB8p+ZerkI3wgO1Niyqxldqgcdpt1nL
         4/fSwClk5SdJsdE9xar3jCf0QhsDbgqknVKjh1y29PQZZb/KjQRUFaTuAflodbSB2n+o
         SOH4ah8qAUgqmOsLgvkPJfeP8JStelWxG2g80XN/bJg/ynKvV8hdU9Ohn6AlGCuXLsbA
         FA46pzNKSaMvAzW2F/XJoLcUkZwhQVjNei0xLc9dGp09rdqE83gbG2525zpUSghPKBMV
         JW3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=nSpHlKnMonBGCDJ4nQk2Ue66OCa5K5+vPeWv3/hFJOE=;
        b=H/HwZ4I32zwKUb61chg7Jxm2nbdDgSpTOhzEmFARuldNPSca4GAJ2VorwtnKyJnlJu
         OrRI25Z36yEMKLqt3x/LJZYCZDkhk5bLCTHg70S4v7AFY9Cu3YIGGV3GHAGdu65sd22a
         fQjLx0Xx6RpYM6vmPz/QDn6O4ccdSaaR9CNPJge41jIaWoeD7lxGCGJooBj3K2YD1DIp
         pXkbn+osRgsul/vZt1qFGd4W/mhY20e/rY1qby9gVUKrxy7lQOR1JfDtLbIvI18QhreV
         g6vvUShz+1nVuJWmO3NkJKnu//7n9clIsnYQ14TbwNulbIBTh4600ZnIXBI/6ED5strK
         4+Rg==
X-Gm-Message-State: ACrzQf3HRIXh1ibaKdwkMixjq/dkZTW90B/89CcTo6SX7htY1Xg8rL1M
        xvk/LPZ9DUOpmHveNMoYRhY=
X-Google-Smtp-Source: AMsMyM7kX49lKVt1xUXI2pYaAZ5BxYNYmf78+4OvUymQl4C3q2pE9zJ73jw/SIe98bBUePxmcVVEnQ==
X-Received: by 2002:a05:6512:32ab:b0:4a2:2e49:94c with SMTP id q11-20020a05651232ab00b004a22e49094cmr97808lfe.351.1665067066826;
        Thu, 06 Oct 2022 07:37:46 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id v11-20020a2ea60b000000b0026c36023a9asm1195007ljp.131.2022.10.06.07.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 07:37:45 -0700 (PDT)
Date:   Thu, 6 Oct 2022 17:37:39 +0300
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
Subject: [RFC PATCH v2 3/5] dt-bindings: iio: Add KX022A accelerometer
Message-ID: <80fa42040f385eb47f4f3c71b9b02f643a643e38.1665066397.git.mazziesaccount@gmail.com>
References: <cover.1665066397.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CWY5zw2XSqCeWUI7"
Content-Disposition: inline
In-Reply-To: <cover.1665066397.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CWY5zw2XSqCeWUI7
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
 .../bindings/iio/accel/kionix,kx022a.yaml     | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/kionix,kx02=
2a.yaml

diff --git a/Documentation/devicetree/bindings/iio/accel/kionix,kx022a.yaml=
 b/Documentation/devicetree/bindings/iio/accel/kionix,kx022a.yaml
new file mode 100644
index 000000000000..2919c436e46f
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/kionix,kx022a.yaml
@@ -0,0 +1,67 @@
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
+    maxItems: 2
+    items:
+      enum:
+        - INT1
+        - INT2
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

--CWY5zw2XSqCeWUI7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmM+6DMACgkQeFA3/03a
ocWRVwf8DNKB4bqBpETH0MNjmGKJ4869T8YSm8ERJ7lPTheLtM/xsoSPTDVFzvqW
Ie27FkJj5rDxinNZuv/lW0Xp8o4rUtJv0yInoUV8a/mYiAdSGclDZu43n/0hhHEU
LH3xbdRATQGOk9zLBuzAkWAyDWU9RBBgvJbmuAoDZT2RL7BZ7anepr40g+xRph3E
MYNj2fKmLHDuTPa07IjmBb/Y1DJo4XmngmJIH1Z34y08x6nqd3EPukRe9TZIiBT0
w+Z1RVL9Oe/BKDB+EQOsOyVPzi02Z8MYSt1OonZa2FqJKLhUl5YiEfxR9fHeKMqZ
FKxbOpOoLKaTkoNeLaOKcGSt2lYl2Q==
=adws
-----END PGP SIGNATURE-----

--CWY5zw2XSqCeWUI7--
