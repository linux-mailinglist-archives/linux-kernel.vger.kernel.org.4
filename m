Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8A36FA2B1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 10:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbjEHI5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 04:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233386AbjEHI5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 04:57:36 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5894821573;
        Mon,  8 May 2023 01:57:31 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f315712406so161980415e9.0;
        Mon, 08 May 2023 01:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683536250; x=1686128250;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZPLvkIvtLC6+B7znIWatvSXfTI7f9KmVz7fncKddhqI=;
        b=NOEQsRNjTZ34Mz97BXBCCVqgGl5hxzsvyCQjQnlgSOPoAcjn9ocfvJVVI3fPEQE5Rm
         73L8nnPYHfB8cV5rojUcjfRSMl6/iYOfr8hnUWVHAO51v8F16ib49cOqFoTUtaAVhIe2
         e/ZTThTcUoMS45GuWV6llj7BcIpwRS6Tx5XijCbhW6cunt5JSv6pVRS6kJ6e1T03T1A9
         fN0NwJzqC8BO+fVJEsDTQat7BsuMr2gCQEZ5Glfw4O9XZmasaJRJPFgyn/JyPnXEgfAA
         GEEhvAoyBYMSL0FU195P/+yFbOJ9CX4dIqG4Wc3Q8u6HN8UhR6k6PWW/QLv010aPDTAF
         WCSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683536250; x=1686128250;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZPLvkIvtLC6+B7znIWatvSXfTI7f9KmVz7fncKddhqI=;
        b=jgPpjDokjW5e5oF9fMrwqhyXg10n5oO21CaSTQ6AYWtJNIC/I6/KVJCmWxdsOsbIcq
         +cuuf0aA0jRH0vnnyC/gtQtnoN2YS97DSDg+nEWwjeaxEv3TohUGzun4sYfBDocZRGGb
         SNCUfLnFlHTtzq/9JPBPb2fycnyCp4CvUPmu/q5rLIAq6rANF90P8zIlbhVaBQd/Eq65
         cpIKeE7Hmszbz/nTI1UkpeTRo8/8gukdd3plYW7mxs5BlqHjcV3aZ74tG/fW72hxzMrz
         FnPK7gHV63bAnw57VwPFFRyZ4ObKkjJk6Q6rNMsg5KFyspx7HBoHwfOIGyfQ5Lu1TsEk
         Xx2w==
X-Gm-Message-State: AC+VfDw50YT8fiyYLxwM3Xod7BXCH8wkb1YPkuG3igHpELJadTOYbvBg
        6j3qF2QoeFbtUlKLDzL4fMYaPmE9mE13Iw==
X-Google-Smtp-Source: ACHHUZ5170gD0qWyViQhbwVMdfdLaGlswQv5lfQTrPjoCZkXRHlVbhXMlo+cLckFWAxjp0X3AnIJBw==
X-Received: by 2002:adf:dd83:0:b0:307:7d1a:20fd with SMTP id x3-20020adfdd83000000b003077d1a20fdmr5715126wrl.12.1683536249976;
        Mon, 08 May 2023 01:57:29 -0700 (PDT)
Received: from standask-GA-A55M-S2HP ([188.123.113.247])
        by smtp.gmail.com with ESMTPSA id z6-20020adff746000000b002f103ca90cdsm10656624wrp.101.2023.05.08.01.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 01:57:29 -0700 (PDT)
Date:   Mon, 8 May 2023 10:57:27 +0200
From:   Stanislav Jakubek <stano.jakubek@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: pwm: brcm,kona-pwm: convert to YAML
Message-ID: <20230508085727.GA7252@standask-GA-A55M-S2HP>
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

Convert Broadcom Kona family PWM controller bindings to DT schema.

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
 .../devicetree/bindings/pwm/brcm,kona-pwm.txt | 21 --------
 .../bindings/pwm/brcm,kona-pwm.yaml           | 51 +++++++++++++++++++
 2 files changed, 51 insertions(+), 21 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/brcm,kona-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt b/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt
deleted file mode 100644
index c42eecfc81ed..000000000000
--- a/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt
+++ /dev/null
@@ -1,21 +0,0 @@
-Broadcom Kona PWM controller device tree bindings
-
-This controller has 6 channels.
-
-Required Properties :
-- compatible: should contain "brcm,kona-pwm"
-- reg: physical base address and length of the controller's registers
-- clocks: phandle + clock specifier pair for the external clock
-- #pwm-cells: Should be 3. See pwm.yaml in this directory for a
-  description of the cells format.
-
-Refer to clocks/clock-bindings.txt for generic clock consumer properties.
-
-Example:
-
-pwm: pwm@3e01a000 {
-	compatible = "brcm,bcm11351-pwm", "brcm,kona-pwm";
-	reg = <0x3e01a000 0xc4>;
-	clocks = <&pwm_clk>;
-	#pwm-cells = <3>;
-};
diff --git a/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.yaml b/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.yaml
new file mode 100644
index 000000000000..d1a58d130708
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/brcm,kona-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom Kona family PWM controller
+
+description:
+  This controller has 6 channels.
+
+maintainers:
+  - Florian Fainelli <f.fainelli@gmail.com>
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - brcm,bcm11351-pwm
+      - const: brcm,kona-pwm
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  '#pwm-cells':
+    const: 3
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include "dt-bindings/clock/bcm281xx.h"
+
+    pwm@3e01a000 {
+       compatible = "brcm,bcm11351-pwm", "brcm,kona-pwm";
+       reg = <0x3e01a000 0xcc>;
+       clocks = <&slave_ccu BCM281XX_SLAVE_CCU_PWM>;
+       #pwm-cells = <3>;
+    };
+...
-- 
2.25.1

