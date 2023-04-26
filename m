Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9C96EF356
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 13:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240637AbjDZLVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 07:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240577AbjDZLVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 07:21:44 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0A05274
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 04:21:43 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4efefbd2c5eso4301103e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 04:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682508102; x=1685100102;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zyn3pWh1I5zYmXKJZnDWojm/WjqJCfT4hRVyzg3c8zM=;
        b=AL84eNVXhM+h+pb78WkGyas5/MFVD8cGu6qX5aqC4mJg0AkPLmvvlXEdas3556gk2k
         qgaMsEvIrooQhgFM3M7P9FzkTxd2YEACMufo5FCNMh00HhP6zjXxMmwDeLIOt3jiueLT
         Yu9lCfLko3eN+3viE/7nYNe7N2QHjNY92YXAd04avgqgUFB/iLT0/AIJvNtd9PqWwlO4
         3acOv6iSujIymNCpbCeIV7vw17pulTz/J4/VP1+G6MbDYsI8aVl96IIfSSSdSBtHcYxU
         Fdn746aHI6yb5toQrKjt/6rcntmx4ojALZ5fCg1gXc50hq3+OLTtoGD/b2OfsB+E1Hcj
         V6Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682508102; x=1685100102;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zyn3pWh1I5zYmXKJZnDWojm/WjqJCfT4hRVyzg3c8zM=;
        b=UIEeKke64/NAnnUk3xKq3qek5Q9etSTZaWwxjvsHQSJrcsPLlk7yyh2HkySw4P4D7/
         eGuHEGPd8MlUz93rIMf8A+3unmhNgyGefHrrM/ncPMu7Y6RGKTCVVOQvRCE0Hi/D643Q
         IveD+xv8CwUjiHhM8KcZOScmr5z4hnQCGVTHZyiszB7M8DySqL6ykTIz5Mkn30k/z/38
         MRV90f8yTAxIqkjxBKqFuv4opiusp40mxBaY53cr/BXqTs65uHO9x5DgBGvJZWh7e8Dd
         Prtkn06tPMC+6Vz7tE1Bj6QZNf7bCPQwxOt6vB7UGEkZL8uUrbfxetTAo9v/0fwGXlyf
         Fa+Q==
X-Gm-Message-State: AAQBX9d/V7awH07jzxuHaw3N/DsNCXsgYZSiEkdlYgi1bA22loIThSga
        Mkc2crrmn2deveWBk2d9x0dzxg==
X-Google-Smtp-Source: AKy350YhOl8LLm54rt/4YgIe3Ha5QTCl8gyTtf7aqKuYUiXyHktmWRGMYpRDOSjHD+nKNyCmwHspJg==
X-Received: by 2002:a19:ae0d:0:b0:4ef:d4d7:a9f4 with SMTP id f13-20020a19ae0d000000b004efd4d7a9f4mr4140058lfc.19.1682508101728;
        Wed, 26 Apr 2023 04:21:41 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id u28-20020a056512041c00b004ec84d24818sm2453237lfk.282.2023.04.26.04.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 04:21:41 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 26 Apr 2023 13:21:38 +0200
Subject: [PATCH v2 1/2] dt-bindings: gpio: Add STMPE YAML DT schema
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230426-stmpe-dt-bindings-v2-1-2f85a1fffcda@linaro.org>
References: <20230426-stmpe-dt-bindings-v2-0-2f85a1fffcda@linaro.org>
In-Reply-To: <20230426-stmpe-dt-bindings-v2-0-2f85a1fffcda@linaro.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee@kernel.org>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Stefan Agner <stefan@agner.ch>, Marek Vasut <marex@denx.de>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a schema for the STMPE GPIO that while it is used a
lot in the kernel tree is anyway missing its bindings.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- New patch split off from the MFD patch.
---
 .../devicetree/bindings/gpio/st,stmpe-gpio.yaml    | 60 ++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/st,stmpe-gpio.yaml b/Documentation/devicetree/bindings/gpio/st,stmpe-gpio.yaml
new file mode 100644
index 000000000000..6e991ebbdf77
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/st,stmpe-gpio.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/st,stmpe-gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMicroelectonics Port Expander (STMPE) GPIO Block
+
+description: STMicroelectronics Port Expander (STMPE) is a series of slow
+  bus controllers for various expanded peripherals such as GPIO, keypad,
+  touchscreen, ADC, PWM or rotator. It can contain one or several different
+  peripherals connected to SPI or I2C. These bindings pertain to the
+  GPIO portions of these expanders.
+
+maintainers:
+  - Linus Walleij <linus.walleij@linaro.org>
+
+properties:
+  compatible:
+    const: st,stmpe-gpio
+
+  "#gpio-cells":
+    const: 2
+
+  "#interrupt-cells":
+    const: 2
+
+  gpio-controller: true
+
+  interrupt-controller: true
+
+  st,norequest-mask:
+    description: A bitmask of GPIO lines that cannot be requested because for
+      for example not being connected to anything on the system
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+patternProperties:
+  "^.+-hog(-[0-9]+)?$":
+    type: object
+
+    properties:
+      gpio-hog: true
+      gpios: true
+      input: true
+      output-high: true
+      output-low: true
+      line-name: true
+
+    required:
+      - gpio-hog
+      - gpios
+
+additionalProperties: false
+
+required:
+  - compatible
+  - "#gpio-cells"
+  - "#interrupt-cells"
+  - gpio-controller
+  - interrupt-controller

-- 
2.34.1

