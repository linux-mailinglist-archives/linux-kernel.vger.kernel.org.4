Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAD56000ED
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 17:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiJPPtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 11:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiJPPtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 11:49:25 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF36110E;
        Sun, 16 Oct 2022 08:49:24 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so12126778pjq.3;
        Sun, 16 Oct 2022 08:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4QRChZnGSanUWZWAPSF22lD+n/i2JuoI0Xb2Ifg9orc=;
        b=jId3KosuWGR/wkRkz5i2dmWo4ffebdrnByoCqXpyUNoC4QC1np3eOgcbpdd5ueX8oN
         mwcjc8dj8eNOEOHPM862qYQnBsy7DPC4zyh2ItKBOXilrVcg/dI72APCJ7ZdxqFJCoyC
         osnAoYFSfytTGPjXnPKQBozSJ/gjdkGHjbbb5Wj3vHkYElYbzhilS1F4NxdhYI4vDyoO
         9EVOw1J8g0HDAXFuXBnANjVsgtB12hJS/j3TUvrBRa03tZikeQ4iUzWXwHqQzJVYESMo
         QTsDh7NvAb7R5r66OO8IxFEH6KXT63viCEX2/cp+bAaTD74MBmtt+jGJLf7jb855vGTJ
         Gl1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4QRChZnGSanUWZWAPSF22lD+n/i2JuoI0Xb2Ifg9orc=;
        b=lhcBfn49+sjPaDBYLykrURcYnJM6PJRKWVeHKrUhVUWGbPvkLmXs8XguuyENKDeGuB
         na+91F9AaF0YsEUgqWe4pydJ+1HZ84G+nmNp8b6Ykl18bRfXdl0rUrXmOc7vAXz24kr2
         6w86lS5vGEa10m8NB678LWUErQELng2LsuVmJflUIQ/LzBCvFVEOeH+iyRgoahHSFVns
         M3jcS9qWTp0UZ27GMG1NauY3fnZp9vvQosPu0bascoEboQ0y11M3mHDA0l5hyY0p76If
         kIIvY0t80iNgoX8zf3auCvFBuwv5J/lJ1bOzf5ZQuyOqqWEJawR7iGq4f9lsQq8mHAUC
         JPNw==
X-Gm-Message-State: ACrzQf0xEiMdlNwgBEmZqlRiPYVx2PPfIGnIxYugtr4JLtLOnWq9y+q2
        YEc/YBOCI1g/L9xee2CUqVo=
X-Google-Smtp-Source: AMsMyM4oFL5egkVxcTxLbKsZlm7GTSl2oanxbjw7R5Zg1W+sTByzz11zTBztafn3nq9hu6y1o5hFYw==
X-Received: by 2002:a17:903:22c1:b0:185:5276:92e5 with SMTP id y1-20020a17090322c100b00185527692e5mr581858plg.134.1665935363787;
        Sun, 16 Oct 2022 08:49:23 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id w14-20020a63fb4e000000b0041a6638b357sm4595222pgj.72.2022.10.16.08.49.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Oct 2022 08:49:23 -0700 (PDT)
From:   Tony Huang <tonyhuang.sunplus@gmail.com>
To:     tonyhuang.sunplus@gmail.com, ulf.hansson@linaro.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        wells.lu@sunplus.com
Subject: [PATCH v10 1/2] dt-binding: mmc: Add mmc yaml file for Sunplus SP7021
Date:   Sun, 16 Oct 2022 23:48:31 +0800
Message-Id: <e4afa6c7a3e01e06172f19964c568c7065ae2bad.1665931914.git.tonyhuang.sunplus@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1665931914.git.tonyhuang.sunplus@gmail.com>
References: <cover.1665931914.git.tonyhuang.sunplus@gmail.com>
In-Reply-To: <cover.1665931914.git.tonyhuang.sunplus@gmail.com>
References: <cover.1665931914.git.tonyhuang.sunplus@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MMC YAML file for Sunplus SP7021.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Tony Huang <tonyhuang.sunplus@gmail.com>
---
Changes in v5:
 - Addressed comments from Krzysztof.

Changes in v6:
 - Addressed comments from Krzysztof.
 - To substitute MMC for mmc. To substitute YMAL for ymal.
 - Remove max-frequency.
 - Fixed wrong file name.

Changes in v7:
 -No change.

Changes in v8:
 -No change.

Changes in v9:
 -No change.

Changes in v10:
 -No change.

 .../devicetree/bindings/mmc/sunplus,mmc.yaml       | 62 ++++++++++++++++++++++
 MAINTAINERS                                        |  6 +++
 2 files changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/sunplus,mmc.yaml

diff --git a/Documentation/devicetree/bindings/mmc/sunplus,mmc.yaml b/Documentation/devicetree/bindings/mmc/sunplus,mmc.yaml
new file mode 100644
index 0000000..50f2119
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/sunplus,mmc.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) Sunplus Ltd. Co. 2021
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/sunplus,mmc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sunplus MMC Controller
+
+maintainers:
+  - Tony Huang <tonyhuang.sunplus@gmail.com>
+  - Li-hao Kuo <lhjeff911@gmail.com>
+
+allOf:
+  - $ref: "mmc-controller.yaml"
+
+properties:
+  compatible:
+    enum:
+      - sunplus,sp7021-mmc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - resets
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    mmc0: mmc@9c003b00 {
+        compatible = "sunplus,sp7021-mmc";
+        reg = <0x9c003b00 0x180>;
+        interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clkc 0x4e>;
+        resets = <&rstc 0x3e>;
+        bus-width = <8>;
+        max-frequency = <52000000>;
+        non-removable;
+        disable-wp;
+        cap-mmc-highspeed;
+        mmc-ddr-3_3v;
+        no-sdio;
+        no-sd;
+    };
+
diff --git a/MAINTAINERS b/MAINTAINERS
index fd768d4..cdd809a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18869,6 +18869,12 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/dlink/sundance.c
 
+SUNPLUS MMC DRIVER
+M:	Tony Huang <tonyhuang.sunplus@gmail.com>
+M:	Li-hao Kuo <lhjeff911@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/mmc/sunplus,mmc.yaml
+
 SUNPLUS OCOTP DRIVER
 M:	Vincent Shih <vincent.sunplus@gmail.com>
 S:	Maintained
-- 
2.7.4

