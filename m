Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329E069F8C3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 17:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbjBVQOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 11:14:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbjBVQOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 11:14:39 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1415BBD;
        Wed, 22 Feb 2023 08:14:33 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id s22so10613433lfi.9;
        Wed, 22 Feb 2023 08:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l5JBDHjdN3MXwiI4IvjYTThifirf1TjzCClQnfsSE+U=;
        b=C4BKH4vzq1IF/vkpPcXc7b3H47gB9h+zS9yBv4/O8gLdjbjqoFn8PQJZgXhgmqakTC
         BpE3h/J0uiTvINLApNIwOethrvNsMtNikrgXePg+2LV0PMy/KxV/iw8da8FKuyVYk6aJ
         HFkFjM3BsXMFkr860SpA1ExHxyADvZTiWipbB6nm8Gk6zjfekwOslY8jtRgjkMiBO8h1
         2jOJ2bMMjrR4yXr6ecCqsElNCb2mI70NhUNCOpFJE/fEtlRP0ePAb/d2pWC7W50CLaPY
         0iIN1G8mIYd2/QdOpjkHiQ5ShGaMDXXoN8f0hcWs1Ag93sIq7z+AAZWXtx6ONpU6mlqZ
         VxiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l5JBDHjdN3MXwiI4IvjYTThifirf1TjzCClQnfsSE+U=;
        b=HoLQwuKUfEHNRzpljJUtYv/htr3/R/6RFIqRoI38pdbRyW/siMix+LPip7n6CiYYMU
         S9GLko0tWlcMMy5hgfwr8Fo1CV+pAzWIKgCZhQSvafy/uq6xjulYBV/uMtBoC35ltW8T
         CCfSZusqhvYa/NnUC3//iilrBZHel35V2rpCgCmyKQHSts10SFu2W5l2a6BNN4j4BM95
         4pflj3/rt7idD6cELRNwP5l44dlRGF6xIGnjxbAiVAIYepH3ED4fnMeU5Km8/xaycez6
         lFNQiojizIiDKXUeKAlzhAvRoxvcp7NUkC4PLmAKz82zduCsQkNF+TwjQl6yZQQDZugT
         BvGw==
X-Gm-Message-State: AO0yUKW4VP+TT1RpKDXwkvJ8snhUJpn9EkKTdhQeun4Mxizo0H/K1qLH
        /MVW9As8oUOlyhXRJooOJFk=
X-Google-Smtp-Source: AK7set/cyqYcHBeoYVP4mLuHnE2LUNKTG5gTdN+PU5U9ATeZRhRW5bSSbnQpK3fzyEOWvFXjATIhKg==
X-Received: by 2002:a19:c511:0:b0:4b5:90c5:281c with SMTP id w17-20020a19c511000000b004b590c5281cmr3400591lfe.19.1677082470939;
        Wed, 22 Feb 2023 08:14:30 -0800 (PST)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id y10-20020a19750a000000b004d885a44789sm2211833lfe.66.2023.02.22.08.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 08:14:30 -0800 (PST)
Date:   Wed, 22 Feb 2023 18:14:25 +0200
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Liam Beguin <liambeguin@gmail.com>,
        Peter Rosin <peda@axentia.se>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/6] dt-bindings: iio: light: Support ROHM BU27034
Message-ID: <af211ec180d91a13862630e635019ebe03d4be31.1677080089.git.mazziesaccount@gmail.com>
References: <cover.1677080089.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KlI1YUSxTXU2sZ4e"
Content-Disposition: inline
In-Reply-To: <cover.1677080089.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KlI1YUSxTXU2sZ4e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

ROHM BU27034 is an ambient light sesnor with 3 channels and 3 photo diodes
capable of detecting a very wide range of illuminance. Typical application
is adjusting LCD and backlight power of TVs and mobile phones.

Add initial dt-bindings.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 .../bindings/iio/light/rohm-bu27034.yaml      | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/rohm-bu2703=
4.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/rohm-bu27034.yaml =
b/Documentation/devicetree/bindings/iio/light/rohm-bu27034.yaml
new file mode 100644
index 000000000000..a3a642c259e8
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/rohm-bu27034.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/rohm-bu27034.yaml#
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

--KlI1YUSxTXU2sZ4e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmP2P2EACgkQeFA3/03a
ocXYSAf+MH8wn7LUv8X/Ec3EMtvD906qnmasjW3nu/K/Rs8dDvTJ9tjs1qoDpcxT
CcJd8v4seB/FtmGyt8EWZKugrXwTQTdDFUZ32CKj4iCSZ+7UWEEkTXjDirhKf41P
0jmbz2Af3zE21RgC8sT2z86MBf79U5EBI/D0aZOM1gQSi7eLM+9qIQeFZgohr7uY
cqQIaE1/N9srRFjAazJlTN7O6BPwSc5IWpjkT+UGYI0z5fijaClCXnuOA1X/BYQo
XYXyT0e5kr+12llFXb+vW1QqgWyAeWgq9gwrtFtQSE8QjjVcrokd+DcAvpjFe+2h
XYWBPpaZsVJhy2miITy/tHvRavL5eA==
=PsNl
-----END PGP SIGNATURE-----

--KlI1YUSxTXU2sZ4e--
