Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E96B6DAB87
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 12:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239871AbjDGK2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 06:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbjDGK2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 06:28:18 -0400
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150F0AD19;
        Fri,  7 Apr 2023 03:27:27 -0700 (PDT)
Received: from droid01-cd.amlogic.com (10.98.11.200) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2507.13; Fri, 7 Apr 2023
 18:28:40 +0800
From:   Kelvin Zhang <kelvin.zhang@amlogic.com>
To:     <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kelvin Zhang <kelvin.zhang@amlogic.com>
Subject: [PATCH] dt-bindings: arm: amlogic: add C3 bindings
Date:   Fri, 7 Apr 2023 18:27:04 +0800
Message-ID: <20230407102704.1055152-1-kelvin.zhang@amlogic.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.98.11.200]
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the new C3 SoC/board device tree bindings.

C3 is an advanced edge AI processor designed for smart IP camera
applications, which does not belong to Meson series.

Therefore, modify the title field accordingly.

Signed-off-by: Kelvin Zhang <kelvin.zhang@amlogic.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index 274ee0890312..08d59842655c 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/arm/amlogic.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Amlogic MesonX
+title: Amlogic SoC based Platforms
 
 maintainers:
   - Kevin Hilman <khilman@baylibre.com>
@@ -205,6 +205,13 @@ properties:
               - amlogic,ad401
           - const: amlogic,a1
 
+      - description: Boards with the Amlogic C3 C302X/C308L SoC
+        items:
+          - enum:
+              - amlogic,aw409
+              - amlogic,aw419
+          - const: amlogic,c3
+
       - description: Boards with the Amlogic Meson S4 S805X2 SoC
         items:
           - enum:

base-commit: e134c93f788fb93fd6a3ec3af9af850a2048c7e6
-- 
2.37.1

