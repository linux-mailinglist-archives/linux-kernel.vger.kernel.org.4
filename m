Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B86615F98
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 10:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbiKBJXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 05:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbiKBJVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 05:21:23 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC547652;
        Wed,  2 Nov 2022 02:20:21 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A2998JE024836;
        Wed, 2 Nov 2022 09:20:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=m91dTGqMCPtaloE6kq956kQd/IyaSUJjpVzmlyvzJrc=;
 b=mmWr9rfbIHohSvfrDiOim5+yHumGI4QgpnLXGtAsO6ZxZalZaknj1pLVF3DYYPCq2TEG
 5lMFoS+AWboRvhwlZVr0QoVKSvmT81Yx3tpgUx9CFuKuVKK/KnhxPHRT0Q/ELvP8iVYq
 PseG2hSjD+MmVJpY1u0SrPm8Orz/1aFsMI7ip231GHX3CLKtfKBeEFLOZI1Qku43rFT3
 X87tqf58jnhjlr1McNXy2A9ogQ0Bfgg3h7p6/B1lU6lBqxKPegfKo0qFgzn/PI4V6uvg
 oZNkzqo2Hb/BvK6mBkeBk3mtSWxlAyVkHWPZL/SztPsBr7IbsZHDtEi0WeI+1TH4fIXh lQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kkjb0gf3x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 09:20:08 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A29K71s013767
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Nov 2022 09:20:07 GMT
Received: from jinlmao-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 2 Nov 2022 02:20:02 -0700
From:   Mao Jinlong <quic_jinlmao@quicinc.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        Leo Yan <leo.yan@linaro.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH v14 7/9] dt-bindings: arm: Adds CoreSight TPDA hardware definitions
Date:   Wed, 2 Nov 2022 17:19:13 +0800
Message-ID: <20221102091915.15281-8-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221102091915.15281-1-quic_jinlmao@quicinc.com>
References: <20221102091915.15281-1-quic_jinlmao@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: atdKF8q0YdjPtkXSZ9wg6dHwyloTlqL7
X-Proofpoint-ORIG-GUID: atdKF8q0YdjPtkXSZ9wg6dHwyloTlqL7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_06,2022-11-01_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0 mlxlogscore=999
 priorityscore=1501 mlxscore=0 adultscore=3 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211020055
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds new coresight-tpda.yaml file describing the bindings required
to define tpda in the device trees.

Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
---
 .../bindings/arm/qcom,coresight-tpda.yaml     | 111 ++++++++++++++++++
 MAINTAINERS                                   |   2 +-
 2 files changed, 112 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml

diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
new file mode 100644
index 000000000000..eb9bfc5f93a2
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
@@ -0,0 +1,111 @@
+# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/qcom,coresight-tpda.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Trace, Profiling and Diagnostics Aggregator - TPDA
+
+description: |
+  TPDAs are responsible for packetization and timestamping of data sets
+  utilizing the MIPI STPv2 packet protocol. Pulling data sets from one or
+  more attached TPDM and pushing the resultant (packetized) data out a
+  master ATB interface. Performing an arbitrated ATB interleaving (funneling)
+  task for free-flowing data from TPDM (i.e. CMB and DSB data set flows).
+
+maintainers:
+  - Mao Jinlong <quic_jinlmao@quicinc.com>
+  - Tao Zhang <quic_taozha@quicinc.com>
+
+# Need a custom select here or 'arm,primecell' will match on lots of nodes
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - qcom,coresight-tpda
+  required:
+    - compatible
+
+properties:
+  $nodename:
+    pattern: "^tpda(@[0-9a-f]+)$"
+  compatible:
+    items:
+      - const: qcom,coresight-tpda
+      - const: arm,primecell
+
+  reg:
+    minItems: 1
+    maxItems: 2
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: apb_pclk
+
+  in-ports:
+    type: object
+    description: |
+      Input connections from TPDM to TPDA
+    $ref: /schemas/graph.yaml#/properties/ports
+
+  out-ports:
+    type: object
+    description: |
+      Output connections from the TPDA to legacy CoreSight trace bus.
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port:
+        description:
+          Output connection from the TPDA to legacy CoreSight Trace bus.
+        $ref: /schemas/graph.yaml#/properties/port
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - in-ports
+  - out-ports
+
+additionalProperties: false
+
+examples:
+  # minimum tpda definition.
+  - |
+    tpda@6004000 {
+       compatible = "qcom,coresight-tpda", "arm,primecell";
+       reg = <0x6004000 0x1000>;
+
+       clocks = <&aoss_qmp>;
+       clock-names = "apb_pclk";
+
+       in-ports {
+         #address-cells = <1>;
+         #size-cells = <0>;
+
+        port@0 {
+          reg = <0>;
+          tpda_qdss_0_in_tpdm_dcc: endpoint {
+            remote-endpoint =
+              <&tpdm_dcc_out_tpda_qdss_0>;
+            };
+        };
+      };
+
+       out-ports {
+         port {
+                 tpda_qdss_out_funnel_in0: endpoint {
+                    remote-endpoint =
+                    <&funnel_in0_in_tpda_qdss>;
+                  };
+          };
+       };
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 485b0ca691fb..9154d296ba8d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2060,7 +2060,7 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux.git
 F:	Documentation/ABI/testing/sysfs-bus-coresight-devices-*
 F:	Documentation/devicetree/bindings/arm/arm,coresight-*.yaml
-F:	Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
+F:	Documentation/devicetree/bindings/arm/qcom,coresight-*.yaml
 F:	Documentation/devicetree/bindings/arm/arm,embedded-trace-extension.yaml
 F:	Documentation/devicetree/bindings/arm/arm,trace-buffer-extension.yaml
 F:	Documentation/trace/coresight/*
-- 
2.17.1

