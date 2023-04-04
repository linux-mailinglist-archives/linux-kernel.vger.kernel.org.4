Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787F36D68E3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 18:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235223AbjDDQa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 12:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235359AbjDDQaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 12:30:12 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FB446BC
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 09:30:10 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id q19so30379141wrc.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 09:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680625808;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3fPm8iQsu3PXiX9UtaaXxTfcyhiLnzUQ0oS0z/eHP0Q=;
        b=5E1/4PXVI7xXROdgc5cyA/ZMG0OFPxq4oeWNkd0Rw8a6F2q1/paBLSCJXDfRzd0bsS
         /WnfsJ30PiYsL8G05UGSKwitdTtTl46Vn+1RduG1Y8VsdnZzycM7dQActoFlKLpTnc0g
         BUVs8Zk3dVojT21P9//DRM/0GC+GNemGV0jM449uICgCb4SSCpL5xxKYNi1eXdMf6zMU
         Yr/pSzoG5gmNVmUQc5KXWUdwxpoD7f7xxCPWoLLQcutUxTPSXz0wKgjABs3n1QZDnRmq
         tbJ1g7QUuOruh/NBYTy2G0yvT3UJ0TOKKGX280/VfcEia2YSjRi3oAw8mhFg/tXUNFmg
         QGig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680625808;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3fPm8iQsu3PXiX9UtaaXxTfcyhiLnzUQ0oS0z/eHP0Q=;
        b=R2CdGusyKsa4wg+fLBHNc+xvZ5GGJPtbjPKbr91lLmW2oaekOMBvo180MGq/2UHFSa
         IXs3AibBJswRlLhDye57daFcBEuG776DomZ4PfQrfsDRKZB3JWoIctsen0EVc5YkYUis
         KFSQaamIzzSodoKo5gXqW/IG8AhLwM+6pdLB1GTotRP4UR7sAUK5UsgE0yMxhZGYlkdW
         H5c6hM6+l23hL51bQdy6+9DHnTC3PUc3aped8s//1ZjKnT1ciM6BK2y1wEsO27/sYhWD
         wVcUBuGY85358PhT7IaOAY+y3Omjuv94Cfg/W5z+hIY7wEW7eo5uAN67Wt6gn7GH6Bh8
         +WZw==
X-Gm-Message-State: AAQBX9cWwqUdKpTSdjRexTr0tujiA6LeorXyv/O7W4DMv+oG2VIVhk5q
        02v/mNvdFLGgVhJbaII+L5+6zQ==
X-Google-Smtp-Source: AKy350bwZoqlEwBDskiE/IRsA/yOqgpI3H9hlO1N+VWFVxHr4VsbBmVTxxuq7vjbwzpT/l0hydSY0Q==
X-Received: by 2002:a05:6000:150:b0:2e3:7dba:2ba6 with SMTP id r16-20020a056000015000b002e37dba2ba6mr18924wrx.6.1680625808715;
        Tue, 04 Apr 2023 09:30:08 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id o7-20020adfe807000000b002e4cd2ec5c7sm12694528wrm.86.2023.04.04.09.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 09:30:08 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Tue, 04 Apr 2023 18:29:50 +0200
Subject: [PATCH v3 2/3] dt-bindings: pinctrl: mediatek: deprecate custom
 bias pull properties for mt8365
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230327-cleanup-pinctrl-binding-v3-2-6f56d5c7a8de@baylibre.com>
References: <20230327-cleanup-pinctrl-binding-v3-0-6f56d5c7a8de@baylibre.com>
In-Reply-To: <20230327-cleanup-pinctrl-binding-v3-0-6f56d5c7a8de@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3521; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=cP3MabLj1zpNPUMZqw1OhrEkYXQOUITPoTif+rF9fUo=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkLFCNrywDsoe4jiH3UnujVAgYQWtf/M/OJ9ie74fS
 SEm2uuOJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZCxQjQAKCRArRkmdfjHURUAGD/
 4rxS8wtQEth/9IobGOHJfI/HINziRRF1RJfBwgOrmugJEiX5KDAXwrdpCMZUoiaeTT1hSRssT2fnj9
 fslNrLhBRsa3cz6OGGifGYS8apFf5sK3Quy27OudNuU6F+Rg7ruxz2PqKaR+UvhCIKMuwJ7Tyw62EC
 YGfJl+ZstFxNXNDVR26cpvxyH45/ZNhKCdxHr0mJBsal17l28k2Ri34lNtcOgidN+DaxljMcr9k1FB
 Xj0G7ki9izG9/ODbKW0KtMXRtLP9cMNPqoFPp1QNiBWFxEul1MXgkpHmzGbrrSaRzaUEqGvVoyjGEk
 iUduZQLARerRovAoKlE/wH7CCqIGX7wIgwdsPfd1YnsRPGNfqbEis7RXkPLLVlnoxjwP3JfO+xyan+
 /f8UuUS4cmwGUyWi4KLo7cjQqMjyPj1CM+h+uegVWOc3laYlAFf/oES4iZCpEBIvu3GbnXN4VY9umf
 42JEpI6tuznQuCXt5Q1KAhzt4exAywjLRt4gsyOtiWeBAfrN4wYuStiFULb9BZQyKZLEcjdb9ueAOM
 G9QVEmXUGI2ej+bEP/Ni0zMPb1HfY1c8eWir+Zvc/cZhcZsMMayXHWe9Caaohw5+WLuJu+1dANWoN6
 4khAKkueNtCUTCeI/9iaOOcVFhS5+peIYwmHnMQT33BgGOo5ZJhbxOYtX2kA==
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
 .../bindings/pinctrl/mediatek,mt8365-pinctrl.yaml  | 36 ++++++++++++++++++----
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml
index dce9fd1a6a72..75d74b92c767 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml
@@ -72,12 +72,32 @@ patternProperties:
           bias-disable: true
 
           bias-pull-up:
-            description:
-              Besides generic pinconfig options, it can be used as the pull up
-              settings for 2 pull resistors, R0 and R1. User can configure those
-              special pins.
-
-          bias-pull-down: true
+            oneOf:
+              - type: boolean
+              - enum: [100, 101, 102, 103]
+                description: Pull up R1/R0 type define value.
+            description: |
+              For pull up type is normal, it don't need add R1/R0 define.
+              For pull up type is R1/R0 type, it can add value to set different
+              resistance. Valid arguments are described as below:
+              100: (R1, R0) = (0, 0) which means R1 disabled and R0 disabled.
+              101: (R1, R0) = (0, 1) which means R1 disabled and R0 enabled.
+              102: (R1, R0) = (1, 0) which means R1 enabled and R0 disabled.
+              103: (R1, R0) = (1, 1) which means R1 enabled and R0 enabled.
+
+          bias-pull-down:
+            oneOf:
+              - type: boolean
+              - enum: [100, 101, 102, 103]
+                description: Pull down R1/R0 type define value.
+            description: |
+              For pull down type is normal, it don't need add R1/R0 define.
+              For pull down type is R1/R0 type, it can add value to set
+              different resistance. Valid arguments are described as below:
+              100: (R1, R0) = (0, 0) which means R1 disabled and R0 disabled.
+              101: (R1, R0) = (0, 1) which means R1 disabled and R0 enabled.
+              102: (R1, R0) = (1, 0) which means R1 enabled and R0 disabled.
+              103: (R1, R0) = (1, 1) which means R1 enabled and R0 enabled.
 
           input-enable: true
 
@@ -123,7 +143,9 @@ patternProperties:
             enum: [0, 1, 2, 3, 4, 5, 6, 7]
 
           mediatek,pull-up-adv:
+            deprecated: true
             description: |
+              DEPRECATED: Please use bias-pull-up instead.
               Pull up setings for 2 pull resistors, R0 and R1. User can
               configure those special pins. Valid arguments are described as
               below:
@@ -135,7 +157,9 @@ patternProperties:
             enum: [0, 1, 2, 3]
 
           mediatek,pull-down-adv:
+            deprecated: true
             description: |
+              DEPRECATED: Please use bias-pull-down instead.
               Pull down settings for 2 pull resistors, R0 and R1. User can
               configure those special pins. Valid arguments are described as
               below:

-- 
2.25.1

