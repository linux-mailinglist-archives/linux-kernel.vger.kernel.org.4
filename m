Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1873C5B39D9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 15:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbiIINv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 09:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbiIINva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 09:51:30 -0400
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B39D9E8A2;
        Fri,  9 Sep 2022 06:51:06 -0700 (PDT)
Received: from robin.home.jannau.net (p54acc2ba.dip0.t-ipconnect.de [84.172.194.186])
        by soltyk.jannau.net (Postfix) with ESMTPSA id 68AFA26EFED;
        Fri,  9 Sep 2022 15:51:05 +0200 (CEST)
From:   Janne Grunau <j@jannau.net>
To:     asahi@lists.linux.dev
Cc:     Mark Kettenis <kettenis@openbsd.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Hector Martin <marcan@marcan.st>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sven Peter <sven@svenpeter.dev>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 04/10] dt-bindings: arm: apple: Add t6001/t6002 Mac Studio compatibles
Date:   Fri,  9 Sep 2022 15:50:57 +0200
Message-Id: <20220909135103.98179-5-j@jannau.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220909135103.98179-1-j@jannau.net>
References: <20220909135103.98179-1-j@jannau.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
---

 Documentation/devicetree/bindings/arm/apple.yaml | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/apple.yaml b/Documentation/devicetree/bindings/arm/apple.yaml
index 8d93e8a6cc18..b34e56b9dc59 100644
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
 
@@ -79,8 +81,15 @@ properties:
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
 
 additionalProperties: true
 
-- 
2.35.1

