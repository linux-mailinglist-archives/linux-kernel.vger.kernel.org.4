Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D50B66453A0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 06:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiLGFyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 00:54:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiLGFyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 00:54:32 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C7D2558BE4;
        Tue,  6 Dec 2022 21:54:30 -0800 (PST)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 07 Dec 2022 14:54:30 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 409492058B4F;
        Wed,  7 Dec 2022 14:54:30 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 7 Dec 2022 14:54:30 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id E1D251DA5;
        Wed,  7 Dec 2022 14:54:29 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v2 01/16] dt-bindings: clock: Fix node descriptions in uniphier-clock example
Date:   Wed,  7 Dec 2022 14:53:50 +0900
Message-Id: <20221207055405.30940-2-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221207055405.30940-1-hayashi.kunihiko@socionext.com>
References: <20221207055405.30940-1-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prior to adding dt-bindings for SoC-dependent controllers, rename the
clock nodes their parent nodes to the generic names in the example.

And also fix the missing compatible string.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../clock/socionext,uniphier-clock.yaml       | 21 +++++++++++--------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/socionext,uniphier-clock.yaml b/Documentation/devicetree/bindings/clock/socionext,uniphier-clock.yaml
index 9a0cc7341630..672450a1ecda 100644
--- a/Documentation/devicetree/bindings/clock/socionext,uniphier-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/socionext,uniphier-clock.yaml
@@ -61,11 +61,12 @@ required:
 
 examples:
   - |
-    sysctrl@61840000 {
-        compatible = "socionext,uniphier-sysctrl", "simple-mfd", "syscon";
+    syscon@61840000 {
+        compatible = "socionext,uniphier-ld11-sysctrl",
+                     "simple-mfd", "syscon";
         reg = <0x61840000 0x4000>;
 
-        clock {
+        clock-controller {
             compatible = "socionext,uniphier-ld11-clock";
             #clock-cells = <1>;
         };
@@ -74,11 +75,12 @@ examples:
     };
 
   - |
-    mioctrl@59810000 {
-        compatible = "socionext,uniphier-mioctrl", "simple-mfd", "syscon";
+    syscon@59810000 {
+        compatible = "socionext,uniphier-ld11-mioctrl",
+                     "simple-mfd", "syscon";
         reg = <0x59810000 0x800>;
 
-        clock {
+        clock-controller {
             compatible = "socionext,uniphier-ld11-mio-clock";
             #clock-cells = <1>;
         };
@@ -87,11 +89,12 @@ examples:
     };
 
   - |
-    perictrl@59820000 {
-        compatible = "socionext,uniphier-perictrl", "simple-mfd", "syscon";
+    syscon@59820000 {
+        compatible = "socionext,uniphier-ld11-perictrl",
+                     "simple-mfd", "syscon";
         reg = <0x59820000 0x200>;
 
-        clock {
+        clock-controller {
             compatible = "socionext,uniphier-ld11-peri-clock";
             #clock-cells = <1>;
         };
-- 
2.25.1

