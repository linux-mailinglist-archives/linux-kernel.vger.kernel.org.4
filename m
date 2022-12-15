Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 873CD64D7B8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 09:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbiLOIYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 03:24:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiLOIY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 03:24:27 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCECE2D1F7;
        Thu, 15 Dec 2022 00:24:26 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id t11-20020a17090a024b00b0021932afece4so1962842pje.5;
        Thu, 15 Dec 2022 00:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p1Kmh8wc8B768hb6NEwxEyoQrVxe7sg2+tN2PZX5I48=;
        b=ZUU6fRFAgDHWMOOBwLjYmWgSBGlGPLj4j9IhUifgPy48cmwsioOZ5sdfYqx1kA5X8v
         O1SV1490pzV8ti7HOlXU+xnw+f60w+sreKkrlPNmSWSYWI5o/NwbfSsZRNS/aZPx+oJ4
         2Ur1AC6EzqYScIUDJ6wFsaiUONLIAWmJhZHoptn+ESiMNcGMg/9On/LbY6OfRE96UybT
         IWscjxu8vVOvc+KasOnZy3EqIjv1DzI/0PiNxJCu93MCtGlVrb1T7OKYP+6ZRuVRZvjD
         JiWyZzti++qhiTvrimQsdc+mMyIcDjx1WVWr7d4aDAlyUqn4Q6w6LVV+AgcQNI/eg25y
         1vBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p1Kmh8wc8B768hb6NEwxEyoQrVxe7sg2+tN2PZX5I48=;
        b=uMZhFk38AIXFJRD0e3skecyNYOHe+k00l2NMsriRK4MecBhfWJ78RmDkECLFrguu+I
         wapk0lSlqgp+dGV2a+mpTMXryVEn1qEX6rBOE7cJ50EXRS9AjhV86Q96jYGOe3k6xv6S
         NDdFYaQBuK2t/RKi0DcjCAmGyLlFrcB+sGaXcX26DGmSl4hMmgag39U5iNlc/x4Gd4Ub
         T/KMchWvgyB7s/EPM4/0yL3Qr/q8OaL03Ss92LN0bK6zeSJGtaKZ6rauFWZq3ArNncLD
         oyQX2zxlVDHUBXomhpWpWtbkmfgW6M+n+2IC87L+8BgR5BgcxzyKbhq7ihdMaiiRG9DV
         RA7A==
X-Gm-Message-State: ANoB5pnB+aej5YEdBEmOgneLW/XQiWEKqJODsn40ytnfEbkZSds+y5fg
        DMQu/mAu1HyiGyZpXNtmKbQ=
X-Google-Smtp-Source: AA0mqf4H0xtf9PlO/ezZzhfvfMwH42TTqZAVpNPj+UUZjOqyfBIClcGHZKe61nqT7FufFf6yywo45g==
X-Received: by 2002:a17:90a:6845:b0:218:cbf6:733 with SMTP id e5-20020a17090a684500b00218cbf60733mr27943740pjm.21.1671092666157;
        Thu, 15 Dec 2022 00:24:26 -0800 (PST)
Received: from localhost.localdomain ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id k14-20020a17090a404e00b0020aacde1964sm2594606pjg.32.2022.12.15.00.24.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Dec 2022 00:24:25 -0800 (PST)
From:   Li-hao Kuo <lhjeff911@gmail.com>
To:     rafael@kernel.org, krzk@kernel.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amitk@kernel.org, robh+dt@kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lh.kuo@sunplus.com, Li-hao Kuo <lhjeff911@gmail.com>
Subject: [PATCH v14 2/2] dt-bindings: thermal: Add Sunplus schema
Date:   Thu, 15 Dec 2022 16:23:50 +0800
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
Changes in v12:
 - no change.

Changes in v13:
 - no change.

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

