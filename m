Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6DB6B8E9E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 10:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjCNJYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 05:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbjCNJX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 05:23:58 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F257746C4;
        Tue, 14 Mar 2023 02:23:54 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id f6-20020a17090ac28600b0023b9bf9eb63so6204110pjt.5;
        Tue, 14 Mar 2023 02:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678785833;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wLzit+yPTB9EJ5lmdvzAMxMYaSZ/Ktnl1xMjwc4SSlY=;
        b=CXMuCvp0v6WBlK9hz3mgtXN2c2b4woTU15Owp7XJK+80pJQc14AwZ5maBfGMEle8af
         nUtc51oOukNMUD1h8OiZHLJwSE4aBZMrVghZbwxAy4qq77YWuIPR1X4UHSj6ovYorMTN
         R06KQ6P4M+Y0baxQUoMiJfeAF9lC/uNUAv8CeRJ6OqAES5XnIXNzoVXgULC8F6hUXTxu
         A4RsnRnnhHfuAZ3vZnMwFg7ayQW5Zqy4mJpOrrE+FeQiNs2z9dk2uwp3PALWv9S2JVyp
         MmmXpegHFsw+pwdvShAomv14DfSABTB62o7VvrKjnR5lPK8oOTnv/YUGrZ5m2HS3o/j7
         Vbag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678785833;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wLzit+yPTB9EJ5lmdvzAMxMYaSZ/Ktnl1xMjwc4SSlY=;
        b=WnnPIMl88YgYNkZ85LeVsTjDQ8CD0M5XhDrrw6Cj4QGLAhZZgduDC7wxk+vFOsBu6R
         DIvOgj94SRIa4z4qGWEyspKVSbD52WuOQvu6KCArxMfwuH7Yp66FsdO7rSy05narL6nT
         4EjHJ3+ZD9n2UQX8ctFvrNwva6onkd33Pb6y+mRfXatcg5IhScQZZAhCODqZnmdc2oVu
         BxiArNMFkmKwQDA44obJdZzixHaj/9RW8Wi2M+a5WCkDbW9tZM8XpLcad/xMSwS/S2gM
         A98kUa0Q9SzxK+M/QC8jg+nJSTmjyXBiTSA5P/E1yiEuljwjpNhW7XgiKiunFQ1tnzpR
         yZbQ==
X-Gm-Message-State: AO0yUKU45BrG19B31LpeS0LU7B4B2MbOjl6QnZYXmddRKPlPW0diUhLk
        FPwA+ezAnvDRI26U6zzNjMI=
X-Google-Smtp-Source: AK7set8LhfISBZ22sLdNVeNyLkSrxVBW4X7W2/h1qHmjDbgENTohk8c2ZjqAemREVy4xPUwQdxVlsA==
X-Received: by 2002:a05:6a20:4da7:b0:bc:a2a9:1aa with SMTP id gj39-20020a056a204da700b000bca2a901aamr34485023pzb.55.1678785833663;
        Tue, 14 Mar 2023 02:23:53 -0700 (PDT)
Received: from localhost.localdomain ([1.200.129.193])
        by smtp.gmail.com with ESMTPSA id f21-20020aa782d5000000b00592626fe48csm1120898pfn.122.2023.03.14.02.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 02:23:53 -0700 (PDT)
From:   Jim Liu <jim.t90615@gmail.com>
To:     JJLIU0@nuvoton.com, KWLIU@nuvoton.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, jim.t90615@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: [PATCH v5 3/3] dt-bindings: gpio: add NPCM sgpio driver bindings
Date:   Tue, 14 Mar 2023 17:23:11 +0800
Message-Id: <20230314092311.8924-4-jim.t90615@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230314092311.8924-1-jim.t90615@gmail.com>
References: <20230314092311.8924-1-jim.t90615@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-bindings document for the Nuvoton NPCM7xx sgpio driver

Signed-off-by: Jim Liu <jim.t90615@gmail.com>
---
Changes for v4:
   - remove bus bus-frequency
   - modify in/out description
Changes for v4:
   - modify in/out property
   - modify bus-frequency property
Changes for v3:
   - modify description
   - modify in/out property name
Changes for v2:
   - modify description
---
 .../bindings/gpio/nuvoton,sgpio.yaml          | 87 +++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml

diff --git a/Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml b/Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml
new file mode 100644
index 000000000000..9237376eda18
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml
@@ -0,0 +1,87 @@
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
+  nuvoton,input-ngpios:
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    description: |
+      The numbers of GPIO's exposed.GPIO lines is only for gpi.
+    minimum: 0
+    maximum: 64
+
+  nuvoton,output-ngpios:
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    description: |
+      The numbers of GPIO's exposed.GPIO lines is only for gpo.
+    minimum: 0
+    maximum: 64
+
+required:
+  - compatible
+  - reg
+  - clock
+  - gpio-controller
+  - '#gpio-cells'
+  - interrupts
+  - nuvoton,input-ngpios
+  - nuvoton,output-ngpios
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
+        gpio-controller;
+        #gpio-cells = <2>;
+        nuvoton,input-ngpios = <64>;
+        nuvoton,output-ngpios = <64>;
+        status = "disabled";
+    };
-- 
2.17.1

