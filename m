Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB7B642F4C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 18:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbiLERpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 12:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbiLERpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 12:45:07 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1878201BD;
        Mon,  5 Dec 2022 09:44:52 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B5FtdTu013915;
        Mon, 5 Dec 2022 17:44:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=6rgPnRwmVVa+UVyovfXZI9g3mo94ArQ7AGW3IIy6RLE=;
 b=WEpzScjoUk4BJNj/3EFmgKcv3VQ62Y454Sr/Jx3yLqpg+LReAtuxYlCRX+x4tpVTUtqa
 6oNeMdiPREPoPuCArgYvntolnXXJzD2eVrjU4e00VJRphh0mrz4sBF5LeFOhIoR3u2h8
 8hpVP45byCMsikUz91GesJwOXF+q8iRi8xZXO9XI8MKMXiimuVKZQGwn/WlhnCFktwEK
 xWOjkdNWL05+y+Xpj0hlLJxGga5nsjp4c7jpwPRxsqD6FBbuAw2Bp3lbDKuqB8ov/43V
 8uoRQnVqs73fAdj9i51X408S/woTBfNIyohSK7wQ3HbQXmY9qtuK1Fns8Rz9uGevIdjQ Hw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m9eev13u3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Dec 2022 17:44:47 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2B5HilZX006458
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 5 Dec 2022 17:44:47 GMT
Received: from th-lint-050.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 5 Dec 2022 09:44:46 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kalyan Thota <quic_kalyant@quicinc.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        "Kuogee Hsieh" <quic_khsieh@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 12/13] arm64: dts: qcom: sc8280xp-crd: Enable EDP
Date:   Mon, 5 Dec 2022 09:44:32 -0800
Message-ID: <20221205174433.16847-13-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221205174433.16847-1-quic_bjorande@quicinc.com>
References: <20221205174433.16847-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: nduJkoyWAuuJ1icPWF8qziQ1u-Z6HW6v
X-Proofpoint-GUID: nduJkoyWAuuJ1icPWF8qziQ1u-Z6HW6v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-05_01,2022-12-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212050146
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

The SC8280XP CRD has a EDP display on MDSS0 DP3, enable relevant nodes
and link it together with the backlight control.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---

Changes since v3:
- Added description of the regulator that powers the panel.

 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts | 72 ++++++++++++++++++++++-
 1 file changed, 71 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
index f09810e3d956..a7d2384cbbe8 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
@@ -20,7 +20,7 @@ aliases {
 		serial0 = &qup2_uart17;
 	};
 
-	backlight {
+	backlight: backlight {
 		compatible = "pwm-backlight";
 		pwms = <&pmc8280c_lpg 3 1000000>;
 		enable-gpios = <&pmc8280_1_gpios 8 GPIO_ACTIVE_HIGH>;
@@ -34,6 +34,22 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+	vreg_edp_3p3: regulator-edp-3p3 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VREG_EDP_3P3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&tlmm 25 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&edp_reg_en>;
+
+		regulator-boot-on;
+	};
+
 	vreg_edp_bl: regulator-edp-bl {
 		compatible = "regulator-fixed";
 
@@ -230,6 +246,54 @@ vreg_l9d: ldo9 {
 	};
 };
 
+&dispcc0 {
+	status = "okay";
+};
+
+&mdss0 {
+	status = "okay";
+};
+
+&mdss0_dp3 {
+	compatible = "qcom,sc8280xp-edp";
+	status = "okay";
+
+	data-lanes = <0 1 2 3>;
+
+	aux-bus {
+		panel {
+			compatible = "edp-panel";
+			power-supply = <&vreg_edp_3p3>;
+
+			backlight = <&backlight>;
+
+			ports {
+				port {
+					edp_panel_in: endpoint {
+						remote-endpoint = <&mdss0_dp3_out>;
+					};
+				};
+			};
+		};
+	};
+
+	ports {
+		port@1 {
+			reg = <1>;
+			mdss0_dp3_out: endpoint {
+				remote-endpoint = <&edp_panel_in>;
+			};
+		};
+	};
+};
+
+&mdss0_dp3_phy {
+	status = "okay";
+
+	vdda-phy-supply = <&vreg_l6b>;
+	vdda-pll-supply = <&vreg_l3b>;
+};
+
 &pcie2a {
 	perst-gpios = <&tlmm 143 GPIO_ACTIVE_LOW>;
 	wake-gpios = <&tlmm 145 GPIO_ACTIVE_LOW>;
@@ -496,6 +560,12 @@ hastings_reg_en: hastings-reg-en-state {
 &tlmm {
 	gpio-reserved-ranges = <74 6>, <83 4>, <125 2>, <128 2>, <154 7>;
 
+	edp_reg_en: edp-reg-en-state {
+		pins = "gpio25";
+		function = "gpio";
+		output-enable;
+	};
+
 	kybd_default: kybd-default-state {
 		disable-pins {
 			pins = "gpio102";
-- 
2.37.3

