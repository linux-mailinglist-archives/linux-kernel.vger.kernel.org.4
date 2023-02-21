Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C01669E00D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 13:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234267AbjBUMPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 07:15:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234429AbjBUMP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 07:15:27 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F2E4499;
        Tue, 21 Feb 2023 04:14:59 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 31LC6KHE021153;
        Tue, 21 Feb 2023 06:06:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1676981180;
        bh=ZgK1Q7UxoYFIJ7lBntlYuht9796aFLvImb8AVSWmmFs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=HwuVv2cyqpPmMR792sSOZiB4KU1SyyzuTj/QvWNO/GyaZXqToyzUT7mDWfFNz3lL5
         ztkAtJEK/DzETm2cUC/sFplXZEyxsbUoPhVPwVSGQsge4SNmvrkSZRpgVY7JIf2rVI
         LqWS575u6e0U/gzyV4LR3IHPk5+k00EFNJnbuW0A=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 31LC6KuV125664
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 Feb 2023 06:06:20 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 21
 Feb 2023 06:06:20 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 21 Feb 2023 06:06:20 -0600
Received: from uda0500640.dal.design.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 31LC6CbO030829;
        Tue, 21 Feb 2023 06:06:17 -0600
From:   Ravi Gunasekaran <r-gunasekaran@ti.com>
To:     <nm@ti.com>, <afd@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <s-vadapalli@ti.com>, <r-gunasekaran@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v10 1/9] dt-bindings: mfd: ti,j721e-system-controller: Fix mux node regex
Date:   Tue, 21 Feb 2023 17:36:04 +0530
Message-ID: <20230221120612.27366-2-r-gunasekaran@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230221120612.27366-1-r-gunasekaran@ti.com>
References: <20230221120612.27366-1-r-gunasekaran@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mux-controller nodes may not have "reg" property. Update the regex
for such nodes to resolve the dtbs warnings

Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
---
 .../bindings/mfd/ti,j721e-system-controller.yaml          | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
index 76ef4352e13c..532bfa45e6a0 100644
--- a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
+++ b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
@@ -45,7 +45,7 @@ properties:
 
 patternProperties:
   # Optional children
-  "^mux-controller@[0-9a-f]+$":
+  "^mux-controller(@|-)[0-9a-f]+$":
     type: object
     description:
       This is the SERDES lane control mux.
@@ -94,6 +94,12 @@ examples:
                 /* SERDES4 lane0/1/2/3 select */
         };
 
+        usb_serdes_mux: mux-controller-80 {
+                compatible = "mmio-mux";
+                #mux-control-cells = <1>;
+                mux-reg-masks = <0x0 0x8000000>;
+        };
+
         clock-controller@4140 {
             compatible = "ti,am654-ehrpwm-tbclk", "syscon";
             reg = <0x4140 0x18>;
-- 
2.17.1

