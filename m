Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D336D5FE2CA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 21:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiJMTg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 15:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiJMTgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 15:36:21 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9112417C564;
        Thu, 13 Oct 2022 12:36:19 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id f193so2455083pgc.0;
        Thu, 13 Oct 2022 12:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9zEp8WwVcb7daZG+SSD+C887fYzwYL9krvYTpGgFmms=;
        b=gEu0spplDzZ/2nsJojKXpG+pCBMVN0/ZUPWwFsYdV+afFOkrOAUoOVZ9w6zB+sXmPs
         laq223fc8S4ZmpOX7YweHLCgWdTuZm3mVBj37wqqBimUiO9GfW3k9j5tBhcul/LEbmO6
         qzDrxZAEvyeBizRSSyBgnfnxb8eXqvzPb9bFwZno5TLn0DmjSBY3vk6lZVtTLf0XxE8S
         qCjEzifGMoPi0ov6GwtVlPsGLof8Q8kTM2bC5wd7x1VJxHmGPlqpyqYFCT+fPoGKPkFe
         Zfs3vdHZEzBIKDc117QTyfnhO+/SSh08WmFQtkhpvvQOxsVpUtnXTkmaTkQVx3Nc6Yj2
         yUlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9zEp8WwVcb7daZG+SSD+C887fYzwYL9krvYTpGgFmms=;
        b=TpkoUIymxWQt9vvPRyfe0ETKIn2Ta37QW6cLL+3Vu5DHvkKqrM7mvGg0aHoq43kLG8
         vfJ0lzBRn/uyYhjbac59bAwWwtClW8AJprETFzhnL8lZ7iDqLaVWeW5cj/5t3ALw6aq9
         EwOh5gG67JCWJVLC/O67GTAyEQzq5pbvJ2McElcUCWs7ID57t56DZw6ucUwYCAjRW1Bu
         fm01T3smPSc0Pvko5nHQvzXaz5zWcg6sXvBU9pM53g3an5w74TiJydHbS0pFm17FzSOK
         1J8q7i/1F+XmNQigb9wcbXd5ivxzP0BytsO9EcNSWy2DuRWFGoz63mkco2avMcVbER19
         iSgQ==
X-Gm-Message-State: ACrzQf0JO6S/Kb6zSfsdbqr08/K5/GOkwfBtvhvfA2gZPqcoFGCG6iG+
        IwTMwfT+e79u/6K0zf8eG3I=
X-Google-Smtp-Source: AMsMyM42xNNOoa0aywh+nto1bQ8rkdSsbrgXj2FYIcADmDX+K8BEkO+SwD6jigr6y0b7vFWtcy2CvA==
X-Received: by 2002:a63:8bc9:0:b0:45f:afa8:e686 with SMTP id j192-20020a638bc9000000b0045fafa8e686mr1267288pge.219.1665689778314;
        Thu, 13 Oct 2022 12:36:18 -0700 (PDT)
Received: from [172.30.1.63] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id x32-20020a634a20000000b00456891e1dacsm80787pga.68.2022.10.13.12.36.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Oct 2022 12:36:17 -0700 (PDT)
Message-ID: <ab67f2aa-64c2-8b58-20b4-ee797c9e0a19@gmail.com>
Date:   Fri, 14 Oct 2022 04:36:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RESEND PATCH] clk: samsung: exynos7885: Correct "div4" clock
 parents
Content-Language: en-US
To:     David Virag <virag.david003@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221013151341.151208-1-virag.david003@gmail.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20221013151341.151208-1-virag.david003@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22. 10. 14. 00:13, David Virag wrote:
> "div4" DIVs which divide PLLs by 4 are actually dividing "div2" DIVs by
> 2 to achieve a by 4 division, thus their parents are the respective
> "div2" DIVs. These DIVs were mistakenly set to have the PLLs as parents.
> This leads to the kernel thinking "div4"s and everything under them run
> at 2x the clock speed. Fix this.
> 
> Fixes: 45bd8166a1d8 ("clk: samsung: Add initial Exynos7885 clock driver")
> Signed-off-by: David Virag <virag.david003@gmail.com>
> ---
>  drivers/clk/samsung/clk-exynos7885.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/samsung/clk-exynos7885.c b/drivers/clk/samsung/clk-exynos7885.c
> index a7b106302706..368c50badd15 100644
> --- a/drivers/clk/samsung/clk-exynos7885.c
> +++ b/drivers/clk/samsung/clk-exynos7885.c
> @@ -182,7 +182,7 @@ static const struct samsung_div_clock top_div_clks[] __initconst = {
>  	    CLK_CON_DIV_PLL_SHARED0_DIV2, 0, 1),
>  	DIV(CLK_DOUT_SHARED0_DIV3, "dout_shared0_div3", "fout_shared0_pll",
>  	    CLK_CON_DIV_PLL_SHARED0_DIV3, 0, 2),
> -	DIV(CLK_DOUT_SHARED0_DIV4, "dout_shared0_div4", "fout_shared0_pll",
> +	DIV(CLK_DOUT_SHARED0_DIV4, "dout_shared0_div4", "dout_shared0_div2",
>  	    CLK_CON_DIV_PLL_SHARED0_DIV4, 0, 1),
>  	DIV(CLK_DOUT_SHARED0_DIV5, "dout_shared0_div5", "fout_shared0_pll",
>  	    CLK_CON_DIV_PLL_SHARED0_DIV5, 0, 3),
> @@ -190,7 +190,7 @@ static const struct samsung_div_clock top_div_clks[] __initconst = {
>  	    CLK_CON_DIV_PLL_SHARED1_DIV2, 0, 1),
>  	DIV(CLK_DOUT_SHARED1_DIV3, "dout_shared1_div3", "fout_shared1_pll",
>  	    CLK_CON_DIV_PLL_SHARED1_DIV3, 0, 2),
> -	DIV(CLK_DOUT_SHARED1_DIV4, "dout_shared1_div4", "fout_shared1_pll",
> +	DIV(CLK_DOUT_SHARED1_DIV4, "dout_shared1_div4", "dout_shared1_div2",
>  	    CLK_CON_DIV_PLL_SHARED1_DIV4, 0, 1),
>  
>  	/* CORE */

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

Thanks for fix-up.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
