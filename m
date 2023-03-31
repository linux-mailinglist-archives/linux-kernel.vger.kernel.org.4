Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47926D26D4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 19:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbjCaRj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 13:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232039AbjCaRjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 13:39:20 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2176FCA03
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 10:39:18 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id l12so23198915wrm.10
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 10:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680284356;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h/PKiRdK/AdCxhQPLVxp6qRTTYRDZGG0+AZ8Pt0BlOY=;
        b=xb2DAmdVIUD0mU4ZM/DecBkaOGR5wsQ6d9c+8vO0ZCq9EzXbbrDYS2OikBJmEMDjs2
         3dCeGNehnUlRSkQ0uuFsk99EuTCG6pU/RB42JLRqfZq+YwiiCEg3GkRCGtDrfp65MPvk
         McAhpZ5R5z/KSekNsSBFlBAhnFaOJDb1pS5Lbk9sEfGD0scfLOR0YB2LKFz4WJ2S7qLt
         5B7CxaayfziYW2P+NHWNaSTZnRQK/HEAoBRY0K9Nt3U2WUQkHT0Koy3gpxJCjN2B8yK7
         xH5fU5UoS2UGd4E3Vsjom0Y1dEvrbPdAypLr7NSdLGwv9fZsWqf9jn0jutUntQHSkHEc
         Bj2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680284356;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h/PKiRdK/AdCxhQPLVxp6qRTTYRDZGG0+AZ8Pt0BlOY=;
        b=dDneTofRdgezUB95iV4rm2qraQA5Lqs+AHjEy8dPUPDkTtkW+E+xJy6mJdNdWmesHs
         YrrGeqyfaVtFWzkbY6WbDL19b0+RUkzs/c2l1iE0nnDv4m3B3cRKekHmohkJN26EmZyY
         Kxuy8rIS61pi66GwL1MoPiFNDTYLIFqG+zxD/buCrFBW/uhTLr0v1kUsRNS9sOMvdQXH
         q1JVUSzJwVASgBURyY1l2JR1I3O8H/lZuO2s/kfqSc3SdAIYmrqX16+KYccC+5Hk3Gud
         kizwA6Q1hv5oHV5W+TbnzW8ElPdb+aq64bPtn1m81pU44OfwRdvKtnQLYj6ft4C8r+m5
         ytZQ==
X-Gm-Message-State: AAQBX9e6oQN07SOhGokIiVptQaIfbsoBAooqSxQOwCOMKwYFmnQVnSza
        Z/pnti0pMwLuo3C2BP5+2/9DJg==
X-Google-Smtp-Source: AKy350Z5qBmyx03YFMY4exnOGUjSMNVkNU5SbYP4fhFOR/ObMcOrfWTagg7GiOvZeoINCeNRFUsb/A==
X-Received: by 2002:adf:df88:0:b0:2c7:604:52a1 with SMTP id z8-20020adfdf88000000b002c7060452a1mr19563658wrl.29.1680284356630;
        Fri, 31 Mar 2023 10:39:16 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id o5-20020adfcf05000000b002c592535839sm2733550wrj.17.2023.03.31.10.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 10:39:16 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Fri, 31 Mar 2023 19:39:00 +0200
Subject: [PATCH v2 2/2] dt-bindings: pinctrl: mediatek: deprecate custom
 bias pull properties for mt8365
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230327-cleanup-pinctrl-binding-v2-2-f21fbcc3016e@baylibre.com>
References: <20230327-cleanup-pinctrl-binding-v2-0-f21fbcc3016e@baylibre.com>
In-Reply-To: <20230327-cleanup-pinctrl-binding-v2-0-f21fbcc3016e@baylibre.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?utf-8?q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3599; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=99/zsAro4iog0C+4jUroqtzB5pHnwrzuYQWT6NZAlsM=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkJxrBc+oHkE+9tNrcKZp9r++zV1rP91TNBZwe1D7T
 WVhYllSJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZCcawQAKCRArRkmdfjHURX9rD/
 4pfi2lithVMijjiYZPLKnaAHoQGss4png8T9snd06mrSkSOW/XHJ2DAT1vj2Z7F1du3OZJIIFBKusu
 Sd9Mqwb+IbwgfZI3arRrv1PpkSmUFh5SrT6bNkTr1ghyc4P7wm/mvz+jxgZawAbczk3AzHnntrAIEF
 cPm9MWc9KGbD9m+6/0mwxapjLBl82frEvCSxiLp+MQzcFjBtz/JOek6v5L7OIcZO/P94n/o3xrKmwz
 8Rz01ll2XoQaL27tDO8YX/7KTZHOtHeCmrjh9EuozCidfCP8c2THTy0KTYQbzFA2mNjtr8QDMCjJeq
 /xDGnAyYZ5VMIUO6OC5dSnh5eWhQLQwYFOykT7ay67Ir9APCeh7Mube5RfnKowcy4qIAkW6r4iO4dz
 o+iinLYMwXIckKCvvraBH6yQQ8BA4SzcUHNrE4klJ2fKd5zEdOGw7Em2nwY2m86ytSXOOkr6wm9tel
 NVLSOQCeHGrdZJ+bHaJ3G01RAyJ0Exun25N4soIioWmNJyc4B2eK83S4jJZqeegWFFzg+HGhDffcGD
 kq9V1VNom+q+aPhy6w1owWIi2sY9DqsXZHQBeZ7SiorT/SGU3CEd4+ovuVkwJixAyYFsXxVpR2W/X5
 cd7P//yboXTqXP1AzX8+zN7MWeZCZvYNl1YjUL9N5kw6zBgtjFyfQJKuKRAA==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to be more generic, "mediatek,pull-up-adv" and
"mediatek,pull-down-adv" should be deprecated. Use "bias-pull-up" and
"bias-pull-down" instead.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 .../bindings/pinctrl/mediatek,mt8365-pinctrl.yaml  | 32 +++++++++++++++++++---
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml
index 347f533776ba..2ce6a69b0bf9 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml
@@ -72,12 +72,32 @@ patternProperties:
           bias-disable: true
 
           bias-pull-up:
+            oneOf:
+              - type: boolean
+              - enum: [100, 101, 102, 103]
+                description: Pull up R1/R0 type define value.
             description: |
-              Besides generic pinconfig options, it can be used as the pull up
-              settings for 2 pull resistors, R0 and R1. User can configure those
-              special pins.
+              For pull up type is normal, it don't need add R1/R0 define.
+              For pull up type is R1/R0 type, it can add value to set different
+              resistance. Valid arguments are described as below:
+              0: (R1, R0) = (0, 0) which means R1 disabled and R0 disabled.
+              1: (R1, R0) = (0, 1) which means R1 disabled and R0 enabled.
+              2: (R1, R0) = (1, 0) which means R1 enabled and R0 disabled.
+              3: (R1, R0) = (1, 1) which means R1 enabled and R0 enabled.
 
-          bias-pull-down: true
+          bias-pull-down:
+            oneOf:
+              - type: boolean
+              - enum: [100, 101, 102, 103]
+                description: Pull down R1/R0 type define value.
+            description: |
+              For pull down type is normal, it don't need add R1/R0 define.
+              For pull down type is R1/R0 type, it can add value to set
+              different resistance. Valid arguments are described as below:
+              0: (R1, R0) = (0, 0) which means R1 disabled and R0 disabled.
+              1: (R1, R0) = (0, 1) which means R1 disabled and R0 enabled.
+              2: (R1, R0) = (1, 0) which means R1 enabled and R0 disabled.
+              3: (R1, R0) = (1, 1) which means R1 enabled and R0 enabled.
 
           input-enable: true
 
@@ -123,7 +143,9 @@ patternProperties:
             enum: [0, 1, 2, 3, 4, 5, 6, 7]
 
           mediatek,pull-up-adv:
+            deprecated: true
             description: |
+              DEPRECATED: Please use bias-pull-up instead.
               Pull up setings for 2 pull resistors, R0 and R1. User can
               configure those special pins. Valid arguments are described as below:
               0: (R1, R0) = (0, 0) which means R1 disabled and R0 disabled.
@@ -134,7 +156,9 @@ patternProperties:
             enum: [0, 1, 2, 3]
 
           mediatek,pull-down-adv:
+            deprecated: true
             description: |
+              DEPRECATED: Please use bias-pull-down instead.
               Pull down settings for 2 pull resistors, R0 and R1. User can
               configure those special pins. Valid arguments are described as below:
               0: (R1, R0) = (0, 0) which means R1 disabled and R0 disabled.

-- 
2.25.1

