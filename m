Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49BD4639C94
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 20:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiK0TU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 14:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiK0TU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 14:20:57 -0500
Received: from srv01.abscue.de (abscue.de [IPv6:2a03:4000:63:bf5:4817:8eff:feeb:8ac7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF66DFFB;
        Sun, 27 Nov 2022 11:20:57 -0800 (PST)
Received: from srv01.abscue.de (localhost [127.0.0.1])
        by spamfilter.srv.local (Postfix) with ESMTP id 928531C0049;
        Sun, 27 Nov 2022 20:20:55 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Received: from srv01.abscue.de (abscue.de [89.58.28.240])
        by srv01.abscue.de (Postfix) with ESMTPSA id 7D9961C0048;
        Sun, 27 Nov 2022 20:20:55 +0100 (CET)
From:   =?UTF-8?q?Otto=20Pfl=C3=BCger?= <otto.pflueger@abscue.de>
To:     =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Otto=20Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Subject: [PATCH 4/4] dt-bindings: display: panel: mipi-dbi-spi: Add io-supply
Date:   Sun, 27 Nov 2022 20:14:33 +0100
Message-Id: <20221127191433.1363395-5-otto.pflueger@abscue.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221127191433.1363395-2-otto.pflueger@abscue.de>
References: <20221127191433.1363395-2-otto.pflueger@abscue.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the new io-supply property, which specifies the
regulator for the I/O voltage supply on platforms where the panel
panel power and I/O supplies are separate.

Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
---
 .../bindings/display/panel/panel-mipi-dbi-spi.yaml        | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml b/Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml
index d55bf12ecead..68cbdfab5438 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml
@@ -22,8 +22,9 @@ description: |
   The standard defines the following interface signals for type C:
   - Power:
     - Vdd: Power supply for display module
+      Called power-supply in this binding.
     - Vddi: Logic level supply for interface signals
-    Combined into one in this binding called: power-supply
+      Called io-supply in this binding.
   - Interface:
     - CSx: Chip select
     - SCL: Serial clock
@@ -80,6 +81,11 @@ properties:
       Controller data/command selection (D/CX) in 4-line SPI mode.
       If not set, the controller is in 3-line SPI mode.
 
+  io-supply:
+    description: |
+      Logic level supply for interface signals (Vddi).
+      No need to set if this is the same as power-supply.
+
   power-supply:
     description: Power supply for the display module (Vdd).
 
-- 
2.30.2
