Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E0660E87C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 21:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234652AbiJZTI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 15:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234532AbiJZTHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 15:07:39 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A882528B;
        Wed, 26 Oct 2022 12:05:23 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29QIqOt2007406;
        Wed, 26 Oct 2022 19:05:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=jhYpsaV1LXRk5dkWzA/68/wdRiQQdS22qh0RRflz7xs=;
 b=pGMJxAYatwZQaMfGqJDkPHIlm8bAMkdoQkeG/+2wjSwEp/r4AjitL43fcmbk1WgAHq4b
 daIh47BoSAq3KiOmEAnC/BAr3urt9GYIZRebk1a30z6PGDYlSLa0ELr8IopiI2u/d4oE
 yvVtDjRBPhiPhMu6fiAwQHp4PiCaKUHe90DwXiruCcSAhMqPKp+vErxDmwi/339lTLjE
 G8kwUKLaUu8fXSuyq6ZnYylgv7ixiTgrYVoqgCYNPiRSYLHJk+iejQVJswvzqqycIhVh
 3NdL2S7hz4s0uWR4vDss83QK0MKLptF4xXhlbj1tjTmPZhnaJLXLjKSDIn1WXzphrcts 2g== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kfahvr1kp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Oct 2022 19:05:20 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29QJ5JB1003674
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Oct 2022 19:05:19 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 26 Oct 2022 12:05:18 -0700
From:   Melody Olvera <quic_molvera@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>
Subject: [PATCH v3 1/2] dt-bindings: pinctrl: qcom: Add QDU1000 and QRU1000 pinctrl bindings
Date:   Wed, 26 Oct 2022 12:04:56 -0700
Message-ID: <20221026190457.4003037-2-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221026190457.4003037-1-quic_molvera@quicinc.com>
References: <20221026190457.4003037-1-quic_molvera@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ZKZL1FPVySv-froeni7G-f4gHs-bxUZr
X-Proofpoint-ORIG-GUID: ZKZL1FPVySv-froeni7G-f4gHs-bxUZr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-26_07,2022-10-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0 spamscore=0
 adultscore=0 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2210260107
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation details for device tree bindings for QDU1000 and QRU1000
TLMM devices.

Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
---
 .../bindings/pinctrl/qcom,qdu1000-tlmm.yaml   | 135 ++++++++++++++++++
 1 file changed, 135 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,qdu1000-tlmm.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,qdu1000-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,qdu1000-tlmm.yaml
new file mode 100644
index 000000000000..a2ca4d59e2e0
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,qdu1000-tlmm.yaml
@@ -0,0 +1,135 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/qcom,qdu1000-tlmm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies, Inc. QDU1000/QRU1000 TLMM block
+
+maintainers:
+  - Melody Olvera <quic_molvera@quicinc.com>
+
+description: |
+  This binding describes the Top Level Mode Multiplexer block (TLMM) found
+  in the QDU1000 and QRU1000 platforms.
+
+allOf:
+  - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: qcom,qdu1000-tlmm
+
+  reg:
+    maxItems: 1
+
+  interrupts: true
+  interrupt-controller: true
+  "#interrupt-cells": true
+  gpio-controller: true
+
+  gpio-reserved-ranges:
+    minItems: 1
+    maxItems: 75
+
+  gpio-line-names:
+    maxItems: 151
+
+  "#gpio-cells": true
+  gpio-ranges: true
+  wakeup-parent: true
+
+patternProperties:
+  "-state$":
+    oneOf:
+      - $ref: "#/$defs/qcom-qdu1000-tlmm-state"
+      - patternProperties:
+          "-pins$":
+            $ref: "#/$defs/qcom-qdu1000-tlmm-state"
+        additionalProperties: false
+
+$defs:
+  qcom-qdu1000-tlmm-state:
+    type: object
+    description:
+      Pinctrl node's client devices use subnodes for desired pin configuration.
+      Client device subnodes use below standard properties.
+    $ref: qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state
+
+    properties:
+      pins:
+        description:
+          List of gpio pins affected by the properties specified in this
+          subnode.
+        items:
+          oneOf:
+            - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-4][0-9])$"
+            - enum: [ sdc1_rclk, sdc1_clk, sdc1_cmd, sdc1_data ]
+        minItems: 1
+        maxItems: 36
+
+      function:
+        description:
+          Specify the alternative function to be configured for the specified
+          pins.
+        enum: [ atest_char, atest_usb, char_exec, CMO_PRI, cmu_rng,
+                dbg_out_clk, ddr_bist, ddr_pxi1, ddr_pxi2, ddr_pxi3, ddr_pxi4,
+                ddr_pxi5, ddr_pxi6, ddr_pxi7, eth012_int_n, eth345_int_n,
+                gcc_gp1, gcc_gp2, gcc_gp3, gpio, gps_pps_in, hardsync_pps_in,
+                intr_c, jitter_bist_ref, pcie_clkreqn, phase_flag, pll_bist,
+                pll_clk, prng_rosc, qdss_cti, qdss_gpio, qlink0_enable,
+                qlink0_request, qlink0_wmss, qlink1_enable, qlink1_request,
+                qlink1_wmss, qlink2_enable, qlink2_request, qlink2_wmss,
+                qlink3_enable, qlink3_request, qlink3_wmss, qlink4_enable,
+                qlink4_request, qlink4_wmss, qlink5_enable, qlink5_request,
+                qlink5_wmss, qlink6_enable, qlink6_request, qlink6_wmss,
+                qlink7_enable, qlink7_request, qlink7_wmss, qspi_clk, qspi_cs,
+                qspi0, qspi1, qspi2, qspi3, qup00, qup01, qup02, qup03, qup04,
+                qup05, qup06, qup07, qup08, qup10, qup11, qup12, qup13, qup14,
+                qup15, qup16, qup17, qup20, qup21, qup22, SI5518_INT, smb_alert,
+                smb_clk, smb_dat, tb_trig, tgu_ch0, tgu_ch1, tgu_ch2, tgu_ch3,
+                tgu_ch4, tgu_ch5, tgu_ch6, tgu_ch7, tmess_prng0, tmess_prng1,
+                tmess_prng2, tmess_prng3, tod_pps_in, tsense_pwm1, tsense_pwm2,
+                usb2phy_ac, usb_con_det, usb_dfp_en, usb_phy, vfr_0, vfr_1,
+                vsense_trigger ]
+
+      bias-disable: true
+      bias-pull-down: true
+      bias-pull-up: true
+      drive-strength: true
+      input-enable: true
+      output-high: true
+      output-low: true
+
+    required:
+      - pins
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    pinctrl@f000000 {
+        compatible = "qcom,qdu1000-tlmm";
+        reg = <0xf000000 0x1000000>;
+        interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+        gpio-controller;
+        #gpio-cells = <2>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+        gpio-ranges = <&tlmm 0 0 151>;
+        wakeup-parent = <&pdc>;
+
+        uart0-default-state {
+            pins = "gpio6", "gpio7", "gpio8", "gpio9";
+            function = "qup00";
+        };
+    };
-- 
2.25.1

