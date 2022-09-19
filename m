Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53FD35BD73F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 00:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiISWZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 18:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiISWZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 18:25:13 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9728513E97;
        Mon, 19 Sep 2022 15:25:11 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id e18so1265163edj.3;
        Mon, 19 Sep 2022 15:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=krzfWY+U+C68iDb788Ps/isqFlp7Jns624VMj/Zic0w=;
        b=fO8nIdegJnYZSRDU3a+VlcKRlEqWcPuKtYKcsYbLbVVbbLpAAJj12c0L6u2WrWWn4m
         e4RgFEpnzIhLolF1MB10MsulZCjHG52OJM40NUQ6rS15bsMgPcPymwCvRvdf0U2FWGGE
         iWnrFt4cOhDi4Xy0cRsNeFDhg96YxBmgbHQTTMr2MxspWaVf/IvLvJW1H6D6nvY4S7b9
         zVtn3JMob54SIJ5CW5FA7qLuJK54S8vSfGizvauuJ7/iiF7AqDVB0xTknKcUK5Ja9D6d
         CJvWv5I4VX+L3X16kgy+B7+R0a9Jz/WwBeM3PVJBFBlNQu+lNuEfw42BTpzFB+LVP5kx
         ni0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=krzfWY+U+C68iDb788Ps/isqFlp7Jns624VMj/Zic0w=;
        b=3JUbV3zlcwRenvPM5TcS2Ug3MZc8wgwIXNdRMMIaWjwvxm/5baSJ+CcQnqatYfF+Je
         D1uWI8ERB+KY1FBLrAerqD2gKOW52bcnprbyiZhYzadHniiOeuGMvxCAwTQf0QBJScfJ
         yPzg5WBsgIg/K4dwvtb0D+A+d6fYC7Hw7/CRRCoQ1EFWbaZ1S0nn8LSEkmGHUlpLgkF7
         u6YRE+03yY9B4SPK1Vi7eO9ActOk0kcQjHtkzAIH+4U6y8+4Uc3R2HsrcqPSXeSlYPYH
         lS0hEvSDkA3FIFzxQJEaHMBg3Jr75VCQuo/9XzshhKs+AiuZurXIy2vxdnFhS5TkQSzR
         b+Sw==
X-Gm-Message-State: ACrzQf2fqvD0vJnMAvOykvXZJwYLAaqPfRynb+CpISEZ53iWwAWJBmTn
        L2voTd98RIOIWUUervtGCR/yYhl38xE=
X-Google-Smtp-Source: AMsMyM7aMIM27Gmv/KDNMjmjSw8seFcCELcWjbwpbxYL4wAjDBR/TRExa/X0MA2mps43ZhhKg1k2QA==
X-Received: by 2002:aa7:c7d3:0:b0:44f:2776:31b with SMTP id o19-20020aa7c7d3000000b0044f2776031bmr17736474eds.251.1663626309950;
        Mon, 19 Sep 2022 15:25:09 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id e19-20020a50ec93000000b004528a535b44sm13694319edr.32.2022.09.19.15.25.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 15:25:09 -0700 (PDT)
Message-ID: <20c6a502-2ff5-bdb1-fb4f-0741f3a2c19c@gmail.com>
Date:   Tue, 20 Sep 2022 00:25:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v2] dt-bindings: clock: rockchip: change
 SPDX-License-Identifier
To:     heiko@sntech.de, zhangqing@rock-chips.com,
        finley.xiao@rock-chips.com, shawn.lin@rock-chips.com,
        zhengxing@rock-chips.com, jeffy.chen@rock-chips.com,
        andy.yan@rock-chips.com, mylene.josserand@collabora.com,
        nfraprado@collabora.com, eric@engestrom.ch
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sboyd@kernel.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change SPDX-License-Identifier to (GPL-2.0+ OR MIT)
for Rockchip clock bindings.

Cc: Heiko Stübner <heiko@sntech.de>
Cc: Elaine Zhang <zhangqing@rock-chips.com>
Cc: Xing Zheng <zhengxing@rock-chips.com>
Cc: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: Finley Xiao <finley.xiao@rock-chips.com>
Cc: Andy Yan <andy.yan@rock-chips.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Eric Engestrom <eric@engestrom.ch>
Cc: Mylène Josserand <mylene.josserand@collabora.com>
Cc: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

Request for copyright holder approval.
Rockchip recently replied on other clock-patches to dual-license the
binding.

https://lore.kernel.org/all/510d1180-bc8e-7820-c772-ed7f35447087@rock-chips.com/
From Finley with an  @rock-chips.com address, so this should be ok.

---

Changed V2:
  Use GPL-2.0+ OR MIT license
  Add more CC

---

git log Documentation/devicetree/bindings/clock/*px30*.txt

Author: Heiko Stuebner <heiko@sntech.de>
    arm64: dts: rockchip: document explicit px30 cru dependencies

Author: Elaine Zhang <zhangqing@rock-chips.com>
    dt-bindings: add bindings for px30 clock controller

===

git log Documentation/devicetree/bindings/clock/*rk3036*.txt

Author: Xing Zheng <zhengxing@rock-chips.com>
    clk: rockchip: rk3036: rename emac ext source clock

Author: Xing Zheng <zhengxing@rock-chips.com>
    dt-bindings: add documentation of rk3036 clock controller

===

git log Documentation/devicetree/bindings/clock/*rk3188*.txt

Author: Eric Engestrom <eric@engestrom.ch>
    Documentation: dt: clock: fix spelling mistakes

Author: Heiko Stübner <heiko@sntech.de>
    dt-bindings: add documentation for rk3188 clock and reset unit

===

git log Documentation/devicetree/bindings/clock/*rk3228*.txt

Author: Jeffy Chen <jeffy.chen@rock-chips.com>
    dt-bindings: add documentation of rk3228 clock controller

===

git log Documentation/devicetree/bindings/clock/*rk3288*.txt

Author: Mylène Josserand <mylene.josserand@collabora.com>
    dt-bindings: clocks: add rk3288w variant compatible

Author: Eric Engestrom <eric@engestrom.ch>
    Documentation: dt: clock: fix spelling mistakes

Author: Heiko Stübner <heiko@sntech.de>
    dt-bindings: add documentation for rk3288 cru

===

git log Documentation/devicetree/bindings/clock/*rk3308*.txt

Author: Finley Xiao <finley.xiao@rock-chips.com>
    dt-bindings: Add bindings for rk3308 clock controller

===

git log Documentation/devicetree/bindings/clock/*rk3368*.txt

Author: Heiko Stuebner <heiko@sntech.de>
    dt-bindings: add documentation of rk3668 clock controller

===

git log Documentation/devicetree/bindings/clock/*rk3399*.txt

Author: Nícolas F. R. A. Prado <nfraprado@collabora.com>
    dt-bindings: clk: Convert rockchip,rk3399-cru to DT schema

Author: Xing Zheng <zhengxing@rock-chips.com>
    dt-bindings: clk: add rockchip,grf property for RK3399

Author: Xing Zheng <zhengxing@rock-chips.com>
    dt-bindings: add bindings for rk3399 clock controller

===

git log Documentation/devicetree/bindings/clock/*rk11*.txt

Author: Andy Yan <andy.yan@rock-chips.com>
    dt-bindings: rk1108-cru: rename RK1108 to RV1108

Author: Shawn Lin <shawn.lin@rock-chips.com>
    dt-bindings: add documentation for rk1108 cru
---
 Documentation/devicetree/bindings/clock/rockchip,px30-cru.yaml  | 2 +-
 .../devicetree/bindings/clock/rockchip,rk3036-cru.yaml          | 2 +-
 .../devicetree/bindings/clock/rockchip,rk3228-cru.yaml          | 2 +-
 .../devicetree/bindings/clock/rockchip,rk3288-cru.yaml          | 2 +-
 .../devicetree/bindings/clock/rockchip,rk3308-cru.yaml          | 2 +-
 .../devicetree/bindings/clock/rockchip,rk3368-cru.yaml          | 2 +-
 .../devicetree/bindings/clock/rockchip,rk3399-cru.yaml          | 2 +-
 .../devicetree/bindings/clock/rockchip,rv1108-cru.yaml          | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/rockchip,px30-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,px30-cru.yaml
index 3eec381c7cf5..0f0f64b6f8cb 100644
--- a/Documentation/devicetree/bindings/clock/rockchip,px30-cru.yaml
+++ b/Documentation/devicetree/bindings/clock/rockchip,px30-cru.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0
+# SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/clock/rockchip,px30-cru.yaml#
diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3036-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rk3036-cru.yaml
index 1376230fede6..ba5b45464315 100644
--- a/Documentation/devicetree/bindings/clock/rockchip,rk3036-cru.yaml
+++ b/Documentation/devicetree/bindings/clock/rockchip,rk3036-cru.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0
+# SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/clock/rockchip,rk3036-cru.yaml#
diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3228-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rk3228-cru.yaml
index cf7dc01d9478..1050fff72ade 100644
--- a/Documentation/devicetree/bindings/clock/rockchip,rk3228-cru.yaml
+++ b/Documentation/devicetree/bindings/clock/rockchip,rk3228-cru.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0
+# SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/clock/rockchip,rk3228-cru.yaml#
diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3288-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rk3288-cru.yaml
index 96bc05749e1a..6655e97d52e4 100644
--- a/Documentation/devicetree/bindings/clock/rockchip,rk3288-cru.yaml
+++ b/Documentation/devicetree/bindings/clock/rockchip,rk3288-cru.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0
+# SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/clock/rockchip,rk3288-cru.yaml#
diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3308-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rk3308-cru.yaml
index 523ee578a586..fec37f5b80f6 100644
--- a/Documentation/devicetree/bindings/clock/rockchip,rk3308-cru.yaml
+++ b/Documentation/devicetree/bindings/clock/rockchip,rk3308-cru.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0
+# SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/clock/rockchip,rk3308-cru.yaml#
diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3368-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rk3368-cru.yaml
index adb67877720d..90af242b41c1 100644
--- a/Documentation/devicetree/bindings/clock/rockchip,rk3368-cru.yaml
+++ b/Documentation/devicetree/bindings/clock/rockchip,rk3368-cru.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0
+# SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/clock/rockchip,rk3368-cru.yaml#
diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.yaml
index 54da1e31ea73..0b758e015ee3 100644
--- a/Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.yaml
+++ b/Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only
+# SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/clock/rockchip,rk3399-cru.yaml#
diff --git a/Documentation/devicetree/bindings/clock/rockchip,rv1108-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rv1108-cru.yaml
index 20421c22f184..4611d920b8df 100644
--- a/Documentation/devicetree/bindings/clock/rockchip,rv1108-cru.yaml
+++ b/Documentation/devicetree/bindings/clock/rockchip,rv1108-cru.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0
+# SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/clock/rockchip,rv1108-cru.yaml#
-- 
2.20.1

