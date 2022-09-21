Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424575BF42D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 05:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbiIUDPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 23:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbiIUDOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 23:14:03 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB657E31A;
        Tue, 20 Sep 2022 20:13:59 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 28L3DtWq051276;
        Tue, 20 Sep 2022 22:13:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1663730035;
        bh=AtcwFOGurorrsS8M3cTE6kweZ9sEB5pQonVGxy23QvM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=JgZm9WaAyJLIzpIAoLiscThcPOPGtX106gcMQgw583SD1ZghI56LBlkM6W24Jt4kZ
         Hefau7sCElJ8+WC3G+M5dYIlU+NLzvxuv2To4FP3Q1c3HfyhDPFId5z2gJ/ZMzOsGK
         SUMFAbxZyp5M2vDZKeuUSoRp1UAq1OQvbnOuo7pU=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 28L3Dtu2044270
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 20 Sep 2022 22:13:55 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 20
 Sep 2022 22:13:55 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 20 Sep 2022 22:13:55 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 28L3DqpU011186;
        Tue, 20 Sep 2022 22:13:54 -0500
From:   Matt Ranostay <mranostay@ti.com>
To:     <vigneshr@ti.com>, <nm@ti.com>, <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Matt Ranostay <mranostay@ti.com>
Subject: [PATCH v3 7/9] dt-bindings: PCI: Add host mode device-id for j721s2 platform
Date:   Tue, 20 Sep 2022 20:13:25 -0700
Message-ID: <20220921031327.4135-8-mranostay@ti.com>
X-Mailer: git-send-email 2.38.0.rc0.52.gdda7228a83
In-Reply-To: <20220921031327.4135-1-mranostay@ti.com>
References: <20220921031327.4135-1-mranostay@ti.com>
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

Add unique device-id of 0xb013 for j721s2 platform to oneOf field.

Signed-off-by: Matt Ranostay <mranostay@ti.com>
---
 Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
index 2115d5a3f0e1..ba8def03b691 100644
--- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
@@ -73,6 +73,8 @@ properties:
           - const: 0xb00f
       - items:
           - const: 0xb010
+      - items:
+          - const: 0xb013
 
   msi-map: true
 
-- 
2.37.2

