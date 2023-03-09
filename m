Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED6A6B2F14
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 21:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjCIUtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 15:49:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbjCIUrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 15:47:49 -0500
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6C9FCF3C;
        Thu,  9 Mar 2023 12:47:37 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 32E0FE9C7A;
        Thu,  9 Mar 2023 12:47:12 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DOtsMJA8AAFH; Thu,  9 Mar 2023 12:47:11 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1678394831; bh=pCDAsfR2lOaVwFkXT961/Eh2p4yd/S/PGbqe0bqp1GU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mzsvwsz9LjjAKTjdAHjea0ymln2b0zSpNVG0Rf0444tZ93ZfSERfnh8RahYEY2B/b
         tEfSPSDynNm75aHogoCoBdMvgJzT2sCD7E9fXM+FKLcjQ5aNSCyXz0+b6qgWiAxR9K
         8Ou05VWtG8WhB/1xA83tUZVZ8Q7Y2gkcwa7frEpfZddcPLSOFwZCft3B1bQKm2ld1v
         Ul4xop5IrnCDMOXa+j5htagsasE43Lw+Z5Zvr44iOb8nFjSwLT4sgf8mWCM7tUlPpt
         egi7aCq1O3I44zhRXB+KQSzj4TPaScmWz/kJB/5FSQk24VDm6nO25vHPo0yGRbvhan
         +GlJVjeiuzPNQ==
To:     robh@kernel.org, krzysztof.kozlowski@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com
Cc:     kernel@puri.sm, linux-imx@nxp.com, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v1 13/14] arm64: dts: imx8mq-librem5: Reduce I2C frequency to 384kHz
Date:   Thu,  9 Mar 2023 21:46:07 +0100
Message-Id: <20230309204608.237605-14-martin.kepplinger@puri.sm>
In-Reply-To: <20230309204608.237605-1-martin.kepplinger@puri.sm>
References: <20230309204608.237605-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>

According to imx8mq errata (ERR007805):

> To meet the clock low period requirement in fast speed mode,
> SCL must be configured to 384KHz or less.

Note that the imx i2c driver already implements this erratum and works
around it. This is only for the description to reflect reality.

Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
index 7e70663cffa30..35bde8d41e8e7 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
@@ -778,7 +778,7 @@ MX8MQ_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B	0x1f
 };
 
 &i2c1 {
-	clock-frequency = <387000>;
+	clock-frequency = <384000>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_i2c1>;
 	status = "okay";
@@ -976,7 +976,7 @@ rtc@68 {
 };
 
 &i2c2 {
-	clock-frequency = <387000>;
+	clock-frequency = <384000>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_i2c2>;
 	status = "okay";
@@ -1025,7 +1025,7 @@ accel_gyro: accel-gyro@6a	{
 };
 
 &i2c3 {
-	clock-frequency = <387000>;
+	clock-frequency = <384000>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_i2c3>;
 	status = "okay";
@@ -1115,7 +1115,7 @@ touchscreen@38 {
 };
 
 &i2c4 {
-	clock-frequency = <387000>;
+	clock-frequency = <384000>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_i2c4>;
 	status = "okay";
-- 
2.30.2

