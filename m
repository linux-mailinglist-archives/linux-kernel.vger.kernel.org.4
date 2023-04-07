Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C270E6DB6DF
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 01:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjDGXIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 19:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjDGXIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 19:08:10 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DFAE069;
        Fri,  7 Apr 2023 16:08:05 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1841c57c221so2222379fac.3;
        Fri, 07 Apr 2023 16:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680908884; x=1683500884;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=0F6rJsxE3aamYqBv3Ml8xVL2zDyuJMNH53v8qppkKDk=;
        b=VcAN/MwiTqf4yUVTPyCDBbwDfHPWwi1LQ8Aym/RCEG7rZYuQaokxcWDbKiTnvaeDJb
         s4pTG5n6QjYqlvupI/nhdGEhvjALJ8cP/h8IPizp5pLNKAYyRHO8tsMCsT8Hqkx3diBZ
         iFA37dWnw7W2+STHpKDZvrFqIYga9zEElqQlk29ncB92zYhXYowN8ft3pU95OVaUuubv
         3ic05wNoHC7c7UL68PWbnf2FDbwmnKT0od7QUkugOoL+dGo8WBfLhCT/vUYIQclPMWnZ
         961J07OYKuiCEI2Eot/xbBDcI7SAm2dB/GQJ0LGAPpnO8WVqRhZCav4AcDDBGgHNiYOZ
         T3Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680908884; x=1683500884;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0F6rJsxE3aamYqBv3Ml8xVL2zDyuJMNH53v8qppkKDk=;
        b=RjUlYBUjw+z+t5qdST2ljpkUTtqgltFiXR82EjCPbCehCSVRiEZznvpbu1zQBYRbbi
         UwSAypVk7XIvKldR3ZGGfQrZAm30aVNynqKVKUz5YLQ48pLSocfkQ062LboB0oodsDC8
         mFnVWAMOAoCC2EcPFJR+jmAwMpjECMTvFt15n8GGZa55p7OEHXgqBj8Optz99EYJU+7j
         Le43BBVWzlf8XKvmfdFPaXqBpiy4HJtReCBNEOHGK7BkmME1zj0k/4lSVSDkDhqaOzpm
         qFQoSVS0+ES7TY5+KoHdp0KwqfYuApWd6Ma4wNNY7qNQHoJ9xEyCKZBFpbxvltbNeX1w
         jn8Q==
X-Gm-Message-State: AAQBX9cLqmazLCtsW04JNMz57oLZHkpuy9PqNTV/QnOi6i+or00h+rHV
        F6gOEuvzGE/5QJUtcySTaOc=
X-Google-Smtp-Source: AKy350ZF+lqnJCB/1jdRyLyjGIXwaAzcAR5fESlrxZmmS/aaHiJKvHSFKr3KvKIZxgPkrUbr/0STBw==
X-Received: by 2002:a05:6870:64a6:b0:184:2b9d:2b12 with SMTP id cz38-20020a05687064a600b001842b9d2b12mr141951oab.13.1680908884279;
        Fri, 07 Apr 2023 16:08:04 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k1-20020a9d7dc1000000b0069fb8bfb4f3sm2047277otn.77.2023.04.07.16.08.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Apr 2023 16:08:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <0a9cc901-9634-6fd0-eade-7a512631c62a@roeck-us.net>
Date:   Fri, 7 Apr 2023 16:08:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] media: i2c: video: constify pointers to
 hwmon_channel_info
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
References: <20230407150015.79715-1-krzysztof.kozlowski@linaro.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230407150015.79715-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/23 08:00, Krzysztof Kozlowski wrote:
> Statically allocated array of pointed to hwmon_channel_info can be made
> const for safety.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> This depends on hwmon core patch:
> https://lore.kernel.org/all/20230406203103.3011503-2-krzysztof.kozlowski@linaro.org/
> 
> Therefore I propose this should also go via hwmon tree.
> 

I am not going to apply patches for 10+ subsystems through the hwmon tree.
This can only result in chaos. The dependent patch is available at

git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-const

or wait until after the next commit window to apply this patch.

Thanks,
Guenter

> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-hwmon@vger.kernel.org
> ---
>   drivers/media/i2c/video-i2c.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/i2c/video-i2c.c b/drivers/media/i2c/video-i2c.c
> index dddf9827b314..abd472dcd497 100644
> --- a/drivers/media/i2c/video-i2c.c
> +++ b/drivers/media/i2c/video-i2c.c
> @@ -274,7 +274,7 @@ static const struct hwmon_channel_info amg88xx_temp = {
>   	.config = amg88xx_temp_config,
>   };
>   
> -static const struct hwmon_channel_info *amg88xx_info[] = {
> +static const struct hwmon_channel_info * const amg88xx_info[] = {
>   	&amg88xx_temp,
>   	NULL
>   };

