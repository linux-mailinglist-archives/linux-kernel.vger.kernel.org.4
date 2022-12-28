Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF9565872A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 23:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbiL1WB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 17:01:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiL1WBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 17:01:24 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18657D12F;
        Wed, 28 Dec 2022 14:01:23 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id u9so41244731ejo.0;
        Wed, 28 Dec 2022 14:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LXpwDRhegkKqFBKPdsaD1Z/bgeJAmjFVHZvc5PWsjjE=;
        b=mEV36ZK+fCaMEqG4mCqf7EjZ6FEcrzK2F+Mr106XvI/3vuZEqfb6RA5+2sTYiaoSb1
         jtnM8CSYWdMhkaDFcBFlFg+6WiQAKTPDkHHJ8SJOWim5gNrnoRhV3ju6f9MeQda9uUKE
         IZRFLJPJdHoYBdwYwMFKJIcN1Bd9Po4Wax9bA1m/pZ/YGsHpFmYu27K2dqBefitDeY/b
         idcc4s4+sxWpVZj9/1SoNOKOc75A8AZIZHQcrPQDIX++e3NEWprn+1PHdUgci5wlywtV
         jfeqelvZ/y3sWwyIPDbWKO2ahfxvV3rLd1sBmSTGBHJlmMd4rQrkwWAROxB6Id33RZXZ
         KlgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LXpwDRhegkKqFBKPdsaD1Z/bgeJAmjFVHZvc5PWsjjE=;
        b=l/0zQxzg2znVbTISxcxN/hFCimnsiKQzdcI8FdL2BkG2xh6sUi76AnttfOAcLm83En
         Y08X5On0lUmEzoHFueGAxFN9p+Fb4eMLjK9Ey0WrsjXqNobvy5NrkOnM+KdLv1Pxy6XS
         jbDabICFgjHr+jEUhss34r9aEDBzRhvWMUeiWVur+kZQTyyEF+cuIlz4VNZm74j0jcU/
         8ycI6SJJbV4BFdKEu1yMPXRSs5mRMDsmwQEDEnSpaHiwB8vISWJbY1o3xuaXJnAuo0NT
         YoRULa12EY+fUfrCDyDRsg4OvYNDQ1smiIYgiCr+1yNUJaFmiD1dOayEGlCsIC8TplDP
         ev/w==
X-Gm-Message-State: AFqh2koytpL6Ot2OmvIcht/OdXkLE+S+aJDEDnPlWeUYKCkCkh7oa9Xl
        NNzC1uCUS2T8ikF8QduJFI0=
X-Google-Smtp-Source: AMrXdXvayKNs2MYNNK3ZiUuIf9BdTvY0mtNtigekQbnGc542UVm7F0Z961eejRZ1qUTItjDYTiwM9Q==
X-Received: by 2002:a17:906:60cb:b0:84b:b481:6188 with SMTP id f11-20020a17090660cb00b0084bb4816188mr12899468ejk.64.1672264881524;
        Wed, 28 Dec 2022 14:01:21 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id a14-20020a1709063a4e00b007e5856d6359sm7781741ejf.66.2022.12.28.14.01.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Dec 2022 14:01:20 -0800 (PST)
Message-ID: <5fa3aaca-4e49-8baa-68c4-2b3981400d3b@gmail.com>
Date:   Wed, 28 Dec 2022 23:01:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 1/2] dt-bindings: phy: rockchip: convert
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
 .../bindings/phy/rockchip,dp-phy.yaml         | 41 +++++++++++++++++++
 .../bindings/phy/rockchip-dp-phy.txt          | 26 ------------
 2 files changed, 41 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/rockchip,dp-phy.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/rockchip-dp-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/rockchip,dp-phy.yaml b/Documentation/devicetree/bindings/phy/rockchip,dp-phy.yaml
new file mode 100644
index 000000000..73f75ab1c
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/rockchip,dp-phy.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/rockchip,dp-phy.yaml#
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

