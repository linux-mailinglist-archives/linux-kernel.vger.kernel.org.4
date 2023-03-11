Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5DC36B6062
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 21:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjCKUDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 15:03:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjCKUDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 15:03:39 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D22D59C9;
        Sat, 11 Mar 2023 12:03:34 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id y15-20020a17090aa40f00b00237ad8ee3a0so8150888pjp.2;
        Sat, 11 Mar 2023 12:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678565014;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tn6uanZ75/AtO/6uD8tRhIGr3tlvAld8WET0HuG22qg=;
        b=NyLgIqHF0KgRhHyBW2b5aIoxWf34dCTp9KdqnU2+NiZaod/2dLsG90LERd9bUfKa7q
         pO27w98ompOHqzXAbzrbdho5DoJQi2429JNNLIgqC3d7bMxp/vckTp4AQtgaZf7xLT/d
         egVPApFRevYJrtlTUWSXZp+dF5FG61LgbGQ8PKyL3IcmlW9lDMygIp5efDMTrK7bi0J1
         JS8IByg428W8ROmO2OK52dhTY1qnvfPcDcw8bLXCwVGK5Guydonynq9O2BY4zBvWZ2A/
         73nMxjGfaw+ihvbMu0JxczIX1PI6nazeWuLWBGTnyl5g5d2yDJT6NPE5ak2HKeDkv0C6
         4I0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678565014;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tn6uanZ75/AtO/6uD8tRhIGr3tlvAld8WET0HuG22qg=;
        b=iNzH4aF3MWO0DIhi+Ed6yeUqNd+bVE9kaNIvxHmmCTRsyfEJ72LBdWQlg9roxLWeVV
         8byvPxR/nuqXPCbYo5QAWLKyTRdYY6IBT3kql4erI430SX9zMv3FAsAybchcR/Ufiqo4
         ZMCpXRihOvhfUDXJ38qCpL8OCG3GWZgSu6iu5w9XMfwOeGkVEhX1VI5LFPIo/eb3FbzD
         nsCKssFPFUMeT9bfZcpOaLWEj4z7BKBSckt44HyGLbeVuCa/iy3FPURUCPEPjFQsg+xi
         XPU6nvzxvesNmkeGJShWX/SHRi0i97/RbfDCc4BVbCyj3kj1gUH8CXDO+WYrNvVj0gPZ
         7y1Q==
X-Gm-Message-State: AO0yUKXLhh73/+I3Vzz/m6DzYFBXmZu+J91nZdOr3F5mmzVPfBlneALZ
        OzC7BYewaNf7wGpv9IKMDxQ=
X-Google-Smtp-Source: AK7set8lSKverypePwj+U3/vR/Fs/55zW0LXDGO+Xec2AdRSTGZx79cHgSY2He2AMzAHzV66Y5+JNA==
X-Received: by 2002:a17:90b:3ec9:b0:237:ae7c:15b9 with SMTP id rm9-20020a17090b3ec900b00237ae7c15b9mr30737682pjb.36.1678565013918;
        Sat, 11 Mar 2023 12:03:33 -0800 (PST)
Received: from localhost.localdomain ([49.43.248.22])
        by smtp.googlemail.com with ESMTPSA id n13-20020a17090a928d00b002341c0ff245sm1879787pjo.19.2023.03.11.12.03.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 11 Mar 2023 12:03:33 -0800 (PST)
From:   Vijaya Anand <sunrockers8@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vijaya Anand <sunrockers8@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [RFC PATCH] ASoC: dt-bindings: adi,adau17x1: Convert to DT schema
Date:   Sun, 12 Mar 2023 01:33:05 +0530
Message-Id: <20230311200305.82087-1-sunrockers8@gmail.com>
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
index 000000000000..9c1dbf2b4e70
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/adi,adau17x1.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/adi,adau17x1.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices ADAU1361/ADAU1461/ADAU1761/ADAU1961/ADAU1381/ADAU1781
+
+maintainers:
+  - Lars-Peter Clausen <lars@metafoo.de>
+
+properties:
+  compatible:
+    enum:
+      - adi,adau1361
+      - adi,adau1461
+      - adi,adau1761
+      - adi,adau1961
+      - adi,adau1381
+      - adi,adau1781
+
+  reg:
+    maxItems: 1
+    description: The i2c address. Value depends on the state of ADDR0 and ADDR1, as wired in hardware.
+
+  clock-names:
+    const: mclk
+
+  clocks:
+    maxItems: 1
+    description:
+      phandle + clock-specifiers for the clock that provides the audio master
+      clock for the device.
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c_bus {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      adau1361@38 {
+        compatible = "adi,adau1761";
+        reg = <0x38>;
+        clock-names = "mclk";
+        clocks = <&audio_clock>;
+      };
+    };
-- 
2.37.1 (Apple Git-137.1)

