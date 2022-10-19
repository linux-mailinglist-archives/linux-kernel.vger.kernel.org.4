Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D53604E34
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 19:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbiJSRIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 13:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbiJSRHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 13:07:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8101C25DF;
        Wed, 19 Oct 2022 10:07:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E3572B82569;
        Wed, 19 Oct 2022 17:07:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A62C433D6;
        Wed, 19 Oct 2022 17:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666199263;
        bh=NBiNwt7o0VNrUfZVe+mze7hfm/agY6VvLH9+RfpkjI4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XDO4lZI7Y+1o0w/32vAGAx5EDuVyphtGY+VGYBpbXLcRmeqKpQfEGyHGeQS/49/4p
         c0cPG5HOjo/6+hYy5oyrfZklgqYZuuZmXNn7OjTTybluP383b2PvZi3GfPqgR/LKe4
         v5oWAlpHGXGb09aidwHCFup7X25IBw4gsHM0YykI6RUw6BkJkiP+C/pnA54t3j335k
         nqy9FWaQVZaHqs3iGGJ8BSNGm0EkqrGYlHel+8ALJczCBZ+AaZ6DPMhKl3NkylD9Cp
         5sYpOyyHNvx5j9ELvxaxNGynJJdr3vmY9uBUtVfsyCMDWZSe+e9bMxq7xgn8MWaqhe
         k0aNSV6BzO2xQ==
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     jh80.chung@samsung.com
Cc:     dinguyen@kernel.org, ulf.hansson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCHv5 6/6] arm: dts: socfpga: remove "clk-phase" in sdmmc_clk
Date:   Wed, 19 Oct 2022 12:06:57 -0500
Message-Id: <20221019170657.68014-7-dinguyen@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221019170657.68014-1-dinguyen@kernel.org>
References: <20221019170657.68014-1-dinguyen@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

