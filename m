Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF5273DAF2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 11:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjFZJNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 05:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjFZJNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 05:13:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A245B5;
        Mon, 26 Jun 2023 02:11:38 -0700 (PDT)
Date:   Mon, 26 Jun 2023 09:11:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687770696;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xbv5A6sD45xGW47P3SSYENQrAsMjS5mlFzU8Do8XEug=;
        b=oW8CwUU9f/H4+O5M2mSqqyJgftnFrrXiT5vcasfyvJNhY+zfPhFgCkZlQdkpGm1qtwN5F6
        6IGF42uVrbXEWBv8nfhXQvrHxv/A5KFocDt2OTEYZzShDYt4DDmXVbrftkiJ13ylPpr1v3
        oBNEYFPwDioUPvxSKeeA5GGfWxuSDoZClLzxXaB/WnIhCCssBorDiDu9S4rt8cBQPUfVVy
        5gTYPPJOQ8EjgaQupofsgKl7Y+y7+4ih5MxmYURhWbnAkf1Fj68m9doRlRnCtidV1SZmXX
        COcUTHoUWrTqTpK5eFslmPcj1s/XMsqaLIFOaC822N+NzQKjamF78morOZaLlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687770696;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xbv5A6sD45xGW47P3SSYENQrAsMjS5mlFzU8Do8XEug=;
        b=+0ImqEhzbCL1StphWBjmg+VTiAIsuKddtvO3AtMu6/y9J8KdGRXCb7ybUpVdu3PQX9d1qo
        N0ni9dGCt9q18GBQ==
From:   "tip-bot2 for Sergio Paracuellos" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] dt-bindings: timers: Add Ralink SoCs timer
Cc:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230620100231.1412582-1-sergio.paracuellos@gmail.com>
References: <20230620100231.1412582-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Message-ID: <168777069609.404.2771921874159413486.tip-bot2@tip-bot2>
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

Commit-ID:     6d0d4df8e7e1fe22d961d667c2bfa40c3d5022e8
Gitweb:        https://git.kernel.org/tip/6d0d4df8e7e1fe22d961d667c2bfa40c3d5022e8
Author:        Sergio Paracuellos <sergio.paracuellos@gmail.com>
AuthorDate:    Tue, 20 Jun 2023 12:02:31 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 23 Jun 2023 09:33:43 +02:00

dt-bindings: timers: Add Ralink SoCs timer

Add YAML documentation for the timer which is present on Ralink SoCs.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20230620100231.1412582-1-sergio.paracuellos@gmail.com
---
 Documentation/devicetree/bindings/timer/ralink,rt2880-timer.yaml | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/ralink,rt2880-timer.yaml

diff --git a/Documentation/devicetree/bindings/timer/ralink,rt2880-timer.yaml b/Documentation/devicetree/bindings/timer/ralink,rt2880-timer.yaml
new file mode 100644
index 0000000..daa7832
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/ralink,rt2880-timer.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/ralink,rt2880-timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Timer present in Ralink family SoCs
+
+maintainers:
+  - Sergio Paracuellos <sergio.paracuellos@gmail.com>
+
+properties:
+  compatible:
+    const: ralink,rt2880-timer
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
+    timer@100 {
+        compatible = "ralink,rt2880-timer";
+        reg = <0x100 0x20>;
+
+        clocks = <&sysc 3>;
+
+        interrupt-parent = <&intc>;
+        interrupts = <1>;
+    };
+...
