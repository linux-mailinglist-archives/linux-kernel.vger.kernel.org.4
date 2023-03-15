Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D7A6BA5AB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 04:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjCODfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 23:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbjCODfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 23:35:18 -0400
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C082623DBA;
        Tue, 14 Mar 2023 20:35:16 -0700 (PDT)
From:   Yixun Lan <dlan@gentoo.org>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Jagan Teki <jagan@amarulasolutions.com>,
        Christopher Obbard <chris.obbard@collabora.com>,
        Yixun Lan <dlan@gentoo.org>, Nick Xie <nick@khadas.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: arm: rockchip: Add Khadas Edge2 board
Date:   Wed, 15 Mar 2023 11:34:40 +0800
Message-Id: <20230315033441.32719-2-dlan@gentoo.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230315033441.32719-1-dlan@gentoo.org>
References: <20230315033441.32719-1-dlan@gentoo.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Edge2 is an ultraslim, credit-card sized ARM PC designed by Khadas.
It has quite a few rich peripherals.

Specification:
- Rockchip RK3588s
- 8/16GB LPDDR4
- 32/64GB eMMC 5.1
- AP6275P WiFi6 LAN
- HDMI2.1 Type-A
- MIPI-CSI x3
- MIPI-DSI x2
- usb3.1; usb2.0
- RTC clock
- PWM fan
- SPI Flash
- Pads expansion board (UART, USB)

Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 35f74eda30ae..ff663797291c 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -533,6 +533,11 @@ properties:
               - khadas,edge-v
           - const: rockchip,rk3399
 
+      - description: Khadas Edge2 series boards
+        items:
+          - const: khadas,edge2
+          - const: rockchip,rk3588s
+
       - description: Kobol Helios64
         items:
           - const: kobol,helios64
-- 
2.39.2

