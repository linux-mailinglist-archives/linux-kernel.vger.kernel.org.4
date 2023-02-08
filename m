Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5929E68E686
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 04:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjBHDPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 22:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbjBHDPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 22:15:14 -0500
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6895143449;
        Tue,  7 Feb 2023 19:15:11 -0800 (PST)
X-MailGates: (flag:4,DYNAMIC,BADHELO,RELAY,NOHOST:PASS)(compute_score:DE
        LIVER,40,3)
Received: from 192.168.10.46
        by mg.richtek.com with MailGates ESMTP Server V5.0(17204:0:AUTH_RELAY)
        (envelope-from <chiaen_wu@richtek.com>); Wed, 08 Feb 2023 11:15:00 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.20; Wed, 8 Feb
 2023 11:15:00 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1118.20 via Frontend
 Transport; Wed, 8 Feb 2023 11:15:00 +0800
From:   ChiaEn Wu <chiaen_wu@richtek.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <sre@kernel.org>
CC:     <cy_huang@richtek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <peterwu.pub@gmail.com>, ChiaEn Wu <chiaen_wu@richtek.com>
Subject: [Patch][next] dt-bindings: power: supply: Revise Richtek RT9467 compatible name
Date:   Wed, 8 Feb 2023 11:14:24 +0800
Message-ID: <dc8873c3125f7aa6f84dc7b33a44bf00907e0814.1675853673.git.chiaen_wu@richtek.com>
X-Mailer: git-send-email 1.8.3.1
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
"richtek,rt9467"

Fixes: e1b4620fb503 ("dt-bindings: power: supply: Add Richtek RT9467 battery charger")
Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
---
 .../devicetree/bindings/power/supply/richtek,rt9467-charger.yaml      | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/supply/richtek,rt9467-charger.yaml b/Documentation/devicetree/bindings/power/supply/richtek,rt9467-charger.yaml
index 92c5706..9176808 100644
--- a/Documentation/devicetree/bindings/power/supply/richtek,rt9467-charger.yaml
+++ b/Documentation/devicetree/bindings/power/supply/richtek,rt9467-charger.yaml
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

