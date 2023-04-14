Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2421C6E1F63
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 11:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjDNJfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 05:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjDNJfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 05:35:12 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F62C83CF;
        Fri, 14 Apr 2023 02:34:48 -0700 (PDT)
Received: from localhost (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DD467660320A;
        Fri, 14 Apr 2023 10:34:21 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681464862;
        bh=0pJdxIJkVJSQqKBTxSYqm8uKUIxBe37vCYuK7W6XaLo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UofXJW8dvLsF4YLVoEdLhw33+WIoxvTTiUglwVfH0K9csK9WtuiwKT4OoJixDaX3k
         hv6YZvrK1Ri0ISZ/jReXdX/pfzK2hPStHZBNeNUchHnCedA+YX/EzVLhUvVqWttyi8
         tNrvYnIuYETJOQSBhx60/s6+By5xrfjaSnXOa1mT2ul+dPxrCV6S6ksASz2lkIl5xF
         JNJUAhLpw9/XTYjZjoHFw9jDC9cyoHER+9Mv2qOeoLr+yEqjlpxMoucVbQ+7FWPFoP
         3Wc5b/5Cnghz46JzcgM23LvTy1YAWJBam8tXlAycLAfHwpEF6a8AF9k2Y4+kwygLgP
         dU+cr9A/V14mA==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Christopher Obbard <chris.obbard@collabora.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Shreeya Patel <shreeya.patel@collabora.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH 2/3] arm64: dts: rockchip: Use generic name for es8316 on rk3588-rock-5b
Date:   Fri, 14 Apr 2023 12:34:10 +0300
Message-Id: <20230414093411.113787-3-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230414093411.113787-1-cristian.ciocaltea@collabora.com>
References: <20230414093411.113787-1-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use generic 'audio-codec' name for es8316 node on Rock 5B board.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
index 62750beb12aa..8cc97d146a73 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
@@ -72,7 +72,7 @@ hym8563: rtc@51 {
 &i2c7 {
 	status = "okay";
 
-	es8316: es8316@11 {
+	es8316: audio-codec@11 {
 		compatible = "everest,es8316";
 		reg = <0x11>;
 		clocks = <&cru I2S0_8CH_MCLKOUT>;
-- 
2.40.0

