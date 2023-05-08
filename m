Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2427F6FA7BC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 12:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234820AbjEHKeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 06:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234749AbjEHKd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 06:33:57 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323282674A;
        Mon,  8 May 2023 03:33:02 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3062b101ae1so2680664f8f.2;
        Mon, 08 May 2023 03:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683541977; x=1686133977;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5RO31PIvOJ1a+cgiuJEFwT9RyHnjbLWAMpuWQH4KIaA=;
        b=LTe8i/EEI090DJOGzB6O8dy8nt7yJ29tkNzWmyiXQ/QaXCPWnIHwSAIb7Gult7iaVR
         RXXWmCqC0C4cwaQb6N00PRITSZeG18Su4yucjYPo280JqskpqwG6CIxtLf+rUsi4r5Yl
         fSzxO+sCpUeYhH5EI20ELsHRRoBMgRXy+Fd0GEYmsYNj1T51PKxVTD9x7uNeKuX5EZoP
         YLioH6cqA6ZqEVGYbVVfCK62sI3BZjlingJ+tdcqtOjWyNokyzInctZTXO1Ql2FsKl0X
         wb6VzscfnaQGyu0JfStfa0EfXvaFgUUBtFkPEdVZRVnvnkTpRfp2hPVgTr1PO5cyLc5v
         GIxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683541977; x=1686133977;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5RO31PIvOJ1a+cgiuJEFwT9RyHnjbLWAMpuWQH4KIaA=;
        b=bA3QyrtK+ANJyrJpXnO5z6HIoHj8Jtezw6d+K2G2Fr8/btDyf+LPp9vVXCS9gXTxby
         EXnw63gWHD3TH1tpv9/ZmBsSrguR6axIRNZnbvqNuhpYxor5FXQZISXbR/hDG8DRYjZS
         gsYNOr5Y67C+dfuphXjJSDZaR0wLTMTpydrIN1gmgMGZ4AguV+nCSwBCG3RiuXiAmy9M
         wQYG2bNyndFmJQkBouDxQh5HbwC46uIpDDhw8Lwoaa0zOxo/F8yP1kUTEPPO56xpRQ0N
         KWZkFQqwsnCkg1CwoeNRvQgWale3jBgTn8CwuxdETyuLqBzoLfxIh2/XXnAzQ+owD6rE
         mZJg==
X-Gm-Message-State: AC+VfDxmea6T9lZekikbiyyiKunKx0L+Lxsyqc7ftGCE4a/DbXtwMlDw
        e2sI4PvAYoKorvBC45TBsaDqu/i8zh/LRw==
X-Google-Smtp-Source: ACHHUZ6fBe+qiJgUVzfdb6H6qzEqFT1QwIdcbJsLKwaksUowloncRa2eTgJ2kBkRYnXxoikN1qwAcg==
X-Received: by 2002:a5d:4570:0:b0:2fe:c0ea:18b5 with SMTP id a16-20020a5d4570000000b002fec0ea18b5mr6094585wrc.35.1683541977506;
        Mon, 08 May 2023 03:32:57 -0700 (PDT)
Received: from standask-GA-A55M-S2HP ([188.123.113.247])
        by smtp.gmail.com with ESMTPSA id k11-20020adff5cb000000b0030649242b72sm10931916wrp.113.2023.05.08.03.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 03:32:57 -0700 (PDT)
Date:   Mon, 8 May 2023 12:32:55 +0200
From:   Stanislav Jakubek <stano.jakubek@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] dt-bindings: firmware: brcm,kona-smc: convert to YAML
Message-ID: <20230508103255.GA18424@standask-GA-A55M-S2HP>
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
Changes in V3:
  - remove unnecessary oneOf (Krzysztof)

Changes in V2:
  - move to firmware subdirectory (Krzysztof)
  - drop deprecated compatibles (Krzysztof)
  - adjusted commit message to reflect the above changes
  
 .../bindings/firmware/brcm,kona-smc.yaml      | 39 +++++++++++++++++++
 .../bindings/misc/brcm,kona-smc.txt           | 15 -------
 2 files changed, 39 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/firmware/brcm,kona-smc.yaml
 delete mode 100644 Documentation/devicetree/bindings/misc/brcm,kona-smc.txt

diff --git a/Documentation/devicetree/bindings/firmware/brcm,kona-smc.yaml b/Documentation/devicetree/bindings/firmware/brcm,kona-smc.yaml
new file mode 100644
index 000000000000..684b15ba9ad0
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/brcm,kona-smc.yaml
@@ -0,0 +1,39 @@
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
+    items:
+      - enum:
+          - brcm,bcm11351-smc
+          - brcm,bcm21664-smc
+          - brcm,bcm23550-smc
+      - const: brcm,kona-smc
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

