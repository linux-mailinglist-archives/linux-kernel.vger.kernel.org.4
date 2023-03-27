Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8CE46CA25B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 13:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjC0L1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 07:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjC0L1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 07:27:43 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED4444B8;
        Mon, 27 Mar 2023 04:27:38 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id j11so10917599lfg.13;
        Mon, 27 Mar 2023 04:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679916458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OQC5OuYYB5bXTGsTSu+XARSUI0pqTHor1aKx4p1f4tg=;
        b=Q87CmO0tyG+0j+kCyK7VxNkBm77Qy3pEHP2bsbaBgcC5tLC1JHf5WYYrorV6wIWfsE
         S81ERDvbPWithU3KVVqyUCydJ2uLePIQJpX9qRgvr2GXS5CPAypnHBXdgnpoDkg74zj8
         CHHbUsA8+FoNanaPBRHEky9Mk2h9TlWvdVEvSx9ahhjk94HhCtPZkbqEU1Q3AIuUjTiP
         BJfGyvDcGxmJIxMfAjtf+2itagbG/wR/auJHombJ5uoZA4WPqZ1eVN6iVr7ajWZQTYJa
         X5oRx3DvlHBUaFtT2D0+EsQareS9nPpVc24V5j3IFyosT1ebPAkThWUkrTbOgwS46C9r
         mXfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679916458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQC5OuYYB5bXTGsTSu+XARSUI0pqTHor1aKx4p1f4tg=;
        b=SrBU+Nq6/OVW2mntn9MZYic9ivrahUxCzocW+ToZfSplWk08p91nbkKHD2kt85IP9O
         f8ozjIb9KOeyJc6QGwdPV9zs2EZQ1rNQvx65+RpX/OzmRtMeSYmM0PrZsvRTk3tAqvJF
         yg/TTigc5YlPDKoFvzFb1ZwzHPFPdiyZag/dtcSrsdJK9xM40ArNMnmy0xw+S2iCeztu
         SxoWZjZh5mZoRpZjr++IEHbyyphEVI/kF9ibu/xO7p3pqPlrz20eSMzPY70qQy5WvWsU
         tEXDg6g9L+L86b4rFFMkTOBxXp3bTXEt7uV6zWVW3Q5Lot+RjxKVkk5Vys7sSm2kFvpi
         MR0g==
X-Gm-Message-State: AAQBX9fSzjKRze988I99IoVcS9H8bVuRekF753DkmZnCfaiYZtNYbxdG
        +AZNKToZ1/Re7TYoyItuFOg=
X-Google-Smtp-Source: AKy350ZCeObX9MknMXFokduoANK1g/lvcMqZYUUdhRmo4XooTNwX9C4tmB1cZGiS6IG0eb0bHUOl6A==
X-Received: by 2002:ac2:5085:0:b0:4eb:d20:b2ad with SMTP id f5-20020ac25085000000b004eb0d20b2admr1515705lfm.63.1679916457757;
        Mon, 27 Mar 2023 04:27:37 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id e2-20020ac25462000000b004eaef4b51dasm2663450lfn.107.2023.03.27.04.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 04:27:37 -0700 (PDT)
Date:   Mon, 27 Mar 2023 14:27:33 +0300
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
Subject: [PATCH v6 1/7] dt-bindings: iio: light: Support ROHM BU27034
Message-ID: <8ae2e7ac3f2df981f5d424f4d1e5f2aa37020b7d.1679915278.git.mazziesaccount@gmail.com>
References: <cover.1679915278.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2GzT8EOhGp/ew666"
Content-Disposition: inline
In-Reply-To: <cover.1679915278.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2GzT8EOhGp/ew666
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

--2GzT8EOhGp/ew666
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmQhfaUACgkQeFA3/03a
ocWyNgf/fSKl1mtQ43s64s8dHSW7Jf5NV8QmBlp11KOfP1T3b7lQAA4z9Kit4cug
XbxozXhluvF8Vl9xCGLCgDYRooy6e/t+huWfPFj/VmNphPt6i+4msTJYqQsvTKRy
gtN+AfsA3CZX0LUyUNGcWgB91G0+3PlyfpP9S+dEPfS2oP3LVFzF2OILydbsQcv6
5u+n+Zp9ngPiZaBRkUeaU/e1LHvSUIvd73SSB72WI855KfDEb0yT24yNHtXI0WNy
+mwM1H2JCC1bExplCaG76IS55ywJTeB+zO7lbqBkiX2G81o822Cj404hQLO5NNeW
hB53jW4WTRaeipH6ZwblLgniQPXhDQ==
=KwB6
-----END PGP SIGNATURE-----

--2GzT8EOhGp/ew666--
