Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66848607605
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 13:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiJULWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 07:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiJULWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 07:22:02 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6BD4261429;
        Fri, 21 Oct 2022 04:21:58 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id x18so3291395ljm.1;
        Fri, 21 Oct 2022 04:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ff1Fq682tglQjFEQ/rqieCnCur14IRaiPmZgfb2AelY=;
        b=XHLvvmzXj37dVZagPb6YYIKoOd5wpMQ6+GBhmlRl2ZKrXQRsPNqBOXoSwvn60UtPJA
         NUDeILUT9Grntpu4Llh2phTOIS7rN21FNrVFgfWmLSmjwKdBgrsAVEA4QoJE3LmQosjc
         aHBe4NHvQgsfLkI0JWOdL83aoKW3J4rGWychQZ0TDRRDswpwqIoN7E3ZUay+K/FPmapx
         PappMSJ+rv9t045c6fA7aq3Dog4/+2NpX3SYLi+iO44BC+v4ckyHdafu+fHu8/ptvnVt
         aoJrmaot+Eed2pN1FDyv5Xd4QbkT/EUpqqRgzBqX/ekcu++kX6fqgFTFV2QR8uDbyiWe
         hCJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ff1Fq682tglQjFEQ/rqieCnCur14IRaiPmZgfb2AelY=;
        b=ip+DvW6ZuACutEuNwF3AVawclhgX4gJtzCdr1gkyGadBdOsdS/qYf5Rrkqpu/xFnyy
         EBIPgkuypQM7gnE/NUB8+95v5qeVCxApO9z9nMN0+//SyqiBjmGhJw+Y5TMYs8rwo/cQ
         0/pf9J/EkOefLhWjMe6VZD60oycH7rifaxfpF1MrC/No1mH8Ka07ZD4YH6djCInIiPBz
         STZLdM9tu+KC8MsipKhPrwOrCWTMJlidWVocPTnyj++BAD9auaYHBhHMUCHHlgsOUOTV
         ge05Z8r4VDIwlt3ZOYovIZ92XBC5kSFjUKd5ujvxKmms0EoPmlzJ5RKMg40Mi3CfyOt5
         4vBw==
X-Gm-Message-State: ACrzQf3Oydpqkpx5pcwFPkaKN+V2hBp8Y+UuADEswEwqC7Djoy51zZRc
        uEFdWVzxRkq3jAkKZ2uGQlY=
X-Google-Smtp-Source: AMsMyM6f8zbyDcV8HfSn/DBBK+Ilh0ts3mTJMAVMsXMXR1Y9djsI6TtgvCgCQMVz6eioC2jutIZA1A==
X-Received: by 2002:a2e:b80f:0:b0:26d:fd9d:6e29 with SMTP id u15-20020a2eb80f000000b0026dfd9d6e29mr7028798ljo.391.1666351316436;
        Fri, 21 Oct 2022 04:21:56 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyby-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::2])
        by smtp.gmail.com with ESMTPSA id t16-20020a056512209000b0048b26d4bb64sm3133368lfr.40.2022.10.21.04.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 04:21:55 -0700 (PDT)
Date:   Fri, 21 Oct 2022 14:21:51 +0300
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
Subject: [PATCH v4 1/3] dt-bindings: iio: Add KX022A accelerometer
Message-ID: <06f8e1ab29d02ed216db10091a269df4b6abad9a.1666350457.git.mazziesaccount@gmail.com>
References: <cover.1666350457.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="99ety+xxpEjg4OA2"
Content-Disposition: inline
In-Reply-To: <cover.1666350457.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--99ety+xxpEjg4OA2
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

--99ety+xxpEjg4OA2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmNSgM8ACgkQeFA3/03a
ocVazQgAn5La4AIWRiPkYF0fK3XCNbx/WiLpZT+/uLSn4Yb4MrjcZPSkKcGabT9d
QOanYvONREE5Bp5aTRcvQm6H+CHtROV3skvpJfy1EA6PlvWTeO4+fMeqqr2LuNav
SJsjDEGrdSPkbul6N99kqV7bFd9hwnwMQDl7ROcW+EqRYH82LFZvsxP7arZ4Pmab
MmrjcnLx79dmZ+JSIXr/3iNWo29Cewcb6k3ePFhqWPiBrQKz7GcamU3ya+mQs3CQ
i4cmzcT73wV578Yh34XNVtalNVhN4nOTXqiQvEKhxytUEgAbLUc098cb+9OR9MTW
VDFwGY4rX5+wWEG6cUYks0HRmHYpZA==
=iku/
-----END PGP SIGNATURE-----

--99ety+xxpEjg4OA2--
