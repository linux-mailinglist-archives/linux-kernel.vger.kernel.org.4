Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A71B620C35
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 10:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbiKHJ31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 04:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233678AbiKHJ3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 04:29:23 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D67B12AEB;
        Tue,  8 Nov 2022 01:29:22 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id b1-20020a17090a7ac100b00213fde52d49so12833120pjl.3;
        Tue, 08 Nov 2022 01:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Pnl7ZG08BhjAH6w2uqmjyTgSyZMRz6TVlKCPmOlFFnw=;
        b=pqyf9Mvi/QB8JnIQTEouecCNDmv6LLuj2YKC0kTdOedBz4uSPyMY751nDpC58LvKLH
         wEKo8smrgfj38+moOCQ/L9WPD189rxa8Vo7zv6eroS4NHxd7dr1bjf6r5VWOIVpoj4Hf
         DcKNtGzr2SYSbYATtVp9N4fiZ1Ld3kuGomjX7a5Q8SKPnIAqv/DB7czm897rLbL+5JmH
         tO4xd2h7AXIIxsv0zgEwaSOW6enGw7ecd//3dAqNR35h0fYBqk8usM72beDm4p+NJYH7
         ZG2tIj2rkFU2HOHWweBD6wqQAH6O4n8IunFFiB1+7Pc8BAWM8HmSD1obAmggxvyVMaRP
         4WiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pnl7ZG08BhjAH6w2uqmjyTgSyZMRz6TVlKCPmOlFFnw=;
        b=sd1O4kBTIIbChu4/XTgEfVBWjVMlXYV/EnfixIHH4sbZds0HPiMOUeAsquOLS2TnEz
         Nu/1USfhOmgs9QRA2lFTpcsm4DQTjQR6YBJnEcPDcxeFz2ltfBHm6PLkdXXl+YFHEHGj
         NlwT5MzRUpcuPkH8b67NkqLPmrlE8SuBj1PNoAtRy3RHX6mW9br/4knvVsjE9OIgnMCk
         RwYSKHCAr4sxi7jLL84FHMMyr0xsU/wj8bGrngTVJbHFijrtZHAcVDm0wJG+Cpf7jlPm
         ODPyFBpos/riXsf+6rtygOLGedi8os9poDjkfcrKHgx76jWi/j8mo+lco/O/g2SimWv+
         BajQ==
X-Gm-Message-State: ACrzQf21etK5AJiqRwqodIQmnpNDDbr03Jvn2n6oOMJ3gpN0G72KoSak
        xm0F1ssn4bvOBvHcq8CuPkc=
X-Google-Smtp-Source: AMsMyM6HPyMpiaGuaVKtcrPc2W9JwIRekSRu91sJCZKaEaBonWxVW4n0J0k/yNpzJLPVHimnB8VH4w==
X-Received: by 2002:a17:90a:1657:b0:213:7c4d:768a with SMTP id x23-20020a17090a165700b002137c4d768amr65617879pje.199.1667899762087;
        Tue, 08 Nov 2022 01:29:22 -0800 (PST)
Received: from localhost.localdomain ([180.217.157.203])
        by smtp.gmail.com with ESMTPSA id x17-20020a170902ec9100b00186727e5f5csm6467147plg.248.2022.11.08.01.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 01:29:21 -0800 (PST)
From:   Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To:     JJLIU0@nuvoton.com, jim.t90615@gmail.com, KWLIU@nuvoton.com,
        linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, openbmc@lists.ozlabs.org
Subject: [PATCH v2 3/3] dt-bindings: gpio: Add Nuvoton NPCM750 serial I/O expansion interface(SGPIO)
Date:   Tue,  8 Nov 2022 17:28:40 +0800
Message-Id: <20221108092840.14945-4-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221108092840.14945-1-JJLIU0@nuvoton.com>
References: <20221108092840.14945-1-JJLIU0@nuvoton.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NPCM750 include two SGPIO modules.
Each module supports up to 64 input and 64 output pins.
the output pin must be serial to parallel device(such as the hc595)
the input in must be parallel to serial device(such as the hc165)

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
Changes for v2:
   - modify description
---
 .../bindings/gpio/nuvoton,sgpio.yaml          | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml

diff --git a/Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml b/Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml
new file mode 100644
index 000000000000..331e3cb28b98
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml
@@ -0,0 +1,79 @@
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
+  This SGPIO controller is for NUVOTON NPCM7xx and NPCM8xx SoC,
+  NPCM7xx/NPCM8xx have two sgpio module each module can support up
+  to 64 output pins,and up to 64 input pin.
+  Nuvoton NPCM750 SGPIO module is base on serial to parallel IC (HC595)
+  and parallel to serial IC (HC165).
+  GPIO pins can be programmed to support the following options
+  - Support interrupt option for each input port and various interrupt
+    sensitivity option (level-high, level-low, edge-high, edge-low)
+  - Directly connected to APB bus and its shift clock is from APB bus clock
+    divided by a programmable value.
+  - nin_gpios is number of input GPIO lines
+  - nout_gpios is number of output GPIO lines
+  - ngpios is number of nin_gpios GPIO lines and nout_gpios GPIO lines.
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
+  nin_gpios: true
+
+  nout_gpios: true
+
+  bus-frequency: true
+
+required:
+  - compatible
+  - reg
+  - gpio-controller
+  - '#gpio-cells'
+  - interrupts
+  - nin_gpios
+  - nout_gpios
+  - clocks
+  - bus-frequency
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/nuvoton,npcm7xx-clock.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    sgpio1: sgpio@101000 {
+        compatible = "nuvoton,npcm750-sgpio";
+        reg = <0x101000 0x200>;
+        clocks = <&clk NPCM7XX_CLK_APB3>;
+        interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+        bus-frequency = <16000000>;
+        gpio-controller;
+        #gpio-cells = <2>;
+        nin_gpios = <64>;
+        nout_gpios = <64>;
+        status = "disabled";
+    };
-- 
2.17.1

