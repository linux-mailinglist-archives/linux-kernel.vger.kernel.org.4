Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B5765477D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 21:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235298AbiLVUqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 15:46:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiLVUqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 15:46:11 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6904B1C401;
        Thu, 22 Dec 2022 12:46:10 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2BMKjuVe024965;
        Thu, 22 Dec 2022 14:45:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1671741956;
        bh=FjD3HhJH9r0H0J7RMDwx9xTIzqCwJ0z09ShPMRFU5ZY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=NWiLXIdb1wDfwULe2IXdh9KUYnSKoAAQbVoRoCXtV8axNatVnXNwuNA3bAE+Ju+pv
         wBB8vVIfdbBCYtj+wrM7ZSUCl8deET3tS3Xea+K6PoXeiASnMEadkJSHZx6f9xBAeM
         x+UZQRF7A0De1Ia9YBKbi+kBOqMf2Lcj3LpMPDv0=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2BMKjujt119268
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 22 Dec 2022 14:45:56 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 22
 Dec 2022 14:45:56 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 22 Dec 2022 14:45:56 -0600
Received: from LT5CD112GSQZ.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2BMKjk7N004121;
        Thu, 22 Dec 2022 14:45:52 -0600
From:   Apurva Nandan <a-nandan@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>
CC:     Apurva Nandan <a-nandan@ti.com>, Hari Nagalla <hnagalla@ti.com>
Subject: [PATCH v4 1/4] dt-bindings: arm: ti: Add bindings for J784s4 SoC
Date:   Fri, 23 Dec 2022 02:15:42 +0530
Message-ID: <20221222204545.45281-2-a-nandan@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221222204545.45281-1-a-nandan@ti.com>
References: <20221222204545.45281-1-a-nandan@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding for J784S4 SoC

Signed-off-by: Apurva Nandan <a-nandan@ti.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/ti/k3.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
index 203faab80142..98af220df721 100644
--- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
@@ -72,6 +72,12 @@ properties:
               - ti,j721s2-evm
           - const: ti,j721s2
 
+      - description: K3 J784s4 SoC
+        items:
+          - enum:
+              - ti,j784s4-evm
+          - const: ti,j784s4
+
 additionalProperties: true
 
 ...
-- 
2.34.1

