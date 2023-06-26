Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0765873DB04
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 11:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjFZJOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 05:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjFZJNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 05:13:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B8FE6;
        Mon, 26 Jun 2023 02:11:40 -0700 (PDT)
Date:   Mon, 26 Jun 2023 09:11:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687770699;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8U6HqRIVCmdFTK2bG+jKp3mqwOBDyQxzcI+oyYrBZzk=;
        b=krHrUkWyZbF+kEVD3vyBaV52tKjPWvgdCuInBIkdTgIeUJHFRnyaTcJmuumwnpNuigE2hd
        eCn2rdj7/dCfmsnZkQn9mkZFWEcnFK+ghiyOiyVSMDfci0Vyxl7phEyZCrjeOEjG8c+tlk
        Kttp9lDgks8EIjsh7q8DgucsINHSHGYpF5JYEe2fhXogHDLhcUBXnr1vVEnNcCrSzJGY5W
        cwM/llrp6mI0a3lZyvMsWDNNCwJrUJom1RuxjC21Y+kdHMoD5vZQtMcB9loK8nXfjcA08y
        9+WVkI0bQhyHnXNllm6LqdmEKkNo/OOksNwWyKR7yD4GStUnPS0s1T+mlDz+LQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687770699;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8U6HqRIVCmdFTK2bG+jKp3mqwOBDyQxzcI+oyYrBZzk=;
        b=f2jNQfn8/8zIX3jjG3lhRVfNE5ePy03BLylGJu3kTH54YanWN/aRDWbwtaN57BswpFSfFw
        fKWDPlI/Jbk+nvDw==
From:   "tip-bot2 for Keguang Zhang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] dt-bindings: timer: Add Loongson-1 clocksource
Cc:     Keguang Zhang <keguang.zhang@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230512103724.587760-3-keguang.zhang@gmail.com>
References: <20230512103724.587760-3-keguang.zhang@gmail.com>
MIME-Version: 1.0
Message-ID: <168777069909.404.17882663079174570164.tip-bot2@tip-bot2>
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

Commit-ID:     b25efff2a63f0d573f409f22e82904db9cc7d577
Gitweb:        https://git.kernel.org/tip/b25efff2a63f0d573f409f22e82904db9cc7d577
Author:        Keguang Zhang <keguang.zhang@gmail.com>
AuthorDate:    Fri, 12 May 2023 18:37:23 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 19 Jun 2023 17:06:55 +02:00

dt-bindings: timer: Add Loongson-1 clocksource

Add devicetree binding document for Loongson-1 clocksource.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20230512103724.587760-3-keguang.zhang@gmail.com
---
 Documentation/devicetree/bindings/timer/loongson,ls1x-pwmtimer.yaml | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/loongson,ls1x-pwmtimer.yaml

diff --git a/Documentation/devicetree/bindings/timer/loongson,ls1x-pwmtimer.yaml b/Documentation/devicetree/bindings/timer/loongson,ls1x-pwmtimer.yaml
new file mode 100644
index 0000000..ad61ae5
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/loongson,ls1x-pwmtimer.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/loongson,ls1x-pwmtimer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Loongson-1 PWM timer
+
+maintainers:
+  - Keguang Zhang <keguang.zhang@gmail.com>
+
+description:
+  Loongson-1 PWM timer can be used for system clock source
+  and clock event timers.
+
+properties:
+  compatible:
+    const: loongson,ls1b-pwmtimer
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/loongson,ls1x-clk.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    clocksource: timer@1fe5c030 {
+        compatible = "loongson,ls1b-pwmtimer";
+        reg = <0x1fe5c030 0x10>;
+
+        clocks = <&clkc LS1X_CLKID_APB>;
+        interrupt-parent = <&intc0>;
+        interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
+    };
