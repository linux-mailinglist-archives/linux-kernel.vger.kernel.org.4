Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B4C653DA9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 10:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235301AbiLVJoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 04:44:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235254AbiLVJni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 04:43:38 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825C427B2C;
        Thu, 22 Dec 2022 01:43:34 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BM8wl6U001822;
        Thu, 22 Dec 2022 09:43:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=WqanA7g4agLXDy4c8myJWwB4RnCuP9dwVpD2Pg/9858=;
 b=nw3cucH4PRprVEZJFiLVPMj8XA5kfGTBlKih1J1msese51ON2WH6OQNq43vVXEMVr+uG
 8yC8oC/RSv1mmL7HR/+1MfBNMumkXFTshjJYPRWR8Zx6rrmbl6NlZCDUCfFZPHSN7kEC
 R57FHjH+tkhGomkpMdN/6kCx8Waj9a13rgzn9mwIt70ZLFaEduCvAEi8vi9bRAQLVNux
 uYHNf6PkaAVzANSQh/XkV7XRI0lpWNggqT3QzsJBB/jwEp0LwqLaxH1CfR5ftmrQYpm0
 7i8h18l8kdQTDNIKTwUWccZuGr3UqE82J1/ZFNXMS+vgcJQ5kxF33KFZgKOnhebvrMZ1 og== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mm8x4hcda-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Dec 2022 09:43:31 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BM9hU9o008557
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Dec 2022 09:43:30 GMT
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 22 Dec 2022 01:43:26 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_rohkumar@quicinc.com>,
        <srinivas.kandagatla@linaro.org>, <dianders@chromium.org>,
        <swboyd@chromium.org>, <judyhsiao@chromium.org>,
        <konrad.dybcio@linaro.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH 3/7] arm64: dts: qcom: sc7280: audioreach: Add lpass pil node
Date:   Thu, 22 Dec 2022 15:12:46 +0530
Message-ID: <1671702170-24781-4-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1671702170-24781-1-git-send-email-quic_srivasam@quicinc.com>
References: <1671702170-24781-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3Vi9oSHcfWeB4qyaIAOC-uDuPvFy0gc8
X-Proofpoint-ORIG-GUID: 3Vi9oSHcfWeB4qyaIAOC-uDuPvFy0gc8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-22_03,2022-12-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 suspectscore=0 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212220085
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add lpass pil node for sc7280 based audioreach platforms.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Tested-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
---
This patch depends on:
    -- https://lore.kernel.org/linux-remoteproc/6e0590af-0bd1-cbef-c573-fa62b5bc9e63@quicinc.com/

 .../qcom/sc7280-herobrine-audioreach-wcd9385.dtsi  | 99 ++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
index 1eac94e1..0ce8755 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
@@ -110,3 +110,102 @@
 		};
 	};
 };
+
+&soc {
+	qcom,lpass@3000000 {
+		compatible = "qcom,sc7280-adsp-pil";
+		reg = <0 0x03000000 0 0x5000>,
+			<0 0x0355b000 0 0x10>;
+
+		reg-names = "qdsp6ss_base",
+			"lpass_efuse";
+
+		interrupts-extended = <&pdc 6 IRQ_TYPE_LEVEL_HIGH>,
+					<&adsp_smp2p_in 0 0>,
+					<&adsp_smp2p_in 1 0>,
+					<&adsp_smp2p_in 2 0>,
+					<&adsp_smp2p_in 3 0>,
+					<&adsp_smp2p_in 7 0>;
+
+		interrupt-names = "wdog", "fatal", "ready",
+			"handover", "stop-ack",  "shutdown-ack";
+		qcom,qmp = <&aoss_qmp>;
+
+		clocks = <&rpmhcc RPMH_CXO_CLK>,
+			<&gcc GCC_CFG_NOC_LPASS_CLK>,
+			<&lpasscc LPASS_QDSP6SS_XO_CLK>,
+			<&lpasscc LPASS_QDSP6SS_SLEEP_CLK>,
+			<&lpasscc LPASS_QDSP6SS_CORE_CLK>;
+
+		clock-names = "xo", "gcc_cfg_noc_lpass",
+				"lpass_qdsp6ss_xo",
+				"lpass_qdsp6ss_sleep",
+				"lpass_qdsp6ss_core";
+
+		iommus = <&apps_smmu 0x1800 0x0>;
+
+		power-domains =	<&rpmhpd SC7280_LCX>;
+		power-domain-names = "lcx";
+		required-opps = <&rpmhpd_opp_nom>;
+
+		resets = <&aoss_reset AOSS_CC_LPASS_RESTART>,
+			<&pdc_reset PDC_AUDIO_SYNC_RESET>;
+
+		reset-names = "cc_lpass", "pdc_sync";
+
+		qcom,halt-regs = <&tcsr_1 0x3000 0x5000 0x8000 0x13000>;
+
+		memory-region = <&adsp_mem>;
+
+		status = "okay";
+
+		qcom,smem-states = <&adsp_smp2p_out 0>;
+		qcom,smem-state-names = "stop";
+
+		glink-edge {
+			interrupts-extended = <&ipcc IPCC_CLIENT_LPASS
+						IPCC_MPROC_SIGNAL_GLINK_QMP
+						IRQ_TYPE_EDGE_RISING>;
+			mboxes = <&ipcc IPCC_CLIENT_LPASS
+					IPCC_MPROC_SIGNAL_GLINK_QMP>;
+
+			label = "lpass";
+			qcom,remote-pid = <2>;
+
+			gpr {
+				compatible = "qcom,gpr";
+				qcom,glink-channels = "adsp_apps";
+				qcom,domain = <GPR_DOMAIN_ID_ADSP>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				qcom,intents = <512 20>;
+
+				q6apm: q6apm {
+					reg = <GPR_APM_MODULE_IID>;
+					compatible = "qcom,q6apm";
+					#sound-dai-cells = <0>;
+					q6apmdai: dais {
+						compatible = "qcom,q6apm-dais";
+						#sound-dai-cells = <1>;
+						iommus = <&apps_smmu 0x1801 0x0>;
+					};
+
+					q6apmbedai: bedais {
+						compatible = "qcom,q6apm-lpass-dais";
+						#sound-dai-cells = <1>;
+					};
+				};
+
+				q6prm: q6prm {
+					reg = <GPR_PRM_MODULE_IID>;
+					compatible = "qcom,q6prm";
+					#clock-cells = <2>;
+					q6prmcc: cc {
+						compatible = "qcom,q6prm-lpass-clocks";
+						#clock-cells = <2>;
+					};
+				};
+			};
+		};
+	};
+};
-- 
2.7.4

