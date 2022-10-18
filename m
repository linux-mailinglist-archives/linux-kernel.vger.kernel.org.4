Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85ACB6025CE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 09:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbiJRHdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 03:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbiJRHdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 03:33:19 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83FA63FFC;
        Tue, 18 Oct 2022 00:33:16 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id 10so13085450pli.0;
        Tue, 18 Oct 2022 00:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=da75isXx88J+6UlTqgwNIlDk2sV2HDvdnOV1lRzZ9pY=;
        b=QGiLwnR8hHfj+U3sT4Ghd/2Jtg5z5rEQdWlM0zTyKpWBFGkNxQPMSydZ/j1O9zrTkr
         j2rYQYSC3REtq3MRfcbcLgzBfJwEow45hnXaNBYImRmspxddQMPEBVcfB4IbvO7g9Mm3
         vsyENIBWWNn+9n+pWkTchV0lDsL7R0NZuaSNBojF1N7f1GmuJ2Cufwp899DSQYcAxxwW
         U1UcEH+DUGsmd4hJGGldWCByZpZxugL/K0V6dM8c+OD0WVA6fGfrUgvpltTRJF8iv3Ud
         jzO8ju8b44sEvmBOokNRpB567ZchAplBMCsRdXO1YXaNxfzF4IfmX/sBsrnBXJ/HGr0v
         AYjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=da75isXx88J+6UlTqgwNIlDk2sV2HDvdnOV1lRzZ9pY=;
        b=C2LFz803qHn5bEiBGAhebQq7f0vf2dJUaN+oJ9zjq7j9Q70AI1R8LPRGwtu0Ro2gDn
         q3jKbl4fMQugHMMKzzxXJ9hdIKtguoY88elPVgIL+mrHGwhSOGI9cBnLIsk7QPia3LWG
         1inFrwUYXR2mo863ZMatwFfDt8Jz4yW86IOap/RoOLdCzf747IQ0DwyoZs6r6gcXV/jG
         wxqyK4aNThz0kCyH//P9LQb20PZr+EpOktlAPxHyIB86DTpeyFQEx/kgGi9Nr50nsn0g
         uakcHc24Of2TYR/3qYO9L9syw+HSPjiQmrK7vclOdGPwFy1KLGAC0zKHOWAU6BZm6utP
         2dww==
X-Gm-Message-State: ACrzQf0zdQbKEDOVbtQpmvjRft/Ad3XcTIN7DjUSk83Fk6FAMYQq074W
        NQLVpFLp4iHe3OFbBaClubo=
X-Google-Smtp-Source: AMsMyM4giiTRXCLbRjxm43ZeOdiU0Gl6VrrUtI79rKgepiikbMZYJ7W2Jo50WJykIKe6eRL0aDGGtw==
X-Received: by 2002:a17:90a:ab06:b0:20d:8764:b97a with SMTP id m6-20020a17090aab0600b0020d8764b97amr2149193pjq.7.1666078395919;
        Tue, 18 Oct 2022 00:33:15 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id s1-20020a170902ea0100b001769206a766sm7853260plg.307.2022.10.18.00.33.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Oct 2022 00:33:15 -0700 (PDT)
From:   Li-hao Kuo <lhjeff911@gmail.com>
To:     krzk@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
        amitk@kernel.org, rui.zhang@intel.com, robh+dt@kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lh.kuo@sunplus.com, Li-hao Kuo <lhjeff911@gmail.com>
Subject: [PATCH v11 2/2] dt-bindings: thermal: Add Sunplus schema
Date:   Tue, 18 Oct 2022 15:32:52 +0800
Message-Id: <038211f33e4d5dd5129712aef2738a83577c7745.1665990345.git.lhjeff911@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1665990345.git.lhjeff911@gmail.com>
References: <cover.1665990345.git.lhjeff911@gmail.com>
In-Reply-To: <cover.1665990345.git.lhjeff911@gmail.com>
References: <cover.1665990345.git.lhjeff911@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for Sunplus thermal driver

Signed-off-by: Li-hao Kuo <lhjeff911@gmail.com>
---
Changes in v11:
 - Remove the remove function of the platform_driver
 - Fix error reported-by: kernel test robot.

 .../bindings/thermal/sunplus,sp7021-thermal.yaml   | 43 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/sunplus,sp7021-thermal.yaml

diff --git a/Documentation/devicetree/bindings/thermal/sunplus,sp7021-thermal.yaml b/Documentation/devicetree/bindings/thermal/sunplus,sp7021-thermal.yaml
new file mode 100644
index 0000000..98b5674
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/sunplus,sp7021-thermal.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright (C) Sunplus Co., Ltd.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/sunplus,sp7021-thermal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sunplus Thermal controller
+
+maintainers:
+  - Li-hao Kuo <lhjeff911@gmail.com>
+
+properties:
+  compatible:
+    enum:
+      - sunplus,sp7021-thermal
+
+  reg:
+    maxItems: 1
+
+  nvmem-cells:
+    maxItems: 1
+
+  nvmem-cell-names:
+    const: calib
+
+required:
+  - compatible
+  - reg
+  - nvmem-cells
+  - nvmem-cell-names
+
+additionalProperties: false
+
+examples:
+  - |
+    thermal@9c000280 {
+        compatible = "sunplus,sp7021-thermal";
+        reg = <0x9c000280 0xc>;
+        nvmem-cells = <&calib>;
+        nvmem-cell-names = "calib";
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index bf22c53..f41e625 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19757,6 +19757,7 @@ SUNPLUS THERMAL DRIVER
 M:	Li-hao Kuo <lhjeff911@gmail.com>
 L:	linux-pm@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/thermal/sunplus,sp7021-thermal.yaml
 F:	drivers/thermal/sunplus_thermal.c
 
 SUNPLUS UART DRIVER
-- 
2.7.4

