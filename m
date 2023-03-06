Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779B06AC916
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 18:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbjCFRDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 12:03:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjCFRDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 12:03:12 -0500
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF545553C;
        Mon,  6 Mar 2023 09:02:33 -0800 (PST)
Received: from relay1-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::221])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 5B40ECBCDD;
        Mon,  6 Mar 2023 16:20:10 +0000 (UTC)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 67A6C240009;
        Mon,  6 Mar 2023 16:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678119489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5ZSZUb7GNlBfiAchjhGPnlmY1wyc58r4uqf5a2BVKcc=;
        b=WW0u8X/CwCxTy1Budp77BMxj8RY9TQRC6HFhAEHtEaK01/F/46ewNM9a+/1eSeow0vKHMH
        SP7Ri1/OXEStAzybIXos6AQWWV9/L8lib2izVJIsNz9xwR+gU1WM/qX0rGjHDLTC0ZqOkV
        R1zSoEL9TSZdqBPOdUOEfi2YFHrz7w+WCJvTwI0f0FcEY/46kXKGF8v32NuBCrK5HvB+CT
        yRrb5oEA1+RQIok3DHk48idjPStF48gtr3gBLMdrMY9k7KkOWIVUHS8oxOGpkU0PZTlex/
        3sQMydMigPFj6nmrN810mJi0ERCsdhf976rRdEWSjJUj8rDGbzDQSSTMfKjDPA==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Qiang Zhao <qiang.zhao@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v7 01/10] dt-bindings: soc: fsl: cpm_qe: Add TSA controller
Date:   Mon,  6 Mar 2023 17:17:45 +0100
Message-Id: <20230306161754.89146-2-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230306161754.89146-1-herve.codina@bootlin.com>
References: <20230306161754.89146-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the time slot assigner (TSA) available in some
PowerQUICC SoC such as MPC885 or MPC866.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 .../bindings/soc/fsl/cpm_qe/fsl,cpm1-tsa.yaml | 205 ++++++++++++++++++
 include/dt-bindings/soc/cpm1-fsl,tsa.h        |  13 ++
 2 files changed, 218 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-tsa.yaml
 create mode 100644 include/dt-bindings/soc/cpm1-fsl,tsa.h

diff --git a/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-tsa.yaml b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-tsa.yaml
new file mode 100644
index 000000000000..7e51c639a79a
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-tsa.yaml
@@ -0,0 +1,205 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/fsl/cpm_qe/fsl,cpm1-tsa.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: PowerQUICC CPM Time-slot assigner (TSA) controller
+
+maintainers:
+  - Herve Codina <herve.codina@bootlin.com>
+
+description:
+  The TSA is the time-slot assigner that can be found on some PowerQUICC SoC.
+  Its purpose is to route some TDM time-slots to other internal serial
+  controllers.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - fsl,mpc885-tsa
+          - fsl,mpc866-tsa
+      - const: fsl,cpm1-tsa
+
+  reg:
+    items:
+      - description: SI (Serial Interface) register base
+      - description: SI RAM base
+
+  reg-names:
+    items:
+      - const: si_regs
+      - const: si_ram
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+patternProperties:
+  '^tdm@[0-1]$':
+    description:
+      The TDM managed by this controller
+    type: object
+
+    additionalProperties: false
+
+    properties:
+      reg:
+        minimum: 0
+        maximum: 1
+        description:
+          The TDM number for this TDM, 0 for TDMa and 1 for TDMb
+
+      fsl,common-rxtx-pins:
+        $ref: /schemas/types.yaml#/definitions/flag
+        description:
+          The hardware can use four dedicated pins for Tx clock, Tx sync, Rx
+          clock and Rx sync or use only two pins, Tx/Rx clock and Tx/Rx sync.
+          Without the 'fsl,common-rxtx-pins' property, the four pins are used.
+          With the 'fsl,common-rxtx-pins' property, two pins are used.
+
+      clocks:
+        minItems: 2
+        items:
+          - description: External clock connected to L1RSYNC pin
+          - description: External clock connected to L1RCLK pin
+          - description: External clock connected to L1TSYNC pin
+          - description: External clock connected to L1TCLK pin
+
+      clock-names:
+        minItems: 2
+        items:
+          - const: l1rsync
+          - const: l1rclk
+          - const: l1tsync
+          - const: l1tclk
+
+      fsl,rx-frame-sync-delay-bits:
+        enum: [0, 1, 2, 3]
+        default: 0
+        description: |
+          Receive frame sync delay in number of bits.
+          Indicates the delay between the Rx sync and the first bit of the Rx
+          frame. 0 for no bit delay. 1, 2 or 3 for 1, 2 or 3 bits delay.
+
+      fsl,tx-frame-sync-delay-bits:
+        enum: [0, 1, 2, 3]
+        default: 0
+        description: |
+          Transmit frame sync delay in number of bits.
+          Indicates the delay between the Tx sync and the first bit of the Tx
+          frame. 0 for no bit delay. 1, 2 or 3 for 1, 2 or 3 bits delay.
+
+      fsl,clock-falling-edge:
+        $ref: /schemas/types.yaml#/definitions/flag
+        description:
+          Data is sent on falling edge of the clock (and received on the rising
+          edge). If 'clock-falling-edge' is not present, data is sent on the
+          rising edge (and received on the falling edge).
+
+      fsl,fsync-rising-edge:
+        $ref: /schemas/types.yaml#/definitions/flag
+        description:
+          Frame sync pulses are sampled with the rising edge of the channel
+          clock. If 'fsync-rising-edge' is not present, pulses are sampled with
+          the falling edge.
+
+      fsl,double-speed-clock:
+        $ref: /schemas/types.yaml#/definitions/flag
+        description:
+          The channel clock is twice the data rate.
+
+    patternProperties:
+      '^fsl,[rt]x-ts-routes$':
+        $ref: /schemas/types.yaml#/definitions/uint32-matrix
+        description: |
+          A list of tuple that indicates the Tx or Rx time-slots routes.
+        items:
+          items:
+            - description:
+                The number of time-slots
+              minimum: 1
+              maximum: 64
+            - description: |
+                The source (Tx) or destination (Rx) serial interface
+                (dt-bindings/soc/cpm1-fsl,tsa.h defines these values)
+                 - 0: No destination
+                 - 1: SCC2
+                 - 2: SCC3
+                 - 3: SCC4
+                 - 4: SMC1
+                 - 5: SMC2
+              enum: [0, 1, 2, 3, 4, 5]
+        minItems: 1
+        maxItems: 64
+
+    allOf:
+      # If fsl,common-rxtx-pins is present, only 2 clocks are needed.
+      # Else, the 4 clocks must be present.
+      - if:
+          required:
+            - fsl,common-rxtx-pins
+        then:
+          properties:
+            clocks:
+              maxItems: 2
+            clock-names:
+              maxItems: 2
+        else:
+          properties:
+            clocks:
+              minItems: 4
+            clock-names:
+              minItems: 4
+
+    required:
+      - reg
+      - clocks
+      - clock-names
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - '#address-cells'
+  - '#size-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/soc/cpm1-fsl,tsa.h>
+
+    tsa@ae0 {
+        compatible = "fsl,mpc885-tsa", "fsl,cpm1-tsa";
+        reg = <0xae0 0x10>,
+              <0xc00 0x200>;
+        reg-names = "si_regs", "si_ram";
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        tdm@0 {
+            /* TDMa */
+            reg = <0>;
+
+            clocks = <&clk_l1rsynca>, <&clk_l1rclka>;
+            clock-names = "l1rsync", "l1rclk";
+
+            fsl,common-rxtx-pins;
+            fsl,fsync-rising-edge;
+
+            fsl,tx-ts-routes = <2 0>,             /* TS 0..1 */
+                           <24 FSL_CPM_TSA_SCC4>, /* TS 2..25 */
+                           <1 0>,                 /* TS 26 */
+                           <5 FSL_CPM_TSA_SCC3>;  /* TS 27..31 */
+
+            fsl,rx-ts-routes = <2 0>,             /* TS 0..1 */
+                           <24 FSL_CPM_TSA_SCC4>, /* 2..25 */
+                           <1 0>,                 /* TS 26 */
+                           <5 FSL_CPM_TSA_SCC3>;  /* TS 27..31 */
+        };
+    };
diff --git a/include/dt-bindings/soc/cpm1-fsl,tsa.h b/include/dt-bindings/soc/cpm1-fsl,tsa.h
new file mode 100644
index 000000000000..2cc44e867dbe
--- /dev/null
+++ b/include/dt-bindings/soc/cpm1-fsl,tsa.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+
+#ifndef __DT_BINDINGS_SOC_FSL_TSA_H
+#define __DT_BINDINGS_SOC_FSL_TSA_H
+
+#define FSL_CPM_TSA_NU		0	/* Pseuso Cell Id for not used item */
+#define FSL_CPM_TSA_SCC2	1
+#define FSL_CPM_TSA_SCC3	2
+#define FSL_CPM_TSA_SCC4	3
+#define FSL_CPM_TSA_SMC1	4
+#define FSL_CPM_TSA_SMC2	5
+
+#endif
-- 
2.39.2

