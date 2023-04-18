Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B976E561D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 03:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjDRBAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 21:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjDRBAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 21:00:39 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057A82D77;
        Mon, 17 Apr 2023 18:00:33 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33I10NkS012536;
        Mon, 17 Apr 2023 20:00:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681779623;
        bh=OS7712zJKNw58HtC9X5O53QAWeh7BlP8TTEJdq8mwVM=;
        h=From:To:CC:Subject:Date;
        b=Nmbl8ED0fFJsZEXjZNPqZpwVsJOUSNjR4MihRBHou5UCwHWFV2U7aTKbPHFyLCGnd
         MC7yO6bemDbCLDYZqMn0DqUwLYUGpZCx4dreemPEaXFz+FIrzPSZXSukcXzlk4fvdJ
         DfC/cJ2BZvAbCksmOSe5rNVEKaxq6jVqKyxjEVA8=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33I10NX1091283
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 Apr 2023 20:00:23 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 17
 Apr 2023 20:00:23 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 17 Apr 2023 20:00:22 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33I10Mre016129;
        Mon, 17 Apr 2023 20:00:22 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Roger Quadros <rogerq@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Lee Jones <lee@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>
Subject: [PATCH] dt-bindings: mfd: ti,j721e-system-controller: Add SoC chip ID
Date:   Mon, 17 Apr 2023 20:00:19 -0500
Message-ID: <20230418010019.1222431-1-nm@ti.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The system-controller node also contains the chip-id node that is used
to identify the SoC specific properties. Add a pattern property to
match to the same, and add to the example.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 .../bindings/mfd/ti,j721e-system-controller.yaml      | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
index 76ef4352e13c..0c98d913747b 100644
--- a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
+++ b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
@@ -62,6 +62,12 @@ patternProperties:
     description:
       The phy node corresponding to the ethernet MAC.
 
+  "^chipid@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/hwinfo/ti,k3-socinfo.yaml#
+    description:
+      The node corresponding to SoC chip identification.
+
 required:
   - compatible
   - reg
@@ -99,5 +105,10 @@ examples:
             reg = <0x4140 0x18>;
             #clock-cells = <1>;
         };
+
+        chipid@14 {
+            compatible = "ti,am654-chipid";
+            reg = <0x14 0x4>;
+        };
     };
 ...
-- 
2.40.0

