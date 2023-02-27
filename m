Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4AE16A49D4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 19:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjB0SdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 13:33:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjB0SdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 13:33:22 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D091FF3B;
        Mon, 27 Feb 2023 10:32:56 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31RCtGwI026362;
        Mon, 27 Feb 2023 10:32:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=t+re6yD5UFAUuv7Rao5NJSDL9RP5e62V7XEy8m44VsU=;
 b=TZQu/2eQkPpyaT7eP1LJvTALTFCgxKNoyooY/a/0SIo3AUgz/QqMc7y3+i1sQMwSqmHZ
 msGPBr2/DMeuscz+KRmQMroDRAFKvm7GVPX1ht9TdHzt6LzMscxLxNBmZ7kuqPeGCvxS
 QS8BzSDHorghp3nHbuXQRk86+/T8xIdIiTvRvw3nOOARAJW6785hlWwOqHE770RqblZL
 dj72FU3ARf0oT+ndQXnoYGtBst69IIee0IJCel8P2bA/6or9NyCtd6+zWs7X75O8pvc6
 in1RkdNv/BCcY48pwMRR2Ttb3u8Wq5/3WtDJ9aWGx67FW8+aGLioJistm/BmPtKlq87Y tg== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3nyjqtsbna-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 27 Feb 2023 10:32:50 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 27 Feb
 2023 10:32:44 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.42 via Frontend
 Transport; Mon, 27 Feb 2023 10:32:44 -0800
Received: from localhost.localdomain (unknown [10.110.150.250])
        by maili.marvell.com (Postfix) with ESMTP id 83A3D3F7063;
        Mon, 27 Feb 2023 10:32:44 -0800 (PST)
From:   Piyush Malgujar <pmalgujar@marvell.com>
To:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <yamada.masahiro@socionext.com>, <devicetree@vger.kernel.org>
CC:     <jannadurai@marvell.com>, <cchavva@marvell.com>,
        Piyush Malgujar <pmalgujar@marvell.com>
Subject: [PATCH v3 5/6] dt-bindings: mmc: sdhci-cadence: SD6 support
Date:   Mon, 27 Feb 2023 10:31:50 -0800
Message-ID: <20230227183151.27912-6-pmalgujar@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230227183151.27912-1-pmalgujar@marvell.com>
References: <20230227183151.27912-1-pmalgujar@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Xg4GOC06UIFmvulNu52G-IzwWk4MmApx
X-Proofpoint-GUID: Xg4GOC06UIFmvulNu52G-IzwWk4MmApx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-27_15,2023-02-27_01,2023-02-09_01
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
 .../devicetree/bindings/mmc/cdns,sdhci.yaml   | 24 +++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
index 8b1a0fdcb5e3e2e8b87d8d7678e37f3dad447fc1..0dba17c4f17f82c8ae68e46225ed72418e8361ff 100644
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
@@ -111,6 +113,24 @@ properties:
     minimum: 0
     maximum: 0x7f
 
+  cdns,iocell-input-delay-ps:
+    description: Delay in ps across the input IO cells
+
+  cdns,iocell-output-delay-ps:
+    description: Delay in ps across the output IO cells
+
+  cdns,delay-element-ps:
+    description: Delay element in ps used for calculating phy timings
+
+  cdns,read-dqs-cmd-delay-ps:
+    description: Command delay used in HS200 tuning
+
+  cdns,tune-val-start-ps:
+    description: Staring value of data delay used in HS200 tuning
+
+  cdns,tune-val-step-ps:
+    description: Incremental value of data delay used in HS200 tuning
+
 required:
   - compatible
   - reg
-- 
2.17.1

