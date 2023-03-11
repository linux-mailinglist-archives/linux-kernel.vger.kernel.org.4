Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6B06B5AB4
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 11:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjCKK7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 05:59:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCKK7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 05:59:15 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E10AA768E;
        Sat, 11 Mar 2023 02:59:13 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32BAwwlJ124397;
        Sat, 11 Mar 2023 04:58:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678532338;
        bh=Q3OmIpHz8SOJdfFpUHaoWrQVCmkCMxF1H8FkBwgPJlY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=QM6Df8XIJfS+TnaMPPzu3xTKGzIQfvEuFWiRImMjcxvGqG7aZtVgFf7OzEVlWTKkD
         NqpEamddWp2Rtvh/NMTYhplX1Qm10juN67OlDEwCZ4vwrvoZEUU0LEX9g3o9vliBpS
         kCUXscuyRQ7O6Hur1CwxFn3XkJbbw5VZ1uO45+mE=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32BAwwXc002959
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 11 Mar 2023 04:58:58 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Sat, 11
 Mar 2023 04:58:57 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Sat, 11 Mar 2023 04:58:58 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32BAwvlq045037;
        Sat, 11 Mar 2023 04:58:57 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>, Julien Panis <jpanis@baylibre.com>,
        Bryan Brattlof <bb@ti.com>
Subject: [PATCH 1/2] arm64: dts: ti: k3-am62-wakeup: Introduce RTC node
Date:   Sat, 11 Mar 2023 04:58:49 -0600
Message-ID: <20230311105850.21811-2-nm@ti.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230311105850.21811-1-nm@ti.com>
References: <20230311105850.21811-1-nm@ti.com>
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

Introduce digital RTC node in wakeup domain. Even though this has
no specific battery backup supply, this on-chip RTC is used in
cost-optimized board designs as a wakeup source.

Signed-off-by: Nishanth Menon <nm@ti.com>
---

No previous version posted publicly.

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
2.37.2

