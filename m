Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35FEB625990
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 12:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233702AbiKKLiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 06:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbiKKLhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 06:37:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BD687B3D;
        Fri, 11 Nov 2022 03:36:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B64DBB82510;
        Fri, 11 Nov 2022 11:36:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87287C433D7;
        Fri, 11 Nov 2022 11:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668166604;
        bh=3RaDnZ53pbckdRhlNF7hOhtOnoJFCOeiN6Pj8MvQ8c8=;
        h=From:To:Cc:Subject:Date:From;
        b=aV9KCEk/eelSsOvQGNfpWwxqxT3sdtc53rs06VUfQu+lfvmnlyWUqyFEAgahVZeae
         xeOxJyMMD851iGKgUL80M8BYAmss+6Kec7H2z5c9nMtE5pQ+29cz2uk80tyw8FJ+q9
         QJRGOFNNOdsl52L7H0d4wO0n9wpF6CTGJFL3VOKRRQAEzCkicmLHOF36Nbjn6Z6hgf
         HouWlXWFbPAmrD5OSEo/rwVkHg6j+ROQs5emKIlQ/woGHL/qZWbo8lWHru3URUUjXY
         WX9qCoP46xs3Klu3QP64ckH11cpsp3dN8rLniuLVy42S8Em2HwVdK0i466Uhd3ohjj
         FcPwfLOnOupcw==
From:   matthias.bgg@kernel.org
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, frank-w@public-files.de
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <mbrugger@suse.com>
Subject: [PATCH] arm64: dts: mediatek: mt7986: Add SoC compatible
Date:   Fri, 11 Nov 2022 12:36:35 +0100
Message-Id: <20221111113635.4603-1-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <mbrugger@suse.com>

Missing SoC compatible in the board file causes dt bindings check.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
---
 arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts | 2 +-
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi    | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
index afe37b702eef9..0e3b603159477 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
@@ -9,7 +9,7 @@
 
 / {
 	model = "MediaTek MT7986a RFB";
-	compatible = "mediatek,mt7986a-rfb";
+	compatible = "mediatek,mt7986a-rfb", "mediatek,mt7986a";
 
 	aliases {
 		serial0 = &uart0;
diff --git a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
index 72e0d9722e07a..1191ecf345a7d 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
@@ -14,6 +14,8 @@ / {
 	#address-cells = <2>;
 	#size-cells = <2>;
 
+	compatible = "mediatek,mt7986a";
+
 	clk40m: oscillator@0 {
 		compatible = "fixed-clock";
 		clock-frequency = <40000000>;
-- 
2.38.0

