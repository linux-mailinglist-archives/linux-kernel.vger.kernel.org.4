Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265F56B37AA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 08:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbjCJHqV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 10 Mar 2023 02:46:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjCJHqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 02:46:03 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2882E38010;
        Thu,  9 Mar 2023 23:45:07 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id A37EB24E17F;
        Fri, 10 Mar 2023 15:45:05 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 10 Mar
 2023 15:45:05 +0800
Received: from williamqiu-virtual-machine.starfivetech.com (171.223.208.138)
 by EXMBX068.cuchost.com (172.16.6.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Fri, 10 Mar 2023 15:45:04 +0800
From:   William Qiu <william.qiu@starfivetech.com>
To:     <devicetree@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        William Qiu <william.qiu@starfivetech.com>,
        Hal Feng <hal.feng@starfivetech.com>
Subject: [PATCH v2 1/2] dt-bindings: PWM: Add StarFive PWM module
Date:   Fri, 10 Mar 2023 15:45:02 +0800
Message-ID: <20230310074503.155131-2-william.qiu@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230310074503.155131-1-william.qiu@starfivetech.com>
References: <20230310074503.155131-1-william.qiu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation to describe StarFive Pulse Width Modulation
controller driver.

Signed-off-by: William Qiu <william.qiu@starfivetech.com>
---
 .../bindings/pwm/starfive,jh7110-pwm.yaml     | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/starfive,jh7110-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/starfive,jh7110-pwm.yaml b/Documentation/devicetree/bindings/pwm/starfive,jh7110-pwm.yaml
new file mode 100644
index 000000000000..b66aa4b6eca8
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/starfive,jh7110-pwm.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/starfive,jh7110-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive PWM controller
+
+maintainers:
+  - William Qiu <william.qiu@starfivetech.com>
+
+description:
+  StarFive SoCs contain PWM and when operating in PWM mode, the PTC core generates
+  binary signal with user-programmable low and high periods. Clock source for the
+  PWM can be either system clockor external clock. Each PWM timer block provides 8
+  PWM channels.
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    const: starfive,jh7110-pwm
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  "#pwm-cells":
+    const: 3
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - resets
+
+additionalProperties: false
+
+examples:
+  - |
+    pwm@120d0000 {
+        compatible = "starfive,jh7110-pwm";
+        reg = <0x120d0000 0x10000>;
+        clocks = <&syscrg 121>;
+        resets = <&syscrg 108>;
+        #pwm-cells=<3>;
+    };
-- 
2.34.1

