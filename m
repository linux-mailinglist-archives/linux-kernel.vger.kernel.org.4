Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70BB66D4295
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 12:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjDCKxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 06:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbjDCKwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 06:52:55 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482757ED8;
        Mon,  3 Apr 2023 03:52:54 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id u10so27588062plz.7;
        Mon, 03 Apr 2023 03:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680519174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CjHdMf5pmc+VnOq5rbReP1B7/Pwn++54UQQr+szUSWc=;
        b=N46ym3KmbP15CNVB1tEhbGBxxsceIvYRTyde8BixGqsGzruAP3aNxDHpoebiQH9wad
         zbbk6rYfZCrq0gT9XW+rF36oZYcz07BZyWfoeSyj1kkyb23vd0jBOOlSE773L4q5doKx
         Y4lFsrfp5G3UzOn9ByEhp5CaIcyrQEkOZsX9XwOaxKUBiVmruOy3VLesauDtXo62bDNu
         0U5xd1Ocp7FJmrkJvZynoydQCmRV9XFtDJhl/+xmjCEiZG1MY1vASnlRtbk5SRgxtFQe
         Y1zHmaCK4p1Fmwui2dLoTSrq9FWyoNRzfzFqjdaQTYOZYvqnf9ooY9h0R1Nnqpqf6kvu
         o2Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680519174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CjHdMf5pmc+VnOq5rbReP1B7/Pwn++54UQQr+szUSWc=;
        b=kynyPuZBCOZkU7m/uFw0nBXqHZ1Dl67MKdF0zpcNmOaWJx1BRmM0YDMGpcRTt/ojii
         aCkxf/yUCbrXGe8bBihdEMpaFQm6+970Yz5e3okGdSeHXsCPCFFPUvKCNpQXJZ+RNVdg
         NOgmLnlX8MJUGHtEIjCzIKtI2RFtDjY5nMj4VIgIsAjO0HOnHyxwHPI52mbPs+GZto9l
         5XdEAQtcH6OK3a9IIZm6qXP0oX2ie14fKe5OAZvOowCF/gmps465Sd26mckPQ3OSaaeE
         Y79p5UGzc8mL/mwlBV2MYJCSCzbaU4p0qvJ9Hl/UBlLwpixJF6Nfzh4Y0En7eLi8zSMW
         lpIQ==
X-Gm-Message-State: AAQBX9ch8UgLLijZBN2JWJijrdpRZcl4kfuIkqBCXa4FsqkW7wZJ/OLd
        Wyt1eX1/+A7oqTGIQaiRj/A=
X-Google-Smtp-Source: AKy350YvdEdEdbgS7UVH6gaz7BWar8qebb1CN+RG5zbgI0OjvDNbVafRz8qmSEdwk+P5kNiWRpdu9Q==
X-Received: by 2002:a17:90b:4c8b:b0:240:c25:210 with SMTP id my11-20020a17090b4c8b00b002400c250210mr39814675pjb.44.1680519173681;
        Mon, 03 Apr 2023 03:52:53 -0700 (PDT)
Received: from pavilion.. ([2409:40f2:100f:dc7:7de5:f2e3:4932:541])
        by smtp.gmail.com with ESMTPSA id jf2-20020a170903268200b001a27e5ee634sm6325182plb.33.2023.04.03.03.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 03:52:53 -0700 (PDT)
From:   Saalim Quadri <danascape@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, daniel.baluta@nxp.com
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Saalim Quadri <danascape@gmail.com>
Subject: [PATCH v2] ASoC: dt-bindings: wm8510: Convert to dtschema
Date:   Mon,  3 Apr 2023 16:22:37 +0530
Message-Id: <20230403105237.3854-1-danascape@gmail.com>
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
Changes:
V1 - V2: Fixup issues mentioned by Krzysztof
         Add SPI and I2C examples

 .../devicetree/bindings/sound/wlf,wm8510.yaml | 52 +++++++++++++++++++
 .../devicetree/bindings/sound/wm8510.txt      | 18 -------
 2 files changed, 52 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8510.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/wm8510.txt

diff --git a/Documentation/devicetree/bindings/sound/wlf,wm8510.yaml b/Documentation/devicetree/bindings/sound/wlf,wm8510.yaml
new file mode 100644
index 000000000000..418a82f65531
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/wlf,wm8510.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/wlf,wm8510.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: WM8510 audio CODEC
+
+maintainers:
+  - patches@opensource.cirrus.com
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    const: wlf,wm8510
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
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        
+        codec@0 {
+            compatible = "wlf,wm8510";
+            reg = <0>;
+        };
+    };
+
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
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

