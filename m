Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3068664C5F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 20:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239533AbjAJTXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 14:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235187AbjAJTWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 14:22:45 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF72551EC
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 11:22:43 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id j16-20020a05600c1c1000b003d9ef8c274bso6546087wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 11:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EIQZzMj+NHdju0t2ECocoqq5GGkKwpX9WdATXuG5dps=;
        b=yEc+gsDdkzGwE/FSyvNyEh1vt0FGFYMl37lXZIUPXRbd54Bz/By5Bk7TQ5m8PjY6sV
         R/o2ewqkyU8ePtCmw1uB7uN9rjeMIgp8hoWWxERpC0+NWepPXfAvGZXqeWvyv4BLTaF8
         c+uZy/yeUX20RjF7fGO+BmIpgfMTPiWY0647WOR5ACyhN1gVsm8s4fPRCzIAiomk3VWS
         +Oy46WN80//y9dvbWjnnEK/pOOwlIQq+SeNrii3m5VBu9dvXd/kmSlIFhRz5qmITgczA
         FHhXchJNP9oJLi+6bKJEwn7x42YDUUCbWBOob3kJSm1qRDZWt3H5mQzHWh4urebns+5b
         5xVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EIQZzMj+NHdju0t2ECocoqq5GGkKwpX9WdATXuG5dps=;
        b=PFMf/xVxSTEgxl/ievU3sngdBQQr1qHsbQxg5Dzzr0snbgmpW0uKPAoejQJCvwjdWZ
         omR01mMxJsvWSnhqtX6tQpYCKc/laT52tEQz7dAQB0PJyS1g6cvNi6mGW+C5auzzb3tP
         9q5tPVTsVF0aSseO2kX4OCpsiZAEpzF9JnfrXq0NKusynn6NzwvUdMVMuzwhOj1OfeLP
         R/mXn2Vm06+t0D2tw8FCo7H7ndZV4u+1UHZ2D99y64eeLJbTsGtDAHd9RBiJgy6C8BGU
         Vli0dChRr3e4tmMLBEB6i2gO+VMfYJLblas/QtkCGq41lfIVqpwGNp9LpQs18F0dIrWZ
         6EaA==
X-Gm-Message-State: AFqh2kpNg0Ae6DAtHmESr3mqdXx9g9G+3tXyYz9xLhf+7VxXsIrUATGt
        lUHJGIVjzY1dC2I/FoMqEBauaw==
X-Google-Smtp-Source: AMrXdXsQ3jXXQ+9/7MqQL1QO2A97thYMfY62C5s3DqLGlNpE1/eOFpvuP28NAtdEmN5G5Jivb2s+yA==
X-Received: by 2002:a05:600c:4d20:b0:3d3:5737:3afb with SMTP id u32-20020a05600c4d2000b003d357373afbmr51067099wmp.41.1673378561804;
        Tue, 10 Jan 2023 11:22:41 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id l14-20020a05600c4f0e00b003d96c811d6dsm22284343wmq.30.2023.01.10.11.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 11:22:41 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 10 Jan 2023 20:22:36 +0100
Subject: [PATCH v2 1/3] arm64: dts: qcom: sm8550: add display hardware devices
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230104-topic-sm8550-upstream-dts-display-v2-1-9fbb15263e0d@linaro.org>
References: <20230104-topic-sm8550-upstream-dts-display-v2-0-9fbb15263e0d@linaro.org>
In-Reply-To: <20230104-topic-sm8550-upstream-dts-display-v2-0-9fbb15263e0d@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.11.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devices tree nodes describing display hardware on SM8550:
- Display Clock Controller
- MDSS
- MDP
- two DSI controllers and DSI PHYs

This does not provide support for DP controllers present on the SM8550.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 299 +++++++++++++++++++++++++++++++++++
 1 file changed, 299 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 2d9377e01c3f..243fffa19c35 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -6,6 +6,7 @@
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/clock/qcom,sm8550-gcc.h>
 #include <dt-bindings/clock/qcom,sm8550-tcsr.h>
+#include <dt-bindings/clock/qcom,sm8550-dispcc.h>
 #include <dt-bindings/dma/qcom-gpi.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -1455,6 +1456,304 @@ opp-202000000 {
 			};
 		};
 
+		mdss: display-subsystem@ae00000 {
+			compatible = "qcom,sm8550-mdss";
+			reg = <0 0x0ae00000 0 0x1000>;
+			reg-names = "mdss";
+
+			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
+				 <&gcc GCC_DISP_AHB_CLK>,
+				 <&gcc GCC_DISP_HF_AXI_CLK>,
+				 <&dispcc DISP_CC_MDSS_MDP_CLK>;
+
+			resets = <&dispcc DISP_CC_MDSS_CORE_BCR>;
+
+			power-domains = <&dispcc MDSS_GDSC>;
+
+			interconnects = <&mmss_noc MASTER_MDP 0 &gem_noc SLAVE_LLCC 0>,
+				        <&mc_virt MASTER_LLCC 0 &mc_virt SLAVE_EBI1 0>;
+			interconnect-names = "mdp0-mem", "mdp1-mem";
+
+			iommus = <&apps_smmu 0x1c00 0x2>;
+
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			status = "disabled";
+
+			mdss_mdp: display-controller@ae01000 {
+				compatible = "qcom,sm8550-dpu";
+				reg = <0 0x0ae01000 0 0x8f000>,
+				      <0 0x0aeb0000 0 0x2008>;
+				reg-names = "mdp", "vbif";
+
+				interrupt-parent = <&mdss>;
+				interrupts = <0>;
+
+				clocks = <&gcc GCC_DISP_AHB_CLK>,
+					<&gcc GCC_DISP_HF_AXI_CLK>,
+					<&dispcc DISP_CC_MDSS_AHB_CLK>,
+					<&dispcc DISP_CC_MDSS_MDP_LUT_CLK>,
+					<&dispcc DISP_CC_MDSS_MDP_CLK>,
+					<&dispcc DISP_CC_MDSS_VSYNC_CLK>;
+				clock-names = "bus",
+					      "nrt_bus",
+					      "iface",
+					      "lut",
+					      "core",
+					      "vsync";
+
+				power-domains = <&rpmhpd SM8550_MMCX>;
+
+				assigned-clocks = <&dispcc DISP_CC_MDSS_VSYNC_CLK>;
+				assigned-clock-rates = <19200000>;
+
+				operating-points-v2 = <&mdp_opp_table>;
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+						dpu_intf1_out: endpoint {
+							remote-endpoint = <&mdss_dsi0_in>;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+						dpu_intf2_out: endpoint {
+							remote-endpoint = <&mdss_dsi1_in>;
+						};
+					};
+				};
+
+				mdp_opp_table: opp-table {
+					compatible = "operating-points-v2";
+
+					opp-200000000 {
+						opp-hz = /bits/ 64 <200000000>;
+						required-opps = <&rpmhpd_opp_low_svs>;
+					};
+
+					opp-325000000 {
+						opp-hz = /bits/ 64 <325000000>;
+						required-opps = <&rpmhpd_opp_svs>;
+					};
+
+					opp-375000000 {
+						opp-hz = /bits/ 64 <375000000>;
+						required-opps = <&rpmhpd_opp_svs_l1>;
+					};
+
+					opp-514000000 {
+						opp-hz = /bits/ 64 <514000000>;
+						required-opps = <&rpmhpd_opp_nom>;
+					};
+				};
+			};
+
+			mdss_dsi0: dsi@ae94000 {
+				compatible = "qcom,mdss-dsi-ctrl";
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
+					 <&gcc GCC_DISP_HF_AXI_CLK>;
+				clock-names = "byte",
+					      "byte_intf",
+					      "pixel",
+					      "core",
+					      "iface",
+					      "bus";
+
+				power-domains = <&rpmhpd SM8550_MMCX>;
+
+				assigned-clocks = <&dispcc DISP_CC_MDSS_BYTE0_CLK_SRC>, <&dispcc DISP_CC_MDSS_PCLK0_CLK_SRC>;
+				assigned-clock-parents = <&mdss_dsi0_phy 0>, <&mdss_dsi0_phy 1>;
+
+				operating-points-v2 = <&mdss_dsi_opp_table>;
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
+						mdss_dsi0_in: endpoint {
+							remote-endpoint = <&dpu_intf1_out>;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
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
+			mdss_dsi0_phy: phy@ae95000 {
+				compatible = "qcom,sm8550-dsi-phy-4nm";
+				reg = <0 0x0ae95000 0 0x200>,
+				      <0 0x0ae95200 0 0x280>,
+				      <0 0x0ae95500 0 0x400>;
+				reg-names = "dsi_phy",
+					    "dsi_phy_lane",
+					    "dsi_pll";
+
+				clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
+					 <&rpmhcc RPMH_CXO_CLK>;
+				clock-names = "iface", "ref";
+
+				#clock-cells = <1>;
+				#phy-cells = <0>;
+
+				status = "disabled";
+			};
+
+			mdss_dsi1: dsi@ae96000 {
+				compatible = "qcom,mdss-dsi-ctrl";
+				reg = <0 0x0ae96000 0 0x400>;
+				reg-names = "dsi_ctrl";
+
+				interrupt-parent = <&mdss>;
+				interrupts = <5>;
+
+				clocks = <&dispcc DISP_CC_MDSS_BYTE1_CLK>,
+					 <&dispcc DISP_CC_MDSS_BYTE1_INTF_CLK>,
+					 <&dispcc DISP_CC_MDSS_PCLK1_CLK>,
+					 <&dispcc DISP_CC_MDSS_ESC1_CLK>,
+					 <&dispcc DISP_CC_MDSS_AHB_CLK>,
+					 <&gcc GCC_DISP_HF_AXI_CLK>;
+				clock-names = "byte",
+					      "byte_intf",
+					      "pixel",
+					      "core",
+					      "iface",
+					      "bus";
+
+				power-domains = <&rpmhpd SM8550_MMCX>;
+
+				assigned-clocks = <&dispcc DISP_CC_MDSS_BYTE1_CLK_SRC>, <&dispcc DISP_CC_MDSS_PCLK1_CLK_SRC>;
+				assigned-clock-parents = <&mdss_dsi1_phy 0>, <&mdss_dsi1_phy 1>;
+
+				operating-points-v2 = <&mdss_dsi_opp_table>;
+
+				phys = <&mdss_dsi1_phy>;
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
+						mdss_dsi1_in: endpoint {
+							remote-endpoint = <&dpu_intf2_out>;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+						mdss_dsi1_out: endpoint {
+						};
+					};
+				};
+			};
+
+			mdss_dsi1_phy: phy@ae97000 {
+				compatible = "qcom,sm8550-dsi-phy-4nm";
+				reg = <0 0x0ae97000 0 0x200>,
+				      <0 0x0ae97200 0 0x280>,
+				      <0 0x0ae97500 0 0x400>;
+				reg-names = "dsi_phy",
+					    "dsi_phy_lane",
+					    "dsi_pll";
+
+				clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
+					 <&rpmhcc RPMH_CXO_CLK>;
+				clock-names = "iface", "ref";
+
+				#clock-cells = <1>;
+				#phy-cells = <0>;
+
+				status = "disabled";
+			};
+		};
+
+		dispcc: clock-controller@af00000 {
+			compatible = "qcom,sm8550-dispcc";
+			reg = <0 0x0af00000 0 0x20000>;
+			clocks = <&bi_tcxo_div2>,
+				 <&bi_tcxo_ao_div2>,
+				 <&gcc GCC_DISP_AHB_CLK>,
+				 <&sleep_clk>,
+				 <&mdss_dsi0_phy 0>,
+				 <&mdss_dsi0_phy 1>,
+				 <&mdss_dsi1_phy 0>,
+				 <&mdss_dsi1_phy 1>,
+				 <0>, /* dp0 */
+				 <0>,
+				 <0>, /* dp1 */
+				 <0>,
+				 <0>, /* dp2 */
+				 <0>,
+				 <0>, /* dp3 */
+				 <0>;
+			power-domains = <&rpmhpd SM8550_MMCX>;
+			required-opps = <&rpmhpd_opp_low_svs>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+			status = "disabled";
+		};
+
 		pdc: interrupt-controller@b220000 {
 			compatible = "qcom,sm8550-pdc", "qcom,pdc";
 			reg = <0 0x0b220000 0 0x30000>, <0 0x174000f0 0 0x64>;

-- 
2.34.1
