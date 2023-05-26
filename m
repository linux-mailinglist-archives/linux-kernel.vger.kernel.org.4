Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC06712593
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 13:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243297AbjEZLed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 07:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243313AbjEZLeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 07:34:23 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40138E58;
        Fri, 26 May 2023 04:34:06 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34QAfjwc028797;
        Fri, 26 May 2023 11:33:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=p+wzYQ+wN/aRj1zUFCB9lOHA9948C58rbMTC9QRgZoc=;
 b=EoYh7ZDBUuNHCLDUhbgwUg0HXexcayzGcTJMqDp8bww5IZod/v3LXyx+wWMku+x4+VWn
 jbNjy3WYm/2sxCj0IcH3Piss2qe2fS9WhejTa7uLL6LOsJj4cRsEUtcAYeXs5jZz14Jw
 GeYLoHqIY0qJCO8Xxn3gwK59r0OC+LBHd3SrKLh6t5rc87GZPF8A0AoGSTvHe42IHuKv
 f1HM+xu+mOH4TPYRZcK1Frg8nFozn1QltkCMXIqiXZzYSnLV+TGeONFiEYVFcIg7MUKS
 YBgs2yvPMrODJq6gOUOrjc8tlN0eos4EMGs8bCJnZi0lHE0rMle7QFwtbrIYYIZXFlRo 8w== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qtu0u03uy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 11:33:57 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34QBXuph019903
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 11:33:56 GMT
Received: from hu-mohs-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 26 May 2023 04:33:50 -0700
From:   Mohammad Rafi Shaik <quic_mohs@quicinc.com>
To:     <krzysztof.kozlowski+dt@linaro.org>, <vkoul@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>, <robh+dt@kernel.org>,
        <broonie@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>, <srinivas.kandagatla@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>, <alsa-devel@alsa-project.org>,
        <quic_rjendra@quicinc.com>, <konrad.dybcio@somainline.org>,
        <mka@chromium.org>, <quic_visr@quicinc.com>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Subject: [PATCH v6 5/8] arm64: dts: qcom: sc7280: Add LPASS PIL node
Date:   Fri, 26 May 2023 17:02:55 +0530
Message-ID: <20230526113258.1467276-6-quic_mohs@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230526113258.1467276-1-quic_mohs@quicinc.com>
References: <20230526113258.1467276-1-quic_mohs@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: k4DA7orYpn27KZ5BTPG0KrECHI7tfR2L
X-Proofpoint-GUID: k4DA7orYpn27KZ5BTPG0KrECHI7tfR2L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-26_01,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 impostorscore=0 phishscore=0 mlxscore=0 spamscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305260098
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

