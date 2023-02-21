Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3AA969E45D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 17:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234437AbjBUQRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 11:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234271AbjBUQRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 11:17:16 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B7A2C66A
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 08:17:11 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id h16so19516114edz.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 08:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oUsSFf+8W788BHVLSjZQlyYufSpAGNHgM/qoly2HN38=;
        b=f3K9AFBQPqvqHmcWC4asopLazx00fE6HDs7dk9hl/fwrLUG5EE6WzGxzELNFpV1tgT
         Smc4kuJqFCcV/9dOX+H6+7ErJUid79PFmfp82f+zgetQHRVgZ58SJAb+fvSKjvOel0Ru
         r+13TcHXHMVVnyliXqq7iVPgRG5lh0NOUf4bx0Ujsg6x7WwSlEvQ95pWMibG/Y6XEwjx
         GGtwZXpc79kfOF3mMKRy5mesv1S+7Ni1SrZHLP9hlcnWIvwDxHWiieOkrdEiZN8LOwfq
         KfZopNNzg8yymVdRetqF+1uCZj5evdS0fI1TLCOmA4DkzUc+qgt4QbNXf61VyRD7AFGV
         Ldsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oUsSFf+8W788BHVLSjZQlyYufSpAGNHgM/qoly2HN38=;
        b=qLmloUzUpG8GrEvfXpzcSnW2IiYBA+6HrD68qOon2J+r1hBmc5DzsDvIGjFhZIXYsh
         aA2d/+Bo2j5dqXSG3v6Y2KkX0jIMavm0Gpc/Og9xmtnNQxyDaDgdq65px+XVIjvcCyhK
         e2exlngD1wjObYXH34ZLpfogKHzuVXqqEf2FV3gRUH19qRXGmmU0aGSflztH48rfjbYi
         GHSzxqJNEhAZMTl9/RTJVGZyR2zS1fN2X+mlFZJiuJ+UT548RGb2WTcaH+ZAZi0Vk8TZ
         uBXI4SJlr6tM2Y41HtEjSijTI6a1o2R7nCqDtHEKV1Y/UIbbIyYa5CFHSM4dRceqlfj1
         ufvw==
X-Gm-Message-State: AO0yUKVVdpC56fgoaLIF5y/jhIBpu8KzgfK0YO8Y/fwUvcIUcuovT7KL
        lbcLFjPtq/av8avguYfIydIoHw==
X-Google-Smtp-Source: AK7set+beYuq0Q1tCpnZkYHGSnCiJOVatL4InDipprorqkYEsxyiEh/SZ+aaqS4hVMmwCpyXk+tPaA==
X-Received: by 2002:a50:ed0e:0:b0:4ac:bab1:feee with SMTP id j14-20020a50ed0e000000b004acbab1feeemr6195879eds.24.1676996229352;
        Tue, 21 Feb 2023 08:17:09 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id u13-20020aa7d88d000000b004ab4c28a967sm2112142edq.44.2023.02.21.08.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 08:17:09 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: input: cypress,cyapa: convert to dtschema
Date:   Tue, 21 Feb 2023 17:17:06 +0100
Message-Id: <20230221161706.56639-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Cypress All Points Addressable (APA) I2C Touchpad / Trackpad
bindings to DT schema.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/input/cypress,cyapa.txt          | 42 ----------------
 .../bindings/input/cypress,cyapa.yaml         | 49 +++++++++++++++++++
 2 files changed, 49 insertions(+), 42 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/cypress,cyapa.txt
 create mode 100644 Documentation/devicetree/bindings/input/cypress,cyapa.yaml

diff --git a/Documentation/devicetree/bindings/input/cypress,cyapa.txt b/Documentation/devicetree/bindings/input/cypress,cyapa.txt
deleted file mode 100644
index d3db65916a36..000000000000
--- a/Documentation/devicetree/bindings/input/cypress,cyapa.txt
+++ /dev/null
@@ -1,42 +0,0 @@
-Cypress I2C Touchpad
-
-Required properties:
-- compatible: must be "cypress,cyapa".
-- reg: I2C address of the chip.
-- interrupts: interrupt to which the chip is connected (see interrupt
-	binding[0]).
-
-Optional properties:
-- wakeup-source: touchpad can be used as a wakeup source.
-- pinctrl-names: should be "default" (see pinctrl binding [1]).
-- pinctrl-0: a phandle pointing to the pin settings for the device (see
-	pinctrl binding [1]).
-- vcc-supply: a phandle for the regulator supplying 3.3V power.
-
-[0]: Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
-[1]: Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
-
-Example:
-	&i2c0 {
-		/* ... */
-
-		/* Cypress Gen3 touchpad */
-		touchpad@67 {
-			compatible = "cypress,cyapa";
-			reg = <0x67>;
-			interrupt-parent = <&gpio>;
-			interrupts = <2 IRQ_TYPE_EDGE_FALLING>;	/* GPIO 2 */
-			wakeup-source;
-		};
-
-		/* Cypress Gen5 and later touchpad */
-		touchpad@24 {
-			compatible = "cypress,cyapa";
-			reg = <0x24>;
-			interrupt-parent = <&gpio>;
-			interrupts = <2 IRQ_TYPE_EDGE_FALLING>;	/* GPIO 2 */
-			wakeup-source;
-		};
-
-		/* ... */
-	};
diff --git a/Documentation/devicetree/bindings/input/cypress,cyapa.yaml b/Documentation/devicetree/bindings/input/cypress,cyapa.yaml
new file mode 100644
index 000000000000..29515151abe9
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/cypress,cyapa.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/cypress,cyapa.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cypress All Points Addressable (APA) I2C Touchpad / Trackpad
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+
+properties:
+  compatible:
+    const: cypress,cyapa
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  wakeup-source: true
+
+  vcc-supply:
+    description: 3.3V power
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        trackpad@67 {
+            reg = <0x67>;
+            compatible = "cypress,cyapa";
+            interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
+            interrupt-parent = <&gpx1>;
+            wakeup-source;
+        };
+    };
-- 
2.34.1

