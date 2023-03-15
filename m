Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251146BAC15
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 10:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbjCOJYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 05:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbjCOJY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 05:24:27 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B2822A1A;
        Wed, 15 Mar 2023 02:24:20 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32F9OD5V076003;
        Wed, 15 Mar 2023 04:24:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678872253;
        bh=kN5HfLaSDZw2gaUqS4ucdoReUGJEGmout9fy809fv6o=;
        h=From:To:CC:Subject:Date;
        b=b3BX8snHa1faIoUo8QBr+GbwARRcAahOJ9P4DV4DiwdUsJ/l7ZxJn3kw8xwcz4jrw
         aCg22h/UgxGCNy0RWCHo9sBSTfBY3/EROcesdcbUwoaJjnVvfAUOvir8PLFC5kTO0j
         QfixD2+hM7+FPgzzOdzZBWN9/q+65w0xe7UphR+Y=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32F9ODAj022902
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 Mar 2023 04:24:13 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 15
 Mar 2023 04:24:12 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 15 Mar 2023 04:24:12 -0500
Received: from uda0492258.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32F9O9oi071738;
        Wed, 15 Mar 2023 04:24:09 -0500
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
To:     <vkoul@kernel.org>, <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH] dt-bindings: phy: ti: phy-gmii-sel: Add support for J784S4 CPSW9G
Date:   Wed, 15 Mar 2023 14:54:08 +0530
Message-ID: <20230315092408.1722114-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CPSW9G instance of CPSW Ethernet Switch on TI's J784S4 SoC supports
additional PHY modes like QSGMII. Add a compatible for it.

Enable the use of "ti,qsgmii-main-ports" property for J784S4 CPSW9G.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml b/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
index 6d46f57fa1b4..3f2c5e2a11d5 100644
--- a/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
+++ b/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
@@ -55,6 +55,7 @@ properties:
       - ti,am654-phy-gmii-sel
       - ti,j7200-cpsw5g-phy-gmii-sel
       - ti,j721e-cpsw9g-phy-gmii-sel
+      - ti,j784s4-cpsw9g-phy-gmii-sel
 
   reg:
     maxItems: 1
@@ -87,6 +88,7 @@ allOf:
               - ti,am654-phy-gmii-sel
               - ti,j7200-cpsw5g-phy-gmii-sel
               - ti,j721e-cpsw9g-phy-gmii-sel
+              - ti,j784s4-cpsw9g-phy-gmii-sel
     then:
       properties:
         '#phy-cells':
@@ -113,6 +115,7 @@ allOf:
           contains:
             enum:
               - ti,j721e-cpsw9g-phy-gmii-sel
+              - ti,j784s4-cpsw9g-phy-gmii-sel
     then:
       properties:
         ti,qsgmii-main-ports:
@@ -130,6 +133,7 @@ allOf:
               enum:
                 - ti,j7200-cpsw5g-phy-gmii-sel
                 - ti,j721e-cpsw9g-phy-gmii-sel
+                - ti,j784s4-cpsw9g-phy-gmii-sel
     then:
       properties:
         ti,qsgmii-main-ports: false
-- 
2.25.1

