Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F37C665E91
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 15:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbjAKO6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 09:58:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbjAKO55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 09:57:57 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84F4D4A
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 06:57:53 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id g19-20020a05600c4ed300b003d9eb1dbc0aso9886054wmq.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 06:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y3LJx+Nh8Xj8DEVlyljWWnwnw5ApxQN4nGKS5rYoQuE=;
        b=m96JKu+SCNJmZ29gKAV8mtAjxXydKJ/YUgb6i2bGTW4UvE/3SJazsb4u/Eo8jVRuOQ
         doG6HzrlrISQp+Yop+CxJQmN0aFD0VGGIu6+66/9HapTnQsbLxA7CKZRTPMtJ48/F5OV
         cEnXRRqx6Lk8OkRV36CXHohrNVe9aPfWjXMOrKuHll/HftsgX0V1FGOwc6uCmUfpuxqP
         fbjlU/KqTGTSlz+W4HEEjAflyJXb8N/dAFL5LeVU/NDBHzzETkX6hpT7PSi/blE96IKr
         vgzfyEvxD6a416LdAIh4P1A5MTGR95bZK2EdDtS0zmKPz9Jo51oL7CLD9hR2ixhEwUSE
         TFAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y3LJx+Nh8Xj8DEVlyljWWnwnw5ApxQN4nGKS5rYoQuE=;
        b=X257YTrgnVZNtlm5H7mv9gRk6ed2nANagVsCwe82ITpooMetm8+IpIoxCPYM0NEhuP
         mi8BAwUftQGPuLYIowOp/ZeVwzCDv5huiLKer+8J+ugT1s1n/lqqOaPDCnZMIQSmUinG
         ZAdJcjXaDgVr3K0W/pEVlY8q/wPwvqbh3X4PZZBXGrO8ies2Wo1C/jaGXqeLuM11bodk
         K3PQLurDnbXgTeBEafj/l97tOJskRdkZ7f6NmoSPcJEO13C1FUhVI5L94ukXefruG9D1
         IIzmjYDTfTiTFnKkOrvz+mOSNrwFhStdP4kJadQrBkVANR2V0s48R1uMwLDBKFfxccw+
         3UQQ==
X-Gm-Message-State: AFqh2kocLRSMLzAdCvTQHgjN2Hga6VCzP6Ex/2D1Mc0g6E8FKM1CeijM
        N8hWlU2csFzVNwHQnyRMFspszg==
X-Google-Smtp-Source: AMrXdXtGdW4uPXVp3JxvxUDiP0L+DInrqSGxn+EBfesjB1hvMtndLnIA3vMlqdBAhEeAf3o6ZLRhUw==
X-Received: by 2002:a1c:6a16:0:b0:3c6:f732:bf6f with SMTP id f22-20020a1c6a16000000b003c6f732bf6fmr52300716wmc.13.1673449072435;
        Wed, 11 Jan 2023 06:57:52 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id o19-20020a05600c511300b003d9862ec435sm7341529wms.20.2023.01.11.06.57.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 06:57:51 -0800 (PST)
Message-ID: <2a2b2412-752a-1c64-41b7-eb256ae55f42@linaro.org>
Date:   Wed, 11 Jan 2023 15:57:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] memory: omap-gpmc: fix multi-device handling on the same
 CS
Content-Language: en-US
To:     INAGAKI Hiroshi <musashino.open@gmail.com>, rogerq@kernel.org,
        tony@atomide.com
Cc:     linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230111141346.1516-1-musashino.open@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230111141346.1516-1-musashino.open@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/2023 15:13, INAGAKI Hiroshi wrote:
> This patch fixes the handling of multiple devices on the same CS by

Do not use "This commit/patch".
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

> replacing CS name to "name" of node instead of "full_name".
> 
> In c2ade654dbf7d02f09ad491f5621fc321d4af96b
> ("memory: omap-gpmc: Use of_node_name_eq for node name comparisons"),

Use syntax: commit short SHA (".....") as pointed by checkpatch.

> the name for setting to CS was replaced but it doesn't fit for the
> comparison by of_node_name_eq.
> In of_node_name_eq, the length for strncmp will be obtained from the
> node that trying to register and it doesn't contain the length of
> "@<cs>,<offset>". 

Skip explanation what is inside of_node_name_eq() but focus on what the
driver is doing.

> But the base name for comparison passed from
> registered CS name contains the prefix,

What is "the prefix"?

>  then, that two lengths won't
> match and false will be returned, and registration on the same CS
> will be failed.

Unfortunately, based on this, I don't get what is compare with what. I
bet the issue is simple, but based on the description it does not look
like that.

> 
> example (Century Systems MA-E350/N, AM3352):
> 
> - Device Tree
> 
>   /* memory mapped gpio controllers on GPMC */
>   gpio@2,2 {
>       reg = <2 0x2 0x1>; /* CS2, offset 0x2, IO size 0x1 */
>       ...
>   };
> 
>   gpio@2,10 {
>       reg = <2 0x10 0x1>; /* CS2, offset 0x10, IO size 0x1 */
>       ...
>   };
> 
>   gpio@2,12 {
>       reg = <2 0x12 0x1>; /* CS2, offset 0x12, IO size 0x1 */
>       ...
>   };
> 
>   gpio@2,14 {
>       reg = <2 0x14 0x1>; /* CS2, offset 0x14, IO size 0x1 */
>       ...
>   };

Trim it, two entries might be enough to illustrate it.

> 
> - dmesg
> 
>   [    1.596402] omap-gpmc 50000000.gpmc: cannot request GPMC CS 2
>   [    1.596434] omap-gpmc 50000000.gpmc: failed to probe DT child 'gpio': -16
>   [    1.596489] omap-gpmc 50000000.gpmc: cannot request GPMC CS 2
>   [    1.596511] omap-gpmc 50000000.gpmc: failed to probe DT child 'gpio': -16
>   [    1.596564] omap-gpmc 50000000.gpmc: cannot request GPMC CS 2
>   [    1.596586] omap-gpmc 50000000.gpmc: failed to probe DT child 'gpio': -16
> 
>   ("gpio@2,2" is ok, "gpio@2,10", "gpio@2,12", "gpio@2.14" are fail)
> 
> Fixes: c2ade654dbf7d02f09ad491f5621fc321d4af96b
> ("memory: omap-gpmc: Use of_node_name_eq for node name comparisons")

Also not correct tag. Run checkpatch.

> 

No blank lines.

> Signed-off-by: INAGAKI Hiroshi <musashino.open@gmail.com>


> ---
>  drivers/memory/omap-gpmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
> index d78f73db37c8..3e3e84e34795 100644
> --- a/drivers/memory/omap-gpmc.c
> +++ b/drivers/memory/omap-gpmc.c
> @@ -2202,7 +2202,7 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
>  		dev_err(&pdev->dev, "cannot request GPMC CS %d\n", cs);
>  		return ret;
>  	}
> -	gpmc_cs_set_name(cs, child->full_name);
> +	gpmc_cs_set_name(cs, child->name);
>  
>  	gpmc_read_settings_dt(child, &gpmc_s);
>  	gpmc_read_timings_dt(child, &gpmc_t);
> 
> base-commit: 13f35b3c72f4075e13a974f439b20b9e26f8f243

Best regards,
Krzysztof

