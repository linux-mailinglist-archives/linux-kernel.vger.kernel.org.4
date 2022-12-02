Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35ABE641173
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 00:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234309AbiLBXXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 18:23:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbiLBXXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 18:23:15 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF67BB007;
        Fri,  2 Dec 2022 15:23:14 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id n3so2008589pfq.10;
        Fri, 02 Dec 2022 15:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aKfchYwXntIzxvzacjQAm257xQlqoADf84p5ijUnCK0=;
        b=TaCN5yg5es/OCGcj/NfRM2JW10uoQVGBXHx4nPm2YvNINoWjPB/7TD4giwLlv1wmiQ
         MrVnyFLL88Au5p3oYp1EJYZR/IVa/Sg+w13ge9FLN42eRLZ8YCEcMn0LYkAgWqmlWXru
         Ys77EdaRACuFl4UD7Zc5QA0sT2gdllTsO02SnM3KKb9q1lGMhzoyg9r39ZhxGEKuFUZL
         3NyIyjVvfssCdHP1hiknRb2HJ7Fhoh0tfD7E1AHVMxpSYIK9SYHU5ukdOWphGRfSlCWk
         I20zRW9PJCZ+zcJRTZWzsfaJicGKJVFa6tGplkl1y6uhCqlPXK6Lg9tshNdCdkQChJ0J
         HC3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aKfchYwXntIzxvzacjQAm257xQlqoADf84p5ijUnCK0=;
        b=U5UyXbBFenA+T5dsU/5Ioin3sWZX3pikwt76bjNa1KE9emZOKy3NWZrXgsZrrn1uTb
         /llXQM440vwf0jQIOtvfyCQjNHjQLJlLM9h1Wi7TU1xG47mkW+2mT1jdLWrDOp2A9gH/
         Q+0sCAKA5We11RS4vPznAludltyga/uOpgcR6nG4NnsUXsmLKahygA2IWQeUj5kRPlD1
         Ns6o/E0N4d44iFaxpwz95Fd9JuFW2qQYgrZY3+lMBlPDQEpDsVaX3pQohA5776n0PwG+
         UFnVhZEXyMQCegronUvUuY+uZZ6iKrBsRemRQVg/8WDP6A9OavCl9DYgkJStjfBmS2xy
         +dsA==
X-Gm-Message-State: ANoB5pmjY9fxI/WtSvZlWwTr/pr/nf/Z+feNpjvhvByzd2+BB/4UGaY0
        c4QiFL4ycjMfAw9w91DFuUU=
X-Google-Smtp-Source: AA0mqf469Y/cLftoGZmaO0lNzpRTefrBSYqmtP4hEkeLeoQt6FlGPNCfB6JCSw1jptFd6fmJSV4lEw==
X-Received: by 2002:a63:2c05:0:b0:477:ceeb:cb9c with SMTP id s5-20020a632c05000000b00477ceebcb9cmr37582557pgs.17.1670023393811;
        Fri, 02 Dec 2022 15:23:13 -0800 (PST)
Received: from [172.30.1.1] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id n9-20020aa79849000000b005769ccca18csm35204pfq.85.2022.12.02.15.23.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 15:23:13 -0800 (PST)
Message-ID: <e13357cb-bc5f-1a66-db54-0fa41e788668@gmail.com>
Date:   Sat, 3 Dec 2022 08:23:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] PM / devfreq: event: use
 devm_platform_get_and_ioremap_resource()
Content-Language: en-US
To:     ye.xingchen@zte.com.cn, cw00.choi@samsung.com
Cc:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        krzysztof.kozlowski@linaro.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        chi.minghao@zte.com.cn
References: <202211220942288196359@zte.com.cn>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <202211220942288196359@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22. 11. 22. 10:42, ye.xingchen@zte.com.cn wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>  drivers/devfreq/event/exynos-nocp.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/devfreq/event/exynos-nocp.c b/drivers/devfreq/event/exynos-nocp.c
> index ccc531ee6938..c1cc23bcb995 100644
> --- a/drivers/devfreq/event/exynos-nocp.c
> +++ b/drivers/devfreq/event/exynos-nocp.c
> @@ -214,8 +214,7 @@ static int exynos_nocp_parse_dt(struct platform_device *pdev,
>  		nocp->clk = NULL;
> 
>  	/* Maps the memory mapped IO to control nocp register */
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	base = devm_ioremap_resource(dev, res);
> +	base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
>  	if (IS_ERR(base))
>  		return PTR_ERR(base);
> 

Applied it. Thanks.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

