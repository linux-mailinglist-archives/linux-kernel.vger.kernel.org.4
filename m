Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C38369549B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 00:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjBMXU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 18:20:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjBMXU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 18:20:27 -0500
Received: from stravinsky.debian.org (stravinsky.debian.org [IPv6:2001:41b8:202:deb::311:108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBF2113C5;
        Mon, 13 Feb 2023 15:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
        s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
        :References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=LG/q1WY/U+U/uFSQNISKRuzbP6EKDwVnNYE4h0kB6+M=; b=k/Rwak50+8guCi1PT4i7JvBAZy
        kF/eKgf6Pk9eAFoU4t+TQJonsFB6Ktzle9rfyOPXz3++9dV24387bFaDQG4ep4m2KgRNJszLvVVbC
        BmcuHVA9ga1lAra5ojPA7liVIFdkivSUdhMmgVITlu1f0c1d2szXHobTdUrB2/AT6KD/Gz7kLHtJZ
        RBLeqLjp/CNTKMS+4lUMFUxxJ2tumi/paXpj7kx7He3/TIUPTxXUY+IjsDmIMy8wwNbnUpFlAlbHj
        BBY4oL/KT8s0UMLdwLZ9w6mgl8G5Dw5EwqTtNceTlY4yKe2YrekAxIe4CnKSKKnFEY+rk1FEDMyrq
        MWhBNcxw==;
Received: from authenticated user
        by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <bage@debian.org>)
        id 1pRi7A-0013qZ-48; Mon, 13 Feb 2023 23:20:04 +0000
From:   Bastian Germann <bage@debian.org>
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>
Cc:     Bastian Germann <bage@debian.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        devicetree@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: allwinner: a64: Add hwspinlock node
Date:   Tue, 14 Feb 2023 00:19:30 +0100
Message-Id: <20230213231931.6546-4-bage@debian.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230213231931.6546-1-bage@debian.org>
References: <20230213231931.6546-1-bage@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Debian-User: bage
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the hwspinlock to A64 which is already implemented for A31.

Signed-off-by: Bastian Germann <bage@debian.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 77b5349f6087..d4be8be0f2f3 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -851,6 +851,16 @@ wdt0: watchdog@1c20ca0 {
 			clocks = <&osc24M>;
 		};
 
+		hwspinlock: hwlock@1c18000 {
+			compatible = "allwinner,sun6i-a31-hwspinlock";
+			reg = <0x01c18000 0x1000>;
+			clocks = <&ccu CLK_BUS_SPINLOCK>;
+			clock-names = "ahb";
+			resets = <&ccu RST_BUS_SPINLOCK>;
+			reset-names = "ahb";
+			#hwlock-cells = <1>;
+		};
+
 		spdif: spdif@1c21000 {
 			#sound-dai-cells = <0>;
 			compatible = "allwinner,sun50i-a64-spdif",
-- 
2.39.1

