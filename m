Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B365607A6D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 17:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiJUPZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 11:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbiJUPZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 11:25:27 -0400
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE99F111BA2;
        Fri, 21 Oct 2022 08:25:26 -0700 (PDT)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.94.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1olttk-0001TX-RT; Fri, 21 Oct 2022 17:25:24 +0200
Date:   Fri, 21 Oct 2022 16:25:18 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     linux-pwm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Frank Wunderlich <frank-w@public-files.de>
Subject: [PATCH 2/2] dt-bindings: pwm: mediatek: Add compatible string for
 MT7986
Message-ID: <Y1K53n7LnjoMoIfj@makrotopia.org>
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

Add new compatible string for MT7986 PWM.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 Documentation/devicetree/bindings/pwm/pwm-mediatek.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
index 554c96b6d0c3e0..6f4e60c9e18b81 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
@@ -8,6 +8,7 @@ Required properties:
    - "mediatek,mt7623-pwm": found on mt7623 SoC.
    - "mediatek,mt7628-pwm": found on mt7628 SoC.
    - "mediatek,mt7629-pwm": found on mt7629 SoC.
+   - "mediatek,mt7986-pwm": found on mt7986 SoC.
    - "mediatek,mt8183-pwm": found on mt8183 SoC.
    - "mediatek,mt8195-pwm", "mediatek,mt8183-pwm": found on mt8195 SoC.
    - "mediatek,mt8365-pwm": found on mt8365 SoC.
-- 
2.38.1

