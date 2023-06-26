Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5DB873DCEE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 13:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjFZLJh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 26 Jun 2023 07:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjFZLJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 07:09:22 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FABEBE;
        Mon, 26 Jun 2023 04:09:19 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id B713324E26A;
        Mon, 26 Jun 2023 19:09:13 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 26 Jun
 2023 19:09:13 +0800
Received: from ubuntu.localdomain (113.72.146.167) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 26 Jun
 2023 19:09:12 +0800
From:   Hal Feng <hal.feng@starfivetech.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        "Walker Chen" <walker.chen@starfivetech.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Hal Feng <hal.feng@starfivetech.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 3/5] ASoC: dt-bindings: Add StarFive JH7110 PWM-DAC controller
Date:   Mon, 26 Jun 2023 19:09:07 +0800
Message-ID: <20230626110909.38718-4-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230626110909.38718-1-hal.feng@starfivetech.com>
References: <20230626110909.38718-1-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.146.167]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for the PWM-DAC controller on the JH7110
RISC-V SoC by StarFive Ltd.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 .../sound/starfive,jh7110-pwmdac.yaml         | 76 +++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/starfive,jh7110-pwmdac.yaml

diff --git a/Documentation/devicetree/bindings/sound/starfive,jh7110-pwmdac.yaml b/Documentation/devicetree/bindings/sound/starfive,jh7110-pwmdac.yaml
new file mode 100644
index 000000000000..91a4213f2bd8
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/starfive,jh7110-pwmdac.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/starfive,jh7110-pwmdac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JH7110 PWM-DAC Controller
+
+description: |
+  The PWM-DAC Controller uses PWM square wave generators plus RC filters to
+  form a DAC for audio play in StarFive JH7110 SoC. This audio play controller
+  supports 16 bit audio format, up to 48K sampling frequency , up to left
+  and right dual channels.
+
+maintainers:
+  - Hal Feng <hal.feng@starfivetech.com>
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    const: starfive,jh7110-pwmdac
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: PWMDAC APB
+      - description: PWMDAC CORE
+
+  clock-names:
+    items:
+      - const: apb
+      - const: core
+
+  resets:
+    maxItems: 1
+    description: PWMDAC APB
+
+  dmas:
+    maxItems: 1
+    description: TX DMA Channel
+
+  dma-names:
+    const: tx
+
+  "#sound-dai-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - resets
+  - dmas
+  - dma-names
+  - "#sound-dai-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    pwmdac@100b0000 {
+        compatible = "starfive,jh7110-pwmdac";
+        reg = <0x100b0000 0x1000>;
+        clocks = <&syscrg 157>,
+                 <&syscrg 158>;
+        clock-names = "apb", "core";
+        resets = <&syscrg 96>;
+        dmas = <&dma 22>;
+        dma-names = "tx";
+        #sound-dai-cells = <0>;
+    };
-- 
2.38.1

