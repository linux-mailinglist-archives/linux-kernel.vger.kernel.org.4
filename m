Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E8066B0BD
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 12:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbjAOLmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 06:42:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbjAOLmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 06:42:17 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615E910A8B;
        Sun, 15 Jan 2023 03:42:16 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30FBg9ug011339;
        Sun, 15 Jan 2023 11:42:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=J9ic4VcHvZVN1ompLbcW8LrUZOkr39+EMHm55JPddNU=;
 b=ir5Ibz/TJYFZmGMCcvuGdmUZUcILJ1O7xiiPNTsnLjijgjllgSlHilXuZwDUl7VmpZi5
 vGuNci/YoNnTyg6dCSd9OjhvWe5g1KDVMnBJQDiTillIC7aDMvgkb9eZcJYC+dy+GRbN
 ooznPI3cV0YFLFSidH96vUArT2uSGywKvAt67Y1bH8OqTGBDyzxa5iJAIArZcJt2tKn4
 Hg9JmYZnK0vuKbk1K4NoJJlruStqBbnxk1WHUQ399t1iN73m3hPXvI28mGk2e1D7xHn/
 R6uqGekh8XY2dJKGO7aa0aD8aSK4i8PSJcNQUFhj3A6irOyX67OrPtJCrirtYFShqUIB cg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n3m089t5t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 15 Jan 2023 11:42:09 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30FBg7BM011064
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 15 Jan 2023 11:42:07 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Sun, 15 Jan 2023 03:42:02 -0800
From:   Krishna Kurapati <quic_kriskura@quicinc.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Andy Gross" <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>,
        <quic_wcheng@quicinc.com>, <quic_jackp@quicinc.com>,
        <quic_harshq@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [RFC v4 1/5] dt-bindings: usb: Add bindings to support multiport properties
Date:   Sun, 15 Jan 2023 17:11:42 +0530
Message-ID: <20230115114146.12628-2-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230115114146.12628-1-quic_kriskura@quicinc.com>
References: <20230115114146.12628-1-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 88yNYB85aAxppARy2pJ7zTBIafxFkd2L
X-Proofpoint-ORIG-GUID: 88yNYB85aAxppARy2pJ7zTBIafxFkd2L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-15_07,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 phishscore=0 mlxlogscore=430 malwarescore=0 spamscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301150089
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings to indicate properties required to support multiport
on Snps Dwc3 controller.

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
 .../devicetree/bindings/usb/snps,dwc3.yaml    | 53 ++++++++++++++++---
 1 file changed, 47 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
index 6d78048c4613..3ea051beb2f8 100644
--- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
@@ -81,15 +81,26 @@ properties:
 
   phys:
     minItems: 1
-    maxItems: 2
+    maxItems: 8
 
   phy-names:
     minItems: 1
-    maxItems: 2
-    items:
-      enum:
-        - usb2-phy
-        - usb3-phy
+    maxItems: 8
+    oneOf:
+    - items:
+        enum:
+          - usb2-phy
+          - usb3-phy
+    - items:
+        enum:
+          - usb2-phy_port0
+          - usb2-phy_port1
+          - usb2-phy_port2
+          - usb2-phy_port3
+          - usb3-phy_port0
+          - usb3-phy_port1
+          - usb3-phy_port2
+          - usb3-phy_port3
 
   resets:
     minItems: 1
@@ -360,6 +371,22 @@ properties:
     description:
       Enable USB remote wakeup.
 
+  num-ports:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      This property indicates the number of ports present on the target that
+      are to be serviced by the DWC3 controller.
+    minimum: 1
+    maximum: 4
+
+  num-ss-ports:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      This property indicates the number of SS capable ports present on the
+      target that are to be serviced by the DWC3 controller.
+    minimum: 1
+    maximum: 4
+
 unevaluatedProperties: false
 
 required:
@@ -388,4 +415,18 @@ examples:
       snps,dis_u2_susphy_quirk;
       snps,dis_enblslpm_quirk;
     };
+  - |
+    usb@4a000000 {
+      compatible = "snps,dwc3";
+      reg = <0x4a000000 0xcfff>;
+      interrupts = <0 92 4>;
+      clocks = <&clk 1>, <&clk 2>, <&clk 3>;
+      clock-names = "bus_early", "ref", "suspend";
+      num-ports = <2>;
+      num-ss-ports = <1>;
+      phys = <&usb2_phy0>, <&usb3_phy0>, <&usb2_phy1>;
+      phy-names = "usb2-phy_port0", "usb3-phy_port0", "usb2-phy_port1";
+      snps,dis_u2_susphy_quirk;
+      snps,dis_enblslpm_quirk;
+    };
 ...
-- 
2.39.0

