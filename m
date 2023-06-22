Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20525739935
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 10:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjFVIRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 04:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjFVIRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 04:17:35 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B4E1BCB;
        Thu, 22 Jun 2023 01:17:34 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-988b75d8b28so525904966b.3;
        Thu, 22 Jun 2023 01:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687421852; x=1690013852;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vQAW8yZCFSnADhBud7nfo4RU3cNf5kaZDT6uTQ+OwQc=;
        b=kARsZqFr4PYS5kVV4NlRTkCQZQl1+2YkJcJ/wMB+wnuZKnPkxd8DmIFYtmv41dRfJy
         4az3ItTyb1ExtxPqmb+QgMl856FuoyOfjrdDUA9Bnp6zzLiHLI4Z8yyYN3fjZRVBwHAr
         DHcKX+Lo5xxBIoVCwd/P5jZlvVIjhuOHzXOnZo7N+9dxTn/wDjthVh86RFWrxuQyJWgw
         ohGqKrC0EUByoaYrhKlJ+wG0eOgEilhQNGzpZ8upuHp40Cvi2MX6MqHi8ln1NR6q4NGd
         F50cPuK/drDFlvCb9TtbvJ3cIxoUlaElPDG6dv9P7f3bwtu2ggBiwhJiSS9hi2IibY+r
         hAoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687421852; x=1690013852;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vQAW8yZCFSnADhBud7nfo4RU3cNf5kaZDT6uTQ+OwQc=;
        b=lLRfRQha3rWLC/D5+7SmBGLLJBskL81N1gNjWoDp9rYCH68N/WvahYKluTWgwA1eIb
         mRTp4zDkFEbse4uiwZ8g2zc0/r44YdxeN3phhgBo8cAtkEkfyeoieZAZEBpB1fGEgMnw
         He0gWP1hinTukourYOiOJQcXV5u26JlnerliwTpJVjZi71BmaAjr9xvChIoEcmnPmYhM
         QYRePtdeq0Gx+pvnV88CTqBSeyI1WZq7mszmf2nbON7Lpd2X0VuQi6rVsQBwPPquqco6
         vLqsFwiysFLUdkpgdGWhH6+jlsIs8oUx3Us/H+1anCljtYj/EmHy2p45x71xxwjeCYGW
         6nQg==
X-Gm-Message-State: AC+VfDw2zaIw/jrPnOYYvPCsufvcMjDQP5SSJp0w6TW4xpwXv4yjm9Wy
        9/mr7hJHw9/KdKuoYbLLyyo=
X-Google-Smtp-Source: ACHHUZ76Q3bXBfAZvU8u8NWc41WchzEkD1d48/cXmceYw0WhwFthHHtW16u20G5hpJ4oaZev3mlmXQ==
X-Received: by 2002:a17:907:c0a:b0:96f:d345:d0f7 with SMTP id ga10-20020a1709070c0a00b0096fd345d0f7mr15611192ejc.62.1687421852485;
        Thu, 22 Jun 2023 01:17:32 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id k22-20020a056402049600b0051bc58b8dbcsm3577886edv.59.2023.06.22.01.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 01:17:32 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Thu, 22 Jun 2023 10:17:24 +0200
Subject: [PATCH v5 3/3] dt-bindings: usb: Add binding for Cypress HX3 USB
 3.0 family
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-hx3-v5-3-319c9c4c846f@skidata.com>
References: <20230620-hx3-v5-0-319c9c4c846f@skidata.com>
In-Reply-To: <20230620-hx3-v5-0-319c9c4c846f@skidata.com>
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
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

