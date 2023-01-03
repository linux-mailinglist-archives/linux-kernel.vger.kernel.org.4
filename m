Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775D665B9FF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 05:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236638AbjACEVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 23:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232809AbjACEVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 23:21:34 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7111D5C;
        Mon,  2 Jan 2023 20:21:33 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3034LJrr052902;
        Mon, 2 Jan 2023 22:21:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1672719679;
        bh=PQ9cOrUm3n4VkDzCLAWjP9i+ayvQHzviTEzPi8T5BZk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=WFWfsaO0DVztqdYVY5MRmaFFi57jQx2r2pcm6fUpWAfpOo0vJfkyQBG5eDXKnOGiy
         yj0pTaX4QGnpew5q+hMUnQee12ZZkVHwU1Oq5XxUkw6YufaUomdpaQYp65Y0zARfz/
         4esDQbEHIXdTwCVvIlW94fKXSXHMtcHF+r6drANI=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3034LJ8s089990
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 2 Jan 2023 22:21:19 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 2
 Jan 2023 22:21:19 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 2 Jan 2023 22:21:19 -0600
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3034LDws084970;
        Mon, 2 Jan 2023 22:21:16 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bb@ti.com>
Subject: [PATCH 1/4] arm64: dts: ti: k3-am62a-mcu: Add MCU domain peripherals
Date:   Tue, 3 Jan 2023 09:51:07 +0530
Message-ID: <20230103042110.1092122-2-vigneshr@ti.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230103042110.1092122-1-vigneshr@ti.com>
References: <20230103042110.1092122-1-vigneshr@ti.com>
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

Introduce DT nodes for MCU domain SPIs and GPIO modules.

Co-developed-by: Bryan Brattlof <bb@ti.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi | 51 ++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi
index 6d1e501b94ab..2bb813e784a2 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi
@@ -36,4 +36,55 @@ mcu_i2c0: i2c@4900000 {
 		clock-names = "fck";
 		status = "disabled";
 	};
+
+	mcu_spi0: spi@4b00000 {
+		compatible = "ti,am654-mcspi", "ti,omap4-mcspi";
+		reg = <0x00 0x04b00000 0x00 0x400>;
+		interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 147 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 147 0>;
+		status = "disabled";
+	};
+
+	mcu_spi1: spi@4b10000 {
+		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
+		reg = <0x00 0x04b10000 0x00 0x400>;
+		interrupts = <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 148 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 148 0>;
+		status = "disabled";
+	};
+
+	mcu_gpio_intr: interrupt-controller@4210000 {
+		compatible = "ti,sci-intr";
+		reg = <0x00 0x04210000 0x00 0x200>;
+		ti,intr-trigger-type = <1>;
+		interrupt-controller;
+		interrupt-parent = <&gic500>;
+		#interrupt-cells = <1>;
+		ti,sci = <&dmsc>;
+		ti,sci-dev-id = <5>;
+		ti,interrupt-ranges = <0 104 4>;
+	};
+
+	mcu_gpio0: gpio@4201000 {
+		compatible = "ti,am64-gpio", "ti,keystone-gpio";
+		reg = <0x00 0x04201000 0x00 0x100>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&mcu_gpio_intr>;
+		interrupts = <30>, <31>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		ti,ngpio = <24>;
+		ti,davinci-gpio-unbanked = <0>;
+		power-domains = <&k3_pds 79 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 79 0>;
+		clock-names = "gpio";
+		status = "disabled";
+	};
 };
-- 
2.39.0

