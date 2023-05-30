Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE4A715E72
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 14:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbjE3MEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 08:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbjE3MEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 08:04:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F66107
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 05:04:05 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1q3y4t-0000DR-39; Tue, 30 May 2023 14:03:51 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1q3y4r-003rX2-VK; Tue, 30 May 2023 14:03:49 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1q3y4o-00C3ug-O1; Tue, 30 May 2023 14:03:46 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     David Jander <david@protonic.nl>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v1 03/15] ARM: dts: imx6dl: prtvt7: Remove touchscreen inversion
Date:   Tue, 30 May 2023 14:03:33 +0200
Message-Id: <20230530120345.2874900-4-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230530120345.2874900-1-o.rempel@pengutronix.de>
References: <20230530120345.2874900-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Jander <david@protonic.nl>

This touchscreen does not seem to be inverted in any axis, so remove these
DT properties.

Signed-off-by: David Jander <david@protonic.nl>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 arch/arm/boot/dts/imx6dl-prtvt7.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl-prtvt7.dts b/arch/arm/boot/dts/imx6dl-prtvt7.dts
index 5e68802fee6d..45bc6e3245f6 100644
--- a/arch/arm/boot/dts/imx6dl-prtvt7.dts
+++ b/arch/arm/boot/dts/imx6dl-prtvt7.dts
@@ -267,8 +267,6 @@ touchscreen {
                               <&adc_ts 5>;
 		io-channel-names = "y", "z1", "z2", "x";
 		touchscreen-min-pressure = <64687>;
-		touchscreen-inverted-x;
-		touchscreen-inverted-y;
 		touchscreen-x-plate-ohms = <300>;
 		touchscreen-y-plate-ohms = <800>;
 	};
-- 
2.39.2

