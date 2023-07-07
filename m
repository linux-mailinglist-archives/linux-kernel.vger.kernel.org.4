Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5495674AF99
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 13:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbjGGLW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 07:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232577AbjGGLW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 07:22:57 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264182116;
        Fri,  7 Jul 2023 04:22:53 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fbc0314a7bso2776821e87.2;
        Fri, 07 Jul 2023 04:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688728971; x=1691320971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S63gsi41nElgut5giYC5sHXmkcKRI+eEyk/xCvZ4vzU=;
        b=PI0eFmI9HOWwTMQIZgWUhEWSsyOCdhR9nlSIj/ZT4vA5K3OEf72r32yrJG8qrUUrH3
         kgWZdAcZJrjguHPDRqi1vvwiRSzqA2NyEU+WjIVv0pguY3P6DwmjMTPkKWkQ5vu6FdwX
         XafQbi4fp3dBvKybUJdxVsYvEma2+AzjrQ5YkbqgG0jMcFFp7x71bdUi+e+Z9ez5RSsS
         WiIRf0UHAY4kCehKGgRBd5ie1NTGLvXPeMSjeZXEZrZpLucJqbwJOT77DKirBsMw9sKf
         qVdvNoIUUEsAKPBgozA2IouxIUvCDSQepFODY+DBdmxwyW4RArzY0pF9lkp10sEZw25u
         WjTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688728971; x=1691320971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S63gsi41nElgut5giYC5sHXmkcKRI+eEyk/xCvZ4vzU=;
        b=G0hu9V0BuzZ95TesHy/frLi3O3zcZqp/sHf4mddfZZmT1uMzqrzIqbeMdpWMNr3PSX
         HYGZoiBWCIzx6dY0P4FSfi+ppF8HNHhRMJxFv5c83IxPbMa3QmgzOE5rKCcfiEaUyEnm
         G8MweclOGfrdxYsxAQbMSogHGqCWfqjq6QnBB1gKe6Cj53kLQFf8sFUzordx08nNt+jZ
         UwmobtDfvpN/1LkzQoc6FHf352xIFNGkYyQciV9iIfUvq7ctRFlxn3ATBh78ZEoxyE7J
         6xs8alECqjKGwzgofpBwhjyIbinJUIaP03ts67UmHLcpuzG7an4ka4HqIfOFvVw92tsX
         Ah5A==
X-Gm-Message-State: ABy/qLaBDoQodIc7xlRZNw+Kbu4J8ec0dPFSvUiARO4vr0UWxqGS4qK9
        Q7eXgYsDoMZeTfVTOmdMYZo=
X-Google-Smtp-Source: APBJJlGMQF74LWOpArnqyLQiE8MXRT/yHZ6i26veZJudiFy186T+yy8CJ4I8eAOKu3y7O3ihfR44og==
X-Received: by 2002:a05:6512:6c7:b0:4fb:8eec:ce47 with SMTP id u7-20020a05651206c700b004fb8eecce47mr4167458lff.58.1688728970968;
        Fri, 07 Jul 2023 04:22:50 -0700 (PDT)
Received: from dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::1])
        by smtp.gmail.com with ESMTPSA id b25-20020ac25e99000000b004fb75996493sm638537lfq.284.2023.07.07.04.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 04:22:50 -0700 (PDT)
Date:   Fri, 7 Jul 2023 14:22:46 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindings: iio: ROHM BU27010 RGBC + flickering
 sensor
Message-ID: <7b2bb4647be8ff7c551d8efcbe160914bceee669.1688723839.git.mazziesaccount@gmail.com>
References: <cover.1688723839.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aOYtKi0o323/xUOC"
Content-Disposition: inline
In-Reply-To: <cover.1688723839.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aOYtKi0o323/xUOC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ROHM BU27010 is a sensor with 6 photodiodes (red, green, blue, clear,
IR and flickering detection) with five configurable channels. Red, green
and flickering detection being always available and two out of the rest
three (blue, clear, IR) can be selected to be simultaneously measured.
Typical application is adjusting LCD/OLED backlight of TVs, mobile phones
and tablet PCs.

Add binding document for ROHM BU27010.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
v1 =3D> v2:
  - Drop trailing blank line
  - Require VDD-supply
  - Fix subject prefix
---
 .../bindings/iio/light/rohm,bu27010.yaml      | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/rohm,bu2701=
0.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/rohm,bu27010.yaml =
b/Documentation/devicetree/bindings/iio/light/rohm,bu27010.yaml
new file mode 100644
index 000000000000..8376d64a641a
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/rohm,bu27010.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/rohm,bu27010.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ROHM BU27010 color sensor
+
+maintainers:
+  - Matti Vaittinen <mazziesaccount@gmail.com>
+
+description: |
+  The ROHM BU27010 is a sensor with 6 photodiodes (red, green, blue, clear,
+  IR and flickering detection) with five configurable channels. Red, green
+  and flickering detection being always available and two out of the rest
+  three (blue, clear, IR) can be selected to be simultaneously measured.
+  Typical application is adjusting LCD/OLED backlight of TVs, mobile phones
+  and tablet PCs.
+
+properties:
+  compatible:
+    const: rohm,bu27010
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  vdd-supply: true
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
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
+        compatible =3D "rohm,bu27010";
+        reg =3D <0x38>;
+      };
+    };
--=20
2.40.1


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

--aOYtKi0o323/xUOC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmSn9YYACgkQeFA3/03a
ocUmfwf+KIdo5sbPTLGyFb3LbbDMLtJRE1wNMeMQvsJz6egqNi2BqmXunUSZJV8J
4VONhjcPYyOwqeGSsUHWHH3oZHZk8TOFDLIj+ewgkbfmj60nwxc5Rx/3Geb57PvF
TMTQV5txTksg2aH1D1kKU/ADgB9jNmcsrqCH1rHJwxPSZgZlOhlHaAJ6/d6jOEOp
Q/cQo/Bfm597CTb/Yk90NawdnLP6C+wrnC0A54evpxO7eiYYTyM1Jd5tPQ3NN8RK
v/Uzl3H7I/MbQCA1Nx8piHcA4uMzm/mha9/P89q7ocd2WgmVmwnQPsyFZK4jZk3Y
7HHjKGIGKLqbCTOKi6I4VgzCISCDUA==
=1AwT
-----END PGP SIGNATURE-----

--aOYtKi0o323/xUOC--
