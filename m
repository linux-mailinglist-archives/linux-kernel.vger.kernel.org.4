Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8280166529C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 05:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235676AbjAKEAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 23:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235240AbjAKD7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 22:59:34 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3D01261E;
        Tue, 10 Jan 2023 19:59:32 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30B3qbfx030396;
        Wed, 11 Jan 2023 03:59:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=s5XOgcEaPvRJJmBk2sTCThTwlERzvoo2f4JEX8cKdG8=;
 b=DOrOW02Kt86YrBPdrurm8dEaZRIdwlFiazdpW7TGHmmXJP85rJ6WEbH7438Od8LEzPYI
 W8hc6QgWOZw5UTd5XuwySj8JpkL8OFljl/atjq62FBDbgIhM+gWzql4nT2NxCGqdVPcT
 OEbpaeh2fdrJdkiO+UlDbaypdLGYoqQmZnCv/S4BHaKCAb5z/hMek3PSVg23p7cZE+7q
 Fo3yt0FlJgDQnrxYsglifXaVAjitzzC4LB2ABr5MO/LFFUhiIWvVpALm7NsDmhIAodrU
 ORcBh8PeaLvNt+yA/vvGryZHENzCfD5Y2FI7pj/vAABEL02uYlvpixJYFaApoFy+jfJt eA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n1kax87qs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Jan 2023 03:59:25 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30B3xP6d013217
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Jan 2023 03:59:25 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 10 Jan 2023 19:59:13 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Johan Hovold <johan@kernel.org>
CC:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v7 1/4] arm64: dts: qcom: sc8280xp: Define some of the display blocks
Date:   Tue, 10 Jan 2023 19:59:03 -0800
Message-ID: <20230111035906.2975494-2-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230111035906.2975494-1-quic_bjorande@quicinc.com>
References: <20230111035906.2975494-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ay3Hd5LiF4mFmuY4rLA7cKxNxVes7kMg
X-Proofpoint-GUID: ay3Hd5LiF4mFmuY4rLA7cKxNxVes7kMg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_10,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301110029
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

Define the display clock controllers, the MDSS instances, the DP phys
and connect these together.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---

Changes since v6:
- Dropped assigned-clock-rate on MDP_CLK
- Rearranged the properties in all nodes

 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 811 +++++++++++++++++++++++++
 1 file changed, 811 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 0ea2f19d471b..2ed17baf50d3 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -4,6 +4,7 @@
  * Copyright (c) 2022, Linaro Limited
  */
 
+#include <dt-bindings/clock/qcom,dispcc-sc8280xp.h>
 #include <dt-bindings/clock/qcom,gcc-sc8280xp.h>
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/interconnect/qcom,osm-l3.h>
@@ -2097,6 +2098,42 @@ usb_1_qmpphy: phy@8903000 {
 			status = "disabled";
 		};
 
+		mdss1_dp0_phy: phy@8909a00 {
+			compatible = "qcom,sc8280xp-dp-phy";
+			reg = <0 0x08909a00 0 0x19c>,
+			      <0 0x08909200 0 0xec>,
+			      <0 0x08909600 0 0xec>,
+			      <0 0x08909000 0 0x1c8>;
+
+			clocks = <&dispcc1 DISP_CC_MDSS_DPTX0_AUX_CLK>,
+				 <&dispcc1 DISP_CC_MDSS_AHB_CLK>;
+			clock-names = "aux", "cfg_ahb";
+			power-domains = <&rpmhpd SC8280XP_MX>;
+
+			#clock-cells = <1>;
+			#phy-cells = <0>;
+
+			status = "disabled";
+		};
+
+		mdss1_dp1_phy: phy@890ca00 {
+			compatible = "qcom,sc8280xp-dp-phy";
+			reg = <0 0x0890ca00 0 0x19c>,
+			      <0 0x0890c200 0 0xec>,
+			      <0 0x0890c600 0 0xec>,
+			      <0 0x0890c000 0 0x1c8>;
+
+			clocks = <&dispcc1 DISP_CC_MDSS_DPTX1_AUX_CLK>,
+				 <&dispcc1 DISP_CC_MDSS_AHB_CLK>;
+			clock-names = "aux", "cfg_ahb";
+			power-domains = <&rpmhpd SC8280XP_MX>;
+
+			#clock-cells = <1>;
+			#phy-cells = <0>;
+
+			status = "disabled";
+		};
+
 		pmu@9091000 {
 			compatible = "qcom,sc8280xp-llcc-bwmon", "qcom,sc7280-llcc-bwmon";
 			reg = <0 0x9091000 0 0x1000>;
@@ -2303,6 +2340,314 @@ usb_1_dwc3: usb@a800000 {
 			};
 		};
 
+		mdss0: display-subsystem@ae00000 {
+			compatible = "qcom,sc8280xp-mdss";
+			reg = <0 0x0ae00000 0 0x1000>;
+			reg-names = "mdss";
+
+			clocks = <&gcc GCC_DISP_AHB_CLK>,
+				 <&dispcc0 DISP_CC_MDSS_AHB_CLK>,
+				 <&dispcc0 DISP_CC_MDSS_MDP_CLK>;
+			clock-names = "iface",
+				      "ahb",
+				      "core";
+			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+			interconnects = <&mmss_noc MASTER_MDP0 0 &mc_virt SLAVE_EBI1 0>,
+					<&mmss_noc MASTER_MDP1 0 &mc_virt SLAVE_EBI1 0>;
+			interconnect-names = "mdp0-mem", "mdp1-mem";
+			iommus = <&apps_smmu 0x1000 0x402>;
+			power-domains = <&dispcc0 MDSS_GDSC>;
+			resets = <&dispcc0 DISP_CC_MDSS_CORE_BCR>;
+
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			status = "disabled";
+
+			mdss0_mdp: display-controller@ae01000 {
+				compatible = "qcom,sc8280xp-dpu";
+				reg = <0 0x0ae01000 0 0x8f000>,
+				      <0 0x0aeb0000 0 0x2008>;
+				reg-names = "mdp", "vbif";
+
+				clocks = <&gcc GCC_DISP_HF_AXI_CLK>,
+					 <&gcc GCC_DISP_SF_AXI_CLK>,
+					 <&dispcc0 DISP_CC_MDSS_AHB_CLK>,
+					 <&dispcc0 DISP_CC_MDSS_MDP_LUT_CLK>,
+					 <&dispcc0 DISP_CC_MDSS_MDP_CLK>,
+					 <&dispcc0 DISP_CC_MDSS_VSYNC_CLK>;
+				clock-names = "bus",
+					      "nrt_bus",
+					      "iface",
+					      "lut",
+					      "core",
+					      "vsync";
+				interrupt-parent = <&mdss0>;
+				interrupts = <0>;
+				power-domains = <&rpmhpd SC8280XP_MMCX>;
+
+				assigned-clocks = <&dispcc0 DISP_CC_MDSS_VSYNC_CLK>;
+				assigned-clock-rates = <19200000>;
+				operating-points-v2 = <&mdss0_mdp_opp_table>;
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@5 {
+						reg = <5>;
+						mdss0_intf5_out: endpoint {
+							remote-endpoint = <&mdss0_dp3_in>;
+						};
+					};
+
+					port@6 {
+						reg = <6>;
+						mdss0_intf6_out: endpoint {
+							remote-endpoint = <&mdss0_dp2_in>;
+						};
+					};
+				};
+
+				mdss0_mdp_opp_table: opp-table {
+					compatible = "operating-points-v2";
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
+					opp-375000000 {
+						opp-hz = /bits/ 64 <375000000>;
+						required-opps = <&rpmhpd_opp_svs_l1>;
+					};
+
+					opp-500000000 {
+						opp-hz = /bits/ 64 <500000000>;
+						required-opps = <&rpmhpd_opp_nom>;
+					};
+					opp-600000000 {
+						opp-hz = /bits/ 64 <600000000>;
+						required-opps = <&rpmhpd_opp_turbo_l1>;
+					};
+				};
+			};
+
+			mdss0_dp2: displayport-controller@ae9a000 {
+				compatible = "qcom,sc8280xp-dp";
+				reg = <0 0xae9a000 0 0x200>,
+				      <0 0xae9a200 0 0x200>,
+				      <0 0xae9a400 0 0x600>,
+				      <0 0xae9b000 0 0x400>;
+
+				clocks = <&dispcc0 DISP_CC_MDSS_AHB_CLK>,
+					 <&dispcc0 DISP_CC_MDSS_DPTX2_AUX_CLK>,
+					 <&dispcc0 DISP_CC_MDSS_DPTX2_LINK_CLK>,
+					 <&dispcc0 DISP_CC_MDSS_DPTX2_LINK_INTF_CLK>,
+					 <&dispcc0 DISP_CC_MDSS_DPTX2_PIXEL0_CLK>;
+				clock-names = "core_iface", "core_aux",
+					      "ctrl_link",
+					      "ctrl_link_iface", "stream_pixel";
+				interrupt-parent = <&mdss0>;
+				interrupts = <14>;
+				phys = <&mdss0_dp2_phy>;
+				phy-names = "dp";
+				power-domains = <&rpmhpd SC8280XP_MMCX>;
+
+				assigned-clocks = <&dispcc0 DISP_CC_MDSS_DPTX2_LINK_CLK_SRC>,
+						  <&dispcc0 DISP_CC_MDSS_DPTX2_PIXEL0_CLK_SRC>;
+				assigned-clock-parents = <&mdss0_dp2_phy 0>, <&mdss0_dp2_phy 1>;
+				operating-points-v2 = <&mdss0_dp2_opp_table>;
+
+				#sound-dai-cells = <0>;
+
+				status = "disabled";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+						mdss0_dp2_in: endpoint {
+							remote-endpoint = <&mdss0_intf6_out>;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+					};
+				};
+
+				mdss0_dp2_opp_table: opp-table {
+					compatible = "operating-points-v2";
+
+					opp-160000000 {
+						opp-hz = /bits/ 64 <160000000>;
+						required-opps = <&rpmhpd_opp_low_svs>;
+					};
+
+					opp-270000000 {
+						opp-hz = /bits/ 64 <270000000>;
+						required-opps = <&rpmhpd_opp_svs>;
+					};
+
+					opp-540000000 {
+						opp-hz = /bits/ 64 <540000000>;
+						required-opps = <&rpmhpd_opp_svs_l1>;
+					};
+
+					opp-810000000 {
+						opp-hz = /bits/ 64 <810000000>;
+						required-opps = <&rpmhpd_opp_nom>;
+					};
+				};
+			};
+
+			mdss0_dp3: displayport-controller@aea0000 {
+				compatible = "qcom,sc8280xp-dp";
+				reg = <0 0xaea0000 0 0x200>,
+				      <0 0xaea0200 0 0x200>,
+				      <0 0xaea0400 0 0x600>,
+				      <0 0xaea1000 0 0x400>;
+
+				clocks = <&dispcc0 DISP_CC_MDSS_AHB_CLK>,
+					 <&dispcc0 DISP_CC_MDSS_DPTX3_AUX_CLK>,
+					 <&dispcc0 DISP_CC_MDSS_DPTX3_LINK_CLK>,
+					 <&dispcc0 DISP_CC_MDSS_DPTX3_LINK_INTF_CLK>,
+					 <&dispcc0 DISP_CC_MDSS_DPTX3_PIXEL0_CLK>;
+				clock-names = "core_iface", "core_aux",
+					      "ctrl_link",
+					      "ctrl_link_iface", "stream_pixel";
+				interrupt-parent = <&mdss0>;
+				interrupts = <15>;
+				phys = <&mdss0_dp3_phy>;
+				phy-names = "dp";
+				power-domains = <&dispcc0 MDSS_GDSC>;
+
+				assigned-clocks = <&dispcc0 DISP_CC_MDSS_DPTX3_LINK_CLK_SRC>,
+						  <&dispcc0 DISP_CC_MDSS_DPTX3_PIXEL0_CLK_SRC>;
+				assigned-clock-parents = <&mdss0_dp3_phy 0>, <&mdss0_dp3_phy 1>;
+				operating-points-v2 = <&mdss0_dp3_opp_table>;
+
+				#sound-dai-cells = <0>;
+
+				status = "disabled";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+						mdss0_dp3_in: endpoint {
+							remote-endpoint = <&mdss0_intf5_out>;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+					};
+				};
+
+				mdss0_dp3_opp_table: opp-table {
+					compatible = "operating-points-v2";
+
+					opp-160000000 {
+						opp-hz = /bits/ 64 <160000000>;
+						required-opps = <&rpmhpd_opp_low_svs>;
+					};
+
+					opp-270000000 {
+						opp-hz = /bits/ 64 <270000000>;
+						required-opps = <&rpmhpd_opp_svs>;
+					};
+
+					opp-540000000 {
+						opp-hz = /bits/ 64 <540000000>;
+						required-opps = <&rpmhpd_opp_svs_l1>;
+					};
+
+					opp-810000000 {
+						opp-hz = /bits/ 64 <810000000>;
+						required-opps = <&rpmhpd_opp_nom>;
+					};
+				};
+			};
+		};
+
+		mdss0_dp2_phy: phy@aec2a00 {
+			compatible = "qcom,sc8280xp-dp-phy";
+			reg = <0 0x0aec2a00 0 0x19c>,
+			      <0 0x0aec2200 0 0xec>,
+			      <0 0x0aec2600 0 0xec>,
+			      <0 0x0aec2000 0 0x1c8>;
+
+			clocks = <&dispcc0 DISP_CC_MDSS_DPTX2_AUX_CLK>,
+				 <&dispcc0 DISP_CC_MDSS_AHB_CLK>;
+			clock-names = "aux", "cfg_ahb";
+			power-domains = <&rpmhpd SC8280XP_MX>;
+
+			#clock-cells = <1>;
+			#phy-cells = <0>;
+
+			status = "disabled";
+		};
+
+		mdss0_dp3_phy: phy@aec5a00 {
+			compatible = "qcom,sc8280xp-dp-phy";
+			reg = <0 0x0aec5a00 0 0x19c>,
+			      <0 0x0aec5200 0 0xec>,
+			      <0 0x0aec5600 0 0xec>,
+			      <0 0x0aec5000 0 0x1c8>;
+
+			clocks = <&dispcc0 DISP_CC_MDSS_DPTX3_AUX_CLK>,
+				 <&dispcc0 DISP_CC_MDSS_AHB_CLK>;
+			clock-names = "aux", "cfg_ahb";
+			power-domains = <&rpmhpd SC8280XP_MX>;
+
+			#clock-cells = <1>;
+			#phy-cells = <0>;
+
+			status = "disabled";
+		};
+
+		dispcc0: clock-controller@af00000 {
+			compatible = "qcom,sc8280xp-dispcc0";
+			reg = <0 0x0af00000 0 0x20000>;
+
+			clocks = <&gcc GCC_DISP_AHB_CLK>,
+				 <&rpmhcc RPMH_CXO_CLK>,
+				 <&sleep_clk>,
+				 <0>,
+				 <0>,
+				 <0>,
+				 <0>,
+				 <&mdss0_dp2_phy 0>,
+				 <&mdss0_dp2_phy 1>,
+				 <&mdss0_dp3_phy 0>,
+				 <&mdss0_dp3_phy 1>,
+				 <0>,
+				 <0>,
+				 <0>,
+				 <0>;
+			power-domains = <&rpmhpd SC8280XP_MMCX>;
+
+			#clock-cells = <1>;
+			#power-domain-cells = <1>;
+			#reset-cells = <1>;
+
+			status = "disabled";
+		};
+
 		pdc: interrupt-controller@b220000 {
 			compatible = "qcom,sc8280xp-pdc", "qcom,pdc";
 			reg = <0 0x0b220000 0 0x30000>, <0 0x17c000f0 0 0x60>;
@@ -2925,6 +3270,472 @@ IPCC_MPROC_SIGNAL_GLINK_QMP
 				qcom,remote-pid = <12>;
 			};
 		};
+
+		mdss1: display-subsystem@22000000 {
+			compatible = "qcom,sc8280xp-mdss";
+			reg = <0 0x22000000 0 0x1000>;
+			reg-names = "mdss";
+
+			clocks = <&gcc GCC_DISP_AHB_CLK>,
+				 <&dispcc1 DISP_CC_MDSS_AHB_CLK>,
+				 <&dispcc1 DISP_CC_MDSS_MDP_CLK>;
+			clock-names = "iface",
+				      "ahb",
+				      "core";
+			interconnects = <&mmss_noc MASTER_MDP_CORE1_0 0 &mc_virt SLAVE_EBI1 0>,
+					<&mmss_noc MASTER_MDP_CORE1_1 0 &mc_virt SLAVE_EBI1 0>;
+			interconnect-names = "mdp0-mem", "mdp1-mem";
+			interrupts = <GIC_SPI 865 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+
+			iommus = <&apps_smmu 0x1800 0x402>;
+			power-domains = <&dispcc1 MDSS_GDSC>;
+			resets = <&dispcc1 DISP_CC_MDSS_CORE_BCR>;
+
+			#interrupt-cells = <1>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			status = "disabled";
+
+			mdss1_mdp: display-controller@22001000 {
+				compatible = "qcom,sc8280xp-dpu";
+				reg = <0 0x22001000 0 0x8f000>,
+				      <0 0x220b0000 0 0x2008>;
+				reg-names = "mdp", "vbif";
+
+				clocks = <&gcc GCC_DISP_HF_AXI_CLK>,
+					 <&gcc GCC_DISP_SF_AXI_CLK>,
+					 <&dispcc1 DISP_CC_MDSS_AHB_CLK>,
+					 <&dispcc1 DISP_CC_MDSS_MDP_LUT_CLK>,
+					 <&dispcc1 DISP_CC_MDSS_MDP_CLK>,
+					 <&dispcc1 DISP_CC_MDSS_VSYNC_CLK>;
+				clock-names = "bus",
+					      "nrt_bus",
+					      "iface",
+					      "lut",
+					      "core",
+					      "vsync";
+				interrupt-parent = <&mdss1>;
+				interrupts = <0>;
+				power-domains = <&rpmhpd SC8280XP_MMCX>;
+
+				assigned-clocks = <&dispcc1 DISP_CC_MDSS_VSYNC_CLK>;
+				assigned-clock-rates = <19200000>;
+				operating-points-v2 = <&mdss1_mdp_opp_table>;
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+						mdss1_intf0_out: endpoint {
+							remote-endpoint = <&mdss1_dp0_in>;
+						};
+					};
+
+					port@4 {
+						reg = <4>;
+						mdss1_intf4_out: endpoint {
+							remote-endpoint = <&mdss1_dp1_in>;
+						};
+					};
+
+					port@5 {
+						reg = <5>;
+						mdss1_intf5_out: endpoint {
+							remote-endpoint = <&mdss1_dp3_in>;
+						};
+					};
+
+					port@6 {
+						reg = <6>;
+						mdss1_intf6_out: endpoint {
+							remote-endpoint = <&mdss1_dp2_in>;
+						};
+					};
+				};
+
+				mdss1_mdp_opp_table: opp-table {
+					compatible = "operating-points-v2";
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
+					opp-375000000 {
+						opp-hz = /bits/ 64 <375000000>;
+						required-opps = <&rpmhpd_opp_svs_l1>;
+					};
+
+					opp-500000000 {
+						opp-hz = /bits/ 64 <500000000>;
+						required-opps = <&rpmhpd_opp_nom>;
+					};
+					opp-600000000 {
+						opp-hz = /bits/ 64 <600000000>;
+						required-opps = <&rpmhpd_opp_turbo_l1>;
+					};
+				};
+			};
+
+			mdss1_dp0: displayport-controller@22090000 {
+				compatible = "qcom,sc8280xp-dp";
+				reg = <0 0x22090000 0 0x200>,
+				      <0 0x22090200 0 0x200>,
+				      <0 0x22090400 0 0x600>,
+				      <0 0x22091000 0 0x400>;
+
+				clocks = <&dispcc1 DISP_CC_MDSS_AHB_CLK>,
+					 <&dispcc1 DISP_CC_MDSS_DPTX0_AUX_CLK>,
+					 <&dispcc1 DISP_CC_MDSS_DPTX0_LINK_CLK>,
+					 <&dispcc1 DISP_CC_MDSS_DPTX0_LINK_INTF_CLK>,
+					 <&dispcc1 DISP_CC_MDSS_DPTX0_PIXEL0_CLK>;
+				clock-names = "core_iface", "core_aux",
+					      "ctrl_link",
+					      "ctrl_link_iface", "stream_pixel";
+				interrupt-parent = <&mdss1>;
+				interrupts = <12>;
+				phys = <&mdss1_dp0_phy>;
+				phy-names = "dp";
+				power-domains = <&rpmhpd SC8280XP_MMCX>;
+
+				assigned-clocks = <&dispcc1 DISP_CC_MDSS_DPTX0_LINK_CLK_SRC>,
+						  <&dispcc1 DISP_CC_MDSS_DPTX0_PIXEL0_CLK_SRC>;
+				assigned-clock-parents = <&mdss1_dp0_phy 0>, <&mdss1_dp0_phy 1>;
+				operating-points-v2 = <&mdss1_dp0_opp_table>;
+
+				#sound-dai-cells = <0>;
+
+				status = "disabled";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+						mdss1_dp0_in: endpoint {
+							remote-endpoint = <&mdss1_intf0_out>;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+					};
+				};
+
+				mdss1_dp0_opp_table: opp-table {
+					compatible = "operating-points-v2";
+
+					opp-160000000 {
+						opp-hz = /bits/ 64 <160000000>;
+						required-opps = <&rpmhpd_opp_low_svs>;
+					};
+
+					opp-270000000 {
+						opp-hz = /bits/ 64 <270000000>;
+						required-opps = <&rpmhpd_opp_svs>;
+					};
+
+					opp-540000000 {
+						opp-hz = /bits/ 64 <540000000>;
+						required-opps = <&rpmhpd_opp_svs_l1>;
+					};
+
+					opp-810000000 {
+						opp-hz = /bits/ 64 <810000000>;
+						required-opps = <&rpmhpd_opp_nom>;
+					};
+				};
+
+			};
+
+			mdss1_dp1: displayport-controller@22098000 {
+				compatible = "qcom,sc8280xp-dp";
+				reg = <0 0x22098000 0 0x200>,
+				      <0 0x22098200 0 0x200>,
+				      <0 0x22098400 0 0x600>,
+				      <0 0x22099000 0 0x400>;
+
+				clocks = <&dispcc1 DISP_CC_MDSS_AHB_CLK>,
+					 <&dispcc1 DISP_CC_MDSS_DPTX1_AUX_CLK>,
+					 <&dispcc1 DISP_CC_MDSS_DPTX1_LINK_CLK>,
+					 <&dispcc1 DISP_CC_MDSS_DPTX1_LINK_INTF_CLK>,
+					 <&dispcc1 DISP_CC_MDSS_DPTX1_PIXEL0_CLK>;
+				clock-names = "core_iface", "core_aux",
+					      "ctrl_link",
+					      "ctrl_link_iface", "stream_pixel";
+				interrupt-parent = <&mdss1>;
+				interrupts = <13>;
+				phys = <&mdss1_dp1_phy>;
+				phy-names = "dp";
+				power-domains = <&rpmhpd SC8280XP_MMCX>;
+
+				assigned-clocks = <&dispcc1 DISP_CC_MDSS_DPTX1_LINK_CLK_SRC>,
+						  <&dispcc1 DISP_CC_MDSS_DPTX1_PIXEL0_CLK_SRC>;
+				assigned-clock-parents = <&mdss1_dp1_phy 0>, <&mdss1_dp1_phy 1>;
+				operating-points-v2 = <&mdss1_dp1_opp_table>;
+
+				#sound-dai-cells = <0>;
+
+				status = "disabled";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+						mdss1_dp1_in: endpoint {
+							remote-endpoint = <&mdss1_intf4_out>;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+					};
+				};
+
+				mdss1_dp1_opp_table: opp-table {
+					compatible = "operating-points-v2";
+
+					opp-160000000 {
+						opp-hz = /bits/ 64 <160000000>;
+						required-opps = <&rpmhpd_opp_low_svs>;
+					};
+
+					opp-270000000 {
+						opp-hz = /bits/ 64 <270000000>;
+						required-opps = <&rpmhpd_opp_svs>;
+					};
+
+					opp-540000000 {
+						opp-hz = /bits/ 64 <540000000>;
+						required-opps = <&rpmhpd_opp_svs_l1>;
+					};
+
+					opp-810000000 {
+						opp-hz = /bits/ 64 <810000000>;
+						required-opps = <&rpmhpd_opp_nom>;
+					};
+				};
+			};
+
+			mdss1_dp2: displayport-controller@2209a000 {
+				compatible = "qcom,sc8280xp-dp";
+				reg = <0 0x2209a000 0 0x200>,
+				      <0 0x2209a200 0 0x200>,
+				      <0 0x2209a400 0 0x600>,
+				      <0 0x2209b000 0 0x400>;
+
+				clocks = <&dispcc1 DISP_CC_MDSS_AHB_CLK>,
+					 <&dispcc1 DISP_CC_MDSS_DPTX2_AUX_CLK>,
+					 <&dispcc1 DISP_CC_MDSS_DPTX2_LINK_CLK>,
+					 <&dispcc1 DISP_CC_MDSS_DPTX2_LINK_INTF_CLK>,
+					 <&dispcc1 DISP_CC_MDSS_DPTX2_PIXEL0_CLK>;
+				clock-names = "core_iface", "core_aux",
+					      "ctrl_link",
+					      "ctrl_link_iface", "stream_pixel";
+				interrupt-parent = <&mdss1>;
+				interrupts = <14>;
+				phys = <&mdss1_dp2_phy>;
+				phy-names = "dp";
+				power-domains = <&rpmhpd SC8280XP_MMCX>;
+
+				assigned-clocks = <&dispcc1 DISP_CC_MDSS_DPTX2_LINK_CLK_SRC>,
+						  <&dispcc1 DISP_CC_MDSS_DPTX2_PIXEL0_CLK_SRC>;
+				assigned-clock-parents = <&mdss1_dp2_phy 0>, <&mdss1_dp2_phy 1>;
+				operating-points-v2 = <&mdss1_dp2_opp_table>;
+
+				#sound-dai-cells = <0>;
+
+				status = "disabled";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+						mdss1_dp2_in: endpoint {
+							remote-endpoint = <&mdss1_intf6_out>;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+					};
+				};
+
+				mdss1_dp2_opp_table: opp-table {
+					compatible = "operating-points-v2";
+
+					opp-160000000 {
+						opp-hz = /bits/ 64 <160000000>;
+						required-opps = <&rpmhpd_opp_low_svs>;
+					};
+
+					opp-270000000 {
+						opp-hz = /bits/ 64 <270000000>;
+						required-opps = <&rpmhpd_opp_svs>;
+					};
+
+					opp-540000000 {
+						opp-hz = /bits/ 64 <540000000>;
+						required-opps = <&rpmhpd_opp_svs_l1>;
+					};
+
+					opp-810000000 {
+						opp-hz = /bits/ 64 <810000000>;
+						required-opps = <&rpmhpd_opp_nom>;
+					};
+				};
+			};
+
+			mdss1_dp3: displayport-controller@220a0000 {
+				compatible = "qcom,sc8280xp-dp";
+				reg = <0 0x220a0000 0 0x200>,
+				      <0 0x220a0200 0 0x200>,
+				      <0 0x220a0400 0 0x600>,
+				      <0 0x220a1000 0 0x400>;
+
+				clocks = <&dispcc1 DISP_CC_MDSS_AHB_CLK>,
+					 <&dispcc1 DISP_CC_MDSS_DPTX3_AUX_CLK>,
+					 <&dispcc1 DISP_CC_MDSS_DPTX3_LINK_CLK>,
+					 <&dispcc1 DISP_CC_MDSS_DPTX3_LINK_INTF_CLK>,
+					 <&dispcc1 DISP_CC_MDSS_DPTX3_PIXEL0_CLK>;
+				clock-names = "core_iface", "core_aux",
+					      "ctrl_link",
+					      "ctrl_link_iface", "stream_pixel";
+				interrupt-parent = <&mdss1>;
+				interrupts = <15>;
+				phys = <&mdss1_dp3_phy>;
+				phy-names = "dp";
+				power-domains = <&rpmhpd SC8280XP_MMCX>;
+
+				assigned-clocks = <&dispcc1 DISP_CC_MDSS_DPTX3_LINK_CLK_SRC>,
+						  <&dispcc1 DISP_CC_MDSS_DPTX3_PIXEL0_CLK_SRC>;
+				assigned-clock-parents = <&mdss1_dp3_phy 0>, <&mdss1_dp3_phy 1>;
+				operating-points-v2 = <&mdss1_dp3_opp_table>;
+
+				#sound-dai-cells = <0>;
+
+				status = "disabled";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+						mdss1_dp3_in: endpoint {
+							remote-endpoint = <&mdss1_intf5_out>;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+					};
+				};
+
+				mdss1_dp3_opp_table: opp-table {
+					compatible = "operating-points-v2";
+
+					opp-160000000 {
+						opp-hz = /bits/ 64 <160000000>;
+						required-opps = <&rpmhpd_opp_low_svs>;
+					};
+
+					opp-270000000 {
+						opp-hz = /bits/ 64 <270000000>;
+						required-opps = <&rpmhpd_opp_svs>;
+					};
+
+					opp-540000000 {
+						opp-hz = /bits/ 64 <540000000>;
+						required-opps = <&rpmhpd_opp_svs_l1>;
+					};
+
+					opp-810000000 {
+						opp-hz = /bits/ 64 <810000000>;
+						required-opps = <&rpmhpd_opp_nom>;
+					};
+				};
+			};
+		};
+
+		mdss1_dp2_phy: phy@220c2a00 {
+			compatible = "qcom,sc8280xp-dp-phy";
+			reg = <0 0x220c2a00 0 0x19c>,
+			      <0 0x220c2200 0 0xec>,
+			      <0 0x220c2600 0 0xec>,
+			      <0 0x220c2000 0 0x1c8>;
+
+			clocks = <&dispcc1 DISP_CC_MDSS_DPTX2_AUX_CLK>,
+				 <&dispcc1 DISP_CC_MDSS_AHB_CLK>;
+			clock-names = "aux", "cfg_ahb";
+			power-domains = <&rpmhpd SC8280XP_MX>;
+
+			#clock-cells = <1>;
+			#phy-cells = <0>;
+
+			status = "disabled";
+		};
+
+		mdss1_dp3_phy: phy@220c5a00 {
+			compatible = "qcom,sc8280xp-dp-phy";
+			reg = <0 0x220c5a00 0 0x19c>,
+			      <0 0x220c5200 0 0xec>,
+			      <0 0x220c5600 0 0xec>,
+			      <0 0x220c5000 0 0x1c8>;
+
+			clocks = <&dispcc1 DISP_CC_MDSS_DPTX3_AUX_CLK>,
+				 <&dispcc1 DISP_CC_MDSS_AHB_CLK>;
+			clock-names = "aux", "cfg_ahb";
+			power-domains = <&rpmhpd SC8280XP_MX>;
+
+			#clock-cells = <1>;
+			#phy-cells = <0>;
+
+			status = "disabled";
+		};
+
+		dispcc1: clock-controller@22100000 {
+			compatible = "qcom,sc8280xp-dispcc1";
+			reg = <0 0x22100000 0 0x20000>;
+
+			clocks = <&gcc GCC_DISP_AHB_CLK>,
+				 <&rpmhcc RPMH_CXO_CLK>,
+				 <0>,
+				 <&mdss1_dp0_phy 0>,
+				 <&mdss1_dp0_phy 1>,
+				 <&mdss1_dp1_phy 0>,
+				 <&mdss1_dp1_phy 1>,
+				 <&mdss1_dp2_phy 0>,
+				 <&mdss1_dp2_phy 1>,
+				 <&mdss1_dp3_phy 0>,
+				 <&mdss1_dp3_phy 1>,
+				 <0>,
+				 <0>,
+				 <0>,
+				 <0>;
+			power-domains = <&rpmhpd SC8280XP_MMCX>;
+
+			#clock-cells = <1>;
+			#power-domain-cells = <1>;
+			#reset-cells = <1>;
+
+			status = "disabled";
+		};
 	};
 
 	sound: sound {
-- 
2.37.3

