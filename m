Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A18273B0B7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 08:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjFWGVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 02:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbjFWGUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 02:20:53 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665AC189;
        Thu, 22 Jun 2023 23:20:52 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9891c73e0fbso62472266b.1;
        Thu, 22 Jun 2023 23:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687501251; x=1690093251;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vQAW8yZCFSnADhBud7nfo4RU3cNf5kaZDT6uTQ+OwQc=;
        b=Cyl0565ZQTnrDNtWV2gdoNppVn9OJSamny2gTKum+bh8LRvCwDSqpg/0rw3HLig+na
         M8UwWJ2R2GOzaR0tYZ+74Vr0M7I2Lb1Mdulz4e14meTpu7pZAmA1TyAWyOnaMcP+h27C
         o6wl6Jkf6DC7cDdfnxT4+965uL8a+QbHQ/jOThkOJYF660Ci2PlFrB3q26H0mEdcMSdH
         kEveW2lWrJJpMT3L4mFt9IM5d+QkZIMCc+s8oHot+tlKlDOR+N6QzhLvDS1uyvZirNId
         gimMN9LWSXrnNQ9RNDg+2IANCZH/3orHHIJFBMOlonaqlyCb94w/4FzmlcE7oIZf/7KQ
         YIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687501251; x=1690093251;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vQAW8yZCFSnADhBud7nfo4RU3cNf5kaZDT6uTQ+OwQc=;
        b=Ouh8XXUItAgT54fah4mGvbiywrhTpOF8LrTx5zlFyLDqEZC+dcoz1UePvGxRHuEwkm
         1Fxvseuw7GE+LtY5/8HWHXmaSGG0DoctZqof/WSByzVYslDzGMvCaogeHpE673x9HSCj
         yHwc2u7UB4zwkdPOue/6lZK8zOUWd1kd7BzYM6NLwIqmwVmutedIYklzrVO2jmi/B9Hj
         XIm9rQjVCx58MsQo6c+x3P17G90UR5gs2647QihwMtO8wEKZeeNkoXOQLbmSyg6a7ICf
         XDGTybUkYBRXkmd5OOloiwMsHT5RFGBphATAUoZoUNw0SBWDSRI/5VYSNo19pM0JfOW8
         UISA==
X-Gm-Message-State: AC+VfDy3N1B6L1CE7Ajg+cjl8jt/pYuF20rxEDLsD450HG30vwtMHwwH
        I6MHoy1fRlTPv8Cw0H4cOUU=
X-Google-Smtp-Source: ACHHUZ40sLLFuhkhkFx2k0/KywOPAz1O7kUR69t+K73Ax3TLT9qeufR3LATq0YvR2IoJuMXxEhTcfw==
X-Received: by 2002:a17:907:a40a:b0:989:6749:d61 with SMTP id sg10-20020a170907a40a00b0098967490d61mr7158015ejc.19.1687501250735;
        Thu, 22 Jun 2023 23:20:50 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id n20-20020a170906725400b009878b0b5302sm5630346ejk.98.2023.06.22.23.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 23:20:50 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Fri, 23 Jun 2023 08:20:38 +0200
Subject: [PATCH v6 3/3] dt-bindings: usb: Add binding for Cypress HX3 USB
 3.0 family
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-hx3-v6-3-6a1d6f8ce689@skidata.com>
References: <20230620-hx3-v6-0-6a1d6f8ce689@skidata.com>
In-Reply-To: <20230620-hx3-v6-0-6a1d6f8ce689@skidata.com>
To:     Matthias Kaehlcke <mka@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Benjamin Bara <benjamin.bara@skidata.com>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Bara <benjamin.bara@skidata.com>

The HX3 family comes in different variants (up to 4 USB 3.0 ports;
multi-TT), e.g. CYUSB330x/CYUSB331x/CYUSB332x/CYUSB230x.

This initial version of the binding only describes USB related aspects
of the HX3 family, it does not cover the option of connecting the
controller as an i2c slave.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
 .../devicetree/bindings/usb/cypress,hx3.yaml       | 77 ++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/cypress,hx3.yaml b/Documentation/devicetree/bindings/usb/cypress,hx3.yaml
new file mode 100644
index 000000000000..47add0d85fb8
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/cypress,hx3.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/cypress,hx3.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cypress HX3 USB 3.0 hub controller family
+
+maintainers:
+  - Benjamin Bara <benjamin.bara@skidata.com>
+
+allOf:
+  - $ref: usb-device.yaml#
+
+properties:
+  compatible:
+    enum:
+      - usb4b4,6504
+      - usb4b4,6506
+
+  reg: true
+
+  reset-gpios:
+    items:
+      - description: GPIO specifier for RESETN pin.
+
+  vdd-supply:
+    description:
+      1V2 power supply (VDD_EFUSE, AVDD12, DVDD12).
+
+  vdd2-supply:
+    description:
+      3V3 power supply (AVDD33, VDD_IO).
+
+  peer-hub:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      phandle to the peer hub on the controller.
+
+required:
+  - compatible
+  - reg
+  - peer-hub
+  - vdd-supply
+  - vdd2-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    usb {
+        dr_mode = "host";
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        /* 2.0 hub on port 1 */
+        hub_2_0: hub@1 {
+          compatible = "usb4b4,6504";
+          reg = <1>;
+          peer-hub = <&hub_3_0>;
+          reset-gpios = <&gpio1 11 GPIO_ACTIVE_LOW>;
+          vdd-supply = <&reg_1v2_usb>;
+          vdd2-supply = <&reg_3v3_usb>;
+        };
+
+        /* 3.0 hub on port 2 */
+        hub_3_0: hub@2 {
+          compatible = "usb4b4,6506";
+          reg = <2>;
+          peer-hub = <&hub_2_0>;
+          reset-gpios = <&gpio1 11 GPIO_ACTIVE_LOW>;
+          vdd-supply = <&reg_1v2_usb>;
+          vdd2-supply = <&reg_3v3_usb>;
+        };
+    };

-- 
2.34.1

