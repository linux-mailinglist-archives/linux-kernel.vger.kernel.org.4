Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97EB96C9F7E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 11:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233312AbjC0JcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 05:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233295AbjC0Jb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 05:31:57 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE494EE4;
        Mon, 27 Mar 2023 02:31:52 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32R1RNtC028389;
        Mon, 27 Mar 2023 09:31:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=WuY0OLeSjLRrqef/sRH5TYF3Q/P/HVHVaV/DzVxgL94=;
 b=OBirZohn+xSQ1WoVIX9B5u3/CdjhcczWbqMLIxXatj5pJykwyM9+won6hGlNtAGPW2EI
 pMHCEuDEOdwbpKbTksH2d3AFjnWLPCwNdpvi4+ApRWYYDrcB4ltuUqx8Er2dKpJmkIS2
 UDOjfY+fX+DiZcEBcc1BMNM6Z7WLFEEHg4gMdUqVR8OkfE1TCz/i8hB8OziPiKe05ASx
 1fFBjbxZF+ewzp4syVZBHtnh9XlYKG8YxPAEF5K6dc7Q6aBeFe5vi8m9OEL8OG6gglmb
 6wfkF21+qn/zK2cRjFWOJFo/bsvtTRDnRiaZbVG1wrZo97HZp0uEg0MueC5ePm1vd/e9 aw== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pht8f3ypd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Mar 2023 09:31:46 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32R9Vktk016599
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Mar 2023 09:31:46 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 27 Mar 2023 02:31:40 -0700
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
Subject: [PATCH v4 3/8] dt-bindings: usb: dwc3: Add IPQ9574 compatible
Date:   Mon, 27 Mar 2023 15:00:55 +0530
Message-ID: <526f822a4d2397284f70ba632d92feaa3db0143e.1679909245.git.quic_varada@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1679909245.git.quic_varada@quicinc.com>
References: <cover.1679909245.git.quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: lwi6aR89MImuoawXYY82_MQzEfGRRdgI
X-Proofpoint-ORIG-GUID: lwi6aR89MImuoawXYY82_MQzEfGRRdgI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 mlxlogscore=929 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303270077
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the IPQ9574 dwc3 compatible.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 Changes in v4:
	- Update other relevant sections
	- Remove constraints not applicable to IPQ9574
---
 .../devicetree/bindings/usb/qcom,dwc3.yaml         | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
index a2aabda..3fc8c3c 100644
--- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
@@ -17,6 +17,7 @@ properties:
           - qcom,ipq6018-dwc3
           - qcom,ipq8064-dwc3
           - qcom,ipq8074-dwc3
+          - qcom,ipq9574-dwc3
           - qcom,msm8953-dwc3
           - qcom,msm8994-dwc3
           - qcom,msm8996-dwc3
@@ -132,11 +133,8 @@ required:
   - "#address-cells"
   - "#size-cells"
   - ranges
-  - power-domains
   - clocks
   - clock-names
-  - interrupts
-  - interrupt-names
 
 allOf:
   - if:
@@ -242,6 +240,24 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,ipq9574-dwc3
+    then:
+      properties:
+        clocks:
+          maxItems: 5
+        clock-names:
+          items:
+            - const: sys_noc_axi
+            - const: anoc_axi
+            - const: master
+            - const: sleep
+            - const: mock_utmi
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
               - qcom,msm8994-dwc3
               - qcom,qcs404-dwc3
     then:
-- 
2.7.4

