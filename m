Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C155B5FE9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 20:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbiILSIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 14:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiILSIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 14:08:45 -0400
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B2A40BCA;
        Mon, 12 Sep 2022 11:08:43 -0700 (PDT)
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by finn.localdomain with esmtp (Exim 4.93)
        (envelope-from <tharvey@gateworks.com>)
        id 1oXnrM-00GaLM-Ir; Mon, 12 Sep 2022 18:08:40 +0000
From:   Tim Harvey <tharvey@gateworks.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v2 3/5] arm64: dts: imx8mp-venice-gw74xx: fix port/phy validation
Date:   Mon, 12 Sep 2022 11:08:34 -0700
Message-Id: <20220912180836.773729-3-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220912180836.773729-1-tharvey@gateworks.com>
References: <20220912180836.773729-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 65ac79e18120 ("net: dsa: microchip: add the phylink
get_caps") the phy-mode must be set otherwise the switch driver will
assume "NA" mode and invalidate the port.

Fixes: 7899eb6cb15d ("arm64: dts: imx: Add i.MX8M Plus Gateworks gw7400
dts support")
Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
v2: no changes
---
 arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
index 3df7ee9a2fe1..211e6a1b296e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
@@ -483,30 +483,35 @@ ports {
 			lan1: port@0 {
 				reg = <0>;
 				label = "lan1";
+				phy-mode = "internal";
 				local-mac-address = [00 00 00 00 00 00];
 			};
 
 			lan2: port@1 {
 				reg = <1>;
 				label = "lan2";
+				phy-mode = "internal";
 				local-mac-address = [00 00 00 00 00 00];
 			};
 
 			lan3: port@2 {
 				reg = <2>;
 				label = "lan3";
+				phy-mode = "internal";
 				local-mac-address = [00 00 00 00 00 00];
 			};
 
 			lan4: port@3 {
 				reg = <3>;
 				label = "lan4";
+				phy-mode = "internal";
 				local-mac-address = [00 00 00 00 00 00];
 			};
 
 			lan5: port@4 {
 				reg = <4>;
 				label = "lan5";
+				phy-mode = "internal";
 				local-mac-address = [00 00 00 00 00 00];
 			};
 
-- 
2.25.1

