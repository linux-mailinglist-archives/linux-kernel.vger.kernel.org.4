Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA01724882
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 18:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238111AbjFFQHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 12:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237972AbjFFQG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 12:06:58 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34008119;
        Tue,  6 Jun 2023 09:06:57 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 356G6kcr016157;
        Tue, 6 Jun 2023 11:06:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686067606;
        bh=ljD/g7qmDFP7w55jqJZ8dj+/JkLV6kaxwIuFkiTg7mY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=WnC1WzarBFNXbHUvaq2U6+5hrUxLZMechZJH9STFuK3xpWGEKu6afh31o0kve4Ngw
         M0p5MB0v1Ay7sTthssLTdMXHp+apss///HqsdpJL5xxivbVM9t78GGMqk4rwDaAYK1
         Y9SHW/ZcgMZS2hTlJeOMZSA32kG+naslNY9C4dGg=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 356G6kaq109219
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Jun 2023 11:06:46 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Jun 2023 11:06:44 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Jun 2023 11:06:44 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 356G6iAt002951;
        Tue, 6 Jun 2023 11:06:44 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jan Kiszka <jan.kiszka@siemens.com>, Andrew Davis <afd@ti.com>,
        Nishanth Menon <nm@ti.com>
Subject: [PATCH V2 3/4] arm64: dts: ti: k3-am65-main: Drop deprecated ti,otap-del-sel property
Date:   Tue, 6 Jun 2023 11:06:42 -0500
Message-ID: <20230606160643.3618390-4-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230606160643.3618390-1-nm@ti.com>
References: <20230606160643.3618390-1-nm@ti.com>
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

ti,otap-del-sel has been deprecated in favor of ti,otap-del-sel-legacy.

Drop the duplicate and misleading ti,otap-del-sel property.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
No change since V1
V1: https://lore.kernel.org/r/20230424144949.244135-6-nm@ti.com
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index f64b4e782ec3..c2fe2ada3f0a 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -469,7 +469,6 @@ sdhci1: mmc@4fa0000 {
 		ti,otap-del-sel-ddr52 = <0x4>;
 		ti,otap-del-sel-hs200 = <0x7>;
 		ti,clkbuf-sel = <0x7>;
-		ti,otap-del-sel = <0x2>;
 		ti,trm-icp = <0x8>;
 		dma-coherent;
 	};
-- 
2.40.0

