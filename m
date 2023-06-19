Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA9373588E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 15:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbjFSN30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 09:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjFSN3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 09:29:21 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1194018D;
        Mon, 19 Jun 2023 06:29:20 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35JDTE0E071572;
        Mon, 19 Jun 2023 08:29:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1687181354;
        bh=rJduMobeRC/tMg1rZKpZ/oOwoM1dMAtCWKvjPlh0XDs=;
        h=From:Date:Subject:References:In-Reply-To:To:CC;
        b=ZthdKPMF4jYqaI2JeOB827Hq4VcAmSArfCpE+GTwB8X41b2UC6/zseeQhpEq8obQf
         ekT1ySOaoWZwxGSBOfKlVDxsIWVnp5e2Czxv6h56QbAVOITiKSHF41Ayp192B1AlKt
         C0quJKi1WkdFpSAoI51rOntZFMph5gKJpeUSMgb0=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35JDTEPP082914
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 19 Jun 2023 08:29:14 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 19
 Jun 2023 08:29:14 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 19 Jun 2023 08:29:14 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 35JDTDOV008680;
        Mon, 19 Jun 2023 08:29:14 -0500
From:   Kamlesh Gurudasani <kamlesh@ti.com>
Date:   Mon, 19 Jun 2023 18:58:47 +0530
Subject: [PATCH v3 1/2] dt-bindings: crypto: ti,sa2ul: make power-domains
 conditional
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230614-sa3ul-v3-1-2eeb810327a1@ti.com>
References: <20230614-sa3ul-v3-0-2eeb810327a1@ti.com>
In-Reply-To: <20230614-sa3ul-v3-0-2eeb810327a1@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jayesh Choudhary <j-choudhary@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kamlesh Gurudasani <kamlesh@ti.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687181351; l=1267;
 i=kamlesh@ti.com; s=20230614; h=from:subject:message-id;
 bh=M3s6KmpyVsIj0WkuttZ1UlVMKN1GIG2n/jJbvX2d0qY=;
 b=/lo7nroG7Wz+d4nNjPuVF7Dnhwp5ArMxd4f5+IjIcq1VsvXr0AQCe+ameXJuk3FSEuRF1djRs
 ljYirhyeQaRAYiaC0D4e+MYx24TnU9o81nTlH0Zy8k/F0I0bqlqPHcK
X-Developer-Key: i=kamlesh@ti.com; a=ed25519;
 pk=db9XKPVWDGJVqj2jDqgnPQd6uQf3GZ3oaQa4bq1odGo=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
---
 Documentation/devicetree/bindings/crypto/ti,sa2ul.yaml | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/crypto/ti,sa2ul.yaml b/Documentation/devicetree/bindings/crypto/ti,sa2ul.yaml
index 77ec8bc70bf7..88c8ee8821d4 100644
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
+          items:
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

