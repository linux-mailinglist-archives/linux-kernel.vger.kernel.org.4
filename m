Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8BF565D109
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 11:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234749AbjADK5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 05:57:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239137AbjADK4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 05:56:53 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B629937386
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 02:55:38 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id qk9so81437330ejc.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 02:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KYzNoKOy+4Ii/LBgF/mqJWtZMgLq9NsSywUWEWmmIBU=;
        b=edVmHyF7sb/2wuzsN3dhIkbzzgEA7XkjqiNTyvjd5yf+K0cH1RAMXPTC0INzE+prR5
         HWytGWkKI1lHWok7rPx/qHYvm/+mOhPaneyN1SkvHfaeMpK2VfaH3GHLWBCU0/QgGN/n
         fypz7aZGG3DyGltQC0KyYnVtaYvPf8nTGWQuPrMluxYhu5AHAzbCRlc7ZHrv/F7P4ZP9
         DQUdksqsdmc8hb+GztiI7cQyg6YlzM0Jl90XAxav2BQZYY21ANq3vpzBOnLagcLYqprB
         1rF5HlbuCk8nmjImqDsE5wS33sh8ZHRI+ohYaI6FYY4pMgbwqz/D9EMAAHUTP20BCtwE
         ek5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KYzNoKOy+4Ii/LBgF/mqJWtZMgLq9NsSywUWEWmmIBU=;
        b=IMprXMKaSfwynU3st/6sBCiWu7/If3Z9HBz0yke+9C1SXPxIMjPrtlHfFpGTTxVxRF
         5ls3r0iIMqvCjFGmyXWLswhui+0LuNqTglGNlwiR5CyjaXw7PUsNC1m3VPxomgaTpTgK
         7N3EjZ0Sj9j5IkGszOFfTaDZ1hlLIgsnjGU+39YaJBsQwY7lbylLlP8DP47RceFalkM2
         ulhuhi4VLq0Rfia5GlTrYl9Rb8RGdPSoOtYm0e9p5vzPQrIr3vcwuQhexnrUPw7WjunS
         90HaLbTuddQGB1B7xzwIc0iDv2ifTQbQhH487cjztSavNWD7qGfSTe8D8zSDTLFVKslW
         WDSw==
X-Gm-Message-State: AFqh2kpZmhz7EfFHu4BnwN7utGKMPAsPUazdkGXW/tQy9hkVpyZyN9fk
        m6HUCgmk2lxHIFwArdoHHYVgzA==
X-Google-Smtp-Source: AMrXdXtQXDvrP8Mm03QChyYcDDMYRpcDK1+orbzA94rpqde8WE46kHwaMtlBv9hBg6y++hjtgUpmAQ==
X-Received: by 2002:a17:906:240f:b0:78d:f454:386d with SMTP id z15-20020a170906240f00b0078df454386dmr42633339eja.42.1672829737263;
        Wed, 04 Jan 2023 02:55:37 -0800 (PST)
Received: from blmsp ([2001:4091:a245:805c:8713:84e4:2a9e:cbe8])
        by smtp.gmail.com with ESMTPSA id mj26-20020a170906af9a00b0073d71792c8dsm15153714ejb.180.2023.01.04.02.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 02:55:36 -0800 (PST)
Date:   Wed, 4 Jan 2023 11:55:35 +0100
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, matthias.bgg@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        wenst@chromium.org, johnson.wang@mediatek.com,
        miles.chen@mediatek.com, fparent@baylibre.com,
        chun-jie.chen@mediatek.com, sam.shih@mediatek.com,
        y.oudjana@protonmail.com, nfraprado@collabora.com,
        rex-bc.chen@mediatek.com, ryder.lee@kernel.org,
        daniel@makrotopia.org, jose.exposito89@gmail.com,
        yangyingliang@huawei.com, pablo.sun@mediatek.com,
        weiyi.lu@mediatek.com, ikjn@chromium.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v2 01/23] clk: mediatek: mt8192: Correctly unregister and
 free clocks on failure
Message-ID: <20230104105535.j7zasooq5u2xgng6@blmsp>
References: <20221223094259.87373-1-angelogioacchino.delregno@collabora.com>
 <20221223094259.87373-2-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221223094259.87373-2-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Angelo,

On Fri, Dec 23, 2022 at 10:42:37AM +0100, AngeloGioacchino Del Regno wrote:
> If anything fails during probe of the clock controller(s), unregister
> (and kfree!) whatever we have previously registered to leave with a
> clean state and prevent leaks.
> 
> Fixes: 710573dee31b ("clk: mediatek: Add MT8192 basic clocks support")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/clk/mediatek/clk-mt8192.c | 72 ++++++++++++++++++++++++-------
>  1 file changed, 56 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/clk/mediatek/clk-mt8192.c b/drivers/clk/mediatek/clk-mt8192.c
> index 0e88588b2c49..eff66ca6c6a7 100644
> --- a/drivers/clk/mediatek/clk-mt8192.c
> +++ b/drivers/clk/mediatek/clk-mt8192.c
> @@ -1100,27 +1100,61 @@ static int clk_mt8192_top_probe(struct platform_device *pdev)
>  	if (IS_ERR(base))
>  		return PTR_ERR(base);
>  
> -	mtk_clk_register_fixed_clks(top_fixed_clks, ARRAY_SIZE(top_fixed_clks), top_clk_data);
> -	mtk_clk_register_factors(top_early_divs, ARRAY_SIZE(top_early_divs), top_clk_data);
> -	mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), top_clk_data);
> -	mtk_clk_register_muxes(top_mtk_muxes, ARRAY_SIZE(top_mtk_muxes), node, &mt8192_clk_lock,
> -			       top_clk_data);
> -	mtk_clk_register_composites(top_muxes, ARRAY_SIZE(top_muxes), base, &mt8192_clk_lock,
> -				    top_clk_data);
> -	mtk_clk_register_composites(top_adj_divs, ARRAY_SIZE(top_adj_divs), base, &mt8192_clk_lock,
> -				    top_clk_data);
> -	r = mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks), top_clk_data);
> +	r = mtk_clk_register_fixed_clks(top_fixed_clks, ARRAY_SIZE(top_fixed_clks), top_clk_data);
>  	if (r)
>  		return r;
>  
> +	r = mtk_clk_register_factors(top_early_divs, ARRAY_SIZE(top_early_divs), top_clk_data);
> +	if (r)
> +		goto unregister_fixed_clks;
> +
> +	r = mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), top_clk_data);
> +	if (r)
> +		goto unregister_early_factors;
> +
> +	r = mtk_clk_register_muxes(top_mtk_muxes, ARRAY_SIZE(top_mtk_muxes), node,
> +				   &mt8192_clk_lock, top_clk_data);
> +	if (r)
> +		goto unregister_factors;
> +
> +	r = mtk_clk_register_composites(top_muxes, ARRAY_SIZE(top_muxes), base,
> +					&mt8192_clk_lock, top_clk_data);
> +	if (r)
> +		goto unregister_muxes;
> +
> +	r = mtk_clk_register_composites(top_adj_divs, ARRAY_SIZE(top_adj_divs), base,
> +					&mt8192_clk_lock, top_clk_data);
> +	if (r)
> +		goto unregister_top_composites;
> +
> +	r = mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks), top_clk_data);
> +	if (r)
> +		goto unregister_adj_divs_composites;
> +
>  	r = clk_mt8192_reg_mfg_mux_notifier(&pdev->dev,
>  					    top_clk_data->hws[CLK_TOP_MFG_PLL_SEL]->clk);
>  	if (r)
> -		return r;
> -
> +		goto unregister_gates;
>  
>  	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get,
>  				      top_clk_data);

I think you may have missed this one. If of_clk_add_hw_provider fails
you should unregister all of the above, right?

Otherwise:
Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>

> +
> +unregister_gates:
> +	mtk_clk_unregister_gates(top_clks, ARRAY_SIZE(top_clks), top_clk_data);
> +unregister_adj_divs_composites:
> +	mtk_clk_unregister_composites(top_adj_divs, ARRAY_SIZE(top_adj_divs), top_clk_data);
> +unregister_top_composites:
> +	mtk_clk_unregister_composites(top_muxes, ARRAY_SIZE(top_muxes), top_clk_data);
> +unregister_muxes:
> +	mtk_clk_unregister_muxes(top_mtk_muxes, ARRAY_SIZE(top_mtk_muxes), top_clk_data);
> +unregister_factors:
> +	mtk_clk_unregister_factors(top_divs, ARRAY_SIZE(top_divs), top_clk_data);
> +unregister_early_factors:
> +	mtk_clk_unregister_factors(top_early_divs, ARRAY_SIZE(top_early_divs), top_clk_data);
> +unregister_fixed_clks:
> +	mtk_clk_unregister_fixed_clks(top_fixed_clks, ARRAY_SIZE(top_fixed_clks),
> +				      top_clk_data);
> +	return r;
>  }
>  
>  static int clk_mt8192_infra_probe(struct platform_device *pdev)
> @@ -1139,14 +1173,16 @@ static int clk_mt8192_infra_probe(struct platform_device *pdev)
>  
>  	r = mtk_register_reset_controller_with_dev(&pdev->dev, &clk_rst_desc);
>  	if (r)
> -		goto free_clk_data;
> +		goto unregister_gates;
>  
>  	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
>  	if (r)
> -		goto free_clk_data;
> +		goto unregister_gates;
>  
>  	return r;
>  
> +unregister_gates:
> +	mtk_clk_unregister_gates(infra_clks, ARRAY_SIZE(infra_clks), clk_data);
>  free_clk_data:
>  	mtk_free_clk_data(clk_data);
>  	return r;
> @@ -1168,10 +1204,12 @@ static int clk_mt8192_peri_probe(struct platform_device *pdev)
>  
>  	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
>  	if (r)
> -		goto free_clk_data;
> +		goto unregister_gates;
>  
>  	return r;
>  
> +unregister_gates:
> +	mtk_clk_unregister_gates(peri_clks, ARRAY_SIZE(peri_clks), clk_data);
>  free_clk_data:
>  	mtk_free_clk_data(clk_data);
>  	return r;
> @@ -1194,10 +1232,12 @@ static int clk_mt8192_apmixed_probe(struct platform_device *pdev)
>  
>  	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
>  	if (r)
> -		goto free_clk_data;
> +		goto unregister_gates;
>  
>  	return r;
>  
> +unregister_gates:
> +	mtk_clk_unregister_gates(apmixed_clks, ARRAY_SIZE(apmixed_clks), clk_data);
>  free_clk_data:
>  	mtk_free_clk_data(clk_data);
>  	return r;
> -- 
> 2.39.0
> 
