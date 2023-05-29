Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A688171474D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 11:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbjE2JpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 05:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbjE2JpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 05:45:06 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C2D90;
        Mon, 29 May 2023 02:45:05 -0700 (PDT)
Received: from [192.168.122.1] (217-149-172-244.nat.highway.telekom.at [217.149.172.244])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 1A7BCCFC2B;
        Mon, 29 May 2023 09:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1685353503; bh=olIjx6WNF0x2y6WeKZc+6Pza/04SgAz6C7jo5EcOTi4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=p6UE9fXxzSn/W3LEX2Wav5xgnUoKZaGYthvYO9z5QQAHAM04kMSpmn6jT21acHtY6
         48clhABsraBmdF4kyjO6tid9TD0ollHJoBVMTYPwSnChKof/e07BlaFCUhnEOxAcGr
         GimB6IpKAPvvkT1fdRDrpaPoFv5uxzmgT+tvtaUU=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Mon, 29 May 2023 11:44:04 +0200
Subject: [PATCH 7/7] ARM: dts: qcom: msm8226: Add mdss nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230308-msm8226-mdp-v1-7-679f335d3d5b@z3ntu.xyz>
References: <20230308-msm8226-mdp-v1-0-679f335d3d5b@z3ntu.xyz>
In-Reply-To: <20230308-msm8226-mdp-v1-0-679f335d3d5b@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3341; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=olIjx6WNF0x2y6WeKZc+6Pza/04SgAz6C7jo5EcOTi4=;
 b=owEBbAKT/ZANAwAIAXLYQ7idTddWAcsmYgBkdHQY5R80arv9k0ADpEw1M/ChWf45zauAT8Z2m
 fs+d+RpiMaJAjIEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZHR0GAAKCRBy2EO4nU3X
 VkYQD/iP2kg+TmrA9D35SoXw/U3mupRc57sfecIUJokolunxh4MPPfeL5D0/3JT0Q5nNw4W0aSJ
 hA+sjtfobYWpluNHDMuDsJ0/DWoSfLqfWmudtS4133dC5B/RcyEXbubj+j4eSk0rJ8I2NQoUVy9
 Kme0Hha0vWs1U/GhFeGtTrwMilhFUpCgQGBvMqw/QTpL/7LOQ2Q+RNTr1giM51ne9Fcqsb8uRv/
 /H1QOyvRLBYXLK7DnPlcg3IGFhTV1k8EhUpHupw8aZkg+BosxMrsm5WPYgpay/4vEKc89NZvSMY
 ObZ2S+SqhNZf/tYkstu+U9lV4aUwG4gNj8Q784jvSww4+wfTmikSKV8FTJ1i86AP6bIfcrOnVU5
 8zOcuMm5YXNZdROr89hUCyJPq0nBxrEK/MAMoShvK8jHXVywrhotHNz1YgK1zj3CFbc4IwkGV4a
 SMTdfFLF1Rt9HAYfsvCz/CQ+9jotUu7PBqrVMwTFdHSB0Q8N3nvK/ax8ICUaJD72ha4YjaX92gm
 Yz6Lp1x8YpVEL9tUmBLVZbobPNy9NbUMhB/ax/LRP9m0P2Taz1JeVUEx8cNML7kpFj8sYh6Arf6
 qPKs2MVsCpEBlCA7oEwCNfQhlfdE6f9pGSMBK8UwpjxEhFWzUaJEzTbEhbF4mc2RUUZJzTxxdI3
 GeZAr3jjdUNyJ
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the nodes that describe the mdss so that display can work on
MSM8226.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm/boot/dts/qcom-msm8226.dtsi | 118 ++++++++++++++++++++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8226.dtsi b/arch/arm/boot/dts/qcom-msm8226.dtsi
index 42acb9ddb8cc..182d6405032f 100644
--- a/arch/arm/boot/dts/qcom-msm8226.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8226.dtsi
@@ -636,6 +636,124 @@ smd-edge {
 				label = "lpass";
 			};
 		};
+
+		mdss: display-subsystem@fd900000 {
+			compatible = "qcom,mdss";
+			reg = <0xfd900000 0x100>, <0xfd924000 0x1000>;
+			reg-names = "mdss_phys", "vbif_phys";
+
+			power-domains = <&mmcc MDSS_GDSC>;
+
+			clocks = <&mmcc MDSS_AHB_CLK>,
+				 <&mmcc MDSS_AXI_CLK>,
+				 <&mmcc MDSS_VSYNC_CLK>;
+			clock-names = "iface", "bus", "vsync";
+
+			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
+
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			status = "disabled";
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			mdp: display-controller@fd900000 {
+				compatible = "qcom,msm8226-mdp5", "qcom,mdp5";
+				reg = <0xfd900100 0x22000>;
+				reg-names = "mdp_phys";
+
+				interrupt-parent = <&mdss>;
+				interrupts = <0>;
+
+				clocks = <&mmcc MDSS_AHB_CLK>,
+					 <&mmcc MDSS_AXI_CLK>,
+					 <&mmcc MDSS_MDP_CLK>,
+					 <&mmcc MDSS_VSYNC_CLK>;
+				clock-names = "iface", "bus", "core", "vsync";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+						mdp5_intf1_out: endpoint {
+							remote-endpoint = <&dsi0_in>;
+						};
+					};
+				};
+			};
+
+			dsi0: dsi@fd922800 {
+				compatible = "qcom,msm8226-dsi-ctrl",
+					     "qcom,mdss-dsi-ctrl";
+				reg = <0xfd922800 0x1f8>;
+				reg-names = "dsi_ctrl";
+
+				interrupt-parent = <&mdss>;
+				interrupts = <4>;
+
+				assigned-clocks = <&mmcc BYTE0_CLK_SRC>, <&mmcc PCLK0_CLK_SRC>;
+				assigned-clock-parents = <&dsi_phy0 0>, <&dsi_phy0 1>;
+
+				clocks = <&mmcc MDSS_MDP_CLK>,
+					 <&mmcc MDSS_AHB_CLK>,
+					 <&mmcc MDSS_AXI_CLK>,
+					 <&mmcc MDSS_BYTE0_CLK>,
+					 <&mmcc MDSS_PCLK0_CLK>,
+					 <&mmcc MDSS_ESC0_CLK>,
+					 <&mmcc MMSS_MISC_AHB_CLK>;
+				clock-names = "mdp_core",
+					      "iface",
+					      "bus",
+					      "byte",
+					      "pixel",
+					      "core",
+					      "core_mmss";
+
+				phys = <&dsi_phy0>;
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+						dsi0_in: endpoint {
+							remote-endpoint = <&mdp5_intf1_out>;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+						dsi0_out: endpoint {
+						};
+					};
+				};
+			};
+
+			dsi_phy0: phy@fd922a00 {
+				compatible = "qcom,dsi-phy-28nm-8226";
+				reg = <0xfd922a00 0xd4>,
+				      <0xfd922b00 0x280>,
+				      <0xfd922d80 0x30>;
+				reg-names = "dsi_pll",
+					    "dsi_phy",
+					    "dsi_phy_regulator";
+
+				#clock-cells = <1>;
+				#phy-cells = <0>;
+
+				clocks = <&mmcc MDSS_AHB_CLK>, <&rpmcc RPM_SMD_XO_CLK_SRC>;
+				clock-names = "iface", "ref";
+			};
+		};
 	};
 
 	timer {

-- 
2.40.1

