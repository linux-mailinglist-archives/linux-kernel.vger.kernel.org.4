Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B722F6275E6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 07:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235782AbiKNG1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 01:27:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbiKNG1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 01:27:06 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F09D1581A
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 22:27:04 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id g12so17755243lfh.3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 22:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bY5kKgtWBUsOEnjOURvV21DJ7RyovgQzTi4nUpuhn6E=;
        b=RWoFR0RCznAXxCcma5tOh2FeyZ1CdkJh+9ErJc+Mj2+I6ETqbdJ9mXOix2hFBZgXb8
         rD0lmcyLg++DIE93cK/wKV7whH20lou+fZW0XZN/RQ19UUaEnuzpoQYrg9gp/1llV1QG
         2midhjXRO2dLFg30DzL6FXvwvd4a7n8ZW5CgB1GLndM/87fPCCOCLDmRNYZPzftn7x3h
         hlgHgOnhZid4//3+2UxYKqdGDJJjsfMdUxvMy0VVUKnybsVqGFTCogACwewbsYk8F1VA
         WnIqL+45h4H/LlVdFg5P7I2L7VJ7uSoNookOOUYBf08Gp8C7zR1utTYnMbMtMdi/yXAW
         uFkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bY5kKgtWBUsOEnjOURvV21DJ7RyovgQzTi4nUpuhn6E=;
        b=Mf94D8iDzluYGZX3KSnI/MQpN/mFtEHXvaZvv5ZrwQwEJOjNKTWldo8nrW9SVLMnZ7
         Rkiw1dz5qLqBlHMP79WdV+verDHZQUxStgmg46I7vPKtjERWyX3KFdG2x6Ymg60eUyc3
         WFgnUSemJKwyByz7OYbX5UgSO/3YMi7mwbH8WrvtwZq123g+y14S5NxfB9x3sKBSDslL
         OFqyh2b3MHNaPoZXkJ6L3qkuadl7ZgpK0C/Wjob1U5R1FV1RITvnZR0HGNj9q2Ra1Ye+
         oHas80t5NFY5VpB8l4f0ltECLdk2XElUp64E3GrGehR671B0Bjcf9tP/ih/bPrzJKDI2
         CFWw==
X-Gm-Message-State: ANoB5pkYUrQ5u1177epO4yk25qWYzcRYcKWN1PLcFWAychaE0Byi4zsm
        spFnDTBkXs8Uxusz1RApcWw=
X-Google-Smtp-Source: AA0mqf4JSHFS2ZAHw4fixGUPDmVLkK7LMQzd/VLb684CUupzxmt17Ynb8cN9YKkTCNC3KpwUAb+tyA==
X-Received: by 2002:ac2:51ac:0:b0:4a9:9827:68ed with SMTP id f12-20020ac251ac000000b004a9982768edmr3395051lfk.45.1668407222388;
        Sun, 13 Nov 2022 22:27:02 -0800 (PST)
Received: from ?IPV6:2001:14ba:16f3:4a00::7? (dc75zzyyyyyyyyyyyyydt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::7])
        by smtp.gmail.com with ESMTPSA id f15-20020a05651c160f00b002770f0a742bsm1844891ljq.41.2022.11.13.22.27.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Nov 2022 22:27:01 -0800 (PST)
Message-ID: <b76ab78d-4785-bc8a-7f56-f21a189584c0@gmail.com>
Date:   Mon, 14 Nov 2022 08:27:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 11/18] mfd: rohm-bd718x7: Drop useless mask_invert flag on
 irqchip
Content-Language: en-US
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>, lee@kernel.org
Cc:     mani@kernel.org, cristian.ciocaltea@gmail.com, wens@csie.org,
        tharvey@gateworks.com, cw00.choi@samsung.com,
        krzysztof.kozlowski@linaro.org, brgl@bgdev.pl, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
References: <20221112151835.39059-1-aidanmacdonald.0x0@gmail.com>
 <20221112151835.39059-12-aidanmacdonald.0x0@gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20221112151835.39059-12-aidanmacdonald.0x0@gmail.com>
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
> Setting mask_invert to false is pointless because that's the
> default. The flag is also deprecated, so drop it.
> 
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

> ---
>   drivers/mfd/rohm-bd718x7.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/mfd/rohm-bd718x7.c b/drivers/mfd/rohm-bd718x7.c
> index bfd81f78beae..ad6c0971a997 100644
> --- a/drivers/mfd/rohm-bd718x7.c
> +++ b/drivers/mfd/rohm-bd718x7.c
> @@ -70,7 +70,6 @@ static struct regmap_irq_chip bd718xx_irq_chip = {
>   	.mask_base = BD718XX_REG_MIRQ,
>   	.ack_base = BD718XX_REG_IRQ,
>   	.init_ack_masked = true,
> -	.mask_invert = false,
>   };
>   
>   static const struct regmap_range pmic_status_range = {

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

