Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E436030F5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 18:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiJRQp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 12:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiJRQpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 12:45:55 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC057E8C52
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 09:45:53 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id t4so11119607wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 09:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+orLHdjN22tP869vCnaab3e5mhNvntEtV9jpkeSTRtw=;
        b=S6dvHcLhvq0gyDjYHLftknwwXLAGEmhHTtaYQfFpeTBoqo8p56p6xiDIqySooNZomx
         YxJJrJQuRywSPrB82azwjh/OJo9/vqIe8iTLEJbVBSN5dy2IEi4L3QewHM/h+of4i81K
         DK8VKsPBPYQ80RGi7Pjg7b/hv9A1ozHZfRGtY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+orLHdjN22tP869vCnaab3e5mhNvntEtV9jpkeSTRtw=;
        b=kJqj/4ivaP/9ypssYhu/H6mzdcVIBtLWEzY5muYLQ9rWLXkS5ihiy7ZwQfTDkfAbEo
         s0+22Gxmw1MArTlvK0ZFBVFrm63qVhcCXUN4pZTubfiSkiSsOsbZM6GU2XrJW71PqId7
         A2/S2af9HjSRcelGzX/8mi9jc8DhtSli+KVGaJvS/p2d0b1EGdWBQvoA4K611S9euMJP
         nWm7s/+24RJICRF+QWvdoDyHpyU5wKyxaW30BrtFFDBPS5EsQedJxMbBESiC/BOFsqqY
         aPIiW25j0xL4ukJRA7HooXAtgZ7YO7ltxwpYIGQ2DOmpvVPN0aA6Y3qA/bPkmUJd/inc
         o5gA==
X-Gm-Message-State: ACrzQf0BE+bg1n1T0v5KZVuVQv/HHxkU37eq7l8hFtFhlsDZATFb0xMB
        fGrNtBss2NE8naMxRYNfHrsMCg==
X-Google-Smtp-Source: AMsMyM5pnkks/HND10mWToRhl+UCf2Z9hxQ1obs63ep+oxFuntY0Pg679ulh4Iz5SoE8EuPgz/8UNw==
X-Received: by 2002:a05:600c:4e06:b0:3c6:ce02:ece4 with SMTP id b6-20020a05600c4e0600b003c6ce02ece4mr2582171wmq.58.1666111551336;
        Tue, 18 Oct 2022 09:45:51 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i.station (net-188-217-54-207.cust.vodafonedsl.it. [188.217.54.207])
        by smtp.gmail.com with ESMTPSA id e26-20020a05600c4b9a00b003a5537bb2besm13545592wmp.25.2022.10.18.09.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 09:45:50 -0700 (PDT)
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     tommaso.merciai@amarulasolutions.com
Cc:     michael@amarulasolutions.com, linuxfancy@googlegroups.com,
        linux-amarula@amarulasolutions.com, kamlesh.gurudasani@gmail.com,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: add binding for tft displays based on ilitek,ili9488
Date:   Tue, 18 Oct 2022 18:45:25 +0200
Message-Id: <20221018164532.1705215-2-tommaso.merciai@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221018164532.1705215-1-tommaso.merciai@amarulasolutions.com>
References: <20221018164532.1705215-1-tommaso.merciai@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This binding is for the tft displays based on ilitek,ili9488.
waveshare,waveshare,pico-rt-lcd-35 (waveshare pico-restouch-lcd-3.5)

Signed-off-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
---
 .../bindings/display/ilitek,ili9488.yaml      | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/ilitek,ili9488.yaml

diff --git a/Documentation/devicetree/bindings/display/ilitek,ili9488.yaml b/Documentation/devicetree/bindings/display/ilitek,ili9488.yaml
new file mode 100644
index 0000000000000..879ecc42c350c
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/ilitek,ili9488.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/ilitek,ili9488.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ilitek ILI9488 display panels device tree bindings
+
+maintainers:
+  - Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>
+  - Michael Trimarchi <michael@amarulasolutions.com>
+  - Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
+
+description:
+  This binding is for display panels using an Ilitek ILI9488 controller in SPI
+  mode.
+
+allOf:
+  - $ref: panel/panel-common.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          # Waveshare 3.5" 320x480 Color TFT LCD
+          - "waveshare,pico-rt-lcd-35"
+      - const: ilitek,ili9488
+
+  spi-max-frequency:
+    maximum: 20000000
+
+  dc-gpios:
+    maxItems: 1
+    description: Display data/command selection (D/CX)
+
+  backlight: true
+  reg: true
+  reset-gpios: true
+  rotation: true
+
+required:
+  - compatible
+  - reg
+  - dc-gpios
+  - reset-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    backlight: backlight {
+            compatible = "gpio-backlight";
+            gpios = <&gpio 22 GPIO_ACTIVE_HIGH>;
+    };
+    spi {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+
+            display@0{
+                    compatible = "waveshare,pico-rt-lcd-35", "ilitek,ili9488";
+                    reg = <0>;
+                    spi-max-frequency = <20000000>;
+                    dc-gpios = <&gpio0 24 GPIO_ACTIVE_HIGH>;
+                    reset-gpios = <&gpio0 25 GPIO_ACTIVE_HIGH>;
+                    backlight = <&backlight>;
+            };
+    };
+
+...
-- 
2.25.1

