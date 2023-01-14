Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60DFD66A82C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 02:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbjANBYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 20:24:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjANBYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 20:24:22 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687C188DEE
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 17:24:20 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id f25-20020a1c6a19000000b003da221fbf48so2172316wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 17:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xU2XxeDGk6YX3FC/ojl/3L4B1JJ6TXtbrbSc+4+VUa4=;
        b=qC7hlNkAIWl9Oy5DRJmCgSuEvLpAWFr4wou/sSBdg0pRISSBrszsF31X7WmpvoWMRk
         4esGZqCRo2RINTRBLm+WDPdxR0loHhwjIsW3sBsHQgznm7z3m+X9628FzLq/0qxJyydq
         GUnsbH7z70pI5BNxQnotTOQoB0aZKfCooqe6gAkczQPafkKjY7JyP13ZWCDlyUqAqmTi
         opHbTho/oeseNuxdSDoBKscg1pKNJYAgGOujP3d+jpnH8/Y++7CmvsVuqhYwQOWzbmw3
         P65sX1h6lWIKs1ceDnEWn2RDCtp3oGpCBiBdsAMX76hIRkpcsAZQSCZnU24m1To120+e
         2qxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xU2XxeDGk6YX3FC/ojl/3L4B1JJ6TXtbrbSc+4+VUa4=;
        b=qt7mcuZRhCgplsFChYPn56nyAZlnkzNqwRGKCWK/yJRxTxitftH7m9WFojBU9q+3C2
         /MiL/PyYJTFhnmNGnqgNPnVz3G+o8p11Y6ckjI9Dq8cM2hy30KQVIVn50duu4iiNes1U
         Rr244Q+aDCx15xWwG9fE5DW7G6myecqUBb29c4/lRfvFe1rxXspg2D2CloTb1IebMymS
         A5mB2a04dvEmISHVD98zCSbo2XWlVMIujEqdmdBlAxMsHLac2UZPHP1qBVG7E5PB46EI
         SYllO4Eby859779ozGVekmcJsn3zPFUrlWu7Ba1qZXML/1IEaM9JkgAucausYzkGDrWr
         dFaw==
X-Gm-Message-State: AFqh2kqgFecrFGtaO2nma9H2UqOxr1ioPogdVumInRO0YQlYNL0fa8ZQ
        EPN6kLcvDzsuc7CfBU5AP1sUDg==
X-Google-Smtp-Source: AMrXdXvI7+ihPxe9K9yveY6NBWcd/Dmo4UaXeaByYpciCo7OwIIinu8o07kuSr4MojVJHZsozjB0Ig==
X-Received: by 2002:a05:600c:3509:b0:3cf:93de:14e8 with SMTP id h9-20020a05600c350900b003cf93de14e8mr58850335wmq.39.1673659458927;
        Fri, 13 Jan 2023 17:24:18 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id j23-20020a05600c1c1700b003b4ff30e566sm3405990wms.3.2023.01.13.17.24.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 17:24:18 -0800 (PST)
Message-ID: <83a7bfed-3b16-3d01-b1b2-f197252bd0b1@linaro.org>
Date:   Sat, 14 Jan 2023 01:24:17 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] interconnect: Skip call into provider if initial bw is
 zero
Content-Language: en-US
To:     Vivek Aknurwar <quic_viveka@quicinc.com>, djakov@kernel.org
Cc:     quic_mdtipton@quicinc.com, quic_okukatla@quicinc.com,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1673647679-15216-1-git-send-email-quic_viveka@quicinc.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <1673647679-15216-1-git-send-email-quic_viveka@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/01/2023 22:07, Vivek Aknurwar wrote:
> Currently framework sets bw even when init bw requirements are zero during
> provider registration, thus resulting bulk of set bw to hw.
> Avoid this behaviour by skipping provider set bw calls if init bw is zero.
> 
> Signed-off-by: Vivek Aknurwar <quic_viveka@quicinc.com>
> ---
>   drivers/interconnect/core.c | 17 ++++++++++-------
>   1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index 25debde..43ed595 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -977,14 +977,17 @@ void icc_node_add(struct icc_node *node, struct icc_provider *provider)
>   	node->avg_bw = node->init_avg;
>   	node->peak_bw = node->init_peak;
>   
> -	if (provider->pre_aggregate)
> -		provider->pre_aggregate(node);
> -
> -	if (provider->aggregate)
> -		provider->aggregate(node, 0, node->init_avg, node->init_peak,
> -				    &node->avg_bw, &node->peak_bw);
> +	if (node->avg_bw || node->peak_bw) {
> +		if (provider->pre_aggregate)
> +			provider->pre_aggregate(node);
> +
> +		if (provider->aggregate)
> +			provider->aggregate(node, 0, node->init_avg, node->init_peak,
> +					    &node->avg_bw, &node->peak_bw);
> +		if (provider->set)
> +			provider->set(node, node);
> +	}
>   
> -	provider->set(node, node);
>   	node->avg_bw = 0;
>   	node->peak_bw = 0;
>   

I have the same comment/question for this patch that I had for the qcom 
arch specific version of it. This patch seems to be doing at a higher 
level what the patch below was doing at a lower level.

https://lore.kernel.org/lkml/1039a507-c4cd-e92f-dc29-1e2169ce5078@linaro.org/T/#m0c90588d0d1e2ab88c39be8f5f3a8f0b61396349

what happens to earlier silicon - qcom silicon which previously made 
explicit zero requests ?

https://lore.kernel.org/lkml/1039a507-c4cd-e92f-dc29-1e2169ce5078@linaro.org/T/#m589e8280de470e038249bb362634221771d845dd

https://lkml.org/lkml/2023/1/3/1232

Isn't it a better idea to let lower layer drivers differentiate what 
they do ?

For example on pre 5.4 qcom kernel silicon we might choose to set the 
value to zero "because that's what the reference code did" but on newer 
silicon we might opt to skip the zero configuration ?

I'm happy to be shown the error of my ways but, absent testing to *show* 
it doesn't impact existing legacy silicon, I think we should be wary of 
this change.

---
bod
