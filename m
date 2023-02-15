Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFCB697BAA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 13:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233403AbjBOMYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 07:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjBOMYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 07:24:20 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D95C34F6C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 04:24:19 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id f47-20020a05600c492f00b003dc584a7b7eso1421221wmp.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 04:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7YwajgLw5rpCnjJ1GWX04nnYlZlCptWHJUsJ8npJmLw=;
        b=EMjtc5RoiZo7/FdVE1g8hyZrIFQZ6Pti6NqqN3Afza5mwQrjdmUMhW7oJtZF1QmELz
         oAl8uB6JoRkG1XzRtPHSc6Im8vh/q9bRWUcS5LR24+HJDTVN287VuyriNrJ/vM2PKfsK
         wg/hmVdfamOQhb1OjDckMPXoioKdrbGTVxbsWUy3JeYCkMsfvrubkomN/kfmV03/65TX
         36uEjBo9DX1pxqE8vjyThVrCuGLeJFFZ2A4x8v2VZdoI6GMe5JtKGBM4+YST8cio5Mb2
         1d/0KtmvkhvY76BSL0CBhb7vPg38pwtaIhbuIS8xv5IbuWCeo9zki1CSaERK2oDnz+Xs
         j54w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7YwajgLw5rpCnjJ1GWX04nnYlZlCptWHJUsJ8npJmLw=;
        b=VvnvWcVELoOCYc/ayhwNLTwUcAruDTPcqKXOS5S5M6nVT+PDAmKrp22UfR+pv9QMfT
         T+3s6fOZ5Gmlfhj7UqWQ90LLJRdC3BpkMyBnoOAdg0TTxZXyk+ZGtKC6jh8pZxvMu96M
         yiP6tlrI9LVz3S/+xaAQ+Pr+MDMUILDHPJkNp7jU8s7LlA69YHeRMm0FnOXf7EODyrjF
         vsVDbJjDE9vmhFaYhEe8pC4TPD6InwI5UN9YoNG+AmtHvw/qklRrJKCzP5AzWA5a4sdg
         lufGkrFPNjGNElneYldroBznsnRlqKvMSPIkpAltcyzlfkPdFChnOXmlM2elypDHGAga
         s+XQ==
X-Gm-Message-State: AO0yUKXcWymNHCLZpYU6b+baowRjwAmmDJsE5pq8t945xVQJALwyqqgl
        +WFhXuh3WehtL7GtrwtwaHc1Vw==
X-Google-Smtp-Source: AK7set+AhG1msf0SDthK44D5NExgEp0Wr5rtPccuuoGRlUviAuaA3sd3k1qgdVUDkbL5OHclJRzWAg==
X-Received: by 2002:a05:600c:5386:b0:3df:9858:c039 with SMTP id hg6-20020a05600c538600b003df9858c039mr3047558wmb.14.1676463857583;
        Wed, 15 Feb 2023 04:24:17 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id k21-20020a05600c1c9500b003dc492e4430sm2015269wms.28.2023.02.15.04.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 04:24:17 -0800 (PST)
Date:   Wed, 15 Feb 2023 14:24:15 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Kevin Groeneveld <kgroeneveld@lenbrook.com>
Cc:     Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: imx: pll14xx: fix recalc_rate for negative kdiv
Message-ID: <Y+zO7/GBurZwihOJ@linaro.org>
References: <20221210203835.9714-1-kgroeneveld@lenbrook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221210203835.9714-1-kgroeneveld@lenbrook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-12-10 15:38:35, Kevin Groeneveld wrote:
> kdiv is a signed 16 bit value in the DEV_CTL1 register. Commit
> 53990cf9d5b4 ("clk: imx: pll14xx: consolidate rate calculation") changed
> the kdiv variable from a short int to just int. When the value read from
> the DIV_CTL1 register is assigned directly to an int the sign of the value
> is lost resulting in incorrect results when the value is negative. Adding
> a s16 cast to the register value fixes the issue.
> 
> Fixes: 53990cf9d5b4 ("clk: imx: pll14xx: consolidate rate calculation")
> Signed-off-by: Kevin Groeneveld <kgroeneveld@lenbrook.com>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

Stephen, can you pick this up through fixes?
> ---
>  drivers/clk/imx/clk-pll14xx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/imx/clk-pll14xx.c b/drivers/clk/imx/clk-pll14xx.c
> index 1d0f79e9c346..d12194d17b10 100644
> --- a/drivers/clk/imx/clk-pll14xx.c
> +++ b/drivers/clk/imx/clk-pll14xx.c
> @@ -254,7 +254,7 @@ static unsigned long clk_pll14xx_recalc_rate(struct clk_hw *hw,
>  
>  	if (pll->type == PLL_1443X) {
>  		pll_div_ctl1 = readl_relaxed(pll->base + DIV_CTL1);
> -		kdiv = FIELD_GET(KDIV_MASK, pll_div_ctl1);
> +		kdiv = (s16)FIELD_GET(KDIV_MASK, pll_div_ctl1);
>  	} else {
>  		kdiv = 0;
>  	}
> -- 
> 2.17.1
> 
