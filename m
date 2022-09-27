Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3E25EC200
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 14:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbiI0MAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 08:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbiI0MA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 08:00:28 -0400
Received: from yawp.biot.com (yawp.biot.com [IPv6:2a01:4f8:10a:8e::fce2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96F4AFADF
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 05:00:27 -0700 (PDT)
Received: from debian-spamd by yawp.biot.com with sa-checked (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1od8pa-00CJmq-U4
        for linux-kernel@vger.kernel.org; Tue, 27 Sep 2022 13:32:55 +0200
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
Received: from [2a02:578:460c:1:ae1f:6bff:fed1:9ca8] (helo=sumner.biot.com)
        by yawp.biot.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1od8pF-00CJiv-3L; Tue, 27 Sep 2022 13:32:33 +0200
Received: from bert by sumner.biot.com with local (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1od8pE-0055tB-I4; Tue, 27 Sep 2022 13:32:32 +0200
From:   Bert Vermeulen <bert@biot.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bert Vermeulen <bert@biot.com>, John Crispin <john@phrozen.org>,
        Benjamin Larsson <benjamin.larsson@iopsys.eu>
Subject: [PATCH v2 1/3] dt-bindings: arm: airoha: Add documentation for Airoha SPI controller
Date:   Tue, 27 Sep 2022 13:32:27 +0200
Message-Id: <20220927113229.1214224-2-bert@biot.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220927113229.1214224-1-bert@biot.com>
References: <20220927113229.1214224-1-bert@biot.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create documentation for accessing the Airoha EN7523 SPI controller.

Signed-off-by: Bert Vermeulen <bert@biot.com>
---
 .../bindings/spi/airoha,en7523-spi.yaml       | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/airoha,en7523-spi.yaml

diff --git a/Documentation/devicetree/bindings/spi/airoha,en7523-spi.yaml b/Documentation/devicetree/bindings/spi/airoha,en7523-spi.yaml
new file mode 100644
index 000000000000..8f4936512a99
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/airoha,en7523-spi.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/airoha,en7523-spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Airoha EN7523 SPI controller
+
+maintainers:
+  - Bert Vermeulen <bert@biot.com>
+
+description: |
+  This binding describes the SPI controller on Airoha EN7523 SoCs.
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: airoha,en7523-spi
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/en7523-clk.h>
+    spi0: spi@1fa10000 {
+      compatible = "airoha,en7523-spi";
+      reg = <0x1fa10000 0x10000>;
+      clocks = <&scu EN7523_CLK_SPI>;
+      #address-cells = <1>;
+      #size-cells = <0>;
+    };
-- 
2.25.1

