Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60549738E1A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 20:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbjFUSEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 14:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbjFUSEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 14:04:11 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F229D;
        Wed, 21 Jun 2023 11:04:10 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9741caaf9d4so752752966b.0;
        Wed, 21 Jun 2023 11:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687370648; x=1689962648;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cXp+vDAywJj5cJVg/DGBbIIG0LrSwQcuzIbyxZXKO/k=;
        b=K+EW8lbSK4PoxTVYtjeTj96jP+KYrKG5oRucUsuNByForLRmUwBToTz81XEdfT8oUi
         /CgExf+MCc1EDN7tAV2qM16x1K4QV75+zqoAnvp6T887K6wZMLJVhSVODjjdOMUPkDgp
         gnFbbqI+jihCIzg0ALDgkj4ZpbZMNBSRDFB/IKiktdIJAOvjuUCFKJPykE7t45HJ0qZL
         HXS3QMlWg2AAXtbiMcEnt/mwu3ZTyPEMOrlJuI0JDUHOWwEYJWT3KaYA7IrozTr9B6KL
         GD1SuSyZ6Nj6ZN0fJYQE5GIAQlMm6IixP/XfIZAzMfbzJme2si21bvfiBToxtfYLhR83
         Q6SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687370648; x=1689962648;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cXp+vDAywJj5cJVg/DGBbIIG0LrSwQcuzIbyxZXKO/k=;
        b=DEQXuqhOSqxHa49doQSyb3hBI2ucOuKKUHD0kzJXkrkjT2Qk4iRb6m7+FUpqiMGrqY
         56yTfbbygf75KZds2CtAHhIWpzEKNJzEJKtntiIAKYJQyfdoIN3kxr34yBoO+sZTzQKi
         KB3UtAlKUM/pAVhptV0TpDzmgQ+GR2Pb9CeDjkw8sFijtHgVAQ0m5XR+3ecMjaRTxeSf
         TXzKDvxP+3e4dRuGOCTtBYj047Cwy5WDbqZnJ8bjepVCFWez9sanJhsxeXrsBSp2h5HI
         ErCKQNl7KaJUoeX+r6Sp3gB+QuTpIK6iGao+NPOEUrByL54o937xBgXfEf+mQVBbgr2f
         h04w==
X-Gm-Message-State: AC+VfDxsT5ImILUCYlphmmJvGmvcFoWxSu5op00EwaYm5qzY7QDyPbYl
        kfdPwDmvqz01CKcPBt7v/k6DOz0NPccBQg==
X-Google-Smtp-Source: ACHHUZ7N4+YBBScMKZUCmuIVV+hNuxz6uOzk1+2+tW4XnlQSDMEifoQ6vD4j5DdLJJ0ml5uElrxyVg==
X-Received: by 2002:a17:907:16a9:b0:98c:e3a1:dbb4 with SMTP id hc41-20020a17090716a900b0098ce3a1dbb4mr1667292ejc.68.1687370648353;
        Wed, 21 Jun 2023 11:04:08 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id u13-20020a170906b10d00b00988955f7b5esm3460779ejy.157.2023.06.21.11.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 11:04:08 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Wed, 21 Jun 2023 20:04:05 +0200
Subject: [PATCH v4 3/3] dt-bindings: usb: Add binding for Cypress HX3 USB
 3.0 family
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-hx3-v4-3-e56b3c6db60b@skidata.com>
References: <20230620-hx3-v4-0-e56b3c6db60b@skidata.com>
In-Reply-To: <20230620-hx3-v4-0-e56b3c6db60b@skidata.com>
To:     Matthias Kaehlcke <mka@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Benjamin Bara <benjamin.bara@skidata.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
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

