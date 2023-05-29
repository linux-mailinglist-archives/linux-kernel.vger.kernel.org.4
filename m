Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C50714EB8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 19:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjE2RFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 13:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjE2RFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 13:05:37 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42991B5;
        Mon, 29 May 2023 10:05:36 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-212-236.ewe-ip-backbone.de [91.248.212.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C25996605961;
        Mon, 29 May 2023 18:05:34 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685379934;
        bh=xH8PWa9VSV+c2f1XMWbXNN3LL+RLVhtLxiDB+5plPzY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PHyDCkx37kcDgV+p61IUy0+8Xj2U6iHNG3iCtyXUhp3iZPcA36U0+BHCEFKGStK6Z
         6eSzGRPQEmWoyhZf3a6THPF1nsNqIXu7DuTFdrYHGrxlcAQ+IFCkYaEPuHvQ+Vx7Eq
         FVvGZx6q1sfovYhllsNcIAP7XGRzNGlhqF8KGxUn/bdZiuZuNfRJNa2Xh9tP3HzaIH
         uVJuMWfX+X6H/5DgZZ5q0Z8iTrIb7fotCD8Kv23QreOY0Fbut6C9ZsuxnOZtiXtKn2
         6JlJQ5ZYkfCwGIGbgm8mSlRyJbDEpHkwmcvS4xFiaYBaqcU5LQAomO9mA6KYNkm6pc
         KRpIRyiBQz4HQ==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 756E74807E2; Mon, 29 May 2023 19:05:32 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v1 2/2] arm64: dts: rockchip: rock-5b: Add SD card support
Date:   Mon, 29 May 2023 19:05:32 +0200
Message-Id: <20230529170532.59804-2-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230529170532.59804-1-sebastian.reichel@collabora.com>
References: <20230529170532.59804-1-sebastian.reichel@collabora.com>
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

Add sdmmc support for Rock Pi 5B board.

Signed-off-by: Lucas Tanure <lucas.tanure@collabora.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
index 2180fea1fb82..e62538cbaf25 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
@@ -216,6 +216,20 @@ &sdhci {
 	status = "okay";
 };
 
+&sdmmc {
+	max-frequency = <200000000>;
+	no-sdio;
+	no-mmc;
+	bus-width = <4>;
+	cap-mmc-highspeed;
+	cap-sd-highspeed;
+	disable-wp;
+	sd-uhs-sdr104;
+	vmmc-supply = <&vcc_3v3_s3>;
+	vqmmc-supply = <&vccio_sd_s0>;
+	status = "okay";
+};
+
 &spi2 {
 	status = "okay";
 	assigned-clocks = <&cru CLK_SPI2>;
-- 
2.39.2

