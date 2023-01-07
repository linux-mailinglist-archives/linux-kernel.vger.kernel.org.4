Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4913660AFE
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 01:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235233AbjAGAmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 19:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjAGAmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 19:42:11 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597A368787;
        Fri,  6 Jan 2023 16:42:10 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C9D584AE;
        Sat,  7 Jan 2023 01:42:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1673052128;
        bh=VXio3V1G2wHCgVDVIyaGGzU/pYcByF5l5Yyhd3vd5VQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZAspDIx2BD51CwtgDrDBBAXc/IssFnYI+8wQ/Kehwy/4+yQi/GDkZSARvvUoEWV3F
         1r+taOA0CyyaXe6rctxS3pYyjR6tbNoiSOucdD/6gURGcFmawIHO9FK3GDZ/5N+pDK
         BOL+faf4BihmtaLclc5d5UuhmR2lei5M/MfSRiIw=
Date:   Sat, 7 Jan 2023 02:42:02 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Michal Simek <michal.simek@amd.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Harini Katakam <harini.katakam@amd.com>,
        David Heidelberg <david@ixit.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Piyush Mehta <piyush.mehta@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Sean Anderson <sean.anderson@seco.com>,
        Tanmay Shah <tanmay.shah@amd.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] arm64: dts: zynqmp: Add xlnx prefix to GEM compatible
 string
Message-ID: <Y7i/2g8Awnb2DyA4@pendragon.ideasonboard.com>
References: <578a4fcbb4143888af954996a45f5e1110e0ee50.1672909426.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <578a4fcbb4143888af954996a45f5e1110e0ee50.1672909426.git.michal.simek@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

Thank you for the patch.

On Thu, Jan 05, 2023 at 10:03:51AM +0100, Michal Simek wrote:
> From: Harini Katakam <harini.katakam@amd.com>
> 
> cdns,zynq/zynqmp/versal-gem was recently deprecated in Linux in
> favour of xlnx prefix. Add this new compatible string and remove
> the existing cdns,zynqmp-gem compatible string.
> 
> Signed-off-by: Harini Katakam <harini.katakam@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> 
> Changes in v2:
> - Remove deprecated compatible string
> - Update commit message
> 
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> index 2ff4b788e094..153db59dc4b3 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -540,7 +540,7 @@ nand0: nand-controller@ff100000 {
>  		};
>  
>  		gem0: ethernet@ff0b0000 {
> -			compatible = "cdns,zynqmp-gem", "cdns,gem";
> +			compatible = "xlnx,zynqmp-gem", "cdns,gem";
>  			status = "disabled";
>  			interrupt-parent = <&gic>;
>  			interrupts = <0 57 4>, <0 57 4>;
> @@ -555,7 +555,7 @@ gem0: ethernet@ff0b0000 {
>  		};
>  
>  		gem1: ethernet@ff0c0000 {
> -			compatible = "cdns,zynqmp-gem", "cdns,gem";
> +			compatible = "xlnx,zynqmp-gem", "cdns,gem";
>  			status = "disabled";
>  			interrupt-parent = <&gic>;
>  			interrupts = <0 59 4>, <0 59 4>;
> @@ -570,7 +570,7 @@ gem1: ethernet@ff0c0000 {
>  		};
>  
>  		gem2: ethernet@ff0d0000 {
> -			compatible = "cdns,zynqmp-gem", "cdns,gem";
> +			compatible = "xlnx,zynqmp-gem", "cdns,gem";
>  			status = "disabled";
>  			interrupt-parent = <&gic>;
>  			interrupts = <0 61 4>, <0 61 4>;
> @@ -585,7 +585,7 @@ gem2: ethernet@ff0d0000 {
>  		};
>  
>  		gem3: ethernet@ff0e0000 {
> -			compatible = "cdns,zynqmp-gem", "cdns,gem";
> +			compatible = "xlnx,zynqmp-gem", "cdns,gem";
>  			status = "disabled";
>  			interrupt-parent = <&gic>;
>  			interrupts = <0 63 4>, <0 63 4>;

-- 
Regards,

Laurent Pinchart
