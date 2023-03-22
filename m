Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769486C4EEE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 16:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjCVPGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 11:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjCVPGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 11:06:06 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9D8637D3;
        Wed, 22 Mar 2023 08:06:05 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id BA4355FD42;
        Wed, 22 Mar 2023 18:06:03 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1679497563;
        bh=L/cZhXKdgtCamQglShAZ97PbA1w3JdiautYGqxltivc=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=kO4DuoLRQa2nQjI/QpH5Rmx3n4zAO8rfTC2pfj2Ykor5jwZlV8hUgal1C0AwQbghG
         jUtLRIEF2iN9SYny7Ifsr71hC0wTUrhhAXYsJZEQGo3igrbM5KjLIDnmFQvP2LtpyE
         xlbgg2Mq9EjtFV/kQClAKCc/FsB/Tq+Ow7AQzZ4oxb+dRMOzRl5iSP0VHeCK9kpiG9
         nEPiA3b3lgGTUAPhglsNGQf/n9Bwk9almp518koq81yS4P+3P78Tp3UtakCebiHZ42
         Lai/0Uzcmn79OW/YeRf6+78YmmGFTPsxCyixsALvEenyB5wQmRNQ1Enm0kYa5CoDrh
         Y1vUB2o66TNPA==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Wed, 22 Mar 2023 18:06:03 +0300 (MSK)
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
Subject: [PATCH v1 1/2] dt-bindings: spi: add binding for meson-spifc-a1
Date:   Wed, 22 Mar 2023 18:04:57 +0300
Message-ID: <20230322150458.783901-2-mmkurbanov@sberdevices.ru>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230322150458.783901-1-mmkurbanov@sberdevices.ru>
References: <20230322150458.783901-1-mmkurbanov@sberdevices.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/03/22 10:34:00 #20990985
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add YAML devicetree binding for Amlogic Meson A113L (A1 family)
SPIFC Driver.

Signed-off-by: Martin Kurbanov <mmkurbanov@sberdevices.ru>
---
 .../bindings/spi/amlogic,meson-a1-spifc.yaml  | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/amlogic,meson-a1-spifc.yaml

diff --git a/Documentation/devicetree/bindings/spi/amlogic,meson-a1-spifc.yaml b/Documentation/devicetree/bindings/spi/amlogic,meson-a1-spifc.yaml
new file mode 100644
index 000000000000..5f84063b01f8
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/amlogic,meson-a1-spifc.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/amlogic,meson-a1-spifc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic Meson A113L SPI Flash Controller
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
+      - amlogic,meson-a1-spifc
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
+    #include <dt-bindings/clock/amlogic,a1-clkc.h>
+    spi@fd000400 {
+          compatible = "amlogic,meson-a1-spifc";
+          reg = <0xfd000400 0x290>;
+          clocks = <&clkc_periphs CLKID_SPIFC>;
+          #address-cells = <1>;
+          #size-cells = <0>;
+    };
-- 
2.40.0

