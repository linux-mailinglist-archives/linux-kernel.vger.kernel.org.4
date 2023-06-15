Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9228731539
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 12:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244939AbjFOK1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 06:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245052AbjFOK1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 06:27:13 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DADB10F7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 03:27:11 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-311153ec442so372126f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 03:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686824830; x=1689416830;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9c2M/W71Umd5OR1G2L6k5M3nfF7xrs6GwHTTg7fiWIs=;
        b=Kn0DCJuy0jSPg3C4d5o4BQNBrg8ri2SZCAu9y1L/hKHfH+fo9LJ1xty8EXFCfWbkz1
         lejgauIRcpHUUlIE+W+1+WE0eddPhG5HRBG4ny0WiiwCSGEMsf7WxqX4lMt6qczlCrne
         5KwzVuhxUYhQyuyachYYm+pnQOe1He67JbbATxaQRIbGwwNQmwEr7lqOEeyzZc23ffxZ
         cWLs+WGYLXYB91GwOYnDUlr94xK+zPfeYxWdHazQ0GLdBVO7B6Pj2rvCfudIsNgu+ux0
         XzLApMGCLsv2s7g6ESe95ApdtxWpvLFAVfFRRrRizr6UXYwzQQZ2aIOVn6MseH81UDp5
         GAKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686824830; x=1689416830;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9c2M/W71Umd5OR1G2L6k5M3nfF7xrs6GwHTTg7fiWIs=;
        b=PAjrC8i7BKh7yFuInLuTk1bIxIuolOe6ycFltdB4iNASiXo4pwuf17w1gjDd6xkyVU
         Bt1T2CZ3WN0Uno1PSEHTOKtpiHI/2N+RCE5/mgnJLPksoDGpHbR8vu91ZExau28XnFFD
         18CU3S/6VzNUqpjlLHJqxvHqLXi3nUdrs2VD4wM3vnt/7DJv7QXgFVxuL/U/3RpzYw2p
         ebihjrRGOa4p8Ki680KdEe6e8beySsZ9TOjflQvQeIFBkDnDn0GgkVJgBDp2HDaca5IF
         iGT6bTllTPzgGNyTAuGcnpjN+0nr6+JLTRGoZLxQAhZ0niGeuL7yE2Jb2Xln3Z0nEmy4
         6eXA==
X-Gm-Message-State: AC+VfDzr6EEk+XsqHrQ33xzlzy/oBlvNqmJcLji4sgtzG5E4eX9Wbsja
        Bf7NC0gjuIZiG1jJY0cfEtvyVw==
X-Google-Smtp-Source: ACHHUZ5WnW6K6wJspp8ESkCXMlnFyQAYikTl8WVkPjrn1KuM+feUHP3nPhrgM38N21/EdO0DnNUFYw==
X-Received: by 2002:adf:e54d:0:b0:311:19ad:a082 with SMTP id z13-20020adfe54d000000b0031119ada082mr645170wrm.3.1686824829831;
        Thu, 15 Jun 2023 03:27:09 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id u5-20020a5d5145000000b0030fa57d8064sm17332337wrt.52.2023.06.15.03.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 03:27:09 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 15 Jun 2023 12:27:00 +0200
Subject: [PATCH v2 1/4] dt-bindings: input: document Goodix Berlin
 Touchscreen IC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230606-topic-goodix-berlin-upstream-initial-v2-1-26bc8fe1e90e@linaro.org>
References: <20230606-topic-goodix-berlin-upstream-initial-v2-0-26bc8fe1e90e@linaro.org>
In-Reply-To: <20230606-topic-goodix-berlin-upstream-initial-v2-0-26bc8fe1e90e@linaro.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Henrik Rydberg <rydberg@bitmath.org>
Cc:     linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3049;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=pJJwmz5Q68XC8REHCc8ClhlwPyfSMUQlDbNdC2eJDX8=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkiud6/CrkxC8xi4+BzQHlOhRQnGpyGT8hJ7TCeYjP
 047zQw2JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZIrnegAKCRB33NvayMhJ0eNZEA
 CWflo7h8IIShUJsDgPRGAttJj691dePcGcV/Ges3E1uGEYf4G4Bl5MRPqCSfToAU03fGYQQJxn82Xg
 PtEDoeQK0pnle99FA7Wq1aUia2qWV2pflK37i2cs8cyVBe7PUOtD6P8a3TBN99TCmkGoMZjX+428du
 wvUPOM4pk2bOL1m0EXJpgT56GTczO2yVk16l7xFAF+3lMFVo+gEJksy7xPSfqltigHozXyEgqxwcCY
 cvwmOCdlUwlwWjIU3k5rE+A4cadpr9pzPD3JghHNtP0q62IBsD5UHwv8e21xL0/z0cz01KAZBzgKjl
 Tw1JVjABR479JTBYF46N8suVjWd1qS/LtfUWqmQ8YE3XS6jEOsNc9zswF8BTCgjuv/cJn+rYxUgeEV
 nIH3vbWbjd5VC4FHvqyvdkqMFtxBsfCrEj93h/AKE1lb+gGECRB4v5O1KX4npqsytIuWR+AxheVoh7
 yUgfZ4DAHn9X2jR/eku/KeWsOXLI8kTns7FgHEF0oWFrUf8hQy5i8cTvi4nt3ABxIe0C+5xOXmhZz6
 RX6bX42n7mJnrswghPqEds8THuhvbMmIjxn+xUK2TdEVca5oP4ZhFIEp2oxMpkTgltZtC2WpwubrpP
 kJglSEgR1zC4LIJ73oNjvRQK6D5PuN7vdXbZiyPCJSzbaWQE/DRAv29MPoYQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the Goodix GT9916 wich is part of the "Berlin" serie
of Touchscreen controllers IC from Goodix.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../bindings/input/touchscreen/goodix,gt9916.yaml  | 95 ++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix,gt9916.yaml b/Documentation/devicetree/bindings/input/touchscreen/goodix,gt9916.yaml
new file mode 100644
index 000000000000..d90f045ac06c
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/goodix,gt9916.yaml
@@ -0,0 +1,95 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/touchscreen/goodix,gt9916.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Goodix Berlin series touchscreen controller
+
+description: The Goodix Berlin series of touchscreen controllers
+  be connected to either I2C or SPI buses.
+
+maintainers:
+  - Neil Armstrong <neil.armstrong@linaro.org>
+
+allOf:
+  - $ref: touchscreen.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    enum:
+      - goodix,gt9916
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+
+  avdd-supply:
+    description: Analog power supply regulator on AVDD pin
+
+  vddio-supply:
+    description: power supply regulator on VDDIO pin
+
+  spi-max-frequency: true
+  touchscreen-inverted-x: true
+  touchscreen-inverted-y: true
+  touchscreen-size-x: true
+  touchscreen-size-y: true
+  touchscreen-swapped-x-y: true
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - avdd-supply
+  - touchscreen-size-x
+  - touchscreen-size-y
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      touchscreen@5d {
+        compatible = "goodix,gt9916";
+        reg = <0x5d>;
+        interrupt-parent = <&gpio>;
+        interrupts = <25 IRQ_TYPE_LEVEL_LOW>;
+        reset-gpios = <&gpio1 1 GPIO_ACTIVE_LOW>;
+        avdd-supply = <&ts_avdd>;
+        touchscreen-size-x = <1024>;
+        touchscreen-size-y = <768>;
+      };
+    };
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      num-cs = <1>;
+      cs-gpios = <&gpio 2 GPIO_ACTIVE_HIGH>;
+      touchscreen@0 {
+        compatible = "goodix,gt9916";
+        reg = <0>;
+        interrupt-parent = <&gpio>;
+        interrupts = <25 IRQ_TYPE_LEVEL_LOW>;
+        reset-gpios = <&gpio1 1 GPIO_ACTIVE_LOW>;
+        avdd-supply = <&ts_avdd>;
+        spi-max-frequency = <1000000>;
+        touchscreen-size-x = <1024>;
+        touchscreen-size-y = <768>;
+      };
+    };
+
+...

-- 
2.34.1

