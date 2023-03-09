Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7967B6B2F15
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 21:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbjCIUtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 15:49:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbjCIUsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 15:48:04 -0500
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A811517C;
        Thu,  9 Mar 2023 12:48:02 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 9325DE9BF0;
        Thu,  9 Mar 2023 12:47:05 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6770ymWoZ0eR; Thu,  9 Mar 2023 12:47:05 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1678394824; bh=Ktp9bUrxSX7wd0bBSswKFZcvkfXHkuw7rvjQsizXMPo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OYYUTZ+Rs8/QbNaM6HlRfccL931QSSy28/1juCnqS4Q8DHFtRzMJ2YET/PqQI77NZ
         XF2t+WaecSHra4hPZGp8i9qqLZXM+f2ZNBcG8MqLKB9/udKj8NGG0QSJ4c+ndC5Ju4
         UlZUlEVlvVQx4EpuhRfU3Od/+1Tb0YDwSUKBqE2/LVgilKBLTthYdCq8ktQ9ac9njc
         MhOQ+vKtIGKtv/nhDRksSdpOnW1wtc9JCl3m53OOBcvJQNqqfRixgjYE1mJw8jQBu5
         Fiu+wsTBPCQG0EPZvZ5tk37C/+oIs4xCcCZy3k4tg1qcMUHphng92fn4oEKSbHwfoR
         mKqX5jeGCq29Q==
To:     robh@kernel.org, krzysztof.kozlowski@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com
Cc:     kernel@puri.sm, linux-imx@nxp.com, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v1 11/14] arm64: dts: imx8mq-librem5: Remove dis_u3_susphy_quirk from usb_dwc3_0
Date:   Thu,  9 Mar 2023 21:46:05 +0100
Message-Id: <20230309204608.237605-12-martin.kepplinger@puri.sm>
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

This reduces power consumption in system suspend by about 10%.

Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
index 0b4b49fa1392a..f557632f574fa 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
@@ -1322,7 +1322,6 @@ &usb_dwc3_0 {
 	#address-cells = <1>;
 	#size-cells = <0>;
 	dr_mode = "otg";
-	snps,dis_u3_susphy_quirk;
 	usb-role-switch;
 	status = "okay";
 
-- 
2.30.2

