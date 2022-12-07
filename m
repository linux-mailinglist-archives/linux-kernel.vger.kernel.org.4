Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E396B64538E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 06:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiLGFur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 00:50:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiLGFul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 00:50:41 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB3456EF7;
        Tue,  6 Dec 2022 21:50:40 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id f3so15363122pgc.2;
        Tue, 06 Dec 2022 21:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O+1ypejFU1APOd5GvvtQXEabTn9dSYDIqBBadKI7UOk=;
        b=S80NPILH4Yzmh0UMLbWNZ05TGTXvcs+9VSyJLZJKyGIdHBlnPULYtQnTjd3ZYhGrBJ
         3n5h+EnFsJGUoRaq6szX1c7h9avw2oSjMnFUNpL8TDFgdbTRusER5SGR7eE2rOTKzEMT
         r18SgDIwH1N24V1Ew/SDzZIzNQVFAlqsQF1/+E7TK7AXuyZ+FTZvGheTyZ12tF1/xXYM
         fO0+VfDvGYtCjwctUEa3pCkAnZWi3EJlxDnxI+B3p+id4HMreINkTwQFW35wYGNIL5YO
         eRNSDVf40fqwqExUN3XnLubiNyawfnGs2K8qs2WXWJDqifnUwG+kvUBkaLIjiLSINEd4
         THIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O+1ypejFU1APOd5GvvtQXEabTn9dSYDIqBBadKI7UOk=;
        b=pkh2NoX1g7XnwRc8vS2ykQDr6wwX/jaM9DuS0812zlQs2YnqxenvTMvx9TfNHDVMmM
         R5aEOWsXcaYy6Cr3tvhFRWb2ewjPHHsq2ErASITBk0TEVJ6WJWTLRSBFHhGwprvgUSzh
         S3wan1gLEgPZ3K0W6anBS7A3XdssVC8R0qUxmYPic3IMZabnU/Mu5UjAgZAVCdV1/Y7A
         sni7f1QDQ8SyJJuX21QJUF0F/eL2tlzqxureulZ9d8pNme+JwhqVreSl2GEjarOUt3gt
         fyiDX56s5de1mU+u0jReG/v7r2XZ1eetryyw3rOZugGR/322+cwN3/zHV+tn8I6iJvU7
         BaEA==
X-Gm-Message-State: ANoB5pkoUVyig3VrDHyrHrgF5xG27b2hx5AZkx7Nq/jckPHZdjOHsUH9
        gdDkRu2vjOkUje1Js+9L2ag=
X-Google-Smtp-Source: AA0mqf5xMOeLZ/Tdsv7e/61cmANIw/ZO/tTxReqLKGh8ogspeOuLzhqvVPp5mLyFRh2cSTTB9DHkNA==
X-Received: by 2002:a63:230e:0:b0:470:86e3:b93e with SMTP id j14-20020a63230e000000b0047086e3b93emr64149999pgj.337.1670392239525;
        Tue, 06 Dec 2022 21:50:39 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id e7-20020a630f07000000b004777c56747csm10585615pgl.11.2022.12.06.21.50.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Dec 2022 21:50:39 -0800 (PST)
From:   Li-hao Kuo <lhjeff911@gmail.com>
To:     rafael@kernel.org, krzk@kernel.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amitk@kernel.org, robh+dt@kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lh.kuo@sunplus.com, Li-hao Kuo <lhjeff911@gmail.com>
Subject: [PATCH v13 2/2] dt-bindings: thermal: Add Sunplus schema
Date:   Wed,  7 Dec 2022 13:50:36 +0800
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

