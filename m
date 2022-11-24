Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B553637716
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 12:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiKXLD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 06:03:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiKXLDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 06:03:55 -0500
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36420881A2;
        Thu, 24 Nov 2022 03:03:54 -0800 (PST)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.94.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1oyA1F-0000L5-44; Thu, 24 Nov 2022 12:03:49 +0100
Date:   Thu, 24 Nov 2022 11:03:41 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.or,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>,
        Zhi Mao <zhi.mao@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>
Subject: [PATCH RESEND v2] dt-bindings: pwm: mediatek: Add compatible for
 MT7986
Message-ID: <Y39PjU1BqBB8tZ98@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new compatible string for MT7986 PWM and list compatible units for
existing entries. Also make sure the number of pwm1-X clocks is listed
for all supported units.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
Changes since v1: list compatibles, fix pwm1-n clocks for all SoCs

Rebased on linux-next and re-run scripts/get_maintainers.pl on patch to
makes sure dt maintainers are included. This has been requested by
Krzysztof Kozlowski.

 .../devicetree/bindings/pwm/pwm-mediatek.txt  | 20 +++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
index 554c96b6d0c3..952a338e06e7 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
@@ -2,14 +2,15 @@ MediaTek PWM controller
 
 Required properties:
  - compatible: should be "mediatek,<name>-pwm":
-   - "mediatek,mt2712-pwm": found on mt2712 SoC.
+   - "mediatek,mt2712-pwm", "mediatek,mt6795-pwm": found on mt2712 SoC.
    - "mediatek,mt6795-pwm": found on mt6795 SoC.
-   - "mediatek,mt7622-pwm": found on mt7622 SoC.
-   - "mediatek,mt7623-pwm": found on mt7623 SoC.
+   - "mediatek,mt7622-pwm", "mediatek,mt8195-pwm", "mediatek,mt8183-pwm", "mediatek,mt7986-pwm": found on mt7622 SoC.
+   - "mediatek,mt7623-pwm", "mediatek,mt7628-pwm": found on mt7623 SoC.
    - "mediatek,mt7628-pwm": found on mt7628 SoC.
    - "mediatek,mt7629-pwm": found on mt7629 SoC.
-   - "mediatek,mt8183-pwm": found on mt8183 SoC.
-   - "mediatek,mt8195-pwm", "mediatek,mt8183-pwm": found on mt8195 SoC.
+   - "mediatek,mt7986-pwm": found on mt7986 SoC.
+   - "mediatek,mt8183-pwm", "mediatek,mt7986-pwm": found on mt8183 SoC.
+   - "mediatek,mt8195-pwm", "mediatek,mt8183-pwm", "mediatek,mt7986-pwm": found on mt8195 SoC.
    - "mediatek,mt8365-pwm": found on mt8365 SoC.
    - "mediatek,mt8516-pwm": found on mt8516 SoC.
  - reg: physical base address and length of the controller's registers.
@@ -20,11 +21,14 @@ Required properties:
                 has no clocks
    - "top": the top clock generator
    - "main": clock used by the PWM core
+   - "pwm1"  : the PWM1 clock for mt7629
+   - "pwm1-2": the two per PWM clocks for mt7986
    - "pwm1-3": the three per PWM clocks for mt8365
-   - "pwm1-8": the eight per PWM clocks for mt2712
+   - "pwm1-4": the four per PWM clocks for mt7628 or mt8183
+   - "pwm1-5": the five per PWM clocks for mt7623 or mt8516
    - "pwm1-6": the six per PWM clocks for mt7622
-   - "pwm1-5": the five per PWM clocks for mt7623
-   - "pwm1"  : the PWM1 clock for mt7629
+   - "pwm1-7": the seven per PWM clocks for mt6795
+   - "pwm1-8": the eight per PWM clocks for mt2712
  - pinctrl-names: Must contain a "default" entry.
  - pinctrl-0: One property must exist for each entry in pinctrl-names.
    See pinctrl/pinctrl-bindings.txt for details of the property values.
-- 
2.38.1

