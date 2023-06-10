Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932AA72ABDC
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 15:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjFJNs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 09:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbjFJNs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 09:48:56 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5160BC;
        Sat, 10 Jun 2023 06:48:55 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2405:201:0:21ea:e49:10dd:40c0:e842])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: shreeya)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C26476606EB4;
        Sat, 10 Jun 2023 14:48:50 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686404934;
        bh=YfRPMg6H1Vu6qLLPU55djOlkqrSJyxogmbIBi0tm8ps=;
        h=From:To:Cc:Subject:Date:From;
        b=WJP115exnOuhndKFVId7R5RsPwblkmS+fOkVi6XKBQDmRyYrYUfotabp/1I32VyNf
         7zMgne2XdHARpVU4L/jt2fUr4fjIRNEnfOLaTsiZex+/QsXQ5gvclyPfssuIlijmM7
         iXxySJGtfsUIaFryY7M+jQJaqhRiATDyTrtHo3UMVwB1dgLOTA5S1ct0t5nQfwRdW5
         +0xPAIwXYWzUxX9E8lxckAham6PYTualXqqkm5aU/GTVER4NoQUGGz3u38gbppfP+3
         m0yXZNCuiOpyEqpXAl5E1QqVryH53KnhFcLyuz7dfreMWE4FkczU1N7FRCw7bVbNbM
         Lq7yvETSFPijw==
From:   Shreeya Patel <shreeya.patel@collabora.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, heiko@sntech.de,
        sebastian.reichel@collabora.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, gustavo.padovan@collabora.com,
        serge.broslavsky@collabora.com,
        Shreeya Patel <shreeya.patel@collabora.com>
Subject: [PATCH] arm64: dts: rockchip: rock5b: Add saradc node
Date:   Sat, 10 Jun 2023 19:18:41 +0530
Message-Id: <20230610134841.172313-1-shreeya.patel@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ADC support for ROCK 5B.

Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
index 154b1089db77..181874905850 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
@@ -207,6 +207,11 @@ &pwm1 {
 	status = "okay";
 };
 
+&saradc {
+	status = "okay";
+	vref-supply = <&avcc_1v8_s0>;
+};
+
 &sdhci {
 	bus-width = <8>;
 	no-sdio;
-- 
2.30.2

