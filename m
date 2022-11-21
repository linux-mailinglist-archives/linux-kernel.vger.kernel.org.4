Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A71631DBE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 11:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbiKUKHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 05:07:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiKUKHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 05:07:09 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1B5A342F;
        Mon, 21 Nov 2022 02:07:08 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id a22-20020a17090a6d9600b0021896eb5554so4915092pjk.1;
        Mon, 21 Nov 2022 02:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eVx5B9anLi6E4Dp71/Pau4amxek3Q2B7q9d4r++NqTE=;
        b=H5Evf/JzuswLRVBqeMs6gTbGSzHSqlFlIGUGcdR97UJRTbEv0ixRRxCBYNxMymaR2L
         +MGClYYZIF/Tl9etPLkUOxjGOD1+/9mB2CqUNej/Uu4zWd04G/B2izRzqDPnToxhDBBV
         3HfCbAWWq633yvyn+RPJkjBKvj4XMvd6etlJTDhpkkG5rEZstGS8pyA8IedM0+xNsMTb
         3DbJyiGARk1M9QVNPj9qLyXSfBUuewnR1qYKEDvTGb71gwvia8EI1Jg55qCVSdjp5Cnq
         SMXvAAGVffhMBbuaTExdiVR7b7gkEwru0Eh9yJdU+GqOe3ehwO5AC0CRkMmEH+vZgeIC
         PbhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eVx5B9anLi6E4Dp71/Pau4amxek3Q2B7q9d4r++NqTE=;
        b=5GpspkjaQLXhlTATbKTWUNRcW7Ivdlcb83iYkYNU8aNN83Ybd5EDrrp3nUXOWQHcF4
         JqKz77ySbr19mHAOjvh+571l4N1mEUzMlErUVwHbN+rWcZFLrS5JCDl9OfMr5Zf9y5mM
         2vNfdzf51NYDWn+OYfW/liHmbV6mkx1priH9FYZxwB8DedHXwHoT9wimrVDvNurkuozn
         Ng9r9mDDUYywNJtS9X9yoKM4Jar+5Plw9BbottDxiREUmDjWJXnSAopt1VO5tOTl7HQK
         Dd4ogerU3YWS0qpU6cc6A+qYBa/Vs+iFEWviqoXBzA1NxKO+LkC/N7CVsl/zYdVcrNun
         8Qqg==
X-Gm-Message-State: ANoB5pm/Kiah7v67qi5TWCU4R4crkqvRSJ4YSOANdJ5vfn68LFvXD7jx
        /tN+vLe6gms7cehP8RxAmySLfQUDR8c=
X-Google-Smtp-Source: AA0mqf4ES0tt7pwXHvGL/wsH26y6prZnAHDOZ/CMxcOR+BE57cGFfKtkFAX2ZmMfIL94j7VKxxw3Bw==
X-Received: by 2002:a17:902:a9c6:b0:188:52df:769e with SMTP id b6-20020a170902a9c600b0018852df769emr775763plr.30.1669025227878;
        Mon, 21 Nov 2022 02:07:07 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id oj8-20020a17090b4d8800b001df264610c4sm23069042pjb.0.2022.11.21.02.07.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Nov 2022 02:07:07 -0800 (PST)
From:   Tony Huang <tonyhuang.sunplus@gmail.com>
To:     tonyhuang.sunplus@gmail.com, lhjeff911@gmail.com,
        ulf.hansson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, wells.lu@sunplus.com
Subject: [PATCH v12 1/2] dt-binding: mmc: Add mmc yaml file for Sunplus SP7021
Date:   Mon, 21 Nov 2022 18:06:48 +0800
Message-Id: <8c8fbc29524819d8ab45a4fe75311b3b7b567650.1669023361.git.tonyhuang.sunplus@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1669023361.git.tonyhuang.sunplus@gmail.com>
References: <cover.1669023361.git.tonyhuang.sunplus@gmail.com>
In-Reply-To: <cover.1669023361.git.tonyhuang.sunplus@gmail.com>
References: <cover.1669023361.git.tonyhuang.sunplus@gmail.com>
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

Changes in v12:
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
index 2585e7e..2d90fe6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19748,6 +19748,12 @@ W:	https://sunplus.atlassian.net/wiki/spaces/doc/overview
 F:	Documentation/devicetree/bindings/net/sunplus,sp7021-emac.yaml
 F:	drivers/net/ethernet/sunplus/
 
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

