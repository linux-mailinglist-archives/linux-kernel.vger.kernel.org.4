Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E91CE63498F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 22:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235031AbiKVVmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 16:42:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235131AbiKVVm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 16:42:29 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5647AC6BC3;
        Tue, 22 Nov 2022 13:41:33 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id i10so38675510ejg.6;
        Tue, 22 Nov 2022 13:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rIlEqmzQ43h5mSij/yzLC0+0L3JCO/odjsG2ekPxh9U=;
        b=h+9kdKFpd/hcmB9R34FN30DRJjEATOGghrxYQQa/sKXJh0OJ9nFB3xlb/rvMGCYIAT
         kw1p6YABGept+dIP3PZKkZdSUa1xnQX3zHaSE3//HboVh/CFxZYfsWFZQ7rxp0eEr8MV
         IMCYHW4Xe2IiiTd2j5W4VZfTawM7xQAjEp4UqsL2XSedaMUlYTruH/ehk5qz9YS1swAC
         5Q5Pzy6SCOdnI0ZH3SYfq0pO/t6c2gJMUzigFwMCYREsa+9OO3SI0if4IBgbySosppuW
         HSU7ymp+WDZzw4D4FtqZPzbvTdCNkr9rBtKVl5MFBtEfs5hxgNdwn6P9x1GdA69W6RXg
         WU2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rIlEqmzQ43h5mSij/yzLC0+0L3JCO/odjsG2ekPxh9U=;
        b=Y74lVrCcG30fo/lOIh+Y6e7kgG8lmBLxnr8A/2L5tVRnnOMseKE6JpnQ7yyemHXDkX
         3QgihMvGvBfxmHIYet6/gC9hNgAtBbAJmhfVQfJBOMY9bjmt13n/2D7UJfA4jJE9996m
         0YvQAcqJoX7529Mwy4BwY58Xc7rCdXJz4LC3+nuBf7V5hqfv9MMTgn/awjmx4ty6EtGz
         W0js2cTqbmxtSt5brCgSQPEYTHLoGqhBr8j8FQoPWl5dBX/uFr11WsN2QTprN5vm5/mn
         uLLji8KUtF4KU0YUuOFt89MDiniQW05gxFb+pvqu6YpNUHIGBx2PN78lEo1Gui/xUQwi
         kUhQ==
X-Gm-Message-State: ANoB5pmmMLZ72sFx31GHdDx0xnW6+rz3/4B7aQ/39OugoaN0RE5Zk3jt
        nNRThd0uyubafBC2PSF/ztY=
X-Google-Smtp-Source: AA0mqf6TDlqWgJrmTLHSzauxMrhn5bqpuKWijJ37xhWA7M3zWQPKY2WbY6FtgxDKHxCv64P2E7/y8w==
X-Received: by 2002:a17:906:810:b0:7ad:d7f9:1f96 with SMTP id e16-20020a170906081000b007add7f91f96mr5253604ejd.384.1669153291680;
        Tue, 22 Nov 2022 13:41:31 -0800 (PST)
Received: from ?IPV6:2a01:c23:b808:900:d439:ecf6:5870:6417? (dynamic-2a01-0c23-b808-0900-d439-ecf6-5870-6417.c23.pool.telefonica.de. [2a01:c23:b808:900:d439:ecf6:5870:6417])
        by smtp.googlemail.com with ESMTPSA id d4-20020a056402400400b0046a0096bfdfsm722502eda.52.2022.11.22.13.41.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 13:41:31 -0800 (PST)
Message-ID: <52861a84-0fe2-37f0-d66a-145f2ebe1d79@gmail.com>
Date:   Tue, 22 Nov 2022 22:41:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
To:     Peter Suti <peter.suti@streamunlimited.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <CAPDyKFqrCCtY_A072WswEFa3Bnz7EfMp40MRYtr3G7Jbq_hbTw@mail.gmail.com>
 <20221122132304.1482508-1-peter.suti@streamunlimited.com>
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH v2] mmc: meson-gx: fix SDIO interrupt handling
In-Reply-To: <20221122132304.1482508-1-peter.suti@streamunlimited.com>
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

On 22.11.2022 14:23, Peter Suti wrote:
> With the interrupt support introduced in commit 066ecde sometimes the
> Marvell-8987 wifi chip entered a deadlock using the marvell-sd-uapsta-8987
> vendor driver. The cause seems to be that sometimes the interrupt handler
> handles 2 IRQs and one of them disables the interrupts which are not reenabled
> when all interrupts are finished. To work around this, disable all interrupts
> when we are in the IRQ context and reenable them when the current IRQ is handled.
> 
To me it's still not clear what you mean with "handles 2 IRQs".
Hard irq handlers aren't re-entrant. Can you provide the exact call sequence
for the issue you're facing?
Are SDIO interrupts handled on more than one CPU in your case?
Are you concerned about the hard irq handler running in parallel on more than one CPU?

The proposed patch looks hacky and somewhat bypasses the SDIO core logic
by partially re-enabling SDIO interrupts in the hard irq handler.

In the first review round I wrote the following but didn't see a feedback yet.
Did you check the linked discussion whether it may be related to your issue?

-> IIRC I had a similar/same problem in mind when discussing the following:
-> https://lore.kernel.org/linux-arm-kernel/CAPDyKFoameOb7d3cn8_ki1O6DbMEAFvkQh1uUsYp4S-Lkq41oQ@mail.gmail.com/
-> Not sure though whether it's related to the issue you're facing.



> Fixes: 066ecde ("mmc: meson-gx: add SDIO interrupt support")
> 
> Signed-off-by: Peter Suti <peter.suti@streamunlimited.com>
> ---
> Changes in v2:
> 	- use spin_lock instead of spin_lock_irqsave
> 	- only reenable interrupts if they were enabled already
> 
>  drivers/mmc/host/meson-gx-mmc.c | 30 +++++++++++++++++++++++-------
>  1 file changed, 23 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index 6e5ea0213b47..0c95f8640b34 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -934,6 +934,13 @@ static void meson_mmc_read_resp(struct mmc_host *mmc, struct mmc_command *cmd)
>  	}
>  }
>  
> +static bool __meson_mmc_sdio_irq_is_enabled(struct mmc_host *mmc)
> +{
> +	struct meson_host *host = mmc_priv(mmc);
> +
> +	return readl(host->regs + SD_EMMC_IRQ_EN) & IRQ_SDIO;
> +}
> +
>  static void __meson_mmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
>  {
>  	struct meson_host *host = mmc_priv(mmc);
> @@ -950,6 +957,11 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
>  	struct mmc_command *cmd;
>  	u32 status, raw_status;
>  	irqreturn_t ret = IRQ_NONE;
> +	bool irq_enabled;
> +
> +	spin_lock(&host->lock);
> +	irq_enabled = __meson_mmc_sdio_irq_is_enabled(host->mmc);
> +	__meson_mmc_enable_sdio_irq(host->mmc, 0);
>  
>  	raw_status = readl(host->regs + SD_EMMC_STATUS);
>  	status = raw_status & (IRQ_EN_MASK | IRQ_SDIO);
> @@ -958,11 +970,11 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
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
> @@ -970,17 +982,16 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
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
> +			spin_unlock(&host->lock);
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
> @@ -1023,6 +1034,11 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
>  	if (ret == IRQ_HANDLED)
>  		meson_mmc_request_done(host->mmc, cmd->mrq);
>  
> +out_unlock:
> +	if (irq_enabled)
> +		__meson_mmc_enable_sdio_irq(host->mmc, 1);
> +	spin_unlock(&host->lock);
> +
>  	return ret;
>  }
>  

