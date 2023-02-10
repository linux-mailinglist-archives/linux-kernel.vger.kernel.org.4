Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 503876922CF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 16:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbjBJP7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 10:59:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbjBJP7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 10:59:03 -0500
Received: from uho.ysoft.cz (uho.ysoft.cz [81.19.3.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC92458A5;
        Fri, 10 Feb 2023 07:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
        s=20160406-ysoft-com; t=1676044184;
        bh=xhuEnx2CumrOZ+cKIjzr+gDXyBCBui5kdVMb7hJPh5M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SghtOdBJ+dMJIBcjcQvfAuEK+sHvLe4wW7KTAcH5oU/OXvA6VgDcJAmjGqeY6UxRE
         RpPuG0qngh6tDXzmqFWZIvPH4CSd1KGULeQsBDuLKmRQ/UoKnmN2UznIu+KwLD3+vQ
         6ys0z7qhqPNZ4z8dpmj84nzrJ9oOAwo8fY4UwpE0=
Received: from vokac-Latitude-7410.ysoft.local (unknown [10.1.8.111])
        by uho.ysoft.cz (Postfix) with ESMTP id 134C7A010B;
        Fri, 10 Feb 2023 16:49:44 +0100 (CET)
From:   =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Subject: [PATCH 2/6] ARM: dts: imx6dl-yapp4: Change LED channel names according to dt-binding
Date:   Fri, 10 Feb 2023 16:48:51 +0100
Message-Id: <20230210154855.3086900-3-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230210154855.3086900-1-michal.vokac@ysoft.com>
References: <20230210154855.3086900-1-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lp55xx LED controller binding was converted to schema and dtbs_check
now complains:

  led-controller@30: 'chan@0', 'chan@1', 'chan@2' do not match any of the regexes

Use correct names to fix that.

Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
---
 arch/arm/boot/dts/imx6dl-yapp4-common.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
index 52162e8c7274..aacbf317feea 100644
--- a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
+++ b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
@@ -274,7 +274,7 @@ leds: led-controller@30 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		chan@0 {
+		led@0 {
 			chan-name = "R";
 			led-cur = /bits/ 8 <0x20>;
 			max-cur = /bits/ 8 <0x60>;
@@ -282,7 +282,7 @@ chan@0 {
 			color = <LED_COLOR_ID_RED>;
 		};
 
-		chan@1 {
+		led@1 {
 			chan-name = "G";
 			led-cur = /bits/ 8 <0x20>;
 			max-cur = /bits/ 8 <0x60>;
@@ -290,7 +290,7 @@ chan@1 {
 			color = <LED_COLOR_ID_GREEN>;
 		};
 
-		chan@2 {
+		led@2 {
 			chan-name = "B";
 			led-cur = /bits/ 8 <0x20>;
 			max-cur = /bits/ 8 <0x60>;
-- 
2.25.1

