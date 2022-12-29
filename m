Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B10658B38
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 10:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbiL2Jtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 04:49:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiL2Jqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 04:46:47 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E5E13F96;
        Thu, 29 Dec 2022 01:44:31 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id fc4so43791580ejc.12;
        Thu, 29 Dec 2022 01:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iyphewPZOfLnxnaRNTB29uqTkJVQ86RQ4fAds/3h3Vs=;
        b=UILyHAR71jRgy8hhzyaRGBWZA/3j6ZCcj33u4g6LkDlrE7d1URoiSz+mXM6Ou1R8z8
         /uzl0JEIqBlkwRzFwi0//frG6jJ2zCgcvaBCwabhhOLn8extuXQgd53Ky/zuEShcIptW
         1SuMd/WZfftH+qhLMHuaebr8lAvHeaG9RVOQige+q1KYZdFf8FAS6FXljuYvD+B0QqJF
         36tiGKzHUQQ8Q7E3apO9vSfOEMcIRUxXa8Jk67Mvd5yDebFyaN2Vfwrg8q715sMkzPss
         fe+7mSLJxCbleoWaJgnroxnWH3wBvBAdORzAYFjSQlCedmjiV/T5D0AoNV7yfgZ20+oT
         9AAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iyphewPZOfLnxnaRNTB29uqTkJVQ86RQ4fAds/3h3Vs=;
        b=TTHRkSUuQgU3gOCbWwtpVUcRh0gjC9TwGCXjmWYR4/3CkyUZ+6Aadyw/QyTEtoer+z
         OA01Z4alIO7/haj0Cp1Mcht2OTefuOXfVt69BTaPAFGJfK//Y9TsszWY9CIVSd+FJgvc
         PGxofLoEWvuZD3tNQ7CiHGfpKsDvmatoACThbicBTNpZw/Z/HVpQ74OZLsQfuRp8QtH8
         sgGkYIXegW3WxJUWuOMFE3gBu6rJrXw024xKo5sm5LQ9yauIPWVIE2jL/DMDtIFVTMDs
         iKrjVgduV0ZXQQqIu4dIemtzkFYvSFZ8FsTvdCSYJWx8oH0oodgnTYW6oUNiVQpllmke
         00iQ==
X-Gm-Message-State: AFqh2kquW1LNZ/eFwJuzz2+LwPEMFxEQ5+zm8aCUEeEzmmbrJ4EbKC/l
        6PMeb98h35/K8AD0HwAvG/k=
X-Google-Smtp-Source: AMrXdXsZL1j1TTNvr8CasU6e9oELKnEX7gPztZg2Fjnd1DsSXTPke5G6cc0hnwJgSA2jIWfVe3gKLw==
X-Received: by 2002:a17:907:a782:b0:7c1:6430:e5d0 with SMTP id vx2-20020a170907a78200b007c16430e5d0mr24247352ejc.4.1672307070247;
        Thu, 29 Dec 2022 01:44:30 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id o11-20020a170906768b00b0077b523d309asm8357801ejm.185.2022.12.29.01.44.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Dec 2022 01:44:29 -0800 (PST)
Message-ID: <aa6fe473-71f2-edba-f009-994a3dbc9802@gmail.com>
Date:   Thu, 29 Dec 2022 10:44:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v2 1/2] dt-bindings: phy: rockchip: convert
 rockchip-dp-phy.txt to yaml
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-phy@lists.infradead.org,
        vkoul@kernel.org, kishon@kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert rockchip-dp-phy.txt to yaml.

Changed:
  rename file name

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

Changed V2:
  Use the compatible as filename.
---
 .../bindings/phy/rockchip,rk3288-dp-phy.yaml  | 41 +++++++++++++++++++
 .../bindings/phy/rockchip-dp-phy.txt          | 26 ------------
 2 files changed, 41 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/rockchip,rk3288-dp-phy.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/rockchip-dp-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/rockchip,rk3288-dp-phy.yaml b/Documentation/devicetree/bindings/phy/rockchip,rk3288-dp-phy.yaml
new file mode 100644
index 000000000..2538235c5
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/rockchip,rk3288-dp-phy.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/rockchip,rk3288-dp-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip specific extensions to the Analogix Display Port PHY
+
+maintainers:
+  - Heiko Stuebner <heiko@sntech.de>
+
+properties:
+  compatible:
+    const: rockchip,rk3288-dp-phy
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: 24m
+
+  "#phy-cells":
+    const: 0
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+  - "#phy-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/rk3288-cru.h>
+    edp-phy {
+      compatible = "rockchip,rk3288-dp-phy";
+      clocks = <&cru SCLK_EDP_24M>;
+      clock-names = "24m";
+      #phy-cells = <0>;
+    };
diff --git a/Documentation/devicetree/bindings/phy/rockchip-dp-phy.txt b/Documentation/devicetree/bindings/phy/rockchip-dp-phy.txt
deleted file mode 100644
index e3b4809fb..000000000
--- a/Documentation/devicetree/bindings/phy/rockchip-dp-phy.txt
+++ /dev/null
@@ -1,26 +0,0 @@
-Rockchip specific extensions to the Analogix Display Port PHY
-------------------------------------
-
-Required properties:
-- compatible : should be one of the following supported values:
-	 - "rockchip.rk3288-dp-phy"
-- clocks: from common clock binding: handle to dp clock.
-	of memory mapped region.
-- clock-names: from common clock binding:
-	Required elements: "24m"
-- #phy-cells : from the generic PHY bindings, must be 0;
-
-Example:
-
-grf: syscon@ff770000 {
-	compatible = "rockchip,rk3288-grf", "syscon", "simple-mfd";
-
-...
-
-	edp_phy: edp-phy {
-		compatible = "rockchip,rk3288-dp-phy";
-		clocks = <&cru SCLK_EDP_24M>;
-		clock-names = "24m";
-		#phy-cells = <0>;
-	};
-};
--
2.20.1

