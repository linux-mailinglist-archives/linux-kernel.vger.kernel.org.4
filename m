Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F42086060F9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 15:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbiJTNHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 09:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbiJTNHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 09:07:15 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01BF15625B;
        Thu, 20 Oct 2022 06:07:12 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29KBSBah019462;
        Thu, 20 Oct 2022 13:06:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=l+GyvNelq8cuzQ1ye6WkY8CoMVFfP12/0oM5XZlZodE=;
 b=fN9YyQQJcwHhum4Dmmos8AJ10kLU51IZ3vd5k7IGLGvDpvicDPDGkZIWl7xSXT4vLBqd
 r/+QpEquQv4+d701dM/zuCvGEPt+3wSlNf6ha+TKtu8KnRGEjm/+zuPi8M5ctKG3/ypa
 CbfaOIpPR6h7fxxNoJiRDfAErCABYG9XXfYI57/CmovHitOWuN7QaacgbB6BYzfVpCRh
 HDqq9bab3LQa5A+2RLgUVuy86mI1S7g0NLV38eQIpO5Kv353BD/KB5tJHux8ZjhgWqDM
 CmaT2Xxl58rQqMNDMxWlu3UNAiQQl8E9ksVRqCze2OpkDyBKQY1srbu3jBp1EDmo01AY UQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ka820wu96-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Oct 2022 13:06:20 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29KD6KYv013627
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Oct 2022 13:06:20 GMT
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 20 Oct 2022 06:06:13 -0700
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <vkoul@kernel.org>, <agross@kernel.org>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@quicinc.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <quic_rohkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        "Ratna Deepthi Kudaravalli" <quic_rkudarav@quicinc.com>
Subject: [PATCH v3] dt-bindings: soundwire: Convert text bindings to DT Schema
Date:   Thu, 20 Oct 2022 18:36:00 +0530
Message-ID: <1666271160-22424-1-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3H-9SeryMe4yQzRIA0edKg9zPt2GpKlY
X-Proofpoint-GUID: 3H-9SeryMe4yQzRIA0edKg9zPt2GpKlY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-20_05,2022-10-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 malwarescore=0 mlxscore=0 impostorscore=0 suspectscore=0 phishscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210200078
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert soundwire text bindings to DT Schema format.

Update interrupt property items as per device tree,
as it is not appropriately described in text file.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Co-developed-by: Ratna Deepthi Kudaravalli <quic_rkudarav@quicinc.com>
Signed-off-by: Ratna Deepthi Kudaravalli <quic_rkudarav@quicinc.com>
---
This patch depends on:
    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=42801e6185290d63691bd39cf8a3bba6cd5fe520
Changes since V2:
  -- Update commit message.
  -- Add child node property.
  -- Change file name.
  -- Remove minIteams for few properties.
  -- Remove redundant required properties.
  -- Remove redundant description for wakeup-source property.
  -- Update interrupt property items.
Changes since V1:
  -- Remove the status field in example.
  -- Remove interrupt-names property in the required list.
  -- Add the wakeup-source property.	
 
 .../devicetree/bindings/soundwire/qcom,sdw.txt     | 214 ---------------------
 .../bindings/soundwire/qcom,soundwire.yaml         | 184 ++++++++++++++++++
 2 files changed, 184 insertions(+), 214 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/soundwire/qcom,sdw.txt
 create mode 100644 Documentation/devicetree/bindings/soundwire/qcom,soundwire.yaml

diff --git a/Documentation/devicetree/bindings/soundwire/qcom,sdw.txt b/Documentation/devicetree/bindings/soundwire/qcom,sdw.txt
deleted file mode 100644
index c85c257..0000000
--- a/Documentation/devicetree/bindings/soundwire/qcom,sdw.txt
+++ /dev/null
@@ -1,214 +0,0 @@
-Qualcomm SoundWire Controller Bindings
-
-
-This binding describes the Qualcomm SoundWire Controller along with its
-board specific bus parameters.
-
-- compatible:
-	Usage: required
-	Value type: <stringlist>
-	Definition: must be "qcom,soundwire-v<MAJOR>.<MINOR>.<STEP>",
-		    Example:
-			"qcom,soundwire-v1.3.0"
-			"qcom,soundwire-v1.5.0"
-			"qcom,soundwire-v1.5.1"
-			"qcom,soundwire-v1.6.0"
-- reg:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: the base address and size of SoundWire controller
-		    address space.
-
-- interrupts:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: should specify the SoundWire Controller core and optional
-		    wake IRQ
-
-- interrupt-names:
-	Usage: Optional
-	Value type: boolean
-	Value type: <stringlist>
-	Definition: should be "core" for core and "wakeup" for wake interrupt.
-
-- wakeup-source:
-	Usage: Optional
-	Value type: boolean
-	Definition: should specify if SoundWire Controller is wake up capable.
-
-- clock-names:
-	Usage: required
-	Value type: <stringlist>
-	Definition: should be "iface" for SoundWire Controller interface clock
-
-- clocks:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: should specify the SoundWire Controller interface clock
-
-- #sound-dai-cells:
-	Usage: required
-	Value type: <u32>
-	Definition: must be 1 for digital audio interfaces on the controller.
-
-- qcom,dout-ports:
-	Usage: required
-	Value type: <u32>
-	Definition: must be count of data out ports
-
-- qcom,din-ports:
-	Usage: required
-	Value type: <u32>
-	Definition: must be count of data in ports
-
-- qcom,ports-offset1:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: should specify payload transport window offset1 of each
-		    data port. Out ports followed by In ports.
-		    Value of 0xFF indicates that this option is not implemented
-		    or applicable for the respective data port.
-		    More info in MIPI Alliance SoundWire 1.0 Specifications.
-
-- qcom,ports-offset2:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: should specify payload transport window offset2 of each
-		    data port. Out ports followed by In ports.
-		    Value of 0xFF indicates that this option is not implemented
-		    or applicable for the respective data port.
-		    More info in MIPI Alliance SoundWire 1.0 Specifications.
-
-- qcom,ports-sinterval-low:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: should be sample interval low of each data port.
-		    Out ports followed by In ports. Used for Sample Interval
-		    calculation.
-		    Value of 0xFF indicates that this option is not implemented
-		    or applicable for the respective data port.
-		    More info in MIPI Alliance SoundWire 1.0 Specifications.
-
-- qcom,ports-word-length:
-	Usage: optional
-	Value type: <prop-encoded-array>
-	Definition: should be size of payload channel sample.
-		    Value of 0xFF indicates that this option is not implemented
-		    or applicable for the respective data port.
-		    More info in MIPI Alliance SoundWire 1.0 Specifications.
-
-- qcom,ports-block-pack-mode:
-	Usage: optional
-	Value type: <prop-encoded-array>
-	Definition: should be 0 or 1 to indicate the block packing mode.
-		    0 to indicate Blocks are per Channel
-		    1 to indicate Blocks are per Port.
-		    Out ports followed by In ports.
-		    Value of 0xFF indicates that this option is not implemented
-		    or applicable for the respective data port.
-		    More info in MIPI Alliance SoundWire 1.0 Specifications.
-
-- qcom,ports-block-group-count:
-	Usage: optional
-	Value type: <prop-encoded-array>
-	Definition: should be in range 1 to 4 to indicate how many sample
-		    intervals are combined into a payload.
-		    Out ports followed by In ports.
-		    Value of 0xFF indicates that this option is not implemented
-		    or applicable for the respective data port.
-		    More info in MIPI Alliance SoundWire 1.0 Specifications.
-
-- qcom,ports-lane-control:
-	Usage: optional
-	Value type: <prop-encoded-array>
-	Definition: should be in range 0 to 7 to identify which	data lane
-		    the data port uses.
-		    Out ports followed by In ports.
-		    Value of 0xFF indicates that this option is not implemented
-		    or applicable for the respective data port.
-		    More info in MIPI Alliance SoundWire 1.0 Specifications.
-
-- qcom,ports-hstart:
-	Usage: optional
-	Value type: <prop-encoded-array>
-	Definition: should be number identifying lowerst numbered coloum in
-		    SoundWire Frame, i.e. left edge of the Transport sub-frame
-		    for each port. Values between 0 and 15 are valid.
-		    Out ports followed by In ports.
-		    Value of 0xFF indicates that this option is not implemented
-		    or applicable for the respective data port.
-		    More info in MIPI Alliance SoundWire 1.0 Specifications.
-
-- qcom,ports-hstop:
-	Usage: optional
-	Value type: <prop-encoded-array>
-	Definition: should be number identifying highest numbered coloum in
-		    SoundWire Frame, i.e. the right edge of the Transport
-		    sub-frame for each port. Values between 0 and 15 are valid.
-		    Out ports followed by In ports.
-		    Value of 0xFF indicates that this option is not implemented
-		    or applicable for the respective data port.
-		    More info in MIPI Alliance SoundWire 1.0 Specifications.
-
-- qcom,dports-type:
-	Usage: optional
-	Value type: <prop-encoded-array>
-	Definition: should be one of the following types
-		    0 for reduced port
-		    1 for simple ports
-		    2 for full port
-		    Out ports followed by In ports.
-		    Value of 0xFF indicates that this option is not implemented
-		    or applicable for the respective data port.
-		    More info in MIPI Alliance SoundWire 1.0 Specifications.
-
-- reset:
-	Usage: optional
-	Value type: <prop-encoded-array>
-	Definition: Should specify the SoundWire audio CSR reset controller interface,
-		    which is required for SoundWire version 1.6.0 and above.
-
-- reset-names:
-	Usage: optional
-	Value type: <stringlist>
-	Definition: should be "swr_audio_cgcr" for SoundWire audio CSR reset
-		    controller interface.
-
-Note:
-	More Information on detail of encoding of these fields can be
-found in MIPI Alliance SoundWire 1.0 Specifications.
-
-= SoundWire devices
-Each subnode of the bus represents SoundWire device attached to it.
-The properties of these nodes are defined by the individual bindings.
-
-= EXAMPLE
-The following example represents a SoundWire controller on DB845c board
-which has controller integrated inside WCD934x codec on SDM845 SoC.
-
-soundwire: soundwire@c85 {
-	compatible = "qcom,soundwire-v1.3.0";
-	reg = <0xc85 0x20>;
-	interrupts = <20 IRQ_TYPE_EDGE_RISING>;
-	clocks = <&wcc>;
-	clock-names = "iface";
-	resets = <&lpass_audiocc LPASS_AUDIO_SWR_TX_CGCR>;
-	reset-names = "swr_audio_cgcr";
-	#sound-dai-cells = <1>;
-	qcom,dports-type = <0>;
-	qcom,dout-ports	= <6>;
-	qcom,din-ports	= <2>;
-	qcom,ports-sinterval-low = /bits/ 8  <0x07 0x1F 0x3F 0x7 0x1F 0x3F 0x0F 0x0F>;
-	qcom,ports-offset1 = /bits/ 8 <0x01 0x02 0x0C 0x6 0x12 0x0D 0x07 0x0A >;
-	qcom,ports-offset2 = /bits/ 8 <0x00 0x00 0x1F 0x00 0x00 0x1F 0x00 0x00>;
-
-	/* Left Speaker */
-	left{
-		....
-	};
-
-	/* Right Speaker */
-	right{
-		....
-	};
-};
diff --git a/Documentation/devicetree/bindings/soundwire/qcom,soundwire.yaml b/Documentation/devicetree/bindings/soundwire/qcom,soundwire.yaml
new file mode 100644
index 0000000..12cd3c1
--- /dev/null
+++ b/Documentation/devicetree/bindings/soundwire/qcom,soundwire.yaml
@@ -0,0 +1,184 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soundwire/qcom,soundwire.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SoundWire Controller
+
+maintainers:
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+  - Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
+
+description:
+  The Qualcomm SoundWire controller along with its board specific bus parameters.
+
+properties:
+  compatible:
+    enum:
+      - qcom,soundwire-v1.3.0
+      - qcom,soundwire-v1.5.0
+      - qcom,soundwire-v1.5.1
+      - qcom,soundwire-v1.6.0
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: specify the SoundWire controller core.
+      - description: specify the Soundwire controller wake IRQ.
+
+  interrupt-names:
+    items:
+      - const: wakeup
+      - const: core
+
+  clocks:
+    items:
+      - description: iface clock
+
+  clock-names:
+    items:
+      - const: iface
+
+  resets:
+    items:
+      - description: SWR_AUDIO_CGCR RESET
+
+  reset-names:
+    items:
+      - const: swr_audio_cgcr
+
+  '#sound-dai-cells':
+    const: 1
+
+  '#address-cells':
+    const: 2
+
+  '#size-cells':
+    const: 0
+
+  wakeup-source: true
+
+  qcom,din-ports:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: count of data in ports
+
+  qcom,dout-ports:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: count of data out ports
+
+  qcom,ports-word-length:
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    description: size of payload channel sample.
+    maxItems: 5
+
+  qcom,ports-sinterval-low:
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    description: sample interval low of each data port.
+    maxItems: 5
+
+  qcom,ports-offset1:
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    description: payload transport window offset1 of each data port.
+    maxItems: 5
+
+  qcom,ports-offset2:
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    description: payload transport window offset2 of each data port.
+    maxItems: 5
+
+  qcom,ports-lane-control:
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    description: identify which data lane the data port uses.
+    maxItems: 5
+
+  qcom,ports-block-pack-mode:
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    description: indicate the block packing mode.
+    maxItems: 5
+
+  qcom,ports-hstart:
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    description: identifying lowerst numbered coloum in SoundWire frame.
+    maxItems: 5
+
+  qcom,ports-hstop:
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    description: identifying highest numbered coloum in SoundWire frame.
+    maxItems: 5
+
+  qcom,ports-block-group-count:
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    description: indicate how many sample intervals are combined into a payload.
+    maxItems: 5
+
+  codec@4:
+    $ref: ../sound/qcom,wcd938x-sdw.yaml#
+    description:
+      Qualcomm WCD9380/WCD9385 Codec is a standalone Hi-Fi audio codec IC.
+      It has RX and TX Soundwire slave devices. This bindings is for the
+      slave devices.
+    type: object
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - '#sound-dai-cells'
+  - '#address-cells'
+  - '#size-cells'
+  - qcom,dout-ports
+  - qcom,din-ports
+  - qcom,ports-sinterval-low
+  - qcom,ports-offset1
+  - qcom,ports-offset2
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/clock/qcom,lpassaudiocc-sc7280.h>
+
+    soundwire@3210000 {
+        compatible = "qcom,soundwire-v1.6.0";
+        reg = <0x03210000 0x2000>;
+
+        interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
+                     <&pdc 130 IRQ_TYPE_LEVEL_HIGH>;
+
+        clocks = <&lpass_rx_macro>;
+        clock-names = "iface";
+
+        qcom,din-ports = <0>;
+        qcom,dout-ports = <5>;
+
+        resets = <&lpass_audiocc LPASS_AUDIO_SWR_RX_CGCR>;
+        reset-names = "swr_audio_cgcr";
+
+        qcom,ports-word-length =        /bits/ 8 <0x01 0x07 0x04 0xff 0xff>;
+        qcom,ports-sinterval-low =      /bits/ 8 <0x03 0x3f 0x1f 0x03 0x03>;
+        qcom,ports-offset1 =            /bits/ 8 <0x00 0x00 0x0b 0x01 0x01>;
+        qcom,ports-offset2 =            /bits/ 8 <0x00 0x00 0x0b 0x00 0x00>;
+        qcom,ports-lane-control =       /bits/ 8 <0x01 0x00 0x00 0x00 0x00>;
+        qcom,ports-block-pack-mode =    /bits/ 8 <0xff 0x00 0x01 0xff 0xff>;
+        qcom,ports-hstart =             /bits/ 8 <0xff 0x03 0xff 0xff 0xff>;
+        qcom,ports-hstop =              /bits/ 8 <0xff 0x06 0xff 0xff 0xff>;
+        qcom,ports-block-group-count =  /bits/ 8 <0xff 0xff 0xff 0xff 0x00>;
+
+        #sound-dai-cells = <1>;
+        #address-cells = <2>;
+        #size-cells = <0>;
+
+        codec@4 {
+            compatible = "sdw20217010d00";
+            reg = <0 4>;
+            qcom,rx-port-mapping = <1 2 3 4 5>;
+        };
+
+    };
-- 
2.7.4

