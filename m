Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F726D209E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 14:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbjCaMm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 08:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbjCaMmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 08:42:07 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A801B1D2E7;
        Fri, 31 Mar 2023 05:41:39 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id y15so28685035lfa.7;
        Fri, 31 Mar 2023 05:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680266498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5RXfhDfFvjtPIk75+oZKo+T1KCJFl4bnE8j/avAuUpQ=;
        b=Xbo6jv7LvpFVqc34eeViCWn/o2fTX/pXlB7+jEZepdeVHQV+g3VEhU+Y5Vg9C/EUen
         03MG9TqWi+Axb+9PXQwTOuBS15dWefhs9viJtVE2Q+rc4n3YxoDHQ1+Z/AL1RFj/NB+m
         QPeG+9QMSEdI1mgbo4sEJf8nRGAFhkbphWkBPAPgJfVmxKndGmTZL8GJR48aNXL2NTTY
         CweZpGl6rji3SLHnMtiJHKC0wTv/yghJbY0hbwOiqidTqFvw3whKKrZ0tKRxLIjAp3AA
         rcKi4Xw+WFMZoyRLOHWO/4e3miq337qtGZCBdZa5vAQWxqC4uSHexw0dSaeUEIGXSS04
         uTwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680266498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5RXfhDfFvjtPIk75+oZKo+T1KCJFl4bnE8j/avAuUpQ=;
        b=wHXSCa9s9pBwa1QGlkApnXFt4eDD+2NqPvmtx6KPbcQG9CiLqFj0JSVNNrnODWM5gt
         7gYa0dC/9RNrbe92NMfdYXfhG+D6mpIQ1KS8pcfm/4CS4y7bXILF4akHPvteld4dXtDC
         ntENkB4U0gBXbGzLIj0CuLmrmZCH3TGVtlY/AMbQSv8JR33A0RR4qIsCu5oTXacatlXw
         QtVL2RWjvu4p5SI9DVCxf0SL03wuidnA9vY37HkFQhUAfVK1VQLV3cXB8uU04EbrKFS3
         2d2XlbmHb1A+qi98hXDIMqaa0WkFiDLBPntiOuPwbs3ZBOR/1Q7AyUJx+s3SAXjmd9ta
         chKA==
X-Gm-Message-State: AAQBX9fJ+1ApXoY5lKwoKSzaq0crO/pQav9QKb+YIKni03A3W726QuFw
        fm94FwK+aWFP/e5S/9N9oPY=
X-Google-Smtp-Source: AKy350bys6f1/SG8QhrZ0G1WPPhf6AYJ/xGvdKMyaPKGQPWtOh2vvdN8qoVHZ0W2v8y/0XlIpKZXBA==
X-Received: by 2002:ac2:5239:0:b0:4dd:afad:8afe with SMTP id i25-20020ac25239000000b004ddafad8afemr7289258lfl.27.1680266497898;
        Fri, 31 Mar 2023 05:41:37 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id q14-20020ac24a6e000000b004e92c0ed7a0sm365340lfp.100.2023.03.31.05.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 05:41:37 -0700 (PDT)
Date:   Fri, 31 Mar 2023 15:41:33 +0300
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
Subject: [PATCH v7 3/5] dt-bindings: iio: light: Support ROHM BU27034
Message-ID: <66a222574176ee2adbfccf6d9a591c04571a18d9.1680263956.git.mazziesaccount@gmail.com>
References: <cover.1680263956.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9UB77LsSsgO7nXYn"
Content-Disposition: inline
In-Reply-To: <cover.1680263956.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9UB77LsSsgO7nXYn
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

--9UB77LsSsgO7nXYn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmQm1P0ACgkQeFA3/03a
ocU0PQgAppKU2NC+nRczBknSeeziuoXajOe7+oA4vHPZO20MGc9MZ7+DQ6FXY/fa
1vxDfbMl3hUj6SjLQn3CT92TpbLtWKHaNaQREFnLmT0MXoFZZhjt6zEK1JFCy+3l
RfcrNsUu4E6NmI83cDCZ30zMRmeb511vxyQoyYca3jixBmAOgqyBwCb2/mcItM51
GFPTGtjMhcWVGnRhF0SHcOTrmk891QgN4wK/Es9wmvVjk+OsUW3MxdpK1qYdDJor
jzGKFhEzRv8ELl4Gw5Tw27hK/8r2sDnKpWOKxjNYEl2cskgbNT7inF69GzIWA2p8
u5vuXN/mHBbVhYoSDUGcyHkK+9OfZw==
=9QDI
-----END PGP SIGNATURE-----

--9UB77LsSsgO7nXYn--
