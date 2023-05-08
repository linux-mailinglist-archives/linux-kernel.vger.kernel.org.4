Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15BF86FA1EB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 10:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbjEHILC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 04:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjEHILA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 04:11:00 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2869917DD1;
        Mon,  8 May 2023 01:10:57 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3063afa2372so3858832f8f.0;
        Mon, 08 May 2023 01:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683533455; x=1686125455;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gZzQbDwIq54TGwOHKDbI2uvd9sVc46yAUWFyBQuGbJg=;
        b=hbUjGDFV5CQsOv9onhQPCBwuRY4IN9eK7HcPShCVQXjlb9h4Bwtb2KyOtAF4DkUmBH
         BGFi1WXocHcThg+VntI9g0U8f1xopuWA1EXLkaXrKyzKfPwbUmg/bxaQ51T5uN7SYFPK
         9hiMKSj3GylvJ4IgkfYPMEOaPbr3Ov4Rtjv8c78ea/N7ascVba5PCFqbBSmH/nmDFjEC
         /da48CQqNcFk/nyf4XeUz3WGiMN5fG60crXiRDx6W8arTxJ50QYgWpezga2WAyG23hRn
         oTpXw4FkOAix2o1JEFxrdsrGnKhw2hgZ8CSnqWNrULGeAba/1cfVbC0nZszwPUEPxEKo
         xBkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683533455; x=1686125455;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gZzQbDwIq54TGwOHKDbI2uvd9sVc46yAUWFyBQuGbJg=;
        b=eiBc8yygFqziUPZIHGfbwkCdRSoNjh+loBv1dZKT42CBmq4teGjUjlrj/M6AHCsG0w
         pUvmvyVh+StIkMsZlriXcBZkf0J8BOj8siMWZBAAgsnqVgqPWJZMmYLRtBO3tzU7UOv8
         WmDY5+5F8ZktbbIyBNbBFHd1QwnzpVk1yVSqscE+ghkc0LQv4F4WgF8FrS56Blif2BU+
         8+DDOcur2mTMyUWIkekLWi6MM4rZkAtn7N957yJm06zaoB9wr8pgo0c4t+LBG4FtJaoz
         2RRRYVEZ5atbBnbEgHlob8iTn7BqNSEBKo/ZxXcgiy8CvydCsjkdTJL47ds5w3eFHJKf
         +fjg==
X-Gm-Message-State: AC+VfDxp64mxFHbU/8HIVwNLub1jydS609yICLnlfOz+H0zfK/duPHHz
        RtIwjnBdqFzI5KQG0mAZpeg=
X-Google-Smtp-Source: ACHHUZ4mLyM8tR18UiJRLGcmA8XkSwrexwnNJfUS3uxnPSGH5G1BgzoUakmFrJYAv5qQ7hnS+R7P8g==
X-Received: by 2002:a5d:6683:0:b0:301:2452:e4d with SMTP id l3-20020a5d6683000000b0030124520e4dmr6949770wru.46.1683533455597;
        Mon, 08 May 2023 01:10:55 -0700 (PDT)
Received: from standask-GA-A55M-S2HP ([188.123.113.247])
        by smtp.gmail.com with ESMTPSA id r9-20020adfe689000000b002f6dafef040sm10533052wrm.12.2023.05.08.01.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 01:10:55 -0700 (PDT)
Date:   Mon, 8 May 2023 10:10:53 +0200
From:   Stanislav Jakubek <stano.jakubek@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: firmware: brcm,kona-smc: convert to YAML
Message-ID: <20230508081053.GA4675@standask-GA-A55M-S2HP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Broadcom Kona family Secure Monitor bounce buffer bindings
to DT schema.

Changes during conversion:
  - move from misc to firmware subdirectory
  - add used, but previously undocumented SoC-specific compatibles
  - drop deprecated compatibles (they've been deprecated for ~10 years)

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---

Changes in V2:
  - move to firmware subdirectory (Krzysztof)
  - drop deprecated compatibles (Krzysztof)
  - adjusted commit message to reflect the above changes
  
 .../bindings/firmware/brcm,kona-smc.yaml      | 40 +++++++++++++++++++
 .../bindings/misc/brcm,kona-smc.txt           | 15 -------
 2 files changed, 40 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/firmware/brcm,kona-smc.yaml
 delete mode 100644 Documentation/devicetree/bindings/misc/brcm,kona-smc.txt

diff --git a/Documentation/devicetree/bindings/firmware/brcm,kona-smc.yaml b/Documentation/devicetree/bindings/firmware/brcm,kona-smc.yaml
new file mode 100644
index 000000000000..16c7928a0daa
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/brcm,kona-smc.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/firmware/brcm,kona-smc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom Kona family Secure Monitor bounce buffer
+
+description:
+  A bounce buffer used for non-secure to secure communications.
+
+maintainers:
+  - Florian Fainelli <f.fainelli@gmail.com>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - brcm,bcm11351-smc
+              - brcm,bcm21664-smc
+              - brcm,bcm23550-smc
+          - const: brcm,kona-smc
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    smc@3404c000 {
+        compatible = "brcm,bcm11351-smc", "brcm,kona-smc";
+        reg = <0x3404c000 0x400>; /* 1 KiB in SRAM */
+    };
+...
diff --git a/Documentation/devicetree/bindings/misc/brcm,kona-smc.txt b/Documentation/devicetree/bindings/misc/brcm,kona-smc.txt
deleted file mode 100644
index 05b47232ed9e..000000000000
--- a/Documentation/devicetree/bindings/misc/brcm,kona-smc.txt
+++ /dev/null
@@ -1,15 +0,0 @@
-Broadcom Secure Monitor Bounce buffer
------------------------------------------------------
-This binding defines the location of the bounce buffer
-used for non-secure to secure communications.
-
-Required properties:
-- compatible : "brcm,kona-smc"
-- DEPRECATED: compatible : "bcm,kona-smc"
-- reg : Location and size of bounce buffer
-
-Example:
-	smc@3404c000 {
-		compatible = "brcm,bcm11351-smc", "brcm,kona-smc";
-		reg = <0x3404c000 0x400>; //1 KiB in SRAM
-	};
-- 
2.25.1

