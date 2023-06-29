Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7948974233C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 11:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbjF2J13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 05:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbjF2J1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 05:27:20 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D91B1BE1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 02:27:18 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3112f5ab0b1so440091f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 02:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688030836; x=1690622836;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=31dDSPmTEwAk2xBEYscYsgGP3NvqtS1pbeFP7C1NdB4=;
        b=xoL9nHEBMMPLXgUGrd9HzmGNF7olI2VB1dla0Wr/y/6DUsz8N0Du40RBGu4WeJOnhq
         c2FIiKV2fHiONWdOpDQlwGWaeaGRGBvAqLCchqBa7x82e318ro3yoFe6LU72GH4QEnWq
         Khge3rLSzy2LNYIQaI+1wURIy65JwXnwCVkUuns9Su3qejnbJTpaLCiwzBM/jh7OAPE2
         JssSfuer0h/vGrAg6af4JiLohtjFtQr7kOZnB0DeprUvidEM8DG0By6YxrmCzu9pxTfu
         yY1LpRS33hlpjGuVav5d0U/AqxkszlNSlr4ePyubLlkDQ0GMc/ALy581E6rJmJiyQarH
         ngAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688030836; x=1690622836;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=31dDSPmTEwAk2xBEYscYsgGP3NvqtS1pbeFP7C1NdB4=;
        b=a1SpMsmeeT+qBHhVFJQVqBlSh5REVTcA7hqe6yj6oXQ3BFS92VJauEYcumnG2fAJg1
         Lox6kjt46Bbs4vVSpkLabvk7yCfcMl/ffUcAHbL5V1G8Vx3M+kKfJfQ0dRhTzHWELfME
         QDkZBg4ftP9zC1d6EDtCGiiJH0h+tFvm0yBGWiWP4MfqLZ5GT/0l0nEROzoLLYZt7eWQ
         j5sMRsoDO/wI+NEkUtMX2CE1Ux9u7aLdCIthBTmc8RmudzzrRHYkSwGkqa/rLsQ5dnWa
         Xu7JYNpcW+uPTJYOTJhw0LkmGPgAjwpGP6mrGAu1NXS7+x3C9HXMhOMp7u/EXOvJuohr
         wsrw==
X-Gm-Message-State: AC+VfDwhjS3tw7HH11GyAuBAIvtZpY25Jcg0vsmyi/V2oPH9qkJkTGRX
        nDuv1V/FaWReZLGLguScfNWv2Q==
X-Google-Smtp-Source: ACHHUZ4Ox+WaeCzwJ47q9oRBXms1IRimwRZII3GgfR2QKTjHkKz0sgpCgbBawOTtbPBv66gY9ViiEQ==
X-Received: by 2002:a05:600c:22d2:b0:3f9:b297:1804 with SMTP id 18-20020a05600c22d200b003f9b2971804mr21295637wmg.17.1688030836346;
        Thu, 29 Jun 2023 02:27:16 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id s4-20020adfea84000000b002ca864b807csm15800172wrm.0.2023.06.29.02.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 02:27:15 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 29 Jun 2023 11:27:10 +0200
Subject: [PATCH v4 1/4] dt-bindings: input: document Goodix Berlin
 Touchscreen IC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230606-topic-goodix-berlin-upstream-initial-v4-1-0947c489be17@linaro.org>
References: <20230606-topic-goodix-berlin-upstream-initial-v4-0-0947c489be17@linaro.org>
In-Reply-To: <20230606-topic-goodix-berlin-upstream-initial-v4-0-0947c489be17@linaro.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Jeff LaBundy <jeff@labundy.com>
Cc:     linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3093;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=sfk9uxvNPIwk9f8d5iBn9m2N4nTZgMQFpRmAil1gnVU=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBknU5wV3PpOBEOPmwhmka9C/nUAM1mrtWNjVtwtcxA
 sl+NRXeJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZJ1OcAAKCRB33NvayMhJ0b5jD/
 9KVUiblZUnHxPDlz1t/Dm9T/JJ5AFtRsNMwcS6Ru57/soLvNWvPDXbDqFL/9Zc6k+Y3p7BAf33lET4
 is02Junwh/koPxik/cuNQkd/g2Edma4AImRGTdqd/NyGSSu4brlFCwd/9kbagHHb+3wWK6zqs794zA
 SSRiE2wNrnex7a4IM91HHY/6TbbOiwx37g1Bpw/D7nIv9GBlFyU2rgoCuQnFLLakxgtnHQZFVphupZ
 yPuL+trrbqBdTeMXqZOnwQweGwDKvQ37Ubqv1I8aRS1+INLq90rGYjvoqRXBWUoYBvrdJ0KGK2LWSX
 h2o77umT+rina3TQywmvON06jmTd9GxXjcKcsjOjV3ioc7Yf6uGEPCYDR0I582poLnlhGAnoAHplNM
 IUS6+Arhk8XekjI2B3nBuEJzyhAAH5s/TywkBpJtbJCPgMBd65teaF/AwMX4oooYfb9Bjt79wdluRI
 Df+4TbxJK1Yiuf0Kk3AIrWddp6J4ODYwHoA0KXCmDuzmWa7rqFtyVv0l4uE2nTpnjD6+//24p6Hho0
 xCaklJHLnnyswZ2+Q9sPmmAw8/O1npV+3qyBw2b/oSmkRiNRS6N1zQ+zOs1FHEhZq2yRTk8RXUysXK
 CmDzpccmdAtjz4sxBBZ9Ltmz3dqTnWCNLBOelIcwzjEEI+4xYF7y7ZBZSjHA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the Goodix GT9916 wich is part of the "Berlin" serie
of Touchscreen controllers IC from Goodix.

Reviewed-by: Rob Herring <robh@kernel.org>
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

