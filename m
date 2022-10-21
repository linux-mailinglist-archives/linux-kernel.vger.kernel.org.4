Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01BB2607DFD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 19:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiJUR52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 13:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbiJUR50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 13:57:26 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3938D26551F;
        Fri, 21 Oct 2022 10:57:26 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-13ae8117023so4463786fac.9;
        Fri, 21 Oct 2022 10:57:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/jQjxq+e47XxVcvPy1+t9R+5G4XPCZM0x41PBT8twbU=;
        b=FXmJyVX2v9mxG5ne3kvzqhgZfBBlVF4c6gAtrOrdCdoInbzzYfwrou9Fxao7cuv/EL
         v/yCjyus1xMusb6VF4XVp+hNJ3UgcW0msF/phlbXUk53QvtvVmglnHc5MUvRSz8Cryo3
         slBOtTbFnocGmd7R+e7Ie8KI5hfSxiW5WG+Bms2HXSzh7wthE4knxvKV0hMieLH0sGFo
         MZsmQpSqkU8mdI40svj/6xoKnKNvCx5aTOjDv/B8ZgaqJdTUHtvWRqBmejxe6ckCWCuQ
         PuHemLuu9D0rMrPRaER0/TftYFAbpMeHHTjeCbh67RYu4UYoDHTIxq43KrBcelgxvcZV
         kmyw==
X-Gm-Message-State: ACrzQf2jN6Vt61sFr7xHy9tgzljgczsOuacA+yYIYN07GUcpyxn5otw/
        6dxoqe4JaJwau+ukFs31T+qZc5ZJ3w==
X-Google-Smtp-Source: AMsMyM4tpdOAMkz2XAcwJ5Q0Ti7mViOL5yxCCERanNJ1hDzAAJGgf89B2S7bNswtDxj5skjtOigv5A==
X-Received: by 2002:a05:6870:9a1f:b0:133:599:9555 with SMTP id fo31-20020a0568709a1f00b0013305999555mr30129688oab.201.1666375045361;
        Fri, 21 Oct 2022 10:57:25 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id db10-20020a0568306b0a00b00661a80d555fsm1389748otb.40.2022.10.21.10.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 10:57:24 -0700 (PDT)
Received: (nullmailer pid 4005712 invoked by uid 1000);
        Fri, 21 Oct 2022 17:57:26 -0000
From:   Rob Herring <robh@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: dt-bindings: Convert dmic-codec to DT schema
Date:   Fri, 21 Oct 2022 12:57:21 -0500
Message-Id: <20221021175721.4005601-1-robh@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the dmic-codec binding to DT schema format.

The '#sound-dai-cells' and 'sound-name-prefix' properties were not
documented, but are in use, so add them.

Reviewed-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
 - Fix example include and syntax errors
 - Update Arnaud's email
---
 .../devicetree/bindings/sound/dmic-codec.yaml | 55 +++++++++++++++++++
 .../devicetree/bindings/sound/dmic.txt        | 22 --------
 2 files changed, 55 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/dmic-codec.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/dmic.txt

diff --git a/Documentation/devicetree/bindings/sound/dmic-codec.yaml b/Documentation/devicetree/bindings/sound/dmic-codec.yaml
new file mode 100644
index 000000000000..bba27c985996
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
+  - Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
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
+    #include <dt-bindings/gpio/gpio.h>
+
+    dmic {
+        compatible = "dmic-codec";
+        dmicen-gpios = <&gpio4 3 GPIO_ACTIVE_HIGH>;
+        num-channels = <1>;
+        wakeup-delay-ms = <50>;
+        modeswitch-delay-ms = <35>;
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

