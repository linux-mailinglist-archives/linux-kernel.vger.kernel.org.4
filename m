Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B32A64C5B1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 10:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237697AbiLNJSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 04:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237767AbiLNJR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 04:17:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF231DF24
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 01:17:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 888CA61806
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 09:17:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D799C433D2;
        Wed, 14 Dec 2022 09:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671009469;
        bh=LhfxboEowfTBAIAnIsZQ33ABn//iM5+t2VumPb1Kwzs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=sGE11KMznVEngn0T0Y4SA29AZSuAx2qm08w/V7uwRA8HUaft6kOQ/Kuh8TLXwIe5T
         VyI3Kv2OZO0qG/hyTcxT18h1iBrMCIf8lwOjgKFy7AGFGnbTcv+CDkSXb2/bEjEAto
         HQUrzdlDy4TPZLrs9zRWE4JCPGtmCEl3Ez/sOE6fZpKeySQ5zWbkcPUvWYy+Z3dpnM
         ozVNWAgSbW6cr9APL5zRsDG9Ocw0HdEYDsUj4u5+AN+bJ6f2EXlRdhn2wvZVmqze8e
         A6ngVOMzMID0Cr+xu9pxCxeofes2IUKksrUzKUtw/NxBjz0ezA2avLF3SUGUBbm13I
         0quiyfifGgwZA==
Message-ID: <47c159b6-a1d3-dd7f-265e-6acbfc06ead0@kernel.org>
Date:   Wed, 14 Dec 2022 11:17:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/2] phy: ti: j721e-wiz: Add support to enable LN23 Type-C
 swap
Content-Language: en-US
To:     Sinthu Raja <sinthu.raja@mistralsolutions.com>,
        Vinod Koul <vkoul@kernel.org>,
        Ravi Gunasekaran <r-gunasekaran@ti.com>,
        Siddharth Vadapalli <s-vadapalli@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sinthu Raja <sinthu.raja@ti.com>
References: <20221213124854.3779-1-sinthu.raja@ti.com>
 <20221213124854.3779-3-sinthu.raja@ti.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20221213124854.3779-3-sinthu.raja@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/12/2022 14:48, Sinthu Raja wrote:
> Serdes wiz supports both LN23 and LN10 Type-C swap. Add support to

SerDes?

what is wiz?

It has nothing to do with Type-C. It is just a lane swap.
There may or may not be a Type-C port.

> configure LN23 bit to swap between lane2 or lane3 if required.

What do you mean by "swap between lane2 or lane3"?

Do you mean "swap lanes 2 and 3"?

Is LN23 bit supported on all variants?

> 
> Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
> ---
>  drivers/phy/ti/phy-j721e-wiz.c | 33 +++++++++++++++++++++++++++++----
>  1 file changed, 29 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
> index b17eec632d49..0091892af0b0 100644
> --- a/drivers/phy/ti/phy-j721e-wiz.c
> +++ b/drivers/phy/ti/phy-j721e-wiz.c
> @@ -58,6 +58,11 @@ enum wiz_lane_standard_mode {
>  	LANE_MODE_GEN4,
>  };
>  
> +enum wiz_lane_typec_swap_mode {
> +	LANE10_SWAP = 0,
> +	LANE23_SWAP = 2,
> +};

What is this? Is it a register setting?

> +
>  enum wiz_refclk_mux_sel {
>  	PLL0_REFCLK,
>  	PLL1_REFCLK,
> @@ -194,6 +199,9 @@ static const struct reg_field p_mac_div_sel1[WIZ_MAX_LANES] = {
>  static const struct reg_field typec_ln10_swap =
>  					REG_FIELD(WIZ_SERDES_TYPEC, 30, 30);
>  
> +static const struct reg_field typec_ln23_swap =
> +					REG_FIELD(WIZ_SERDES_TYPEC, 31, 31);
> +
>  struct wiz_clk_mux {
>  	struct clk_hw		hw;
>  	struct regmap_field	*field;
> @@ -366,6 +374,7 @@ struct wiz {
>  	struct regmap_field	*mux_sel_field[WIZ_MUX_NUM_CLOCKS];
>  	struct regmap_field	*div_sel_field[WIZ_DIV_NUM_CLOCKS_16G];
>  	struct regmap_field	*typec_ln10_swap;
> +	struct regmap_field	*typec_ln23_swap;
>  	struct regmap_field	*sup_legacy_clk_override;
>  
>  	struct device		*dev;
> @@ -675,6 +684,13 @@ static int wiz_regfield_init(struct wiz *wiz)
>  		return PTR_ERR(wiz->typec_ln10_swap);
>  	}
>  
> +	wiz->typec_ln23_swap = devm_regmap_field_alloc(dev, regmap,
> +						       typec_ln23_swap);
> +	if (IS_ERR(wiz->typec_ln23_swap)) {
> +		dev_err(dev, "LN23_SWAP reg field init failed\n");
> +		return PTR_ERR(wiz->typec_ln23_swap);
> +	}
> +
>  	wiz->phy_en_refclk = devm_regmap_field_alloc(dev, regmap, phy_en_refclk);
>  	if (IS_ERR(wiz->phy_en_refclk)) {
>  		dev_err(dev, "PHY_EN_REFCLK reg field init failed\n");
> @@ -1242,15 +1258,24 @@ static int wiz_phy_reset_deassert(struct reset_controller_dev *rcdev,
>  				regmap_field_write(wiz->typec_ln10_swap, 0);
>  		} else {
>  			/* if no typec-dir gpio was specified, and USB lines
> -			 * are connected to Lane 0 then set LN10 SWAP bit to 1.
> +			 * are connected to SWAP lanes '0' or '2' then set LN10 SWAP
> +			 * or LN23 bit to 1 respectively.
>  			 */
>  			u32 num_lanes = wiz->num_lanes;
>  			int i;
>  
>  			for (i = 0; i < num_lanes; i++) {
> -				if ((wiz->lane_phy_type[i] == PHY_TYPE_USB3) \
> -						&& wiz->lane_phy_reg[i] == 0) {
> -					regmap_field_write(wiz->typec_ln10_swap, 1);
> +				if (wiz->lane_phy_type[i] == PHY_TYPE_USB3) {
> +					switch (wiz->lane_phy_reg[i]) {
> +					case LANE10_SWAP:
> +						regmap_field_write(wiz->typec_ln10_swap, 1);
> +						break;
> +					case LANE23_SWAP:
> +						regmap_field_write(wiz->typec_ln23_swap, 1);
> +						break;
> +					default:
> +						break;
> +					}

Could you please explain what is going on here?
What is the basis for deciding if LN10 or LN23 bit must be set or not?

What about clearing those bits?

>  				}
>  			}
>  		}

cheers,
-roger
