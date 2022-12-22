Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0239C6542FD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 15:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235635AbiLVO3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 09:29:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235504AbiLVO25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 09:28:57 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A759101CB;
        Thu, 22 Dec 2022 06:28:56 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id t17so5340510eju.1;
        Thu, 22 Dec 2022 06:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IiR9nJxZj0ahc9gYg7Q4kSlDraiLVtIVMlRjW0NAGg4=;
        b=kVO3wEjlUNasPOkQM+Z8XVHJ1D4eroDcNYLwjW2XFT1X4tvZMLhYsMzwjZLJn31O39
         yjmuS0HuXq1lSB/v+qiLEd/JfdlhFFF8ZoQZQOBhosIrGG7z23XCxzQvXdMMDv4liNZw
         CXZVDY5Fjvl3VTQ47YozPl/DmcpQBwyFeaKUtTFc7iNlEb2i2fR1IqIi04TSpIC2ixLn
         ThK0qRxwTTZQS2Vn/11sFIAtVgqcN1YwPPxG6L1IP1MG7340wDX88+f7bnFFdDiViIBQ
         1PSn4OcmRKU4pr4HNe2SPzP1VeNxXmPRiRltzh1VP1EPFGrGxrpjeAXekFVl0dvLvzKG
         vTxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IiR9nJxZj0ahc9gYg7Q4kSlDraiLVtIVMlRjW0NAGg4=;
        b=KFxx6KpXEiqyBLrT8HbYXDkCoB9mcs7fX63HNWgMqiJPlZN5v8UbGRxzFWj6EJf+FZ
         6FG7hcnv0ayup0a9Q3B5vodGYajDMAEUr95Fr8pPpOoSE6vF9z6ajMWXEaGJ23FFgz++
         f4bjKnjakkgfqa7aVdHvN5GCQpWkI8O40ZFjTm0P1wKMibGiBBhOwXweKz6/2oUQCkAV
         QKuvZUysPT6Fn5qlDWnKl8LdGt3rZC4/HzufIuzp+uY6EGW8qWfsGvXhzU8Wf4ifgc7q
         KZoHloGbVEyrz1ZK8fChlqveV54f3p5m4UEjGqz4nAoR+X5IzGHCLKs0If+fFyBeceDi
         ZCMA==
X-Gm-Message-State: AFqh2krucK3Vn1n8e2NCr/YE+EKQWJjuNyZNDRDF9UJ5DLNi36OKuVlX
        zpZnve9xTJKZACv6MIJ1gpc=
X-Google-Smtp-Source: AMrXdXve0iWMaQ1w3rvzZqthvoHgo3T68e7FSilnYAFSXme6eZvnTnnigr0DKcN5f6y2xvY0Z41wqA==
X-Received: by 2002:a17:906:5956:b0:81b:f617:eb99 with SMTP id g22-20020a170906595600b0081bf617eb99mr4531596ejr.67.1671719334856;
        Thu, 22 Dec 2022 06:28:54 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id vf20-20020a170907239400b0081586470b7csm298343ejb.173.2022.12.22.06.28.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 06:28:54 -0800 (PST)
Message-ID: <0336a3c4-4a43-c983-11d7-e2ae16187fc8@gmail.com>
Date:   Thu, 22 Dec 2022 15:28:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v6 08/17] dt-bindings: usb: convert fcs,fusb302.txt to yaml
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        airlied@gmail.com, daniel@ffwll.ch, andrzej.hajda@intel.com,
        neil.armstrong@linaro.org, robert.foss@linaro.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, philippe.cornu@foss.st.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-usb@vger.kernel.org,
        linus.walleij@linaro.org, inki.dae@samsung.com,
        sw0312.kim@samsung.com, kyungmin.park@samsung.com,
        alim.akhtar@samsung.com, linux-samsung-soc@vger.kernel.org
References: <67771143-fd83-383d-41b2-68e8707134e8@gmail.com>
Content-Language: en-US
In-Reply-To: <67771143-fd83-383d-41b2-68e8707134e8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert fcs,fusb302.txt to yaml.

Changed:
  Add vbus-supply property

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

Changed V6:
  Add unevaluatedProperties
  Drop unused labels
---
 .../devicetree/bindings/usb/fcs,fusb302.txt   | 34 ----------
 .../devicetree/bindings/usb/fcs,fusb302.yaml  | 67 +++++++++++++++++++
 2 files changed, 67 insertions(+), 34 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/usb/fcs,fusb302.txt
 create mode 100644 Documentation/devicetree/bindings/usb/fcs,fusb302.yaml

diff --git a/Documentation/devicetree/bindings/usb/fcs,fusb302.txt b/Documentation/devicetree/bindings/usb/fcs,fusb302.txt
deleted file mode 100644
index 60e465429..000000000
--- a/Documentation/devicetree/bindings/usb/fcs,fusb302.txt
+++ /dev/null
@@ -1,34 +0,0 @@
-Fairchild FUSB302 Type-C Port controllers
-
-Required properties :
-- compatible             : "fcs,fusb302"
-- reg                    : I2C slave address
-- interrupts             : Interrupt specifier
-
-Required sub-node:
-- connector : The "usb-c-connector" attached to the FUSB302 IC. The bindings
-  of the connector node are specified in:
-
-	Documentation/devicetree/bindings/connector/usb-connector.yaml
-
-
-Example:
-
-fusb302: typec-portc@54 {
-	compatible = "fcs,fusb302";
-	reg = <0x54>;
-	interrupt-parent = <&nmi_intc>;
-	interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
-
-	usb_con: connector {
-		compatible = "usb-c-connector";
-		label = "USB-C";
-		power-role = "dual";
-		try-power-role = "sink";
-		source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
-		sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
-			     PDO_VAR(3000, 12000, 3000)
-			     PDO_PPS_APDO(3000, 11000, 3000)>;
-		op-sink-microwatt = <10000000>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/usb/fcs,fusb302.yaml b/Documentation/devicetree/bindings/usb/fcs,fusb302.yaml
new file mode 100644
index 000000000..b396ea0ab
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/fcs,fusb302.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/fcs,fusb302.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Fairchild FUSB302 Type-C Port controller
+
+maintainers:
+  - Rob Herring <robh@kernel.org>
+
+properties:
+  compatible:
+    const: fcs,fusb302
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  vbus-supply:
+    description: VBUS power supply
+
+  connector:
+    type: object
+    $ref: /schemas/connector/usb-connector.yaml#
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - vbus-supply
+  - connector
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/usb/pd.h>
+
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      typec-portc@54 {
+        compatible = "fcs,fusb302";
+        reg = <0x54>;
+        interrupt-parent = <&nmi_intc>;
+        interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+        vbus-supply = <&vbus_typec>;
+
+        connector {
+          compatible = "usb-c-connector";
+          label = "USB-C";
+          power-role = "dual";
+          try-power-role = "sink";
+          source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
+          sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
+                       PDO_VAR(3000, 12000, 3000)
+                       PDO_PPS_APDO(3000, 11000, 3000)>;
+          op-sink-microwatt = <10000000>;
+        };
+      };
+    };
--
2.20.1

