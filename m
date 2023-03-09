Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14CE66B2F0D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 21:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjCIUsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 15:48:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbjCIUrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 15:47:48 -0500
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DE4FFBFF;
        Thu,  9 Mar 2023 12:47:31 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 80729E9B6B;
        Thu,  9 Mar 2023 12:46:56 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Xbgwhex5rcyU; Thu,  9 Mar 2023 12:46:55 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1678394815; bh=NXsv4ig7pDrayBOyT1swTYNEvnq1e/X07EvKNWu6JMg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IdHzzUznf4Y+UMUd7Z4JmuSX5U04Xr25UBzktwlw3bRvj94HrcJrDuHZ8ZF5q3e/W
         /lB4N72Wjok1qupn3TZu1pNvZGEgobbeQ4w7+nna/UVUAl75R8PuiMaAWhV3TXTOyI
         LK1n2bKpEQgCtblIYUiWgrHT+tPkTrRhe5Bi22u994KZd8iRpe9aGqfHWOpSzxlnQU
         6AU7BDv7GeF6xWs0/e4KmRUJ3LbFXgxqskFCKaB5eda0WuJ+e4DM8H5oozRqkh6XyI
         xDJGziyTn3vJbgp6KbpbudMst1DWBVsc67aSsVganM8v+gPXyYqzSn/+3kPOl73qWv
         xGl+wMhZfx4cw==
To:     robh@kernel.org, krzysztof.kozlowski@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com
Cc:     kernel@puri.sm, linux-imx@nxp.com, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Angus Ainslie <angus@akkea.ca>,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v1 08/14] arm64: dts: imx8mq-librem5: add the magnetometer mount matrix
Date:   Thu,  9 Mar 2023 21:46:02 +0100
Message-Id: <20230309204608.237605-9-martin.kepplinger@puri.sm>
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

From: Angus Ainslie <angus@akkea.ca>

Userland needs the mount matrix to know the correct orientation of
the part.

Signed-off-by: Angus Ainslie <angus@akkea.ca>
Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dtsi | 6 ++++++
 arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi    | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dtsi
index c1279e96effd7..db81ed699de75 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dtsi
@@ -38,6 +38,12 @@ MX8MQ_IOMUXC_SPDIF_RX_GPIO5_IO4		0x83
 	};
 };
 
+&magnetometer {
+	mount-matrix =  "1",  "0",  "0",
+			"0", "-1",  "0",
+			"0",  "0", "-1";
+};
+
 &proximity {
 	proximity-near-level = <25>;
 };
diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
index eaf35cff2f8a6..7e470135b86a4 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
@@ -981,7 +981,7 @@ &i2c2 {
 	pinctrl-0 = <&pinctrl_i2c2>;
 	status = "okay";
 
-	magnetometer@1e	{
+	magnetometer: magnetometer@1e	{
 		compatible = "st,lsm9ds1-magn";
 		reg = <0x1e>;
 		pinctrl-names = "default";
-- 
2.30.2

