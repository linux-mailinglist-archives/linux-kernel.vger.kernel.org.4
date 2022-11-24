Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A296E637F74
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 20:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiKXTOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 14:14:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiKXTOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 14:14:14 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74A587574;
        Thu, 24 Nov 2022 11:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1669317247; bh=A7+kRg9M9OJjUrVN+1XPzm8xYzLJxjTtaBFDySHGKIg=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=XKdzizcMj/O2kXKtKqgBCj872UihpKCmQ4RLJEuNI2lgqxHqzLUWfqVWBm6rbQ1kE
         TTe/ZMfYpvtUFrM0Etw8YEILZVRwAoDZxUd5yYABEqBvuby/pGqMNfLVPOGxyRTH4g
         paqtOdVX4x8fGwqoPcK+Qey9jZ7jZw7JqlzT46MFfh+X2ZW9sjAx/hIlT0oE689zsT
         uF7skhibkQL+LwLd0jFSbMhd0KZ1LY7MNODrI85uDlXLuK1zfea8cy436idIc3FGRH
         shLIMnMzpySWta4QPZzK8NEg8P+PAhIvMGzD9fxUuB/PZZiJNuertwJA9/yRzJ1sD6
         QZk4tfrPYhl7Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([95.223.44.31]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MDQeU-1ons4H1EKU-00AS86; Thu, 24
 Nov 2022 20:14:07 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-spi@vger.kernel.org, openbmc@lists.ozlabs.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 1/3] dt-bindings: spi: Add Nuvoton WPCM450 Flash Interface Unit (FIU)
Date:   Thu, 24 Nov 2022 20:13:58 +0100
Message-Id: <20221124191400.287918-2-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221124191400.287918-1-j.neuschaefer@gmx.net>
References: <20221124191400.287918-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ckIn9pSJN3WyPdbYcKFI7A6cVRRUearrUf0sPopHpbcINteKWjG
 omFY4zDNUITjwoTj7QLzl95Muz3yWfdgiVwPaxBQLPrcwNTMB/EDv2FriLlhZ6sSucYsWg0
 xLL+lzvpBuyjmZf4rwvRdU0MZZ7R2lHheIAz+rpcu6h5PuVUTkLeFt1BHwvyNJ/cF2zgImy
 +d5VlAe5ykNxCzM03aR6w==
UI-OutboundReport: notjunk:1;M01:P0:AU9B7Gf2Lr8=;Smh9J9Ev/mBdm6dZKHdLh0SLauO
 MBeaG822gFbmtFbpq6XAL2QpnAflSWXTeuWeNAGPF+Zo5LEEFye2aJDKYKIyuIQg/Ajw9Uqao
 vvDt3tSQ53JFWtjZcjeIDZj3gkG+d2bSa2JC5bmATR5PuhGgYHM1nye+TMrpctSwtitI0o1tA
 maUAJbSxPjTdzo/yXFYKufnWt89tqrMyc9vOMrvEv8QmfP1eBfg886p1MA0JMP5m0vHrf3On/
 +glG/HCUZljG9qq4Sn0YbZ97K7UMuUdLdFC1F7uKVXuzVElZ5WVCJEKJ5/jX05b9tB1zLJNKC
 EFFaZes8pXFPgqy70Dm7W16QkGiqibXcib+R00DtRFPZeUJ3h6/hgdqeWBQFS6Tr/EYUIksJn
 BZ6hVBuu13MevbylCSYt9mWpNLAwzTb5mZEhn67kG3vFaLspWuTR0dTLf0hj+YH0b8ssFdWzA
 uz+riMudVfR9s565eLtdJoaCqGGR/K0Km2rr4Z2ceUFrG0Mrhj902Rlltym2fJwbixA3WNu3J
 mlrjzeEu6ph4QmBS66wZip7hwUVjgmWAasps6Anfx9blyPD6GjzNWAbytoSknIqsDXqkMiDht
 xVmGXHqJoTCjBTyZ7I16EorO3LeeBBcQhPPOyJPGs8HWejhEiTSB9QgtWcQ+0KblrcmXF60T6
 XUi58vHff/aYKY350zt69PwYtXqS/E/b5p5lxu1bejsDFgZDddX9P4esmRnqPhs6GXkoA32V1
 2eosHzxl4BjSlb9GCpJjhLoCZai+95z+TxqnBkoQAO94nFpUnk7dEyOWNwnNkbOnN+ecAZMQb
 watOz/2FiMeWDkTNniSzPYKXCwynN+NjoFyUDOnNQAKFw+FhX6zhTQblHR416Q969XYPHPLX5
 teWgLpfSNNUHK3nT/Oeq3DI9fyR7+NYjzTLBgCofl9qg7kiBA60nyVaygVwAtumCI3s+95zZH
 uzn2Urqd25ag1E//yVZB0oJs38E=
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
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

v2:
- A few cleanups suggested by Krzysztof Kozlowski
- Simplify binding by making second reg item mandatory

v1:
- https://lore.kernel.org/lkml/20221105185911.1547847-4-j.neuschaefer@gmx.=
net/
=2D--
 .../bindings/spi/nuvoton,wpcm450-fiu.yaml     | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/nuvoton,wpcm450-=
fiu.yaml

diff --git a/Documentation/devicetree/bindings/spi/nuvoton,wpcm450-fiu.yam=
l b/Documentation/devicetree/bindings/spi/nuvoton,wpcm450-fiu.yaml
new file mode 100644
index 0000000000000..ef94803e75d90
=2D-- /dev/null
+++ b/Documentation/devicetree/bindings/spi/nuvoton,wpcm450-fiu.yaml
@@ -0,0 +1,66 @@
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
+  - $ref: /schemas/spi/spi-controller.yaml#
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
+      reg =3D <0xc8000000 0x1000>, <0xc0000000 0x4000000>;
+      #address-cells =3D <1>;
+      #size-cells =3D <0>;
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
=2D-
2.35.1

