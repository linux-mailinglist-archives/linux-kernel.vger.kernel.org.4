Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446556BC0A9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 00:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbjCOXLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 19:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjCOXLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 19:11:19 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFAD196AF;
        Wed, 15 Mar 2023 16:11:17 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id d13so3746pjh.0;
        Wed, 15 Mar 2023 16:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678921877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kzy0B/VYnSJRvZ8pGtdA2kQJazW5NtKMyoTehvrQmDw=;
        b=kSOKXaLA2XOfIn6OLaCrF7ohz5hyFI9gZZMaZu62+ifKfKT+mpEtUk7LbMNO8nsoda
         zZ4dpu2h1nnINsgPWb6laXAilEFF4M+hvfyO0USrhjhjkol45xsvEzR7qw631mk+Vjt5
         NKRRMTEsF1jZxH90kXSw9eN7SeegJWB/zU3SoTZGfTOA8l8s7tu2A22/rjj/d/ya7BF2
         2s4FTetw1dgkoqGLk1Dux1vanxLFT0mAm0J3lCY+hPmGC0BWhadUDpB0fz+zjNZrgG0p
         /FIqa6uw7NN0ka16S1u1YlHXWNiz+0aEheoFLWxwqXjqTWD30JZ/K+mT6lXXOhtWb/Qy
         2K5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678921877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kzy0B/VYnSJRvZ8pGtdA2kQJazW5NtKMyoTehvrQmDw=;
        b=o0vdKuohchOqlIiEQSOCBY7/DzvOJudFFwjtgVm+rZ9J3o5bMQrB/y0ZzcHQ0FIHny
         RJrCm5K/YnC7tcucxOctvp33jARxbvOmhMJE275AKnqx0HGrFupxXnmPyONekaEISv8k
         soYIPNfLnV+Hg505bWtX9YKpoDD3xT5UR5o2zxYtFZ79xYqeadNmOqymmg4/gp9CTOyb
         77eImC/vRIN9NBPlEn+9+Ldn/g7TFYunEZLkk2P3pw+UT993ZGVfUskQSfII6s4VK74D
         WGu/yUy5YB7qNexooVz5ODFwUZx9fMvgKC9kW6epOcsELWss5t6RDsDSq+9oG2NjF6fQ
         MUjw==
X-Gm-Message-State: AO0yUKV4est7cOLFdtFOk1pP8YT5emLd/k/q3eBpAEH0Gwc0Nc0UkVeI
        rVRFXKwoODSMjeeOZhe3eqI=
X-Google-Smtp-Source: AK7set9wsbdkZ1LjU01R5iAlOExPzKZm3vwKjuDjqLuZR0UayRfcjyyy0SFPQvHT2QRZ2N2EQDGl1w==
X-Received: by 2002:a05:6a20:8e2a:b0:cb:f76c:e1a8 with SMTP id y42-20020a056a208e2a00b000cbf76ce1a8mr1604364pzj.15.1678921877048;
        Wed, 15 Mar 2023 16:11:17 -0700 (PDT)
Received: from localhost.localdomain ([14.139.38.154])
        by smtp.googlemail.com with ESMTPSA id m123-20020a632681000000b0050bebfe464dsm212616pgm.53.2023.03.15.16.11.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 15 Mar 2023 16:11:16 -0700 (PDT)
From:   Vijaya Anand <sunrockers8@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vijaya Anand <sunrockers8@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v2] ASoC: dt-bindings: adi,adau17x1: Convert to DT schema
Date:   Thu, 16 Mar 2023 04:40:55 +0530
Message-Id: <20230315231055.3067-1-sunrockers8@gmail.com>
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

