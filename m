Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB756BA3E6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 01:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjCOAJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 20:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjCOAJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 20:09:41 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61459360AF;
        Tue, 14 Mar 2023 17:09:35 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id p13-20020a17090a284d00b0023d2e945aebso2253456pjf.0;
        Tue, 14 Mar 2023 17:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678838975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kzy0B/VYnSJRvZ8pGtdA2kQJazW5NtKMyoTehvrQmDw=;
        b=nKOf8FBfQ9KPvrSmoworRlZ9jZ+EREKalj7RmCUGg+12gvO+Kz8OmKTqPxKDCEhRK4
         GlHqyJOzZXf3XHHWBNFvDKuQPO2ZL6ltay52IIctGgpB8PbiQcryGNPjij+UJ6Q0LZlc
         V6TKnxmfIGPQd4zs5TSEs99VjZhOgep/lyARwv3k5vuiYOtcC415KSCwnEzjWEteuGav
         4Z+ohFCXB+0NR5NttQbQrcYFRTu7nmIDeE4jVNkB7PxQVGGCKHmH5mIE7dPHiRzWFoZ8
         Dvb7DPR7sucMV8QhGjTJ4JTln6J838YrJPaWtgicGKGLbxfyJjUbHXoj0bO07hYmmxuB
         rhYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678838975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kzy0B/VYnSJRvZ8pGtdA2kQJazW5NtKMyoTehvrQmDw=;
        b=CseWKZpJgp61ZmDArIAyOFHHUaz8q7SOf9gRXktEETcITOYw7XSrn88fjp+uLWagN+
         ADba2DCNVcUKScFmyj9k3FCGjVDNldwVaaEsvKqwkdasnyW0WJBs8kQVXIQl3JsLIGBI
         qbPiDPejTvLzbSkNKWS7rd2DAWUxY4VCLoxw04/vYJEgWRYgD4S1va6akUjH0GKsKT21
         qOK4Im5RIIMpVuo67gTIvYZoLuesTv1vJcOyL2wflpePWYPLcR1jeTIxXdtV7/p7whhP
         clVnKdHOEcDJR84hsCCtKGGyMv4LIqkQiznunV7vdOA4V8EbZDBC2Wf6YkTZtF3RaVMb
         m4wg==
X-Gm-Message-State: AO0yUKVxlNGE0RGv5+4g7qXdk+lWZqONVHbfX5K/7pVpGp4OiWw0hoeB
        tx/Tvzv38cQPgOVDvhhXf0w=
X-Google-Smtp-Source: AK7set8TUYkpg5z/wkWn9Qm4PGh31BVMHTj0nRUVT2NCG7126FC8rPOANB99aIRkUDre4XDFPNTU8Q==
X-Received: by 2002:a05:6a20:9146:b0:9d:efbe:52ae with SMTP id x6-20020a056a20914600b0009defbe52aemr38231916pzc.30.1678838974492;
        Tue, 14 Mar 2023 17:09:34 -0700 (PDT)
Received: from localhost.localdomain ([14.139.38.154])
        by smtp.googlemail.com with ESMTPSA id z19-20020a634c13000000b00502f017657dsm2080157pga.83.2023.03.14.17.09.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Mar 2023 17:09:33 -0700 (PDT)
From:   Vijaya Anand <sunrockers8@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vijaya Anand <sunrockers8@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [RFC PATCH v2] ASoC: dt-bindings: adi,adau17x1: Convert to DT schema
Date:   Wed, 15 Mar 2023 05:39:14 +0530
Message-Id: <20230315000914.99083-1-sunrockers8@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the binding document for adi,adau17x1 from txt to yaml
so one could validate dt-entries correctly and any future additions
can go into yaml format. Add address and size cells to example to
prevent errors regarding reg format.

Signed-off-by: Vijaya Anand <sunrockers8@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>
---
Changes since v1:
- added 'Codec' in title to clarify type of devices
- put compatible devices in lexographic order
- changed description of clocks
- changed 'unevaluatedProperties' to 'additionalProperties'
- changed node names to be generic

---
 .../bindings/sound/adi,adau17x1.txt           | 32 ------------
 .../bindings/sound/adi,adau17x1.yaml          | 52 +++++++++++++++++++
 2 files changed, 52 insertions(+), 32 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/adi,adau17x1.txt
 create mode 100644 Documentation/devicetree/bindings/sound/adi,adau17x1.yaml

diff --git a/Documentation/devicetree/bindings/sound/adi,adau17x1.txt b/Documentation/devicetree/bindings/sound/adi,adau17x1.txt
deleted file mode 100644
index 1447dec28125..000000000000
--- a/Documentation/devicetree/bindings/sound/adi,adau17x1.txt
+++ /dev/null
@@ -1,32 +0,0 @@
-Analog Devices ADAU1361/ADAU1461/ADAU1761/ADAU1961/ADAU1381/ADAU1781
-
-Required properties:
-
- - compatible:		Should contain one of the following:
-			"adi,adau1361"
-			"adi,adau1461"
-			"adi,adau1761"
-			"adi,adau1961"
-			"adi,adau1381"
-			"adi,adau1781"
-
- - reg:			The i2c address. Value depends on the state of ADDR0
-			and ADDR1, as wired in hardware.
-
-Optional properties:
- - clock-names:		If provided must be "mclk".
- - clocks:		phandle + clock-specifiers for the clock that provides
-			the audio master clock for the device.
-
-Examples:
-#include <dt-bindings/sound/adau17x1.h>
-
-	i2c_bus {
-		adau1361@38 {
-			compatible = "adi,adau1761";
-			reg = <0x38>;
-
-			clock-names = "mclk";
-			clocks = <&audio_clock>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/sound/adi,adau17x1.yaml b/Documentation/devicetree/bindings/sound/adi,adau17x1.yaml
new file mode 100644
index 000000000000..8ef1e7f6ec91
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/adi,adau17x1.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/adi,adau17x1.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title:
+ Analog Devices ADAU1361/ADAU1461/ADAU1761/ADAU1961/ADAU1381/ADAU1781 Codec
+
+maintainers:
+  - Lars-Peter Clausen <lars@metafoo.de>
+
+properties:
+  compatible:
+    enum:
+      - adi,adau1361
+      - adi,adau1381
+      - adi,adau1461
+      - adi,adau1761
+      - adi,adau1781
+      - adi,adau1961
+
+  reg:
+    maxItems: 1
+    description:
+      The i2c address. Value depends on the state of ADDR0 and ADDR1,
+      as wired in hardware.
+
+  clock-names:
+    const: mclk
+
+  clocks:
+    items:
+      - description: provides the audio master clock for the device.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      audio-codec@38 {
+        compatible = "adi,adau1761";
+        reg = <0x38>;
+        clock-names = "mclk";
+        clocks = <&audio_clock>;
+      };
+    };
-- 
2.37.1 (Apple Git-137.1)

