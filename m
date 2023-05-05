Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E626F7CFE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 08:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbjEEGhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 02:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjEEGhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 02:37:16 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6556B903F;
        Thu,  4 May 2023 23:37:15 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3453pxa2028286;
        Fri, 5 May 2023 06:36:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=9L+iB+ub3r6TEbQMkcIk5JjrUEajBbROhVfVmyFK9uc=;
 b=hD0pjDoqXr7WNo2lSur9dWV1UVgHzi9J1MvMOPOIZYR6mAvMIsvHILQCSuJ8j2biguW2
 JCqa2ct7lznPGYvSMs0Tr9KZ2TnwZJaIl1LnmgpZxHNRPvZR84EiblpqhbarSnv7+zkb
 o90qmR3gVkoTpPtAIGGKLeXM5MZtJ6n4hGvKElnqphYuvqJC/tBf8VgcTUIS67iNN57R
 e6IXhs5b4yeRqsz1FMsI4R3rC03jkvkSsW3XoQqGjApojknwyIbwq+In9xnmfaVe/qlq
 zD2+geeu8LwTgyfh7nlMrICCvW3cEut7ic/x1fRDF9m80looKxuIG5VPEKm+zb+LmyTR dQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qckf70y5b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 May 2023 06:36:57 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3456aufl004091
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 5 May 2023 06:36:56 GMT
Received: from hu-schowdhu-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 4 May 2023 23:36:56 -0700
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Alex Elder <elder@ieee.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Subject: [PATCH V23 1/3] dt-bindings: misc: qcom,dcc: Add the dtschema
Date:   Thu, 4 May 2023 23:36:21 -0700
Message-ID: <a717ae0171243419e32b63db5462ba6347284fe0.1683265984.git.quic_schowdhu@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1683265984.git.quic_schowdhu@quicinc.com>
References: <cover.1683265984.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: x23Dq8O44zbUjts3S2hAnsN6iiu9tcOg
X-Proofpoint-ORIG-GUID: x23Dq8O44zbUjts3S2hAnsN6iiu9tcOg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_15,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 bulkscore=0 phishscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305050056
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the device tree bindings for Data Capture and Compare(DCC).

Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/misc/qcom,dcc.yaml    | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/qcom,dcc.yaml

diff --git a/Documentation/devicetree/bindings/misc/qcom,dcc.yaml b/Documentation/devicetree/bindings/misc/qcom,dcc.yaml
new file mode 100644
index 000000000000..572c10e7c2c8
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/qcom,dcc.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/misc/qcom,dcc.yaml#
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
+      - description: DCC base
+      - description: DCC RAM base
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
+        compatible = "qcom,sm8150-dcc", "qcom,dcc";
+        reg = <0x010a2000 0x1000>,
+              <0x010ad000 0x2000>;
+    };
-- 
2.17.1

