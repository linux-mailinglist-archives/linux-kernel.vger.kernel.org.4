Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D727E6D88A5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 22:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbjDEUea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 16:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbjDEUe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 16:34:28 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403D14C1F;
        Wed,  5 Apr 2023 13:34:27 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id x15so35215797pjk.2;
        Wed, 05 Apr 2023 13:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680726867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5mBL1QQnDIB+z3BztabybEP4t58oo66sKusUL7l71Y8=;
        b=elPcmQmDFHSPWnjoT9RNRUFGZ/sLF7ZJrBubJS73mov6OMm0GsE1UVhCuly7fsIVm8
         tRBnetr1WyeXNIO48vO0lqssIoZO4KBY1QWM7kUtju3kuvI41M0ajNLUdO+nvZaVa13h
         58+fKsDHQwOAMyECkfLZuju9GxmHYkNyAmWNMGvUn2dOW+ERke85+NEgOtZL0D/H1YQ3
         bivEuONqfOpNzY58iJQDAijlL/7s14pLFS9gz/SXXFWGV78Wiq9zyyYBJae8EvUog+Zs
         LcJvLQAfFl790WqHH6ZMkZq/OvhpkDtO1w8I/+5frxZcAsjeHtRFGKVSw3XJhNPIuV0h
         NsrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680726867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5mBL1QQnDIB+z3BztabybEP4t58oo66sKusUL7l71Y8=;
        b=A34Nx6K+NVRFcCo5NAotghrvpde0SnQb4B/EIhEIkfoPNS2NwCUJcaW0E9ubVtsrra
         ufjaU+uwY2xHuEPlw8OuGvi5MPb6/+5qAjyP9aIdtR7CG8MXWW5L5PUqkTv6ypGBmXNh
         ZgEI3zDi/4N6geAW9QJgGbEGR0ZvwhEmKMwmL0P3LOnEPmLVuFSGOZ5/AGj5psFn3Rl0
         WQDu+OmH0ehAzs6kFvxoOqpZ8q80r++qby3y0jvWPufSwAOzeZQ86cnVRt6URja8bX+t
         oXr7Edlz2gg3/32ezUJX+1fvE9yq7djMe2fXPqwE846wNOuZC+6kxyqiivZE7H9Qpixw
         IFGA==
X-Gm-Message-State: AAQBX9ci4FFtck1YeXXUwLqGIQAsFqw3TyFsQyLJKTWtSvL3V0aL1rGW
        9a//lj/PmRxvwf3X8f+dtrA=
X-Google-Smtp-Source: AKy350bv/hdrI3VH3BZ76HsUrGFyINmMANwgoAFIha+oi0e7kf0Gs26sQEsMYyx1+5svRIP8E9LUWQ==
X-Received: by 2002:a17:90b:4c0b:b0:234:1a60:a6b0 with SMTP id na11-20020a17090b4c0b00b002341a60a6b0mr7935298pjb.34.1680726866522;
        Wed, 05 Apr 2023 13:34:26 -0700 (PDT)
Received: from pavilion.. ([2402:e280:218d:82:616c:b78a:a01f:5113])
        by smtp.gmail.com with ESMTPSA id c12-20020a17090ab28c00b002340d317f3esm1769231pjr.52.2023.04.05.13.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 13:34:26 -0700 (PDT)
From:   Saalim Quadri <danascape@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, daniel.baluta@nxp.com
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Saalim Quadri <danascape@gmail.com>
Subject: [PATCH] ASoC: dt-bindings: wm8523: Convert to dtschema
Date:   Thu,  6 Apr 2023 02:04:19 +0530
Message-Id: <20230405203419.5621-1-danascape@gmail.com>
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

Convert the WM8523 audio CODEC bindings to DT schema

Signed-off-by: Saalim Quadri <danascape@gmail.com>
---
 .../devicetree/bindings/sound/wlf,wm8523.yaml | 40 +++++++++++++++++++
 .../devicetree/bindings/sound/wm8523.txt      | 16 --------
 2 files changed, 40 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8523.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/wm8523.txt

diff --git a/Documentation/devicetree/bindings/sound/wlf,wm8523.yaml b/Documentation/devicetree/bindings/sound/wlf,wm8523.yaml
new file mode 100644
index 000000000000..decc395bb873
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/wlf,wm8523.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/wlf,wm8523.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: WM8523 audio CODEC
+
+maintainers:
+  - patches@opensource.cirrus.com
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    const: wlf,wm8523
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
+            compatible = "wlf,wm8523";
+            reg = <0x1a>;
+        };
+    };        
diff --git a/Documentation/devicetree/bindings/sound/wm8523.txt b/Documentation/devicetree/bindings/sound/wm8523.txt
deleted file mode 100644
index f3a6485f4b8a..000000000000
--- a/Documentation/devicetree/bindings/sound/wm8523.txt
+++ /dev/null
@@ -1,16 +0,0 @@
-WM8523 audio CODEC
-
-This device supports I2C only.
-
-Required properties:
-
-  - compatible : "wlf,wm8523"
-
-  - reg : the I2C address of the device.
-
-Example:
-
-wm8523: codec@1a {
-	compatible = "wlf,wm8523";
-	reg = <0x1a>;
-};
-- 
2.34.1

