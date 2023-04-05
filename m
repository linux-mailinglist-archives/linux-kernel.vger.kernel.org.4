Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F4C6D7AF4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 13:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237832AbjDELQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 07:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237843AbjDELQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 07:16:35 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FEF559D2;
        Wed,  5 Apr 2023 04:16:13 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id lr16-20020a17090b4b9000b0023f187954acso36902543pjb.2;
        Wed, 05 Apr 2023 04:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680693373;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n6OXfkDuf3MCgikRaPSbB/O12A7AoKBBWB7PbjMP2MY=;
        b=BBxYrUNNDMwp7+Tqeh1bO3vHzynEz0eJ2RXoNzmmg3eCVXIsCV2koZKaVJlb0ZUxyU
         W+zimIXyQ8DMibtueC8dVquK0OfEfjc5BsTUgacp2ZH10gtZyKFPAqKlE+xXaHGMk/2D
         Dr5frSOdrwTuaD6UtKlR+uHhqQcWHNWqsLNWz+fh9tNXLT2FZWGu97t1LqTSnjw7xAEs
         6/ccGh/xEYnxn3xnLSoY6ncqOhRrTLX/p0gzqxo0jIPJwn406x8mvTC4kvp9x/3B64gN
         eDPiGll1tt195UBvZu8/5qG7W7xlLj4O3pXWci2QbSE0HNiLETQnnomISHYZh/N4Mj5N
         mqMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680693373;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n6OXfkDuf3MCgikRaPSbB/O12A7AoKBBWB7PbjMP2MY=;
        b=nPmTQPbOoLypFb8wbeYIo1U7eilLJiqe6fa2+SyiQizVpSf/FFY4Tc1gJn/jeWx5Dj
         TnT0oKojWDHi7cXUSyCRMz6nnhzrMQk50RRiFzbqETM1SBEApGgymfDnznHThNQASQwz
         papE4hUCksU27uD5eFSAjASdibgbgHTWySsi8XkFHSo3UTJCEpRn+2IhanRs7tu64wQr
         uPpo3yYxQZXwbxSBVcx+KcH84lvd26OfzfDsAx2aWWWIbFuSFC7jybYLVA6XpOmp3eeS
         +ucxsUWQ9YlyNIf43P7MrE8zw3uWChXxaxCGcAqmkI8ZM7OUkmx7AlR9HS8yaBoU3lXS
         /eQA==
X-Gm-Message-State: AAQBX9eYK1EBpkbs9OWsn2cM3VxmWZ6e4/U4cm/17TUmMGu13PHAta4k
        2x9fUrPpnX8U4PLfdiZWV1E=
X-Google-Smtp-Source: AKy350YYBD6yGza/LzBE2u0U8/bo6+93p5WXzhhL3ABjKqpdFYKYX6wXfdST+neNSVrpJjOlP2hRqw==
X-Received: by 2002:a17:902:d491:b0:1a1:d70f:712d with SMTP id c17-20020a170902d49100b001a1d70f712dmr7139789plg.31.1680693372699;
        Wed, 05 Apr 2023 04:16:12 -0700 (PDT)
Received: from pavilion.. ([2402:e280:218d:82:89c2:2f77:b4c8:3f7c])
        by smtp.gmail.com with ESMTPSA id ix12-20020a170902f80c00b001960706141fsm9931144plb.149.2023.04.05.04.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 04:16:12 -0700 (PDT)
From:   Saalim Quadri <danascape@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, daniel.baluta@nxp.com
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Saalim Quadri <danascape@gmail.com>
Subject: [PATCH v3] ASoC: dt-bindings: wm8510: Convert to dtschema
Date:   Wed,  5 Apr 2023 16:46:05 +0530
Message-Id: <20230405111605.5250-1-danascape@gmail.com>
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
Changes from V2 -> V3:
    > Drop unneeded SPI example

Changes from V1 -> V2:
    > Added cirrus opensource as the maintainer
    > Added missing $ref to dai-common.yaml
    > Dropped I2C and SPI description
    > Added sound-dai-cells property
    > Added 'compatible' as the required property
    > additionalProperties: false -> unevaluatedProperties: false after adding $ref
    > Added SPI example

 .../devicetree/bindings/sound/wlf,wm8510.yaml | 41 +++++++++++++++++++
 .../devicetree/bindings/sound/wm8510.txt      | 18 --------
 2 files changed, 41 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8510.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/wm8510.txt

diff --git a/Documentation/devicetree/bindings/sound/wlf,wm8510.yaml b/Documentation/devicetree/bindings/sound/wlf,wm8510.yaml
new file mode 100644
index 000000000000..6d12b0ac37e2
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/wlf,wm8510.yaml
@@ -0,0 +1,41 @@
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

