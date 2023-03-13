Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D4B6B7071
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 08:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjCMHxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 03:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjCMHwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 03:52:51 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE94451F8F;
        Mon, 13 Mar 2023 00:52:19 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id t14so11634168ljd.5;
        Mon, 13 Mar 2023 00:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678693930;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DP22K4i2hvSQUMj03mmf1nrlTT4nDZqslXzw3b5STVg=;
        b=mq4CVXLbEPFpKdmBnLa+DaPZzaB+5PUIR1eMjh/S3fQORQr+7borK30x1Sezcwvn3h
         GURCYNkzr8nsUL31CT/9nX7UJ2u4sA8psHIJrab55dBjZPCFypFurmSJrIPqiUwafkLy
         nXiFnALJjYOqNPU7FDabiJDarRrua8EmKrWRNxfQW0/fUC7XRZasBI2sBxy5KXjs3WYs
         9A5BAyxpxFw4SzRZI7Wm3Exmv5L20yk1Zr7GmrR4Y8aG5l4BnQOiYOAt+rNw6COZSI0a
         e5dkLHtYSuFhxNBxcFuu3+mEQNiv1ECxluOgUyxUTx2Cfr8EuDNd70C0MyzOlD3ZwZ1I
         v8fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678693930;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DP22K4i2hvSQUMj03mmf1nrlTT4nDZqslXzw3b5STVg=;
        b=Ux67mV44g0E8te8tXR1aJsgnrRGWgAMYcH8umwDl/j5S/rcWiQkSo4iF75uVTgqUAu
         Q3GkMA8LxHDNBkjlSII+FliKwRedARGCUsA1mDf80n5x1DPrZx7AfrJdgCPPAmF4ok11
         AWyLQQhIaEDTfCmFbXZByV12DRnNxGamUE/h26+MNa/PiMsAX3qc8qp42DyDeXLH8op0
         dvRdbTy8xRMVXno+toYCOD6XhrEQywKCD7hdS+EI+RaZ/toS1Jg8OWhHxtULUUz3GR7J
         eSorgHGx87BUgkeOtoyVjnLC6PtkUNc9QmYgciCr0tO23ALlGCa1fMiKR+frYSq6JrOq
         GNWA==
X-Gm-Message-State: AO0yUKU04eH0GSUSzTYr1zYSTO4zbgXYPOKhwnurMGEzRAcF3ShMXd7l
        zcFCsUWFsw3qkVrdwB4/shs=
X-Google-Smtp-Source: AK7set+fCZnioNoLHXd86gA5fdj9retwzd09OegGlbQGd8saON8iHEbmrTCRWzvBpZhUxZqO/WFw2w==
X-Received: by 2002:a2e:99c4:0:b0:293:4d57:7148 with SMTP id l4-20020a2e99c4000000b002934d577148mr10265826ljj.11.1678693930688;
        Mon, 13 Mar 2023 00:52:10 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::6? (dc75zzyyyyyyyyyyyyydy-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::6])
        by smtp.gmail.com with ESMTPSA id v10-20020a2ea44a000000b002986d9bdecesm912257ljn.129.2023.03.13.00.52.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 00:52:10 -0700 (PDT)
Message-ID: <e07c2fbf-6432-0065-3e68-aeac2ee51799@gmail.com>
Date:   Mon, 13 Mar 2023 09:52:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCHv1 04/11] power: supply: generic-adc-battery: fix unit
 scaling
Content-Language: en-US, en-GB
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230309225041.477440-1-sre@kernel.org>
 <20230309225041.477440-5-sre@kernel.org>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20230309225041.477440-5-sre@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/23 00:50, Sebastian Reichel wrote:
> power-supply properties are reported in µV, µA and µW.
> The IIO API provides mV, mA, mW, so the values need to
> be multiplied by 1000.
> 
> Signed-off-by: Sebastian Reichel <sre@kernel.org>

As Linus wrote, Fixes-tag would be good. With that remark:
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

> ---
>   drivers/power/supply/generic-adc-battery.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/power/supply/generic-adc-battery.c b/drivers/power/supply/generic-adc-battery.c
> index 917bd2a6cc52..535972a332b3 100644
> --- a/drivers/power/supply/generic-adc-battery.c
> +++ b/drivers/power/supply/generic-adc-battery.c
> @@ -136,6 +136,9 @@ static int read_channel(struct gab *adc_bat, enum power_supply_property psp,
>   			result);
>   	if (ret < 0)
>   		pr_err("read channel error\n");
> +	else
> +		*result *= 1000;
> +
>   	return ret;
>   }
>   

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

