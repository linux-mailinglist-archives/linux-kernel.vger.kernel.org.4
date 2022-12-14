Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1C064D1D9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 22:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiLNVdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 16:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiLNVdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 16:33:49 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E62389E1;
        Wed, 14 Dec 2022 13:33:48 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id fc4so47674722ejc.12;
        Wed, 14 Dec 2022 13:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uBqMDvRiGGhkCYxYq5PPq3wG/JUaSlNZRcvAZAXSPdM=;
        b=JdhwQAzhZoLnb4FCFEijBaF8YLzOEb50ZdvsLWyejGEJ23QF4UUzRqdIjV1fJTmef6
         /+y0bg81YCyBVd1kxbaNNdzg7S9GGLHbCvnrmgcNJj8uaXqa9v6P0M68IfcJq+n3Ovm8
         Dlf1xNHUUn2cVcMoZpc2xGFPnWfD3kGoY7qGRvvkxmY3ILKDat+1P0jYMR1EvUP6+Qb7
         pgyYPCHgnIfxd6bBJhfXKyBRbDF2iBb4Ikq0yk08WNsY52F1iW/TNjdS/GTI2HO8VD4C
         LsPidJUNYBY5f8GqxKjQw8rVBz1zly5xW9EG5TjZDodzwGX5wBF1BsfS4mtw8rNj8T/k
         uH3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uBqMDvRiGGhkCYxYq5PPq3wG/JUaSlNZRcvAZAXSPdM=;
        b=lnipKkbiitMOA4CeDYxnWw5GhLFG4N2cMOod8vwq0ArUKbwdD8IWmQT0JMvichBjv8
         yGo/IFkg24SlrSmXuJ50DyQtZ1V2FR0vQWLcS+jH6ZepvVTvhxz3vhr7LXoUED22txWO
         vrxARVpN1VMbmsofVFtIBmtdHwDnSFQzt/RHe+kUWQjcihZ/fH/YEfjDcftGlNX4azcN
         5D0om1E+Ye6Kdjh8GfxkWZab2A2LLiqSeyYdieGWYqT6okFWY3x3qN0A2iPmz8P1WV5F
         x3UNcQw0E/x2nn63lcr8k/6TF4tDeTi6oLZy9sCw7jZ4zv34xygTStc836YJxzKLy/np
         tSMw==
X-Gm-Message-State: ANoB5pkKiB3Pc+kc3Orbq845rhWby+45INo9PwREnDsJtZWDj62n3TIS
        Zug+7DtReMxFDzuPcnGUUe0=
X-Google-Smtp-Source: AA0mqf5g7UcKoeKc2suF+JjVGelSelhQNVtMekeURSx6Qp8qcGsa2HYPL+cAsQAsquPDa6hXqGJb6g==
X-Received: by 2002:a17:906:274b:b0:7c1:7183:2d32 with SMTP id a11-20020a170906274b00b007c171832d32mr13082157ejd.56.1671053626819;
        Wed, 14 Dec 2022 13:33:46 -0800 (PST)
Received: from ?IPV6:2a01:c23:b8b1:2700:80c5:d7b3:aee5:57bf? (dynamic-2a01-0c23-b8b1-2700-80c5-d7b3-aee5-57bf.c23.pool.telefonica.de. [2a01:c23:b8b1:2700:80c5:d7b3:aee5:57bf])
        by smtp.googlemail.com with ESMTPSA id ko12-20020a170907986c00b00781be3e7badsm6308968ejc.53.2022.12.14.13.33.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 13:33:46 -0800 (PST)
Message-ID: <c6863a3e-8855-50fe-25cb-0b38bc3a05e0@gmail.com>
Date:   Wed, 14 Dec 2022 22:33:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
To:     Peter Suti <peter.suti@streamunlimited.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <52861a84-0fe2-37f0-d66a-145f2ebe1d79@gmail.com>
 <20221214134620.3028726-1-peter.suti@streamunlimited.com>
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH v3] mmc: meson-gx: fix SDIO interrupt handling
In-Reply-To: <20221214134620.3028726-1-peter.suti@streamunlimited.com>
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

On 14.12.2022 14:46, Peter Suti wrote:
> With the interrupt support introduced in commit 066ecde sometimes the
> Marvell-8987 wifi chip got stuck using the marvell-sd-uapsta-8987
> vendor driver. The cause seems to be that after sending ack to all interrupts
> the IRQ_SDIO still happens, but it is ignored.
> 
> To work around this, recheck the IRQ_SDIO after meson_mmc_request_done().
> 
> Inspired by 9e2582e ("mmc: mediatek: fix SDIO irq issue") which used a
> similar fix to handle lost interrupts.
> 
The commit description of the referenced fix isn't clear with regard to
who's fault it is that an interrupt can be lost. I'd interpret it being
a silicon bug rather than a kernel/driver bug.
Not sure whether it's the case, but it's possible that both vendors use
at least parts of the same IP in the MMC block, and therefore the issue
pops up here too.

> Fixes: 066ecde ("mmc: meson-gx: add SDIO interrupt support")
> 
> Signed-off-by: Peter Suti <peter.suti@streamunlimited.com>
> ---
> Changes in v2:
> 	- use spin_lock instead of spin_lock_irqsave
> 	- only reenable interrupts if they were enabled already
> 
> Changes in v3:
> 	- Rework the patch based on feedback from Heiner Kallweit.
> 		The IRQ does not happen on 2 CPUs and the hard IRQ is not re-entrant.
> 		But still one SDIO IRQ is lost without this change.
> 		After the ack, reading the SD_EMMC_STATUS BIT(15) is set, but 
> 		meson_mmc_irq() is never called again.
> 
> 		The fix is similar to Mediatek msdc_recheck_sdio_irq().
> 		That platform also loses an IRQ in some cases it seems.
> 
>  drivers/mmc/host/meson-gx-mmc.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index 6e5ea0213b47..7d3ee2f9a7f6 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -1023,6 +1023,22 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
>  	if (ret == IRQ_HANDLED)
>  		meson_mmc_request_done(host->mmc, cmd->mrq);
>  
> +	/*
> +	* Sometimes after we ack all raised interrupts,
> +	* an IRQ_SDIO can still be pending, which can get lost.
> +	*

A reader may scratch his head here and wonder how the interrupt can get lost,
and why adding a workaround instead of eliminating the root cause for losing
the interrupt. If you can't provide an explanation why the root cause for
losing the interrupt can't be fixed, presumably you would have to say that
you're adding a workaround for a suspected silicon bug.

> +	* To prevent this, recheck the IRQ_SDIO here and schedule
> +	* it to be processed.
> +	*/
> +	raw_status = readl(host->regs + SD_EMMC_STATUS);
> +	status = raw_status & (IRQ_EN_MASK | IRQ_SDIO);

This isn't needed here. Why not simply:

status = readl(host->regs + SD_EMMC_STATUS);
if (status & IRQ_SDIO)
  ...


> +	if (status & IRQ_SDIO) {
> +		spin_lock(&host->lock);
> +		__meson_mmc_enable_sdio_irq(host->mmc, 0);
> +		sdio_signal_irq(host->mmc);
> +		spin_unlock(&host->lock);
> +	}
> +
>  	return ret;
>  }
>  

