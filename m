Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242285FF621
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 00:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiJNWMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 18:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiJNWLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 18:11:49 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9B91CFC69;
        Fri, 14 Oct 2022 15:11:18 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29EK0vdJ009254;
        Fri, 14 Oct 2022 22:11:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=3WGZCzy1KQv2emLmCBiGDJCSaiNbwMJcZNfebMX7YWc=;
 b=VkIfQARlQj0gEVd4wKvLxfE1TQUrJ+fb/oX4moXoLUJ8GMM4+JZc8ytjlfCx03PNfKYc
 sjSSt7768Zq7o/8RQ3cKb5xv89jBc8DVFgRa1Fgu70QmX+PwTXiUd62jvavawcAKisb3
 l0fzVK2Fa7I+hOOOv1qFbs+nhgObVcYsLQeVPojgCa0IWNk0ZDvJDUXaOaLy1YXfvsUt
 EE+VqKLypM3YvdzTFoOvr+8zz26Bxqb+qxGroSygjHwqJ6qTx5XBXrLxlTMNtV4U24yO
 pT/0c32sx9GhhHK7cm/iNYEs9CT4pbeKsvq4zBTd31q2mDUqjCrYhIoHtRBiQJiC/z9i lw== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k75yftyje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Oct 2022 22:11:13 +0000
Received: from nasanex01b.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29EMBCi9005979
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Oct 2022 22:11:12 GMT
Received: from hu-molvera-sd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 14 Oct 2022 15:10:37 -0700
From:   Melody Olvera <quic_molvera@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>
Subject: [PATCH v2 1/2] dt-bindings: pinctrl: qcom: Add QDU1000 and QRU1000 pinctrl bindings
Date:   Fri, 14 Oct 2022 15:10:24 -0700
Message-ID: <20221014221025.7372-2-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221014221025.7372-1-quic_molvera@quicinc.com>
References: <20221014221025.7372-1-quic_molvera@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cS1F1ozjSt6jBWp4T_mt4Hx3F0KNXD6V
X-Proofpoint-ORIG-GUID: cS1F1ozjSt6jBWp4T_mt4Hx3F0KNXD6V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-14_11,2022-10-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2210140122
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation details for device tree bindings for QDU1000 and QRU1000
TLMM devices.

Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
---
 .../pinctrl/qcom,qdu1000-pinctrl.yaml         | 159 ++++++++++++++++++
 1 file changed, 159 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,qdu1000-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,qdu1000-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,qdu1000-pinctrl.yaml
new file mode 100644
index 000000000000..2ec661e5e1e0
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,qdu1000-pinctrl.yaml
@@ -0,0 +1,159 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/qcom,qdu1000-pinctrl.yaml#
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
+      - const: qcom,qru1000-tlmm
+
+  reg:
+    maxItems: 1
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
+    maxItems: 150
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
+            - enum: [ ufs_reset, sdc2_clk, sdc2_cmd, sdc2_data ]
+        minItems: 1
+        maxItems: 36
+
+      function:
+        description:
+          Specify the alternative function to be configured for the specified
+          pins.
+        enum: [ adsp_ext, agera_pll, atest_char, atest_tsens, atest_tsens2,
+                atest_usb1, atest_usb10, atest_usb11, atest_usb12, atest_usb13,
+                atest_usb2, atest_usb20, atest_usb21, atest_usb22, atest_usb23,
+                audio_ref, btfm_slimbus, cam_mclk, cci_async, cci_i2c,
+                cci_timer0, cci_timer1, cci_timer2, cci_timer3, cci_timer4,
+                cri_trng, cri_trng0, cri_trng1, dbg_out, ddr_bist, ddr_pxi0,
+                ddr_pxi1, ddr_pxi2, ddr_pxi3, edp_hot, edp_lcd, gcc_gp1,
+                gcc_gp2, gcc_gp3, gpio, jitter_bist, ldo_en, ldo_update,
+                lpass_slimbus, mdp_vsync, mdp_vsync0, mdp_vsync1, mdp_vsync2,
+                mdp_vsync3, mss_lte, m_voc, nav_pps, pa_indicator, pci_e0,
+                pci_e1, phase_flag, pll_bist, pll_bypassnl, pll_reset,
+                pri_mi2s, pri_mi2s_ws, prng_rosc, qdss, qdss_cti, qlink_enable,
+                qlink_request, qspi_clk, qspi_cs, qspi_data, qua_mi2s, qup0,
+                qup1, qup10, qup11, qup12, qup13, qup14, qup15, qup2, qup3,
+                qup4, qup5, qup6, qup7, qup8, qup9, qup_l4, qup_l5, qup_l6,
+                sdc4_clk, sdc4_cmd, sdc4_data, sd_write, sec_mi2s, sp_cmu,
+                spkr_i2s, ter_mi2s, tgu_ch0, tgu_ch1, tgu_ch2, tgu_ch3,
+                tsense_pwm1, tsense_pwm2, tsif1_clk, tsif1_data, tsif1_en,
+                tsif1_error, tsif1_sync, tsif2_clk, tsif2_data, tsif2_en,
+                tsif2_error, tsif2_sync, uim1_clk, uim1_data, uim1_present,
+                uim1_reset, uim2_clk, uim2_data, uim2_present, uim2_reset,
+                uim_batt, usb_phy, vfr_1, vsense_trigger, wlan1_adc0,
+                wlan1_adc1, wlan2_adc0, wlan2_adc1]
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
+    pinctrl@03000000 {
+        compatible = "qcom,qdu1000-pinctrl";
+        reg = <0x03000000 0xdc2000>;
+        interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+        gpio-controller;
+        #gpio-cells = <2>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+        gpio-ranges = <&tlmm 0 0 151>;
+        wakeup-parent = <&pdc_intc>;
+
+        cci0-default-state {
+            pins = "gpio17", "gpio18";
+            function = "cci_i2c";
+
+            bias-pull-up;
+            drive-strength = <2>;
+        };
+
+        cam0-default-state {
+            rst-pins {
+                pins = "gpio9";
+                function = "gpio";
+
+                drive-strength = <16>;
+                bias-disable;
+            };
+
+            mclk0-pins {
+                pins = "gpio13";
+                function = "cam_mclk";
+
+                drive-strength = <16>;
+                bias-disable;
+            };
+        };
+    };
-- 
2.38.0

