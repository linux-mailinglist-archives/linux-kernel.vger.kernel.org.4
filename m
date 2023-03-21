Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA606C2E2D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 10:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjCUJpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 05:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjCUJpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 05:45:44 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E573E410BB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 02:45:41 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id b20so24256789edd.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 02:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679391940;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X6SgoWSVt/mxNafNwwovZduq0v0LpsxCPiynb3Iq17w=;
        b=O9LUHFo2sGjXyoXhvkxtXaUmGGCueO9wty2JWc6fmqdJ2IsyZ2WlFCOP+fwjPTYmr4
         WAmmeyxd03YN0Eal0YLMQ1JJW+y423ni+4XdRkuljG/vAn6i2yrAT+FLMHBZnoat8z//
         vGrt5z9G8iJC60wXFF7gYXJ4jVMkNkFxhtiyQ9cvBaq8FO4sAdizIngIbKng44rpefiw
         hJiyN8iNECMV2wvzUEA7bzwTwI8ZmaOWtlRRWWPmCoGJ2Vu1cKlJ9sXbeXuTbXTrPJHd
         5McHpQ4O1BzDETxn3rBHjxOWDdLeGermJ/k1eFfzzy0od7d0ZF1Ak/Hf3ytdV+CZUg/8
         6aKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679391940;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X6SgoWSVt/mxNafNwwovZduq0v0LpsxCPiynb3Iq17w=;
        b=ISQ3llSiRiSKUFFrgSgz+800GehCcj/dLudXInad7Q000xwTcjeNGO1gnS5PSKo1p1
         y1kt19IhI12iFI5T6RibCDT3VYJOqRgTalNWE/f80IrTmYBo/H0hOsS23cdEgix94ixq
         tX5WLhEewrOVZhHdwIhT0OCootkiGOQyp/pMehB4k22gnUreIM0haiv+ZyDtRlvVrWnU
         X66xmdX2m+c5zFaPGjNBKHbA2jPKpkMcTFmA0qYxqOCJ8dlJNeilIHQNbIjR1DPvWMwD
         vRWMCp+XH50ZGfmRfytX7CTB/R4MUvTYL+LGIi4rGYoVb74XMv5cnqHR9UBf0V0dwqv0
         qZTA==
X-Gm-Message-State: AO0yUKURl6UDC8jey6+/36muf9uSasQB5y6+shgaGfLoiZGwpKvape7W
        eyXKd/BQoYv3321CkpwVV0YRDA==
X-Google-Smtp-Source: AK7set8mF0hB/qIeBO0Qx7+5SNTe2v1PyPFhN53NUg+3QdtKaH/PSdqbxrnbAEMn36DnuXwGKpJD8g==
X-Received: by 2002:a17:906:6817:b0:8f6:88b7:73a7 with SMTP id k23-20020a170906681700b008f688b773a7mr2243596ejr.7.1679391940435;
        Tue, 21 Mar 2023 02:45:40 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id v14-20020a1709063bce00b0093344ef3764sm3664252ejf.57.2023.03.21.02.45.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 02:45:39 -0700 (PDT)
Message-ID: <6601cd6f-5fab-a6a7-2f1e-d3604f729efd@linaro.org>
Date:   Tue, 21 Mar 2023 09:45:38 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] misc: fastrpc: return -EPIPE to invocations on device
 removal
Content-Language: en-US
To:     Richard Acayan <mailingradian@gmail.com>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Escande <thierry.escande@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230130222716.7016-1-mailingradian@gmail.com>
 <20230130222716.7016-2-mailingradian@gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230130222716.7016-2-mailingradian@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/01/2023 22:27, Richard Acayan wrote:
> The return value is initialized as -1, or -EPERM. The completion of an
> invocation implies that the return value is set appropriately, but
> "Permission denied" does not accurately describe the outcome of the
> invocation. Set the invocation's return value to a more appropriate
> "Broken pipe", as the cleanup breaks the driver's connection with rpmsg.
> 
> Fixes: c68cfb718c8f ("misc: fastrpc: Add support for context Invoke method")
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> ---

LGTM, thanks for fixing this,

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


--srini
>   drivers/misc/fastrpc.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 7ccaca1b7cb8..2334a4fd5869 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -2337,8 +2337,10 @@ static void fastrpc_notify_users(struct fastrpc_user *user)
>   	struct fastrpc_invoke_ctx *ctx;
>   
>   	spin_lock(&user->lock);
> -	list_for_each_entry(ctx, &user->pending, node)
> +	list_for_each_entry(ctx, &user->pending, node) {
> +		ctx->retval = -EPIPE;
>   		complete(&ctx->work);
> +	}
>   	spin_unlock(&user->lock);
>   }
>   
