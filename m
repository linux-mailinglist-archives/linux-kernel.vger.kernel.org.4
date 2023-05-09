Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F556FC584
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 13:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235644AbjEILyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 07:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235608AbjEILyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 07:54:43 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0251BCA;
        Tue,  9 May 2023 04:54:40 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3499oli1003186;
        Tue, 9 May 2023 11:54:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=GVPXECU1g8S0Dk+Wl1NXtHOunWomjrF4M7NEfA8YzFo=;
 b=Z1jGfWK7b/97jGYxgaYbucsMnFjPWZmDFRDwJhABLKrk+RpM4tE+EFaAnQKtD0c30lzG
 tyr/BQPylXIj89kvoUg6XTx0cF3itu59yaFup2Yy2drNtDo51g/KXtvEppT0tDyzSzn5
 PabFkWa8R/GNSAmNo86iYlPka+9Pbu78ThoUZa+wu8i/qilGE6mwxbDnBYjhZQ/3LL16
 5yVU8LoLc+r9hXBrCqWZJfFHFdevNs4rUu26y+9aTqdKJwCNKXQvblEYhvLop1OeeCSB
 foSYB9bcdt3A1TeNiEnmDH8rXcedHYXqklsiRvHXewkQK5HofI84uD5uEuca58HgSdr9 3Q== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qf781hm5w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 May 2023 11:54:33 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 349BsWaV021495
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 9 May 2023 11:54:32 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 9 May 2023 04:54:27 -0700
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <quic_wcheng@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-clk@vger.kernel.org>
CC:     Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v11 2/9] dt-bindings: phy: qcom,qmp-usb: Add IPQ9574 USB3 PHY
Date:   Tue, 9 May 2023 17:24:02 +0530
Message-ID: <064614c5b28f6d813634ad14a59b0bf94ac334b7.1683630932.git.quic_varada@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1683630932.git.quic_varada@quicinc.com>
References: <cover.1683630932.git.quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: syZzJzl9g01kXk8rRW5y6cKq7ANuoMCW
X-Proofpoint-ORIG-GUID: syZzJzl9g01kXk8rRW5y6cKq7ANuoMCW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-09_08,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 mlxlogscore=999 malwarescore=0 mlxscore=0
 impostorscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305090095
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Add dt-bindings for USB3 PHY found on Qualcomm IPQ9574

* Making power-domains as optional since IPQ9574 doesn't have GDSCs

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 Changes in v11:
	- Have power-domains as required for non ipq9574 SoCs

 Changes in v10:
	- Remove maxItems for clocks as it is present in top level

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
 .../phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml        | 44 +++++++++++++++++++---
 1 file changed, 38 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
index c61cea4..a272c40 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
@@ -16,6 +16,7 @@ description:
 properties:
   compatible:
     enum:
+      - qcom,ipq9574-qmp-usb3-phy
       - qcom,sa8775p-qmp-usb3-uni-phy
       - qcom,sc8280xp-qmp-usb3-uni-phy
 
@@ -26,11 +27,7 @@ properties:
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
@@ -61,7 +58,6 @@ required:
   - reg
   - clocks
   - clock-names
-  - power-domains
   - resets
   - reset-names
   - vdda-phy-supply
@@ -70,6 +66,42 @@ required:
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
+              - qcom,sa8775p-qmp-usb3-uni-phy
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
+      required:
+        - power-domains
+
 additionalProperties: false
 
 examples:
-- 
2.7.4

