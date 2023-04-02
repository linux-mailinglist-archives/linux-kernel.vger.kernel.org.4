Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 569FF6D3A58
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 22:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjDBU5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 16:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDBU5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 16:57:31 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A507AAF;
        Sun,  2 Apr 2023 13:57:30 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id l7so25365768pjg.5;
        Sun, 02 Apr 2023 13:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680469050;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AqjVyxFjsHfYI8wNbHm0tgaoQeMUAZNmLeUD+5ilnBM=;
        b=nUuCdSjR5ZVXYyusrAi/cdvM1ZxvzHXEfDx/sQ4rsjAc8TSL6NtT2/r0sdbc1zfnYA
         4YdISZYg+jJG27MCiCNMCPA1kVfoIub8jmscr0MpeuWgVv8L9LzFulvNm4uD7uyaTnoz
         Za91rqOEP8dH0A9EGYgguuXqloNAjmZMO4raBsUUDDOE7k3AH1jx/DIYNDk6x+tmtAxh
         /teBWAMbaM0wAT6sLVE+m7eM9ihToR184VYYCrExvSgbGZNpaHrxqN1OHiTRase998Ox
         q87JVx2hSyRC1VshOwYIynfDJTh+W5SnQObiEmVEhzDiy/19a8WRyBTtwJgZfyg+HzrT
         P3Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680469050;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AqjVyxFjsHfYI8wNbHm0tgaoQeMUAZNmLeUD+5ilnBM=;
        b=mcElJ2hbiL5QcfFPv2kOmd0nbPqbf1EuCJG9UohEfkkkhVYBAGl8qBK9lGHRW2NagP
         FSE/DlbMojEo1zDgNLqnP3VrHkFqMJ1fWQJnkPwpsfsFhx76La8wESQVrNr6aMWvbLnW
         I5XRXItiXC/QhWKcyOyzHhTFzsf7PoPiKOmPHNf7LAehFBL9JeDD9o/97hzE85hh2yCK
         EOSLYPp7wF3P2MZ2FneS3zMXS7tMI6sXcAHsWxdlf8uqLpxPFKc3qf12qtdqjtnEXeKf
         G/GCwrmofLaxriZSohXV8S25C3lWzT9XMh4u8QWUPjvhw4rLOfolf77tsoQ069ezUA0T
         jxJQ==
X-Gm-Message-State: AAQBX9cXoJ+fmZS8wLLSCIR6KMybr2k8q/bo9Stat51P60ZzSf3g7Tta
        tSizoFP2LuXF8+CH5ulc+KVRoookRGo/WuFo
X-Google-Smtp-Source: AKy350bHzLEUzxJyYl9lAgeYSOG3MiqiONzGRNTHZrmd6b2nP4rVyl4TN4Fwb0HU7ELRNis5ZGGBig==
X-Received: by 2002:a17:90b:4d83:b0:23f:9445:318e with SMTP id oj3-20020a17090b4d8300b0023f9445318emr16740564pjb.3.1680469049715;
        Sun, 02 Apr 2023 13:57:29 -0700 (PDT)
Received: from pavilion.. ([2409:40f2:100f:dc7:7586:11f6:6763:e4a6])
        by smtp.gmail.com with ESMTPSA id f11-20020a17090274cb00b001a065d3bb0esm5135611plt.211.2023.04.02.13.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Apr 2023 13:57:29 -0700 (PDT)
From:   Saalim Quadri <danascape@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Saalim Quadri <danascape@gmail.com>
Subject: [PATCH] ASoC: dt-bindings: wm8510: Convert to dtschema
Date:   Mon,  3 Apr 2023 02:27:19 +0530
Message-Id: <20230402205719.6728-1-danascape@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the WM8510 audio CODEC bindings to DT schema

Signed-off-by: Saalim Quadri <danascape@gmail.com>
---
 .../devicetree/bindings/sound/wlf,wm8510.yaml | 39 +++++++++++++++++++
 .../devicetree/bindings/sound/wm8510.txt      | 18 ---------
 2 files changed, 39 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8510.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/wm8510.txt

diff --git a/Documentation/devicetree/bindings/sound/wlf,wm8510.yaml b/Documentation/devicetree/bindings/sound/wlf,wm8510.yaml
new file mode 100644
index 000000000000..f45dad0fbef3
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/wlf,wm8510.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/wlf,wm8510.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: WM8510 audio CODEC
+
+description: |
+  These devices support both I2C and SPI (configured with pin strapping
+  on the board).
+
+maintainers:
+  - Mark Brown <broonie@kernel.org>
+
+properties:
+  compatible:
+    const: wlf,wm8510
+
+  reg:
+    description:
+      The I2C address of the device for I2C, the chip select number for SPI
+    maxItems: 1
+
+additionalProperties: false
+
+required:
+  - reg
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        codec@1a {
+            compatible = "wlf,wm8510";
+            reg = <0x1a>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/sound/wm8510.txt b/Documentation/devicetree/bindings/sound/wm8510.txt
deleted file mode 100644
index e6b6cc041f89..000000000000
--- a/Documentation/devicetree/bindings/sound/wm8510.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-WM8510 audio CODEC
-
-This device supports both I2C and SPI (configured with pin strapping
-on the board).
-
-Required properties:
-
-  - compatible : "wlf,wm8510"
-
-  - reg : the I2C address of the device for I2C, the chip select
-          number for SPI.
-
-Example:
-
-wm8510: codec@1a {
-	compatible = "wlf,wm8510";
-	reg = <0x1a>;
-};
-- 
2.34.1

