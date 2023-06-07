Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC0972611F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 15:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240710AbjFGNVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 09:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240692AbjFGNVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 09:21:03 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC37199D;
        Wed,  7 Jun 2023 06:20:56 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 357DKj2c016851;
        Wed, 7 Jun 2023 08:20:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686144045;
        bh=lQ9KjbvxE3j9yC5+Om6A5/Y7rEpOZvFiU5fWmoyxTmI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=dpGQYvhDVwl6XGQE/YefYKTnlhKsNm0+w3fOGn8If52hPp8vHOpPmmS58lry/ocD4
         wwLv3rC8OUHUgLol9M/bdLyYMzNRB7hoAkGlKEBppinVx7ZXfPcw0lkDVyGUXRIF2p
         hQd562u6OIwSuJh0ESa7+PAoL8uFjbxclLObvYuY=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 357DKjI8006692
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 7 Jun 2023 08:20:45 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Jun 2023 08:20:45 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Jun 2023 08:20:45 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 357DKjYw089301;
        Wed, 7 Jun 2023 08:20:45 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Andrew Davis <afd@ti.com>,
        Nishanth Menon <nm@ti.com>
Subject: [PATCH V3 1/3] arm64: dts: ti: k3-am65-main: Fix mcan node name
Date:   Wed, 7 Jun 2023 08:20:41 -0500
Message-ID: <20230607132043.3932726-2-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230607132043.3932726-1-nm@ti.com>
References: <20230607132043.3932726-1-nm@ti.com>
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

s/mcan/can to stay in sync with bindings conventions.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
No change from V2
V2: https://lore.kernel.org/r/20230606160643.3618390-3-nm@ti.com/
V1: https://lore.kernel.org/r/20230424144949.244135-5-nm@ti.com
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
index 5dfa31840e9c..c2519d4607a5 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
@@ -227,7 +227,7 @@ mcu_udmap: dma-controller@285c0000 {
 		};
 	};
 
-	m_can0: mcan@40528000 {
+	m_can0: can@40528000 {
 		compatible = "bosch,m_can";
 		reg = <0x0 0x40528000 0x0 0x400>,
 		      <0x0 0x40500000 0x0 0x4400>;
@@ -243,7 +243,7 @@ m_can0: mcan@40528000 {
 		status = "disabled";
 	};
 
-	m_can1: mcan@40568000 {
+	m_can1: can@40568000 {
 		compatible = "bosch,m_can";
 		reg = <0x0 0x40568000 0x0 0x400>,
 		      <0x0 0x40540000 0x0 0x4400>;
-- 
2.40.0

