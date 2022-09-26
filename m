Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8945EB008
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 20:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiIZSf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 14:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiIZSfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 14:35:55 -0400
Received: from hall.aurel32.net (hall.aurel32.net [IPv6:2001:bc8:30d7:100::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D1C20F58;
        Mon, 26 Sep 2022 11:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
        ; s=202004.hall; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
        Subject:Cc:To:From:Content-Type:From:Reply-To:Subject:Content-ID:
        Content-Description:In-Reply-To:References:X-Debbugs-Cc;
        bh=GkVeS3Zk1J0hHqvSqxxRfJt58YzkCgCZ4A3BhN6JrU4=; b=uyfrzhLkkQ/vfdv0wE0XhNCvP2
        9ee4002Jzqg2sW4OYSOMGtXOacGC5RsjewYs4RlmMwE+oKIyPIdglqeoNbkhopIQKWSlBUGzmhio0
        hycAkmDKufj9WrAATBpx96XZL3sZu2a1vOSJ486zdjpNVD0S/QPbtSC6KJxbVeGUlNts0+odqKxBR
        4BPG0ju3y5m8fphfDws69lXRjui65I40AShZKvDaTVTqtjgy13ZcRUCv544ThkhHdCA1A8XX2y0+5
        CbkhQLMxvBfFUa10Lrpv0BnY7Y8CMDkjbeSTOnBEm2OsbIvt8SC6GZw5/dhSCgwHnrDoN6ZfhUXow
        OXHIQyIA==;
Received: from [2a01:e34:ec5d:a741:8a4c:7c4e:dc4c:1787] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <aurelien@aurel32.net>)
        id 1ocsxH-00B9N6-0B; Mon, 26 Sep 2022 20:35:47 +0200
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.96)
        (envelope-from <aurelien@aurel32.net>)
        id 1ocsxG-007wYd-1Y;
        Mon, 26 Sep 2022 20:35:46 +0200
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     linux-kernel@vger.kernel.org
Cc:     Aurelien Jarno <aurelien@aurel32.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Frank Wunderlich <frank-w@public-files.de>,
        Peter Geis <pgwipeout@gmail.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC
        support),
        linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support)
Subject: [PATCH] arm64: dts: rockchip: Add missing rockchip,pipe-grf to rk3568 PCIe v3 PHY
Date:   Mon, 26 Sep 2022 20:35:32 +0200
Message-Id: <20220926183533.1893371-1-aurelien@aurel32.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit fixes the error message

  rockchip-snps-pcie3-phy fe8c0000.phy: failed to find rockchip,pipe_grf regmap

during boot by providing the missing rockchip,pipe-grf property.

Fixes: faedfa5b40f0 ("arm64: dts: rockchip: Add PCIe v3 nodes to rk3568")
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 arch/arm64/boot/dts/rockchip/rk3568.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568.dtsi b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
index ba67b58f05b7..8818b283ba11 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
@@ -56,6 +56,7 @@ pcie30phy: phy@fe8c0000 {
 		clock-names = "refclk_m", "refclk_n", "pclk";
 		resets = <&cru SRST_PCIE30PHY>;
 		reset-names = "phy";
+		rockchip,pipe-grf = <&pipegrf>;
 		rockchip,phy-grf = <&pcie30_phy_grf>;
 		status = "disabled";
 	};
-- 
2.35.1

