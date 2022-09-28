Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79215ED8F9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 11:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233767AbiI1JaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 05:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233724AbiI1JaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 05:30:03 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB732D1F3;
        Wed, 28 Sep 2022 02:29:58 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id c24so11321522plo.3;
        Wed, 28 Sep 2022 02:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=M1MQzP7nXhdAoOm+Dhk9FYAPvZN0O8P2I4Dh0xXzv94=;
        b=Qw/TctgaljN0UbyGHGd1qOXRq1GZvQKoCWhbHHBEBdlUqyO9IZTvEf+CaX+dTg/xpV
         2TfhMgrV8c64YvMLi1avwgho+W30WDcPB+NXS/r7pDl0zfENRD7zXL8NMcMZNe+43NYv
         eigvsz93QDNJZnnz5kY0Pp9TT3uwXdI7VxA9NV6m341ifsvcmPuaUdV9xQutUyYp+8a2
         I3G+KRvER2aesl/EQsSqoqefctD4ZSJt5X9lfi+3lqQPAPFQobHQpp+uX+9rbgZxj6zM
         rBy2UlpZWKa63v0RUP/wx+d5LhOByeyGmU4Vyszxp42GpWMIQenbLTM9R9jQF1v5JRWo
         Io4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=M1MQzP7nXhdAoOm+Dhk9FYAPvZN0O8P2I4Dh0xXzv94=;
        b=wUVxzjls6pnoezECu2Ov+f+soRK6bcdIUTPyB7NR4v+BbU7CTXUK9Xi3q2EwBPRxRL
         WT3S4IacS9zE02Y/F0KJF20kHSp/3lDenzDiOmfuZ+eks1DUB1ZbgBftn30EODbFScvQ
         Wo2JF2o5rPKehSP68HdM22qC35GI2XJCKx1yiGjR3FI3x2PI+pYmxXTLv0Rh5knQ9cHY
         hxbykNn8RtD9A6wxP3GbXHOqTlUJy0M64mflltyWweYO1CHIflCkSV2Ys1AXNfPDglS9
         8lMnEVJcF/MPzxhs/IlUVBRIfiv5m098+FKAa36uUKgLVb2QsYPtm1yTVyUD1+lTp/Wb
         Ii/Q==
X-Gm-Message-State: ACrzQf2RBBXuy9VkD0KUGc4XSOhiMLBI3L2Vp2xIunwistg6Hulzhfep
        xZGXjgyi9594Lug47j2jno6SzWBRwYCtjg==
X-Google-Smtp-Source: AMsMyM5mHki8d2V2mQIYJfooJnScpyNWw5VYrXuKJ/DnrTGE5cMEaf1pchlRCD4OaFedeEKEt2JtBA==
X-Received: by 2002:a17:902:ecc5:b0:178:3217:e464 with SMTP id a5-20020a170902ecc500b001783217e464mr31629482plh.75.1664357398142;
        Wed, 28 Sep 2022 02:29:58 -0700 (PDT)
Received: from xm06403pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id b22-20020a17090a101600b0020071acaecasm1026831pja.42.2022.09.28.02.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 02:29:57 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] dt-bindings: gpio: Add compatible string for Unisoc UMS512
Date:   Wed, 28 Sep 2022 17:29:37 +0800
Message-Id: <20220928092937.27120-3-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220928092937.27120-1-zhang.lyra@gmail.com>
References: <20220928092937.27120-1-zhang.lyra@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

UMS512 use the same GPIO and EIC controller with SC9860, so this
patch adds compatible string for UMS512 directly.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 .../bindings/gpio/sprd,gpio-eic.yaml          | 33 +++++++++++++++----
 .../devicetree/bindings/gpio/sprd,gpio.yaml   |  7 +++-
 2 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/sprd,gpio-eic.yaml b/Documentation/devicetree/bindings/gpio/sprd,gpio-eic.yaml
index e25ee1884c07..07f7d2b56da6 100644
--- a/Documentation/devicetree/bindings/gpio/sprd,gpio-eic.yaml
+++ b/Documentation/devicetree/bindings/gpio/sprd,gpio-eic.yaml
@@ -42,12 +42,33 @@ description:
 
 properties:
   compatible:
-    enum:
-      - sprd,sc9860-eic-debounce
-      - sprd,sc9860-eic-latch
-      - sprd,sc9860-eic-async
-      - sprd,sc9860-eic-sync
-      - sprd,sc2731-eic
+    oneOf:
+      - enum:
+          - sprd,sc9860-eic-debounce
+          - sprd,sc9860-eic-latch
+          - sprd,sc9860-eic-async
+          - sprd,sc9860-eic-sync
+          - sprd,sc2731-eic
+      - items:
+          - enum:
+              - sprd,ums512-eic-debounce
+          - const: sprd,sc9860-eic-debounce
+      - items:
+          - enum:
+              - sprd,ums512-eic-latch
+          - const: sprd,sc9860-eic-latch
+      - items:
+          - enum:
+              - sprd,ums512-eic-async
+          - const: sprd,sc9860-eic-async
+      - items:
+          - enum:
+              - sprd,ums512-eic-sync
+          - const: sprd,sc9860-eic-sync
+      - items:
+          - enum:
+              - sprd,sc2730-eic
+          - const: sprd,sc2731-eic
 
   reg:
     minItems: 1
diff --git a/Documentation/devicetree/bindings/gpio/sprd,gpio.yaml b/Documentation/devicetree/bindings/gpio/sprd,gpio.yaml
index c0cd1ed9809b..a1ecb2b96a76 100644
--- a/Documentation/devicetree/bindings/gpio/sprd,gpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/sprd,gpio.yaml
@@ -19,7 +19,12 @@ description:
 
 properties:
   compatible:
-    const: sprd,sc9860-gpio
+    oneOf:
+      - const: sprd,sc9860-gpio
+      - items:
+          - enum:
+              - sprd,ums512-gpio
+          - const: sprd,sc9860-gpio
 
   reg:
     maxItems: 1
-- 
2.25.1

