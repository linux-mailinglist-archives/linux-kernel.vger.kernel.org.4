Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC725BAF53
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 16:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbiIPO0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 10:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbiIPOZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 10:25:55 -0400
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7761DB2CF9;
        Fri, 16 Sep 2022 07:25:54 -0700 (PDT)
Received: from robin.home.jannau.net (unknown [91.200.110.112])
        by soltyk.jannau.net (Postfix) with ESMTPSA id 0A2E726F07B;
        Fri, 16 Sep 2022 16:25:53 +0200 (CEST)
From:   Janne Grunau <j@jannau.net>
To:     asahi@lists.linux.dev
Cc:     Mark Kettenis <kettenis@openbsd.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Hector Martin <marcan@marcan.st>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sven Peter <sven@svenpeter.dev>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 03/10] dt-bindings: arm: apple: Add t6001/t6002 Mac Studio compatibles
Date:   Fri, 16 Sep 2022 16:25:43 +0200
Message-Id: <20220916142550.269905-4-j@jannau.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220916142550.269905-1-j@jannau.net>
References: <20220916142550.269905-1-j@jannau.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the following apple,t6001 platform:

- apple,j375c - Mac Studio (M1 Max, 2022)

And the initial apple,t6002 platform:

- apple,j375d - Mac Studio (M1 Ultra, 2022)

Signed-off-by: Janne Grunau <j@jannau.net>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v1:
 - added blank lines between SoC entires
 - added Krzysztof's ack

 Documentation/devicetree/bindings/arm/apple.yaml | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/apple.yaml b/Documentation/devicetree/bindings/arm/apple.yaml
index 8d93e8a6cc18..764a1780317a 100644
--- a/Documentation/devicetree/bindings/arm/apple.yaml
+++ b/Documentation/devicetree/bindings/arm/apple.yaml
@@ -19,12 +19,14 @@ description: |
   - MacBook Air (M1, 2020)
   - iMac (24-inch, M1, 2021)
 
-  And devices based on the "M1 Pro" and "M1 Max" SoCs:
+  And devices based on the "M1 Pro", "M1 Max" and "M1 Ultra" SoCs:
 
   - MacBook Pro (14-inch, M1 Pro, 2021)
   - MacBook Pro (14-inch, M1 Max, 2021)
   - MacBook Pro (16-inch, M1 Pro, 2021)
   - MacBook Pro (16-inch, M1 Max, 2021)
+  - Mac Studio (M1 Max, 2022)
+  - Mac Studio (M1 Ultra, 2022)
 
   The compatible property should follow this format:
 
@@ -67,6 +69,7 @@ properties:
               - apple,j457 # iMac (24-inch, 2x USB-C, M1, 2021)
           - const: apple,t8103
           - const: apple,arm-platform
+
       - description: Apple M1 Pro SoC based platforms
         items:
           - enum:
@@ -74,14 +77,23 @@ properties:
               - apple,j316s # MacBook Pro (16-inch, M1 Pro, 2021)
           - const: apple,t6000
           - const: apple,arm-platform
+
       - description: Apple M1 Max SoC based platforms
         items:
           - enum:
               - apple,j314c # MacBook Pro (14-inch, M1 Max, 2021)
               - apple,j316c # MacBook Pro (16-inch, M1 Max, 2021)
+              - apple,j375c # Mac Studio (M1 Max, 2022)
           - const: apple,t6001
           - const: apple,arm-platform
 
+      - description: Apple M1 Ultra SoC based platforms
+        items:
+          - enum:
+              - apple,j375d # Mac Studio (M1 Ultra, 2022)
+          - const: apple,t6002
+          - const: apple,arm-platform
+
 additionalProperties: true
 
 ...
-- 
2.35.1

