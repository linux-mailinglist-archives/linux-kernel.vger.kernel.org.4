Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCAD6282FE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 15:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237017AbiKNOmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 09:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236540AbiKNOlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 09:41:39 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04D42B1AC;
        Mon, 14 Nov 2022 06:41:37 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AEEK1X5001568;
        Mon, 14 Nov 2022 14:41:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=gHjNE0xcZgxtjK2/MLqyX9Dwm7rH9KWd+5MGtNGc6bE=;
 b=O3Gsro3rWGQQN/TnWFu7P67J3Em31IJStpwcCSfCzTSpUtJtty1zyWWgtIWkf7ty8IUB
 W0egjmCbY47DD5itAaOAn6NQnHty99kVx3K9IpmNPsBJCfGVDTYZ/qqRCvju6nBqSWU4
 s4YE6N0TQtNKHjOp8FcqIwkXelrrQhUCqq9b7f08RmslM4Gcc6R4+YueXFuTLE2YpOUz
 k5rE2CpwSbe8I5hEchkpX3dzbJehEHOcpsq0Lh531os04ih8gzv22Dzr9BbfZr5bIz+Y
 vcCGrIgvy2Cc2NAemMlNnIM2cvNDc+D4YShs62LBmxdgU8dqIWSHwqCh5TnOZPAgfwfl qQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kufk21a9w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 14:41:21 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AEEfLnV012923
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 14:41:21 GMT
Received: from jinlmao-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 14 Nov 2022 06:41:16 -0800
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
Subject: [PATCH v15 7/8] dt-bindings: arm: Adds CoreSight TPDA hardware definitions
Date:   Mon, 14 Nov 2022 22:40:26 +0800
Message-ID: <20221114144027.14365-8-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221114144027.14365-1-quic_jinlmao@quicinc.com>
References: <20221114144027.14365-1-quic_jinlmao@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: WCm00r6I4lckLSrarSBS0DyZ5YCBU7Q3
X-Proofpoint-GUID: WCm00r6I4lckLSrarSBS0DyZ5YCBU7Q3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-14_12,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211140104
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
 .../bindings/arm/qcom,coresight-tpda.yaml     | 129 ++++++++++++++++++
 MAINTAINERS                                   |   2 +-
 2 files changed, 130 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml

diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
new file mode 100644
index 000000000000..c46ddeaf0ced
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
@@ -0,0 +1,129 @@
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
index 1cf03790485c..b7721e9388a1 100644
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

