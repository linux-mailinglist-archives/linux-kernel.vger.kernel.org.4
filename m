Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFB66FDFD7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 16:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237355AbjEJOT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 10:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232424AbjEJOT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 10:19:26 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12F730CD;
        Wed, 10 May 2023 07:19:23 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f195b164c4so48299385e9.1;
        Wed, 10 May 2023 07:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683728362; x=1686320362;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=weRq9/Oz7hsyRYpzT9X4irjExY0OdiEXcbsBvXDXnv0=;
        b=oi+tsWEn2QGAjWjNTJkbhMpYS5G/sRYnlKkP3oaNgOO2ahOe6j2zjb1zzzDbKHMw4U
         11bVu7SyMPLxoyeIe0Z02y5ILi9PZ7X3l4cLSG4NgbizHVYav9Id8DifaMppfzv8L1KZ
         C/w5vorYkLjEsOjm8s4zbw5d9ao0iKyjmLQ8WmDkI3yqbao0Z7/TH4/0Pykr/yGGQ2n+
         zNACHjzkTtC63wr+EoeCuJzJZeBt64WLVYkGESgjctfXKeAkEB0fmlU6fVVJUhawBqiI
         HjhHXEd54blsmIa9cfV5bGvZuTEtCsni5nvvxRFdvvmKLq4SVRqio5BBvzvNh5JqmZgs
         zf+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683728362; x=1686320362;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=weRq9/Oz7hsyRYpzT9X4irjExY0OdiEXcbsBvXDXnv0=;
        b=V0P60t/s4SYJWRgkOLTjCCEjfcB/uX5zlBcc2L06uIwRYNVPQbvP6FlhNfqBuYDh9+
         h6hS3XnwqDZJTOMcyWfwLjBl1n7TjQTKJC2TnaGKto306qsknCleyScj+PTh69bU88e6
         PPRPrW3Per93EUgQio0+ruJXkPXM6pleY7bXh3vX2SRWM60J0Ord1xSJniqj1HC57MER
         mjvIyblf4qrGkp7gMy2PMK1KqkE1w2/LVEJJ1nvmUeXb6/IYn1pmfUFfpRLOVKKmX1EJ
         /shJnLdfaFg/IbPdxNWas5RVcbC7SjGkKIbcgcRzdozNK1Bv179PXdZ+F6PzHENhwHxd
         QHrg==
X-Gm-Message-State: AC+VfDyq/xngP6C4AJxfFTjloVPRVg/BIKAzjUZZXWKKTsgdc+ttPJsZ
        oO7qNZ8YZS7tP6ivrPJ8FtHhYV/40DOrQA==
X-Google-Smtp-Source: ACHHUZ690jlp38DMo0H91xICFaqGrysfxpaSisKMzpYRNVlnL9cLWYGNX5hehfwVFwuVkujpUbNS1g==
X-Received: by 2002:a05:600c:2103:b0:3f4:2cc3:2623 with SMTP id u3-20020a05600c210300b003f42cc32623mr3991733wml.22.1683728361975;
        Wed, 10 May 2023 07:19:21 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id h1-20020a5d5481000000b0030647d1f34bsm17697603wrv.1.2023.05.10.07.19.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 07:19:20 -0700 (PDT)
Message-ID: <423c7e0b-95d7-8389-02fc-6dd5ef215e93@gmail.com>
Date:   Wed, 10 May 2023 16:19:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] mmc: mediatek: Avoid ugly error message when SDIO wakeup
 IRQ isn't used
To:     Douglas Anderson <dianders@chromium.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Yong Mao <yong.mao@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org
References: <20230510064434.1.I935404c5396e6bf952e99bb7ffb744c6f7fd430b@changeid>
Content-Language: en-US, ca-ES, es-ES
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230510064434.1.I935404c5396e6bf952e99bb7ffb744c6f7fd430b@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/05/2023 15:44, Douglas Anderson wrote:
> When I boot a kukui-kodama board, I see an ugly warning in my kernel
> log:
>    mtk-msdc 11240000.mmc: error -ENXIO: IRQ sdio_wakeup not found
> 
> It's pretty normal not to have an "sdio_wakeup" IRQ defined. In fact,
> no device trees in mainline seem to have it. Let's use the
> platform_get_irq_byname_optional() to avoid the error message.
> 
> Fixes: 527f36f5efa4 ("mmc: mediatek: add support for SDIO eint wakup IRQ")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
> 
>   drivers/mmc/host/mtk-sd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index edade0e54a0c..8ce864169986 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -2707,7 +2707,7 @@ static int msdc_drv_probe(struct platform_device *pdev)
>   
>   	/* Support for SDIO eint irq ? */
>   	if ((mmc->pm_caps & MMC_PM_WAKE_SDIO_IRQ) && (mmc->pm_caps & MMC_PM_KEEP_POWER)) {
> -		host->eint_irq = platform_get_irq_byname(pdev, "sdio_wakeup");
> +		host->eint_irq = platform_get_irq_byname_optional(pdev, "sdio_wakeup");
>   		if (host->eint_irq > 0) {
>   			host->pins_eint = pinctrl_lookup_state(host->pinctrl, "state_eint");
>   			if (IS_ERR(host->pins_eint)) {
