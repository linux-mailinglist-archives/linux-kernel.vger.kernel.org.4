Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF07D6CD7AC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 12:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbjC2Kbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 06:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjC2Kbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 06:31:34 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76B31FD3;
        Wed, 29 Mar 2023 03:31:33 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32TAVPaD025103;
        Wed, 29 Mar 2023 05:31:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680085885;
        bh=rWvpNNJ+up2PcEOCe8VmeF+rx0Zow6iaE7KoOS+Bk1g=;
        h=From:Date:Subject:References:In-Reply-To:To:CC;
        b=P/STIhcpY0jfl8vkegNPXIvM23DUfAn2ya+KDI5q1B5ApuG/j1zypr+K3XrAr4oQb
         yyw9Wy9HDKCBSFbpoBkNQqwqaTNMkhfLBVaFSPncLOFZ4LQNJjiCZYdaFTYaLUPFUv
         rOJ6c1ko+K6UTaqjaNg1z2KYUOPp/81+CRGVC9I8=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32TAVPfd091299
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Mar 2023 05:31:25 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 29
 Mar 2023 05:31:24 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 29 Mar 2023 05:31:24 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32TAVOnh017588;
        Wed, 29 Mar 2023 05:31:24 -0500
From:   Jai Luthra <j-luthra@ti.com>
Date:   Wed, 29 Mar 2023 16:00:59 +0530
Subject: [PATCH v9 2/6] arm64: dts: ti: k3-am62-main: Add McASP nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230313-mcasp_upstream-v9-2-6d937efe4ec4@ti.com>
References: <20230313-mcasp_upstream-v9-0-6d937efe4ec4@ti.com>
In-Reply-To: <20230313-mcasp_upstream-v9-0-6d937efe4ec4@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Aradhya Bhatia <a-bhatia1@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Andrew Davis <afd@ti.com>, Jai Luthra <j-luthra@ti.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2740; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=3YQ8iDFX2K1gkT2KWC73dpEyDkmFbkpNff4cJhstfZY=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBkJBN1kjuCOtZrKHK2zbzhGOFDJzTrFTq6HAEz3
 5iI+rkWtJSJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZCQTdQAKCRBD3pH5JJpx
 RSsdD/wIQTiHOOHIbfPiLFhMUECamU44L21ta2ctu0mlNJMQdTcNGhzXQXW1iOjDJPlMljjBN0W
 BqTDMslU44w9I+opc3oSS8/ySU6aa8prj8h4BKVCUjXB287PSsXneMewg6APNYRGZjSu+CU+SUp
 KC+OTRXyv7zdxRx6LQTOqxQzp9p8FJ/lywKKwJB75LLYa06cbtFzvRxllmERTVfz+RJjhxPHOXd
 0PmPjRXaEDrcKwn6zSRwY4+cGaEDi12sA93kJIiqKboC33ed6m2CISKsUyRmH3tZIvW7gvyAcrT
 tdDhG+aHITzHSdoU3XkHcMTI1AC6PikcXLSGCLMmPWFqSIVtn8lvcecULCfR/MX9Q9KDssCBv1p
 P7GbvdMShmzjY+r3fw71d1ZHoG0IJHGPuw0NNdaW5PKZKZtkqD5PRPWU3KcYNFcRErv14WEl2cq
 T/t0mdhzHrtD0ncTLNzPCe+ggfsIGJ0YwjOqL9HkHsAjOIcnl0d7Gkkd1tCn+T+yfm2Ki5JkccH
 B/DbyrH/XITucfMmWT1h0sWS2cs9V+t04NECShQdbV4HsAbuZFa+MzJNqj00nDqF3xQqYIUqn+6
 vKBSVkpf+cTGfQsY/6K25h9lstDV8UD+nNBkHx9YmoV4dTOKpukNkq0BIgh5WCZLNnXyOp/RRYs
 1V7z0we61YT0kjg==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jayesh Choudhary <j-choudhary@ti.com>

Add the nodes for McASP 0-2.

Use the audio-friendly 96MHz main_1_hsdivout6_clk as clock parent
instead of the default 100Mhz main_2_hsdivout8_clk source.

Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
Reviewed-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 60 ++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index 16e14863d7df..b3e4857bbbe4 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -832,4 +832,64 @@ epwm2: pwm@23020000 {
 		clock-names = "tbclk", "fck";
 		status = "disabled";
 	};
+
+	mcasp0: audio-controller@2b00000 {
+		compatible = "ti,am33xx-mcasp-audio";
+		reg = <0x00 0x02b00000 0x00 0x2000>,
+		      <0x00 0x02b08000 0x00 0x400>;
+		reg-names = "mpu", "dat";
+		interrupts = <GIC_SPI 236 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 235 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "tx", "rx";
+
+		dmas = <&main_bcdma 0 0xc500 0>, <&main_bcdma 0 0x4500 0>;
+		dma-names = "tx", "rx";
+
+		clocks = <&k3_clks 190 0>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 190 0>;
+		assigned-clock-parents = <&k3_clks 190 2>;
+		power-domains = <&k3_pds 190 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	mcasp1: audio-controller@2b10000 {
+		compatible = "ti,am33xx-mcasp-audio";
+		reg = <0x00 0x02b10000 0x00 0x2000>,
+		      <0x00 0x02b18000 0x00 0x400>;
+		reg-names = "mpu", "dat";
+		interrupts = <GIC_SPI 238 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 237 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "tx", "rx";
+
+		dmas = <&main_bcdma 0 0xc501 0>, <&main_bcdma 0 0x4501 0>;
+		dma-names = "tx", "rx";
+
+		clocks = <&k3_clks 191 0>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 191 0>;
+		assigned-clock-parents = <&k3_clks 191 2>;
+		power-domains = <&k3_pds 191 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	mcasp2: audio-controller@2b20000 {
+		compatible = "ti,am33xx-mcasp-audio";
+		reg = <0x00 0x02b20000 0x00 0x2000>,
+		      <0x00 0x02b28000 0x00 0x400>;
+		reg-names = "mpu", "dat";
+		interrupts = <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 239 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "tx", "rx";
+
+		dmas = <&main_bcdma 0 0xc502 0>, <&main_bcdma 0 0x4502 0>;
+		dma-names = "tx", "rx";
+
+		clocks = <&k3_clks 192 0>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 192 0>;
+		assigned-clock-parents = <&k3_clks 192 2>;
+		power-domains = <&k3_pds 192 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
 };

-- 
2.40.0

