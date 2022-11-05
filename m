Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B573161DD6B
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 19:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiKES7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 14:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiKES7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 14:59:30 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D052717;
        Sat,  5 Nov 2022 11:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1667674763; bh=0zlGVmWFUJWAxvnZusk8TMaPc0CG35sV5kM6R3yKrvQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Z9sT2LWsbOVZ0gISJr2OamL1OHDHt0LHMzUhGvXkZ7CIJwhcuCk4Vqx3sNrCvOEIF
         BjGRMCAY8ekPr4mpqE8oAaiyvMzcjX4Mjcw4IAFOwWOQDgFsC3uNiKVZ+fSzTn2ViP
         jlxKdbGWYCOXh7js05ZRiCq1FxcpAX+4Vvp6HVCfSzBLezO4oja2kRfRBRF0cixx1j
         eFVpR9VntQoCRXdEemXJgKUUy+Y9/3SvozOQQNRqRFUuHFNCdiqRM53d1KYQXUBmpC
         RdJ/Yw9d9+m6Hq70OaCd8Z/ws3mvp0Pl8yeCWW604NHcQJbJ652irDKk7uvL2olSS5
         xxewg8QnXXotw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([87.78.44.193]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M3DNt-1osmUp3DC9-003cZd; Sat, 05
 Nov 2022 19:59:22 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-spi@vger.kernel.org, openbmc@lists.ozlabs.org
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: [PATCH 3/8] dt-bindings: spi: Add Nuvoton WPCM450 Flash Interface Unit (FIU)
Date:   Sat,  5 Nov 2022 19:59:06 +0100
Message-Id: <20221105185911.1547847-4-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221105185911.1547847-1-j.neuschaefer@gmx.net>
References: <20221105185911.1547847-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4mhJHiA7uzMLYJ28yXXBf74eXRxCJyYO5pHRgHTydKeBdEX8Xng
 jKj6nr7av4t9KvdfbSaYqoC3m8aehbRPG7urF+6tCT5rfmaaWOdhonv92WnicRVsm/GbOLf
 7itL2tJ/L/HFZJjH9ah3OR0WI+V4DNBD/FbE7pEwRgZ4mfbf1X88XnS6xrwVUTnrrbgqtcS
 Qgyh3Tesm9geoyrBpkP9Q==
UI-OutboundReport: notjunk:1;M01:P0:MmDo+WVVpq4=;yqWimBjtK0/euTlSj8+VYUx4t1y
 AjazQdJ3cov+i4w0b9Gg+zq589JFK2Bj0jg61kS7n4VXyzrvO0Na/Q366ZYVTclXXldEtFfmm
 1YBa3b14OMfyL/GDQfCTZwckWFclfhTqOLXfmjuVhM/+OJanN0JiEQITYiN7XGX1Uwdv0L637
 jAN81dS6UPmo7h6uwZpxsmlpVjbJ9nOVGN1/MpAmDFCn7abEYEcWNRUzEp+bWauk2/P2qWGun
 WGnYAVl6wGLLjT34DfP6eNfvyFIUAZPC+4wL2VHjV8EHg6j2HIgyHIxBbrQrpTmg4jsrbKAzV
 oLjx8lEZ5MBRHyojqoDLF6F7iEOHG2KX75EUBYUm6PVHvvRz0P1oWhPeVaUoH8btnkPLOjEyW
 GHXLIhKqxaghjaFdLkIzQbBQCsA3me8wjFFB36k/YOkQBegkkYxtOGwiyX1P4VTxM25F3XeeZ
 HY65++p2HYQICeB1VlbLSKcDOHad+3CzkzJwuAII8s0VCUvAnD2Nxhm2qaj7V95zJ2S4ixz0E
 HOtQwyOJgCcEOp0IGMcqOMcOi5oODq8tVNWEtN69HQl9Us81kK7F45DKt+EGlgdJU+vf3QJ5B
 nuczmjLXWS8bLne8x2EJMs0ajDMokB/evw5ZiNN0kEs2af5dKokEaLP/GsVgAgHykJQlNXGh1
 03mWs8vUqxGuNQBOK6vn1ubFj+pEtFz9X53Y+1Ik2HmbkJCqxug/qQZwdauzlq2nIartKE5v0
 mJgg9DUODgbAdJ6jQVPk2XQ2ktpEWZ3o8yzb3PExP3JCdNyl1stsNVDDu79rUYMgGvaTzM5TA
 t12QYCheXgpRmi61yk6g+MovRsxKQHVrII+56O7u7WFLFvELClRmfsFiKYpXkOaGKJpaE80tq
 s0b1hk1ZQmGMRBoT9XV2ouCbZBjZtNu+M5VK8wExT0P9td+glPjyV+zaKWug9AL6Cgh3A7ENz
 +WdSZg==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Flash Interface Unit (FIU) is the SPI flash controller in the
Nuvoton WPCM450 BMC SoC. It supports four chip selects, and direct
(memory-mapped) access to 16 MiB per chip. Larger flash chips can be
accessed by software-defined SPI transfers.

The FIU in newer NPCM7xx SoCs is not compatible with the WPCM450 FIU.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 .../bindings/spi/nuvoton,wpcm450-fiu.yaml     | 76 +++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/nuvoton,wpcm450-=
fiu.yaml

diff --git a/Documentation/devicetree/bindings/spi/nuvoton,wpcm450-fiu.yam=
l b/Documentation/devicetree/bindings/spi/nuvoton,wpcm450-fiu.yaml
new file mode 100644
index 0000000000000..dc0ea2184f8d0
=2D-- /dev/null
+++ b/Documentation/devicetree/bindings/spi/nuvoton,wpcm450-fiu.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/nuvoton,wpcm450-fiu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton WPCM450 Flash Interface Unit (FIU)
+
+maintainers:
+  - Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
+
+allOf:
+  - $ref: "/schemas/spi/spi-controller.yaml#"
+
+properties:
+  compatible:
+    const: nuvoton,wpcm450-fiu
+
+  reg:
+    items:
+      - description: FIU registers
+      - description: Memory-mapped flash contents
+
+  reg-names:
+    items:
+      - const: control
+      - const: memory
+    minItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  nuvoton,shm:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: a phandle to the SHM block (see ../arm/nuvoton,shm.yaml)
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/nuvoton,wpcm450-clk.h>
+    spi@c8000000 {
+      compatible =3D "nuvoton,wpcm450-fiu";
+      #address-cells =3D <1>;
+      #size-cells =3D <0>;
+      reg =3D <0xc8000000 0x1000>, <0xc0000000 0x4000000>;
+      reg-names =3D "control", "memory";
+      clocks =3D <&clk WPCM450_CLK_FIU>;
+      nuvoton,shm =3D <&shm>;
+
+      flash@0 {
+        compatible =3D "jedec,spi-nor";
+      };
+    };
+
+    shm: syscon@c8001000 {
+      compatible =3D "nuvoton,wpcm450-shm", "syscon";
+      reg =3D <0xc8001000 0x1000>;
+    };
+
+  - |
+    #include <dt-bindings/clock/nuvoton,wpcm450-clk.h>
+    spi@c8000000 {
+      compatible =3D "nuvoton,wpcm450-fiu";
+      // the "memory" resource may be omitted
+      reg =3D <0xc8000000 0x1000>;
+      reg-names =3D "control";
+    };
=2D-
2.35.1

