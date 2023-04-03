Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A586E6D5086
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 20:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbjDCScs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 14:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233233AbjDCScj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 14:32:39 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678172D7F;
        Mon,  3 Apr 2023 11:32:37 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id A07EA5FD35;
        Mon,  3 Apr 2023 21:32:35 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1680546755;
        bh=DHDyHk/Pj446xdaKqd95W4mapo90ZP6LvwdXXHadk4g=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=SmPZcTUEC/r/hmqWA/RXtzYGsxgvLoChyG8kQjKU/HL31+tReLvkPAA3TthzeVsVg
         VzSeT+GKap7p/CePDVf1ApNhDaCmgEgakY0botQZv35ZHiCziL4gEUSGZkRxuexRB3
         BKpBofnL7lsxwM2esYIpgMhIQ03rFS9fLEnuqlvERRfv2T8Ayonn9YxcGJe0l6zoQx
         SIWHE/kVIRbnn6Wy5djfW/xlc+O/BvdiNQBs++pTFoCsmhC9tvEpIurnHgftiOsDlC
         cXgZnNDSGyrKZTqqalFt3hKtrox+nKSJilVrXJqqKAUHeAD3GBa+7NMyeiR/OUalES
         5wAs3UbYTTGpQ==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Mon,  3 Apr 2023 21:32:35 +0300 (MSK)
From:   Martin Kurbanov <mmkurbanov@sberdevices.ru>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel@sberdevices.ru>,
        Martin Kurbanov <mmkurbanov@sberdevices.ru>
Subject: [PATCH v3 1/2] dt-bindings: spi: add Amlogic A1 SPI controller
Date:   Mon, 3 Apr 2023 21:32:16 +0300
Message-ID: <20230403183217.13280-2-mmkurbanov@sberdevices.ru>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230403183217.13280-1-mmkurbanov@sberdevices.ru>
References: <20230403183217.13280-1-mmkurbanov@sberdevices.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/04/03 14:17:00 #21028104
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add YAML devicetree Amlogic A1 (A113L SoC) SPIFC.

Signed-off-by: Martin Kurbanov <mmkurbanov@sberdevices.ru>
---
 .../bindings/spi/amlogic,a1-spifc.yaml        | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/amlogic,a1-spifc.yaml

diff --git a/Documentation/devicetree/bindings/spi/amlogic,a1-spifc.yaml b/Documentation/devicetree/bindings/spi/amlogic,a1-spifc.yaml
new file mode 100644
index 000000000000..ea47d30eef43
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/amlogic,a1-spifc.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/amlogic,a1-spifc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic A1 SPI Flash Controller
+
+maintainers:
+  - Martin Kurbanov <mmkurbanov@sberdevices.ru>
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - amlogic,a1-spifc
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
+    spi@fd000400 {
+        compatible = "amlogic,a1-spifc";
+        reg = <0xfd000400 0x290>;
+        clocks = <&clkc_clkid_spifc>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+    };
--
2.37.2

