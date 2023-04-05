Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C941C6D8925
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 22:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbjDEU63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 16:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjDEU61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 16:58:27 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3CD40C4;
        Wed,  5 Apr 2023 13:58:26 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id iw3so35589433plb.6;
        Wed, 05 Apr 2023 13:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680728306;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3KJ3KXGfgJ4sZPfoaU/5WSm7YH1plpzja1cFXFVy8AQ=;
        b=Ox2POTwE6E8YfRjtE83SQvzsttCEDutLPrnoq/iyXi40fkEB8rLTPmhThCDh3+XY5L
         3vDYVbAU623ZwlR7qt+veiwxSfk1IXV01x7NTWk/se66jKmAh/ule0YUfUBUalWhakNY
         FUEyznRnuPts/VUim3SVVk7uAndY3x8k8I02x0LSnFY3g2iAwkVslP9m2NSjsGrCXAUP
         wA2kKFDvA6WIaKiTJgYN0uoYi9L3tELolNrghfGvloC9F0+AH7DvynJk9T2st1SVGFGO
         U0DJcd1nW3PFivJ509LzSVfJ+jPPVY41HzN4jzKWNxIgsf1nBUzJONyHNhJme8hWc9VD
         Ijvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680728306;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3KJ3KXGfgJ4sZPfoaU/5WSm7YH1plpzja1cFXFVy8AQ=;
        b=XtvSF0tRl+0jpX80Sr87OMKJT90TAiQDxLICKGAas5GQKdXxT7AQW22JDkP/hGpPLo
         GsYrvNeqyISf6R4R0sovaTPDn55n/WKV7nBi9DWX0RGKPYfjXR15ABQ9ZEALhOvRzOGt
         FV6yWIhyh5EGyKuSEzcosJn9souOke66knn79Wal1MTUoEUs/Vd3mf+O00TD+8CssebL
         IKKz6QGMH3jJTbdfwXYVpLGtVpq0y1LEF1/ZGxRWF5SdF1kxsVsyTDJq7eQ9MDiKZeDS
         40+NGKvo5qaCZ5L+6l1/p6A7iRZ6CiaRZ3j3FbVAot8E/M+4BuXBBPPSg/pLYbnMjtXa
         CAXQ==
X-Gm-Message-State: AAQBX9fT2BBzFdOoGz5zkoKLZcNtnW/GDm9P6gTU9Y7fvFHWFkQvFhCs
        jBNezEr/CTaO2BpBar/ag38=
X-Google-Smtp-Source: AKy350aFUDEYE/VwNdXenQbCHuZrtNSCabv8bc99zIl5dBsqrPyqPEiiTzSv5hPYdSGT3mhKIJVmPg==
X-Received: by 2002:a17:90b:1c83:b0:240:3dc7:4939 with SMTP id oo3-20020a17090b1c8300b002403dc74939mr8839876pjb.27.1680728306098;
        Wed, 05 Apr 2023 13:58:26 -0700 (PDT)
Received: from pavilion.. ([2402:e280:218d:82:616c:b78a:a01f:5113])
        by smtp.gmail.com with ESMTPSA id b3-20020a655783000000b0050b026c444fsm9490025pgr.62.2023.04.05.13.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 13:58:25 -0700 (PDT)
From:   Saalim Quadri <danascape@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, daniel.baluta@nxp.com
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Saalim Quadri <danascape@gmail.com>
Subject: [PATCH] ASoC: dt-bindings: wm8711: Convert to dtschema
Date:   Thu,  6 Apr 2023 02:28:20 +0530
Message-Id: <20230405205820.6836-1-danascape@gmail.com>
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

Convert the WM8711 audio CODEC bindings to DT schema

Signed-off-by: Saalim Quadri <danascape@gmail.com>
---
 .../devicetree/bindings/sound/wlf,wm8711.yaml | 40 +++++++++++++++++++
 .../devicetree/bindings/sound/wm8711.txt      | 18 ---------
 2 files changed, 40 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8711.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/wm8711.txt

diff --git a/Documentation/devicetree/bindings/sound/wlf,wm8711.yaml b/Documentation/devicetree/bindings/sound/wlf,wm8711.yaml
new file mode 100644
index 000000000000..ecaac2818b44
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/wlf,wm8711.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/wlf,wm8711.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: WM8711 audio CODEC
+
+maintainers:
+  - patches@opensource.cirrus.com
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    const: wlf,wm8711
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
+            compatible = "wlf,wm8711";
+            reg = <0x1a>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/sound/wm8711.txt b/Documentation/devicetree/bindings/sound/wm8711.txt
deleted file mode 100644
index c30a1387c4bf..000000000000
--- a/Documentation/devicetree/bindings/sound/wm8711.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-WM8711 audio CODEC
-
-This device supports both I2C and SPI (configured with pin strapping
-on the board).
-
-Required properties:
-
-  - compatible : "wlf,wm8711"
-
-  - reg : the I2C address of the device for I2C, the chip select
-          number for SPI.
-
-Example:
-
-wm8711: codec@1a {
-	compatible = "wlf,wm8711";
-	reg = <0x1a>;
-};
-- 
2.34.1

