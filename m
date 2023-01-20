Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6564675BB1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 18:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjATRhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 12:37:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjATRhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 12:37:34 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2586FD22
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 09:37:32 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id m5-20020a05600c4f4500b003db03b2559eso4250073wmq.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 09:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SLhm7/7TseEHDfOfttc2V5ZV0VgqyhPbXgwM+DaFJ5Y=;
        b=svrAMkrGeg8zT3qMBUc2PhbH588n3RDzEdlVohuPV2YfPjLxXbuxlJ48iMLmnDrSRe
         +Njsx+V++rWSsONZOglQjrrOCjk4LPV7JhJnhrlGEPx8Etd4rFUYqMuvt5DFlOPO+X11
         97z+SB1pa8jPyH3kH89RgaNp8tmDfXSREyUcYy9b9VcaCcz/mmDO+M42vIh909mXTzkH
         xJjMv1QjFLLYd76D6D2z/tXfcZ+8WyTLWly+JeB4jUKAghWGFVNu1/lqvQAlqiAfaIpJ
         oziN0j3+iHxFQ2YbJR8KDohwP4ZIrOh+7TatknRT1EyP6ZaoWQxLNCypFJiyPCaPdsma
         5VaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SLhm7/7TseEHDfOfttc2V5ZV0VgqyhPbXgwM+DaFJ5Y=;
        b=62yS6yDo3OYtAf9q6sLuyD23VOBirbwfrz1us4q7I6qvTdb4p2dWOMLylRqO5Y2kfY
         NldENlUUKnmXUDAY5RNBFlv3D8N5y7kMBfl8sr8uU6ODKrSZeCSPZdg+gYTCzRJv2bnn
         lB2GP2yw1QcxoitImrgz7WPoEnqSSXoIl1IBJp/xvbZGdUVKhsmAzD2HdXZ1tBAwwIID
         nLmSGrUTCMFH1Tys++mRk5Omgu32KuPoxDxXBoU2MnMS0dkIsm2xHJcPotmvLHFidfpq
         f6fUZFDiAYqBmwgO/kikiJwyoegrDes8bFLbmCdQKlDWGvaMhBbeCwnOzM5Fs8lKj46k
         M0aA==
X-Gm-Message-State: AFqh2kqq0lH4cmoKc4lBzvGoNmC+Z0Q8ZoL5CWF9qkPohaGDuqnl7WAn
        RUr0Wx3OiIfKZq8tg+uJxfLiNg==
X-Google-Smtp-Source: AMrXdXtLwTrvhfFWX7gv20qxmyVqizkawsPeG5oWnNh3fi0K5uxsTk6CRk4yUMFSb6jnp9mMRvx+lQ==
X-Received: by 2002:a05:600c:a690:b0:3d5:64bf:ccb8 with SMTP id ip16-20020a05600ca69000b003d564bfccb8mr14801898wmb.12.1674236251402;
        Fri, 20 Jan 2023 09:37:31 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id o28-20020a05600c511c00b003dab40f9eafsm3256738wms.35.2023.01.20.09.37.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 09:37:30 -0800 (PST)
Message-ID: <e9a83c52-67df-e448-2005-32fd735eceb1@linaro.org>
Date:   Fri, 20 Jan 2023 17:37:29 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH V2] nvmem: core: fix nvmem_layout_get_match_data()
Content-Language: en-US
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Michael Walle <michael@walle.cc>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20230110204345.7266-1-zajec5@gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230110204345.7266-1-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/01/2023 20:43, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> This function was trying to match wrong OF node (parent device's)
> against an of_match_table. It was always returning NULL.
> 
> Make it match layout's OF node against layout's of_match_table.
> 
> Note: __maybe_unused is needed to avoid:
> warning: variable 'layout_np' set but not used [-Wunused-but-set-variable]
> (of_match_node() is no-op without CONFIG_OF).
> 
> Fixes: f5709a684a0a ("nvmem: core: introduce NVMEM layouts")
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> Reviewed-by: Michael Walle <michael@walle.cc>

Applied thanks,

--srini
> ---
>   drivers/nvmem/core.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index d112bb1328c1..d3be50ed2d0b 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -824,9 +824,11 @@ EXPORT_SYMBOL_GPL(of_nvmem_layout_get_container);
>   const void *nvmem_layout_get_match_data(struct nvmem_device *nvmem,
>   					struct nvmem_layout *layout)
>   {
> +	struct device_node __maybe_unused *layout_np;
>   	const struct of_device_id *match;
>   
> -	match = of_match_node(layout->of_match_table, nvmem->dev.of_node);
> +	layout_np = of_nvmem_layout_get_container(nvmem);
> +	match = of_match_node(layout->of_match_table, layout_np);
>   
>   	return match ? match->data : NULL;
>   }
