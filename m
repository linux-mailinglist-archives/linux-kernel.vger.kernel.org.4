Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4ED568978C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 12:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbjBCLOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 06:14:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbjBCLOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 06:14:38 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277508FB6F;
        Fri,  3 Feb 2023 03:14:37 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 172631C001B;
        Fri,  3 Feb 2023 11:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1675422875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ge7sHeo6XljC/uKf8NYIO4UCkI+QIvq5OQ52h7yZfUg=;
        b=UbXmpiwIu3ZB6+OqqIWbGfPOjGbwGfKL7KdYSW+SquC2V9jkSdxG2VQr36U0xLtXJiaCCk
        JPkt1o9C1KOTlid8qdIFFC9lY6wh1pRvaru66d2cKX+5TkWj3qZQ6N2tEYNwEHd+mSd4SD
        iBC8b8U7B4vjHQA75eRogPEumGJPiGirVL+jb0P60e1AomONNedYXVHEKDALaKTp0euAqb
        H1C5FQ68496XDVXAHxMPc9UM1pESp1GEtmm+BAtdjKXtRnW1FhttXF06RKqwPfVcybzDIt
        241ZpWs6fGx78aYg6F0dDm0HSONM1ss1dtweSpC1wW848jNZ4ZRLNDSShXF8vg==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 1/3] dt-bindings: sound: Add the Renesas X9250 potentiometers
Date:   Fri,  3 Feb 2023 12:14:20 +0100
Message-Id: <20230203111422.142479-2-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230203111422.142479-1-herve.codina@bootlin.com>
References: <20230203111422.142479-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Renesas X9250 is a quad digitally controlled potentiometers.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 .../bindings/sound/renesas,x9250.yaml         | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/renesas,x9250.yaml

diff --git a/Documentation/devicetree/bindings/sound/renesas,x9250.yaml b/Documentation/devicetree/bindings/sound/renesas,x9250.yaml
new file mode 100644
index 000000000000..ad29ef465a18
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/renesas,x9250.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/renesas,x9250.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas X9250 quad potentiometers
+
+maintainers:
+  - Herve Codina <herve.codina@bootlin.com>
+
+description: |
+  The Renesas X9250 is a quad digitally controlled potentiometers.
+
+  In the audio path, it can be present on amplifiers designs and it can be used
+  in ALSA as an auxiliary audio device to control these amplifiers.
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    const: renesas,x9250
+
+  reg:
+    description:
+      SPI device address.
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 2000000
+
+patternProperties:
+  "^renesas,cmd[0-3]-invert$":
+    description:
+      The related command is inverted meaning that the minimum command value
+      set the wiper to Rh and the maximum command value set the wiper to Rl.
+      Without this property, the minimum command value set the wiper to Rl and
+      the maximum to Rh.
+    type: boolean
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        x9250@0 {
+            compatible = "renesas,x9250";
+            reg = <0>;
+            spi-max-frequency = <2000000>;
+            renesas,cmd3-invert;
+        };
+    };
-- 
2.39.0

