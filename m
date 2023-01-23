Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84BA4678652
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 20:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbjAWT2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 14:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbjAWT2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 14:28:49 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BC1126C4;
        Mon, 23 Jan 2023 11:28:47 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30NG9CmD006264;
        Mon, 23 Jan 2023 11:28:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=3aqsbrnfl+QRdhz2agmcbwc7fUlVtyLG1eEbAcKd2wA=;
 b=A9VXpeD1q00DEEDvO8MxOf/3LcLG0Qb/DwIdz4yvBOMPhKVp3/vGnr5QszO+4efPr6ra
 20l8JxC2b3ovG2f9u05jydc2lUz0vrNL57lHOMfAds9oNdRWrjW2mk3Y+45f33HISpmN
 8wRuCkhM4Iz186kTIXwGuCSONJz2pmQ7NyP/HDn4rSLUVa/YIyemNmkisb9fiNXJ5GP0
 b7Qob9SwOIVTbd7obLUIa6TvfG1cl9HWKp+RuBhSqrNt6a8vVJlvtSKB8kwCF/kf4FJe
 1glgPJa+jp1M4gp4/Bks9F7V7NneUuTd6yViywZ01dS43e/XI5MMwRbnTeeZofLO7ZUH RA== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3n8gerbeqy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 23 Jan 2023 11:28:38 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 23 Jan
 2023 11:28:36 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.42 via Frontend
 Transport; Mon, 23 Jan 2023 11:28:36 -0800
Received: from localhost.localdomain (unknown [10.110.150.250])
        by maili.marvell.com (Postfix) with ESMTP id 715133F7050;
        Mon, 23 Jan 2023 11:28:36 -0800 (PST)
From:   Piyush Malgujar <pmalgujar@marvell.com>
To:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <yamada.masahiro@socionext.com>, <devicetree@vger.kernel.org>
CC:     <jannadurai@marvell.com>, <cchavva@marvell.com>,
        Piyush Malgujar <pmalgujar@marvell.com>
Subject: [PATCH v2 4/5] dt-bindings: mmc: sdhci-cadence: SD6 support
Date:   Mon, 23 Jan 2023 11:27:34 -0800
Message-ID: <20230123192735.21136-5-pmalgujar@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230123192735.21136-1-pmalgujar@marvell.com>
References: <20230123192735.21136-1-pmalgujar@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: N1WxNHQkgDPIgLtu5GNZZw9rIpRHeXSS
X-Proofpoint-ORIG-GUID: N1WxNHQkgDPIgLtu5GNZZw9rIpRHeXSS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_12,2023-01-23_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jayanthi Annadurai <jannadurai@marvell.com>

Add support for SD6 controller support.

Signed-off-by: Jayanthi Annadurai <jannadurai@marvell.com>
Signed-off-by: Piyush Malgujar <pmalgujar@marvell.com>
---
 .../devicetree/bindings/mmc/cdns,sdhci.yaml   | 34 +++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
index 8b1a0fdcb5e3e2e8b87d8d7678e37f3dad447fc1..26ef2804aa9e17c583adaa906338ec7af8c4990b 100644
--- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/mmc/cdns,sdhci.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Cadence SD/SDIO/eMMC Host Controller (SD4HC)
+title: Cadence SD/SDIO/eMMC Host Controller (SD4HC, SD6HC)
 
 maintainers:
   - Masahiro Yamada <yamada.masahiro@socionext.com>
@@ -18,7 +18,9 @@ properties:
       - enum:
           - microchip,mpfs-sd4hc
           - socionext,uniphier-sd4hc
-      - const: cdns,sd4hc
+      - enum:
+          - cdns,sd4hc
+          - cdns,sd6hc
 
   reg:
     maxItems: 1
@@ -111,6 +113,34 @@ properties:
     minimum: 0
     maximum: 0x7f
 
+  cdns,iocell-input-delay:
+    description: Delay in ps across the input IO cells
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+
+  cdns,iocell-output-delay:
+    description: Delay in ps across the output IO cells
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+
+  cdns,delay-element:
+    description: Delay element in ps used for calculating phy timings
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+
+  cdns,read-dqs-cmd-delay:
+    description: Command delay used in HS200 tuning
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+
+  cdns,tune-val-start:
+    description: Staring value of data delay used in HS200 tuning
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+
+  cdns,tune-val-step:
+    description: Incremental value of data delay used in HS200 tuning
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+
+  cdns,max-tune-iter:
+    description: Maximum number of iterations to complete the HS200 tuning process
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+
 required:
   - compatible
   - reg
-- 
2.17.1

