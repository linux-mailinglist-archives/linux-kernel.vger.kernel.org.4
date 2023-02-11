Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D00D6933CB
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 21:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjBKUt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 15:49:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBKUty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 15:49:54 -0500
Received: from mr85p00im-hyfv06021301.me.com (mr85p00im-hyfv06021301.me.com [17.58.23.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FFC17CE7
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 12:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1676148592; bh=ipWlGnh3MW1Vz3Ivsi+SHRp2lRJTeFpeE+MicgoNRTM=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=JfMlIIyTeDQ/f5BHzmcDDlfJzGbSwZhs/uB76fCH2v+DBSNb4R+D9dptTKcAGyKNO
         PA68sVIl/BE7XnypZ8J76uAcUtOfL2maHxE7QOJacelK/fIuoVVnW1c4QbLUuCes36
         5+1TEdh/OVniKZonFu0q0OdHCjoBR5zmqh1mJLUocWkQgelrkx3K3sAjjUh0SrUY5M
         btNLabDByExuZt3uZ2r/sQh/SL63PQLvHhBdq64YRXt/L5N+v4Kgvb9v4YYwKnUEAP
         XkygDCgP0CzG0He2ipZ5LPikoJUqqz3gtNntvOtlMUftGRSgllFzdnCm0afWi6znmi
         AKXMKmxRFaagw==
Received: from localhost (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
        by mr85p00im-hyfv06021301.me.com (Postfix) with ESMTPSA id BA7E221510B9;
        Sat, 11 Feb 2023 20:49:51 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Cc:     Alain Volmat <avolmat@me.com>, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: remoteproc: sti: convert st-rproc into dt-schema
Date:   Sat, 11 Feb 2023 21:47:50 +0100
Message-Id: <20230211204751.9149-1-avolmat@me.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: MDdap3thiMhZKujSL1PA1Ox-Q2HonM5A
X-Proofpoint-ORIG-GUID: MDdap3thiMhZKujSL1PA1Ox-Q2HonM5A
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.572,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2020-02-14=5F11:2020-02-14=5F02,2020-02-14=5F11,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0 clxscore=1011
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2302110195
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the st-rproc.txt binding into dt-schema YAML st,sti-rproc.yaml

Signed-off-by: Alain Volmat <avolmat@me.com>
---
 .../bindings/remoteproc/st,sti-rproc.yaml     | 101 ++++++++++++++++++
 .../bindings/remoteproc/st-rproc.txt          |  41 -------
 2 files changed, 101 insertions(+), 41 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/st,sti-rproc.yaml
 delete mode 100644 Documentation/devicetree/bindings/remoteproc/st-rproc.txt

diff --git a/Documentation/devicetree/bindings/remoteproc/st,sti-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/st,sti-rproc.yaml
new file mode 100644
index 000000000000..b9d84dfbcb58
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/st,sti-rproc.yaml
@@ -0,0 +1,101 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/remoteproc/st,sti-rproc.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: STMicroelectronics STi remote processor controller
+
+description:
+  This binding provides support for adjunct processors found on ST SoCs.
+
+  Co-processors can be controlled from the bootloader or the primary OS. If
+  the bootloader starts a co-processor, the primary OS must detect its state
+  and act accordingly.
+
+maintainers:
+  - Patrice Chotard <patrice.chotard@foss.st.com>
+
+properties:
+  compatible:
+    enum:
+      - st,st231-rproc
+      - st,st40-rproc
+
+  memory-region:
+    description:
+      List of phandles to the reserved memory regions associated with the
+      remoteproc device. This is variable and describes the memories shared with
+      the remote processor (e.g. remoteproc firmware and carveouts, rpmsg
+      vrings, ...).
+      (see ../reserved-memory/reserved-memory.txt)
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    maxItems: 1
+
+  st,syscfg:
+    description:
+      System configuration register which holds the boot vector for the co-processor
+    $ref: "/schemas/types.yaml#/definitions/phandle-array"
+    items:
+      - items:
+          - description: Phandle of syscon block
+          - description: Boot vector register offset
+
+  clocks:
+    maxItems: 1
+
+  clock-frequency:
+    description:
+      Frequency of the processing clock of the remote processor
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+
+  "#mbox-cells":
+    const: 1
+
+  mboxes:
+    maxItems: 4
+
+  mbox-names:
+    items:
+      - const: vq0_rx
+      - const: vq0_tx
+      - const: vq1_rx
+      - const: vq1_tx
+
+required:
+  - compatible
+  - memory-region
+  - resets
+  - reset-names
+  - st,syscfg
+  - clocks
+  - clock-frequency
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/stih407-clks.h>
+    #include <dt-bindings/reset/stih407-resets.h>
+    audio_reserved: rproc@42000000 {
+      compatible = "shared-dma-pool";
+        reg = <0x42000000 0x01000000>;
+        no-map;
+    };
+
+    st231-audio {
+      compatible = "st,st231-rproc";
+      memory-region = <&audio_reserved>;
+      resets = <&softreset STIH407_ST231_AUD_SOFTRESET>;
+      reset-names = "sw_reset";
+      clocks = <&clk_s_c0_flexgen CLK_ST231_AUD_0>;
+      clock-frequency = <600000000>;
+      st,syscfg	= <&syscfg_core 0x228>;
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/remoteproc/st-rproc.txt b/Documentation/devicetree/bindings/remoteproc/st-rproc.txt
deleted file mode 100644
index 1031bcd90a79..000000000000
--- a/Documentation/devicetree/bindings/remoteproc/st-rproc.txt
+++ /dev/null
@@ -1,41 +0,0 @@
-STMicroelectronics Co-Processor Bindings
-----------------------------------------
-
-This binding provides support for adjunct processors found on ST SoCs.
-
-Co-processors can be controlled from the bootloader or the primary OS. If
-the bootloader starts a co-processor, the primary OS must detect its state
-and act accordingly.
-
-Required properties:
-- compatible		Should be one of:
-				"st,st231-rproc"
-				"st,st40-rproc"
-- memory-region		Reserved memory (See: ../reserved-memory/reserved-memory.txt)
-- resets		Reset lines (See: ../reset/reset.txt)
-- reset-names		Must be "sw_reset" and "pwr_reset"
-- clocks		Clock for co-processor (See: ../clock/clock-bindings.txt)
-- clock-frequency	Clock frequency to set co-processor at if the bootloader
-			hasn't already done so
-- st,syscfg		System configuration register which holds the boot vector
-			for the co-processor
-				1st cell: Phandle to syscon block
-				2nd cell: Boot vector register offset
-
-Example:
-
-	audio_reserved: rproc@42000000 {
-		compatible = "shared-dma-pool";
-		reg = <0x42000000 0x01000000>;
-		no-map;
-	};
-
-	st231-audio {
-		compatible	= "st,st231-rproc";
-		memory-region	= <&audio_reserved>;
-		resets		= <&softreset STIH407_ST231_AUD_SOFTRESET>;
-		reset-names	= "sw_reset";
-		clocks		= <&clk_s_c0_flexgen CLK_ST231_AUD_0>;
-		clock-frequency	= <600000000>;
-		st,syscfg	= <&syscfg_core 0x228>;
-	};
-- 
2.34.1

