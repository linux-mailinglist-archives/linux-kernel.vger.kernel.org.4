Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E74618F2E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 04:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbiKDDi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 23:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiKDDip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 23:38:45 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023D26437;
        Thu,  3 Nov 2022 20:38:44 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id b21so3766490plc.9;
        Thu, 03 Nov 2022 20:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ivOKkRa7qoXlEHndiKqBlU8PgBKgYvM0wW8U6/YUkjE=;
        b=AuKTgkhxnjjKkqTDkkD+bd2iNIlAw8P1wL4XZa1FrgG1M4YK0sEj6fRye2NqwoKyPE
         xP2cfP8tkZ+OXV0p+ruIDWUVytovPBZ0/H+8bBX55qQoc8/yV+C9Lmfs+i+Og4oUWj63
         azW2KZITY3cezcpZt0ThRVFWD3GkHhV+CwBHU7Hjsr+H5icR7SFNnY76dK/vMk7fOFj2
         sAaELLMuPqcRSWKLF/iNJs++G85A3vm+2T7RI8K29DWDGFasL1a4sXWZCjNhLl0Nwu3/
         yZJLYuohh+BzffalG5DCNSk8VQgk8Imts8HEIBaBW0Vvj5JJBd8coggiXdVo3LyuGfaG
         SAXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ivOKkRa7qoXlEHndiKqBlU8PgBKgYvM0wW8U6/YUkjE=;
        b=7AJrQVg2ph6F3WRKdLdMFgZ4tiPfK0w93+ZHTY5VzsgEgK1J6S62z5wCaHxsjlKbVk
         wcB3EAb7cBrQ+PTwnXuPX3F/ib+GJzKPvPudYjCJHu+PyO1z4DCCcgUgo/l3YnpJC66B
         sqsBD8ABAM+O9qpA/iFMNuZJpMUkpg6lf5pes5+4nAkoABrRdZp50JF6TpOxiJV3YVbu
         V/obrGs+7Y+saGl9YdtBmxe51VdjgT/Pbif9st3FwN62NAJyrk2qe+2pKjWCV1mCoZVP
         lf6ok7DzbFruE66SWdXVL28rXfjAZa7VDWXaLK5t2ZwuKlbwlxUWaM5Skigsc3cTKuzK
         sN9Q==
X-Gm-Message-State: ACrzQf0VCebCEDshNjvzGderzcKSPRdBogALgzVZm/bY4HXAUtit0o2T
        QdPLdEiomnuzetXiLZ2yRdwH8Vi5V2Tq/w==
X-Google-Smtp-Source: AMsMyM5Q8XbTlqyrUemxT6D2TMAJyVOEUTmehuOQItRuZvvp4KKN3cStD2hDZkvxuPg7ZDAVh+EcQQ==
X-Received: by 2002:a17:902:aa8b:b0:178:8f1d:6936 with SMTP id d11-20020a170902aa8b00b001788f1d6936mr33470359plr.168.1667533123438;
        Thu, 03 Nov 2022 20:38:43 -0700 (PDT)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id f17-20020aa79d91000000b0056bb06ce1cfsm1545759pfq.97.2022.11.03.20.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 20:38:43 -0700 (PDT)
From:   Marvin Lin <milkfafa@gmail.com>
To:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     openbmc@lists.ozlabs.org, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, kwliu@nuvoton.com,
        kflin@nuvoton.com, Marvin Lin <milkfafa@gmail.com>
Subject: [PATCH v6 2/5] dt-bindings: media: Add dt-bindings for NPCM Video Capture/Encode Engine
Date:   Fri,  4 Nov 2022 11:38:07 +0800
Message-Id: <20221104033810.1324686-3-milkfafa@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221104033810.1324686-1-milkfafa@gmail.com>
References: <20221104033810.1324686-1-milkfafa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-bindings document for NPCM Video Capture/Encode Engine.

Signed-off-by: Marvin Lin <milkfafa@gmail.com>
---
 .../bindings/media/nuvoton,npcm-video.yaml    | 87 +++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/nuvoton,npcm-video.yaml

diff --git a/Documentation/devicetree/bindings/media/nuvoton,npcm-video.yaml b/Documentation/devicetree/bindings/media/nuvoton,npcm-video.yaml
new file mode 100644
index 000000000000..b5be7ef09038
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/nuvoton,npcm-video.yaml
@@ -0,0 +1,87 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/nuvoton,npcm-video.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton NPCM Video Capture/Encode Engine Device Tree Bindings
+
+maintainers:
+  - Joseph Liu <kwliu@nuvoton.com>
+  - Marvin Lin <kflin@nuvoton.com>
+
+description: |
+  Video Capture/Differentiation Engine (VCD) and Encoding Compression Engine
+  (ECE) present on Nuvoton NPCM SoCs.
+
+properties:
+  compatible:
+    enum:
+      - nuvoton,npcm750-video
+      - nuvoton,npcm845-video
+
+  reg:
+    items:
+      - description: VCD registers
+      - description: ECE registers
+
+  reg-names:
+    items:
+      - const: vcd
+      - const: ece
+
+  interrupts:
+    maxItems: 1
+
+  resets:
+    items:
+      - description: VCD reset control
+      - description: ECE reset control
+
+  reset-names:
+    items:
+      - const: vcd
+      - const: ece
+
+  nuvoton,syscon-gcr:
+    $ref: /schemas/types.yaml#definitions/phandle
+    description: Phandle to the Global Control Register DT node
+
+  nuvoton,syscon-gfxi:
+    $ref: /schemas/types.yaml#definitions/phandle
+    description: Phandle to the Graphics Core Information DT node
+
+  memory-region:
+    description:
+      CMA pool to use for buffers allocation instead of the default CMA pool.
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - resets
+  - reset-names
+  - nuvoton,syscon-gcr
+  - nuvoton,syscon-gfxi
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/reset/nuvoton,npcm7xx-reset.h>
+
+    video: video@f0810000 {
+        compatible = "nuvoton,npcm750-video";
+        reg = <0xf0810000 0x10000>,
+              <0xf0820000 0x2000>;
+        reg-names = "vcd", "ece";
+        interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
+        resets = <&rstc NPCM7XX_RESET_IPSRST2 NPCM7XX_RESET_VCD>,
+                 <&rstc NPCM7XX_RESET_IPSRST2 NPCM7XX_RESET_ECE>;
+        reset-names = "vcd", "ece";
+        nuvoton,syscon-gcr = <&gcr>;
+        nuvoton,syscon-gfxi = <&gfxi>;
+    };
-- 
2.34.1

