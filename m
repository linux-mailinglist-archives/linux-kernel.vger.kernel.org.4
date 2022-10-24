Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04636609BC6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 09:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiJXHow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 03:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiJXHo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 03:44:28 -0400
Received: from mxout1.routing.net (mxout1.routing.net [IPv6:2a03:2900:1:a::a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5DF4DB3A;
        Mon, 24 Oct 2022 00:43:57 -0700 (PDT)
Received: from mxbox1.masterlogin.de (unknown [192.168.10.88])
        by mxout1.routing.net (Postfix) with ESMTP id 16F603FEAE;
        Mon, 24 Oct 2022 07:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1666597432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=PVFntkudDPcDUkrTjdaUD/wKnuxi9MDu9IdQDwEuaUA=;
        b=lxo5WKqWxAHeKNpqTV3sVds4I5G5Eaq6eYEDf5hOUUpGQFjmNEkIXaHoGgqb/EU4wz5en5
        9B180I2AsWJUqSc0ONgRXUJg+5O1oEpvhShCle0A8cE1YGDfHz8/iwHKkZlTGmxGvWEat5
        b6CrTuy/9DDVZ5HtT8w1EKOpFBcWQ0U=
Received: from frank-G5.. (fttx-pool-80.245.75.40.bambit.de [80.245.75.40])
        by mxbox1.masterlogin.de (Postfix) with ESMTPSA id 4FF9A40112;
        Mon, 24 Oct 2022 07:43:51 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: pinctrl: update pcie/pwm/spi bindings for MT7986 SoC
Date:   Mon, 24 Oct 2022 09:43:49 +0200
Message-Id: <20221024074349.7777-1-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 4cf9fda7-e364-4d0a-b8d2-819af5223c20
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
---
 .../bindings/pinctrl/mediatek,mt7986-pinctrl.yaml    | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml
index d5ab5e08badc..0a7d130ef112 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml
@@ -201,7 +201,9 @@ patternProperties:
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
@@ -209,7 +211,9 @@ patternProperties:
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
@@ -217,7 +221,9 @@ patternProperties:
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

