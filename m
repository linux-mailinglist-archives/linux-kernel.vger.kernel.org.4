Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394725F3FB2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbiJDJar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiJDJ1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:27:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EBE0DECB;
        Tue,  4 Oct 2022 02:27:26 -0700 (PDT)
Date:   Tue, 04 Oct 2022 09:27:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664875645;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QC5h0MvN6sbnA7273J7NwkUU+r1RIgEZ8ycGE00KX80=;
        b=mP6KqcaEBcDW+zU/ZqUauWPqIik0F+jEm122mRMmMjdg3+XAHtuFsNBlSJoVK1wnfTIPmd
        hTmAC6Fn3rnIiPmvwPqBPzfIgmfnNXwYSTfDRM2O0clbzI5NgpYb2Z4s5wqTewq9l8zw7O
        MttGJnyEtQjpbHRNG/V7I5wJPM9v2Bsm2gzDC/ubhwWKLiwv5huznAlphFcI2lm7cS+Px1
        0VDEOCL72ztPOCvyImS1FTVNVKVQOsmaElRo3zEOtNTeqQD+bLP2AeK0Z56sFXLC+o6iVL
        e4+bZRS0+Y1PF1uEB8PmblJTLt+GiOKHWETtatzktRFduzCnzMCzuz8g4Bgy0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664875645;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QC5h0MvN6sbnA7273J7NwkUU+r1RIgEZ8ycGE00KX80=;
        b=igcmRtVTfgIdm0XUYujQBQrv6Fr1oga99tvrYOuXb5Zqf1Asab9uwME1+1dVukuCABRmMW
        S9pVmLfl7xIb0CBA==
From:   "tip-bot2 for Vincent Whitchurch" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] dt-bindings: timer: exynos4210-mct: Add ARTPEC-8
 MCT support
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220609112738.359385-2-vincent.whitchurch@axis.com>
References: <20220609112738.359385-2-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Message-ID: <166487564382.401.7504319805460529083.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     99b701fd2758d046d9e6ecdef1a3320d29b8b1d9
Gitweb:        https://git.kernel.org/tip/99b701fd2758d046d9e6ecdef1a3320d29b8b1d9
Author:        Vincent Whitchurch <vincent.whitchurch@axis.com>
AuthorDate:    Thu, 09 Jun 2022 13:27:35 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 20 Sep 2022 10:49:45 +02:00

dt-bindings: timer: exynos4210-mct: Add ARTPEC-8 MCT support

The ARTPEC-8 has an MCT with 4 global and 8 local timer interrupts.

The SoC has a quad-core Cortex-A53 and a single-core Cortex-A5 which
share one MCT with one global and eight local timers.  The Cortex-A53
and Cortex-A5 do not have cache-coherency between them, and therefore
run two separate kernels.

The Cortex-A53 boots first and starts the global free-running counter
and also registers a clock events device using the global timer.  (This
global timer clock events is usually replaced by arch timer clock events
for each of the cores.)

When the A5 boots (via the A53), it should not use the global timer
interrupts or write to the global timer registers.  This is because even
if there are four global comparators, the control bits for all four are
in the same registers, and we would need to synchronize between the
cpus.  Instead, the global timer FRC (already started by the A53) should
be used as the clock source, and one of the local timers which are not
used by the A53 can be used for clock events on the A5.

To support this hardware, add a compatible for the MCT as well as two
new properties to describe the hardware-mandated sharing of the FRC and
dedicating local timers to specific processors.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
Link: https://lore.kernel.org/r/20220609112738.359385-2-vincent.whitchurch@axis.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml b/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
index 9c81d00..829bd22 100644
--- a/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
+++ b/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
@@ -25,6 +25,7 @@ properties:
           - samsung,exynos4412-mct
       - items:
           - enum:
+              - axis,artpec8-mct
               - samsung,exynos3250-mct
               - samsung,exynos5250-mct
               - samsung,exynos5260-mct
@@ -45,6 +46,19 @@ properties:
   reg:
     maxItems: 1
 
+  samsung,frc-shared:
+    type: boolean
+    description: |
+      Indicates that the hardware requires that this processor share the
+      free-running counter with a different (main) processor.
+
+  samsung,local-timers:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 16
+    description: |
+      List of indices of local timers usable from this processor.
+
   interrupts:
     description: |
       Interrupts should be put in specific order. This is, the local timer
@@ -75,6 +89,17 @@ required:
 
 allOf:
   - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - axis,artpec8-mct
+    then:
+      properties:
+        samsung,local-timers: false
+        samsung,frc-shared: false
+  - if:
       properties:
         compatible:
           contains:
@@ -101,6 +126,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - axis,artpec8-mct
               - samsung,exynos5260-mct
               - samsung,exynos5420-mct
               - samsung,exynos5433-mct
