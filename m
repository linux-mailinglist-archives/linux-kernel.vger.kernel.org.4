Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B840E6F581C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 14:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjECMq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 08:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjECMq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 08:46:57 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5263C4688;
        Wed,  3 May 2023 05:46:55 -0700 (PDT)
Received: from pendragon.ideasonboard.com (133-32-181-51.west.xps.vectant.ne.jp [133.32.181.51])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7F3197FC;
        Wed,  3 May 2023 14:46:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1683118010;
        bh=8tpFe1mRbMpuQYRWmCcz3C5R1eFk43c/5w1n3EfEaUs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FhsmWa0sixUOzftKQtwho5RwLw2gOXgSmC/P3VXYP2UI9aw/85Eaqy5FPSijbOC9Q
         Z6hqQusspQI8XN7J+lWSjQitUoyIsEKOuQQYH4KMgNvF0ZWXFJ8WlL8FD2ySmU+yIm
         VcvSd90WihXf3Wb2Al9wGPMqSlc0jKf0hDvmIZ9M=
Date:   Wed, 3 May 2023 15:47:06 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Michal Simek <michal.simek@amd.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Harini Katakam <harini.katakam@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Tanmay Shah <tanmay.shah@amd.com>,
        Vishal Sagar <vishal.sagar@amd.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] Revert "arm64: dts: zynqmp: Add address-cells property
 to interrupt controllers"
Message-ID: <20230503124706.GD32586@pendragon.ideasonboard.com>
References: <e3312910db0922bb8c24a8e681de41709ca11bdf.1683035456.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e3312910db0922bb8c24a8e681de41709ca11bdf.1683035456.git.michal.simek@amd.com>
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

On Tue, May 02, 2023 at 03:51:01PM +0200, Michal Simek wrote:
> This reverts commit c6badbd2d321c19d4f55ee56b0ef12bb3352feac.
> 
> Long time ago this was discussed with Rob at link below that there is no
> need to add address-cells to gpio and interrupt nodes that's why reverting
> this patch for ZynqMP.
> Also there is no visible DTC warning which was seen in past.
> 
> Link: https://lore.kernel.org/r/91e3405245c89f134676449cf3822285798d2ed2.1612189652.git.michal.simek@xilinx.com
> Signed-off-by: Michal Simek <michal.simek@amd.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> 
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> index 51b8349dcacd..2d564ba7e9e4 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -419,7 +419,6 @@ fpd_dma_chan8: dma-controller@fd570000 {
>  
>  		gic: interrupt-controller@f9010000 {
>  			compatible = "arm,gic-400";
> -			#address-cells = <0>;
>  			#interrupt-cells = <3>;
>  			reg = <0x0 0xf9010000 0x0 0x10000>,
>  			      <0x0 0xf9020000 0x0 0x20000>,
> @@ -633,7 +632,6 @@ gem3: ethernet@ff0e0000 {
>  		gpio: gpio@ff0a0000 {
>  			compatible = "xlnx,zynqmp-gpio-1.0";
>  			status = "disabled";
> -			#address-cells = <0>;
>  			#gpio-cells = <0x2>;
>  			gpio-controller;
>  			interrupt-parent = <&gic>;

-- 
Regards,

Laurent Pinchart
