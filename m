Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7696D8914
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 22:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjDEUuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 16:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDEUuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 16:50:35 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25C6CD;
        Wed,  5 Apr 2023 13:50:34 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id e15-20020a17090ac20f00b0023d1b009f52so40781074pjt.2;
        Wed, 05 Apr 2023 13:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680727834;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RKzNCLVl42oXEDNGT8TsESnDpIsZTaCWPqislM2wAtI=;
        b=hxEM/qI4QHMC2jKXgsn0s21vyMD1Io+s5SE6tOIdKgfNYoPyz2Xkfq8xPJODLi5xt2
         BNErNUaDdxAPZ7zaWCjJV1ct4ph1C3pfHMugBN0dRKDPlkEB0Xh95ToT5RnzkjaTTrfq
         KJnlGl7An0mGYZ6fj7cegMLC4wAJjACoK9tUpi+Vxjaa+l8DzOAepCSJHPCNEK3xNLyl
         JpODtvd79KchlQc160KgNCIB5JZeb/3uylAJnv2W0MMkw9qVM+w4XikbJlFCCJ13DRqI
         zbdCHhU9Wavbqj/AY4e72OMafn0yixx7FKkjTGNiQh59ruILbzzpleVul6faXEyRCxLh
         HjGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680727834;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RKzNCLVl42oXEDNGT8TsESnDpIsZTaCWPqislM2wAtI=;
        b=RTQvxhjhZ6SfM0H7TKcPE5IlPC2mw83t9cgH4gLFcdFxGyxJqLMNnnyTZpubjHDdqw
         h6/NHNksDAnPvUHUVMC5wpiTL7pV91B1z+6NPKTVcSu2qLVIR4D28/JFdnoWPgXla0ke
         8NiKpJLFEJvfQKBLkSe2zpxo6gSFQ7XcNhsy5YUaXDO9PRFCT9SpNPL4VHqd+QrgGBQK
         YxzRf2rvqmjux2JCI/V7pI07Ii0fr93K0FJHlZc/xbWjJkqM0g8xkio07pkV+cZWDQwj
         4mp8bgOj2z7AKY+Lz3Hh95NZuvqkBqXwPtsBiKFWPz39fcabFF80cGE9HD721Ws1/4ip
         ZhzQ==
X-Gm-Message-State: AAQBX9cOg+ZI6X5YEXals0ztydxK13DPgyDfSkR41KcwE7qVgQYZcJnV
        bwPkCthJPAccrxMNKIhwTJI=
X-Google-Smtp-Source: AKy350ZQjITByRIh6laCMZtN0D4PEu5si/p7iyC3zWOWJmAU0uCqGQIZmlDCQQfFDVIkWo4Gz74rfA==
X-Received: by 2002:a17:902:d1d5:b0:1a3:d5af:9b6f with SMTP id g21-20020a170902d1d500b001a3d5af9b6fmr5296025plb.19.1680727833997;
        Wed, 05 Apr 2023 13:50:33 -0700 (PDT)
Received: from pavilion.. ([2402:e280:218d:82:616c:b78a:a01f:5113])
        by smtp.gmail.com with ESMTPSA id w9-20020a170902a70900b001a260b5319bsm10577676plq.91.2023.04.05.13.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 13:50:33 -0700 (PDT)
From:   Saalim Quadri <danascape@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, daniel.baluta@nxp.com
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Saalim Quadri <danascape@gmail.com>
Subject: [PATCH] ASoC: dt-bindings: wm8580: Convert to dtschema
Date:   Thu,  6 Apr 2023 02:20:25 +0530
Message-Id: <20230405205025.6448-1-danascape@gmail.com>
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

Convert the WM8580 and WM8581 audio CODEC bindings to DT schema

Signed-off-by: Saalim Quadri <danascape@gmail.com>
---
 .../devicetree/bindings/sound/wlf,wm8580.yaml | 42 +++++++++++++++++++
 .../devicetree/bindings/sound/wm8580.txt      | 16 -------
 2 files changed, 42 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8580.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/wm8580.txt

diff --git a/Documentation/devicetree/bindings/sound/wlf,wm8580.yaml b/Documentation/devicetree/bindings/sound/wlf,wm8580.yaml
new file mode 100644
index 000000000000..2f27852cdc20
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/wlf,wm8580.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/wlf,wm8580.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: WM8580 and WM8581 audio CODEC
+
+maintainers:
+  - patches@opensource.cirrus.com
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - wlf,wm8580
+      - wlf,wm8581
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
+            compatible = "wlf,wm8580";
+            reg = <0x1a>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/sound/wm8580.txt b/Documentation/devicetree/bindings/sound/wm8580.txt
deleted file mode 100644
index ff3f9f5f2111..000000000000
--- a/Documentation/devicetree/bindings/sound/wm8580.txt
+++ /dev/null
@@ -1,16 +0,0 @@
-WM8580 and WM8581 audio CODEC
-
-This device supports I2C only.
-
-Required properties:
-
-  - compatible : "wlf,wm8580", "wlf,wm8581"
-
-  - reg : the I2C address of the device.
-
-Example:
-
-wm8580: codec@1a {
-	compatible = "wlf,wm8580";
-	reg = <0x1a>;
-};
-- 
2.34.1

