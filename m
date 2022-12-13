Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97BF64B115
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 09:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234815AbiLMIZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 03:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234732AbiLMIZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 03:25:08 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AD4C613DD6;
        Tue, 13 Dec 2022 00:25:06 -0800 (PST)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 13 Dec 2022 17:25:04 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 842912059054;
        Tue, 13 Dec 2022 17:25:04 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 13 Dec 2022 17:25:04 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id CDFF8A855F;
        Tue, 13 Dec 2022 17:25:03 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v3 05/17] dt-bindings: watchdog: Fix node descriptions in uniphier-wdt example
Date:   Tue, 13 Dec 2022 17:24:37 +0900
Message-Id: <20221213082449.2721-6-hayashi.kunihiko@socionext.com>
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

Drop a parent node of the watchdog as it is not directly necessary.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../bindings/watchdog/socionext,uniphier-wdt.yaml      | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/socionext,uniphier-wdt.yaml b/Documentation/devicetree/bindings/watchdog/socionext,uniphier-wdt.yaml
index 90698cfa8f94..70c005fdd197 100644
--- a/Documentation/devicetree/bindings/watchdog/socionext,uniphier-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/socionext,uniphier-wdt.yaml
@@ -25,12 +25,6 @@ examples:
   - |
     // The UniPhier watchdog should be a subnode of a "syscon" compatible node.
 
-    sysctrl@61840000 {
-        compatible = "socionext,uniphier-ld11-sysctrl",
-                     "simple-mfd", "syscon";
-        reg = <0x61840000 0x10000>;
-
-        watchdog {
-            compatible = "socionext,uniphier-wdt";
-        };
+    watchdog {
+        compatible = "socionext,uniphier-wdt";
     };
-- 
2.25.1

