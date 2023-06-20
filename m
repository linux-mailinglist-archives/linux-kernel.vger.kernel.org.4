Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D0A736628
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 10:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbjFTI2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 04:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbjFTI2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 04:28:30 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC17130;
        Tue, 20 Jun 2023 01:28:25 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35K8SIHg131019;
        Tue, 20 Jun 2023 03:28:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1687249698;
        bh=suCPQPrzzGFfP4KenDy/T5byFv935u0r7FkdI3FxBb8=;
        h=From:Date:Subject:References:In-Reply-To:To:CC;
        b=Ak0WeTnAy3ZxPjUz74Z60HqtjFXrMaLEDaQ8yMLB6QwaeO8JQhddUzqkVVudnbBuU
         AHg41gN8gHjdHJwyjGRbbvuz2bgA8FAkOxsfxj/MkvcUN5HxWYCB76dlZx29ZwiatA
         pXIm9xxtb7DDnxbgCA18vm43v8BnQs/IuXBEjXL4=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35K8SIjQ022384
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 20 Jun 2023 03:28:18 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 20
 Jun 2023 03:28:18 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 20 Jun 2023 03:28:18 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 35K8SHdC065731;
        Tue, 20 Jun 2023 03:28:18 -0500
From:   Kamlesh Gurudasani <kamlesh@ti.com>
Date:   Tue, 20 Jun 2023 13:56:59 +0530
Subject: [PATCH v4 1/2] dt-bindings: crypto: ti,sa2ul: make power-domains
 conditional
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230614-sa3ul-v4-1-7c969f626796@ti.com>
References: <20230614-sa3ul-v4-0-7c969f626796@ti.com>
In-Reply-To: <20230614-sa3ul-v4-0-7c969f626796@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jayesh Choudhary <j-choudhary@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kamlesh Gurudasani <kamlesh@ti.com>,
        Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687249695; l=1420;
 i=kamlesh@ti.com; s=20230614; h=from:subject:message-id;
 bh=9fFLiJzU0nj0ThkjDNPisO+/050gLX2S2toEaa+3810=;
 b=hZIGO2szRT25GerYQmO4Jq6Qssaj4zGAijghN1ci5tJLrgsDoC+CK2vJXXAhhaIwiyLeWR7JA
 UwgCauj2rEjCN9MIWQxyV3LWcvWYP0BkPaTnG3VTQbCoNRXS+hDc9SS
X-Developer-Key: i=kamlesh@ti.com; a=ed25519;
 pk=db9XKPVWDGJVqj2jDqgnPQd6uQf3GZ3oaQa4bq1odGo=
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

Devices specific to compatible ti,am62-sa3ul don't have control over
power of SA3UL from main domain.

"power-domains" property in crypto node tries to access
the SA3UL power, for which it gets NACK and hence, driver doesn't
probe properly for those particular devices.

Make "power-domains" property as false for devices with
compatible ti,am62-sa3ul.

Fixes: 2ce9a7299bf6 ("dt-bindings: crypto: Add TI SA2UL crypto accelerator documentation")

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
---
 Documentation/devicetree/bindings/crypto/ti,sa2ul.yaml | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/crypto/ti,sa2ul.yaml b/Documentation/devicetree/bindings/crypto/ti,sa2ul.yaml
index 77ec8bc70bf7..f0ef7685550a 100644
--- a/Documentation/devicetree/bindings/crypto/ti,sa2ul.yaml
+++ b/Documentation/devicetree/bindings/crypto/ti,sa2ul.yaml
@@ -66,10 +66,22 @@ patternProperties:
 required:
   - compatible
   - reg
-  - power-domains
   - dmas
   - dma-names
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: ti,am62-sa3ul
+    then:
+      properties:
+        power-domains: false
+    else:
+      required:
+        - power-domains
+
 additionalProperties: false
 
 examples:

-- 
2.34.1

