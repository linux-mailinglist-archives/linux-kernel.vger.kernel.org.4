Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A736C7A76
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 09:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbjCXIz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 04:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbjCXIzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 04:55:39 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5A427488;
        Fri, 24 Mar 2023 01:55:38 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32O8tRRY109212;
        Fri, 24 Mar 2023 03:55:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1679648127;
        bh=kVU3fxPuN+E3YCIbaYl85jZLwsmV6nxyeKf/SyfMpTk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=WXt9eqYe59gNYfRB+3YXYCgRfBi8Lw7rjzoFj/3tNkuCF1B0B3GZsRlvduxt9VjxI
         NuAagPOJSDuhBYLEuEr8S7K2CUlRiOLoL6ham4bwEEnWvmuddjzZOzW26im2RFezBx
         UGPttihiCAkwbgipW1O/K1xb05rZkIkUP6tSJIxA=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32O8tQ1C009006
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 24 Mar 2023 03:55:27 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 24
 Mar 2023 03:55:26 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 24 Mar 2023 03:55:26 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32O8tPLN035746;
        Fri, 24 Mar 2023 03:55:26 -0500
From:   Jai Luthra <j-luthra@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Aradhya Bhatia <a-bhatia1@ti.com>, Jai Luthra <j-luthra@ti.com>
Subject: [PATCH v7 4/6] arm64: dts: ti: k3-am62a-main: Add nodes for McASP
Date:   Fri, 24 Mar 2023 14:25:18 +0530
Message-ID: <20230313-mcasp_upstream-v7-4-88168d0df9b8@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230313-mcasp_upstream-v7-0-88168d0df9b8@ti.com>
References: <20230313-mcasp_upstream-v7-0-88168d0df9b8@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2667; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=R63VlF5mAlSgoaVYF/ip213cmqYqKxSlEFrCk2GElqQ=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBkHWSI5i/+IIQ5VyWoX/UFqZpdb/WD+8IwUDFR9
 6NmRvK7yRiJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZB1kiAAKCRBD3pH5JJpx
 RSCBD/93JeCwg54WoVfmPssaJJpTzZCGw87uhXxbLrubwUPwAOn7V0Hqj0b5qweTLcjRQhRB6xD
 wfUjRdMNlT+sTdbfrRmpuJGCVn1X/vTHefC4eRgsfYJ1MOPqSNG3ZJgUNhMOfmcHivMNYDL8XuL
 hxyPaxQCQMBb0MEOTyUrS/M0FUg3suhocVEUAsE2mXE26DkPHcFFhxhDuHweienh24z7C7W/t0o
 sidikkYAALHOOe5npJnqqEhS9RKGl1T0jAwjY3Vx/mSEFirARzRGGq063u7YWTwwtdbbOkxzxtY
 mbJIKN/XfnsXbHtdEj6Arf4XEfSLTYf6vYvV/Ys57+iN5VtPt0m01NBzKzUOkhZNYShDdf77tzm
 cQe1b99xKSXdEtu4pCnzQx/AnFk6U7a8hScA33fQQpEIm3gnGXeOB1E/aEHXOdUCLlmyWJ4xYzr
 7YpNnq1tHDNy7vItmk2Bn4WuycBzEIuXGi+ItFQ/HXvVHBq4GQ3NXoowoXTjhAYXCH/Ev0ba1T9
 9ERKV66rfg+5rLY7OCp6A4O0HMGhjKA0ogJoJVjQJ18kFOfq/x8Mc/LWL1pI4zgRjMvKj/qBP3p
 kUh1HhlNhQ3cdFM2vKIMuTMQNdBTpN1wLSR73veKnuM846524xnmyUko1BYZqNMIYYCcpZ8T2eI
 ncVpV7cEccjKRfg==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp; fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Same as AM62, AM62A has three instances of McASP which can be used for
transmitting or receiving digital audio in various formats.

Signed-off-by: Jai Luthra <j-luthra@ti.com>
Reviewed-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi | 60 +++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
index 393a1a40b68b..50e4fcb1d678 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
@@ -660,4 +660,64 @@ ecap2: pwm@23120000 {
 		clock-names = "fck";
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

