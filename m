Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D1C6BD34E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 16:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbjCPPWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 11:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbjCPPWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 11:22:06 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3951B10273;
        Thu, 16 Mar 2023 08:22:03 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32GFLiGo123334;
        Thu, 16 Mar 2023 10:21:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678980104;
        bh=HrNGniLRgP7HdKD6uSWSl/WCnmM5MdlA92MQ1FPutwM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=xfVF/c0fu0izgUFqGk9e+TpOKFzXLbIA01M10fAICHezHoLYYpEGaB4EEr/vIW1Ub
         LczBnKI1KJRrH4lnIufZRFI9hIbgNUGeDbUw/f/iku95AIJq33Gq2a5nfLyO3Soho6
         pADvhCtYf59psmnTpiA6ODvWWx5P52ORTjNphzX8=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32GFLiOj029157
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 16 Mar 2023 10:21:44 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 16
 Mar 2023 10:21:44 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 16 Mar 2023 10:21:44 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32GFLibJ016157;
        Thu, 16 Mar 2023 10:21:44 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>, Julien Panis <jpanis@baylibre.com>,
        Bryan Brattlof <bb@ti.com>, Andrew Davis <afd@ti.com>,
        Jason Kridner <jkridner@gmail.com>,
        Robert Nelson <robertcnelson@gmail.com>
Subject: [PATCH V2 1/3] dt-bindings: arm: ti: Add BeaglePlay
Date:   Thu, 16 Mar 2023 10:21:41 -0500
Message-ID: <20230316152143.2438928-2-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230316152143.2438928-1-nm@ti.com>
References: <20230316152143.2438928-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Robert Nelson <robertcnelson@gmail.com>

This board is based on ti,am625

https://beagleplay.org/
https://git.beagleboard.org/beagleplay/beagleplay

Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
Co-developed-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
Changes since V1:
- $subject fixup to drop redundant binding verbage
- Sign-off order fixup.

V1: https://lore.kernel.org/all/20230311111022.23717-2-nm@ti.com/
 Documentation/devicetree/bindings/arm/ti/k3.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
index a60a4065caa8..b4703ac88f04 100644
--- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
@@ -28,6 +28,7 @@ properties:
       - description: K3 AM625 SoC
         items:
           - enum:
+              - beagle,am625-beagleplay
               - ti,am625-sk
           - const: ti,am625
 
-- 
2.40.0

