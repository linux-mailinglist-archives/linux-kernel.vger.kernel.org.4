Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD85F628B62
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 22:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236250AbiKNVdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 16:33:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbiKNVdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 16:33:37 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F9525E7;
        Mon, 14 Nov 2022 13:33:36 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id i21so19226476edj.10;
        Mon, 14 Nov 2022 13:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eKfZHCbbq2pbj5ZCKNOXHjHou+CBwHckbUbOdThGkZk=;
        b=lJfxyhuW1VKX/07EXNu42iSxH+OmYQe5UV10zPkKDz50jdMFRoarCeseVuO8CUyrb4
         yIqkG7eanrwUklwAHftXYmGYeCTNNIvmljt58CzTKAi2dyzmNTODcdd07zHTGxsFCZ4w
         LZXmcB7yTVITKLPIVl1eodewAiPXamreg5zAI3wWp068c/9bj8M//J2FBWcMskPuFaBw
         uLp3iaivBg+TtLMTWD4TbiHa52y5cVLeAkuqygomMd0wnqVKEMxQbZhiH4UkPDoLtK8w
         9Ql+WgvGduqDlC4CPFFK2hdwPGnUkcGLqV+rXDe3/G6ZbTWLJZjhUmykEGHVLK/+gSfM
         kAYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eKfZHCbbq2pbj5ZCKNOXHjHou+CBwHckbUbOdThGkZk=;
        b=WYkPQmFE6do7zC5nZkUdH02PJoXZciRoJrkniXz1E4mZ8JsdiV4xDFnfc9GJ5csEOh
         Vogs9CfBzOe/bUMQ/SvafevvmvWdmzU4Azjj9GcmWx/eX+/JpiK5LCL2Qk++eLkEGRoh
         WjZqqD6wVZsNkQoFJAVHghnrswY3glqu50PiNxh6QP61hA8q2jZeg4FADD/2Y/80hiAy
         g4PoSLi3BNBuKZ3DS6TnF6UZZAM83XC8YCaZUR4TX9bYfcR/kBsSmAqcizJZkwtZecDx
         HGjSl01MbWQAZcA8RXJ9r7gapiA1ecpBY6xGOWKzCMdV6i1COh4Zxkzs2HT7YweE61CQ
         DQ4w==
X-Gm-Message-State: ANoB5plyRxSvlrmH1taL/xTVmFdsnBWMVepkGWfkBIFckDwXw73HZwWB
        LIiJ66nURJtJWQ5A405+XCU=
X-Google-Smtp-Source: AA0mqf6AAIdOaVTwo9dnJzgZOFGDw+mo3rfN3f53F3NHXaHAbqTHoeeHbU7uD3L4MQaRfmOlTwl0Kg==
X-Received: by 2002:aa7:da55:0:b0:464:718c:b271 with SMTP id w21-20020aa7da55000000b00464718cb271mr12581926eds.287.1668461614528;
        Mon, 14 Nov 2022 13:33:34 -0800 (PST)
Received: from ?IPV6:2a01:c23:c14f:9a00:5c5e:411:c829:d51c? (dynamic-2a01-0c23-c14f-9a00-5c5e-0411-c829-d51c.c23.pool.telefonica.de. [2a01:c23:c14f:9a00:5c5e:411:c829:d51c])
        by smtp.googlemail.com with ESMTPSA id l27-20020a170906079b00b0073022b796a7sm4680770ejc.93.2022.11.14.13.33.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 13:33:33 -0800 (PST)
Message-ID: <fedda473-3233-4dfa-e2a3-3f22c2b894e8@gmail.com>
Date:   Mon, 14 Nov 2022 22:33:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Peter Suti <peter.suti@streamunlimited.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221114093857.491695-1-peter.suti@streamunlimited.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH] mmc: meson-gx: fix SDIO interrupt handling
In-Reply-To: <20221114093857.491695-1-peter.suti@streamunlimited.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.11.2022 10:38, Peter Suti wrote:
> With the interrupt support introduced in commit 066ecde sometimes the
> Marvell-8987 wifi chip entered a deadlock using the marvell-sd-uapsta-8987
> vendor driver. The cause seems to be that sometimes the interrupt handler
> handles 2 IRQs and one of them disables the interrupts which are not reenabled
> when all interrupts are finished. To work around this, disable all interrupts
> when we are in the IRQ context and reenable them when the current IRQ is handled.
> 

IIRC I had a similar/same problem in mind when discussing the following:
https://lore.kernel.org/linux-arm-kernel/CAPDyKFoameOb7d3cn8_ki1O6DbMEAFvkQh1uUsYp4S-Lkq41oQ@mail.gmail.com/
Not sure though whether it's related to the issue you're facing.

> Fixes: 066ecde ("mmc: meson-gx: add SDIO interrupt support")
> 
> Signed-off-by: Peter Suti <peter.suti@streamunlimited.com>
> ---
>  drivers/mmc/host/meson-gx-mmc.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index 6e5ea0213b47..972024d57d1c 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -950,6 +950,10 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
>  	struct mmc_command *cmd;
>  	u32 status, raw_status;
>  	irqreturn_t ret = IRQ_NONE;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&host->lock, flags);

Typically you wouldn't have to use _irqsave version in a hard irq handler.
Or is to deal with forced threaded irq handlers?
Do you use forced threaded handlers on your system?

> +	__meson_mmc_enable_sdio_irq(host->mmc, 0);
>  
>  	raw_status = readl(host->regs + SD_EMMC_STATUS);
>  	status = raw_status & (IRQ_EN_MASK | IRQ_SDIO);
> @@ -958,11 +962,11 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
>  		dev_dbg(host->dev,
>  			"Unexpected IRQ! irq_en 0x%08lx - status 0x%08x\n",
>  			 IRQ_EN_MASK | IRQ_SDIO, raw_status);
> -		return IRQ_NONE;
> +		goto out_unlock;
>  	}
>  
>  	if (WARN_ON(!host))
> -		return IRQ_NONE;
> +		goto out_unlock;
>  
>  	/* ack all raised interrupts */
>  	writel(status, host->regs + SD_EMMC_STATUS);
> @@ -970,17 +974,16 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
>  	cmd = host->cmd;
>  
>  	if (status & IRQ_SDIO) {
> -		spin_lock(&host->lock);
> -		__meson_mmc_enable_sdio_irq(host->mmc, 0);
>  		sdio_signal_irq(host->mmc);
> -		spin_unlock(&host->lock);
>  		status &= ~IRQ_SDIO;
> -		if (!status)
> +		if (!status) {
> +			spin_unlock_irqrestore(&host->lock, flags);
>  			return IRQ_HANDLED;
> +		}
>  	}
>  
>  	if (WARN_ON(!cmd))
> -		return IRQ_NONE;
> +		goto out_unlock;
>  
>  	cmd->error = 0;
>  	if (status & IRQ_CRC_ERR) {
> @@ -1023,6 +1026,10 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
>  	if (ret == IRQ_HANDLED)
>  		meson_mmc_request_done(host->mmc, cmd->mrq);
>  
> +out_unlock:
> +	__meson_mmc_enable_sdio_irq(host->mmc, 1);
> +	spin_unlock_irqrestore(&host->lock, flags);
> +
>  	return ret;
>  }
>  

