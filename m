Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430E46275E5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 07:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235775AbiKNG0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 01:26:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbiKNG0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 01:26:23 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FFA14D22
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 22:26:22 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id u11so11850339ljk.6
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 22:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b6VI+ABEZ1h4d+64TdR2Fv/MvDrZgmhBhQx9ZCHP/Hc=;
        b=nbs59sbEk04HhfP4ISizT/HOFFK9oht4Uzb9dfKOObUps2RPcCgGuIw2xdNq4Hv8aJ
         J2F0mW+RLpqoiH9V4IU3EhXNHVBhUdsM+eV983pPcWPyd9rmxC2O0J5yGvMAQSHrTChe
         3dRiVVHbhqeUMFBKXDD/Oo+3FR0W/1YNUbylDbbywFHfAi9FMsstTY+4N9HGa2CBj4UM
         7LhiKGYDBGPBk0hRLXJR+v4v+nB4bQBki4BBSqV8DaI8Uw6jJL7JJSzzWfHBH9FhA+am
         4pgAS1rDQzBfmxL9XjgaYhT0i5rl4o0wOGN2SBo7p+IyVo4T5GTXHFHrrb2w7vhJH5NQ
         PIpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b6VI+ABEZ1h4d+64TdR2Fv/MvDrZgmhBhQx9ZCHP/Hc=;
        b=Ia1TmWj7pvgWZrh5jNGevFXo6Oox35POxdD7THMPbsrdknoRZ+GxfZ6OwnY2YnJrzB
         yOHTU2dUu1xy5c+hR5mLhExssvGxZ04D1V+Cx8LJo+MhY0aGU2CXC+ZGkV7B14cXEhwz
         SMsA0T26toaEVjUMiqrS8DTDAdINSFoKDNiu6NZxj+Rbfl8ZK+NF5jFb15S8a+/7LiBZ
         KgcWJHbBx/KhbVQHo2zfrN1ZTj+7QgxxpOM8AVuZ87+LRgGW24TGI3O7D5HSAF1A6hbA
         N0JzI8yhmfpLGM/ELp0EhT+9iIz3GSEiFsEEyvbmcAaafkOk6KXWpOpvc8l80iD6MRfL
         2G1w==
X-Gm-Message-State: ANoB5pkeI0UgogCFl84zDlRj7z8WGm9H5h5gY/rRqtklrp2g/S/LQKTG
        GBL+g9oVjNNBCsMcDQ0lrgI=
X-Google-Smtp-Source: AA0mqf6g4JQd9vs5Ov2KL2xebg9fydvdju7pLnvavXU+fGrclQlYXmgPDCLzOem8A+R9KznkAVyk0A==
X-Received: by 2002:a2e:8751:0:b0:277:313e:454e with SMTP id q17-20020a2e8751000000b00277313e454emr3565669ljj.446.1668407180722;
        Sun, 13 Nov 2022 22:26:20 -0800 (PST)
Received: from ?IPV6:2001:14ba:16f3:4a00::7? (dc75zzyyyyyyyyyyyyydt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::7])
        by smtp.gmail.com with ESMTPSA id c10-20020a056512324a00b0048af3c090f8sm1712909lfr.13.2022.11.13.22.26.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Nov 2022 22:26:20 -0800 (PST)
Message-ID: <d3e33348-5231-1a42-aac5-93ebfd5f8f14@gmail.com>
Date:   Mon, 14 Nov 2022 08:26:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>, lee@kernel.org
Cc:     mani@kernel.org, cristian.ciocaltea@gmail.com, wens@csie.org,
        tharvey@gateworks.com, cw00.choi@samsung.com,
        krzysztof.kozlowski@linaro.org, brgl@bgdev.pl, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
References: <20221112151835.39059-1-aidanmacdonald.0x0@gmail.com>
 <20221112151835.39059-11-aidanmacdonald.0x0@gmail.com>
Content-Language: en-US
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH 10/18] mfd: rohm-bd71828: Replace irqchip mask_invert with
 unmask_base
In-Reply-To: <20221112151835.39059-11-aidanmacdonald.0x0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/22 17:18, Aidan MacDonald wrote:
> Remove use of the deprecated mask_invert flag. Inverted mask
> registers (where a '1' bit enables an IRQ) can be described more
> directly as an unmask register.
> 
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

> ---
>   drivers/mfd/rohm-bd71828.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mfd/rohm-bd71828.c b/drivers/mfd/rohm-bd71828.c
> index 714d9fcbf07b..3c5c6c393650 100644
> --- a/drivers/mfd/rohm-bd71828.c
> +++ b/drivers/mfd/rohm-bd71828.c
> @@ -413,9 +413,8 @@ static struct regmap_irq_chip bd71828_irq_chip = {
>   	.irqs = &bd71828_irqs[0],
>   	.num_irqs = ARRAY_SIZE(bd71828_irqs),
>   	.status_base = BD71828_REG_INT_BUCK,
> -	.mask_base = BD71828_REG_INT_MASK_BUCK,
> +	.unmask_base = BD71828_REG_INT_MASK_BUCK,
>   	.ack_base = BD71828_REG_INT_BUCK,
> -	.mask_invert = true,
>   	.init_ack_masked = true,
>   	.num_regs = 12,
>   	.num_main_regs = 1,
> @@ -430,9 +429,8 @@ static struct regmap_irq_chip bd71815_irq_chip = {
>   	.irqs = &bd71815_irqs[0],
>   	.num_irqs = ARRAY_SIZE(bd71815_irqs),
>   	.status_base = BD71815_REG_INT_STAT_01,
> -	.mask_base = BD71815_REG_INT_EN_01,
> +	.unmask_base = BD71815_REG_INT_EN_01,
>   	.ack_base = BD71815_REG_INT_STAT_01,
> -	.mask_invert = true,
>   	.init_ack_masked = true,
>   	.num_regs = 12,
>   	.num_main_regs = 1,

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

