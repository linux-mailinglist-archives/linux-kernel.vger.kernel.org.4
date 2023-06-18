Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242A67346C6
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 17:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjFRPNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 11:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjFRPNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 11:13:13 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464C3137;
        Sun, 18 Jun 2023 08:13:12 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-307d20548adso1746115f8f.0;
        Sun, 18 Jun 2023 08:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687101191; x=1689693191;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oxPv/Yf4Ohjyr/HMPVB1IDHR+64j2GjZCQu7s6Zg4G4=;
        b=YEmBA+2+do/1xH2G+keV1PSovoV8RspTcN/ch+vYVMv4XUUUQMPAqEe7joAC5rl/hI
         VqbW2pwx28SUIvn35YzR6/xznsAIJaLqkFBrAyTr4NzgmvN65lYxB4MpahIpA0cLfICn
         frSEcdaTJs9tbTSPMDve31W++rOOhflarj2AyWwNYQgstvvhYwYOw1ueKlAgJoyWTp2k
         wNDsJaleUshW4ETyeO3fxWV3MQ2k8upUO7DmJtIxcGGlKwafFCKnxvE7pmUIzKwCxws1
         pcBqk8/3rR2BZ+koLERlCCgbK1qQaafZnWMGGkiHVgrGjEcMH9Gn3q0qcVoG8nlPC65V
         7mww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687101191; x=1689693191;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oxPv/Yf4Ohjyr/HMPVB1IDHR+64j2GjZCQu7s6Zg4G4=;
        b=QK5JhQukQ9ph69sTmI4d66veeaLp+L4FCknXleRQBCnH2qJaGcTv4hJhTkYAWe62t5
         QdHRrAFiwYE4D9b2haxCBVCR8k0BXVvASYHlQPC9+tDBAC44lTTA3AsqwcZ9wjZPO4Zi
         5PT1nyXMKUAw+FnCVQ+Wc6wdOsXLGaHR0aMQtYR05u39bkz9HCwQ4wFFXC/rbIm6/4it
         WTa8Kp2JK965SEjCH4i5oBV4x9cYkBAetItyiT6KTUd6LTClJUbXxMa/WqIAbtu5ApBp
         IGEgsMtRbot1D7tgMyPo8hX27BQBMEA+EIj326qosYrLJThBXvIeLno3Gp14V0Bl3ehT
         92PA==
X-Gm-Message-State: AC+VfDzmeQ66dL1SntFVQx2YqlB+0YenhEYRxUCbwGnPQX1qhnU6+XSL
        np2EiKiGOF14ZBWP0LBm9/86V32NFbA=
X-Google-Smtp-Source: ACHHUZ74oE+Im5v8BcxvV0Dov2iMA8UpY4FztbdrC0OwN46U9ow1YYZLLKkbg+F/nOIvpBWqFfTSyg==
X-Received: by 2002:a5d:4bc1:0:b0:30a:ae5b:9e93 with SMTP id l1-20020a5d4bc1000000b0030aae5b9e93mr4554763wrt.11.1687101190571;
        Sun, 18 Jun 2023 08:13:10 -0700 (PDT)
Received: from standask-GA-A55M-S2HP ([188.123.113.247])
        by smtp.gmail.com with ESMTPSA id g18-20020a7bc4d2000000b003f8d0308604sm8065373wmk.9.2023.06.18.08.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jun 2023 08:13:10 -0700 (PDT)
Date:   Sun, 18 Jun 2023 17:13:08 +0200
From:   Stanislav Jakubek <stano.jakubek@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] dt-bindings: firmware: brcm,kona-smc: convert to YAML
Message-ID: <20230618151308.GA23586@standask-GA-A55M-S2HP>
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

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
Changes in V4:
  - collect Krzysztof's R-b
  - rebase on next-20230616

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

