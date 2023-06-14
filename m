Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060F972FCA3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 13:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244198AbjFNLgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 07:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235967AbjFNLgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 07:36:11 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443061BF3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 04:36:02 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f61d79b0f2so8726491e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 04:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686742560; x=1689334560;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OK0KHsEEJflt/PIWV1+p8wHbMvB3nj/Mo8p4VCQArys=;
        b=wkPePS6iqDnIoUgLTrHk1JbxyjqKjQE6dTMivQwJ2Uagbn22PSycxc2kHNuw5Wnh0K
         A872mUKQGzaS1r4627zJ+7zR3Tqlt4hOPeIi8YhTbxI+Sh+38uXCViQFweLYD1aeom12
         Mo/XWxSavm/n0EyVxaaTQKPA0DX7OIXpyvh1SiZ4QdIDETow9gurc1YqcZhqfNcMfEDI
         s1zn3JovHSyc6Ciiw8iI44YKEOGd9rSfUmJx2HtBslicjJFTCtxfgjOretdnPK2qhN53
         dzPVLrC9OEj8iJqDg5cAZpn1nADuta4WpRx0BWDq9wKSWxiNX6OyE64HbJWe/tw6gbgt
         bkJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686742560; x=1689334560;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OK0KHsEEJflt/PIWV1+p8wHbMvB3nj/Mo8p4VCQArys=;
        b=HylmrqwX5On7CjDJFf8VawknUrdutYJqoSlLJxIr8qm3XoKLmEsBu8W877EgBn+7No
         L8jyrqv/+Mny9SUlDUl8uhZf0XTZAelTYaOdywMqV/OPNqEPZEjgm09GEp2jBmZbczXl
         ZYnzhkabkvpwBfFFAKAKLwL46wYIxA9wBpOXLsMZv7Tb9kXAi/e9aZKVIAnumqe6q2Ux
         dJr9Qt047ZgwlnW4W9++rxUv8KdR1xX2YtGjNU5qMDwYjDwxDqRRNbYa5sb7AEaI2lIW
         gt4mnFyVTAzJgxmXG3PQvPJBY3PX3/eW9JdHFUyjEg/EOmpgJNwPqki3vh/NQ/ATOfY3
         YUnA==
X-Gm-Message-State: AC+VfDzn3tE/Yre35uco+QXHjxeM1s8hMcdsNHOm6JqCWuzr+04bOWt+
        wk28/Z+7IJqIGRPTWZtd7cZWsA==
X-Google-Smtp-Source: ACHHUZ6Jv2L4/laQwdvAL25VVQQcOYd7w/VONldqarBguPEoXB8kYEYUYufUH8sUlPFOxoJeyAJ+mA==
X-Received: by 2002:a19:3814:0:b0:4f7:66cc:6c91 with SMTP id f20-20020a193814000000b004f766cc6c91mr725672lfa.51.1686742560614;
        Wed, 14 Jun 2023 04:36:00 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id x1-20020ac25dc1000000b004f64b8eee61sm2088406lfq.97.2023.06.14.04.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 04:36:00 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 14 Jun 2023 13:35:38 +0200
Subject: [PATCH v2 7/7] arm64: dts: qcom: sm6350: Add DPU1 nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230315-topic-lagoon_gpu-v2-7-afcdfb18bb13@linaro.org>
References: <20230315-topic-lagoon_gpu-v2-0-afcdfb18bb13@linaro.org>
In-Reply-To: <20230315-topic-lagoon_gpu-v2-0-afcdfb18bb13@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686742545; l=6597;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=bsnWCyLq477XRxbXa0duMpQVLlZ96KNWwe53+HWkyB8=;
 b=5m91ZIomh7uCzHHK4pGHxRokpxD7jUD6gGr3KVRapmAWyvlSqLoShF+hl2KJrjb+QO+wBNG7V
 65EWxfz0B2OC0J30+k8Cf1KXcWsgHojKoEZFel1vB4H6/3fwpK8+Sre
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konrad Dybcio <konrad.dybcio@somainline.org>

Add nodes required to enable MDSS/DPU1 on SM6350. There seem to be no
additional changes required to support the derivative SoCs, such as
SM7225.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6350.dtsi | 218 +++++++++++++++++++++++++++++++++++
 1 file changed, 218 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index cc72c4b4e7c0..7af6278d6b23 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -4,6 +4,7 @@
  * Copyright (c) 2022, Luca Weiss <luca.weiss@fairphone.com>
  */
 
+#include <dt-bindings/clock/qcom,dispcc-sm6350.h>
 #include <dt-bindings/clock/qcom,gcc-sm6350.h>
 #include <dt-bindings/clock/qcom,gpucc-sm6350.h>
 #include <dt-bindings/clock/qcom,rpmh.h>
@@ -1869,6 +1870,223 @@ camcc: clock-controller@ad00000 {
 			#power-domain-cells = <1>;
 		};
 
+		mdss: display-subsystem@ae00000 {
+			compatible = "qcom,sm6350-mdss";
+			reg = <0 0x0ae00000 0 0x1000>;
+			reg-names = "mdss";
+
+			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			clocks = <&gcc GCC_DISP_AHB_CLK>,
+				 <&gcc GCC_DISP_AXI_CLK>,
+				 <&dispcc DISP_CC_MDSS_MDP_CLK>;
+			clock-names = "iface",
+				      "bus",
+				      "core";
+
+			power-domains = <&dispcc MDSS_GDSC>;
+			iommus = <&apps_smmu 0x800 0x2>;
+
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			status = "disabled";
+
+			mdss_mdp: display-controller@ae01000 {
+				compatible = "qcom,sm6350-dpu";
+				reg = <0 0x0ae01000 0 0x8f000>,
+				      <0 0x0aeb0000 0 0x2008>;
+				reg-names = "mdp", "vbif";
+
+				interrupt-parent = <&mdss>;
+				interrupts = <0>;
+
+				clocks = <&gcc GCC_DISP_AXI_CLK>,
+					 <&dispcc DISP_CC_MDSS_AHB_CLK>,
+					 <&dispcc DISP_CC_MDSS_ROT_CLK>,
+					 <&dispcc DISP_CC_MDSS_MDP_LUT_CLK>,
+					 <&dispcc DISP_CC_MDSS_MDP_CLK>,
+					 <&dispcc DISP_CC_MDSS_VSYNC_CLK>;
+				clock-names = "bus",
+					      "iface",
+					      "rot",
+					      "lut",
+					      "core",
+					      "vsync";
+
+				assigned-clocks = <&dispcc DISP_CC_MDSS_VSYNC_CLK>;
+				assigned-clock-rates = <19200000>;
+
+				operating-points-v2 = <&mdp_opp_table>;
+				power-domains = <&rpmhpd SM6350_CX>;
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+
+						dpu_intf1_out: endpoint {
+							remote-endpoint = <&mdss_dsi0_in>;
+						};
+					};
+				};
+
+				mdp_opp_table: opp-table {
+					compatible = "operating-points-v2";
+
+					opp-19200000 {
+						opp-hz = /bits/ 64 <19200000>;
+						required-opps = <&rpmhpd_opp_min_svs>;
+					};
+
+					opp-200000000 {
+						opp-hz = /bits/ 64 <200000000>;
+						required-opps = <&rpmhpd_opp_low_svs>;
+					};
+
+					opp-300000000 {
+						opp-hz = /bits/ 64 <300000000>;
+						required-opps = <&rpmhpd_opp_svs>;
+					};
+
+					opp-373333333 {
+						opp-hz = /bits/ 64 <373333333>;
+						required-opps = <&rpmhpd_opp_svs_l1>;
+					};
+
+					opp-448000000 {
+						opp-hz = /bits/ 64 <448000000>;
+						required-opps = <&rpmhpd_opp_nom>;
+					};
+
+					opp-560000000 {
+						opp-hz = /bits/ 64 <560000000>;
+						required-opps = <&rpmhpd_opp_turbo>;
+					};
+				};
+			};
+
+			mdss_dsi0: dsi@ae94000 {
+				compatible = "qcom,sm6350-dsi-ctrl", "qcom,mdss-dsi-ctrl";
+				reg = <0 0x0ae94000 0 0x400>;
+				reg-names = "dsi_ctrl";
+
+				interrupt-parent = <&mdss>;
+				interrupts = <4>;
+
+				clocks = <&dispcc DISP_CC_MDSS_BYTE0_CLK>,
+					 <&dispcc DISP_CC_MDSS_BYTE0_INTF_CLK>,
+					 <&dispcc DISP_CC_MDSS_PCLK0_CLK>,
+					 <&dispcc DISP_CC_MDSS_ESC0_CLK>,
+					 <&dispcc DISP_CC_MDSS_AHB_CLK>,
+					 <&gcc GCC_DISP_AXI_CLK>;
+				clock-names = "byte",
+					      "byte_intf",
+					      "pixel",
+					      "core",
+					      "iface",
+					      "bus";
+
+				assigned-clocks = <&dispcc DISP_CC_MDSS_BYTE0_CLK_SRC>,
+						  <&dispcc DISP_CC_MDSS_PCLK0_CLK_SRC>;
+				assigned-clock-parents = <&mdss_dsi0_phy 0>, <&mdss_dsi0_phy 1>;
+
+				operating-points-v2 = <&mdss_dsi_opp_table>;
+				power-domains = <&rpmhpd SM6350_MX>;
+
+				phys = <&mdss_dsi0_phy>;
+				phy-names = "dsi";
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				status = "disabled";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+
+						mdss_dsi0_in: endpoint {
+							remote-endpoint = <&dpu_intf1_out>;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+
+						mdss_dsi0_out: endpoint {
+						};
+					};
+				};
+
+				mdss_dsi_opp_table: opp-table {
+					compatible = "operating-points-v2";
+
+					opp-187500000 {
+						opp-hz = /bits/ 64 <187500000>;
+						required-opps = <&rpmhpd_opp_low_svs>;
+					};
+
+					opp-300000000 {
+						opp-hz = /bits/ 64 <300000000>;
+						required-opps = <&rpmhpd_opp_svs>;
+					};
+
+					opp-358000000 {
+						opp-hz = /bits/ 64 <358000000>;
+						required-opps = <&rpmhpd_opp_svs_l1>;
+					};
+				};
+			};
+
+			mdss_dsi0_phy: phy@ae94400 {
+				compatible = "qcom,dsi-phy-10nm";
+				reg = <0 0x0ae94400 0 0x200>,
+				      <0 0x0ae94600 0 0x280>,
+				      <0 0x0ae94a00 0 0x1e0>;
+				reg-names = "dsi_phy",
+					    "dsi_phy_lane",
+					    "dsi_pll";
+
+				#clock-cells = <1>;
+				#phy-cells = <0>;
+
+				clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
+					 <&rpmhcc RPMH_CXO_CLK>;
+				clock-names = "iface", "ref";
+
+				status = "disabled";
+			};
+		};
+
+		dispcc: clock-controller@af00000 {
+			compatible = "qcom,sm6350-dispcc";
+			reg = <0 0x0af00000 0 0x20000>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>,
+				 <&gcc GCC_DISP_GPLL0_CLK>,
+				 <&mdss_dsi0_phy 0>,
+				 <&mdss_dsi0_phy 1>,
+				 <&usb_1_qmpphy QMP_USB43DP_DP_LINK_CLK>,
+				 <&usb_1_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>;
+			clock-names = "bi_tcxo",
+				      "gcc_disp_gpll0_clk",
+				      "dsi0_phy_pll_out_byteclk",
+				      "dsi0_phy_pll_out_dsiclk",
+				      "dp_phy_pll_link_clk",
+				      "dp_phy_pll_vco_div_clk";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+		};
+
 		pdc: interrupt-controller@b220000 {
 			compatible = "qcom,sm6350-pdc", "qcom,pdc";
 			reg = <0 0x0b220000 0 0x30000>, <0 0x17c000f0 0 0x64>;

-- 
2.41.0

