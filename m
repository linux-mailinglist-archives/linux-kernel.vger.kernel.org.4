Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9F76EA64E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 10:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbjDUIxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 04:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbjDUIw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 04:52:57 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE3F93E4;
        Fri, 21 Apr 2023 01:52:53 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 44F2A1BF209;
        Fri, 21 Apr 2023 08:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1682067172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uf38X61eh5A/xDBb52sQbA/hpuTv3mViEcnHyYk1qZU=;
        b=LDceoR3O7N+PXaD/tpqHc1XUJNqVA5lYU8ayDZ/6tKom/Yw5CEpowPhTzg6wu9CKXgHVpw
        NcL5f3cmPVALpHSvgUVVvVYn4Tz9tAZG1POtN9NkPWjUXaqGZ1K5+eLQ4Ej9CBL9+SbJS8
        RLs6EFpsvHzgkwZ+ltUXBaS0cdV4oCTUY7oAHz4zTvJ6nlmpf5d/tZG4z4J506ePoaFynY
        n6ZctmpFm423ZIq+AkIzD6VyorBNy59gjpXe7nTYM0P1yxrD8nfpmrB9cjLTWuhYNW4Ust
        pnE/HCfH0nWxOj9rc8zQY/NGwdPUn9qHVwiizj9aiR8sZ9aw1CEL7mRXZWO0Vw==
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
Subject: [PATCH v3 1/3] dt-bindings: iio: potentiometer: Add the Renesas X9250 potentiometers
Date:   Fri, 21 Apr 2023 10:52:43 +0200
Message-Id: <20230421085245.302169-2-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230421085245.302169-1-herve.codina@bootlin.com>
References: <20230421085245.302169-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Renesas X9250 is a quad digitally controlled potentiometers.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 .../iio/potentiometer/renesas,x9250.yaml      | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/potentiometer/renesas,x9250.yaml

diff --git a/Documentation/devicetree/bindings/iio/potentiometer/renesas,x9250.yaml b/Documentation/devicetree/bindings/iio/potentiometer/renesas,x9250.yaml
new file mode 100644
index 000000000000..dfa36b23eb0d
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/potentiometer/renesas,x9250.yaml
@@ -0,0 +1,54 @@
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
+  - $ref: /schemas/iio/iio.yaml
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
+  '#io-channel-cells':
+    const: 1
+
+  spi-max-frequency:
+    maximum: 2000000
+
+required:
+  - compatible
+  - reg
+  - '#io-channel-cells'
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        potentiometer@0 {
+            compatible = "renesas,x9250t";
+            reg = <0>;
+            spi-max-frequency = <2000000>;
+            #io-channel-cells = <1>;
+        };
+    };
-- 
2.39.2

