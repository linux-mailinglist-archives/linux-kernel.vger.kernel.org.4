Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E23D6D7B9E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 13:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237920AbjDELmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 07:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237708AbjDELmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 07:42:06 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A29C30FD;
        Wed,  5 Apr 2023 04:42:05 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3359cjhg002563;
        Wed, 5 Apr 2023 11:42:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=LG7tLRvP0u5ZX/K7WNtsXB8otVa6AGmVhABVmL3DtbI=;
 b=KFApxxQ24mfdTVNybGUcyqCCTTjqf4UlDnXKagYdJIAPOw1/hKFi31BZ8ouL/IeuUeCe
 CUrj1bKItjgWcI08nSanZJtLaRefpayR8GZ8fgFoln7Sbn+oMCLPhAAbm/mV9967pd/D
 1n6an9hSHuHhEvJK+Mf4qRqRTNvrQRT9b4xsQMnzCm5iViT678b6h7/xrWOB8IsUYPls
 IFxiAJCU2vEvC4zo4fLphVTwQsPumdoTKE3i/QBHVfwGX6mSheYxqe48tOS862/3iWPr
 /lvG9IccsRr1XtHnZHr2z1Dj2e14wzaSmZiUAzl1PvqQKNjVPUD9KCDKxIGI6xEQ+5uO tg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3prnvg2m2e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 11:41:59 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 335Bfwgw022005
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 5 Apr 2023 11:41:58 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 5 Apr 2023 04:41:53 -0700
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
Subject: [PATCH v8 3/8] dt-bindings: usb: dwc3: Add IPQ9574 compatible
Date:   Wed, 5 Apr 2023 17:11:22 +0530
Message-ID: <3ee3163e6933b52e3eb4144c8041062dbd15e6c2.1680693149.git.quic_varada@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1680693149.git.quic_varada@quicinc.com>
References: <cover.1680693149.git.quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yTi1EYuy08mtKjFWmmxUztv6hYkJBuLA
X-Proofpoint-ORIG-GUID: yTi1EYuy08mtKjFWmmxUztv6hYkJBuLA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-05_07,2023-04-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304050106
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the IPQ9574 dwc3 compatible.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 Changes in v6:
	- Made power-domains as optional
	- Resolved all 'make dtbs_check' messages

 Changes in v5:
	- Restore removed constraints

 Changes in v4:
	- Update other relevant sections
	- Remove constraints not applicable to IPQ9574
---
 .../devicetree/bindings/usb/qcom,dwc3.yaml         | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
index d842819..f5dd268 100644
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
@@ -133,7 +134,6 @@ required:
   - "#address-cells"
   - "#size-cells"
   - ranges
-  - power-domains
   - clocks
   - clock-names
   - interrupts
@@ -197,6 +197,26 @@ allOf:
             - const: iface
             - const: sleep
             - const: mock_utmi
+      required:
+        - power-domains
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,ipq9574-dwc3
+    then:
+      properties:
+        clocks:
+          maxItems: 5
+        clock-names:
+          items:
+            - const: cfg_noc
+            - const: core
+            - const: iface
+            - const: sleep
+            - const: mock_utmi
 
   - if:
       properties:
-- 
2.7.4

