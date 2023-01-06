Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B2865FDF0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 10:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234648AbjAFJ0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 04:26:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234766AbjAFJZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 04:25:39 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0607A75D1B;
        Fri,  6 Jan 2023 01:22:07 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3069C2np009102;
        Fri, 6 Jan 2023 09:21:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=S3ndMF2EYga5F7FTdml9lO0rJpUqZibLUywrYV+6qG4=;
 b=GRwl4OCR81lMw1rEAwrT4WpYCE+vTKqtbnOVYhHOCKV+9OVcH9eQ2uRFF50cuq5j+WTx
 POeMp4FSgt2BijeF0c+aD0tAmgofZobnDoTC9FmImGiXHM1dpANUmd61Nf7HyraY7OZp
 CW9BVwemCw+a78r5ZDjKFwgpoczAcKD1ic6qzD0F+a3I4vrOrWIweeh15HqA+QE0q428
 jZdc6OZXkiWGbObbB4LvZR4/ZbzmFVTkg46Uzz9ApewT+MxKyv+4COaeebJSUc1rMf05
 Ko0LvX+bqB7/5U5024BTrVbiYb0Va5o4WzBn7EIBTVcxs8TvsJFcV6zUOf8eQK4G8Fc9 3g== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mx3s1spct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Jan 2023 09:21:39 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3069Lcpq014876
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 6 Jan 2023 09:21:38 GMT
Received: from hu-jinlmao-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 6 Jan 2023 01:21:37 -0800
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
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v16 7/8] dt-bindings: arm: Adds CoreSight TPDA hardware definitions
Date:   Fri, 6 Jan 2023 01:21:18 -0800
Message-ID: <20230106092119.20449-8-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230106092119.20449-1-quic_jinlmao@quicinc.com>
References: <20230106092119.20449-1-quic_jinlmao@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3c-OsY1NHAUsve4f-_RK4-aN7BEv9ctR
X-Proofpoint-GUID: 3c-OsY1NHAUsve4f-_RK4-aN7BEv9ctR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-06_05,2023-01-05_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301060073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
 .../bindings/arm/qcom,coresight-tpda.yaml     | 129 ++++++++++++++++++
 MAINTAINERS                                   |   2 +-
 2 files changed, 130 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml

diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
new file mode 100644
index 000000000000..2ec9b5b24d73
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
@@ -0,0 +1,129 @@
+# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
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
+  There is no strict binding between TPDM and TPDA. TPDA can have multiple
+  TPDMs connect to it. But There must be only one TPDA in the path from the
+  TPDM source to TMC sink. TPDM can directly connect to TPDA's inport or
+  connect to funnel which will connect to TPDA's inport.
+
+  We can use the commands are similar to the below to validate TPDMs.
+  Enable coresight sink first.
+
+  echo 1 > /sys/bus/coresight/devices/tmc_etf0/enable_sink
+  echo 1 > /sys/bus/coresight/devices/tpdm0/enable_source
+  echo 1 > /sys/bus/coresight/devices/tpdm0/integration_test
+  echo 2 > /sys/bus/coresight/devices/tpdm0/integration_test
+
+  The test data will be collected in the coresight sink which is enabled.
+  If rwp register of the sink is keeping updating when do integration_test
+  (by cat tmc_etf0/mgmt/rwp), it means there is data generated from TPDM
+  to sink.
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
index 92e7805bf2e3..d7d22becc647 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2124,7 +2124,7 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux.git
 F:	Documentation/ABI/testing/sysfs-bus-coresight-devices-*
 F:	Documentation/devicetree/bindings/arm/arm,coresight-*.yaml
-F:	Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
+F:	Documentation/devicetree/bindings/arm/qcom,coresight-*.yaml
 F:	Documentation/devicetree/bindings/arm/arm,embedded-trace-extension.yaml
 F:	Documentation/devicetree/bindings/arm/arm,trace-buffer-extension.yaml
 F:	Documentation/trace/coresight/*
-- 
2.39.0

