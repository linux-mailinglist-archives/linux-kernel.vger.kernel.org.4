Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C55FD5FBA99
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 20:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiJKSl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 14:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiJKSlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 14:41:24 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A277CAA2;
        Tue, 11 Oct 2022 11:41:23 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-12c8312131fso16975807fac.4;
        Tue, 11 Oct 2022 11:41:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4JAJVk0JnsSinL2EcEIankDF1nDr2CRkvvuRQlFNUCo=;
        b=tIVwN7GsywVN+eRcBJrK2VFN5O+JS5uHMmEVeEBnKcu4W3ovR5K9tqAaDKz1PtiL8w
         byUm6W3Ox2nGXY+75CT7aJXWxsTNgXYNd6xu5uVgAOHhe0ACDCw4r7VZQ1mnYKx8eJC+
         yCaeLlwTQxZ8+Rlkz5PRNJ5nduwBLb9sWZnVW+vffs94wGtECmfo+7VyUdjNybzzwm97
         gAPKk2a2fR4XTWlK4xspKgJvOZeS2C8GNknVo9s7U8FYKOhJncXyFetF+9MXaDzpJFdt
         iN589XtWZogNqX3AlUrwGN4xKiNnjvQDhZ8jdst1RpIoLrFRtCqP2vTQo/brfpov3W++
         Tb9A==
X-Gm-Message-State: ACrzQf0ddeVRUu5D9aNNQFKimvkQ50+mcmDqIrG6C3cSqZFzCvPuaqPN
        wYi6265byuCPQE8rx6QVLA==
X-Google-Smtp-Source: AMsMyM6NnHYJgkyLWS5L0o44ZzcDSOea6RklSLt6jGqdzkkxoYu8wriiAf7by2811mt0dFqqdYz6Yg==
X-Received: by 2002:a05:6870:424d:b0:132:5c64:dd5a with SMTP id v13-20020a056870424d00b001325c64dd5amr344320oac.128.1665513683076;
        Tue, 11 Oct 2022 11:41:23 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e22-20020a056820061600b00480816a5b8csm117789oow.18.2022.10.11.11.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 11:41:22 -0700 (PDT)
Received: (nullmailer pid 3755271 invoked by uid 1000);
        Tue, 11 Oct 2022 18:41:24 -0000
From:   Rob Herring <robh@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: dt-bindings: Convert dmic-codec to DT schema
Date:   Tue, 11 Oct 2022 13:41:19 -0500
Message-Id: <20221011184119.3754096-1-robh@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the dmic-codec binding to DT schema format.

The '#sound-dai-cells' and 'sound-name-prefix' properties were not
documented, but are in use, so add them.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/sound/dmic-codec.yaml | 55 +++++++++++++++++++
 .../devicetree/bindings/sound/dmic.txt        | 22 --------
 2 files changed, 55 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/dmic-codec.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/dmic.txt

diff --git a/Documentation/devicetree/bindings/sound/dmic-codec.yaml b/Documentation/devicetree/bindings/sound/dmic-codec.yaml
new file mode 100644
index 000000000000..767152fa99cc
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/dmic-codec.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/dmic-codec.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Generic PDM Digital microphone (DMIC) codec
+
+maintainers:
+  - Arnaud Pouliquen <arnaud.pouliquen@st.com>
+
+allOf:
+  - $ref: name-prefix.yaml#
+
+properties:
+  compatible:
+    const: dmic-codec
+
+  '#sound-dai-cells':
+    const: 0
+
+  dmicen-gpios:
+    description: GPIO specifier for DMIC to control start and stop
+    maxItems: 1
+
+  num-channels:
+    description: Number of microphones on this DAI
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    maximum: 8
+    default: 8
+
+  modeswitch-delay-ms:
+    description: Delay (in ms) to complete DMIC mode switch
+
+  wakeup-delay-ms:
+    description: Delay (in ms) after enabling the DMIC
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio.h>
+
+    dmic {
+        compatible = "dmic-codec";
+        dmicen-gpios = <&gpio4 3 GPIO_ACTIVE_HIGH>;
+        num-channels = <1>;
+        wakeup-delay-ms <50>;
+        modeswitch-delay-ms <35>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/sound/dmic.txt b/Documentation/devicetree/bindings/sound/dmic.txt
deleted file mode 100644
index 32e871037269..000000000000
--- a/Documentation/devicetree/bindings/sound/dmic.txt
+++ /dev/null
@@ -1,22 +0,0 @@
-Device-Tree bindings for Digital microphone (DMIC) codec
-
-This device support generic PDM digital microphone.
-
-Required properties:
-	- compatible: should be "dmic-codec".
-
-Optional properties:
-	- dmicen-gpios: GPIO specifier for dmic to control start and stop
-	- num-channels: Number of microphones on this DAI
-	- wakeup-delay-ms: Delay (in ms) after enabling the DMIC
-	- modeswitch-delay-ms: Delay (in ms) to complete DMIC mode switch
-
-Example node:
-
-	dmic_codec: dmic@0 {
-		compatible = "dmic-codec";
-		dmicen-gpios = <&gpio4 3 GPIO_ACTIVE_HIGH>;
-		num-channels = <1>;
-		wakeup-delay-ms <50>;
-		modeswitch-delay-ms <35>;
-	};
-- 
2.35.1

