Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA08062D5CB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 10:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234689AbiKQJEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 04:04:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239476AbiKQJEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 04:04:30 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0D2AF086;
        Thu, 17 Nov 2022 01:04:28 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id j12so1035396plj.5;
        Thu, 17 Nov 2022 01:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BKjqvqbDioqA/t/ty/ZgWuAel+J27n+XHO2hU9qfCqc=;
        b=p9P+0Tx0Yi24CVLn26fSncVi2CO6fdCS6/WcvYDvCTMolU+i2/hWDF/E/9ZOodvvPM
         D03xkSHBy5iBsOk0fvT+gGsDIn40hfHv1gqPpBQU5ec70vbkNrBo5bwugrRQqlMfupsU
         XDMBApEu7sbWXDTOxteoqA9gi+yGCay2EuTq/kj8ixmTKgAAhLlizcD7mSZhgt8D20dw
         1mfGaBSCMlXCIVXbQp6FN0ih0vbEkFvtH+4AhpgpYbBIjK/5BxLXx1/1ZWPx/uDz9IFJ
         LSmfEr43VgXpDER2t7T2twc8wxcXo0yDueMWi4PPpBHLNXoEf6Oi4IlKg+G1x+gxCuN2
         BtKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BKjqvqbDioqA/t/ty/ZgWuAel+J27n+XHO2hU9qfCqc=;
        b=L/ezhut9P/yGVThFgod3yj7Nswi6MeUmwjakiv6ZYqQ6CXXh976e2BdgHnwlCAQ5Zd
         ihaoHnB+4gIyRbAcgoDuJtb7nrzQjNJ6hAJmEiM112SZEqj3+SASotpI341IfzKA0zKG
         4IhklvvshFwJd6q7MPsZAj/QknLmEsQ5/uLeztEUQ9TLGiuqrRLcyFgCHF2uliSDccpX
         CYtBXxLf3ACJ/gQJIdb6Eb/JZ3+s9+RhyXJ+iWXW1WxujrsVJqqjTTVQ9XeakMllMDRD
         718FslPQlkbMjg17dgFqpV/w8kRgVoV90O1gEAuBawD7cZW7SgAcYv8JlGGcTu1UEnKo
         9ATw==
X-Gm-Message-State: ANoB5pmT8sgXIj+gZ/ahCqDRYon0YbBEeAP4U9RVRt6Ox6c60jmhJ1Wu
        LfeTCNUGX2lUxbdFRfXTdNc=
X-Google-Smtp-Source: AA0mqf4WKBDGcErHuuY90Srj+mbqmYEW26Vi7XfQnb+A+/djQU2xwGleQcXjQ41uMFpDPCU6OPC9MQ==
X-Received: by 2002:a17:902:a60d:b0:186:9b19:1dbb with SMTP id u13-20020a170902a60d00b001869b191dbbmr1925053plq.59.1668675867623;
        Thu, 17 Nov 2022 01:04:27 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id m13-20020a170902db0d00b00188767268ddsm731239plx.151.2022.11.17.01.04.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Nov 2022 01:04:27 -0800 (PST)
From:   Li-hao Kuo <lhjeff911@gmail.com>
To:     krzk@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
        amitk@kernel.org, rui.zhang@intel.com, robh+dt@kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lh.kuo@sunplus.com, Li-hao Kuo <lhjeff911@gmail.com>
Subject: [PATCH v11 2/2] dt-bindings: thermal: Add Sunplus schema
Date:   Thu, 17 Nov 2022 17:04:21 +0800
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
 - Reviewed by Mr. Rob Herring <robh+dt@kernel.org>

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

