Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0AED61E0BB
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 09:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiKFIBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 03:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiKFIBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 03:01:31 -0500
Received: from mxout2.routing.net (mxout2.routing.net [IPv6:2a03:2900:1:a::b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF9C6343;
        Sun,  6 Nov 2022 01:01:30 -0700 (PDT)
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
        by mxout2.routing.net (Postfix) with ESMTP id 015F75FC27;
        Sun,  6 Nov 2022 08:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1667721689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZjAdxtpTxlN0A+X+YASvDZA5e+yMzGung7G3AXysxXY=;
        b=f64ZSD342f1H++EkxJtwBZ5JLOXuUyQ8HHV19RnUZkFW7a0OhFAmUS1PBy4aaMjiuvr3wq
        FZayF6YeqDzxrGoAkhermRevgaOvpW++yGOsKUuCEwg6RH1uqOOh3Ed1s9YPu2uWnKfyIC
        DmbowoMTxSE7SmCNbY2GMq31BoedIwg=
Received: from frank-G5.. (fttx-pool-80.245.79.199.bambit.de [80.245.79.199])
        by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 3C025360707;
        Sun,  6 Nov 2022 08:01:28 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Sam Shih <sam.shih@mediatek.com>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/6] dt-bindings: pinctrl: update pcie/pwm/spi bindings for MT7986 SoC
Date:   Sun,  6 Nov 2022 09:01:08 +0100
Message-Id: <20221106080114.7426-2-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221106080114.7426-1-linux@fw-web.de>
References: <20221106080114.7426-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 930663f8-d39f-4ea1-b476-287d1e74bae5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

Allow multiple items for pcie, pwm and spi function.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/pinctrl/mediatek,mt7986-pinctrl.yaml    | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml
index 89b8f3dd67a1..75766956cfad 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml
@@ -197,7 +197,9 @@ patternProperties:
             then:
               properties:
                 groups:
-                  enum: [pcie_clk, pcie_wake, pcie_pereset]
+                  items:
+                    enum: [pcie_clk, pcie_wake, pcie_pereset]
+                  maxItems: 3
           - if:
               properties:
                 function:
@@ -205,7 +207,9 @@ patternProperties:
             then:
               properties:
                 groups:
-                  enum: [pwm0, pwm1_0, pwm1_1]
+                  items:
+                    enum: [pwm0, pwm1_0, pwm1_1]
+                  maxItems: 2
           - if:
               properties:
                 function:
@@ -213,7 +217,9 @@ patternProperties:
             then:
               properties:
                 groups:
-                  enum: [spi0, spi0_wp_hold, spi1_0, spi1_1, spi1_2, spi1_3]
+                  items:
+                    enum: [spi0, spi0_wp_hold, spi1_0, spi1_1, spi1_2, spi1_3]
+                  maxItems: 2
           - if:
               properties:
                 function:
-- 
2.34.1

