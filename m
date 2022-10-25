Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE7660D46E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 21:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbiJYTPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 15:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiJYTPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 15:15:31 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3715D7B596;
        Tue, 25 Oct 2022 12:15:30 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29PJFJ7b114083;
        Tue, 25 Oct 2022 14:15:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666725319;
        bh=ZL+YBJQnQSuukUMqpWoTNGCHm/b9bnX/oYmoOE+d/FI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=OKckoL/GfszSOf8nC78uXgGuGM54L9GiYSrrW6i9/k5QJQsmxC1e7lOxR4gN7xN2u
         xVtSxCra31wWCVz/YFvHj18BVZF2/dw2MnPC+Wa2jW+tFH9o0WdUF2s3BihTFmP9kQ
         lr3eVbz0IqppJcBkX7mp9qCx3TnTPEiJCLa141qY=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29PJFJDd065990
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Oct 2022 14:15:19 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 25
 Oct 2022 14:15:19 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 25 Oct 2022 14:15:19 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29PJFJbX038872;
        Tue, 25 Oct 2022 14:15:19 -0500
From:   Bryan Brattlof <bb@ti.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
CC:     Keerthy <j-keerthy@ti.com>, Linux PM <linux-pm@vger.kernel.org>,
        Device Trees <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        LKML ARM <linux-arm-kernel@lists.infradead.org>,
        Bryan Brattlof <bb@ti.com>
Subject: [PATCH v2 05/11] dt-bindings: thermal: k3-j72xx: elaborate on binding description
Date:   Tue, 25 Oct 2022 14:15:09 -0500
Message-ID: <20221025191515.9151-6-bb@ti.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221025191515.9151-1-bb@ti.com>
References: <20221025191515.9151-1-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1844; h=from:subject; bh=X0Gh04bGx605RJeJrzQxigJ9CmhRVnqOURTu0JyzGYk=; b=owNCWmg5MUFZJlNZOWG3gQAAcn///77Pf////l/XLb/v/tvruz978P3uvvbz8XsZvZJ+j/SwARsr B2k00aDQDQNDQAAGQZGQDQDQaAANDEBkwIGgAAAAeoAAbSDTRmp6m2qHQAaAaABoxGmg0BoaDIaA9I ZMgADQNANNG1NADNQDQG0JkDRoeKBkAZBoZQep6mTINGgDQyBiA00DAmhoANBiNABkZBkAyDIaGjQG QBkANNA9QNGmjIAg775YQYWGC/iiIwpkEAttmJGCwEMBul41oBi14bzmVinKERBshcHg3a31TuCY5M TVKNjWOYqa/w5Y5ulEDTUbuSuEHRel89F1Vl8IoUWPb0inrrCUgmViG/X25ACoHtm/scRZo5frcWVA DgmCpoGQSJcw2/pNT37GINJi7TJUnGkIYDzJ2ayfE51S5x9IFkxcgeD2XHhK5xlpSM3RdaxExWh2sf +uuMQvROfQ45LEXTA24LCTwvfZlxAOZhuWjE9eJpOLgshOPaowmYvP96WXsHEESZAJ+rLdCshlJIoM G1aCo4bvPVv1iEuscLwKCZ7Bq/U/kvDPImYi8RDmIMkiyJjkYwW+yPgHNpUkitLR4rBnqlEbY4nJKZ tCQX5jBIkZb06dYxukxwhg9zLDdRmkm1oHPYAMy/gRaEBAgKgMQrSmSDg/xdyRThQkDlht4EA=
X-Developer-Key: i=bb@ti.com; a=openpgp; fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Elaborate on the function of this device node as well as some of the
properties this node uses.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 .../bindings/thermal/ti,j72xx-thermal.yaml    | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml b/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
index c74f124ebfc00..3bb870a26872f 100644
--- a/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
@@ -9,6 +9,19 @@ title: Texas Instruments J72XX VTM (DTS) binding
 maintainers:
   - Keerthy <j-keerthy@ti.com>
 
+description: |
+  The TI K3 family of SoCs typically have a Voltage & Thermal
+  Management (VTM) device to control up to 8 temperature diode
+  sensors to measure silicon junction temperatures from different
+  hotspots of the chip as well as provide temperature, interrupt
+  and alerting information.
+
+  The following polynomial equation can then be used to convert
+  value returned by this device into a temperature in Celsius
+
+  Temp(C) = (-9.2627e-12) * x^4 + (6.0373e-08) * x^3 + \
+            (-1.7058e-04) * x^2 + (3.2512e-01) * x   + (-4.9003e+01)
+
 properties:
   compatible:
     enum:
@@ -19,7 +32,11 @@ properties:
     items:
       - description: VTM cfg1 register space
       - description: VTM cfg2 register space
-      - description: VTM efuse register space
+      - description: |
+          A software trimming method must be applied to some Jacinto
+          devices to function properly. This eFuse region provides
+          the information needed for these SoCs to report
+          temperatures accurately.
 
   power-domains:
     maxItems: 1
-- 
2.38.1

