Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFE270C349
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 18:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbjEVQ1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 12:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232413AbjEVQ1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 12:27:09 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217AF10D
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 09:27:06 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2af1822b710so56975121fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 09:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684772824; x=1687364824;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L49vT0kSR5iSdRQMfUzpP/XyxjpgXdinB+PYS7EXDgc=;
        b=hslmTQFnRshGj8Ynfw9m40NnwzxlzACJFeHB4LYvMAZ2S4Vl6dODIcOfObQNoZmGJI
         v0CEqYyDjgxWI4/G6gpVomEyfpCHdzFaQKuqI0BoKUvEWAzGa7YP0FPkelNSQnW5kuUR
         u/RQlE9uNh/gevB7eAo7o4V4UTP4YCKSbQyzb9mhAv6Nff/swqxFPGOPk6bfaZDXANiX
         0319rEZ5gsRaWJMo/8z8yScQm4CwlDfDwhjmESf4FtLvc3V4K22bmCtlcZxE9E1wamVm
         MfeF0upJz8SK6eijJlDxUMnGUgSm2eH1FTc2bCOVklpq+oczDUrAvPHXlXahHr9KltiY
         ERjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684772824; x=1687364824;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L49vT0kSR5iSdRQMfUzpP/XyxjpgXdinB+PYS7EXDgc=;
        b=jC9E0jEpAD2bWzIhIT3BxcKLPBCkArW1j2Y9ndRa8mgBqVU70YQelgeNY7MfowOcti
         FYcCumCYY/zkyhchpzlHkC6gjp88J7QfkOnE24ZJqR5caH9Zj3a/2YFs7Q74DrrnOdYb
         chGZwI7/1K7RnRlnZrb2VLAK174kaWEbhQoyCylctmi4M1Az4vDACr9GpLpUE/XBJSsC
         DxpR4/6uVekCGbH/PaK5MgcanLWwiOtwGWLD2WXIvlYQtgtfLBFhvSMkGRoR/Yu7ZoPd
         ImYXoaKllpewFf8lMOis4vDIwrYmpN1E9F+44EfjIDlsD2rSMnCe38BU7e1vQy0M6d5m
         ABnw==
X-Gm-Message-State: AC+VfDxUK3HYHT7sWIBPWsJRlTK8RFKyUes7DqAX3yk7f6+ydF8Lcn8E
        TkZCjaENBNmpQfhMstSxhgEje01mXFG/SNOtnow=
X-Google-Smtp-Source: ACHHUZ4hNKvBkWnnwTi1UvbA0enOMv6lEWqh3SrknYDQNxa4Yan8j5JvPkVwFOINBdweiebeMKBCgA==
X-Received: by 2002:a2e:7406:0:b0:2a8:ac69:bfe with SMTP id p6-20020a2e7406000000b002a8ac690bfemr3696560ljc.42.1684772824265;
        Mon, 22 May 2023 09:27:04 -0700 (PDT)
Received: from [192.168.1.101] (abyk97.neoplus.adsl.tpnet.pl. [83.9.30.97])
        by smtp.gmail.com with ESMTPSA id c9-20020a05651c014900b002a8d01905f7sm1168547ljd.101.2023.05.22.09.27.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 09:27:03 -0700 (PDT)
Message-ID: <2e4ad0e8-9fdf-6af8-f591-be27168460ae@linaro.org>
Date:   Mon, 22 May 2023 18:27:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] soc: qcom: rpmpd: use correct __le32 type
To:     Min-Hua Chen <minhuadotchen@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230522160757.284165-1-minhuadotchen@gmail.com>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230522160757.284165-1-minhuadotchen@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22.05.2023 18:07, Min-Hua Chen wrote:
> Use cpu_to_le32 to cast constants to __le32 before comparing
> them with __le32 type pd->key. This fixes the following sparse
> warnings:
> 
> drivers/soc/qcom/rpmpd.c:895:31: sparse: warning: restricted __le32 degrades to integer
> drivers/soc/qcom/rpmpd.c:896:15: sparse: warning: restricted __le32 degrades to integer
> 
> Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
> ---
I wonder if our drivers are capable of booting and working properly
in BE..

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/soc/qcom/rpmpd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
> index f8397dcb146c..99b017fd76b7 100644
> --- a/drivers/soc/qcom/rpmpd.c
> +++ b/drivers/soc/qcom/rpmpd.c
> @@ -892,8 +892,8 @@ static int rpmpd_set_performance(struct generic_pm_domain *domain,
>  	pd->corner = state;
>  
>  	/* Always send updates for vfc and vfl */
> -	if (!pd->enabled && pd->key != KEY_FLOOR_CORNER &&
> -	    pd->key != KEY_FLOOR_LEVEL)
> +	if (!pd->enabled && pd->key != cpu_to_le32(KEY_FLOOR_CORNER) &&
> +	    pd->key != cpu_to_le32(KEY_FLOOR_LEVEL))
>  		goto out;
>  
>  	ret = rpmpd_aggregate_corner(pd);
