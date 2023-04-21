Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD1A6EAE67
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 17:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbjDUP5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 11:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232712AbjDUP5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 11:57:14 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D50B61B3;
        Fri, 21 Apr 2023 08:57:12 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33LEUHsC001025;
        Fri, 21 Apr 2023 15:57:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=MhEvVeuVBa956KqQumdsr7KO5iv0t1ylxTys4IwOMXQ=;
 b=QB8CS41L39w6rSDNLLlkxN/ADCt5hHzlLMHAb/OIBr6vLY5vli7Hz9IkqI8TpCBrVx0G
 kFKH43SefwF9PFup+/6ddhnJk7I8wEE7ZAcuQV8RGR7t0M/y2/1NUvv5yJ2//YF2MF+x
 aHQUfXAe3oaTf6oag9S/m7u9X+gJ2Pfl96XUKKz/d3M6bxNPKzcIeQST32qCvxUE00wt
 mK673zKFTbO1k+AkJllMa4KKCizKRHD4GTp5Bvv8pXzbdtCEvtLvW1WJewYiqU/wtx0D
 FXcfw49zY7QKwLD79ax1aKUD48AOtFMwpYcepQx/KJGulh/IhOxaYx/IROhH6Z4Nnset Fw== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q3thdrexf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Apr 2023 15:57:06 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33LFv5SA015389
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Apr 2023 15:57:05 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 21 Apr 2023 08:57:00 -0700
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <gregkh@linuxfoundation.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <quic_wcheng@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
CC:     Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v9 2/8] dt-bindings: phy: qcom,qmp-usb: Add IPQ9574 USB3 PHY
Date:   Fri, 21 Apr 2023 21:24:44 +0530
Message-ID: <b00042df41420ac337703ca99ac7876c46552946.1682092324.git.quic_varada@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1682092324.git.quic_varada@quicinc.com>
References: <cover.1682092324.git.quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: XXCETyNNITSy_raFKaebkrnsI9XBvy1r
X-Proofpoint-GUID: XXCETyNNITSy_raFKaebkrnsI9XBvy1r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-21_08,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 mlxlogscore=999 mlxscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304210140
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Add dt-bindings for USB3 PHY found on Qualcomm IPQ9574

* Making power-domains as optional since IPQ9574 doesn't have GDSCs

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>

---
 Changes in v9:
	- Move 'allOf' to the correct position

 Changes in v8:
	- Update clock names for ipq9574

 Changes in v6:
	- Made power-domains optional

Note: In the earlier patch sets, had used the (legacy)
specification available in qcom,msm8996-qmp-usb3-phy.yaml. Moved
to newer specification in qcom,sc8280xp-qmp-usb3-uni-phy.yaml
---
 .../phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml        | 43 +++++++++++++++++++---
 1 file changed, 37 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
index 16fce10..b9dcda2 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
@@ -16,6 +16,7 @@ description:
 properties:
   compatible:
     enum:
+      - qcom,ipq9574-qmp-usb3-phy
       - qcom,sc8280xp-qmp-usb3-uni-phy
 
   reg:
@@ -25,11 +26,7 @@ properties:
     maxItems: 4
 
   clock-names:
-    items:
-      - const: aux
-      - const: ref
-      - const: com_aux
-      - const: pipe
+    maxItems: 4
 
   power-domains:
     maxItems: 1
@@ -60,7 +57,6 @@ required:
   - reg
   - clocks
   - clock-names
-  - power-domains
   - resets
   - reset-names
   - vdda-phy-supply
@@ -69,6 +65,41 @@ required:
   - clock-output-names
   - "#phy-cells"
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,ipq9574-qmp-usb3-phy
+    then:
+      properties:
+        clocks:
+          maxItems: 4
+        clock-names:
+          items:
+            - const: aux
+            - const: ref
+            - const: cfg_ahb
+            - const: pipe
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sc8280xp-qmp-usb3-uni-phy
+    then:
+      properties:
+        clocks:
+          maxItems: 4
+        clock-names:
+          items:
+            - const: aux
+            - const: ref
+            - const: com_aux
+            - const: pipe
+
 additionalProperties: false
 
 examples:
-- 
2.7.4

