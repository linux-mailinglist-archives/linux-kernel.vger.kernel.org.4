Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 549DF5F97CF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 07:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiJJFes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 01:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbiJJFec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 01:34:32 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D4A50FAA;
        Sun,  9 Oct 2022 22:34:29 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id f140so9901839pfa.1;
        Sun, 09 Oct 2022 22:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VhtwD/Hk+4MmxWjIA7ioMhD4KoMl+0rYDVzSC0gMCyo=;
        b=RmjJoHRY0sT+7aPKDElNCqDaPnPxEpgrpU3JZTWY6f+f9D+LGqjUCR+yjOjO0YrabX
         uT+OKOJNlI2FLR4cTDTehEv4wvjbEcbjFtrSOa/E1bRnMTzbOCicaUi0SPwH8cWHwLmU
         ufr7YTl+OhrncTg6TD84HiRwOwVea8Ag0GYLdPJC1LdaLSLb4Y5D2EdXq/M2ZTVR638N
         4waPlF1JNiWjECmL4z60RHzc7rTBkozr5QHmg9YM6yvGkl4z3lgP4THcn+dFiqQQR5ix
         DpOZcrj+MGlzMrEwZJJDS2ADseD8hkPZLwfEVEvIZYvaflRkj2ILvWmsPkL+zx3GLreV
         Bd6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VhtwD/Hk+4MmxWjIA7ioMhD4KoMl+0rYDVzSC0gMCyo=;
        b=s0HmdXlAsKZQFBpj5PaPJl+1MLeaeQkGD+bTBKkRD0jDlDO7vhZmAi3qXDkcefGj1N
         KOTUhv6QmsFcGFV7UDWlx76uv6NsElv6zL52oXLUuExfnwzWeZuhJlNr3eNUOHUqLCyE
         t5avUpFu+PhEml+E7qmoB0IV99iXkc/Nerg87LHIRrgfpXCNRAkRD94hoeOyu5YqqbP/
         sEso6TLCJagGMv+oO5bfodzL8Hsv43+TW87d3pO4BDBl6qaHt0cylu5NWUxC2H5Mx7RV
         Ste6mAMLzwFfisJVvFGMAGKQ3YgCIWp3ghbE9RvVG5mP0zywa90ELf6kEp3K/GW+hJ2T
         /dtw==
X-Gm-Message-State: ACrzQf20WQ61nJ41vJkVQRW7rEoewH7a/m4KGXr96VYxi3XB35eHC2AD
        hPeBuZzvlqLwtSak/NIHjCYbip/6dFw=
X-Google-Smtp-Source: AMsMyM70wYHt4G5bUNXTnIFDsYYiQX6qWlQoyTI0no4LU55Mcvt1m1GjIYkVxKzPRznXafnSOWSKnw==
X-Received: by 2002:aa7:9af5:0:b0:562:a65f:ec81 with SMTP id y21-20020aa79af5000000b00562a65fec81mr18327527pfp.16.1665380068287;
        Sun, 09 Oct 2022 22:34:28 -0700 (PDT)
Received: from xm06403pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id 126-20020a620584000000b00562519cad97sm5891920pff.19.2022.10.09.22.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 22:34:27 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Cixi Geng <cixi.geng1@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH V3 3/3] dt-bindings: gpio: Add compatible string for Unisoc UMS512
Date:   Mon, 10 Oct 2022 13:33:38 +0800
Message-Id: <20221010053338.22580-4-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221010053338.22580-1-zhang.lyra@gmail.com>
References: <20221010053338.22580-1-zhang.lyra@gmail.com>
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

UMS512 use the same GPIO and EIC controller with SC9860.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../bindings/gpio/sprd,gpio-eic.yaml          | 33 +++++++++++++++----
 .../devicetree/bindings/gpio/sprd,gpio.yaml   |  7 +++-
 2 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/sprd,gpio-eic.yaml b/Documentation/devicetree/bindings/gpio/sprd,gpio-eic.yaml
index a21350bd0f2c..99fcf970773a 100644
--- a/Documentation/devicetree/bindings/gpio/sprd,gpio-eic.yaml
+++ b/Documentation/devicetree/bindings/gpio/sprd,gpio-eic.yaml
@@ -42,12 +42,33 @@ description: |
 
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
index 40924123d184..483168838128 100644
--- a/Documentation/devicetree/bindings/gpio/sprd,gpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/sprd,gpio.yaml
@@ -19,7 +19,12 @@ description: |
 
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

