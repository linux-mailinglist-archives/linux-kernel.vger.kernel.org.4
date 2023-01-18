Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5623672096
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 16:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbjARPIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 10:08:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbjARPIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 10:08:04 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4695C1A943;
        Wed, 18 Jan 2023 07:08:04 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 981FB1643;
        Wed, 18 Jan 2023 16:08:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1674054481;
        bh=cbYIJLxWYvhHSRoHhaPJMPAY7kxciyPP8qzt5JPTBHY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qj4NmTJFzI7/kZUqMUTNBseLA4rYjHurwh61GjjfXOmW5S1FGn9a6L/cqXHQbQYD3
         ExZfDDDY54ExJnmoAYklZkoaBi18uUruA5TzNYrdifEtk1fTc5IhCuLSj4zf0KE/7L
         DYSUaUCNFYkRECyEskZTqUusasVMH02bdCatx3kc=
Date:   Wed, 18 Jan 2023 17:07:59 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Subject: Re: [PATCH] arm64: dts: renesas: r9a09g011: Reword ethernet status
Message-ID: <Y8gLTxuedrE2TUfq@pendragon.ideasonboard.com>
References: <20230118135259.19249-1-fabrizio.castro.jz@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230118135259.19249-1-fabrizio.castro.jz@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabrizio,

Thank you for the patch.

On Wed, Jan 18, 2023 at 01:52:59PM +0000, Fabrizio Castro wrote:
> Although of_fdt_device_is_available returns true when the DT
> property "status" is assigned "ok" or "okay", and false for every
> other value, it's become common practice to assign "disabled"
> when we want of_fdt_device_is_available to return false.
> For some reason, the status property of the ethernet node was
> assigned "disable" when originally added to the kernel. Change
> it to "disabled" for consistency.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
>  arch/arm64/boot/dts/renesas/r9a09g011.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r9a09g011.dtsi b/arch/arm64/boot/dts/renesas/r9a09g011.dtsi
> index dd35a8ff72ee..b0c066c5e0ba 100644
> --- a/arch/arm64/boot/dts/renesas/r9a09g011.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r9a09g011.dtsi
> @@ -165,7 +165,7 @@ avb: ethernet@a3300000 {
>  			power-domains = <&cpg>;
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> -			status = "disable";
> +			status = "disabled";
>  		};
>  
>  		cpg: clock-controller@a3500000 {

-- 
Regards,

Laurent Pinchart
