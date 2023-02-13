Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743A4694CB4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 17:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjBMQ2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 11:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjBMQ2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 11:28:48 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52ECACC0B;
        Mon, 13 Feb 2023 08:28:47 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31D8s4NC030248;
        Mon, 13 Feb 2023 16:28:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=EUcRMOs+JFnOIXugh6WW4bZ2T5jvv8NCSO4U7kYwseY=;
 b=Yoe0obGrDP6kK5wG87otfFsIEwmjuzQm6ZsNzuWPaZP2PcJVgtRWoH/+i+HuKQORuL2N
 pHQsrAHQsvgstuzrPkiMt5rjJEZzfyqwPeuPr5+fI64qymENrRDl6wtRlCg3U1BWs836
 blczw+UXeCbkhe6IyP0O+Xj9qfZ/EjhSNeJeH7U0QuiyjANMGG9CvRzLh/TaiW9V/UGm
 SO2//W4pPE6JUmR2LXqZvGiqYvDWc+qeLFJSxUaAbhN9I120uBvyPXBMs1VmoGo5lbo8
 0LxrCL4Kv02JgGG2bDSnYh4w8IN32G6z4UPN/qfgxQXAZFUVyg7L5HduKQHPL0TSOuI+ zQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3np342vq9t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 16:28:28 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31DGSRjR029687
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 16:28:27 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 13 Feb 2023 08:28:27 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 1/4] arm64: dts: qcom: sc8280xp: Add USB-C-related DP blocks
Date:   Mon, 13 Feb 2023 08:28:18 -0800
Message-ID: <20230213162821.1253831-2-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230213162821.1253831-1-quic_bjorande@quicinc.com>
References: <20230213162821.1253831-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4tNP_10XPmu0ShCzktT4L3lMIZX0oyos
X-Proofpoint-ORIG-GUID: 4tNP_10XPmu0ShCzktT4L3lMIZX0oyos
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_11,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302130149
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

Add the two DisplayPort controllers that are attached to QMP phys for
providing display output on USB Type-C.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---

Changes since v2:
- Added linebreak to clock-names.

 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 172 ++++++++++++++++++++++++-
 1 file changed, 168 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 52172f79f2f2..92d5b5e21e50 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -3155,6 +3155,20 @@ ports {
 					#address-cells = <1>;
 					#size-cells = <0>;
 
+					port@0 {
+						reg = <0>;
+						mdss0_intf0_out: endpoint {
+							remote-endpoint = <&mdss0_dp0_in>;
+						};
+					};
+
+					port@4 {
+						reg = <4>;
+						mdss0_intf4_out: endpoint {
+							remote-endpoint = <&mdss0_dp1_in>;
+						};
+					};
+
 					port@5 {
 						reg = <5>;
 						mdss0_intf5_out: endpoint {
@@ -3199,6 +3213,156 @@ opp-600000000 {
 				};
 			};
 
+			mdss0_dp0: displayport-controller@ae90000 {
+				compatible = "qcom,sc8280xp-dp";
+				reg = <0 0xae90000 0 0x200>,
+				      <0 0xae90200 0 0x200>,
+				      <0 0xae90400 0 0x600>,
+				      <0 0xae91000 0 0x400>,
+				      <0 0xae91400 0 0x400>;
+				interrupt-parent = <&mdss0>;
+				interrupts = <12>;
+				clocks = <&dispcc0 DISP_CC_MDSS_AHB_CLK>,
+					 <&dispcc0 DISP_CC_MDSS_DPTX0_AUX_CLK>,
+					 <&dispcc0 DISP_CC_MDSS_DPTX0_LINK_CLK>,
+					 <&dispcc0 DISP_CC_MDSS_DPTX0_LINK_INTF_CLK>,
+					 <&dispcc0 DISP_CC_MDSS_DPTX0_PIXEL0_CLK>;
+				clock-names = "core_iface", "core_aux",
+					      "ctrl_link",
+					      "ctrl_link_iface",
+					      "stream_pixel";
+
+				assigned-clocks = <&dispcc0 DISP_CC_MDSS_DPTX0_LINK_CLK_SRC>,
+						  <&dispcc0 DISP_CC_MDSS_DPTX0_PIXEL0_CLK_SRC>;
+				assigned-clock-parents = <&usb_0_qmpphy QMP_USB43DP_DP_LINK_CLK>,
+							 <&usb_0_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>;
+
+				phys = <&usb_0_qmpphy QMP_USB43DP_DP_PHY>;
+				phy-names = "dp";
+
+				#sound-dai-cells = <0>;
+
+				operating-points-v2 = <&mdss0_dp0_opp_table>;
+				power-domains = <&rpmhpd SC8280XP_CX>;
+
+				status = "disabled";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+						mdss0_dp0_in: endpoint {
+							remote-endpoint = <&mdss0_intf0_out>;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+					};
+				};
+
+				mdss0_dp0_opp_table: opp-table {
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
+			mdss0_dp1: displayport-controller@ae98000 {
+				compatible = "qcom,sc8280xp-dp";
+				reg = <0 0xae98000 0 0x200>,
+				      <0 0xae98200 0 0x200>,
+				      <0 0xae98400 0 0x600>,
+				      <0 0xae99000 0 0x400>,
+				      <0 0xae99400 0 0x400>;
+				interrupt-parent = <&mdss0>;
+				interrupts = <13>;
+				clocks = <&dispcc0 DISP_CC_MDSS_AHB_CLK>,
+					 <&dispcc0 DISP_CC_MDSS_DPTX1_AUX_CLK>,
+					 <&dispcc0 DISP_CC_MDSS_DPTX1_LINK_CLK>,
+					 <&dispcc0 DISP_CC_MDSS_DPTX1_LINK_INTF_CLK>,
+					 <&dispcc0 DISP_CC_MDSS_DPTX1_PIXEL0_CLK>;
+				clock-names = "core_iface", "core_aux",
+					      "ctrl_link",
+					      "ctrl_link_iface", "stream_pixel";
+
+				assigned-clocks = <&dispcc0 DISP_CC_MDSS_DPTX1_LINK_CLK_SRC>,
+						  <&dispcc0 DISP_CC_MDSS_DPTX1_PIXEL0_CLK_SRC>;
+				assigned-clock-parents = <&usb_1_qmpphy QMP_USB43DP_DP_LINK_CLK>,
+							 <&usb_1_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>;
+
+				phys = <&usb_1_qmpphy QMP_USB43DP_DP_PHY>;
+				phy-names = "dp";
+
+				#sound-dai-cells = <0>;
+
+				operating-points-v2 = <&mdss0_dp1_opp_table>;
+				power-domains = <&rpmhpd SC8280XP_CX>;
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
+						mdss0_dp1_in: endpoint {
+							remote-endpoint = <&mdss0_intf4_out>;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+					};
+				};
+
+				mdss0_dp1_opp_table: opp-table {
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
 			mdss0_dp2: displayport-controller@ae9a000 {
 				compatible = "qcom,sc8280xp-dp";
 				reg = <0 0xae9a000 0 0x200>,
@@ -3387,10 +3551,10 @@ dispcc0: clock-controller@af00000 {
 			clocks = <&gcc GCC_DISP_AHB_CLK>,
 				 <&rpmhcc RPMH_CXO_CLK>,
 				 <&sleep_clk>,
-				 <0>,
-				 <0>,
-				 <0>,
-				 <0>,
+				 <&usb_0_qmpphy QMP_USB43DP_DP_LINK_CLK>,
+				 <&usb_0_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>,
+				 <&usb_1_qmpphy QMP_USB43DP_DP_LINK_CLK>,
+				 <&usb_1_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>,
 				 <&mdss0_dp2_phy 0>,
 				 <&mdss0_dp2_phy 1>,
 				 <&mdss0_dp3_phy 0>,
-- 
2.25.1

