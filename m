Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06CE769FACA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 19:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbjBVSJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 13:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbjBVSJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 13:09:18 -0500
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BF43401B;
        Wed, 22 Feb 2023 10:09:17 -0800 (PST)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1pUtYJ-0008Ju-24;
        Wed, 22 Feb 2023 19:09:15 +0100
Date:   Wed, 22 Feb 2023 18:09:08 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     linux-clk@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Edward-JW Yang <edward-jw.yang@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>
Subject: [PATCH RFC 1/4] dt-bindings: clock: rename mt7986-clk.h to
 mediatek,mt7986-clk.h
Message-ID: <15d718a2d696d29b48668b9ab5531369c537a1e6.1677089171.git.daniel@makrotopia.org>
References: <cover.1677089171.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1677089171.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename dt-bindings header file mt7986-clk.h to mediatek,mt7986-clk.h,
propagate this change also to mt7986a.dtsi which is the only user.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi                       | 2 +-
 drivers/clk/mediatek/clk-mt7986-infracfg.c                      | 2 +-
 drivers/clk/mediatek/clk-mt7986-topckgen.c                      | 2 +-
 .../dt-bindings/clock/{mt7986-clk.h => mediatek,mt7986-clk.h}   | 0
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename include/dt-bindings/clock/{mt7986-clk.h => mediatek,mt7986-clk.h} (100%)

diff --git a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
index 0d9800c51cc9b..a53993fe457ca 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
@@ -6,7 +6,7 @@
 
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
-#include <dt-bindings/clock/mt7986-clk.h>
+#include <dt-bindings/clock/mediatek,mt7986-clk.h>
 #include <dt-bindings/reset/mt7986-resets.h>
 #include <dt-bindings/phy/phy.h>
 #include <dt-bindings/thermal/thermal.h>
diff --git a/drivers/clk/mediatek/clk-mt7986-infracfg.c b/drivers/clk/mediatek/clk-mt7986-infracfg.c
index b7efa70c2d6c2..e3363d700243d 100644
--- a/drivers/clk/mediatek/clk-mt7986-infracfg.c
+++ b/drivers/clk/mediatek/clk-mt7986-infracfg.c
@@ -14,7 +14,7 @@
 #include "clk-gate.h"
 #include "clk-mux.h"
 
-#include <dt-bindings/clock/mt7986-clk.h>
+#include <dt-bindings/clock/mediatek,mt7986-clk.h>
 #include <linux/clk.h>
 
 static DEFINE_SPINLOCK(mt7986_clk_lock);
diff --git a/drivers/clk/mediatek/clk-mt7986-topckgen.c b/drivers/clk/mediatek/clk-mt7986-topckgen.c
index fbca3feded8f0..971b5259186a6 100644
--- a/drivers/clk/mediatek/clk-mt7986-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt7986-topckgen.c
@@ -14,7 +14,7 @@
 #include "clk-gate.h"
 #include "clk-mux.h"
 
-#include <dt-bindings/clock/mt7986-clk.h>
+#include <dt-bindings/clock/mediatek,mt7986-clk.h>
 #include <linux/clk.h>
 
 static DEFINE_SPINLOCK(mt7986_clk_lock);
diff --git a/include/dt-bindings/clock/mt7986-clk.h b/include/dt-bindings/clock/mediatek,mt7986-clk.h
similarity index 100%
rename from include/dt-bindings/clock/mt7986-clk.h
rename to include/dt-bindings/clock/mediatek,mt7986-clk.h
-- 
2.39.2

