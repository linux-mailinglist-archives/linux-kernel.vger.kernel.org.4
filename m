Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01DDE6E53CF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 23:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjDQVYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 17:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjDQVYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 17:24:17 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945253A82;
        Mon, 17 Apr 2023 14:24:16 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id l21so9527426pla.5;
        Mon, 17 Apr 2023 14:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681766656; x=1684358656;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tS2EUAIxndFqnf5A6Ki9yaF0traiHvKhRYcLbNaTGjs=;
        b=Fk/0X/CitoM7OVxl8nn7ggP0Ren4uObavNY91hwd44HvH2NrKmoM0h23GPordmdQk1
         dMIvDKGQZ6vocVh9NEtr6riaR0BFi433NmwiWQ0WiXHqdukhUtYGmEgCqkW55JPnMAir
         sXmGk7XXIEgJXib45NbZVgiNjjWKkJ5PO/hwvP+ksBeNyyWFoFBn3toRELFepx9U7g1+
         6kB3tF+cLh6pQD0Ob3kjFPOKztpgGXsxYGuCKDWF4yc0x7+h0Yw0pCN9bVGOPkTO8KU9
         XmzpZ6DgO4zXHDL/DKfqaF/SMcS6+NATLNM1veooGQeS94J92n0oWmyBqz2WEXdukkpA
         yjXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681766656; x=1684358656;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tS2EUAIxndFqnf5A6Ki9yaF0traiHvKhRYcLbNaTGjs=;
        b=D73qD3j6jemSDaE8dC5jWQVlHDoY7iPzctSIv4IGk+9oEP19izjXdMwwHGwOFyuVWv
         Av63NhaYxXQD3YErzjGj/iuDx8pYWaC9KVdyGY0XYkX/Le/WLSj9nrEKsTyhvQXT55qj
         f6Zkcuy+uKh950a/XY5mtIfdJ8npcyyiFemalJ5/O9z/8ktte8MWEXMVnBYmf9z4s9WA
         NSCAFDGyeiDr9Bdn4MmG0eYGCJz9rVS/vkk4ys85/A7zWkt0Kp/E+L6ne8dZzWSpZAoL
         eT52HDNy3UgiUpntOXWuDuWe5Ndk49ccYV2GzrQeY7KGduHQP6hR7Fp5hjt54hctf4X1
         a7vw==
X-Gm-Message-State: AAQBX9dXrV4JcJawmaXnjnzo4l+Xnzf+9lrHs9jXCC6TKiJlBdp2MeRG
        0JOZ9OFHBKP/JMjrNmVbUcBXh5p0Dhdabw==
X-Google-Smtp-Source: AKy350aujkebVnw/oK8vmydVyXqYA3HoOBCMvisiFO1fI6aF4eFv8ANUXJNBd8VwXfiyiWREOkU7bA==
X-Received: by 2002:a05:6a21:7893:b0:f0:93d9:9c03 with SMTP id bf19-20020a056a21789300b000f093d99c03mr265012pzc.15.1681766655822;
        Mon, 17 Apr 2023 14:24:15 -0700 (PDT)
Received: from localhost.localdomain ([2402:e280:218d:82:ae97:7cb6:b12a:54f5])
        by smtp.gmail.com with ESMTPSA id k4-20020aa790c4000000b0063d2dae6247sm1177507pfk.77.2023.04.17.14.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 14:24:14 -0700 (PDT)
From:   Saalim Quadri <danascape@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, daniel.baluta@gmail.com
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Saalim Quadri <danascape@gmail.com>
Subject: [PATCH] ASoC: dt-bindings: wm8737: Convert to dtschema
Date:   Mon, 17 Apr 2023 21:24:00 +0000
Message-Id: <20230417212400.161796-1-danascape@gmail.com>
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

Convert the WM8737 audio CODEC bindings to DT schema

Signed-off-by: Saalim Quadri <danascape@gmail.com>
---
 .../devicetree/bindings/sound/wlf,wm8737.yaml | 40 +++++++++++++++++++
 .../devicetree/bindings/sound/wm8737.txt      | 18 ---------
 2 files changed, 40 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8737.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/wm8737.txt

diff --git a/Documentation/devicetree/bindings/sound/wlf,wm8737.yaml b/Documentation/devicetree/bindings/sound/wlf,wm8737.yaml
new file mode 100644
index 000000000000..12d8765726d8
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/wlf,wm8737.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/wlf,wm8737.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: WM8737 audio CODEC
+
+maintainers:
+  - patches@opensource.cirrus.com
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    const: wlf,wm8737
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
+            compatible = "wlf,wm8737";
+            reg = <0x1a>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/sound/wm8737.txt b/Documentation/devicetree/bindings/sound/wm8737.txt
deleted file mode 100644
index eda1ec6a7563..000000000000
--- a/Documentation/devicetree/bindings/sound/wm8737.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-WM8737 audio CODEC
-
-This device supports both I2C and SPI (configured with pin strapping
-on the board).
-
-Required properties:
-
-  - compatible : "wlf,wm8737"
-
-  - reg : the I2C address of the device for I2C, the chip select
-          number for SPI.
-
-Example:
-
-wm8737: codec@1a {
-	compatible = "wlf,wm8737";
-	reg = <0x1a>;
-};
-- 
2.40.0

