Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6921690A9F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 14:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjBINls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 08:41:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjBINlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 08:41:44 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D121846705
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 05:41:41 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id az4-20020a05600c600400b003dff767a1f1so1555354wmb.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 05:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CU99A3qAz7AXXrQplpT1MuuDMQU9ldkAjGA2AqUf0T0=;
        b=ImlKFUeQ2taGX0SvIp26PSGxKa3dwwl1tmuZ5M06ujHzWh3hl3rd60sY83lv+qCenI
         0qSza1Y/OBLJB+j9fCJpRl32j0bK+sa8GFPagG81MyG0fN7r5iK+CVleCcV/URfEAB0f
         AVa9JouaiSTi2Viojvw8h2p3FFt9reL9nJzooThQQbCy5F9Awhulg9YjFhRrCKOAIc7y
         WqVkmKaX9fAxus7LCSrQlMrSF0mzvcuZ8TPCMbhx4G6LEjg8VmfnyCbGQChwu2/Td8uQ
         CXAgnnxdZ6xPgXTbLqTnea8RHfK0GHRaB/iw/beQkRv2WbIFDVj/qXFiSehgBSb+GDJQ
         h61g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CU99A3qAz7AXXrQplpT1MuuDMQU9ldkAjGA2AqUf0T0=;
        b=WA3t+0CsPM2POEYg1+hnSHOM+KfzDE0mUtk9tbLZ+zUFN8IP36j0Ts4FMZ1j6OghW7
         I5squ3ndgTEfSbCA80sxV7sTw9CmO+pXMOMiNZNTFQHMJnoVaMLTxQ8qiAInzBnn3HqC
         7cppJKec3hBJlZlhWE/vnXLtJ5rfhBy7Q6LopXTuX9CKKaoSVuhV42IgwRZ7CUT88k7V
         lMn9It/zAG/M1JqIpMPZ5UrQq0NZ37en9lIY9iqiBwlQcuGG4ORAXq58jJW7JTr1ChYz
         QmMlzsc2vAwUFL0gx0aiQrEbksonnSkZne6mwRYdP0117/susPeoiHKQndZZoUH9ABjv
         9MoA==
X-Gm-Message-State: AO0yUKWfrRl6vEH9ZCKrJudoYOwBsFni70KxtmMxFGnmPzRRH6LRoSCp
        y2aM+d0YJBB76MVUjp7k8UTqTw==
X-Google-Smtp-Source: AK7set9KbStsFCWSuek/BkTuzJIPXd3DaYisd2ak/58gga5zQlIerOgkiYECAD2ikHl+dqpxsBFq8g==
X-Received: by 2002:a05:600c:2e94:b0:3df:e46f:c226 with SMTP id p20-20020a05600c2e9400b003dfe46fc226mr9731856wmn.16.1675950100407;
        Thu, 09 Feb 2023 05:41:40 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id k12-20020a7bc40c000000b003dfe549da4fsm4946991wmi.18.2023.02.09.05.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 05:41:39 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 09 Feb 2023 14:41:37 +0100
Subject: [PATCH 1/6] dt-bindings: rtc: convert rtc-meson-vrtc.txt to
 dt-schema
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230209-b4-amlogic-bindings-convert-take2-v1-1-c4fe9049def9@linaro.org>
References: <20230209-b4-amlogic-bindings-convert-take2-v1-0-c4fe9049def9@linaro.org>
In-Reply-To: <20230209-b4-amlogic-bindings-convert-take2-v1-0-c4fe9049def9@linaro.org>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Amlogic Virtual RTC bindings to dt-schema.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../bindings/rtc/amlogic,meson-vrtc.yaml           | 42 ++++++++++++++++++++++
 .../devicetree/bindings/rtc/rtc-meson-vrtc.txt     | 22 ------------
 2 files changed, 42 insertions(+), 22 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/amlogic,meson-vrtc.yaml b/Documentation/devicetree/bindings/rtc/amlogic,meson-vrtc.yaml
new file mode 100644
index 000000000000..1d5694c08965
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/amlogic,meson-vrtc.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/amlogic,meson-vrtc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic Virtual RTC (VRTC)
+
+maintainers:
+  - Neil Armstrong <neil.armstrong@linaro.org>
+
+description:
+  The interface is 1 register where an alarm time (in seconds) is to be written.
+
+  The alarm register is a simple scratch register shared between the
+  application processors (AP) and the secure co-processor (SCP).
+  When the AP suspends, the SCP will use the value of this register to
+  program an always-on timer before going sleep. When the timer expires,
+  the SCP will wake up and will then wake the AP.
+
+allOf:
+  - $ref: rtc.yaml#
+
+properties:
+  compatible:
+    const: amlogic,meson-vrtc
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    vrtc: rtc@a8 {
+        compatible = "amlogic,meson-vrtc";
+        reg = <0x000a8 0x4>;
+    };
diff --git a/Documentation/devicetree/bindings/rtc/rtc-meson-vrtc.txt b/Documentation/devicetree/bindings/rtc/rtc-meson-vrtc.txt
deleted file mode 100644
index c014f54a9853..000000000000
--- a/Documentation/devicetree/bindings/rtc/rtc-meson-vrtc.txt
+++ /dev/null
@@ -1,22 +0,0 @@
-* Amlogic Virtual RTC (VRTC)
-
-This is a Linux interface to an RTC managed by firmware, hence it's
-virtual from a Linux perspective.  The interface is 1 register where
-an alarm time (in seconds) is to be written.
-
-Required properties:
-- compatible: should be "amlogic,meson-vrtc"
-- reg: physical address for the alarm register
-
-The alarm register is a simple scratch register shared between the
-application processors (AP) and the secure co-processor (SCP.)  When
-the AP suspends, the SCP will use the value of this register to
-program an always-on timer before going sleep. When the timer expires,
-the SCP will wake up and will then wake the AP.
-
-Example:
-
-	vrtc: rtc@0a8 {
-		compatible = "amlogic,meson-vrtc";
-		reg = <0x0 0x000a8 0x0 0x4>;
-	};

-- 
2.34.1

