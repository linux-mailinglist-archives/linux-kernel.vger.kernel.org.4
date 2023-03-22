Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14ABB6C460B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 10:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjCVJSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 05:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjCVJSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 05:18:06 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD9E4EDA;
        Wed, 22 Mar 2023 02:18:04 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 20so11010634lju.0;
        Wed, 22 Mar 2023 02:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679476683;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SvinzVyNJiyQo6/rtiAuowUYxIvCos71YoiDmTjL/Qk=;
        b=OIWLhGHxCwXaa7ZyCKqtipBQT+vOZctj9NR3I8m3AHjmQ40j+nRaW8dmTlEMp4eFE1
         nL7qjzLwKO1+TlEs0m0nHtvL/iXdBnRdwgqUEHWrPxUQk4lFOEcR4VUj057z0FHCGKOl
         cRRFQ1lJWA1Rd5oXsjzbVYF+txGEe7sOt3qUmMNFtmggrYRnTxHkXlx1+b003zqPVMg2
         +V62u7t5P3GttkUuBjla8iJRo3m7xVmEyCSuuDvE3cDOHXvrHah2D1lzuiYX5WVjnkrV
         2VXBB5tBZr9oDIVlcd3I44b32yTvDQRHuxUR77Z3XVhpJ6nTRXEF8b3rmzaUFJFXeIFX
         tQeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679476683;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SvinzVyNJiyQo6/rtiAuowUYxIvCos71YoiDmTjL/Qk=;
        b=1cBYsmvP9rWUacxeVgBs3T4NtIGLSDxysdbvJRLuHq1pC1cSU8tfX0tVr5TBscLfny
         XuMlI1a6yP7uasjbYhUCVS/3cf/gi8c6vEPFYC6+gTlGFcRIqL7q4umqugWarR0UyhpD
         XeOI8rGF90WsDtBJhF0gx1ZdIArGKJNkVvlL5uSCqiYkJWFAT7RAmGOw5qXDdaPVDc1T
         4jWULfaKhIk53n+DrAZXyTXLxaGIuR/H5HGs7CTWvZOJNtRh8MTku3Tbwn7FoGn6XH3v
         g0L39kceyQzN3qFoi4RUkeXgEm+NYuVaSBCTTvvInZ9w4U8xHXaBsN/+A0Fpdtg06uSu
         hIuw==
X-Gm-Message-State: AO0yUKVEYgNosfDQe9oYQRu4aNW4hlOqHZvX1POvog+A2uq4HmX4a7SU
        ayX0JWnFSbw09ZktpnpbaN5IIE0CaME=
X-Google-Smtp-Source: AK7set99SU5cwyvIU1CHZm+733XfDGBLKh7eHhaiwnkPd5sQbUOuEvbz3WiLSbF0Ni4xm4PePrOZZg==
X-Received: by 2002:a2e:3014:0:b0:295:a930:6a59 with SMTP id w20-20020a2e3014000000b00295a9306a59mr1780584ljw.6.1679476682878;
        Wed, 22 Mar 2023 02:18:02 -0700 (PDT)
Received: from [192.168.1.103] ([178.176.72.74])
        by smtp.gmail.com with ESMTPSA id w2-20020a2e8202000000b00295a7f35206sm2542069ljg.48.2023.03.22.02.18.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 02:18:02 -0700 (PDT)
Subject: Re: [PATCH] mmc: jz4740: Use dev_err_probe()
To:     ye.xingchen@zte.com.cn, ulf.hansson@linaro.org
Cc:     paul@crapouillou.net, linux-mips@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <202303221707010277273@zte.com.cn>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <d91d6e3c-da8c-0601-0cd7-45bfe7c4ad50@gmail.com>
Date:   Wed, 22 Mar 2023 12:18:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <202303221707010277273@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/23 12:07 PM, ye.xingchen@zte.com.cn wrote:

> From: Ye Xingchen <ye.xingchen@zte.com.cn>
> 
> Replace the open-code with dev_err_probe() to simplify the code.
> 
> Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
> ---
>  drivers/mmc/host/jz4740_mmc.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
> index 698450afa7bb..a6ad03b24add 100644
> --- a/drivers/mmc/host/jz4740_mmc.c
> +++ b/drivers/mmc/host/jz4740_mmc.c
> @@ -232,10 +232,7 @@ static int jz4740_mmc_acquire_dma_channels(struct jz4740_mmc_host *host)
>  	if (!IS_ERR(host->dma_tx))
>  		return 0;
> 
> -	if (PTR_ERR(host->dma_tx) != -ENODEV) {
> -		dev_err(dev, "Failed to get dma tx-rx channel\n");
> -		return PTR_ERR(host->dma_tx);
> -	}
> +	return dev_err_probe(dev, PTR_ERR(host->dma_tx), "Failed to get dma tx-rx channel\n");

   I'm afraid this makes the following code unreachable...

> 
>  	host->dma_tx = dma_request_chan(mmc_dev(host->mmc), "tx");
>  	if (IS_ERR(host->dma_tx)) {

MBR, Sergey
