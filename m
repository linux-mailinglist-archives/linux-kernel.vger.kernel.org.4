Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4475C60EBE7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 00:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbiJZW62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 18:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiJZW60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 18:58:26 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E434B6FA22;
        Wed, 26 Oct 2022 15:58:25 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id kt23so20085446ejc.7;
        Wed, 26 Oct 2022 15:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tKXO41Y/SWSFFaAWCsB9RGz7D8TegGmZORhd3TxzdEs=;
        b=YezYmqKzkTpedLipitniPXjPQD7/CZzP7/gotJ69PCCHoOoAD13kadMq0mnOJ+xEco
         ZU//Bo5Lo6aSvY1FAi0czPITrw36AOUxYu9oUk13o/yoihxDLqMt7AOfj/Zklbx8AoDt
         AE4yQeqonK+bQy3wh2K28NULJ6FWGc5YRhJ1mcFVql3UWCB6P/7Srb2MUqaxI4LXOhbB
         2DYZCsGNeiIhp7rUKatVcRiS0fyGOo5lRYm5NVmoEaR7YM/9riMVLSCTXftOLAAalUKb
         cA5+jF9s+TvMMTFrXwlzx3qTr0Q4oehyjRHjhr8SQbzkEONyn92fzqURHh0jXvVTPQ+9
         ki6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tKXO41Y/SWSFFaAWCsB9RGz7D8TegGmZORhd3TxzdEs=;
        b=eOvQgXwn243S6Tfrj0dHTmm53FcK5bgfR89Bav20k2WqtX7oFoZK91mCL3KKBjWCWb
         OH0C3eoG24kDpDpV9pMpv2FoGruhCRfRxQFahEkZyjMqAM355gfxpzNwxvUb0FlToIzq
         Q5/lwgHT3F56eVpv/T3aWLXjkaQlZI+PKlfV1cUOfh9fTULPWzBj8Uwd8cF2m8oYLihD
         QQPZ++VOyzW86vHn7Ephlm6jVFx3B/wf+77rX+nyjV3TUPAnd6rNsd4pIgrQijjDYiyK
         x2Bpg3XYugqqvb2ACNblKx7iQi4JHU0dNxyLOeQAw7TVfPDYfs+UJrX8WDUX0AxshAaX
         txwA==
X-Gm-Message-State: ACrzQf0iirBn63fukXWxPjcUz+L/0RrKqI1psYWAAhZFruQCSEU2oDHd
        RQZGK9iEePQM+6hOQfhALF0=
X-Google-Smtp-Source: AMsMyM6mQ/QRK3Y9ZsO5bVp1hlFiabnBy4SeH8oU4i4Vf7HLzAV3HiZy991kqc6SMFO9ebEhHJ9j2w==
X-Received: by 2002:a17:906:5a5f:b0:79f:9f1f:2fef with SMTP id my31-20020a1709065a5f00b0079f9f1f2fefmr24085589ejc.396.1666825104358;
        Wed, 26 Oct 2022 15:58:24 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id o19-20020a170906769300b0078250005a79sm3554252ejm.163.2022.10.26.15.58.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 15:58:23 -0700 (PDT)
Message-ID: <f7127f87-05fd-5e20-eb2d-a3fd04674229@gmail.com>
Date:   Thu, 27 Oct 2022 00:58:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 1/3] dt-bindings: rtc: convert haoyu,hym8563.txt to yaml
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert haoyu,hym8563.txt to yaml.

Changed:
  Add clock-frequency property

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 .../devicetree/bindings/rtc/haoyu,hym8563.txt | 30 ----------
 .../bindings/rtc/haoyu,hym8563.yaml           | 60 +++++++++++++++++++
 2 files changed, 60 insertions(+), 30 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/rtc/haoyu,hym8563.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/haoyu,hym8563.yaml

diff --git a/Documentation/devicetree/bindings/rtc/haoyu,hym8563.txt b/Documentation/devicetree/bindings/rtc/haoyu,hym8563.txt
deleted file mode 100644
index a8934fe2a..000000000
--- a/Documentation/devicetree/bindings/rtc/haoyu,hym8563.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-Haoyu Microelectronics HYM8563 Real Time Clock
-
-The HYM8563 provides basic rtc and alarm functionality
-as well as a clock output of up to 32kHz.
-
-Required properties:
-- compatible: should be: "haoyu,hym8563"
-- reg: i2c address
-- #clock-cells: the value should be 0
-
-Optional properties:
-- clock-output-names: From common clock binding
-- interrupts: rtc alarm/event interrupt
-
-Example:
-
-hym8563: hym8563@51 {
-	compatible = "haoyu,hym8563";
-	reg = <0x51>;
-
-	interrupts = <13 IRQ_TYPE_EDGE_FALLING>;
-
-	#clock-cells = <0>;
-};
-
-device {
-...
-	clocks = <&hym8563>;
-...
-};
diff --git a/Documentation/devicetree/bindings/rtc/haoyu,hym8563.yaml b/Documentation/devicetree/bindings/rtc/haoyu,hym8563.yaml
new file mode 100644
index 000000000..57729443f
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/haoyu,hym8563.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/haoyu,hym8563.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Haoyu Microelectronics HYM8563 Real Time Clock (RTC)
+
+description:
+  The HYM8563 provides basic RTC and alarm functionality
+  as well as a clock output of up to 32kHz.
+
+maintainers:
+  - Heiko Stuebner <heiko@sntech.de>
+
+allOf:
+  - $ref: "rtc.yaml#"
+
+properties:
+  compatible:
+    const: haoyu,hym8563
+
+  reg:
+    const: 0x51
+
+  interrupts:
+    maxItems: 1
+
+  clock-frequency:
+    enum: [1, 32, 1024, 32768]
+
+  clock-output-names:
+    maxItems: 1
+
+  "#clock-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - "#clock-cells"
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        hym8563: rtc@51 {
+            compatible = "haoyu,hym8563";
+            reg = <0x51>;
+            interrupts = <13 IRQ_TYPE_EDGE_FALLING>;
+            clock-frequency = <32768>;
+            clock-output-names = "xin32k";
+            #clock-cells = <0>;
+        };
+    };
--
2.20.1

