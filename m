Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C890571258D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 13:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242661AbjEZLeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 07:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242917AbjEZLeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 07:34:03 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00FAE7;
        Fri, 26 May 2023 04:33:57 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34Q8m4F1017295;
        Fri, 26 May 2023 11:33:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=0TPL7SuFnbzKFa6XETKi0K/JpDHEU4uZqqjPlZlSnjI=;
 b=a5uSboM895striIlWY+ZocZUU4IQ3hSrcp/+Mj5EbBkXganjCh51bTeDiDsTM+wj8Z8t
 IoHvSYkKbdhk93b9+GrCxVbt44LrQKE3EsLtvOWPKyS7/sBTUzCtaHzHHdu35iM9aE5F
 sK4vv1nD7fdt2nPitKboN52nMZXjtUAEoNUpuGngVF9Z4Ej4Warr1ZoEdHobpssFnk3W
 KiChwq8iadF9UKyUujPno288m5antB8o7/V/uIhdAkcQWUpUSg25QAmWnEf8QlbKVy9X
 hNQ+GxW9Prh+b9m4bk9Q7HE1RJ8mqDfq4wFRpdMjATJJT5ePcApLk1IKkAtAiUr0mTLV IA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qtrd8geuj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 11:33:39 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34QBXclv010512
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 11:33:38 GMT
Received: from hu-mohs-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 26 May 2023 04:33:32 -0700
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
        Mohammad Rafi Shaik <quic_mohs@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 2/8] dt-bindings: remoteproc: qcom: sc7280-adsp-pil: Add missing properties
Date:   Fri, 26 May 2023 17:02:52 +0530
Message-ID: <20230526113258.1467276-3-quic_mohs@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 0dIzPdncnpFa-sOTaAtyvcqGiai2Ojgn
X-Proofpoint-GUID: 0dIzPdncnpFa-sOTaAtyvcqGiai2Ojgn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-26_01,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 mlxscore=0 priorityscore=1501 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305260098
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>

Add reg-names and power-domain-names for remoteproc ADSP peripheral
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
Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../remoteproc/qcom,sc7280-adsp-pil.yaml      | 30 ++++++++++++++++---
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-adsp-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-adsp-pil.yaml
index 94ca7a0cc203..7addc7de64c0 100644
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
2.25.1

