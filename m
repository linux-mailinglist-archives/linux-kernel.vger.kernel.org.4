Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE52732F0E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 12:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345166AbjFPKrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 06:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345500AbjFPKqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 06:46:46 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B56729D;
        Fri, 16 Jun 2023 03:39:13 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35GAPOGx028525;
        Fri, 16 Jun 2023 10:38:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=p+wzYQ+wN/aRj1zUFCB9lOHA9948C58rbMTC9QRgZoc=;
 b=MrhtbUM1YzoKrgNoIJ3cwq24s0BerOz5RMOIEEpstm/dPn+5+OS3nlIyjQY8crxz0X+T
 YnCcE+5t4cX+9djdvxK3rH73lZR8KBZ2RvghfULCimKCmOaU2qO1kQsbXI80gVd9Hpro
 EJB8nVw1ycup+L+lWE+vMeZkRhP2QPjjkUBboym9ujNg5AUL+W8xSvKuBKFH6jtLQhLD
 tvE+91jz94t6Pgn+hbogGPfFZDMH1hNYhPJwYcWfkuaBXB67prNiJDk3RL18fLloNa5R
 HaY/VAyPf7msNwQwfcHsBT7MMOwIJv8ML4WLBeRe+KdHP9/zJI3GYiWm88pNk3lgeVyN cQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r8fdh0rfa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Jun 2023 10:38:15 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35GAcEBh030787
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Jun 2023 10:38:14 GMT
Received: from hu-mohs-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 16 Jun 2023 03:38:09 -0700
From:   Mohammad Rafi Shaik <quic_mohs@quicinc.com>
To:     <krzysztof.kozlowski+dt@linaro.org>, <swboyd@chromium.org>,
        <andersson@kernel.org>, <broonie@kernel.org>, <agross@kernel.org>
CC:     <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>, <srinivas.kandagatla@linaro.org>,
        <konrad.dybcio@linaro.org>, <dianders@chromium.org>,
        <judyhsiao@chromium.org>, <quic_visr@quicinc.com>,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Subject: [RESEND v6 5/8] arm64: dts: qcom: sc7280: Add LPASS PIL node
Date:   Fri, 16 Jun 2023 16:05:31 +0530
Message-ID: <20230616103534.4031331-6-quic_mohs@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230616103534.4031331-1-quic_mohs@quicinc.com>
References: <20230616103534.4031331-1-quic_mohs@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Zu8PSlJHaZ2MZEQoAZpOFA1ehtmFwmjw
X-Proofpoint-GUID: Zu8PSlJHaZ2MZEQoAZpOFA1ehtmFwmjw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-16_06,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=887 spamscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306160095
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>

Add LPASS PIL node for sc7280 based audioreach platforms.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
---
 .../sc7280-herobrine-audioreach-wcd9385.dtsi  | 90 +++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
index 95d3aa08ebde..9daea1b25656 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
@@ -7,6 +7,8 @@
  */
 
 #include <dt-bindings/sound/qcom,q6afe.h>
+#include <dt-bindings/clock/qcom,lpass-sc7280.h>
+#include <dt-bindings/soc/qcom,gpr.h>
 
 /{
 	/* BOARD-SPECIFIC TOP LEVEL NODES */
@@ -105,4 +107,92 @@ platform {
 			};
 		};
 	};
+
+	remoteproc_adsp: remoteproc@3000000 {
+		compatible = "qcom,sc7280-adsp-pil";
+		reg = <0 0x03000000 0 0x5000>, <0 0x0355b000 0 0x10>;
+		reg-names = "qdsp6ss_base", "lpass_efuse";
+
+		interrupts-extended = <&pdc 6 IRQ_TYPE_LEVEL_HIGH>,
+				      <&adsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+				      <&adsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+				      <&adsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+				      <&adsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>,
+				      <&adsp_smp2p_in 7 IRQ_TYPE_EDGE_RISING>;
+
+		interrupt-names = "wdog", "fatal", "ready",
+				  "handover", "stop-ack",
+				  "shutdown-ack";
+
+		qcom,qmp = <&aoss_qmp>;
+
+		clocks = <&rpmhcc RPMH_CXO_CLK>,
+			 <&gcc GCC_CFG_NOC_LPASS_CLK>;
+		clock-names = "xo", "gcc_cfg_noc_lpass";
+
+		iommus = <&apps_smmu 0x1800 0x0>;
+
+		power-domains =	<&rpmhpd SC7280_CX>;
+		power-domain-names = "cx";
+
+		required-opps = <&rpmhpd_opp_nom>;
+
+		resets = <&pdc_reset PDC_AUDIO_SYNC_RESET>,
+			 <&aoss_reset AOSS_CC_LPASS_RESTART>;
+		reset-names =  "pdc_sync", "cc_lpass";
+
+		qcom,halt-regs = <&tcsr_1 0x3000 0x5000 0x8000 0x13000>;
+
+		memory-region = <&adsp_mem>;
+
+		qcom,smem-states = <&adsp_smp2p_out 0>;
+		qcom,smem-state-names = "stop";
+
+		glink-edge {
+			interrupts-extended = <&ipcc IPCC_CLIENT_LPASS
+					      IPCC_MPROC_SIGNAL_GLINK_QMP
+					      IRQ_TYPE_EDGE_RISING>;
+
+			mboxes = <&ipcc IPCC_CLIENT_LPASS
+				 IPCC_MPROC_SIGNAL_GLINK_QMP>;
+
+			label = "lpass";
+			qcom,remote-pid = <2>;
+
+			gpr {
+				compatible = "qcom,gpr";
+				qcom,glink-channels = "adsp_apps";
+				qcom,domain = <GPR_DOMAIN_ID_ADSP>;
+				qcom,intents = <512 20>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				q6apm: service@1 {
+					compatible = "qcom,q6apm";
+					reg = <GPR_APM_MODULE_IID>;
+					#sound-dai-cells = <0>;
+
+					q6apmdai: dais {
+						compatible = "qcom,q6apm-dais";
+						iommus = <&apps_smmu 0x1801 0x0>;
+					};
+
+					q6apmbedai: bedais {
+						compatible = "qcom,q6apm-lpass-dais";
+						#sound-dai-cells = <1>;
+					};
+				};
+
+				q6prm: service@2 {
+					compatible = "qcom,q6prm";
+					reg = <GPR_PRM_MODULE_IID>;
+
+					q6prmcc: clock-controller {
+						compatible = "qcom,q6prm-lpass-clocks";
+						#clock-cells = <2>;
+					};
+				};
+			};
+		};
+	};
 };
-- 
2.25.1

