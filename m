Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E04D721B11
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 01:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbjFDXX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 19:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjFDXX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 19:23:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D55EA8;
        Sun,  4 Jun 2023 16:23:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDCED60A6F;
        Sun,  4 Jun 2023 23:23:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8DC7C433D2;
        Sun,  4 Jun 2023 23:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685921035;
        bh=V9LESKCHeGbMcnFP0vVt52k0cpabNqrKbgbb3i99zuc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E0cNWYjdgd1ZX3ItgsVQ6VbQ9A8uONmnH4pGdW1YBmhWL+c3QfZHhy4vrpcLEgwTz
         WqJ0wBBClaIrPq68VdtqiCbmaaWdeR0/YqnVrkQ94LdDKEGc+9quPspMH/pljOI+D9
         cfLfVQWlC8EVqTKqd1NvKFNVwvMBYYxB2+uiOFf7nMIgKga3TUqkZG1lIJ2D0XWUkc
         SnZkGp6qh3GgNFE0NCsECg27Y/yuh3Eut5DtkkcLzALqxiiLXhrhXZYCIhEw1m7LYz
         E3AU00bBMv3FgvuCtcEFf80D14XwJgEalt8MxVFinXtAWVnchl4LqNNWYKvSgZgJql
         A3Oq39Kk7wXEA==
Date:   Mon, 5 Jun 2023 07:23:42 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, pawell@cadence.com,
        rogerq@kernel.org, a-govindraju@ti.com, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH 1/2] usb: cdns3: imx: simplify clock name usage
Message-ID: <20230604232342.GF258497@nchen-desktop>
References: <20230517152545.3404508-1-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517152545.3404508-1-Frank.Li@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-05-17 11:25:44, Frank Li wrote:
> Simplifies the clock names in imx_cdns3_core_clks[]. Such as, renaming
> "usb3_lpm_clk" to "lpm". The "usb3" prefix and "clk" suffix were
> redundant.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Acked-by: Peter Chen <peter.chen@kernel.org>
> ---
> 
> This patch was missed at
> https://lore.kernel.org/imx/20230327145523.3121810-1-Frank.Li@nxp.com/
> 
>  drivers/usb/cdns3/cdns3-imx.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/cdns3/cdns3-imx.c b/drivers/usb/cdns3/cdns3-imx.c
> index 59860d1753fd..5d9ca3c3c71d 100644
> --- a/drivers/usb/cdns3/cdns3-imx.c
> +++ b/drivers/usb/cdns3/cdns3-imx.c
> @@ -105,11 +105,11 @@ static inline void cdns_imx_writel(struct cdns_imx *data, u32 offset, u32 value)
>  }
>  
>  static const struct clk_bulk_data imx_cdns3_core_clks[] = {
> -	{ .id = "usb3_lpm_clk" },
> -	{ .id = "usb3_bus_clk" },
> -	{ .id = "usb3_aclk" },
> -	{ .id = "usb3_ipg_clk" },
> -	{ .id = "usb3_core_pclk" },
> +	{ .id = "lpm" },
> +	{ .id = "bus" },
> +	{ .id = "aclk" },
> +	{ .id = "ipg" },
> +	{ .id = "core" },
>  };
>  
>  static int cdns_imx_noncore_init(struct cdns_imx *data)
> -- 
> 2.34.1
> 

-- 

Thanks,
Peter Chen
