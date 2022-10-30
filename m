Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5DF6126C0
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 02:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiJ3Avb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 20:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiJ3Av2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 20:51:28 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E66D3FED1;
        Sat, 29 Oct 2022 17:51:27 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id r61-20020a17090a43c300b00212f4e9cccdso13015692pjg.5;
        Sat, 29 Oct 2022 17:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ANEhihAqc+rSAji5S1A02YEBoRyu9ZtLwD6DRxGi/HU=;
        b=HZBdE5kmHNDNeA4duKPPdVEErV00KJK5dhhbOh0YvnTE9FOs2/MQXKqnVGeV7b7GF0
         ebMS9VGbIwmaKWjg9ThCrU+ILUZwBkV/zs+mqLcofUu7tDKAmqHBFdmf7z7qpYSsywlf
         GMkAOfezYSIP2vde3D33yj1E2nb6ZFrJ6LYJu4W8bQ9r3530aBHJOUyTEwHMAB1NGQpG
         BL3VLXweIVOGJm15qLBX598Sg25d7o7WzteFEvgSzoVFfAlHQ6dGTvjbhwjFeEtcYYWG
         utvoHgMjWTQlAEzkS4aJfXfhDCHSt0+xVkrhlHcGQ72zZbFSF0o/EJomGvY2IMIe2ede
         wzAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ANEhihAqc+rSAji5S1A02YEBoRyu9ZtLwD6DRxGi/HU=;
        b=XBgBtwMUomSHf0gM2ior1ob30YZNwt+R+8ccDwuH9G2UyOgFYavGJ2OEpYapPIh6Si
         vNZBbfqiN0KgUHwhaI76ry6dxvo8a8D2G0SZHS3ubkDLlYm8AvDnO9EJFv8oJuFICkIw
         5wT2tgFteeT3SD0G6E1YBHtDp0yIk4IEYdBs1kt0woW4OCJr3Fjr4+7eJtsi2vrb/9zK
         civ+fMNZD+e7aCpDGeKRfdOW+IHkDFKYcrHSv41k2Cx+vxVA7/OXE/5yp2MKTbSZi6k/
         hjbxwd/yCHmTNVDW0+J135eJCxR0z6Jz5G+Xlsay+rssOm/7ASMDHTmx9qUA8a+C9zI2
         rCkg==
X-Gm-Message-State: ACrzQf2zg80HnzdwHkos8Ds0GY7P5/nBaDrAPbmTL5sQ1uZk911mHve+
        Buc+bJayYhUc7k/o7k2F4WY=
X-Google-Smtp-Source: AMsMyM4sO1wbZ9sxSYCXnLbtl3lXKLWKABJsH/0+BF9gxOvsWORV5jGYjv+P9JUMldHag7rRH/a6xA==
X-Received: by 2002:a17:903:4ca:b0:179:d21f:f04b with SMTP id jm10-20020a17090304ca00b00179d21ff04bmr6902683plb.7.1667091086918;
        Sat, 29 Oct 2022 17:51:26 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id b14-20020a170902650e00b00176dd41320dsm1836744plk.119.2022.10.29.17.51.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Oct 2022 17:51:26 -0700 (PDT)
From:   Tony Huang <tonyhuang.sunplus@gmail.com>
To:     tonyhuang.sunplus@gmail.com, lhjeff911@gmail.com,
        ulf.hansson@linaro.org, robh+dt@kernle.org, krzk+dz@kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, wells.lu@sunplus.com
Subject: [PATCH v11 1/2] dt-binding: mmc: Add mmc yaml file for Sunplus SP7021
Date:   Sun, 30 Oct 2022 08:50:49 +0800
Message-Id: <61818eada54f5adb873455143cd950b28d57bc2c.1667087353.git.tonyhuang.sunplus@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1667087353.git.tonyhuang.sunplus@gmail.com>
References: <cover.1667087353.git.tonyhuang.sunplus@gmail.com>
In-Reply-To: <cover.1667087353.git.tonyhuang.sunplus@gmail.com>
References: <cover.1667087353.git.tonyhuang.sunplus@gmail.com>
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

Changes in v11:
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

