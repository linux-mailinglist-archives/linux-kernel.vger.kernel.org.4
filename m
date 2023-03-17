Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698696BEB95
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 15:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjCQOnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 10:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjCQOnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 10:43:12 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56D8367C5;
        Fri, 17 Mar 2023 07:43:03 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id f16so5309222ljq.10;
        Fri, 17 Mar 2023 07:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679064182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ghmMfinFDDdTN92ApK4Yf07wpTrmYSX8BQBPIjw/BlY=;
        b=Rw4Z7OonWOm+/1aLHL0yAopg91Yj6Nk75pGuBl73xJuErQZp8AbYTMvPICA+G4NftH
         OV51IDbVPMV86jBf3nDDWS/YjPuxNkZ4ZaqCF8zsX7pv+Ysc49qLovWAo1xLaVIkqQqc
         ff6t8axPIboXtt2vusX5meHj9gfujmrHRaAvDERvLsSIb2i9ElpeCGffHxoDX0jrowZI
         5i017j+KCmdD+3qSyLGnVgKNwycaZ3XvTAa+243HYUHSepLg2rNvi+K/TkWcikqYentU
         7sGJlFnQ0PXPZi7qf741otX10tD8TzR4Q88lY/SDsoRp0e5M78AK77lwRGLDhGs9kLh7
         sXeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679064182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ghmMfinFDDdTN92ApK4Yf07wpTrmYSX8BQBPIjw/BlY=;
        b=s8WbZF7W7q9Rk+iWsHzPkfnUc3OF85JIEV99O3jcWAAkziws/rej7ZgCVEWfuaXzDh
         fSg17mx7n3dWHMxd2TrmYLT++Y191JEfLO7/UKGin9Jqu6SFKcs0y6EqEf/OjQxNKvW6
         r2RoocG3pBbTuBDezki29QhTRq30IjxidVBfVJt6fElMQqsQkSEIp9YN+MXcFfIzSTwM
         DTyE+5I0WWI3B9yV26880ULRJHeqh2609D9I5X0NJBe5aQ73VgnXiq477gxnEl32Cckv
         7fYW4QimLoKOzPkXBYhslVbpvgX3rs1lmK8dUn5mkHqNtYoKpmGlY8ojDKaOXegvGRFz
         NUqA==
X-Gm-Message-State: AO0yUKVdflT+RCd8bCfFqM5p+mdts/VFcdZR2foZALbH1sa99jGSkM8I
        zBfyG/ZgSvRdBEjDjAEEHq8=
X-Google-Smtp-Source: AK7set8Rnl2k70DUO2K+6qCdnN447e2my1s4zgfcx6/oAmQzvx0y6N8q3RkgvW3OKvc5nUsAUVAIrQ==
X-Received: by 2002:a05:651c:150a:b0:298:a164:590f with SMTP id e10-20020a05651c150a00b00298a164590fmr4426010ljf.45.1679064182065;
        Fri, 17 Mar 2023 07:43:02 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id s9-20020a2e2c09000000b00293d7c95df1sm437851ljs.78.2023.03.17.07.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 07:43:01 -0700 (PDT)
Date:   Fri, 17 Mar 2023 16:42:57 +0200
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/8] dt-bindings: iio: light: Support ROHM BU27034
Message-ID: <b76268e49d116fcd00b1ba63974e2bdff9f31b00.1679062529.git.mazziesaccount@gmail.com>
References: <cover.1679062529.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MP2Qmur0xHqWTD0n"
Content-Disposition: inline
In-Reply-To: <cover.1679062529.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MP2Qmur0xHqWTD0n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

ROHM BU27034 is an ambient light sesnor with 3 channels and 3 photo diodes
capable of detecting a very wide range of illuminance. Typical application
is adjusting LCD and backlight power of TVs and mobile phones.

Add dt-bindings.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---
v2 =3D>
- No changes

Changes since RFCv1 =3D> v2
- Fix binding file name and id by using comma instead of a hyphen to
  separate the vendor and part names.
---
 .../bindings/iio/light/rohm,bu27034.yaml      | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/rohm,bu2703=
4.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/rohm,bu27034.yaml =
b/Documentation/devicetree/bindings/iio/light/rohm,bu27034.yaml
new file mode 100644
index 000000000000..30a109a1bf3b
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/rohm,bu27034.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/rohm,bu27034.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ROHM BU27034 ambient light sensor
+
+maintainers:
+  - Matti Vaittinen <mazziesaccount@gmail.com>
+
+description: |
+  ROHM BU27034 is an ambient light sesnor with 3 channels and 3 photo diod=
es
+  capable of detecting a very wide range of illuminance. Typical applicati=
on
+  is adjusting LCD and backlight power of TVs and mobile phones.
+  https://fscdn.rohm.com/en/products/databook/datasheet/ic/sensor/light/bu=
27034nuc-e.pdf
+
+properties:
+  compatible:
+    const: rohm,bu27034
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells =3D <1>;
+      #size-cells =3D <0>;
+
+      light-sensor@38 {
+        compatible =3D "rohm,bu27034";
+        reg =3D <0x38>;
+        vdd-supply =3D <&vdd>;
+      };
+    };
+
+...
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

--MP2Qmur0xHqWTD0n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmQUfHEACgkQeFA3/03a
ocVJiwf/QboumHD0nWvLt8F5UN9bt5KO023XluK8eaCJf5GslPBFeZiOZFCYsn8H
qDA484vUdGgPMFBYS3pKPimczBzGrnhMyAqO65BFl3T0TOi139oJ3KMpliQt0C9G
4QbnVBjjn9e5brVheY10ogo1NqwU4+P9l0CYioj+bKCks0RWPIlMwnL8KDpHc8Az
76JbR7c2kn6KD5J9EtEqSA6yoXjuduRTbxKNJ1DwuJQjD/uHspsaX4HAxay6xR50
uBWsUj7WOCpznQ6HIWEUW7zwSQY/e3X9j5r1m12zLETdL/rTD81DKGjCy/bnI4fp
1VJnCp1IaP5viwpchrfp9S5vggLvCw==
=LERK
-----END PGP SIGNATURE-----

--MP2Qmur0xHqWTD0n--
