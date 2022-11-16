Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C62C62BEED
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 14:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiKPNEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 08:04:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbiKPNEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 08:04:41 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7747519C20
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 05:04:40 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id cl5so29806753wrb.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 05:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PDPHEEaVB0ByL1QejxhqdfYXs09dfDHsAgFha8KgtL4=;
        b=t1tN4b5+HteefnAyzuoMnRbHP/OKr+FhL2R3KrmGshvdO/2yOAC5L1nunApO9Ug1CJ
         2pikDz2YiTIx/n0ZOqQPCIR9zmr3kqiisohrfkrXXHaHAT2qBzoNYG7liVCJKj1zpqO6
         +VTUqlhs//vB6ca2tNOcVodRsOCBFIxA/2HVKUsKE51nFgxGfUzBr692uEwPXVvBkSSO
         l/SDmavmp+2Q6q4F0WYlpEYfxZMCBRevn01opjSevsUQ9ryjpYuNITtyCjKg6OGPT9fI
         pJudUCdB02K3IaylmbiiYL5nH7xeYPEfuPCqp126ZogbZ/JzxHT9mytA6A6ygtHg0B0I
         pBJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PDPHEEaVB0ByL1QejxhqdfYXs09dfDHsAgFha8KgtL4=;
        b=7FYoybaAdtVa7MEH4xkw8w6VNguJdNQTZ5rRir0dZaqBbNnhlpCka6y9GoZui2YOFb
         8L/ypQ+98fM/CX27tfuBon3C40VTsVR4VGup3dQHrgJvZMWzkBgFO/JWYaKBx+tafH5G
         Sto2op5IE6vFY5DZU+uxkWfcIlAL4Gr/cE7IJQWQ1lysQfq2YKUMr9s51+N0Dm9ARJSp
         D5RPZRT7wHjuH+KWVDnr9W1reDkMjtKlLN3PkUTBGsMiPOxcjyDMz5mMmkYQVTe0g34I
         iCrIxhYhgw2xb3uescVlOHuD422DpI41CyYifCMV36wucS8TkQYm8B+fsRReMIMyAcRX
         DGUA==
X-Gm-Message-State: ANoB5pnhSmelc1TwSUj+y0/buM4oBbH+lo2oH3isjVlCGWkv4bHEFWhr
        rvhTChmT0fSzshtSdhp5tA/Jr3AcA5HXSA==
X-Google-Smtp-Source: AA0mqf5SOeVyL132+R8/3PlPJ85ApwjaCEgXrEHMd7gc+KeakbIo3eIASvrl4Q9ovmsKlGMqjcCk0Q==
X-Received: by 2002:a5d:56cb:0:b0:236:d611:84e1 with SMTP id m11-20020a5d56cb000000b00236d61184e1mr13891246wrw.328.1668603878999;
        Wed, 16 Nov 2022 05:04:38 -0800 (PST)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id co19-20020a0560000a1300b0022e66749437sm15130613wrb.93.2022.11.16.05.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 05:04:38 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: qcom: sm8550: Add PCIe PHYs and controllers nodes
Date:   Wed, 16 Nov 2022 15:04:29 +0200
Message-Id: <20221116130430.2812173-2-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221116130430.2812173-1-abel.vesa@linaro.org>
References: <20221116130430.2812173-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PCIe controllers and PHY nodes.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 245 +++++++++++++++++++++++++++
 1 file changed, 245 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 07ba709ca35f..5c274d0372ad 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -648,12 +648,16 @@ gcc: clock-controller@100000 {
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;
 			clock-names = "bi_tcxo", "sleep_clk",
+				      "pcie_0_pipe_clk",
+				      "pcie_1_pipe_clk",
 				      "pcie_1_phy_aux_clk",
 				      "ufs_phy_rx_symbol_0_clk",
 				      "ufs_phy_rx_symbol_1_clk",
 				      "ufs_phy_tx_symbol_0_clk",
 				      "usb3_phy_wrapper_gcc_usb30_pipe_clk";
 			clocks = <&rpmhcc RPMH_CXO_CLK>, <&sleep_clk>,
+				 <&pcie0_lane>,
+				 <&pcie1_lane>,
 				 <&pcie_1_phy_aux_clk>,
 				 <&ufs_phy_rx_symbol_0_clk>,
 				 <&ufs_phy_rx_symbol_1_clk>,
@@ -1372,6 +1376,247 @@ mmss_noc: interconnect@1780000 {
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
+		pcie0: pci@1c00000 {
+			compatible = "qcom,pcie-sm8550-pcie0";
+			reg = <0 0x01c00000 0 0x3000>,
+			      <0 0x60000000 0 0xf1d>,
+			      <0 0x60000f20 0 0xa8>,
+			      <0 0x60001000 0 0x1000>,
+			      <0 0x60100000 0 0x100000>;
+			reg-names = "parf", "dbi", "elbi", "atu", "config";
+			device_type = "pci";
+			linux,pci-domain = <0>;
+			bus-range = <0x00 0xff>;
+			num-lanes = <2>;
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			ranges = <0x01000000 0x0 0x60200000 0 0x60200000 0x0 0x100000>,
+				 <0x02000000 0x0 0x60300000 0 0x60300000 0x0 0x3d00000>;
+
+			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi";
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &intc 0 0 0 149 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+					<0 0 0 2 &intc 0 0 0 150 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+					<0 0 0 3 &intc 0 0 0 151 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+					<0 0 0 4 &intc 0 0 0 152 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+
+			interconnect-names = "icc_path";
+			interconnects = <&pcie_noc MASTER_PCIE_0 0 &mc_virt SLAVE_EBI1 0>;
+
+			clocks = <&gcc GCC_PCIE_0_PIPE_CLK>,
+				 <&gcc GCC_PCIE_0_PIPE_CLK_SRC>,
+				 <&pcie0_lane>,
+				 <&rpmhcc RPMH_CXO_CLK>,
+				 <&gcc GCC_PCIE_0_AUX_CLK>,
+				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
+				 <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
+				 <&gcc GCC_PCIE_0_SLV_AXI_CLK>,
+				 <&gcc GCC_PCIE_0_SLV_Q2A_AXI_CLK>,
+				 <&gcc GCC_DDRSS_PCIE_SF_QTB_CLK>,
+				 <&gcc GCC_AGGRE_NOC_PCIE_AXI_CLK>;
+			clock-names = "pipe",
+					"pipe_mux",
+					"phy_pipe",
+					"ref",
+					"aux",
+					"cfg",
+					"bus_master",
+					"bus_slave",
+					"slave_q2a",
+					"ddrss_sf_tbu",
+					"aggre0";
+
+			iommus = <&apps_smmu 0x1400 0x7f>;
+			iommu-map = <0x0   &apps_smmu 0x1400 0x1>,
+				    <0x100 &apps_smmu 0x1401 0x1>;
+
+			resets = <&gcc GCC_PCIE_0_BCR>;
+			reset-names = "pci";
+
+			power-domains = <&gcc PCIE_0_GDSC>;
+			power-domain-names = "gdsc";
+
+			phys = <&pcie0_lane>;
+			phy-names = "pciephy";
+
+			perst-gpios = <&tlmm 94 GPIO_ACTIVE_LOW>;
+			wake-gpios = <&tlmm 96 GPIO_ACTIVE_HIGH>;
+
+			pinctrl-names = "default";
+			pinctrl-0 = <&pcie0_default_state>;
+
+			status = "disabled";
+		};
+
+		pcie0_phy: phy@1c06000 {
+			compatible = "qcom,sm8550-qmp-gen3x2-pcie-phy";
+			reg = <0 0x01c06000 0 0x200>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+			clocks = <&gcc GCC_PCIE_0_AUX_CLK>,
+				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
+				 <&tcsr TCSR_PCIE_0_CLKREF_EN>,
+				 <&gcc GCC_PCIE_0_PHY_RCHNG_CLK>;
+			clock-names = "aux", "cfg_ahb", "ref", "refgen";
+
+			resets = <&gcc GCC_PCIE_0_PHY_BCR>;
+			reset-names = "phy";
+
+			assigned-clocks = <&gcc GCC_PCIE_0_PHY_RCHNG_CLK>;
+			assigned-clock-rates = <100000000>;
+
+			power-domains = <&gcc PCIE_0_PHY_GDSC>;
+			power-domain-names = "gdsc";
+
+			status = "disabled";
+
+			pcie0_lane: phy@1c06200 {
+				reg = <0 0x1c06e00 0 0x200>, /* tx0 */
+				      <0 0x1c07000 0 0x200>, /* rx0 */
+				      <0 0x1c06200 0 0x200>, /* pcs */
+				      <0 0x1c07600 0 0x200>, /* tx1 */
+				      <0 0x1c07800 0 0x200>, /* rx1 */
+				      <0 0x1c06600 0 0x200>; /* pcs_pcie */
+				clocks = <&gcc GCC_PCIE_0_PIPE_CLK>;
+				clock-names = "pipe0";
+
+				#clock-cells = <0>;
+				#phy-cells = <0>;
+				clock-output-names = "pcie_0_pipe_clk";
+			};
+		};
+
+		pcie1: pci@1c08000 {
+			compatible = "qcom,pcie-sm8550-pcie1";
+			reg = <0x0 0x01c08000 0x0 0x3000>,
+			      <0x0 0x40000000 0x0 0xf1d>,
+			      <0x0 0x40000f20 0x0 0xa8>,
+			      <0x0 0x40001000 0x0 0x1000>,
+			      <0x0 0x40100000 0x0 0x100000>;
+			reg-names = "parf", "dbi", "elbi", "atu", "config";
+			device_type = "pci";
+			linux,pci-domain = <1>;
+			bus-range = <0x00 0xff>;
+			num-lanes = <2>;
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			ranges = <0x01000000 0x0 0x40200000 0 0x40200000 0x0 0x100000>,
+				 <0x02000000 0x0 0x40300000 0 0x40300000 0x0 0x1fd00000>;
+
+			interrupts = <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi";
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &intc 0 0 0 434 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+					<0 0 0 2 &intc 0 0 0 435 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+					<0 0 0 3 &intc 0 0 0 438 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+					<0 0 0 4 &intc 0 0 0 439 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+
+			clocks = <&gcc GCC_PCIE_1_PIPE_CLK>,
+				 <&gcc GCC_PCIE_1_PIPE_CLK_SRC>,
+				 <&pcie1_lane>,
+				 <&rpmhcc RPMH_CXO_CLK>,
+				 <&gcc GCC_PCIE_1_AUX_CLK>,
+				 <&gcc GCC_PCIE_1_CFG_AHB_CLK>,
+				 <&gcc GCC_PCIE_1_MSTR_AXI_CLK>,
+				 <&gcc GCC_PCIE_1_SLV_AXI_CLK>,
+				 <&gcc GCC_PCIE_1_SLV_Q2A_AXI_CLK>,
+				 <&gcc GCC_DDRSS_PCIE_SF_QTB_CLK>,
+				 <&gcc GCC_AGGRE_NOC_PCIE_AXI_CLK>,
+				 <&gcc GCC_CNOC_PCIE_SF_AXI_CLK>;
+			clock-names = "pipe",
+					"pipe_mux",
+					"phy_pipe",
+					"ref",
+					"aux",
+					"cfg",
+					"bus_master",
+					"bus_slave",
+					"slave_q2a",
+					"ddrss_sf_tbu",
+					"aggre1",
+					"cnoc_pcie_sf_axi";
+
+			interconnect-names = "icc_path";
+			interconnects = <&pcie_noc MASTER_PCIE_1 0 &mc_virt SLAVE_EBI1 0>;
+
+			iommus = <&apps_smmu 0x1480 0x7f>;
+			iommu-map = <0x0   &apps_smmu 0x1480 0x1>,
+				    <0x100 &apps_smmu 0x1481 0x1>;
+
+			resets = <&gcc GCC_PCIE_1_BCR>,
+				<&gcc GCC_PCIE_1_LINK_DOWN_BCR>;
+			reset-names = "pci",
+				"pcie_1_link_down_reset";
+
+			power-domains = <&gcc PCIE_1_GDSC>;
+			power-domain-names = "gdsc";
+
+			phys = <&pcie1_lane>;
+			phy-names = "pciephy";
+
+			perst-gpios = <&tlmm 97 GPIO_ACTIVE_LOW>;
+			enable-gpios = <&tlmm 99 GPIO_ACTIVE_HIGH>;
+
+			pinctrl-names = "default";
+			pinctrl-0 = <&pcie1_default_state>;
+
+			assigned-clocks = <&gcc GCC_PCIE_1_AUX_CLK>;
+			assigned-clock-rates = <19200000>;
+
+			status = "disabled";
+		};
+
+		pcie1_phy: phy@1c0f000 {
+			compatible = "qcom,sm8550-qmp-gen4x2-pcie-phy";
+			reg = <0x0 0x01c0f000 0x0 0x200>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+			clocks = <&gcc GCC_PCIE_1_AUX_CLK>,
+				 <&gcc GCC_PCIE_1_PHY_AUX_CLK>,
+				 <&gcc GCC_PCIE_1_CFG_AHB_CLK>,
+				 <&tcsr TCSR_PCIE_1_CLKREF_EN>,
+				 <&gcc GCC_PCIE_1_PHY_RCHNG_CLK>;
+			clock-names = "aux", "aux_phy", "cfg_ahb", "ref", "refgen";
+
+			resets = <&gcc GCC_PCIE_1_PHY_BCR>,
+				<&gcc GCC_PCIE_1_NOCSR_COM_PHY_BCR>;
+			reset-names = "phy",
+				"pcie_1_nocsr_com_phy_reset";
+
+			assigned-clocks = <&gcc GCC_PCIE_1_PHY_RCHNG_CLK>;
+			assigned-clock-rates = <100000000>;
+
+			power-domains = <&gcc PCIE_1_PHY_GDSC>;
+			power-domain-names = "phy_gdsc";
+
+			status = "disabled";
+
+			pcie1_lane: phy@1c0e000 {
+				reg = <0x0 0x1c0e000 0x0 0x200>, /* tx */
+				      <0x0 0x1c0e200 0x0 0x300>, /* rx */
+				      <0x0 0x1c0f200 0x0 0x200>, /* pcs */
+				      <0x0 0x1c0e800 0x0 0x200>, /* tx */
+				      <0x0 0x1c0ea00 0x0 0x300>, /* rx */
+				      <0x0 0x1c0f400 0x0 0xc00>, /* pcs_pcie */
+				      <0x0 0x1c0ee00 0x0 0x0a0>; /* ln_shrd */
+				clocks = <&gcc GCC_PCIE_1_PIPE_CLK>;
+				clock-names = "pipe0";
+
+				#clock-cells = <0>;
+				#phy-cells = <0>;
+				clock-output-names = "pcie_1_pipe_clk";
+			};
+		};
+
 		tcsr_mutex: hwlock@1f40000 {
 			compatible = "qcom,tcsr-mutex";
 			reg = <0x0 0x01f40000 0x0 0x20000>;
-- 
2.34.1

