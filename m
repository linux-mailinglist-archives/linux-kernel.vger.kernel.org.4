Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489CB74DB9E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 18:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjGJQwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 12:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbjGJQwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 12:52:35 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C07FF4;
        Mon, 10 Jul 2023 09:52:35 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-189-246.ewe-ip-backbone.de [91.248.189.246])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7C52B660700D;
        Mon, 10 Jul 2023 17:52:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689007952;
        bh=3T6R53iEwpPY/kj6xBN/ggft/CaTR55t0Gd3VFcgnDg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GjPae7hvup5PHsZBHp3QERTx6JTI2bZiVgQZD9n+qj9YenY4nQeAdo88dT9vprK7L
         I8i8IFc1WsKgtrsDsrPLeRFvWcqSAksNI+z2CRzUjPWKIxon3sYk5g1MOVJDGiaCfU
         uGdehEVobkeI/XZFuAcM4bJE8Yrn9gVJVQr1j1QJI28Yd8SuAyGuPR9XttWN3seY7n
         I7VInvfCVtENDxFBmspF+P+K70X9WPt9n8A7MpbsZVxhFzBoDZuon10zNTDKIlmnV8
         kz9roRF3hSvx/7tR+iKGazIftnxsJWYQvTQ3k+5+2lXxpUctSi+j7B5f9xmS4tQP8B
         plVqMyjMd4Rkg==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 225BA4805CC; Mon, 10 Jul 2023 18:52:28 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Lucas Tanure <lucas.tanure@collabora.com>,
        kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v1 06/13] arm64: dts: rockchip: rock-5a: add SD card support
Date:   Mon, 10 Jul 2023 18:52:21 +0200
Message-Id: <20230710165228.105983-7-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230710165228.105983-1-sebastian.reichel@collabora.com>
References: <20230710165228.105983-1-sebastian.reichel@collabora.com>
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

From: Lucas Tanure <lucas.tanure@collabora.com>

Add sdmmc support for Rock Pi 5A board.

Signed-off-by: Lucas Tanure <lucas.tanure@collabora.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
index 87864a991b50..19e05dba2794 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
@@ -188,6 +188,20 @@ &sdhci {
 	status = "okay";
 };
 
+&sdmmc {
+	max-frequency = <150000000>;
+	no-sdio;
+	no-mmc;
+	bus-width = <4>;
+	cap-mmc-highspeed;
+	cap-sd-highspeed;
+	disable-wp;
+	sd-uhs-sdr104;
+	vmmc-supply = <&vcc_3v3_s0>;
+	vqmmc-supply = <&vccio_sd_s0>;
+	status = "okay";
+};
+
 &spi2 {
 	status = "okay";
 	assigned-clocks = <&cru CLK_SPI2>;
-- 
2.40.1

