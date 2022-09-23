Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4DC5E8221
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 20:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbiIWSyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 14:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbiIWSyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 14:54:09 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AACA9121125;
        Fri, 23 Sep 2022 11:54:08 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id v1so961814plo.9;
        Fri, 23 Sep 2022 11:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=LWMvhbkibgVgAwfGEYsjKv95/YymSp2YBe/BKCGgDoY=;
        b=fZHpHbfxrAeBCHPt7qxiUpkI7pVUt4VGuppckzMijURoQcs9f34htIA5HDFw0QyAK1
         k5Bk8UrMIZXZW3BmVB1d02HnZFYyaCWuG77Hn9wEWvy8n1OjK9ILtzAmDGC1whz2dbFn
         sqWowXq4TTijS5OY5itAD4oQR63DuFjv3fmozNMnatgbpway263ZQLToFVI7PbsDai86
         EIESN6gtnwEn5LkIABlkFCUA/OBNmP50BexaXF2mjcNMMEys8/5LlGBAjQJQ69jwALIz
         Gdj5DAsy+u4dDw1FH7IG3/e9svFGU9gcfHPuBp5uB+rjplSadEkkByr9tQKkvYGx7C39
         S+SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=LWMvhbkibgVgAwfGEYsjKv95/YymSp2YBe/BKCGgDoY=;
        b=ZseX0Lq/OzNNGKsPhZ1YvAEfIDRdrZO95RkzOs96nVmMn7hZgO4cR/Jxk9CbmBAe9i
         EtTwut025Js3KTRmoDh4Ih/AtTXVT5wWUISClT2DrMkuNyFCfZq4dP1HjQsDk28fyOGY
         vs+53ML8kSR4Ahd1rP94Spqm7v57m8d58tNf3Bsr97wEijgiEU4v2MI53ZJg7BH7hW1c
         QKOMYrJlwc2y5YBzPfvkhQunj5rO6w+drblheBeuilCf4Y/LovByrC8YJZjGGhYWSIjB
         VyXErDMMgXOp5ZOMXTe+z2SgDng3KJe4tKPj+8eVsA6NDRXmaljeXpldxhBH6MOVZ/ZF
         koFA==
X-Gm-Message-State: ACrzQf12SuZB+1zNNPe8J+llQ/5EeIHDZ4vb7y5j2T2zDsvoEVvldnJj
        rnJIFAtggxCGQicIC6T6yu8moehmiHuL3Q==
X-Google-Smtp-Source: AMsMyM67jaXCU2IRewa9bN7XjNm+zndBDucoWXwx53NnRo2HYIEGk/09YnGcyyAM4bJk1tZLN/Jk8Q==
X-Received: by 2002:a17:90a:1096:b0:202:c5a9:bf1e with SMTP id c22-20020a17090a109600b00202c5a9bf1emr11447790pja.3.1663959248159;
        Fri, 23 Sep 2022 11:54:08 -0700 (PDT)
Received: from localhost.localdomain ([115.99.115.48])
        by smtp.gmail.com with ESMTPSA id l16-20020a170903121000b00176b3d7db49sm6490497plh.0.2022.09.23.11.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 11:54:07 -0700 (PDT)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     alexandre.belloni@bootlin.com, a.zummo@towertech.it,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, jagathjog1996@gmail.com
Subject: [PATCH v3 1/2] dt-bindings: rtc: add Maxim max31329 rtc device tree bindings
Date:   Sat, 24 Sep 2022 00:23:57 +0530
Message-Id: <20220923185358.11023-2-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220923185358.11023-1-jagathjog1996@gmail.com>
References: <20220923185358.11023-1-jagathjog1996@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document devicetree bindings for the Maxim max31329 Real Time Clock.

Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/rtc/maxim,max31329.yaml          | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/maxim,max31329.yaml

diff --git a/Documentation/devicetree/bindings/rtc/maxim,max31329.yaml b/Documentation/devicetree/bindings/rtc/maxim,max31329.yaml
new file mode 100644
index 000000000000..fc99f1854847
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/maxim,max31329.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/maxim,max31329.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX31329 Real Time Clock
+
+maintainers:
+  - Jagath Jog J <jagathjog1996@gmail.com>
+
+allOf:
+  - $ref: rtc.yaml#
+
+properties:
+  compatible:
+    const: maxim,max31329
+
+  reg:
+    maxItems: 1
+
+  "#clock-cells":
+    const: 0
+
+  clock-output-names:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  trickle-resistor-ohms:
+    enum:
+      - 3000
+      - 6000
+      - 11000
+
+  wakeup-source: true
+
+  start-year: true
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        rtc@68 {
+            compatible = "maxim,max31329";
+            reg = <0x68>;
+            trickle-resistor-ohms = <6000>;
+            #clock-cells = <0>;
+        };
+    };
+...
-- 
2.17.1

