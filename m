Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C31B73DAFA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 11:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjFZJOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 05:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjFZJNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 05:13:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D23D1;
        Mon, 26 Jun 2023 02:11:38 -0700 (PDT)
Date:   Mon, 26 Jun 2023 09:11:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687770697;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I2ekPGZx4yrFXTeInvVwLDdUQShBzF0h2p1JV7OJ41o=;
        b=J00GZvzIKlnsJwL/1MKB/gXwxzuWPGZU9KDQZ2VHCV7re2T03Dxm1alN2MT06zp/pEobPU
        kcIO7tmo9gPiDUWFSz7LNt6EdyaCKAedrCQMaQfmFf0/2sEmLpZ3LhPBoXpJH34Hh0ftFj
        lmPO+Gr/H/mBM9Uks4LA0sKHr5bIIwrqeN/X9QRM9AGKJkxibYv0hped3yzaoNXyWeZZyk
        YEpPGYiq+XhH1eK8QdYqEBV0runwVYEoGIMTo22acQgUdggEH9fIRDzx0QipDOfOoW+ydk
        TxqKQg3FBvgJCAlg3jVzDihO1MoJ8YyvjebHF1ksdGmHr1o4NCj7ir18TDVgTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687770697;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I2ekPGZx4yrFXTeInvVwLDdUQShBzF0h2p1JV7OJ41o=;
        b=KjfrVVN6hLi9D96Q8f9XY66HdZscFJHn82T5Bi87IF8OA2k7vKK3SQvPH1xZmMlOrxv50J
        +q0PX46D4o17DtCQ==
From:   "tip-bot2 for Stanislav Jakubek" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] dt-bindings: timer: brcm,kona-timer: convert to YAML
Cc:     Stanislav Jakubek <stano.jakubek@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230618144635.GA22166@standask-GA-A55M-S2HP>
References: <20230618144635.GA22166@standask-GA-A55M-S2HP>
MIME-Version: 1.0
Message-ID: <168777069704.404.13055618719527078493.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     038d454ad996a5e275d46188d65d890d2a243f36
Gitweb:        https://git.kernel.org/tip/038d454ad996a5e275d46188d65d890d2a243f36
Author:        Stanislav Jakubek <stano.jakubek@gmail.com>
AuthorDate:    Sun, 18 Jun 2023 16:46:35 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 23 Jun 2023 09:33:43 +02:00

dt-bindings: timer: brcm,kona-timer: convert to YAML

Convert Broadcom Kona family timer bindings to DT schema.

Changes during conversion:
  - drop deprecated compatible (it's been deprecated for ~10 years)

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20230618144635.GA22166@standask-GA-A55M-S2HP
---
 Documentation/devicetree/bindings/timer/brcm,kona-timer.txt  | 25 +---
 Documentation/devicetree/bindings/timer/brcm,kona-timer.yaml | 52 +++++++-
 2 files changed, 52 insertions(+), 25 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/timer/brcm,kona-timer.txt
 create mode 100644 Documentation/devicetree/bindings/timer/brcm,kona-timer.yaml

diff --git a/Documentation/devicetree/bindings/timer/brcm,kona-timer.txt b/Documentation/devicetree/bindings/timer/brcm,kona-timer.txt
deleted file mode 100644
index 39adf54..0000000
--- a/Documentation/devicetree/bindings/timer/brcm,kona-timer.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-Broadcom Kona Family timer
------------------------------------------------------
-This timer is used in the following Broadcom SoCs:
- BCM11130, BCM11140, BCM11351, BCM28145, BCM28155
-
-Required properties:
-- compatible : "brcm,kona-timer"
-- DEPRECATED: compatible : "bcm,kona-timer"
-- reg : Register range for the timer
-- interrupts : interrupt for the timer
-- clocks: phandle + clock specifier pair of the external clock
-- clock-frequency: frequency that the clock operates
-
-Only one of clocks or clock-frequency should be specified.
-
-Refer to clocks/clock-bindings.txt for generic clock consumer properties.
-
-Example:
-	timer@35006000 {
-		compatible = "brcm,kona-timer";
-		reg = <0x35006000 0x1000>;
-		interrupts = <0x0 7 0x4>;
-		clocks = <&hub_timer_clk>;
-	};
-
diff --git a/Documentation/devicetree/bindings/timer/brcm,kona-timer.yaml b/Documentation/devicetree/bindings/timer/brcm,kona-timer.yaml
new file mode 100644
index 0000000..d6af838
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/brcm,kona-timer.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/brcm,kona-timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom Kona family timer
+
+maintainers:
+  - Florian Fainelli <f.fainelli@gmail.com>
+
+properties:
+  compatible:
+    const: brcm,kona-timer
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-frequency: true
+
+oneOf:
+  - required:
+      - clocks
+  - required:
+      - clock-frequency
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/bcm281xx.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    timer@35006000 {
+        compatible = "brcm,kona-timer";
+        reg = <0x35006000 0x1000>;
+        interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&aon_ccu BCM281XX_AON_CCU_HUB_TIMER>;
+    };
+...
