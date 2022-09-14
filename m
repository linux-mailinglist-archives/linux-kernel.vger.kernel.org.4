Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08475B869E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 12:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiINKu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 06:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiINKuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 06:50:51 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14F5578AF;
        Wed, 14 Sep 2022 03:50:49 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id dv25so33702310ejb.12;
        Wed, 14 Sep 2022 03:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=wpXuLValBWZP/zsjY+A/TTXQD/M5Ih3exq/CAis/KV4=;
        b=KR5cNVuGyLreJdEwSguHZcLjR67Yrc8eSXryirIPnTbfK7hukpa0bMR5bZthCe2R8D
         H7I4pCJlDqLsrs01RgUiuWH5+ixtVerhc1JWt78BnangoiwxjlXcSTt0iXFbbSPer46P
         1gR8TUIM9vZkeZMiJ3pULe8rpPxESiA8IyRMQ4qlDV7d3RplQiwmgQj4DDOGLQICB5X8
         zFDU2OTUK3y/MY/kWApsvJvzLNiXp1Yr9lI//GymPOyNKfCEbVIu0VJICPsJ8AeAFmcj
         vFm8/7ZuEqfjqEDQs2TbQoSsC9gJBVxmtZexVkDyqsL4z+90V6CDMg8wvXhFdCQTeqYi
         8lDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=wpXuLValBWZP/zsjY+A/TTXQD/M5Ih3exq/CAis/KV4=;
        b=t8iYHZorLwULUjPoCQKTv84nTEsYKeUDqFai6xHUaAsdJMxe73lGrbIAKdBp/l9QVr
         me7pdm322HEhVlhcgepSCq57C8MLmKiUhIvorLucVHKn3+grItHhh+bIKuKXTxjqzpDN
         McWzSjgFZNanqZqHvrdxLeuqhOgvk2hsG5tLzta/HeFr3GSGyOiy7rTu/h3rVe9MRq53
         cWHKF330IMUayfBjEI6huAZqfABKwKbNLNcMfGYfqmZFVig9qgp3WEM6/0gRfi6gSviU
         GqTy5bNAapkWGEVgIjjNlVUvU9dq8ckabEt5vWPpINcwROtKgpnnuwufqBhr9QgsVAoH
         oZ9Q==
X-Gm-Message-State: ACgBeo3Yn8bBFXZ+nECyylPRRX/hJ51VYTPUNAiMd744l99MUc00j22/
        cpktHFNSyexK5exjkA9vJPc=
X-Google-Smtp-Source: AA6agR57Ct4WYUR7jRYjlimTKGNY/sfvUSeQJTWA+6ZOqZmcdQcywa0lV0N+PBrpH4ROtVU0ncwKdw==
X-Received: by 2002:a17:907:7f04:b0:77d:5bad:46d7 with SMTP id qf4-20020a1709077f0400b0077d5bad46d7mr9985823ejc.663.1663152648005;
        Wed, 14 Sep 2022 03:50:48 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id g8-20020a17090669c800b0073d8ad7feeasm7316219ejs.213.2022.09.14.03.50.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Sep 2022 03:50:47 -0700 (PDT)
Message-ID: <d70fa056-608d-0c19-7948-c67b15a4246e@gmail.com>
Date:   Wed, 14 Sep 2022 12:50:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1] dt-bindings: clock: rockchip: change
 SPDX-License-Identifier
To:     heiko@sntech.de, zhangqing@rock-chips.com,
        finley.xiao@rock-chips.com, shawn.lin@rock-chips.com,
        zhengxing@rock-chips.com, jeffy.chen@rock-chips.com,
        jay.xu@rock-chips.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sboyd@kernel.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change SPDX-License-Identifier to (GPL-2.0-only OR BSD-2-Clause)
for Rockchip clock bindings.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

Request for copyright holder approval.
---
 Documentation/devicetree/bindings/clock/rockchip,px30-cru.yaml  | 2 +-
 .../devicetree/bindings/clock/rockchip,rk3036-cru.yaml          | 2 +-
 .../devicetree/bindings/clock/rockchip,rk3188-cru.yaml          | 2 +-
 .../devicetree/bindings/clock/rockchip,rk3228-cru.yaml          | 2 +-
 .../devicetree/bindings/clock/rockchip,rk3288-cru.yaml          | 2 +-
 .../devicetree/bindings/clock/rockchip,rk3308-cru.yaml          | 2 +-
 .../devicetree/bindings/clock/rockchip,rk3368-cru.yaml          | 2 +-
 .../devicetree/bindings/clock/rockchip,rk3399-cru.yaml          | 2 +-
 .../devicetree/bindings/clock/rockchip,rk3568-cru.yaml          | 2 +-
 .../devicetree/bindings/clock/rockchip,rv1108-cru.yaml          | 2 +-
 10 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/rockchip,px30-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,px30-cru.yaml
index 3eec381c7..cb20a632c 100644
--- a/Documentation/devicetree/bindings/clock/rockchip,px30-cru.yaml
+++ b/Documentation/devicetree/bindings/clock/rockchip,px30-cru.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/clock/rockchip,px30-cru.yaml#
diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3036-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rk3036-cru.yaml
index 1376230fe..ffac332b9 100644
--- a/Documentation/devicetree/bindings/clock/rockchip,rk3036-cru.yaml
+++ b/Documentation/devicetree/bindings/clock/rockchip,rk3036-cru.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/clock/rockchip,rk3036-cru.yaml#
diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3188-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rk3188-cru.yaml
index ddd7e46af..6979ed1c4 100644
--- a/Documentation/devicetree/bindings/clock/rockchip,rk3188-cru.yaml
+++ b/Documentation/devicetree/bindings/clock/rockchip,rk3188-cru.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/clock/rockchip,rk3188-cru.yaml#
diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3228-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rk3228-cru.yaml
index cf7dc01d9..ca34345e1 100644
--- a/Documentation/devicetree/bindings/clock/rockchip,rk3228-cru.yaml
+++ b/Documentation/devicetree/bindings/clock/rockchip,rk3228-cru.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/clock/rockchip,rk3228-cru.yaml#
diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3288-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rk3288-cru.yaml
index 96bc05749..b952b0eab 100644
--- a/Documentation/devicetree/bindings/clock/rockchip,rk3288-cru.yaml
+++ b/Documentation/devicetree/bindings/clock/rockchip,rk3288-cru.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/clock/rockchip,rk3288-cru.yaml#
diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3308-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rk3308-cru.yaml
index 523ee578a..e1b314ed3 100644
--- a/Documentation/devicetree/bindings/clock/rockchip,rk3308-cru.yaml
+++ b/Documentation/devicetree/bindings/clock/rockchip,rk3308-cru.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/clock/rockchip,rk3308-cru.yaml#
diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3368-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rk3368-cru.yaml
index adb678777..3e8225357 100644
--- a/Documentation/devicetree/bindings/clock/rockchip,rk3368-cru.yaml
+++ b/Documentation/devicetree/bindings/clock/rockchip,rk3368-cru.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/clock/rockchip,rk3368-cru.yaml#
diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.yaml
index 54da1e31e..b06eef33b 100644
--- a/Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.yaml
+++ b/Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/clock/rockchip,rk3399-cru.yaml#
diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3568-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rk3568-cru.yaml
index fc7546f52..5b49adcac 100644
--- a/Documentation/devicetree/bindings/clock/rockchip,rk3568-cru.yaml
+++ b/Documentation/devicetree/bindings/clock/rockchip,rk3568-cru.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/clock/rockchip,rk3568-cru.yaml#
diff --git a/Documentation/devicetree/bindings/clock/rockchip,rv1108-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rv1108-cru.yaml
index 20421c22f..95bfeb8fc 100644
--- a/Documentation/devicetree/bindings/clock/rockchip,rv1108-cru.yaml
+++ b/Documentation/devicetree/bindings/clock/rockchip,rv1108-cru.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/clock/rockchip,rv1108-cru.yaml#
-- 
2.20.1

