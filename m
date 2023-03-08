Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704E66B07D2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 14:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbjCHNCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 08:02:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjCHNBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 08:01:13 -0500
X-Greylist: delayed 421 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 08 Mar 2023 05:00:15 PST
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [84.16.66.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88C6C5614
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 05:00:14 -0800 (PST)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4PWsgK3H2MzMqrZ8;
        Wed,  8 Mar 2023 13:53:17 +0100 (CET)
Received: from unknown by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4PWsgJ6mt9zMsl17;
        Wed,  8 Mar 2023 13:53:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
        s=20220412; t=1678279997;
        bh=D/Bwcn9ct9hGVp/HejFmpJ8/8S1VgnELr/+g/GheFts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RcJ3ZqcqkehRuJkeohwXTkl/Vzpu1MkGfHwckgN6IVW6etUZ+IpnWSOhWUByWii/F
         6oMe7UekMrUS6XD3ek+Nzk4KHqF0Rh8LCuitqGfMtqWaxDf9OMpQETtft/RyxBLgu/
         dyyFVhpMcszePU/lc2LUh3qWNz2vIOjydmXmrkUA=
From:   Philippe Schenker <dev@pschenker.ch>
To:     devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 18/25] arm64: dts: colibri-imx8x: Add no-1-8-v to sd-card
Date:   Wed,  8 Mar 2023 13:52:52 +0100
Message-Id: <20230308125300.58244-19-dev@pschenker.ch>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230308125300.58244-1-dev@pschenker.ch>
References: <20230308125300.58244-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philippe Schenker <philippe.schenker@toradex.com>

Many Colibri carrier boards are using 3.3V pull-up resistors on the
SD-Card connector. Letting it switch to 1.8V is an invalid state.

Do prevent this from happening by keeping the signaling voltage at 3.3V.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

 arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
index 180a1d940b8d..f09a6aad6275 100644
--- a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
@@ -303,6 +303,7 @@ &usdhc2 {
 	bus-width = <4>;
 	cd-gpios = <&lsio_gpio3 9 GPIO_ACTIVE_LOW>;
 	disable-wp;
+	no-1-8-v;
 	vmmc-supply = <&reg_module_3v3>;
 };
 
-- 
2.39.2

