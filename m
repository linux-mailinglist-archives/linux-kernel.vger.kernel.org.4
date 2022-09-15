Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5757C5B9CD7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 16:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiIOOUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 10:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiIOOT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 10:19:58 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E87217073;
        Thu, 15 Sep 2022 07:19:57 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28FDw41v014423;
        Thu, 15 Sep 2022 14:19:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=6dAyzQe89u0mG11KpSWzWdayugn/QcfUtFtIUyj7M7Y=;
 b=EHc0QLl6ZuGVXw5K7gjl3rPA+6LY61RRFJxu/7YgGaIXfODI1DSTKT77Fci3TLpI5mKZ
 +/UdFiUukbTeXGnItI1o/mnQ7D4zcjuW55vm6nB81J+fShGKZPvfq833SJBpygm9uyec
 bTqW7lWVKXEN5xGKFBpaPPUfMbwY6C6JAorQ3b+6Cvb68toJpgQeuwL3Ky+jM4papkyI
 qwqlTCQiVfy+fqCHbjMlGIHBx//G0/k9daCMIX1lO422N4eM29kq0sAuA+Fuf3V5wQs7
 SxFIwa6BSlheGypSAAuoMzy/JIbQN/LXe4cIITp6JIXBh0j/sExGPVkq8xsXQ42a+w35 Pw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jkwjesfbd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Sep 2022 14:19:51 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28FEJoEe007170
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Sep 2022 14:19:50 GMT
Received: from blr-ubuntu-525.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 15 Sep 2022 07:19:46 -0700
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Alex Elder <elder@ieee.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        "Sai Prakash Ranjan" <quic_saipraka@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>, <vkoul@kernel.org>,
        "Souradeep Chowdhury" <quic_schowdhu@quicinc.com>
Subject: [PATCH V10 1/7] dt-bindings: Added the yaml bindings for DCC
Date:   Thu, 15 Sep 2022 19:48:41 +0530
Message-ID: <c6b55a5b44a8add13ea9015542522b2562cf8f60.1663250640.git.quic_schowdhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1663250639.git.quic_schowdhu@quicinc.com>
References: <cover.1663250639.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: IEEaVU3VsiyAzZ0Q9N5NuCkGS_1zl4X3
X-Proofpoint-GUID: IEEaVU3VsiyAzZ0Q9N5NuCkGS_1zl4X3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-15_08,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 clxscore=1015 impostorscore=0
 adultscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209150083
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation for Data Capture and Compare(DCC) device tree bindings
in yaml format.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
---
 .../devicetree/bindings/arm/msm/qcom,dcc.yaml      | 44 ++++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,dcc.yaml

diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,dcc.yaml b/Documentation/devicetree/bindings/arm/msm/qcom,dcc.yaml
new file mode 100644
index 0000000..8396b0c
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/msm/qcom,dcc.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/msm/qcom,dcc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Data Capture and Compare
+
+maintainers:
+  - Souradeep Chowdhury <quic_schowdhu@quicinc.com>
+
+description: |
+    DCC (Data Capture and Compare) is a DMA engine which is used to save
+    configuration data or system memory contents during catastrophic failure
+    or SW trigger. DCC is used to capture and store data for debugging purpose
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - qcom,sm8150-dcc
+          - qcom,sc7280-dcc
+          - qcom,sc7180-dcc
+          - qcom,sdm845-dcc
+      - const: qcom,dcc
+
+  reg:
+    items:
+      - description: DCC base register region
+      - description: DCC RAM base register region
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    dma@10a2000{
+                compatible = "qcom,sm8150-dcc","qcom,dcc";
+                reg = <0x010a2000 0x1000>,
+                      <0x010ad000 0x2000>;
+    };
-- 
2.7.4

