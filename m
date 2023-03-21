Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6CF6C3363
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 14:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjCUNx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 09:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbjCUNxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 09:53:25 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2054ECCF;
        Tue, 21 Mar 2023 06:53:12 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32LDaxTg014539;
        Tue, 21 Mar 2023 13:53:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=0rmgemONNJfGZzVwQn3IfTQ2H6gFeJjA70ihHxeH6+o=;
 b=GSOdZsr/j1NYZtXdRIDVOiPIfKPLXdN0bUxex/RT0XaF7SvBqNvgAPgZFgr+Fon50YYe
 Gr23PPWts5+4CsEnjgEzXjnkBqMzRDBlOl0+RjSwhYHxsDTO1tmq0YEfCsYRKmsc2s/8
 XXFzn8RQDJ590wv49MuTb1nM4eTohyp2FXbXM4MESius7k/OPZf64mU9tLHwhL5uEQiU
 3bltUkn4bkXSYtGo6g6rTMtZ8YlZwBNViB4VuvNz5qwtLPQDkHzzTS4NRZwPusWG+r/P
 6YfOMfKmD5XGGbZHAavpb70XJHXHcd2cnwd/BXBx5v6LYssXMnKOVEQtj7stbxzthY60 eA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pfdm4g1qk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Mar 2023 13:53:03 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32LDr24g020370
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Mar 2023 13:53:02 GMT
Received: from blr-ubuntu-525.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 21 Mar 2023 06:52:58 -0700
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Subject: [PATCH V1 2/4] dt-bindings: soc: qcom,mpm-sleep-counter: Add the dtschema
Date:   Tue, 21 Mar 2023 19:21:49 +0530
Message-ID: <576e53a1d0ef218536da976102b4cc207436ec1d.1679403696.git.quic_schowdhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1679403696.git.quic_schowdhu@quicinc.com>
References: <cover.1679403696.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: RXt_LeJy-5HaMCYtNhCmjyrwFMGMZsGB
X-Proofpoint-GUID: RXt_LeJy-5HaMCYtNhCmjyrwFMGMZsGB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_10,2023-03-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303210108
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the device tree bindings for the module power manager sleep
counter.

Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
---
 .../bindings/soc/qcom/qcom,mpm-sleep-counter.yaml  | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,mpm-sleep-counter.yaml

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,mpm-sleep-counter.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,mpm-sleep-counter.yaml
new file mode 100644
index 0000000..f9f46b7
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,mpm-sleep-counter.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/qcom/qcom,mpm-sleep-counter.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MPM Sleep Counter
+
+maintainers:
+  - Souradeep Chowdhury <quic_schowdhu@quicinc.com>
+
+description: |
+    MPM(Module Power Manager) has a sleep counter which is used to track
+    various stages of the boot process in Qualcomm.
+
+properties:
+  compatible:
+    items:
+      - const: qcom,mpm2-sleep-counter
+
+  reg:
+    items:
+      - description: MPM Sleep Counter Base
+
+  clock-frequency:
+    description: Frequency for the sleep counter
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    mpm2-sleep-counter@c221000{
+       compatible = "qcom,mpm2-sleep-counter";
+       reg = <0xc221000 0x1000>;
+       clock-frequency = <32768>;
+    };
-- 
2.7.4

