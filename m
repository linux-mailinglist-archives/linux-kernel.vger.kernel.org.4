Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B3A60523C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 23:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbiJSVvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 17:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiJSVvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 17:51:08 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D592E161FC3;
        Wed, 19 Oct 2022 14:51:07 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id m81so20818457oia.1;
        Wed, 19 Oct 2022 14:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ABNNnqtZNxuF6VlncFXZkkBSAIWL/7Dr/Oxp8PF+xog=;
        b=BXyNIQpkIfqU55IqfFJRSa6S+VqAsbrgMAt8/UXHYvUk03TLj7Kze6Y5tt+VxCnw6Q
         f8FfzO2XKnZ2o+2VWK3+r+QDVeKYkMUX/dHM4qMFmsqlbryzY/WIRje3KN+ihzBgOWHc
         wIHIYDhdohbQYDtpSFzVx3uSSKIcnAB8KkmfwakhJPLxyq8KXm2c2gethIsRhpUhvgOX
         p88V7wyS4LPGZj0unWUoouCkExh2JYyTuripcH1I+RYS/Cl6eX/ialQ1CkKiwriKLHII
         6Ip+dQsqyNo8pFT69fJ6Pw/41+SsJ/wERll6Ij3vXKpYDXXSxdpCqdrqkIordj30FDY0
         fPrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ABNNnqtZNxuF6VlncFXZkkBSAIWL/7Dr/Oxp8PF+xog=;
        b=BQEcQG60lGugjTiAm8QRThPhRE2En1Ice9hG52zU3FQsxGDeKo1nGTkjwrpLUtPnvn
         rmWCQiSaTQ8reu2njaC/D1035kHP+S9ddnu0CqOlpEeMfoLKCmMoLxkBK8SXOZZx8/g9
         /dXmgaAlUrBFHt/4wIwFOER8yWGC71ejnmml37jL2B8t79aHFGACMKYdxwiYX2ovduqF
         Vp/E/HlIbH2euh8WeSjjhoDORly8+MthGHEqPFS5bcVLi7z38d4Q88isytOFjEjwcDdP
         U2dCYutTBVDgXVfhtMwG+WSqnp3qUmGLqYaullynsg10MjKQpksMlxDsL52L3jMgotUL
         a12g==
X-Gm-Message-State: ACrzQf1DGvuZlDHXaLuBnNJrw65ilJ84vTYtx6COnuXgjzjhagy8RUqX
        e/Jh0OtyAyUTCz8MKkVw8JE=
X-Google-Smtp-Source: AMsMyM5NeQWFcsgWUWIo67Wa773CwI18mDjG9WjNaKa8VGao2IY7nb/wNeUHTjGm2s1LEBlqgaKrVw==
X-Received: by 2002:a05:6808:a8b:b0:355:385d:e51e with SMTP id q11-20020a0568080a8b00b00355385de51emr5002668oij.117.1666216267169;
        Wed, 19 Oct 2022 14:51:07 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i20-20020a9d6254000000b00661d4e012d6sm7692676otk.20.2022.10.19.14.51.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 14:51:06 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <0d1b4fed-7ded-88fc-3c37-4f859fc505c1@roeck-us.net>
Date:   Wed, 19 Oct 2022 14:51:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] hwmon: (jc42) Restore the min/max/critical temperatures
 on resume
Content-Language: en-US
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-hwmon@vger.kernel.org
Cc:     jdelvare@suse.com, linux-kernel@vger.kernel.org
References: <20221019214108.220319-1-martin.blumenstingl@googlemail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20221019214108.220319-1-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/22 14:41, Martin Blumenstingl wrote:
> The JC42 compatible thermal sensor on Kingston KSM32ES8/16ME DIMMs
> (using Micron E-Die) is an ST Microelectronics STTS2004 (manufacturer
> 0x104a, device 0x2201). It does not keep the previously programmed
> minimum, maximum and critical temperatures after system suspend and
> resume (which is a shutdown / startup cycle for the JC42 temperature
> sensor). This results in an alarm on system resume because the hardware
> default for these values is 0°C (so any environment temperature greater
> than 0°C will trigger the alarm).
> 
> Example before system suspend:
>    jc42-i2c-0-1a
>    Adapter: SMBus PIIX4 adapter port 0 at 0b00
>    temp1:        +34.8°C  (low  =  +0.0°C)
>                           (high = +85.0°C, hyst = +85.0°C)
>                           (crit = +95.0°C, hyst = +95.0°C)
> 
> Example after system resume (without this change):
>    jc42-i2c-0-1a
>    Adapter: SMBus PIIX4 adapter port 0 at 0b00
>    temp1:        +34.8°C  (low  =  +0.0°C)             ALARM (HIGH, CRIT)
>                           (high =  +0.0°C, hyst =  +0.0°C)
>                           (crit =  +0.0°C, hyst =  +0.0°C)
> 
> Apply the previously read or previously programmed temperature limits on
> system resume. This fixes the alarm due to the hardware defaults of 0°C
> because the previously applied limits (from a userspace setting) are
> re-applied on system resume.
> 
> Fixes: 175c490c9e7f ("hwmon: (jc42) Add support for STTS2004 and AT30TSE004")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
> This is my first change to jc42. I tried to be defensive with applying
> the previous values by only configuring them if they are known valid. I
> only have this one set of JC42 compatible sensors but I can adapt the
> code here based on your suggestions.
> 
> 
>   drivers/hwmon/jc42.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/hwmon/jc42.c b/drivers/hwmon/jc42.c
> index 30888feaf589..f98b28ff10ad 100644
> --- a/drivers/hwmon/jc42.c
> +++ b/drivers/hwmon/jc42.c
> @@ -558,6 +558,19 @@ static int jc42_resume(struct device *dev)
>   	data->config &= ~JC42_CFG_SHUTDOWN;
>   	i2c_smbus_write_word_swapped(data->client, JC42_REG_CONFIG,
>   				     data->config);
> +
> +	if (data->valid || data->temp[t_min])

This contradicts "with applying the previous values by only configuring
them if they are known valid". It explicitly applies the values if they
are marked as not valid, and it also applies the values if they are 0
(I don't really see the value of doing that).

Sorry, I don't understand the logic. Did you mean to use "&&" instead
of "||" ?

Thanks,
Guenter

> +		i2c_smbus_write_word_swapped(data->client, temp_regs[t_min],
> +					     data->temp[t_min]);
> +
> +	if (data->valid || data->temp[t_max])
> +		i2c_smbus_write_word_swapped(data->client, temp_regs[t_max],
> +					     data->temp[t_max]);
> +
> +	if (data->valid || data->temp[t_crit])
> +		i2c_smbus_write_word_swapped(data->client, temp_regs[t_crit],
> +					     data->temp[t_crit]);
> +
>   	return 0;
>   }
>   

