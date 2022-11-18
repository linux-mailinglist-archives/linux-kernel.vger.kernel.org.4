Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA8A62EDFA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 07:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241304AbiKRGyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 01:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241264AbiKRGxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 01:53:11 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6137676140
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:53:09 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id l14so7862921wrw.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zi/aqN+5kkLqpduxJhM6ZAsivYXFZswxWDL4NZRZeIg=;
        b=AA46n0Ow0h7wfdZEweGRRl8/TcbAL6DWicY7Ck5e50YKFmmLgFwEuNIfrDBLiUNFL+
         d7KqoxNKe5ytArZq2rkxDfs2ev9RjRxGY6T4DJok3biQrCEgPaJ9OmAXN3JHGaRUoh3y
         nW8o1MXY8nOhYMssJtGRsywXPIIFcoH2nnkNVMgqLdObHsMX0TLTmRr+0sNMDJfhV+4y
         u+FhUwK44EmTa/tQqr/FpEU5yRysFxOwbF96z8h21xOeHMfDbTfHbNu6/JEhEUOEHvGI
         4sCVrK1/+w8uyvVqqIgsQyGDrPK0p9O6z6Bfd6ZDFvYHONmXeAtBg3zcWSQd0BG/HtsQ
         QEPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zi/aqN+5kkLqpduxJhM6ZAsivYXFZswxWDL4NZRZeIg=;
        b=fa6hW8VAM+KA1ABoYKRyDu9MTi1+GQhPBQKsvRaKdcQcK3SdJgT1Ld81hCwKfKP75K
         JCAUMrJNlJwH5Um+8wkfzsUu6RXEKQZCbzGBPNtc6chJ45cq+H8Ze0OrwcHZAb4pBylx
         kN/Qz9YjKZ+Ygx1u7hoAm656hkRrrKkK65Wkumuh9BzX5lOrittSMNmWQDArA2u+HP/f
         ALUrU0xNMbsg8uPEiTEP1G4vhokUTv3QLJ340WwlEhqJyCQZ3LBbS+hgDIvnZ0XXXrHU
         VZa+bjFRR2GW2b0w8ScfMY6g/7D03l3V0ZWXm6Ija9ACh9YE5gOct68Acyt8+KfPY+Hw
         UW1A==
X-Gm-Message-State: ANoB5pndCKCz9crLF05k0Z+WSC4k6J2xOpRnQll1/ll0Rs75EVasN5lH
        ssa46AbZ0i8QRjqvulT4LQXqkQ==
X-Google-Smtp-Source: AA0mqf6smkc/nedHUU5LaCQVXBvJEkZ+cpWryXOd0ozUKU5Tuau0n39oWvZ6JNQ1uBL7tBn3sQWXgg==
X-Received: by 2002:a05:6000:501:b0:22c:d27d:12e4 with SMTP id a1-20020a056000050100b0022cd27d12e4mr3291569wrf.546.1668754387761;
        Thu, 17 Nov 2022 22:53:07 -0800 (PST)
Received: from localhost.localdomain ([167.98.215.174])
        by smtp.gmail.com with ESMTPSA id 23-20020a05600c229700b003cf75213bb9sm7648100wmf.8.2022.11.17.22.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 22:53:07 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 10/12] dt-bindings: slimbus: convert bus description to DT schema
Date:   Fri, 18 Nov 2022 06:52:44 +0000
Message-Id: <20221118065246.6835-11-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221118065246.6835-1-srinivas.kandagatla@linaro.org>
References: <20221118065246.6835-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Convert the SLIMbus bus description bindings to DT Schema.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/slimbus/bus.txt       | 60 ------------
 .../bindings/slimbus/slim-ngd-qcom-ctrl.txt   |  2 -
 .../bindings/slimbus/slim-qcom-ctrl.txt       |  3 -
 .../devicetree/bindings/slimbus/slimbus.yaml  | 95 +++++++++++++++++++
 4 files changed, 95 insertions(+), 65 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/slimbus/bus.txt
 create mode 100644 Documentation/devicetree/bindings/slimbus/slimbus.yaml

diff --git a/Documentation/devicetree/bindings/slimbus/bus.txt b/Documentation/devicetree/bindings/slimbus/bus.txt
deleted file mode 100644
index bbe871f82a8b..000000000000
--- a/Documentation/devicetree/bindings/slimbus/bus.txt
+++ /dev/null
@@ -1,60 +0,0 @@
-SLIM(Serial Low Power Interchip Media Bus) bus
-
-SLIMbus is a 2-wire bus, and is used to communicate with peripheral
-components like audio-codec.
-
-Required property for SLIMbus controller node:
-- compatible	- name of SLIMbus controller
-
-Child nodes:
-Every SLIMbus controller node can contain zero or more child nodes
-representing slave devices on the bus. Every SLIMbus slave device is
-uniquely determined by the enumeration address containing 4 fields:
-Manufacturer ID, Product code, Device index, and Instance value for
-the device.
-If child node is not present and it is instantiated after device
-discovery (slave device reporting itself present).
-
-In some cases it may be necessary to describe non-probeable device
-details such as non-standard ways of powering up a device. In
-such cases, child nodes for those devices will be present as
-slaves of the SLIMbus controller, as detailed below.
-
-Required property for SLIMbus child node if it is present:
-- reg		- Should be ('Device index', 'Instance ID') from SLIMbus
-		  Enumeration  Address.
-		  Device Index Uniquely identifies multiple Devices within
-		  a single Component.
-		  Instance ID Is for the cases where multiple Devices of the
-		  same type or Class are attached to the bus.
-
-- compatible	-"slimMID,PID". The textual representation of Manufacturer ID,
-	 	  Product Code, shall be in lower case hexadecimal with leading
-		  zeroes suppressed
-
-Optional property for SLIMbus child node if it is present:
-- slim-ifc-dev	- Should be phandle to SLIMBus Interface device.
-		  Required for devices which deal with streams.
-
-SLIMbus example for Qualcomm's slimbus manager component:
-
-	slim@28080000 {
-		compatible = "qcom,apq8064-slim", "qcom,slim";
-		reg = <0x28080000 0x2000>,
-		interrupts = <0 33 0>;
-		clocks = <&lcc SLIMBUS_SRC>, <&lcc AUDIO_SLIMBUS_CLK>;
-		clock-names = "iface", "core";
-		#address-cells = <2>;
-		#size-cell = <0>;
-
-		codec_ifd: ifd@0,0{
-			compatible = "slim217,60";
-			reg = <0 0>;
-		};
-
-		codec: wcd9310@1,0{
-			compatible = "slim217,60";
-			reg = <1 0>;
-			slim-ifc-dev  = <&codec_ifd>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/slimbus/slim-ngd-qcom-ctrl.txt b/Documentation/devicetree/bindings/slimbus/slim-ngd-qcom-ctrl.txt
index e94a2ad3a710..7c3d9eb6af5d 100644
--- a/Documentation/devicetree/bindings/slimbus/slim-ngd-qcom-ctrl.txt
+++ b/Documentation/devicetree/bindings/slimbus/slim-ngd-qcom-ctrl.txt
@@ -5,8 +5,6 @@ with SLIMBus slaves directly over the bus using messaging interface and
 communicating with master component residing on ADSP for bandwidth and
 data-channel management
 
-Please refer to slimbus/bus.txt for details of the common SLIMBus bindings.
-
 - compatible:
 	Usage: required
 	Value type: <stringlist>
diff --git a/Documentation/devicetree/bindings/slimbus/slim-qcom-ctrl.txt b/Documentation/devicetree/bindings/slimbus/slim-qcom-ctrl.txt
index 922dcb8ff24a..6d955e129f90 100644
--- a/Documentation/devicetree/bindings/slimbus/slim-qcom-ctrl.txt
+++ b/Documentation/devicetree/bindings/slimbus/slim-qcom-ctrl.txt
@@ -4,9 +4,6 @@ master component.
 
 Required properties:
 
- - #address-cells - refer to Documentation/devicetree/bindings/slimbus/bus.txt
- - #size-cells	- refer to Documentation/devicetree/bindings/slimbus/bus.txt
-
  - reg : Offset and length of the register region(s) for the device
  - reg-names : Register region name(s) referenced in reg above
 	 Required register resource entries are:
diff --git a/Documentation/devicetree/bindings/slimbus/slimbus.yaml b/Documentation/devicetree/bindings/slimbus/slimbus.yaml
new file mode 100644
index 000000000000..22513fb7c59a
--- /dev/null
+++ b/Documentation/devicetree/bindings/slimbus/slimbus.yaml
@@ -0,0 +1,95 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/slimbus/slimbus.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SLIM (Serial Low Power Interchip Media) bus
+
+maintainers:
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+description:
+  SLIMbus is a 2-wire bus, and is used to communicate with peripheral
+  components like audio-codec.
+
+properties:
+  $nodename:
+    pattern: "^slim(@.*|-[0-9a-f])*$"
+
+  "#address-cells":
+    const: 2
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^.*@[0-9a-f]+,[0-9a-f]+$":
+    type: object
+    description: |
+      Every SLIMbus controller node can contain zero or more child nodes
+      representing slave devices on the bus. Every SLIMbus slave device is
+      uniquely determined by the enumeration address containing 4 fields::
+      Manufacturer ID, Product code, Device index, and Instance value for the
+      device.
+
+      If child node is not present and it is instantiated after device
+      discovery (slave device reporting itself present).
+
+      In some cases it may be necessary to describe non-probeable device
+      details such as non-standard ways of powering up a device. In such cases,
+      child nodes for those devices will be present as slaves of the SLIMbus
+      controller.
+
+    properties:
+      compatible:
+        pattern: "^slim[0-9a-f]+,[0-9a-f]+$"
+
+      reg:
+        maxItems: 1
+        description: |
+          Pair of (device index, instande ID), where::
+           - Device index, which uniquely identifies multiple devices within a
+             single component.
+           - Instance ID, can be used for the cases where multiple devices of
+             the same type or class are attached to the bus.
+
+    required:
+      - compatible
+      - reg
+
+    additionalProperties: true
+
+required:
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: true
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-msm8960.h>
+    #include <dt-bindings/clock/qcom,lcc-msm8960.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    soc {
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges;
+
+        slim@28080000 {
+            compatible = "qcom,apq8064-slim", "qcom,slim";
+            reg = <0x28080000 0x2000>, <0x80207c 4>;
+            reg-names = "ctrl", "slew";
+            interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&lcc SLIMBUS_SRC>, <&lcc AUDIO_SLIMBUS_CLK>;
+            clock-names = "iface", "core";
+            #address-cells = <2>;
+            #size-cells = <0>;
+
+            audio-codec@1,0 {
+                compatible = "slim217,60";
+                reg = <1 0>;
+            };
+        };
+    };
-- 
2.25.1

