Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA799695406
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 23:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjBMWoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 17:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjBMWoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 17:44:22 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170A32057F;
        Mon, 13 Feb 2023 14:44:17 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id co8so10038064wrb.1;
        Mon, 13 Feb 2023 14:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=b5Nie9z/6uzDA7Xv3vo+T2ySPWYh0uKc2BDIxZYHNtY=;
        b=QBJ4Cf3lK8jkkhwi4icD9MExmeSqtKyiYqSwBk6+Ai431i75JhfRSEj0NGVQCse6jA
         D4N73wqy2vdFy8YG9l98ZBWyxaDNFGmRwy0mh40poyKT16tcRAQMVGkNvMASv+khWHKU
         wjge2U6bhKlu1ObVR+mMnDxRIBAII8tPbwwDrQj8A58HR/dJSSHU+wkprmfNCOHhUCzy
         BKGW6+wjqJ9ixpbFs+tgq+Q4sCFmjoC4Zr6ZatblyGjkC2gxjINJXseFIrnGWjyLDiLO
         nIQqCg2fHQvCLKB0dj1eYTfyO/efpn5z0SbTiXlWzTL4Gc6kmNzMx1KJMGIOVukqloXy
         MD6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b5Nie9z/6uzDA7Xv3vo+T2ySPWYh0uKc2BDIxZYHNtY=;
        b=4kJRDZoVlmPmreFDuYVTDVqBoi6Ozay1xyBKeD/IqAsjXEnookjoFKs0R6KhwrBehX
         TnU2ZZsSXLuGuggfte5lCU6Kf+GGrT4SRNrOV9ZO0V9JNd54aIwrsDge3qodar7GW1nF
         SnKIOqCrVWBd398r3uZEoeB67Fq1G96XfRE6RufRnW35bDpnb3I+4K72WFie0Xyut3l0
         kCdxo/FaIBlCSvkHPxet8+1k7Cy8blzMaA9K8PffAD/fWVl9vQ3V4BjTnLdQSZ1hMXsL
         bL1ePJmLhZynLYuDls8XueX2/56B+wahl1p5ZLMItljC2y61kPPxmdvkxHh322Y1gLda
         +YNw==
X-Gm-Message-State: AO0yUKWaL3FCdDSM909i234YMNs8H39qIxbJtEsFIrmfW3GB7mhGfj9K
        WmGo7JOpx65NfR3yDOhN3aLeS/A0oHQ=
X-Google-Smtp-Source: AK7set+pv3rKKfFH25IFKSJ9TbE7DVZ2pwi0iGEWNOoTi19utgiGe+bj151JjjUAS0z2FTvLxN1uoQ==
X-Received: by 2002:a5d:678a:0:b0:2c4:71e:5565 with SMTP id v10-20020a5d678a000000b002c4071e5565mr237454wru.54.1676328255302;
        Mon, 13 Feb 2023 14:44:15 -0800 (PST)
Received: from Ansuel-xps. (93-34-91-73.ip49.fastwebnet.it. [93.34.91.73])
        by smtp.gmail.com with ESMTPSA id v14-20020adfe28e000000b0027cb20605e3sm11421347wri.105.2023.02.13.14.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 14:44:14 -0800 (PST)
Message-ID: <63eabd3e.df0a0220.f8fb1.b4f3@mx.google.com>
X-Google-Original-Message-ID: <Y+is2WLR7yZetbxV@Ansuel-xps.>
Date:   Sun, 12 Feb 2023 10:09:45 +0100
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] clk: qcom: clk-hfpll: switch to .determine_rate
References: <20230212-clk-qcom-determine_rate-v1-0-b4e447d4926e@z3ntu.xyz>
 <20230212-clk-qcom-determine_rate-v1-2-b4e447d4926e@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230212-clk-qcom-determine_rate-v1-2-b4e447d4926e@z3ntu.xyz>
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 12, 2023 at 03:11:09PM +0100, Luca Weiss wrote:
> .determine_rate is meant to replace .round_rate. The former comes with a
> benefit which is especially relevant on 32-bit systems: since
> .determine_rate uses an "unsigned long" (compared to a "signed long"
> which is used by .round_rate) the maximum value on 32-bit systems
> increases from 2^31 (or approx. 2.14GHz) to 2^32 (or approx. 4.29GHz).
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>

Tested-by: Christian Marangi <ansuelsmth@gmail.com>

> ---
>  drivers/clk/qcom/clk-hfpll.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/clk/qcom/clk-hfpll.c b/drivers/clk/qcom/clk-hfpll.c
> index 7dd17c184b69..86f728dc69e5 100644
> --- a/drivers/clk/qcom/clk-hfpll.c
> +++ b/drivers/clk/qcom/clk-hfpll.c
> @@ -128,20 +128,20 @@ static void clk_hfpll_disable(struct clk_hw *hw)
>  	spin_unlock_irqrestore(&h->lock, flags);
>  }
>  
> -static long clk_hfpll_round_rate(struct clk_hw *hw, unsigned long rate,
> -				 unsigned long *parent_rate)
> +static int clk_hfpll_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
>  {
>  	struct clk_hfpll *h = to_clk_hfpll(hw);
>  	struct hfpll_data const *hd = h->d;
>  	unsigned long rrate;
>  
> -	rate = clamp(rate, hd->min_rate, hd->max_rate);
> +	req->rate = clamp(req->rate, hd->min_rate, hd->max_rate);
>  
> -	rrate = DIV_ROUND_UP(rate, *parent_rate) * *parent_rate;
> +	rrate = DIV_ROUND_UP(req->rate, req->best_parent_rate) * req->best_parent_rate;
>  	if (rrate > hd->max_rate)
> -		rrate -= *parent_rate;
> +		rrate -= req->best_parent_rate;
>  
> -	return rrate;
> +	req->rate = rrate;
> +	return 0;
>  }
>  
>  /*
> @@ -241,7 +241,7 @@ const struct clk_ops clk_ops_hfpll = {
>  	.enable = clk_hfpll_enable,
>  	.disable = clk_hfpll_disable,
>  	.is_enabled = hfpll_is_enabled,
> -	.round_rate = clk_hfpll_round_rate,
> +	.determine_rate = clk_hfpll_determine_rate,
>  	.set_rate = clk_hfpll_set_rate,
>  	.recalc_rate = clk_hfpll_recalc_rate,
>  	.init = clk_hfpll_init,
> 
> -- 
> 2.39.1
> 

-- 
	Ansuel
