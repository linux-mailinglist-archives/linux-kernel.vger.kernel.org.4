Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0289D673899
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 13:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjASMbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 07:31:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjASM23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 07:28:29 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755005EF93;
        Thu, 19 Jan 2023 04:28:20 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30JBkKaO024665;
        Thu, 19 Jan 2023 12:28:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=9WGsjJvP+1/um8Hd8VhI/0r92/XxI99jW+WUww0Bjj0=;
 b=XDfvDCDngqYEvmt9n9W+dMopR3nMfHCqJqRto9/JLjjNFintTFr4qKtMXzfC1FuojQer
 fD+9x1uUto/yKSDlp+FOJaKiMoMwYF4B3c96NHlV7jMS9rv8gGzhdojkYlKo2C4XI2Em
 Jb/8vfpfHoaeAwr4hhkstXagPstWjtDpn1MzJjw2bDCCo3LlKBcedo3tK5UNA5F0kKXG
 o4Dlfvfl6rDlaVZCldFmMHId7eUIhP/oLTDaEND4w03A1j+uN+2gubQzpW/2dY4lIjlS
 ATx2lUKqO4GVt0eHVWh0HLvf4u3jfqlA/MX9dx31o+5Cyzt+pOxJ7rlgA+Tf0U7/Y8SM Fw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n7593r36b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 12:28:12 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30JCSB3S002872
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 12:28:11 GMT
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 19 Jan 2023 04:28:06 -0800
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
Subject: [PATCH v3 7/7] dt-bindings: remoteproc: qcom: sc7280-adsp-pil: Add missing properties
Date:   Thu, 19 Jan 2023 17:57:07 +0530
Message-ID: <1674131227-26456-8-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1674131227-26456-1-git-send-email-quic_srivasam@quicinc.com>
References: <1674131227-26456-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ZjBx5kd-ESFFDMycv3g1ezGz7maVHjeY
X-Proofpoint-ORIG-GUID: ZjBx5kd-ESFFDMycv3g1ezGz7maVHjeY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-19_09,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 mlxscore=0 adultscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301190098
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add reg-names and power-domain-names for remoteproc ADSP pheripheral
loader. Add firmware-name property to distinguish and load different
firmware binaries of various vendors.
Change qcom,halt-regs property phandle to tcsr_1 from tcsr_mutex.
Also add required-opps property and change power domain from LCX to CX,
which is actual PD to be controlled, for setting appropriate
performance state.
This is to make compatible with remoteproc ADSP PIL driver and
latest device tree changes.

Fixes: 8490a99586ab ("dt-bindings: remoteproc: qcom: Add SC7280 ADSP support")

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
---
 .../bindings/remoteproc/qcom,sc7280-adsp-pil.yaml  | 30 +++++++++++++++++++---
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-adsp-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-adsp-pil.yaml
index 94ca7a0..7addc7d 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-adsp-pil.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-adsp-pil.yaml
@@ -23,6 +23,11 @@ properties:
       - description: qdsp6ss register
       - description: efuse q6ss register
 
+  reg-names:
+    items:
+      - const: qdsp6ss_base
+      - const: lpass_efuse
+
   iommus:
     items:
       - description: Phandle to apps_smmu node with sid mask
@@ -57,7 +62,11 @@ properties:
 
   power-domains:
     items:
-      - description: LCX power domain
+      - description: CX power domain
+
+  power-domain-names:
+    items:
+      - const: cx
 
   resets:
     items:
@@ -73,6 +82,12 @@ properties:
     maxItems: 1
     description: Reference to the reserved-memory for the Hexagon core
 
+  firmware-name:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      The name of the firmware which should be loaded for this remote
+      processor.
+
   qcom,halt-regs:
     $ref: /schemas/types.yaml#/definitions/phandle-array
     description:
@@ -80,7 +95,7 @@ properties:
       four offsets within syscon for q6, modem, nc and qv6 halt registers.
     items:
       - items:
-          - description: phandle to TCSR_MUTEX registers
+          - description: phandle to TCSR_1 registers
           - description: offset to the Q6 halt register
           - description: offset to the modem halt register
           - description: offset to the nc halt register
@@ -100,6 +115,10 @@ properties:
     $ref: /schemas/types.yaml#/definitions/phandle
     description: Reference to the AOSS side-channel message RAM.
 
+  required-opps:
+    description:
+      A phandle to an OPP node describing required MMCX performance point.
+
   glink-edge:
     $ref: qcom,glink-edge.yaml#
     type: object
@@ -167,13 +186,16 @@ examples:
                  <&gcc GCC_CFG_NOC_LPASS_CLK>;
         clock-names = "xo", "gcc_cfg_noc_lpass";
 
-        power-domains = <&rpmhpd SC7280_LCX>;
+        power-domains = <&rpmhpd SC7280_CX>;
+        power-domain-names = "cx";
+
+        required-opps = <&rpmhpd_opp_nom>;
 
         resets = <&pdc_reset PDC_AUDIO_SYNC_RESET>,
                  <&aoss_reset AOSS_CC_LPASS_RESTART>;
         reset-names = "pdc_sync", "cc_lpass";
 
-        qcom,halt-regs = <&tcsr_mutex 0x23000 0x25000 0x28000 0x33000>;
+        qcom,halt-regs = <&tcsr_1 0x23000 0x25000 0x28000 0x33000>;
 
         memory-region = <&adsp_mem>;
 
-- 
2.7.4

