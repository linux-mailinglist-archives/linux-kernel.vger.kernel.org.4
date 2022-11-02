Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB11616B07
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 18:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbiKBRjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 13:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbiKBRjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 13:39:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C21C2494F;
        Wed,  2 Nov 2022 10:39:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AD838B820D6;
        Wed,  2 Nov 2022 17:38:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FC89C4347C;
        Wed,  2 Nov 2022 17:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667410738;
        bh=rZM/Jb1cF/J5Dk3UhHZ90vCNfl/3XrVYW+A+ti6fTZc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IesK7MHd5dukyAch713I2OIRLuxBIEKDFThjLDy+6HpPA7XO44jmY/IudmGKOzHhI
         fhtLEZHiZPF3W618g13kxdNg2tnI4NvyOZVJqmQmBUa8J+c1uO4pVk94gdlzrMIDXa
         bh6ISUfiDFu5i7tUpvvdvfDuY7hs4NPSULfnevvj7QLa3/supqr3azusXRue9rh/LK
         PVG9xE+acBHC301oQ2eB1kctQf1wlDNEESIjPMK7FctYNwYgra+KBbTRuT0nitNDCM
         6e3C5/gqs+ppnV+goFfPJzzeDrCfxJrlMY5tTiBQ1z0SebI5RLu4jbBSSoPeFOFO+X
         71MFSiTvHTeng==
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     jh80.chung@samsung.com
Cc:     dinguyen@kernel.org, ulf.hansson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCHv7 6/6] arm: dts: socfpga: remove "clk-phase" in sdmmc_clk
Date:   Wed,  2 Nov 2022 12:38:43 -0500
Message-Id: <20221102173843.409039-6-dinguyen@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221102173843.409039-1-dinguyen@kernel.org>
References: <20221102173843.409039-1-dinguyen@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the SDMMC driver can use the "clk-phase-sd-hs" binding, we don't
need the clk-phase in the sdmmc_clk anymore.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
v7: no changes
v6: no changes
v5: new
---
 arch/arm/boot/dts/socfpga.dtsi         | 1 -
 arch/arm/boot/dts/socfpga_arria10.dtsi | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 604fc6e0c4ad..a2419a5c6c26 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -453,7 +453,6 @@ sdmmc_clk: sdmmc_clk {
 						compatible = "altr,socfpga-gate-clk";
 						clocks = <&f2s_periph_ref_clk>, <&main_nand_sdmmc_clk>, <&per_nand_mmc_clk>;
 						clk-gate = <0xa0 8>;
-						clk-phase = <0 135>;
 					};
 
 					sdmmc_clk_divided: sdmmc_clk_divided {
diff --git a/arch/arm/boot/dts/socfpga_arria10.dtsi b/arch/arm/boot/dts/socfpga_arria10.dtsi
index b6ebe207e2bc..eb528c103d70 100644
--- a/arch/arm/boot/dts/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10.dtsi
@@ -365,7 +365,6 @@ sdmmc_clk: sdmmc_clk {
 						compatible = "altr,socfpga-a10-gate-clk";
 						clocks = <&sdmmc_free_clk>;
 						clk-gate = <0xC8 5>;
-						clk-phase = <0 135>;
 					};
 
 					qspi_clk: qspi_clk {
-- 
2.25.1

