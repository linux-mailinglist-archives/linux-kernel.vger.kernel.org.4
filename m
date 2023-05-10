Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E939A6FD7C1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 09:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236268AbjEJHCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 03:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjEJHCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 03:02:41 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B1F1BE1;
        Wed, 10 May 2023 00:02:39 -0700 (PDT)
Received: from pendragon.ideasonboard.com (softbank126090219015.bbtec.net [126.90.219.15])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A36F26C8;
        Wed, 10 May 2023 09:02:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1683702151;
        bh=gTyf7K9TCdYPOIWZVBGOcQOImy6JE1GzmR01BgNrEnY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M3fbGCahAx84rnETzh/hUpFny0g4rTZ0zWYwCH+Xa4/8mUh57Zh/zYh3SvIiw+fhJ
         SyHVZgTdYX40XhXyiSlXGVLXICxDL0wi1O68uXQAQ3IS8pwn2uNC3ZVr+HqqlhLLQq
         pvMClXyfnrEmi94+BbvaFrP4pEwbMg91iXpJExUM=
Date:   Wed, 10 May 2023 10:02:34 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Michal Simek <michal.simek@amd.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Harini Katakam <harini.katakam@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Piyush Mehta <piyush.mehta@xilinx.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Tanmay Shah <tanmay.shah@amd.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 08/23] arm64: zynqmp: Add resets property to sdhci nodes
Message-ID: <20230510070234.GG11711@pendragon.ideasonboard.com>
References: <cover.1683034376.git.michal.simek@amd.com>
 <8f8592d6454c024c8f8b92e56c9009c65ad1d54a.1683034376.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8f8592d6454c024c8f8b92e56c9009c65ad1d54a.1683034376.git.michal.simek@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

Thank you for the patch.

On Tue, May 02, 2023 at 03:35:36PM +0200, Michal Simek wrote:
> From: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
> 
> Add "resets" property to sdhci nodes. Resets property is used to reset the
> SD host controller when dynamic configuration support is enabled.
> 
> Signed-off-by: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> 
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> index a117294dc890..7bd3e816226a 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -755,6 +755,7 @@ sdhci0: mmc@ff160000 {
>  			#clock-cells = <1>;
>  			clock-output-names = "clk_out_sd0", "clk_in_sd0";
>  			power-domains = <&zynqmp_firmware PD_SD_0>;
> +			resets = <&zynqmp_reset ZYNQMP_RESET_SDIO0>;
>  		};
>  
>  		sdhci1: mmc@ff170000 {
> @@ -768,6 +769,7 @@ sdhci1: mmc@ff170000 {
>  			#clock-cells = <1>;
>  			clock-output-names = "clk_out_sd1", "clk_in_sd1";
>  			power-domains = <&zynqmp_firmware PD_SD_1>;
> +			resets = <&zynqmp_reset ZYNQMP_RESET_SDIO1>;
>  		};
>  
>  		smmu: iommu@fd800000 {

-- 
Regards,

Laurent Pinchart
