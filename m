Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E75CA6C1D0C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbjCTRAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 13:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232956AbjCTQ7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 12:59:38 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FDD199F1;
        Mon, 20 Mar 2023 09:53:00 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32KGpOJY021129;
        Mon, 20 Mar 2023 11:51:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1679331084;
        bh=QPyC/DbvOyWHYeXOzG9GugyttVskkFsiS09ljjL/M7g=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=fdgnjN4CmGalQTfpdpRkDjUlSwy9FxKuWVGKHdnmm/PBkh9wbGgcqawSZywMz+ViJ
         aehcilXnlO1V+xLHUSo5VPgDNkwjrAIrCS1JQb1KBdD+TyldpesqxT9IJlxT/9fjEO
         dXbPOhfMBCNEvL3VKw8XWXLP/GuPoJ/mLUEGZ0pw=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32KGpOdC094500
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Mar 2023 11:51:24 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 20
 Mar 2023 11:51:24 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 20 Mar 2023 11:51:24 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32KGpOQo021931;
        Mon, 20 Mar 2023 11:51:24 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Julien Panis <jpanis@baylibre.com>, <bb@ti.com>,
        <d-gole@ti.com>, Nishanth Menon <nm@ti.com>
Subject: [PATCH V3 1/2] arm64: dts: ti: k3-am62-wakeup: Introduce RTC node
Date:   Mon, 20 Mar 2023 11:51:22 -0500
Message-ID: <20230320165123.80561-2-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230320165123.80561-1-nm@ti.com>
References: <20230320165123.80561-1-nm@ti.com>
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

Introduce digital RTC node in wakeup domain. Even though this has
no specific battery backup supply, this on-chip RTC is used in
cost-optimized board designs as a wakeup source.

Reviewed-by: Dhruva Gole <d-gole@ti.com>
Reviewed-by: Bryan Brattlof <bb@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
Changes since v2:
- Just reviewed-by pickups

V2: https://lore.kernel.org/all/20230315170706.1598977-2-nm@ti.com/
V1: https://lore.kernel.org/all/20230311105850.21811-2-nm@ti.com/

 arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
index 38dced6b4fef..fec81546fbbd 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
@@ -40,4 +40,14 @@ wkup_i2c0: i2c@2b200000 {
 		clock-names = "fck";
 		status = "disabled";
 	};
+
+	wkup_rtc0: rtc@2b1f0000 {
+		compatible = "ti,am62-rtc";
+		reg = <0x00 0x2b1f0000 0x00 0x100>;
+		interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 117 6> , <&k3_clks 117 0>;
+		clock-names = "vbus", "osc32k";
+		power-domains = <&k3_pds 117 TI_SCI_PD_EXCLUSIVE>;
+		wakeup-source;
+	};
 };
-- 
2.40.0

