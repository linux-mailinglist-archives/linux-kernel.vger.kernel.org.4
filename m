Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919A266529A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 05:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235504AbjAKD75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 22:59:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235250AbjAKD7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 22:59:35 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4028012617;
        Tue, 10 Jan 2023 19:59:34 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30B3QpQq014862;
        Wed, 11 Jan 2023 03:59:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=+DRQLy7dPqrMWQRzkVk8ZWnilY7ApCKz0xzc0kZGFeM=;
 b=ChAVS6y2R/bL1PKxB7Z5sC3tHcGUoM187YHJJnoI1K3QyI7AE4flc1bQNbXgBabNmpTq
 Qw1g2IbfqcL2CcgtqedRq9oybJdOXZ/FBW80NUQltwmSg6xkzEnESKAc/7Rd4izDcuLy
 3r8ikhtsyZWJZwJvVAQ9vFAeDolPpR4A/btQOqEUu+bGckH3ZK9PA10CWGW0zulz/x0y
 AP1ByMxAo/DeOKiAwmVpXZdoAxFiBiFdROUcvxdVa/8z4fstZpQ22bYCe3laugnnzXWj
 HnXyRGdxlhhtPJN4iUeOph8UDRuylA6V0QL/B8yvKmAs8CtzAPCZOhVV3iR8rF9S1nF+ OA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n1kxhg5v4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Jan 2023 03:59:26 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30B3xPpu016349
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Jan 2023 03:59:26 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 10 Jan 2023 19:59:25 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Johan Hovold <johan@kernel.org>
CC:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v7 3/4] arm64: dts: qcom: sa8295-adp: Enable DP instances
Date:   Tue, 10 Jan 2023 19:59:05 -0800
Message-ID: <20230111035906.2975494-4-quic_bjorande@quicinc.com>
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
X-Proofpoint-GUID: yHdOADCGowCQL93GBSYyNBuLMTdrz5ru
X-Proofpoint-ORIG-GUID: yHdOADCGowCQL93GBSYyNBuLMTdrz5ru
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_10,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0 adultscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 mlxlogscore=857
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

The SA8295P ADP has, among other interfaces, six MiniDP connectors which
are connected to MDSS0 DP2 and DP3, and MDSS1 DP0 through DP3.

Enable Display Clock controllers, MDSS instanced, MDPs, DP controllers,
DP PHYs and link them all together.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---

Changes since v6:
- None

 arch/arm64/boot/dts/qcom/sa8295p-adp.dts | 243 ++++++++++++++++++++++-
 1 file changed, 241 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
index 84cb6f3eeb56..c35e16b087b8 100644
--- a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
+++ b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
@@ -23,6 +23,90 @@ aliases {
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+	dp2-connector {
+		compatible = "dp-connector";
+		label = "DP2";
+		type = "mini";
+
+		hpd-gpios = <&tlmm 20 GPIO_ACTIVE_HIGH>;
+
+		port {
+			dp2_connector_in: endpoint {
+				remote-endpoint = <&mdss1_dp0_phy_out>;
+			};
+		};
+	};
+
+	dp3-connector {
+		compatible = "dp-connector";
+		label = "DP3";
+		type = "mini";
+
+		hpd-gpios = <&tlmm 45 GPIO_ACTIVE_HIGH>;
+
+		port {
+			dp3_connector_in: endpoint {
+				remote-endpoint = <&mdss1_dp1_phy_out>;
+			};
+		};
+	};
+
+	edp0-connector {
+		compatible = "dp-connector";
+		label = "EDP0";
+		type = "mini";
+
+		hpd-gpios = <&tlmm 2 GPIO_ACTIVE_HIGH>;
+
+		port {
+			edp0_connector_in: endpoint {
+				remote-endpoint = <&mdss0_dp2_phy_out>;
+			};
+		};
+	};
+
+	edp1-connector {
+		compatible = "dp-connector";
+		label = "EDP1";
+		type = "mini";
+
+		hpd-gpios = <&tlmm 3 GPIO_ACTIVE_HIGH>;
+
+		port {
+			edp1_connector_in: endpoint {
+				remote-endpoint = <&mdss0_dp3_phy_out>;
+			};
+		};
+	};
+
+	edp2-connector {
+		compatible = "dp-connector";
+		label = "EDP2";
+		type = "mini";
+
+		hpd-gpios = <&tlmm 7 GPIO_ACTIVE_HIGH>;
+
+		port {
+			edp2_connector_in: endpoint {
+				remote-endpoint = <&mdss1_dp2_phy_out>;
+			};
+		};
+	};
+
+	edp3-connector {
+		compatible = "dp-connector";
+		label = "EDP3";
+		type = "mini";
+
+		hpd-gpios = <&tlmm 6 GPIO_ACTIVE_HIGH>;
+
+		port {
+			edp3_connector_in: endpoint {
+				remote-endpoint = <&mdss1_dp3_phy_out>;
+			};
+		};
+	};
 };
 
 &apps_rsc {
@@ -159,13 +243,168 @@ vreg_l7g: ldo7 {
 
 		vreg_l8g: ldo8 {
 			regulator-name = "vreg_l8g";
-			regulator-min-microvolt = <880000>;
-			regulator-max-microvolt = <880000>;
+			regulator-min-microvolt = <912000>;
+			regulator-max-microvolt = <912000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l11g: ldo11 {
+			regulator-name = "vreg_l11g";
+			regulator-min-microvolt = <912000>;
+			regulator-max-microvolt = <912000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 	};
 };
 
+&dispcc0 {
+	status = "okay";
+};
+
+&dispcc1 {
+	status = "okay";
+};
+
+&mdss0 {
+	status = "okay";
+};
+
+&mdss0_dp2 {
+	data-lanes = <0 1 2 3>;
+
+	status = "okay";
+
+	ports {
+		port@1 {
+			reg = <1>;
+			mdss0_dp2_phy_out: endpoint {
+				remote-endpoint = <&edp0_connector_in>;
+			};
+		};
+	};
+};
+
+&mdss0_dp2_phy {
+	vdda-phy-supply = <&vreg_l8g>;
+	vdda-pll-supply = <&vreg_l3g>;
+
+	status = "okay";
+};
+
+&mdss0_dp3 {
+	data-lanes = <0 1 2 3>;
+
+	status = "okay";
+
+	ports {
+		port@1 {
+			reg = <1>;
+			mdss0_dp3_phy_out: endpoint {
+				remote-endpoint = <&edp1_connector_in>;
+			};
+		};
+	};
+};
+
+&mdss0_dp3_phy {
+	vdda-phy-supply = <&vreg_l8g>;
+	vdda-pll-supply = <&vreg_l3g>;
+
+	status = "okay";
+};
+
+&mdss1 {
+	status = "okay";
+};
+
+&mdss1_dp0 {
+	data-lanes = <0 1 2 3>;
+
+	status = "okay";
+
+	ports {
+		port@1 {
+			reg = <1>;
+			mdss1_dp0_phy_out: endpoint {
+				remote-endpoint = <&dp2_connector_in>;
+			};
+		};
+	};
+};
+
+&mdss1_dp0_phy {
+	vdda-phy-supply = <&vreg_l11g>;
+	vdda-pll-supply = <&vreg_l3g>;
+
+	status = "okay";
+};
+
+&mdss1_dp1 {
+	data-lanes = <0 1 2 3>;
+
+	status = "okay";
+
+	ports {
+		port@1 {
+			reg = <1>;
+			mdss1_dp1_phy_out: endpoint {
+				remote-endpoint = <&dp3_connector_in>;
+			};
+		};
+	};
+};
+
+&mdss1_dp1_phy {
+	vdda-phy-supply = <&vreg_l11g>;
+	vdda-pll-supply = <&vreg_l3g>;
+
+	status = "okay";
+};
+
+&mdss1_dp2 {
+	data-lanes = <0 1 2 3>;
+
+	status = "okay";
+
+	ports {
+		port@1 {
+			reg = <1>;
+			mdss1_dp2_phy_out: endpoint {
+				remote-endpoint = <&edp2_connector_in>;
+			};
+		};
+	};
+};
+
+&mdss1_dp2_phy {
+	vdda-phy-supply = <&vreg_l11g>;
+	vdda-pll-supply = <&vreg_l3g>;
+
+	status = "okay";
+};
+
+&mdss1_dp3 {
+	data-lanes = <0 1 2 3>;
+
+	status = "okay";
+
+	ports {
+		port@1 {
+			reg = <1>;
+			mdss1_dp3_phy_out: endpoint {
+				remote-endpoint = <&edp3_connector_in>;
+			};
+		};
+	};
+};
+
+&mdss1_dp3_phy {
+	vdda-phy-supply = <&vreg_l11g>;
+	vdda-pll-supply = <&vreg_l3g>;
+
+	status = "okay";
+};
+
 &pcie2a {
 	perst-gpios = <&tlmm 143 GPIO_ACTIVE_LOW>;
 	wake-gpios = <&tlmm 145 GPIO_ACTIVE_LOW>;
-- 
2.37.3

