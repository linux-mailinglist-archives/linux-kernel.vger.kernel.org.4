Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775C16FCAC8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 18:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235781AbjEIQJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 12:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235729AbjEIQJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 12:09:17 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C4D2120;
        Tue,  9 May 2023 09:09:15 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 9152EFF80F;
        Tue,  9 May 2023 16:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1683648554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9kMsDQBfor4spt7iEDtWMeNz0VMgYY5+MkzcLfMNcc0=;
        b=Qlps/wnxI542IxIOJuq0zxgs4sl/Z8DeS7UeaYSSVpCco6nB3QENDvwAbexhpjCb4eCLNn
        0Y7ZBycY+Hv7W4CMY4J/BhLIH4q22AQXbYU2YmeVYOt8v7pBi1qCFSk1p8C/7LVocWkrqZ
        97H/tl/gDNNJnoIMKg7ijeM4nZ0db79pA/XSbMtbCO+ACY94IBov0FWJBliXj31HFmZqHf
        WKWZ/8rdBtYrQ8PYzXSnwaq62EGHvff7ZgoOrB3SXV6zkRQjK4VDT30SJ/h796jpAlMOwU
        z0WcU2MUmd7POgx6uKlOl+dYZOMA11SKZ0RpCJMH95RNAFffEqfFKSWBySsO5g==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v4 1/3] dt-bindings: iio: potentiometer: Add the Renesas X9250 potentiometers
Date:   Tue,  9 May 2023 18:08:50 +0200
Message-Id: <20230509160852.158101-2-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509160852.158101-1-herve.codina@bootlin.com>
References: <20230509160852.158101-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Renesas X9250 is a quad digitally controlled potentiometers.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 .../iio/potentiometer/renesas,x9250.yaml      | 78 +++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/potentiometer/renesas,x9250.yaml

diff --git a/Documentation/devicetree/bindings/iio/potentiometer/renesas,x9250.yaml b/Documentation/devicetree/bindings/iio/potentiometer/renesas,x9250.yaml
new file mode 100644
index 000000000000..ab5c09c00ff4
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/potentiometer/renesas,x9250.yaml
@@ -0,0 +1,78 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/potentiometer/renesas,x9250.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas X9250 quad potentiometers
+
+maintainers:
+  - Herve Codina <herve.codina@bootlin.com>
+
+description:
+  The Renesas X9250 integrates four digitally controlled potentiometers.
+  On each potentiometer, the X9250T has a 100 kOhms total resistance and the
+  X9250U has a 50 kOhms total resistance.
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml
+
+properties:
+  compatible:
+    enum:
+      - renesas,x9250t
+      - renesas,x9250u
+
+  reg:
+    maxItems: 1
+
+  vcc-supply:
+    description:
+      Regulator for the VCC power supply.
+
+  avp-supply:
+    description:
+      Regulator for the analog V+ power supply.
+
+  avn-supply:
+    description:
+      Regulator for the analog V- power supply.
+
+  '#io-channel-cells':
+    const: 1
+
+  spi-max-frequency:
+    maximum: 2000000
+
+  wp-gpios:
+    maxItems: 1
+    description:
+      GPIO connected to the write-protect pin.
+
+required:
+  - compatible
+  - reg
+  - vcc-supply
+  - avp-supply
+  - avn-supply
+  - '#io-channel-cells'
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        potentiometer@0 {
+            compatible = "renesas,x9250t";
+            reg = <0>;
+            vcc-supply = <&vcc_regulator>;
+            avp-supply = <&avp_regulator>;
+            avn-supply = <&avp_regulator>;
+            wp-gpios = <&gpio 1 GPIO_ACTIVE_LOW>;
+            spi-max-frequency = <2000000>;
+            #io-channel-cells = <1>;
+        };
+    };
-- 
2.40.1

