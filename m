Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B805EFC4B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 19:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233884AbiI2RwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 13:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233758AbiI2RwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 13:52:09 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3EDC146617;
        Thu, 29 Sep 2022 10:52:05 -0700 (PDT)
X-QQ-mid: bizesmtp91t1664473914tqedou0x
Received: from localhost.localdomain ( [113.72.145.157])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 30 Sep 2022 01:51:52 +0800 (CST)
X-QQ-SSF: 01000000002000303000B00A0000000
X-QQ-FEAT: VNWd8gjdZNrqI5XK6Kpr9+wOXo7z2LCerXVK3EG7K1PrQ9eL9Yo0lIQ1X455d
        +QCfpwb4krugRfeHjrMBw3J9dYDmRV051+HzuyyUOeL6ikLghpR8ZVj27J+eLe72XcJLtx8
        U3RGu8pFKqxZ9aNuaNASRqNeDF21ucsHd3lYMkBCYxKP2zyjg0BTIWOUIsdNGUT1iEtHCQn
        ukEIWjC0XUaQalLCz+ENi2ak3qzKD7PTxlfUYO7amCJXrvLjBwfLiMU0QQaucmiLXIQtSsA
        End+Lzg4nxYrtbGOGUGZ35ymYjWjoIa9y9JEIwSD0eNj1CeUBamf1ToLnh5jU+0kWfi+8Ex
        yeXbaom0+4xNG8SgRjYuIjQbFbgIShVQc8JJk5MhGwEw8nBxXokb0bL7ShivY2O8PUOXxmx
        mTLSNoSZc3s=
X-QQ-GoodBg: 0
From:   Hal Feng <hal.feng@linux.starfivetech.com>
To:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Hal Feng <hal.feng@linux.starfivetech.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 12/30] dt-bindings: reset: Add starfive,jh7110-reset bindings
Date:   Fri, 30 Sep 2022 01:51:47 +0800
Message-Id: <20220929175147.19749-1-hal.feng@linux.starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
References: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:linux.starfivetech.com:qybglogicsvr:qybglogicsvr2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for the reset controller on the JH7110 RISC-V
SoC by StarFive Technology Ltd.

Signed-off-by: Hal Feng <hal.feng@linux.starfivetech.com>
---
 .../bindings/reset/starfive,jh7110-reset.yaml | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/starfive,jh7110-reset.yaml

diff --git a/Documentation/devicetree/bindings/reset/starfive,jh7110-reset.yaml b/Documentation/devicetree/bindings/reset/starfive,jh7110-reset.yaml
new file mode 100644
index 000000000000..bb0010c200f9
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/starfive,jh7110-reset.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reset/starfive,jh7110-reset.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JH7110 SoC Reset Controller Device Tree Bindings
+
+maintainers:
+  - Emil Renner Berthing <kernel@esmil.dk>
+  - Hal Feng <hal.feng@linux.starfivetech.com>
+
+properties:
+  compatible:
+    enum:
+      - starfive,jh7110-reset
+
+  "#reset-cells":
+    const: 1
+
+  starfive,assert-offset:
+    description: Offset of the first ASSERT register
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  starfive,status-offset:
+    description: Offset of the first STATUS register
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  starfive,nr-resets:
+    description: Number of reset signals
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+required:
+  - compatible
+  - "#reset-cells"
+  - starfive,assert-offset
+  - starfive,status-offset
+  - starfive,nr-resets
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/reset/starfive-jh7110.h>
+
+    syscrg_rst: reset-controller@13020000 {
+        compatible = "starfive,jh7110-reset";
+        #reset-cells = <1>;
+        starfive,assert-offset = <0x2F8>;
+        starfive,status-offset= <0x308>;
+        starfive,nr-resets = <JH7110_SYSRST_END>;
+    };
+
+...
-- 
2.17.1

