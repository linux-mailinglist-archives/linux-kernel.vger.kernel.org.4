Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471C560565D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 06:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiJTEgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 00:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiJTEgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 00:36:22 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19AB16086F
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 21:36:20 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id h14so2172870pjv.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 21:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=o17RQhlYUBZsMUmpb8StxU8A9Z3KXwBN0N+ZYEngB1E=;
        b=VtPEHdzhQMEWZw3owOIfjqIu3ZJVH0Wzl/cMEq++H/LvWPcPqd3qbMf1ACg8pFU0tM
         /PJH1dDYxvocWs01HDEzzdsES93RJEa6FiXbRbX6/lHhoZiWrQRx1TLkPgOJnCvVZMPI
         G9XADsRhdhLo7T228yY7PXtoXi7VEWJayJncCQ0r7YuARykYmWK/uPHizwuRYusubjnr
         i/yP6fQtmIwa4Vs6mLxh11CgN2vmXNouV8vq5shWcixAhLiMMsjyCGAYtvGa6LLlY8cr
         WCLyxAXusmezvVr6Nt6lsRhAra18fVI57dFv6RNB0uuxlAQRR14BPtgu91/nM0Oiw8pF
         Fxvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o17RQhlYUBZsMUmpb8StxU8A9Z3KXwBN0N+ZYEngB1E=;
        b=SxLh2vJLte4sJ7n+FcKb0HvFP90qCZ3wuRMZGuzReb3pkMyyJ+IajRq8Q+boi3dJN6
         D8oyEM0XWZcOl59JWPpcq1OLCZJAMhoROYNIAwtEfaWn4sQuoa3lB8Ncc58wi+fSofB5
         NNK4/RL2sAzuD88AFs5GPFZxGj2k3S0Qy2aUXlEYFZD6JjXQEOdTKpUMS3L/EqkRSoGr
         WKybJZpuHD8EBVYeGz93QO4FjIcZy9n8UFriRC7Ey/Z7fs0epH6JH7vs5/nTLrkHTwLX
         3aHBOwzLop7O35Q8mFW3eOjDJmdpN+DUFXvf0ruSwievUM35Zv8FT1MnH3BsVDprW1+a
         AS1w==
X-Gm-Message-State: ACrzQf0AsLUXhYo1iNo0ctfNiLn6Z5gma8ssvfhnYrxIvQJcV7tfCPw7
        d4Xl8h5/4RmOasPWiXBXkRa8SQ==
X-Google-Smtp-Source: AMsMyM6JMa9WLiFbvoVx4vYwYCZzPiim1UptyMJUVWSD81py6SUfnrjSxJDxjmTh1qKJOoEy59NARg==
X-Received: by 2002:a17:90b:691:b0:20d:6171:c94 with SMTP id m17-20020a17090b069100b0020d61710c94mr47924799pjz.25.1666240580413;
        Wed, 19 Oct 2022 21:36:20 -0700 (PDT)
Received: from localhost ([122.172.86.128])
        by smtp.gmail.com with ESMTPSA id a29-20020aa795bd000000b0056234327070sm12602800pfk.95.2022.10.19.21.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 21:36:10 -0700 (PDT)
Date:   Thu, 20 Oct 2022 10:06:05 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     =?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 4/6] clk: spear: Fix CLCD clock definition on SPEAr600
Message-ID: <20221020043605.hyytaxyth2j5xnag@vireshk-i7>
References: <20221019133208.319626-1-kory.maincent@bootlin.com>
 <20221019133208.319626-5-kory.maincent@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221019133208.319626-5-kory.maincent@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-10-22, 15:32, Köry Maincent wrote:
> From: Kory Maincent <kory.maincent@bootlin.com>
> 
> There is no SPEAr600 device named "clcd". Instead, the description of the
> CLCD (color liquid crystal display controller) name is "fc200000.clcd", so
> we should associate the CLCD gateable clock to this device name.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
>  drivers/clk/spear/spear6xx_clock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/spear/spear6xx_clock.c b/drivers/clk/spear/spear6xx_clock.c
> index c192a9141b86..ee0ed89f2954 100644
> --- a/drivers/clk/spear/spear6xx_clock.c
> +++ b/drivers/clk/spear/spear6xx_clock.c
> @@ -207,7 +207,7 @@ void __init spear6xx_clk_init(void __iomem *misc_base)
>  
>  	clk = clk_register_gate(NULL, "clcd_clk", "clcd_mclk", 0,
>  			PERIP1_CLK_ENB, CLCD_CLK_ENB, 0, &_lock);
> -	clk_register_clkdev(clk, NULL, "clcd");
> +	clk_register_clkdev(clk, NULL, "fc200000.clcd");
>  
>  	/* gpt clocks */
>  	clk = clk_register_gpt("gpt0_1_syn_clk", "pll1_clk", 0, PRSC0_CLK_CFG,

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
