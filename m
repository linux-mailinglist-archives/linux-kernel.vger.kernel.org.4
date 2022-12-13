Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695E764B0FF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 09:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234749AbiLMIZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 03:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbiLMIZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 03:25:06 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 266BD13CEE;
        Tue, 13 Dec 2022 00:25:04 -0800 (PST)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 13 Dec 2022 17:25:03 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 693D62059054;
        Tue, 13 Dec 2022 17:25:03 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 13 Dec 2022 17:25:03 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 3A1D4A855F;
        Tue, 13 Dec 2022 17:25:03 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v3 01/17] dt-bindings: clock: Fix node descriptions in uniphier-clock example
Date:   Tue, 13 Dec 2022 17:24:33 +0900
Message-Id: <20221213082449.2721-2-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221213082449.2721-1-hayashi.kunihiko@socionext.com>
References: <20221213082449.2721-1-hayashi.kunihiko@socionext.com>
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
clock nodes to the generic names in the example.

And drop redundant examples and a parent node of the clock as it is not
directly necessary.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../clock/socionext,uniphier-clock.yaml       | 39 ++-----------------
 1 file changed, 3 insertions(+), 36 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/socionext,uniphier-clock.yaml b/Documentation/devicetree/bindings/clock/socionext,uniphier-clock.yaml
index 9a0cc7341630..4e82582fb2f3 100644
--- a/Documentation/devicetree/bindings/clock/socionext,uniphier-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/socionext,uniphier-clock.yaml
@@ -61,40 +61,7 @@ required:
 
 examples:
   - |
-    sysctrl@61840000 {
-        compatible = "socionext,uniphier-sysctrl", "simple-mfd", "syscon";
-        reg = <0x61840000 0x4000>;
-
-        clock {
-            compatible = "socionext,uniphier-ld11-clock";
-            #clock-cells = <1>;
-        };
-
-        // other nodes ...
-    };
-
-  - |
-    mioctrl@59810000 {
-        compatible = "socionext,uniphier-mioctrl", "simple-mfd", "syscon";
-        reg = <0x59810000 0x800>;
-
-        clock {
-            compatible = "socionext,uniphier-ld11-mio-clock";
-            #clock-cells = <1>;
-        };
-
-        // other nodes ...
-    };
-
-  - |
-    perictrl@59820000 {
-        compatible = "socionext,uniphier-perictrl", "simple-mfd", "syscon";
-        reg = <0x59820000 0x200>;
-
-        clock {
-            compatible = "socionext,uniphier-ld11-peri-clock";
-            #clock-cells = <1>;
-        };
-
-        // other nodes ...
+    clock-controller {
+        compatible = "socionext,uniphier-ld11-clock";
+        #clock-cells = <1>;
     };
-- 
2.25.1

