Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBB8650D3C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 15:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbiLSOZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 09:25:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbiLSOZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 09:25:42 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5930B10FFA;
        Mon, 19 Dec 2022 06:25:34 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJEMlk2032583;
        Mon, 19 Dec 2022 06:25:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=sZDhLkMXdcSms0aPg5UjnaZXXpAsV8fH5Cf17fs0i2o=;
 b=eCWIRqtdPRf8+/Gs3+82MI9QZuiv45nQmjXd4p0AE9WBNZ6aQDu9LWS4mdfHkRiGTQ/e
 dz+LitmjcE+yS6KTUS2EDOHe5AsXdiAJFgOIryuywPZs55kEyf10TvwZ4xXupDGLDDFS
 Mg5eqtYiv+hBZl4Q8nbPsg9z0ASCnEj2b39AcSq/FiBcEXCmJvkSruTLXMX74REkcvIx
 OpT2Ov2GffWISmLfdPqSWphkVUn/l+ncBG/nXjh3QFSD8Yj+AHHq9G67+iMgf2v5lnrl
 /medcCUmoy2Erfv9DFc+Acm9R57LVDu7vdxpf54CBJ0OoZx8Zqy5UeviK3kNJU63Qb+Y UA== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3mhe5rkf2f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 06:25:20 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 19 Dec
 2022 06:25:18 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.42 via Frontend
 Transport; Mon, 19 Dec 2022 06:25:18 -0800
Received: from localhost.localdomain (unknown [10.110.150.250])
        by maili.marvell.com (Postfix) with ESMTP id C8E673F70C6;
        Mon, 19 Dec 2022 06:25:16 -0800 (PST)
From:   Piyush Malgujar <pmalgujar@marvell.com>
To:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <yamada.masahiro@socionext.com>, <devicetree@vger.kernel.org>
CC:     <jannadurai@marvell.com>, <cchavva@marvell.com>,
        Piyush Malgujar <pmalgujar@marvell.com>
Subject: [PATCH 3/5] dt-bindings: mmc: sdhci-cadence: SD6 support
Date:   Mon, 19 Dec 2022 06:24:16 -0800
Message-ID: <20221219142418.27949-4-pmalgujar@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221219142418.27949-1-pmalgujar@marvell.com>
References: <20221219142418.27949-1-pmalgujar@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: EmU-Tjoj77No0l76s9EVDrwkSp1SoOph
X-Proofpoint-ORIG-GUID: EmU-Tjoj77No0l76s9EVDrwkSp1SoOph
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-19_01,2022-12-15_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jayanthi Annadurai <jannadurai@marvell.com>

Add support for SD6 controller support

Signed-off-by: Jayanthi Annadurai <jannadurai@marvell.com>
Signed-off-by: Piyush Malgujar <pmalgujar@marvell.com>
---
 .../devicetree/bindings/mmc/cdns,sdhci.yaml   | 33 +++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
index 8b1a0fdcb5e3e2e8b87d8d7678e37f3dad447fc1..2043e78ccd5f708a01e87fd96ec410418fcd539f 100644
--- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/mmc/cdns,sdhci.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Cadence SD/SDIO/eMMC Host Controller (SD4HC)
+title: Cadence SD/SDIO/eMMC Host Controller (SD4HC, SD6HC)
 
 maintainers:
   - Masahiro Yamada <yamada.masahiro@socionext.com>
@@ -19,6 +19,7 @@ properties:
           - microchip,mpfs-sd4hc
           - socionext,uniphier-sd4hc
       - const: cdns,sd4hc
+      - const: cdns,sd6hc
 
   reg:
     maxItems: 1
@@ -111,6 +112,34 @@ properties:
     minimum: 0
     maximum: 0x7f
 
+  cdns,iocell_input_delay:
+    description: Delay in ps across the input IO cells
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+
+  cdns,iocell_output_delay:
+    description: Delay in ps across the output IO cells
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+
+  cdns,delay_element:
+    description: Delay element in ps used for calculating phy timings
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+
+  cdns,read_dqs_cmd_delay:
+    description: Command delay used in HS200 tuning
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+
+  cdns,tune_val_start:
+    description: Staring value of data delay used in HS200 tuning
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+
+  cdns,tune_val_step:
+    description: Incremental value of data delay used in HS200 tuning
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+
+  cdns,max_tune_iter:
+    description: Maximum number of iterations to complete the HS200 tuning process
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+
 required:
   - compatible
   - reg
@@ -122,7 +151,7 @@ unevaluatedProperties: false
 examples:
   - |
     emmc: mmc@5a000000 {
-        compatible = "socionext,uniphier-sd4hc", "cdns,sd4hc";
+        compatible = "socionext,uniphier-sd4hc", "cdns,sd4hc", "cdns,sd6hc";
         reg = <0x5a000000 0x400>;
         interrupts = <0 78 4>;
         clocks = <&clk 4>;
-- 
2.17.1

