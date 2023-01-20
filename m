Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334926757CC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 15:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjATOyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 09:54:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjATOyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 09:54:14 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1AC880BA6;
        Fri, 20 Jan 2023 06:54:10 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KDp3IW031207;
        Fri, 20 Jan 2023 14:17:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=PIdM7o1+hw/XrhEmFs2MPxHnXk6lUaLi/Afz0Ror2KA=;
 b=Dj4fJqRbL/i34wWsr2THHZgNDecZOSckEXktB5A1DHtKeQSoBWK/i1/cg30Uy6lhGCRe
 Z+n8pVJ5TX4xTIRCEIOA4BHDUDb3RnwBb08P09wlcibWK5OXSQ6ky3Nn6AAoyYRHnNDR
 8M6i+G09cBUCDbnJsPFD8vKHpvqY8uGhkc42uI5HGnamfzAeWxojJpcbPgvgCDa3UWg4
 zhEWpxHFlcKGDRsIt01izGlqrKpmvaUO4A06B5UnBft/+XYs+Oh9YJ+3zAYESTY4n7hq
 ocet5XEAxxVEfdrYOnrWwV3Yk7dkV0M/vT7L5JMypgT3dwx9qAlO8UHz9i7pv0kIh/My sw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n700yuuu1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 14:17:19 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30KEHIoX018610
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 14:17:18 GMT
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 20 Jan 2023 06:17:12 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <vkoul@kernel.org>, <agross@kernel.org>, <andersson@kernel.org>,
        <robh+dt@kernel.org>, <broonie@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_rohkumar@quicinc.com>,
        <srinivas.kandagatla@linaro.org>, <dianders@chromium.org>,
        <swboyd@chromium.org>, <judyhsiao@chromium.org>,
        <alsa-devel@alsa-project.org>, <quic_rjendra@quicinc.com>,
        <konrad.dybcio@somainline.org>, <mka@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH v4 3/7] arm64: dts: qcom: sc7280: Add LPASS PIL node
Date:   Fri, 20 Jan 2023 19:46:37 +0530
Message-ID: <1674224201-28109-4-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1674224201-28109-1-git-send-email-quic_srivasam@quicinc.com>
References: <1674224201-28109-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: BwpPfXJ1-MIsJI44Evue_1xtmm0NCdcC
X-Proofpoint-ORIG-GUID: BwpPfXJ1-MIsJI44Evue_1xtmm0NCdcC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_08,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 mlxscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301200135
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add LPASS PIL node for sc7280 based audioreach platforms.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Tested-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
---
 .../qcom/sc7280-herobrine-audioreach-wcd9385.dtsi  |  4 +
 arch/arm64/boot/dts/qcom/sc7280.dtsi               | 96 ++++++++++++++++++++++
 2 files changed, 100 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
index 7b3f7ee..81e0f3a 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
@@ -107,3 +107,7 @@
 		};
 	};
 };
+
+&remoteproc_adsp {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 6908bca..42e8fd8 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/clock/qcom,dispcc-sc7280.h>
 #include <dt-bindings/clock/qcom,gcc-sc7280.h>
 #include <dt-bindings/clock/qcom,gpucc-sc7280.h>
+#include <dt-bindings/clock/qcom,lpass-sc7280.h>
 #include <dt-bindings/clock/qcom,lpassaudiocc-sc7280.h>
 #include <dt-bindings/clock/qcom,lpasscorecc-sc7280.h>
 #include <dt-bindings/clock/qcom,rpmh.h>
@@ -21,6 +22,7 @@
 #include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/reset/qcom,sdm845-aoss.h>
 #include <dt-bindings/reset/qcom,sdm845-pdc.h>
+#include <dt-bindings/soc/qcom,gpr.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 #include <dt-bindings/sound/qcom,lpass.h>
 #include <dt-bindings/thermal/thermal.h>
@@ -3439,6 +3441,100 @@
 			status = "disabled";
 		};
 
+		remoteproc_adsp: remoteproc@3000000 {
+			compatible = "qcom,sc7280-adsp-pil";
+			reg = <0 0x03000000 0 0x5000>, <0 0x0355b000 0 0x10>;
+			reg-names = "qdsp6ss_base", "lpass_efuse";
+
+			interrupts-extended = <&pdc 6 IRQ_TYPE_LEVEL_HIGH>,
+					      <&adsp_smp2p_in 0 IRQ_TYPE_NONE>,
+					      <&adsp_smp2p_in 1 IRQ_TYPE_NONE>,
+					      <&adsp_smp2p_in 2 IRQ_TYPE_NONE>,
+					      <&adsp_smp2p_in 3 IRQ_TYPE_NONE>,
+					      <&adsp_smp2p_in 7 IRQ_TYPE_NONE>;
+
+			interrupt-names = "wdog", "fatal", "ready",
+					  "handover", "stop-ack",
+					  "shutdown-ack";
+
+			qcom,qmp = <&aoss_qmp>;
+
+			clocks = <&rpmhcc RPMH_CXO_CLK>,
+				 <&gcc GCC_CFG_NOC_LPASS_CLK>;
+
+			clock-names = "xo", "gcc_cfg_noc_lpass";
+
+			iommus = <&apps_smmu 0x1800 0x0>;
+
+			power-domains =	<&rpmhpd SC7280_CX>;
+			power-domain-names = "cx";
+
+			required-opps = <&rpmhpd_opp_nom>;
+
+			resets = <&pdc_reset PDC_AUDIO_SYNC_RESET>,
+				 <&aoss_reset AOSS_CC_LPASS_RESTART>;
+
+			reset-names =  "pdc_sync", "cc_lpass";
+			qcom,halt-regs = <&tcsr_1 0x3000 0x5000 0x8000 0x13000>;
+
+			memory-region = <&adsp_mem>;
+
+			qcom,smem-states = <&adsp_smp2p_out 0>;
+			qcom,smem-state-names = "stop";
+
+			status = "disabled";
+
+			glink-edge {
+				interrupts-extended = <&ipcc IPCC_CLIENT_LPASS
+						       IPCC_MPROC_SIGNAL_GLINK_QMP
+						       IRQ_TYPE_EDGE_RISING>;
+
+				mboxes = <&ipcc IPCC_CLIENT_LPASS
+					 IPCC_MPROC_SIGNAL_GLINK_QMP>;
+
+				label = "lpass";
+				qcom,remote-pid = <2>;
+
+				gpr {
+					compatible = "qcom,gpr";
+					qcom,glink-channels = "adsp_apps";
+					qcom,domain = <GPR_DOMAIN_ID_ADSP>;
+					qcom,intents = <512 20>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					q6apm: service@1 {
+						compatible = "qcom,q6apm";
+						reg = <GPR_APM_MODULE_IID>;
+						#sound-dai-cells = <0>;
+						qcom,protection-domain = "avs/audio",
+									 "msm/adsp/audio_pd";
+
+						q6apmdai: dais {
+							compatible = "qcom,q6apm-dais";
+							iommus = <&apps_smmu 0x1801 0x0>;
+						};
+
+						q6apmbedai: bedais {
+							compatible = "qcom,q6apm-lpass-dais";
+							#sound-dai-cells = <1>;
+						};
+					};
+
+					q6prm: service@2 {
+						compatible = "qcom,q6prm";
+						reg = <GPR_PRM_MODULE_IID>;
+						qcom,protection-domain = "avs/audio",
+									 "msm/adsp/audio_pd";
+						q6prmcc: clock-controller {
+							compatible = "qcom,q6prm-lpass-clocks";
+							#clock-cells = <2>;
+						};
+					};
+				};
+			};
+		};
+
 		remoteproc_wpss: remoteproc@8a00000 {
 			compatible = "qcom,sc7280-wpss-pil";
 			reg = <0 0x08a00000 0 0x10000>;
-- 
2.7.4

