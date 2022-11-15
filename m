Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E437628CFB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 00:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237931AbiKNXCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 18:02:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237863AbiKNXCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 18:02:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75C11B7B2;
        Mon, 14 Nov 2022 15:02:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65E1AB815C9;
        Mon, 14 Nov 2022 23:02:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0453EC43146;
        Mon, 14 Nov 2022 23:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668466949;
        bh=SbGaxIgecXbcJ4YaHl7Qj9l6cKlCJwLyETRWGn6erYU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=roEah/ZCp8R7JeSAGqtvJ+Cw2npX1Pu0V9Eo0Hu7l9QWdnhknsm1kDi9oKzCdicf2
         s58zGJxh1/p4tJbfq6c73cEvVKKI4dA9PjJ7JMowcDfhcAEmuv6lydMX8bgxgIqtyg
         Bq08irWXMl239opwZJDU3DMSabRNurvSX9q5sKThd+jT3IHSOHfngitAUW5nOl9T8+
         WXfJ2/nn0uerVbtEGV5yYlv15ZRW7ybm2Sk2jtdD/pZfPZLCDpL5l/wxC4F46IwMio
         jIqZx4sDLfG3siak2Kt6ubJ6yf2zDf8ebYdNpTXGM6HQkVB4poepM+8w6L8NnlpE1y
         7qnyq819sBLUA==
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     jh80.chung@samsung.com
Cc:     dinguyen@kernel.org, ulf.hansson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCHv9 6/6] arm: dts: socfpga: remove "clk-phase" in sdmmc_clk
Date:   Mon, 14 Nov 2022 17:02:17 -0600
Message-Id: <20221114230217.202634-6-dinguyen@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221114230217.202634-1-dinguyen@kernel.org>
References: <20221114230217.202634-1-dinguyen@kernel.org>
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

Now that the SDMMC driver can use the "clk-phase-sd-hs" binding, we don't
need the clk-phase in the sdmmc_clk anymore.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
v9: no changes
v8: no changes
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

