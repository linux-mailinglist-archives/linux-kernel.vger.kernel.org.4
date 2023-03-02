Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957D56A8083
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 11:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjCBK5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 05:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjCBK5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 05:57:45 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39CC3D939;
        Thu,  2 Mar 2023 02:57:43 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id n2so21517834lfb.12;
        Thu, 02 Mar 2023 02:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lCl9XoxGwy/DDzsLigivRQ3lZuvtC698+UDYy5GiLqA=;
        b=eLulg8Q7TeOjgjAuxSvCoW1Pt1S6LquLdEvwjoLALzrIYV65VS9NxEfNUUAKWh9RWK
         xgevj7CfddPmMunT/qJM9beBJfduXPw4vNfmpsWpgKGzFTGQ1JfNHXJdlqYXOb0Krx4m
         ZxFGzlCzBcLDtvKjDqQyTtxH+F4lJiSQQyuDWHeWc0mMpP5kI9VVftKgNb9/3GRkC4Zl
         Q1DmgGkrnAKcR769za2g3uUaApG0rMH10xWikevQcqeyOYSu1yddzNFI1LEQdQXqrQ0D
         7Vq2SxRhFUhLqNGTA/Nux/H2QKm2CMCl8GGErjkIwtZ/zE1tttMOqLmPpMjin3eG+p7W
         XhIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lCl9XoxGwy/DDzsLigivRQ3lZuvtC698+UDYy5GiLqA=;
        b=wGpMb0n8CbMJ/Fh3mUIkhlPCHB/9YB73g3eMUYrCKj7fK+2ar/fxu/Pu1+brE7xWm9
         bc3LlLn0v0K2L9qXYhjTeBKh4yrMMNz+XDVav7Qmm3RWtnO75oReyozey3RTicvrM1mU
         EYuSO+rBh5+uCM2OhlN2ewcnvaVVQEY+iFn7GDDTN4pzUuuoLvqRcQ5kOxIKz5f3kyRp
         1NgO5/FuGXNnRrE1omxfun4X/G2ssGR68GA7mw0fmZMeue9dIct+Nhf0UH276/2St9kW
         eEDRqdAZFPYJxRSH73jMn3PsS/2pMOaagrkesfynQlsc2703Zp91d5is4yVTTfXNgdEJ
         u6fg==
X-Gm-Message-State: AO0yUKW+77RoQIpFAvKqJWoYyyedz5xMHh7S/R5sOhOksQ0iKT+aZXK7
        nuuTSoX44wLCq1Z7dBe/oyg=
X-Google-Smtp-Source: AK7set8imEaw156sXSY8JpJHnsaHJpAY1hjWKQva1n38cdKNK7y0KddduGD1dLyovud9e7xXQdOKUg==
X-Received: by 2002:ac2:484e:0:b0:4b5:5ddc:da32 with SMTP id 14-20020ac2484e000000b004b55ddcda32mr2391092lfy.56.1677754661761;
        Thu, 02 Mar 2023 02:57:41 -0800 (PST)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id f19-20020a19ae13000000b004b50b4f63b7sm2085261lfc.170.2023.03.02.02.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 02:57:41 -0800 (PST)
Date:   Thu, 2 Mar 2023 12:57:37 +0200
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
Subject: [PATCH v2 1/6] dt-bindings: iio: light: Support ROHM BU27034
Message-ID: <87a8b787faf34cb217fc1ed892ebe7a1d7de9b7e.1677750859.git.mazziesaccount@gmail.com>
References: <cover.1677750859.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GsSIaOqWkwnXtkuc"
Content-Disposition: inline
In-Reply-To: <cover.1677750859.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GsSIaOqWkwnXtkuc
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

Changes since RFCv1:
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

--GsSIaOqWkwnXtkuc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmQAgSEACgkQeFA3/03a
ocXtnwgAs8Xy4QpHND2z5cVo5s0GrjJ8ekHTPho/EbcocCI1XjyGg5g7HVOQJhu6
mV7iqwrrcKSjQQCGKLwPIwFZedwr982innZ9b9XJ+YnpY4fYr5PIr6W0s95ijz94
+LZ7xV1MIUt1waRL4/pQwtAVWzzOlZKjzBIl2bTP7gLjSUDNXmCuObzG1y3On+w/
AA8RYIs3y+NSJq3iF7ACPnupOJxb45nFISiIsoESO2v9wja2HlTnHBFZYK8idgqO
3h2phmI1jgVz40tZJisAWcWNI8nz/kfFeK77D1KPasiMCPNH2eAPq8Jfzcg0z2ZD
oRBb8e0UT+wN7UxiI/30mkzmJXRe1g==
=RIY7
-----END PGP SIGNATURE-----

--GsSIaOqWkwnXtkuc--
