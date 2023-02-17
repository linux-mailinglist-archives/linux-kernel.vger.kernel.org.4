Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794D669A692
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 09:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjBQIHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 03:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjBQIGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 03:06:46 -0500
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0DFA12C64A;
        Fri, 17 Feb 2023 00:06:35 -0800 (PST)
X-MailGates: (flag:4,DYNAMIC,BADHELO,RELAY,NOHOST:PASS)(compute_score:DE
        LIVER,40,3)
Received: from 192.168.10.46
        by mg.richtek.com with MailGates ESMTP Server V5.0(23448:0:AUTH_RELAY)
        (envelope-from <chiaen_wu@richtek.com>); Fri, 17 Feb 2023 16:06:27 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.20; Fri, 17 Feb
 2023 16:06:26 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1118.20 via Frontend
 Transport; Fri, 17 Feb 2023 16:06:26 +0800
From:   ChiaEn Wu <chiaen_wu@richtek.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <sre@kernel.org>
CC:     <cy_huang@richtek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <peterwu.pub@gmail.com>, ChiaEn Wu <chiaen_wu@richtek.com>
Subject: [PATCH v3 1/2][next] dt-bindings: power: supply: Revise Richtek RT9467 compatible name
Date:   Fri, 17 Feb 2023 16:06:05 +0800
Message-ID: <d099179cb531a7bee0ade1e8431feb9b967a4de3.1676648773.git.chiaen_wu@richtek.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1676648773.git.chiaen_wu@richtek.com>
References: <cover.1676648773.git.chiaen_wu@richtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Revise RT9467 compatible name from "richtek,rt9467-charger" to
"richtek,rt9467" because it has to match the "compatible name" in
the source code.

Fixes: e1b4620fb503 ("dt-bindings: power: supply: Add Richtek RT9467 battery charger")
Reported-by: Rob Herring <robh@kernel.org>
Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
---
v3:
- Roll back the file name.

v2:
- Add more description about this change in the commit message.
- Rename "richtek,rt9467-charger.yaml" to "richtek,rt9467.yaml".
- Rename "$id" as above.
---
 .../devicetree/bindings/power/supply/richtek,rt9467-charger.yaml    | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/supply/richtek,rt9467-charger.yaml b/Documentation/devicetree/bindings/power/supply/richtek,rt9467-charger.yaml
index 92c5706..3723717 100644
--- a/Documentation/devicetree/bindings/power/supply/richtek,rt9467-charger.yaml
+++ b/Documentation/devicetree/bindings/power/supply/richtek,rt9467-charger.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/power/supply/richtek,rt9467-charger.yaml#
+$id: http://devicetree.org/schemas/power/supply/richtek,rt9467.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Richtek RT9467 Switching Battery Charger with Power Path Management
@@ -25,7 +25,7 @@ description: |
 
 properties:
   compatible:
-    const: richtek,rt9467-charger
+    const: richtek,rt9467
 
   reg:
     maxItems: 1
@@ -65,7 +65,7 @@ examples:
       #size-cells = <0>;
 
       charger@5b {
-        compatible = "richtek,rt9467-charger";
+        compatible = "richtek,rt9467";
         reg = <0x5b>;
         wakeup-source;
         interrupts-extended = <&gpio_intc 32 IRQ_TYPE_LEVEL_LOW>;
-- 
2.7.4

