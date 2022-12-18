Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D8164FF36
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 16:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiLRPDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 10:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiLRPC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 10:02:58 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86DFB849;
        Sun, 18 Dec 2022 07:02:57 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E0B01825;
        Sun, 18 Dec 2022 16:02:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1671375776;
        bh=angMpOKX3ruM++I5kn+WH32q/8+BFsyeQw59CY3/WN4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IgqfzVDldi4oIGW4h9OlHuNoPEbvuwc7fluBoG7gPeI4UVMXx/7HGZFpuxpnRA9Ab
         rPcTAZHRvKfO65Wkx+QLSio0UvGCmY5Xd5GVH0gV9uNlWXF3oHi3R2YTcabCyAU6/k
         0bxmiXVEnV1M64u9YLQVjghj0Oz1x8hcyzD6MWPs=
Date:   Sun, 18 Dec 2022 17:02:52 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: imx8mp: Fix power-domain typo
Message-ID: <Y58rnBMSLHtELIU4@pendragon.ideasonboard.com>
References: <20221217180849.775718-1-aford173@gmail.com>
 <20221217180849.775718-2-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221217180849.775718-2-aford173@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

Thank you for the patch.

On Sat, Dec 17, 2022 at 12:08:49PM -0600, Adam Ford wrote:
> dt_binding_check detects an issue with the pgc_hsiomix power
> domain:
>   pgc: 'power-domains@17' does not match any of the regexes
> 
> This is because 'power-domains' should be 'power-domain'

Oops.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> Fixes: 2ae42e0c0b67 ("arm64: dts: imx8mp: add HSIO power-domains")
> Signed-off-by: Adam Ford <aford173@gmail.com>
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> index 7a8ca56e48b6..19609ef0560a 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -591,7 +591,7 @@ pgc_mipi_phy2: power-domain@16 {
>  						reg = <IMX8MP_POWER_DOMAIN_MIPI_PHY2>;
>  					};
>  
> -					pgc_hsiomix: power-domains@17 {
> +					pgc_hsiomix: power-domain@17 {
>  						#power-domain-cells = <0>;
>  						reg = <IMX8MP_POWER_DOMAIN_HSIOMIX>;
>  						clocks = <&clk IMX8MP_CLK_HSIO_AXI>,

-- 
Regards,

Laurent Pinchart
