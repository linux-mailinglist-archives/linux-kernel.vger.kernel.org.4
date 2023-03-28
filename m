Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE9F6CC5B2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 17:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233141AbjC1PQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 11:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232995AbjC1PQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 11:16:15 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98F0113E0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 08:15:19 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id l15-20020a05600c4f0f00b003ef6d684102so4354919wmq.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 08:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680016493;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PiMcWrRifwEUskuyIQFulIGS7kWqc1dpRYsMeE3Bnt8=;
        b=lkLswlCp30qWwFIoG0VhbwpbY4a6zCPS1qSMwqwqeiFFRzUZmaUPXzqNBgLn9KbnZA
         EjRMoSidmm0G1ZqXLco7qoaIeAGtEqy9CzCmGT113ZV9pZlOZXo3Q4EQCvl5QeTp1+07
         kEIka5g6iNZos2U6DbuOOzeSxbQ/cJ+Ymvhn4t6dwcq9C/hnxbYylLgrMYJp0a4BoA9y
         E8vCYfeNd7p3wsnJmXtnAPbXhT/qlhRza6jRb6elaW6Yp0GEpqkFB2A/bwALWysQ5g6S
         Q6c0Hr9njtIXFUbe4cyCN9r+vmJFm9YuhFp7Q/rjIsMdNApQtZJ3QRPehh/ts8+0ft+2
         zzOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680016493;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PiMcWrRifwEUskuyIQFulIGS7kWqc1dpRYsMeE3Bnt8=;
        b=qxr3UZ7MkJyq/VIEghYauBs+zbzGbEY7bi4+96jXmF3xlSfExC0RUIkr++VwNDNGyh
         WMvWf3oCGqfjWIbV8hOute09tHFcUuR+dyr+1x7eN3UWYIoXKLQRGy7xEsbCzM3zj7W3
         e2mlMIqM8Zp+Dfb7H/eSqnaEYjh1vEUmCh/TVJi/khbhULlW+Goq8Btoka/00SbW118z
         WYGyovbN6TCcRHgqA8VQQvRSH0FwDYQ2Kca3VdCrhVUpqOesc8LgGD5cblpOzsWJssoB
         A/qkZuylZLSXS9b2No1iC7RkLaxdSJCLiShs//x3exdw/DgQakGk4BIfB5qnyX12sZxp
         y2mw==
X-Gm-Message-State: AO0yUKWla6a5tnobWwU2HKreiDQVFcioAcUT7bHQIioRslJ9ES7T8WvL
        OrCueuTfKejpnJmquhoSkefgPg==
X-Google-Smtp-Source: AK7set95wY5EE0YNtfyvHTheORBSmDzHYguznEV+XEbkUnM0uVPMSwFMBcmsjKdakudAhAOmOYBvCQ==
X-Received: by 2002:a7b:ce08:0:b0:3da:1f6a:7b36 with SMTP id m8-20020a7bce08000000b003da1f6a7b36mr12456491wmc.0.1680016493494;
        Tue, 28 Mar 2023 08:14:53 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.91])
        by smtp.gmail.com with ESMTPSA id v4-20020a05600c214400b003ef62deb830sm11354391wml.25.2023.03.28.08.14.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 08:14:53 -0700 (PDT)
Message-ID: <48f1ee32-a030-8188-3a9d-612888b9678f@linaro.org>
Date:   Tue, 28 Mar 2023 16:14:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH -next] spi: rockchip-sfc: Use
 devm_platform_get_and_ioremap_resource()
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>, broonie@kernel.org
Cc:     heiko@sntech.de, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230328062118.86336-1-yang.lee@linux.alibaba.com>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230328062118.86336-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/28/23 07:21, Yang Li wrote:
> According to commit 890cc39a8799 ("drivers: provide
> devm_platform_get_and_ioremap_resource()"), convert
> platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/spi/spi-rockchip-sfc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

If I were you I would make a single patch addressing all the drivers
from SPI as this is a single logical change. You get extra points as you
avoid polluting the log.

> 
> diff --git a/drivers/spi/spi-rockchip-sfc.c b/drivers/spi/spi-rockchip-sfc.c
> index 4fabd2e0439f..6830ecaa270b 100644
> --- a/drivers/spi/spi-rockchip-sfc.c
> +++ b/drivers/spi/spi-rockchip-sfc.c
> @@ -576,8 +576,7 @@ static int rockchip_sfc_probe(struct platform_device *pdev)
>  	sfc = spi_master_get_devdata(master);
>  	sfc->dev = dev;
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	sfc->regbase = devm_ioremap_resource(dev, res);
> +	sfc->regbase = devm_platform_get_and_ioremap_resource(pdev, 0, &res);

No, you better use devm_platform_ioremap_resource() as res is not used
afterwards. You'll get rid of the local variable too.

>  	if (IS_ERR(sfc->regbase))
>  		return PTR_ERR(sfc->regbase);
>  
