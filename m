Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E5D73B186
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 09:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjFWH2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 03:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjFWH2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 03:28:20 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E8719BF;
        Fri, 23 Jun 2023 00:28:19 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-988aefaa44eso33257866b.2;
        Fri, 23 Jun 2023 00:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687505298; x=1690097298;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vQAW8yZCFSnADhBud7nfo4RU3cNf5kaZDT6uTQ+OwQc=;
        b=WLwNwwXJL81ydxxMH8W3bUqs1JkG9L3tzw5sYwCMGRUeSyKhrz3b3mn2sokXi56yNY
         NISOHlpjPmelvIDtVkxsCzU8uAb/oH8+WE9gmuvkwesuPpNZT5AGV82+VvVLqIOTl7f4
         5+bBBwqYadyM76vgEm6KAZfUr7GS4/+SWRn/cOLagB0Xm5NHOWt9xO0DGGyo3vSMXWXK
         W5KnQAmuuFyPfZyAf+Z7VW1BjEY+Wk3u82V3aRdbwW0G35Mw6UUDro47d2m+KeX9SCwn
         0RHezvIynmP3K1FWWqKwjnd/1E3TSK4qffhd5qH+nCNshCJ4ThTmLIQ9o4/3WunK/Ej7
         qJEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687505298; x=1690097298;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vQAW8yZCFSnADhBud7nfo4RU3cNf5kaZDT6uTQ+OwQc=;
        b=h0h/FWBXnBbUo4Y7bdkpdbH4qmzaAs3MrIJlwZxfZuhB0LfeBR0cGYo1gaznkFIXFz
         s1RI02GmOwRo6T+x124f53rrOWmSss8Mu2W4XuBS0/m6LWbfkU12ObPZku3KN7VDhHmZ
         7RCrW1Qu+GR4RLeTUeu69yzCDR1KAk3EOT+Bv0zFKgqZYODg2i2TnhNHga2BcsBiKB8D
         E/UUhnHihMDGLAQEQuXevYZtU5DY9vAc47SM9HvfXmDK7jN1iGD2VTMpR2pzzK91STBd
         HSVR6+wYKxNUEmRd9T8AUa7qfXqH8cHn0I24I4K3jcQNwC9vdR96id/zWt1/izfKhPBl
         PZbA==
X-Gm-Message-State: AC+VfDz+CBBOBQJ0s5fsQU0XfBBT+aXS4fosKOtIVQrkpKq8yM7aJxr4
        XTLh4gZNDJv4Wlgz70fBJ9s=
X-Google-Smtp-Source: ACHHUZ64S0PU2CibTDqtbntbr658so5FMj8Ky0zBReLz2hhtgAH/FxtzwPWKd9Kui2ozk94o+XyqKQ==
X-Received: by 2002:a17:907:1c09:b0:988:2037:c67f with SMTP id nc9-20020a1709071c0900b009882037c67fmr16189345ejc.2.1687505297662;
        Fri, 23 Jun 2023 00:28:17 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id y19-20020a17090614d300b00982d0563b11sm5637811ejc.197.2023.06.23.00.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 00:28:17 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Fri, 23 Jun 2023 09:28:14 +0200
Subject: [PATCH v7 3/3] dt-bindings: usb: Add binding for Cypress HX3 USB
 3.0 family
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-hx3-v7-3-f79b4b22a1bf@skidata.com>
References: <20230620-hx3-v7-0-f79b4b22a1bf@skidata.com>
In-Reply-To: <20230620-hx3-v7-0-f79b4b22a1bf@skidata.com>
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

