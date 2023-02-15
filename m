Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F586988DE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 00:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjBOXnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 18:43:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBOXnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 18:43:39 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46F22ED45;
        Wed, 15 Feb 2023 15:43:37 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id m20-20020a05600c3b1400b003e1e754657aso2895441wms.2;
        Wed, 15 Feb 2023 15:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Lcyca8KM+39QRTpE76FUCpFnsYSePDx0T/C4Ew+RwlY=;
        b=hDoF3j9LF4Aqw1xHEdk3Pr3yfElKBh67JP2/YsonJdHz271ZQR1JfDoJeLNH47hk+u
         UOzxtMUujk7G8zhIryr2HYUmm4eKzH7e30oLrJEbzf7GB3xykYYoMhttLNquFTUz3aDm
         ZtvT56QzLYVaYrVD7AhGZbO1WBYtc9fMql0hBj2gbDAlZa3aLTZ7JixLK25YLfGV3mLi
         FrSLRtGl1Lrx65ARZfezgg3gv7GA2+p/pn4t/Ya+kCRA6V+RmKHmTVesvaz0ZPktH2OW
         T+HG05SHix+gL6Gsxq4xtAXIf6uiCKVBbipH+Y0Y3BqKwjLsjel5HcPAgUu2OV5NEf+R
         U5eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lcyca8KM+39QRTpE76FUCpFnsYSePDx0T/C4Ew+RwlY=;
        b=t14T3C4hWUclpwXL4aLCEiToEauXUuY3GCs/0Dqlrujk5jFW/6Y57LqTeXNlqtSD4x
         boaG2qwRXqi1ddslvJc+W8zKRBHh8WGhN/H9ItQxEYsLXG6asqiTFfPtwSvlD3F4svaP
         zbhNH/2/DJnU6w6JfOXPDyj/v99QkD/q/eR66ZPrTQNUu/azXxW+yYhKYZuRiRd9EEn+
         y6CFnpqv/bRgPs2VZbmn0f/xOXkcV0QEbcQjiqzh/2oQog3KN1ZFfpw9BbJVfzNThrKw
         jm9/R3vdljVTkqrT6LCLv/vxlvyj0QwWcfigROMnV6o7O5AGxHTK4QJ8lFPsExEpx9Jp
         +U0w==
X-Gm-Message-State: AO0yUKXP4yzgY4X/lgolpm+ecuTZMofF36Sc1fvrY6G+lMwpDy4b3XkL
        xlLo3ICzJs6wS9XacimqNVoY9UBoEWw=
X-Google-Smtp-Source: AK7set9pOekd3gkQzFc9O4F4XJyzbxbrZpcf1HuaYNYZK/I+rrkmTmJuNhVYY4huFJfLw2UM/SuC+Q==
X-Received: by 2002:a05:600c:181d:b0:3e0:99:b59d with SMTP id n29-20020a05600c181d00b003e00099b59dmr3416150wmp.21.1676504616035;
        Wed, 15 Feb 2023 15:43:36 -0800 (PST)
Received: from Ansuel-xps. (93-34-91-73.ip49.fastwebnet.it. [93.34.91.73])
        by smtp.gmail.com with ESMTPSA id c16-20020a05600c0ad000b003e1f9b633fcsm3436256wmr.16.2023.02.15.15.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 15:43:35 -0800 (PST)
Message-ID: <63ed6e27.050a0220.ed51a.aae8@mx.google.com>
X-Google-Original-Message-ID: <Y+1sG72iwKdDIsPm@Ansuel-xps.>
Date:   Thu, 16 Feb 2023 00:34:51 +0100
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Russell King <linux@armlinux.org.uk>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH] clk: Fix wrong clock returned in parent_data with .name
 and no .index
References: <20230215232712.17072-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230215232712.17072-1-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 12:27:12AM +0100, Christian Marangi wrote:
> Commit 601b6e93304a ("clk: Allow parents to be specified via clkspec index")
> introduced a regression due to a "fragile" implementation present in some very
> corner case.
> 
> Such commit introduced the support for parents to be specified using
> clkspec index. The index is an int and should be -1 if the feature
> should not be used. This is the case with parent_hws or legacy
> parent_names used and the index value is set to -1 by default.
> With parent_data the situation is different, since it's a struct that
> can have multiple value (.index, .name, .fw_name), it's init to all 0 by
> default. This cause the index value to be set to 0 everytime even if not
> intended to be defined and used.
> 
> This simple "fragile" implementation cause side-effect and unintended
> behaviour.
> 
> Assuming the following scenario (to repro the corner case and doesn't
> reflect real code):
> 
> In dt we have a node like this:
> 		acc1: clock-controller@2098000 {
> 			compatible = "qcom,kpss-acc-v1";
> 			reg = <0x02098000 0x1000>, <0x02008000 0x1000>;
> 			clock-output-names = "acpu1_aux";
> 			clocks = <&pxo_board>;
> 			clock-names = "pxo";
> 			#clock-cells = <0>;
> 		};
> 
> And on the relevant driver we have the parent data defined as such:
> 		static const struct clk_parent_data aux_parents[] = {
> 			{ .name = "pll8_vote" },
> 			{ .fw_name = "pxo", .name = "pxo_board" },
> 		};
> 
> Someone would expect the first parent to be globally searched and set to
> point to the clock named "pll8_vote".
> But this is not the case and instead under the hood, the parent point to
> the pxo clock. This happen without any warning and was discovered on
> another platform while the gcc driver was converted to parent_data and
> only .name was defined.
> 
> The reason is hard to discover but very simple.
> 
> Due to the introduction of index support, clk_core_get() won't return
> -ENOENT but insted will correctly return a clock.
> This is because of_parse_clkspec() will use the index (that is set to 0
> due to how things are allocated) and correctly find in the DT node a
> clock at index 0. That in the provided example is exactly the phandle to
> pxo_board.
> 
> Clock is found so the parent is now wrongly linked to the pxo_board
> clock.
> 
> This only happens in this specific scenario but it's still worth to be
> handled and currently there are some driver that hardcode the
> parent_data and may suffer from this.
> 
> To fix this and handle it correctly we can use the following logic:
> 1. With a .fw_name not defined (index searching is skipped if a named
>    clock is provided)
> 2. Check if .name is provided
> 3. Compare the provided .name with what clockspec found
> 4. Return -ENOENT if the name doesn't match, return the clock if it does.
> 
> Returning -ENOENT permit clk core code flow to fallback to global
> searching and correctly search the right clock.
> 
> Fixes: 601b6e93304a ("clk: Allow parents to be specified via clkspec index")
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Jeffrey Hugo <jhugo@codeaurora.org>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Think this should also be backported to stable kernel just like it was
done with 4f8c6aba37da199155a121c6cdc38505a9eb0259 ?

> ---
>  drivers/clk/clk.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 998676d78029..42e297fcfe45 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -395,6 +395,7 @@ of_clk_get_hw_from_clkspec(struct of_phandle_args *clkspec)
>   */
>  static struct clk_core *clk_core_get(struct clk_core *core, u8 p_index)
>  {
> +	const char *global_name = core->parents[p_index].name;
>  	const char *name = core->parents[p_index].fw_name;
>  	int index = core->parents[p_index].index;
>  	struct clk_hw *hw = ERR_PTR(-ENOENT);
> @@ -407,6 +408,23 @@ static struct clk_core *clk_core_get(struct clk_core *core, u8 p_index)
>  	    !of_parse_clkspec(np, index, name, &clkspec)) {
>  		hw = of_clk_get_hw_from_clkspec(&clkspec);
>  		of_node_put(clkspec.np);
> +
> +		/*
> +		 * The returned hw may be incorrect and extra check are required in
> +		 * some corner case.
> +		 *
> +		 * In case a .fw_name is not set of_parse_clkspec will use the index
> +		 * to search the related clock.
> +		 * But index may be never set and actually never intended to be used
> +		 * in the defined parent_data since a 0 value is also accepted and that
> +		 * is what by default each struct is initialized.
> +		 *
> +		 * In the following case check if we have .name and check if the returned
> +		 * clock name match the globally name defined for the parent in the
> +		 * parent_data .name value.
> +		 */
> +		if (!name && global_name && strcmp(global_name, hw->core->name))
> +			return ERR_PTR(-ENOENT);
>  	} else if (name) {
>  		/*
>  		 * If the DT search above couldn't find the provider fallback to
> -- 
> 2.38.1
> 

-- 
	Ansuel
