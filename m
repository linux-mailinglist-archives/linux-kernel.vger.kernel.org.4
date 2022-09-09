Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55EB5B3B98
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 17:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbiIIPNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 11:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbiIIPNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 11:13:30 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB1314496A;
        Fri,  9 Sep 2022 08:13:29 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 73so1865353pga.1;
        Fri, 09 Sep 2022 08:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Zfu8klkEEURpU6QZwMFaeAs/esTIGjM6BvmfdjMYuCk=;
        b=PODlkorAAqZbTwnS+KtflFGWb5TSePODhLXgkQomTCOWmIPtSD6/uF/JLYiQDDDJtX
         uhhlzzWTuRSXl5a+uNPuYqszF3jFH6ALgZz/a3GDjeRBLQAoQFZLaM5+TXT8x03TouPE
         CePhR0nGy4BNXZHuIP+FszmSJL78tR07S9VlP9Y85LZ48ZGGITdqEfIoWOpCyxNXlsCR
         Lcc34Gv6ymp7ObpNp1DYqZXzswXOalb2LBZsFY3LEozCLLvkHI/WQ7ybPJSlRdBFmKOW
         cfMkt3agwYnZeCWuZU5iAr1CCEWS1n+ekR+vE6OHb0SBrHelz52AS3tNGXsrbHU4Gxlg
         0Bzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Zfu8klkEEURpU6QZwMFaeAs/esTIGjM6BvmfdjMYuCk=;
        b=Xj6Zs8hSIHJQT5QZi2H/gg5FGBE7ppRIi0mIppcY6Jne1y7Zl6bxHdH+oH9U4OcdmN
         Cu7P5rmnZaz/ETQxpbesxKnzpIn2qfR2xCGmoxXkZGdnzKm04u0BQdshfePagwI7cSog
         T5XtmItbE4mP5Rmkcm9puEqQN7GSzBoxgR1rFjL4PaqH2Evx9NbNUnqbhZeiV8yKoY0L
         VjEU4gNRIL74t6CI/PaiyHEIqejYhKIQZ7UOCRE1Bpx4Hv4QWVr8nQf9MWrGN1DlYqzH
         iJ6h4Ny3d0FpN+lrJc4IzRS7aufkDT/0o0f8fV5GNnjpTuWcA/h/7tSNFMk0+G4X0kFw
         mvOw==
X-Gm-Message-State: ACgBeo38O+5XdOY74etRMxWewQvqdE6Dem61mwj9d/JfGYHG32lP2S9J
        t5WDQmmrqgO5nPraCY6aTRE=
X-Google-Smtp-Source: AA6agR5azrzLQI/fFnxGkbw1T+Tz8G/gbqM64PyGxdhI6maNS97eKSZmMYpTxnn+ddbhyYaISOrkvg==
X-Received: by 2002:a63:ee57:0:b0:438:9514:46fe with SMTP id n23-20020a63ee57000000b00438951446femr1713648pgk.623.1662736408955;
        Fri, 09 Sep 2022 08:13:28 -0700 (PDT)
Received: from tj10039pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id e7-20020a056a0000c700b0052e6d5ee183sm651962pfj.129.2022.09.09.08.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 08:13:28 -0700 (PDT)
From:   Cixi Geng <gengcixi@gmail.com>
To:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH V8 1/2] dt-bindings: mfd: sprd: Add bindings for ums512 global registers
Date:   Fri,  9 Sep 2022 23:12:35 +0800
Message-Id: <20220909151236.277671-2-gengcixi@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220909151236.277671-1-gengcixi@gmail.com>
References: <20220909151236.277671-1-gengcixi@gmail.com>
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

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

Add bindings for Unisoc system global register which provide register map
for clocks.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/mfd/sprd,ums512-glbreg.yaml      | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml

diff --git a/Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml b/Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml
new file mode 100644
index 000000000000..996bd4a17ca3
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2022 Unisoc Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/sprd,ums512-glbreg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Unisoc System Global Register
+
+maintainers:
+  - Orson Zhai <orsonzhai@gmail.com>
+  - Baolin Wang <baolin.wang7@gmail.com>
+  - Chunyan Zhang <zhang.lyra@gmail.com>
+
+description:
+  Unisoc system global registers provide register map
+  for clocks and some multimedia modules of the SoC.
+
+properties:
+  compatible:
+    items:
+      - const: sprd,ums512-glbregs
+      - const: syscon
+      - const: simple-mfd
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+  ranges:
+    maxItems: 1
+
+  reg:
+    maxItems: 1
+
+patternProperties:
+  "^clock-controller@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/clock/sprd,ums512-clk.yaml#
+    description:
+      Clock controller for the SoC clocks.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    ap_apb_regs: syscon@71000000 {
+      compatible = "sprd,ums512-glbregs", "syscon", "simple-mfd";
+      reg = <0x71000000 0x3000>;
+      #address-cells = <1>;
+      #size-cells = <1>;
+      ranges = <0 0x71000000 0x3000>;
+
+      clock-controller@0 {
+        compatible = "sprd,ums512-apahb-gate";
+        reg = <0x0 0x2000>;
+        #clock-cells = <1>;
+      };
+    };
+
+  - |
+    ap_intc5_regs: syscon@32360000 {
+      compatible = "sprd,ums512-glbregs", "syscon", "simple-mfd";
+      reg = <0x32360000 0x1000>;
+    };
-- 
2.34.1

