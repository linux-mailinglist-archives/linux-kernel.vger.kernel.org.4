Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFFEF651C1B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 09:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbiLTICh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 03:02:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233378AbiLTICE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 03:02:04 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E212416493;
        Tue, 20 Dec 2022 00:02:02 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d7so11474875pll.9;
        Tue, 20 Dec 2022 00:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mAhkp0InTgU68d121ZiU7XlrosaqquvStPHnwrA29z4=;
        b=bC5WPILqfiUNWIv9u/ks5N5N5oeqPvabMgKlYff+DyW6W09Mm48wpfVICLYqZP1P7J
         z34I/ss/TCt4MtiJ2Sr2cZbOTuv1AHOS2PQrnEK5Wva1mw8/Z4ppYsLHdPBi2OProZrO
         r3Y53HGmIurtAqSQgaVZEonPlHrWzq4BoybuZJGl0gryagSQkIH9tqv7tKZUIFZvtIAM
         e2nuULgtDrr+pgeOC27VS4+D8LpQBXmkWb0wCdmnF2W401iIpJ3PSSqxX3/Q29pnXZsu
         GHuu8ZhTkK0lNP2KaraTuVvQQ+W0fj458X7FSmOQizhWn3siJzunmya3XuTqyQrW3AGA
         GDLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mAhkp0InTgU68d121ZiU7XlrosaqquvStPHnwrA29z4=;
        b=Y5UM+zBbrxc1B3Fvqok7OQoh7yepGF7pNiYBQ/KTSo1SiPPIPA888cQ8/++vcypRoP
         V2YOkxsqV5Or9rIn8AAOMKd1C8Nut441eowbRLYbrF2muAqw7TY65QzoMwOKpsbs54/Z
         k3lLZgLH5feoa56Pj9+ZsraYALwbdcN9JnlmMtliwv7l6DTzH4dOvbzCe7dw/4c1jDZb
         bs4v7qGkFFT4JBoa9b/cwOTPneTTrTQZ5EsSXkbg64KqWe2fx3Lwt8Y3oKTCSeErfWlv
         5pJXq9+LyL28FHk+k/uFbJ6eh145YbQ1AePv9nLr/pVBzmLutaB82/f+Nq0dYYYJLSQa
         rSHA==
X-Gm-Message-State: ANoB5pkArOMPd41QPl53uYXnA+tXWfY22vfYifLEz6AseuIBGaaTOeDr
        d0X9D4h15bHDf2rfEk1phiEPaDvZaKA=
X-Google-Smtp-Source: AA0mqf65FeV1zQJUKDGZB88+1MWZK7pVvXTbj+AThHkMQNGdpkgcWMtGNpMaQliox7RalI4/GbiC0g==
X-Received: by 2002:a05:6a20:94cd:b0:aa:3c1:46d with SMTP id ht13-20020a056a2094cd00b000aa03c1046dmr55852642pzb.57.1671523322415;
        Tue, 20 Dec 2022 00:02:02 -0800 (PST)
Received: from localhost.localdomain ([180.217.146.214])
        by smtp.gmail.com with ESMTPSA id u15-20020a65670f000000b00476d1385265sm7559179pgf.25.2022.12.20.00.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 00:02:02 -0800 (PST)
From:   Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To:     JJLIU0@nuvoton.com, KWLIU@nuvoton.com, jim.t90615@gmail.com,
        linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: [PATCH v3 3/3] dt-bindings: gpio: add npcm7xx sgpio driver bindings
Date:   Tue, 20 Dec 2022 16:01:39 +0800
Message-Id: <20221220080139.1803-4-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221220080139.1803-1-JJLIU0@nuvoton.com>
References: <20221220080139.1803-1-JJLIU0@nuvoton.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-bindings document for the NPCM7xx sgpio driver

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
Changes for v3:
   - modify description
   - modify in/out property name 
Changes for v2:
   - modify description
---
 .../bindings/gpio/nuvoton,sgpio.yaml          | 83 +++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml

diff --git a/Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml b/Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml
new file mode 100644
index 000000000000..673535314cff
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/nuvoton,sgpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton SGPIO controller
+
+maintainers:
+  - Jim LIU <JJLIU0@nuvoton.com>
+
+description:
+  This SGPIO controller is for NUVOTON NPCM7xx and NPCM8xx SoC.
+  Nuvoton NPCM7xx SGPIO module is combine serial to parallel IC (HC595)
+  and parallel to serial IC (HC165), and use APB3 clock to control it.
+  This interface has 4 pins  (D_out , D_in, S_CLK, LDSH).
+  NPCM7xx/NPCM8xx have two sgpio module each module can support up
+  to 64 output pins,and up to 64 input pin, the pin is only for gpi or gpo.
+  GPIO pins have sequential, First half is gpo and second half is gpi.
+  GPIO pins can be programmed to support the following options
+  - Support interrupt option for each input port and various interrupt
+    sensitivity option (level-high, level-low, edge-high, edge-low)
+  - Directly connected to APB bus and its shift clock is from APB bus clock
+    divided by a programmable value.
+  - ngpios is number of nuvoton,input-ngpios GPIO lines and nuvoton,output-ngpios GPIO lines.
+    nuvoton,input-ngpios GPIO lines is only for gpi.
+    nuvoton,output-ngpios GPIO lines is only for gpo.
+
+properties:
+  compatible:
+    enum:
+      - nuvoton,npcm750-sgpio
+      - nuvoton,npcm845-sgpio
+
+  reg:
+    maxItems: 1
+
+  gpio-controller: true
+
+  '#gpio-cells':
+    const: 2
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  nuvoton,input-ngpios: true
+
+  nuvoton,output-ngpios: true
+
+  bus-frequency: true
+
+required:
+  - compatible
+  - reg
+  - gpio-controller
+  - '#gpio-cells'
+  - interrupts
+  - nuvoton,input-ngpios
+  - nuvoton,output-ngpios
+  - clocks
+  - bus-frequency
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/nuvoton,npcm7xx-clock.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    gpio8: gpio@101000 {
+        compatible = "nuvoton,npcm750-sgpio";
+        reg = <0x101000 0x200>;
+        clocks = <&clk NPCM7XX_CLK_APB3>;
+        interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+        bus-frequency = <16000000>;
+        gpio-controller;
+        #gpio-cells = <2>;
+        nuvoton,input-ngpios = <64>;
+        nuvoton,output-ngpios = <64>;
+        status = "disabled";
+    };
-- 
2.17.1

