Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 651EB6AB97A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 10:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjCFJQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 04:16:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjCFJQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 04:16:12 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF77322A34;
        Mon,  6 Mar 2023 01:16:01 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id n2so11730184lfb.12;
        Mon, 06 Mar 2023 01:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678094160;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KlYsQ3RJ0RNf4tdciuB9SdK/fWEcM/do33YmLelo7IA=;
        b=PbHWelD2MQstx1Wkle0mzLF/H2GXIcYrkNEQlkmbEEBGJSvruIcLOyedfPGuZEiWRY
         qCJLhvG1JAY8rYw9iPB/Oa7wZayH9L1lLc/NHk0QcLGAk1jGXU8mRmZuAY46cz2tIAoo
         wBS4uqW2mkdr2T8q+Lfo9OELxh6V9qhdNPmaET5GZIt/cn0+jGUPlpcd647E2zITrXXq
         +8OB9P4szy+w7IpFJNKLsxs+7aL3S3jEhJULqH5YAEcVRnGJdzk487rOpF1cqSkY7pOp
         RM2oxtAk9Z/ijgUDF12EV4wpOIVhfulBEkR4ST7FdLECY17SbE6FqPQ3D2q/oc+ZT9Sc
         QjxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678094160;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KlYsQ3RJ0RNf4tdciuB9SdK/fWEcM/do33YmLelo7IA=;
        b=cRGMIRVAyyfW4WsVWAYtMvKzBGia9ascsWsxsoZGCFrgrRdOiaHgGtPhLNI2lTAYAh
         NzFbUv0KN3UzqavoSPPHVQ1UKNG0TpA9UpiRQxRp525A9H8AhgOvmq00Tj6dMhmSsklK
         BXZTXhem3giW9QCymXgd4eBrqcq7lYUCQtCHehWd6WoH3WGFOW5bc/Bs5aS8oAor3HAZ
         LN42KLAXRmdxmvPVWvs0XPWBh5R4jlqFj+fNH49Pyflj7wfI98pz6qcRxvJFSLulcxNJ
         z/tmhbf20YjbLHD9tZGMaO0cgftANAWq8Y7tTazFeCkWiMKiWLcSnMp4Bq1qOFdmCEWp
         3fOg==
X-Gm-Message-State: AO0yUKWF32BMobaZDNJwNM0s/oI5IqQcvm90EaqruTqg4vkQdqL3+f70
        8/w68mOdo64lGVNuXEMDIn6Worzz6tE=
X-Google-Smtp-Source: AK7set/7qZ5VbxQ+AbyIchnudb72C098R7isLPhBZtr3WABxooas1T5uaw3wIPkNhu/5v2v4s4TZUQ==
X-Received: by 2002:ac2:4c2e:0:b0:4e0:ee54:fa25 with SMTP id u14-20020ac24c2e000000b004e0ee54fa25mr2952416lfq.20.1678094160152;
        Mon, 06 Mar 2023 01:16:00 -0800 (PST)
Received: from dc75zzyyyyyyyyyyyyydy-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyydy-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::6])
        by smtp.gmail.com with ESMTPSA id i27-20020a056512007b00b004db0d26adb4sm1417940lfo.182.2023.03.06.01.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 01:15:59 -0800 (PST)
Date:   Mon, 6 Mar 2023 11:15:53 +0200
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
Subject: [PATCH v3 1/6] dt-bindings: iio: light: Support ROHM BU27034
Message-ID: <0b31bbc3d4afa2663a83f08bd77ee2b20f677def.1678093787.git.mazziesaccount@gmail.com>
References: <cover.1678093787.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4HFgpxBb6NqVEr/y"
Content-Disposition: inline
In-Reply-To: <cover.1678093787.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4HFgpxBb6NqVEr/y
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

--4HFgpxBb6NqVEr/y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmQFr0kACgkQeFA3/03a
ocV1vAgAmalrbKKA5F3ractzpAwDTYfI/hTJNHaPemDsZWaJfGNNCCt0XiIw++Br
NWThdcLSPFJAMRftPaCDUTcme92bkGW+IJDXynkHuz4WiGVMEC0YxvylNvtyaPW2
n+yv61rx7ekWfGtVy1V1Uac0IcVm6I896nElXA1obXo0S/hMK6ZhfSvrYi0pOGll
+lIw0RwHczcd+LZ+Y7hTVnXtwmt8KSaXLl/0/d8l2HDKqolIIqLuSADm4qTFEAnt
gVdEIyedj63hyzyFWW/sPASObb6V234MeRBiLQmvwWDF7Ga+L8UgTmQKw5BGHfzt
QizkdA7cDB23O4mZiC7XX0I5FhHO8g==
=G833
-----END PGP SIGNATURE-----

--4HFgpxBb6NqVEr/y--
