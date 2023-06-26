Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F6873DCEB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 13:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjFZLJ3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 26 Jun 2023 07:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjFZLJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 07:09:20 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98C3E1;
        Mon, 26 Jun 2023 04:09:18 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 05EF924DE30;
        Mon, 26 Jun 2023 19:09:12 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 26 Jun
 2023 19:09:12 +0800
Received: from ubuntu.localdomain (113.72.146.167) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 26 Jun
 2023 19:09:11 +0800
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
Subject: [PATCH v1 1/5] ASoC: dt-bindings: Add StarFive JH7110 dummy PWM-DAC transmitter
Date:   Mon, 26 Jun 2023 19:09:05 +0800
Message-ID: <20230626110909.38718-2-hal.feng@starfivetech.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for StarFive JH7110 dummy PWM-DAC transmitter.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 .../sound/starfive,jh7110-pwmdac-dit.yaml     | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/starfive,jh7110-pwmdac-dit.yaml

diff --git a/Documentation/devicetree/bindings/sound/starfive,jh7110-pwmdac-dit.yaml b/Documentation/devicetree/bindings/sound/starfive,jh7110-pwmdac-dit.yaml
new file mode 100644
index 000000000000..bc43e3b1e9d2
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/starfive,jh7110-pwmdac-dit.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/starfive,jh7110-pwmdac-dit.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JH7110 Dummy PWM-DAC Transmitter
+
+maintainers:
+  - Hal Feng <hal.feng@starfivetech.com>
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    const: starfive,jh7110-pwmdac-dit
+
+  "#sound-dai-cells":
+    const: 0
+
+  sound-name-prefix: true
+
+required:
+  - compatible
+  - "#sound-dai-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    pwmdac-dit {
+        compatible = "starfive,jh7110-pwmdac-dit";
+        #sound-dai-cells = <0>;
+    };
+
+...
+
-- 
2.38.1

