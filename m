Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1174B653625
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 19:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234622AbiLUSX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 13:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234774AbiLUSXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 13:23:47 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D71D264B4;
        Wed, 21 Dec 2022 10:23:46 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id kw15so38749303ejc.10;
        Wed, 21 Dec 2022 10:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I8bHMUqENRt0vHg2+ln10JPBh/wNz9sMNq+zKIXFVzY=;
        b=F1We4HR4kaz9DAtLcoLZlAZ8ezAcRL+vFHXFCFq9L2rdsQFBkDOa6PsRjRMCSZdu4O
         bG3GmcD1fEWI7WQ6v7+hmIg8tVK1XhIWIm/0/qsrpg+RvaHWdTNCmrQ1+538wrrWcAGn
         xRn8xDjhurrxURajLVCfuHGmTHwnnnUtZwlFLUu88UYZvBnqOKGZXuWW2etehJvAxPNY
         EsZiCUCod1hVM+/8EkGNs3+eCJ/Vs+ZT9Rss7L6I7JuG7+xcBTdx9x+C0E4Y+PlvRy2t
         JALyWQSoKu4XrUN6T+T2+oEMp/QSutJfir7nEy5+dAYGgOIUC+41tsAEUNQcYTCwAWww
         qUig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I8bHMUqENRt0vHg2+ln10JPBh/wNz9sMNq+zKIXFVzY=;
        b=KKdICv1Ps+/pOcFZ2nkLPphcB9e9N99w3pSnqK9/p7+3P8iPmNSKjNzDilQ+xsvzO/
         TAjAt/9hL/6xGbjSon/ZucBoXpcWnPPRc3PmbSt3bWJ92Q4xL9X6HirPDJLlUMhRnbdW
         /n9SsWGNKhGSPUOb5K1U7p7Ip8oOpImcVLdGUYxaQ7xqWx6GoPNN66aLQRrDw1frscVV
         0cfrseFhYr0rtlQtIC4ts8IE2RsuoXwt1WCB63/m87a/HAKSPpcg/MhHcDoyRnEQPK1w
         oIlD6GOmsgzrWNf0X955uMzFp1czKIoDdwsnEbSPbmFcKXOmVv+oTIK+D5KVN3H5ujrJ
         Yf2Q==
X-Gm-Message-State: AFqh2kpJx/f9chu1ljvEa6vdn7sO7Hico+mkLxQ3pdIqmlGU0um6lp/Z
        wY+deDCoja7uwJXUcQfb2Jw=
X-Google-Smtp-Source: AMrXdXsxUOH/lAF8WRHYe33yxE8xdirpltA08OXaL7of17FvVtMHNrIjxtHjPmygwWrZSToTHaTKUg==
X-Received: by 2002:a17:906:1410:b0:7c0:eba3:e2e with SMTP id p16-20020a170906141000b007c0eba30e2emr2006134ejc.31.1671647024682;
        Wed, 21 Dec 2022 10:23:44 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id k4-20020aa7c044000000b0046856c307d0sm7388176edo.5.2022.12.21.10.23.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 10:23:44 -0800 (PST)
Message-ID: <fc68bedc-ff93-13bc-aa06-7920f5e53de6@gmail.com>
Date:   Wed, 21 Dec 2022 19:23:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v5 05/12] dt-bindings: usb: convert fcs,fusb302.txt to yaml
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        airlied@gmail.com, daniel@ffwll.ch, andrzej.hajda@intel.com,
        neil.armstrong@linaro.org, robert.foss@linaro.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, philippe.cornu@foss.st.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-usb@vger.kernel.org
References: <7f883643-c796-029f-ba38-73532325632d@gmail.com>
Content-Language: en-US
In-Reply-To: <7f883643-c796-029f-ba38-73532325632d@gmail.com>
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
 .../devicetree/bindings/usb/fcs,fusb302.txt   | 34 ----------
 .../devicetree/bindings/usb/fcs,fusb302.yaml  | 66 +++++++++++++++++++
 2 files changed, 66 insertions(+), 34 deletions(-)
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
index 000000000..9b172fda9
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/fcs,fusb302.yaml
@@ -0,0 +1,66 @@
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
+      fusb302: typec-portc@54 {
+        compatible = "fcs,fusb302";
+        reg = <0x54>;
+        interrupt-parent = <&nmi_intc>;
+        interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+        vbus-supply = <&vbus_typec>;
+
+        usb_con: connector {
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

