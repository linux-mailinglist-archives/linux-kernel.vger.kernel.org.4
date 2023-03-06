Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E54356AD2B0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 00:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjCFXMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 18:12:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjCFXM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 18:12:29 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85ECF2386A;
        Mon,  6 Mar 2023 15:12:27 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 326N5XmO021527;
        Mon, 6 Mar 2023 23:12:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=omULz/2yvQYLDBSp/17RkFqhTWJMTk4HL7QPtaR04wk=;
 b=iduoyJeMbAhgyRXCh0HCwGZfe7dTaZ0sl03jE3/C5I38YhgZlLlG1jYnJcm69YgmZ53S
 cfUI6Ekt8WW1lUUn8LPWoUT210kER56tEjkiUpINjjy9anKEDic4pJGtHGjrq8l3SRuY
 BCEJ0CLMHOdUghNEOekoUiyuBl3CD3T1HXnh2OSIhBwTzkwRCVrYkuw3AAhJrip8snhP
 DMArYcRn1iJttFVlA8t3fSsOU+pthmGs/Sx/ZgC6vafe/PQRLxiER35yMD1ljoquMSR4
 IaQAtbr0jpuwpBZ47dI1LB0dfirBnQN+R/FxQHoXWjTmoD9R23KL9pFDqbhZqaPP2Wzj 6g== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p41876b0k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 23:12:23 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 326NCM5Z019349
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 6 Mar 2023 23:12:22 GMT
Received: from hu-molvera-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 6 Mar 2023 15:12:22 -0800
From:   Melody Olvera <quic_molvera@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>
CC:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>
Subject: [PATCH v2 3/7] dt-bindings: remoteproc: mpss: Document QDU1000/QRU1000 mpss devices
Date:   Mon, 6 Mar 2023 15:11:58 -0800
Message-ID: <20230306231202.12223-4-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230306231202.12223-1-quic_molvera@quicinc.com>
References: <20230306231202.12223-1-quic_molvera@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3JBtrnWMyHSwr2MPF6klsZjiIMXUvrow
X-Proofpoint-ORIG-GUID: 3JBtrnWMyHSwr2MPF6klsZjiIMXUvrow
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_14,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=952 bulkscore=0 suspectscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303060202
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This documents the compatible for the component used to boot the
MPSS on the QDU1000 and QRU1000 SoCs.

The QDU1000 and QRU1000 mpss boot process now requires the specification
of an RMB register space to complete the handshake needed to start or
attach the mpss.

Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
---
 .../remoteproc/qcom,qdu1000-mpss-pas.yaml     | 130 ++++++++++++++++++
 1 file changed, 130 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,qdu1000-mpss-pas.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,qdu1000-mpss-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,qdu1000-mpss-pas.yaml
new file mode 100644
index 000000000000..9cb4296c1fa6
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,qdu1000-mpss-pas.yaml
@@ -0,0 +1,130 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/remoteproc/qcom,qdu1000-mpss-pas.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm QDU1000 Modem Peripheral Authentication Service
+
+maintainers:
+  - Melody Olvera <quic_molvera@quicinc.com>
+
+description:
+  Qualcomm QDU1000 SoC Peripheral Authentication Service loads and boots firmware
+  on the Qualcomm DSP Hexagon core.
+
+properties:
+  compatible:
+    enum:
+      - qcom,qdu1000-mpss-pas
+
+  reg:
+    maxItems: 2
+
+  clocks:
+    items:
+      - description: XO clock
+
+  clock-names:
+    items:
+      - const: xo
+
+  qcom,qmp:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Reference to the AOSS side-channel message RAM.
+
+  smd-edge: false
+
+  firmware-name:
+    $ref: /schemas/types.yaml#/definitions/string-array
+    items:
+      - description: Firmware name of the Hexagon core
+      - description: Firmware name of the Hexagon Devicetree
+
+  memory-region:
+    items:
+      - description: Memory region for main Firmware authentication
+      - description: Memory region for Devicetree Firmware authentication
+      - description: DSM Memory region
+
+  interrupts:
+    minItems: 6
+
+  interrupt-names:
+    minItems: 6
+
+  interconnects:
+    minItems: 1
+
+  power-domains:
+    items:
+      - description: CX power domain
+      - description: MSS power domain
+
+  power-domain-names:
+    items:
+      - const: cx
+      - const: mss
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - $ref: /schemas/remoteproc/qcom,pas-common.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/interconnect/qcom,qdu1000-rpmh.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/mailbox/qcom-ipcc.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
+
+    remoteproc@4080000 {
+        compatible = "qcom,qdu1000-mpss-pas";
+        reg = <0x4080000 0x4040>,
+              <0x4180000 0x1000>;
+
+        clocks = <&rpmhcc RPMH_CXO_CLK>;
+        clock-names = "xo";
+
+        interrupts-extended = <&intc GIC_SPI 264 IRQ_TYPE_EDGE_RISING>,
+                              <&smp2p_modem_in 0 IRQ_TYPE_EDGE_RISING>,
+                              <&smp2p_modem_in 1 IRQ_TYPE_EDGE_RISING>,
+                              <&smp2p_modem_in 2 IRQ_TYPE_EDGE_RISING>,
+                              <&smp2p_modem_in 3 IRQ_TYPE_EDGE_RISING>,
+                              <&smp2p_modem_in 7 IRQ_TYPE_EDGE_RISING>;
+        interrupt-names = "wdog", "fatal", "ready", "handover",
+                          "stop-ack", "shutdown-ack";
+
+        memory-region = <&mpss_mem>, <&dtb_mpss_mem>, <&mpss_dsm_mem>;
+
+        firmware-name = "qcom/qdu1000/modem.mbn",
+                        "qcom/qdu1000/modem_dtb.mbn";
+
+        power-domains = <&rpmhpd QDU1000_CX>,
+                        <&rpmhpd QDU1000_MSS>;
+        power-domain-names = "cx", "mss";
+
+        interconnects = <&mc_virt MASTER_LLCC &mc_virt SLAVE_EBI1>;
+
+        qcom,qmp = <&aoss_qmp>;
+
+        qcom,smem-states = <&smp2p_adsp_out 0>;
+        qcom,smem-state-names = "stop";
+
+        glink-edge {
+            interrupts-extended = <&ipcc IPCC_CLIENT_MPSS
+                                         IPCC_MPROC_SIGNAL_GLINK_QMP
+                                         IRQ_TYPE_EDGE_RISING>;
+            mboxes = <&ipcc IPCC_CLIENT_MPSS IPCC_MPROC_SIGNAL_GLINK_QMP>;
+
+            label = "modem";
+            qcom,remote-pid = <2>;
+
+        };
+    };
-- 
2.25.1

