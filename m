Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2674D73A534
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 17:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbjFVPjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 11:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbjFVPjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 11:39:11 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA77D193
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 08:39:07 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f90b8acefdso49813455e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 08:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687448346; x=1690040346;
        h=content-transfer-encoding:in-reply-to:subject:organization
         :references:cc:to:content-language:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/TTIQo7RQLmeRtc0cFEhWudyxQbqgwfYT0QcYRBzTlw=;
        b=qwIwMaIGrZdH8DISKNqxbDajZkozvwFC/cGwPz/KQq72/zst4rPaPTAe+vNrDDmul9
         f5dH1H7LqvoYWSokLHuVVpy87m4qo+UndpOfoOsC1DcZd0FVxlcO+cWryXMzFEIzq1tq
         /L41YUcuwemLWhJJJ/4I+KxWBJRjr9ro0UmRgl1PaDBZS137tcQvzul4xEqyRYWh7yvF
         DN9ZM/H4do8QvaluIdeaTbpuXxmN4oxms2yPAs4JwrKN0R8pC73VADjpnPi2dmdBNeFx
         bFfRp9IAnRsFBmY39uzsnadmr5XNaWAvHMBbzJF7TXJDs3GgAejU0O61FGJ8T2lfouEe
         8UsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687448346; x=1690040346;
        h=content-transfer-encoding:in-reply-to:subject:organization
         :references:cc:to:content-language:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/TTIQo7RQLmeRtc0cFEhWudyxQbqgwfYT0QcYRBzTlw=;
        b=UtlVABnf4NNGLuYsfT6fozqffZtJr/+0/N1vM2m5ddmXGX1tcrTREBKSskDH0alMBR
         bWKTIq0eUCSGF0CsdXv/d3x7Zf77oh979pf0CGvwMrSA4r+or2beMO2wN0WbQd0ZQgQ/
         PX0kPVAYffXkYQwzJXPBn234ZM9GT0HJ8yez3CJt1EdQeE6Sd712Wjf7MOHOx/GzzXk2
         uYNByvylex8U8KFmXqoZUKPQfjPqc5L45lU+ZFUHsXnOOdhB6XLbTNdI68iqRgV6BTBP
         j9IDm1eHeHZxh+WmmUMvj9bGAYeP0oVoe/EH9VBYzTnqsxuHKUcaqA7Xw7s8+W45eQxQ
         NCbw==
X-Gm-Message-State: AC+VfDzvEX4BsmfLg8BvpZF5sH0A+lnc/pybQDmDG1bfCoMK7bpzxRFz
        eybQKx44J4PQRssYxAlzmZrkr4FWsE3MeK1XsKgvPA==
X-Google-Smtp-Source: ACHHUZ5IVlN9nvimZC0AgCo+wvYzCtbd2bGkr5HIzv4AYqE7G3whHBT7GsXhqGbXiGaB7E7/o2IACw==
X-Received: by 2002:a7b:c3d2:0:b0:3f7:a552:2ec7 with SMTP id t18-20020a7bc3d2000000b003f7a5522ec7mr13495816wmj.33.1687448346301;
        Thu, 22 Jun 2023 08:39:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:f692:a800:4794:385? ([2a01:e0a:982:cbb0:f692:a800:4794:385])
        by smtp.gmail.com with ESMTPSA id l16-20020a1c7910000000b003f9bdf60b34sm4743793wme.11.2023.06.22.08.39.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 08:39:05 -0700 (PDT)
Message-ID: <9c52ce87-f69c-e69c-ec43-6b2cc3b37c4a@linaro.org>
Date:   Thu, 22 Jun 2023 17:39:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230622101813.3453772-1-arnd@kernel.org>
 <286cf2d8-2da8-7203-ee53-bf08332fa519@linaro.org>
 <f28f78fc-84ce-4990-9126-4075f3d88e01@app.fastmail.com>
Organization: Linaro Developer Services
Subject: Re: [PATCH] usb: typec: nb7vpq904m: add CONFIG_DRM dependency
In-Reply-To: <f28f78fc-84ce-4990-9126-4075f3d88e01@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 22/06/2023 13:24, Arnd Bergmann wrote:
> On Thu, Jun 22, 2023, at 12:39, Neil Armstrong wrote:
>> Hi,
>>
>> On 22/06/2023 12:18, Arnd Bergmann wrote:
>>> From: Arnd Bergmann <arnd@arndb.de>
>>>
>>> This driver calls directly into DRM functions and fails to link if
>>> that is disabled:
>>>
>>> ld.lld: error: undefined symbol: devm_drm_bridge_add
>>> ld.lld: error: undefined symbol: devm_drm_of_get_bridge
>>>>>> referenced by nb7vpq904m.c
>>>>>>                 drivers/usb/typec/mux/nb7vpq904m.o:(nb7vpq904m_probe) in archive vmlinux.a
>>>
>>> Fixes: 88d8f3ac9c67e ("usb: typec: add support for the nb7vpq904m Type-C Linear Redriver")
>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>> ---
>>>    drivers/usb/typec/mux/Kconfig | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/usb/typec/mux/Kconfig b/drivers/usb/typec/mux/Kconfig
>>> index 8c4d6b8fb75c3..f53ae24b6c048 100644
>>> --- a/drivers/usb/typec/mux/Kconfig
>>> +++ b/drivers/usb/typec/mux/Kconfig
>>> @@ -37,7 +37,7 @@ config TYPEC_MUX_INTEL_PMC
>>>    
>>>    config TYPEC_MUX_NB7VPQ904M
>>>    	tristate "On Semiconductor NB7VPQ904M Type-C redriver driver"
>>> -	depends on I2C
>>> +	depends on I2C && DRM
>>>    	select REGMAP_I2C
>>>    	help
>>>    	  Say Y or M if your system has a On Semiconductor NB7VPQ904M Type-C
>>
>> I think it could be :
>>
>> +	depends on DRM || DRM=n
>> +	select DRM_PANEL_BRIDGE if DRM
> 
> As far as I can tell, this would only avoid the link error
> against devm_drm_of_get_bridge(), but not the one against
> devm_drm_bridge_add(), which is defined in drm.ko through
> drivers/gpu/drm/drm_bridge.c.

I'm trying to reproduce such situation, but so fail I fail.

In the driver there's a guard to avoid calling into DRM functions
when disabled:
#if IS_ENABLED(CONFIG_OF) && IS_ENABLED(CONFIG_DRM_PANEL_BRIDGE)

so I wonder which kind on config leaded to that since
CONFIG_DRM_PANEL_BRIDGE is only enabled when DRM_PANEL and DRM are.

Neil

> 
>      Arnd

