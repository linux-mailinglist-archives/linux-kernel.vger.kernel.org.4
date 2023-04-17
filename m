Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC406E5200
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 22:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjDQUnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 16:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjDQUnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 16:43:41 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44EC4422E;
        Mon, 17 Apr 2023 13:43:40 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5144a9c11c7so2018571a12.2;
        Mon, 17 Apr 2023 13:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681764220; x=1684356220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0D8fVQxMh2FytECOWBOGS25wxqSLBJ+NNK2BQrzIi0o=;
        b=Ovsw61+/H1VzeZJwEvaeiN2rtY9+4CGQ97C3CXw57wyz4X3sGBZSw4h/rpIFulq7nn
         HE9XwCw79oVevtF5Ckuw+PvXxdZ6QI1fus7xzyW/+6kfXOqNl8ltuKpZr3h2eHM8ESyF
         NpcC52hW0bk5GrYGbuIX07KdMIsJ/N84j+SzdOyqS6EHjX1OF3QffdlBovpLUI9hpqbT
         OZJppBBbR40xKayueq3IPwdEg3DgDyzCSQXCoJrvR39xueqfrsynhIFlZxrDam4Cv3iz
         +ZsC8D0yhSHT7ETYy9GhWzOPulqpr1T985vZfikHihLdR4XQl2KeDUWF21mhG3c43g2+
         BwUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681764220; x=1684356220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0D8fVQxMh2FytECOWBOGS25wxqSLBJ+NNK2BQrzIi0o=;
        b=QjrUewghmZ9ATFHjpyDtJKsZokwW8uVNEH1yKnGl38NGVG0qtrxykZ1p/Ok+O7B92K
         tnxemKHCaSK2qm7rpZNAFXEcmTBBDwRkcKLdy3drMbEEdAz5XubSj2L5Md60n/62MNiJ
         u2RyWCs/p9I35E1fL3WZzcXECUY4+jTU9J/bfpKcN6iSqgeCVkRtZuo5csN82epZ6Cay
         r8bahsgF+3K8OVl/uiDDGoXTTrVBkBt7S1v+u0f0C0Fn41wLx5XLayXimyj71ts+NxGd
         kZOSH1HVneqQvzk+OkBPUWy2nKB+T1N5IYm0aBEq18ELQY/wH39lrG+gbyqlOOcOp5V9
         3Xdg==
X-Gm-Message-State: AAQBX9e3Mjv1i3a6fNAmWzWJykT2UAG2ey34kWNOJf369MylZv/cb1al
        MFeDIXZ/lscFy/KLwCDQ0kmCxl3172WvtA==
X-Google-Smtp-Source: AKy350ZEPlPFvNP14bOLRitENDFtYaBMlc5g7zDZRvZSbWac/MAqQ3aSClp6qBRk07miCaf4k7I38A==
X-Received: by 2002:a05:6a00:890:b0:63a:fae3:9890 with SMTP id q16-20020a056a00089000b0063afae39890mr22888001pfj.24.1681764219582;
        Mon, 17 Apr 2023 13:43:39 -0700 (PDT)
Received: from localhost.localdomain ([2402:e280:218d:82:ae97:7cb6:b12a:54f5])
        by smtp.gmail.com with ESMTPSA id a2-20020aa78642000000b00632bb373949sm7956126pfo.158.2023.04.17.13.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 13:43:39 -0700 (PDT)
From:   Saalim Quadri <danascape@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, daniel.baluta@gmail.com
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Saalim Quadri <danascape@gmail.com>
Subject: [PATCH] ASoC: dt-bindings: wm8728: Convert to dtschema
Date:   Mon, 17 Apr 2023 20:43:23 +0000
Message-Id: <20230417204323.137681-1-danascape@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the WM8728 audio CODEC bindings to DT schema

Signed-off-by: Saalim Quadri <danascape@gmail.com>
---
 .../devicetree/bindings/sound/wlf,wm8728.yaml | 40 +++++++++++++++++++
 .../devicetree/bindings/sound/wm8728.txt      | 18 ---------
 2 files changed, 40 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8728.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/wm8728.txt

diff --git a/Documentation/devicetree/bindings/sound/wlf,wm8728.yaml b/Documentation/devicetree/bindings/sound/wlf,wm8728.yaml
new file mode 100644
index 000000000000..fc89475a051e
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/wlf,wm8728.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/wlf,wm8728.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: WM8728 audio CODEC
+
+maintainers:
+  - patches@opensource.cirrus.com
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    const: wlf,wm8728
+
+  reg:
+    maxItems: 1
+
+  "#sound-dai-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        codec@1a {
+            compatible = "wlf,wm8728";
+            reg = <0x1a>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/sound/wm8728.txt b/Documentation/devicetree/bindings/sound/wm8728.txt
deleted file mode 100644
index a3608b4c78b9..000000000000
--- a/Documentation/devicetree/bindings/sound/wm8728.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-WM8728 audio CODEC
-
-This device supports both I2C and SPI (configured with pin strapping
-on the board).
-
-Required properties:
-
-  - compatible : "wlf,wm8728"
-
-  - reg : the I2C address of the device for I2C, the chip select
-          number for SPI.
-
-Example:
-
-wm8728: codec@1a {
-	compatible = "wlf,wm8728";
-	reg = <0x1a>;
-};
-- 
2.40.0

