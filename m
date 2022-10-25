Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8291260C5A6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 09:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbiJYHnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 03:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbiJYHms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 03:42:48 -0400
Received: from mxout3.routing.net (mxout3.routing.net [IPv6:2a03:2900:1:a::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4BB15A8E7;
        Tue, 25 Oct 2022 00:42:47 -0700 (PDT)
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
        by mxout3.routing.net (Postfix) with ESMTP id 7DC3B625BD;
        Tue, 25 Oct 2022 07:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1666683765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m0tnr5ZD8EC2va1ebYMWM4ouc4PlgDpshSSnTTqC0Pw=;
        b=T6ILDSntEIQG1Lxfaudwh18uKwgDURHsEnVpRrwudk2wmE2Nkv4pRrC3LEClFMoMwqm0hc
        M0oO2pzuiWZ290pHr7+ZhSZS6zoobZ1BARZR9XVeAauja3LOvKGf2ueZy6Jva3oQP4iWjQ
        ChVGPvjSSNCMsG7zcQBx+RTlHoaVGXc=
Received: from frank-G5.. (fttx-pool-217.61.152.57.bambit.de [217.61.152.57])
        by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 9EB97360310;
        Tue, 25 Oct 2022 07:42:44 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sam Shih <Sam.Shih@mediatek.com>
Subject: [PATCH v4 3/6] arm64: dts: mediatek: mt2712e: swap last 2 clocks to match binding
Date:   Tue, 25 Oct 2022 09:42:35 +0200
Message-Id: <20221025074238.18136-4-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221025074238.18136-1-linux@fw-web.de>
References: <20221025074238.18136-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 2109dc3c-1eb0-4146-986b-e8934a220a40
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

First 3 clocks for mt2712 need to be "source", "hclk", "source_cg"
so swap last 2 of mmc0 to match the binding.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
index e6d7453e56e0..9dc0794fcd2e 100644
--- a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
@@ -766,9 +766,9 @@ mmc0: mmc@11230000 {
 		interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_LOW>;
 		clocks = <&pericfg CLK_PERI_MSDC30_0>,
 			 <&pericfg CLK_PERI_MSDC50_0_HCLK_EN>,
-			 <&pericfg CLK_PERI_MSDC30_0_QTR_EN>,
-			 <&pericfg CLK_PERI_MSDC50_0_EN>;
-		clock-names = "source", "hclk", "bus_clk", "source_cg";
+			 <&pericfg CLK_PERI_MSDC50_0_EN>,
+			 <&pericfg CLK_PERI_MSDC30_0_QTR_EN>;
+		clock-names = "source", "hclk", "source_cg", "bus_clk";
 		status = "disabled";
 	};
 
-- 
2.34.1

