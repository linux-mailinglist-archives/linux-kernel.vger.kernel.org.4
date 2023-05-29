Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9690B714C53
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 16:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjE2Osu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 10:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjE2Ost (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 10:48:49 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E04AD
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 07:48:48 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-5343c3daff0so2108073a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 07:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685371727; x=1687963727;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cHmc8ME+OazRZv0u5evpMix4PvtvAeVb+xwAGhQm2XQ=;
        b=jKncQQ1BTnrrDrxS9h0WoEhc5m1VW+Zvmj5P1B1I1gFI/DGY6FnfXFlIyQi4HW0Fz6
         61zHNTG0FO+6TPhJsKiSc3CCMM12tWsbHodhy6c8927ZqXrPHACYQYmozHPxYeM//5ps
         AQtlmvexyKrtsXrLLCx4IaXx23JgXhau9raFsO/1donkcSsuGtSrkcJXMiu3c/EyF07Q
         aguW3sLasdLrPiJdtnjyliCvOF0GVq927tuG3cEZnjHCPd5gGmPQ9JvB7HRB19hFI1H0
         l7UGskHkI/mitD5mHJvDig7AlzJFve1lapX4bi2ZIDjU8oFTFOF/SC0s/2qn74QRuc32
         SN/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685371727; x=1687963727;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cHmc8ME+OazRZv0u5evpMix4PvtvAeVb+xwAGhQm2XQ=;
        b=SuwLTNFpKu37FihPgc75C/EjGvvizwL50HRip8K31BMo44BO7yHWCpMYNNaDfQU7ov
         odt3tNG7Lo5PN9wyBm6X7fwlMDI/cEw71leN8vOmnWmzuZF+OyI+S6UJRuJWfHgatLjU
         JKJg12SZitSWTAmRDWDfisPU3thhJjXfbeBnRgDyzcYKKq1El/4l7j4pXhIuH7Z16bNr
         kiIp5qQuptAMFMLWRUlsWxbQg+7WSVsoCMprDEgf5ugv13/MSLvmEGuJOmvnG3W82pDt
         WPvM294ICThxDPgK8z/oFboF1+fxqJmM13+b0mU4gE8mGiS0H70oXFPihutJvr5H1qfi
         0mXw==
X-Gm-Message-State: AC+VfDw64mVUOx+mQ43ZLFME0sxnEzUD0LwzwJmd/xfRy9jWIZZ1dmaI
        HcXGbi8oGw4v9eys2jwRv/Q=
X-Google-Smtp-Source: ACHHUZ76I7KI+qTLo7Ns+qxdQ9NH2/PV8Pp0on8c9jI26x+jqNrsd4sLFMngSGDex+42GIUbVwjeqA==
X-Received: by 2002:a17:902:cccf:b0:1af:eea0:4f35 with SMTP id z15-20020a170902cccf00b001afeea04f35mr12236600ple.2.1685371727347;
        Mon, 29 May 2023 07:48:47 -0700 (PDT)
Received: from [172.30.1.35] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id n19-20020a170902969300b001a527761c31sm8373820plp.79.2023.05.29.07.48.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 07:48:46 -0700 (PDT)
Message-ID: <34664bea-1d94-735d-8202-36da3c5c6415@gmail.com>
Date:   Mon, 29 May 2023 23:48:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] extcon: Switch i2c drivers back to use .probe()
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
References: <20230525202802.630753-1-u.kleine-koenig@pengutronix.de>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20230525202802.630753-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 5. 26. 05:28, Uwe Kleine-König wrote:
> After commit b8a1a4cd5a98 ("i2c: Provide a temporary .probe_new()
> call-back type"), all drivers being converted to .probe_new() and then
> 03c835f498b5 ("i2c: Switch .probe() to not take an id parameter")
> convert back to (the new) .probe() to be able to eventually drop
> .probe_new() from struct i2c_driver.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/extcon/extcon-fsa9480.c      | 2 +-
>  drivers/extcon/extcon-ptn5150.c      | 2 +-
>  drivers/extcon/extcon-rt8973a.c      | 2 +-
>  drivers/extcon/extcon-sm5502.c       | 2 +-
>  drivers/extcon/extcon-usbc-tusb320.c | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/extcon/extcon-fsa9480.c b/drivers/extcon/extcon-fsa9480.c
> index e8b2671eb29b..e458ce0c45ab 100644
> --- a/drivers/extcon/extcon-fsa9480.c
> +++ b/drivers/extcon/extcon-fsa9480.c
> @@ -369,7 +369,7 @@ static struct i2c_driver fsa9480_i2c_driver = {
>  		.pm		= &fsa9480_pm_ops,
>  		.of_match_table = fsa9480_of_match,
>  	},
> -	.probe_new		= fsa9480_probe,
> +	.probe			= fsa9480_probe,
>  	.id_table		= fsa9480_id,
>  };
>  
> diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
> index 017a07197f38..4616da7e5430 100644
> --- a/drivers/extcon/extcon-ptn5150.c
> +++ b/drivers/extcon/extcon-ptn5150.c
> @@ -348,7 +348,7 @@ static struct i2c_driver ptn5150_i2c_driver = {
>  		.name	= "ptn5150",
>  		.of_match_table = ptn5150_dt_match,
>  	},
> -	.probe_new	= ptn5150_i2c_probe,
> +	.probe		= ptn5150_i2c_probe,
>  	.id_table = ptn5150_i2c_id,
>  };
>  module_i2c_driver(ptn5150_i2c_driver);
> diff --git a/drivers/extcon/extcon-rt8973a.c b/drivers/extcon/extcon-rt8973a.c
> index afc9b405d103..19bb49f13fb0 100644
> --- a/drivers/extcon/extcon-rt8973a.c
> +++ b/drivers/extcon/extcon-rt8973a.c
> @@ -695,7 +695,7 @@ static struct i2c_driver rt8973a_muic_i2c_driver = {
>  		.pm	= &rt8973a_muic_pm_ops,
>  		.of_match_table = rt8973a_dt_match,
>  	},
> -	.probe_new = rt8973a_muic_i2c_probe,
> +	.probe = rt8973a_muic_i2c_probe,
>  	.remove	= rt8973a_muic_i2c_remove,
>  	.id_table = rt8973a_i2c_id,
>  };
> diff --git a/drivers/extcon/extcon-sm5502.c b/drivers/extcon/extcon-sm5502.c
> index 8401e8b27788..c8c4b9ef72aa 100644
> --- a/drivers/extcon/extcon-sm5502.c
> +++ b/drivers/extcon/extcon-sm5502.c
> @@ -840,7 +840,7 @@ static struct i2c_driver sm5502_muic_i2c_driver = {
>  		.pm	= &sm5502_muic_pm_ops,
>  		.of_match_table = sm5502_dt_match,
>  	},
> -	.probe_new = sm5022_muic_i2c_probe,
> +	.probe = sm5022_muic_i2c_probe,
>  	.id_table = sm5502_i2c_id,
>  };
>  
> diff --git a/drivers/extcon/extcon-usbc-tusb320.c b/drivers/extcon/extcon-usbc-tusb320.c
> index b408ce989c22..1251301d2005 100644
> --- a/drivers/extcon/extcon-usbc-tusb320.c
> +++ b/drivers/extcon/extcon-usbc-tusb320.c
> @@ -501,7 +501,7 @@ static const struct of_device_id tusb320_extcon_dt_match[] = {
>  MODULE_DEVICE_TABLE(of, tusb320_extcon_dt_match);
>  
>  static struct i2c_driver tusb320_extcon_driver = {
> -	.probe_new	= tusb320_probe,
> +	.probe		= tusb320_probe,
>  	.driver		= {
>  		.name	= "extcon-tusb320",
>  		.of_match_table = tusb320_extcon_dt_match,
> 
> base-commit: ac9a78681b921877518763ba0e89202254349d1b

When I tried to apply it, there is conflict for extcon-usbc-tusb320.c
extcon-usbc-tusb320.c was already changed to probe_new. 
I'd like you to resend it on latest extcon-next branch. Thanks.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

