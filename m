Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0AE26082B3
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 02:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiJVAII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 20:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbiJVAHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 20:07:13 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7661373A3;
        Fri, 21 Oct 2022 17:06:40 -0700 (PDT)
Received: from localhost (89-26-75-29.goll.dyn.salzburg-online.at [89.26.75.29])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 980676602820;
        Sat, 22 Oct 2022 01:05:27 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666397127;
        bh=M9jhghRNgf0eus9ZzOBzaxf6Pqwe1OVS+Ho5srdastA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X9w+pQ/YY7L/iS/K28OzhGpRsb8OImmS13/KCuAUu8T7SL4O2SkBrHWZo8o1E/DFC
         l9ZXfZf0iTtf60eisn9+We5thfCadTVfa86/7Aams/lPmayG0qoA71JOC9kUo/8SAi
         Rjd1ORD46LeGXqQRPrz+tVN3N/YMq/jaZHEMfp2o5aeM8YIlDj9WBAld8dRiRMk+vo
         RHbWutFVBOzoCN36YGLPxrEW1r13oe4gDxAbSlq+PnhvC23e6PR6Rk7iA6n3B0YSyo
         +6fWQYKcCUeeG1rL09RFd4oj7Jy/A2+UziU09ketkHf9fz11OZxDkTfOdbn/vdP2PQ
         lbRg49d8A+K0w==
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
To:     linux-media@vger.kernel.org
Cc:     kernel@collabora.com, nas.chung@chipsnmedia.com,
        hverkuil@xs4all.nl, ezequiel@vanguardiasur.com.ar,
        linux-kernel@vger.kernel.org, nicolas.dufresne@collabora.com,
        p.zabel@pengutronix.de, dafna@fastmail.com
Subject: [PATCH v10 6/7] dt-bindings: media: wave5: add yaml devicetree bindings
Date:   Sat, 22 Oct 2022 02:05:05 +0200
Message-Id: <20221022000506.221933-7-sebastian.fricke@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221022000506.221933-1-sebastian.fricke@collabora.com>
References: <20221022000506.221933-1-sebastian.fricke@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert Beckett <bob.beckett@collabora.com>

Add bindings for the wave5 chips&media codec driver

Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
---
 .../devicetree/bindings/media/wave5.yml       | 73 +++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/wave5.yml

diff --git a/Documentation/devicetree/bindings/media/wave5.yml b/Documentation/devicetree/bindings/media/wave5.yml
new file mode 100644
index 000000000000..85dc3c744876
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/wave5.yml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/wave5.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Chips&Media Wave 5 Series multi-standard codec IP
+
+maintainers:
+  - Nas Chung <nas.chung@chipsnmedia.com>
+  - Robert Beckett <bob.beckett@collabora.com>
+  - Sebastian Fricke <sebastian.fricke@collabora.com>
+
+description: |-
+  The Chips&Media WAVE codec IP is a multi format video encoder/decoder
+
+properties:
+  compatible:
+    anyOf:
+      - items:
+        - enum:
+            - cnm,cm511-vpu
+            - cnm,cm517-vpu
+            - cnm,cm521-vpu
+            - cnm,cm521c-vpu
+            - cnm,cm521c-dual-vpu
+            - cnm,cm521e1-vpu
+            - cnm,cm537-vpu
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 4
+
+  clock-names:
+    minItems: 1
+    maxItems: 4
+
+  interrupts:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  sram:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: phandle pointing to the SRAM device node
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    vpu: video-codec@12345678 {
+        compatible = "cnm,cm521-vpu";
+        reg = <0x12345678 0x1000>;
+        interrupts = <42>;
+        clocks = <&clks 42>;
+        clock-names = "vcodec";
+        sram = <&sram>;
+    };
+
-- 
2.25.1

