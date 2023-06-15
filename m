Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD09C7311FD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 10:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243509AbjFOIVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 04:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244295AbjFOIUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 04:20:43 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A202700
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 01:20:38 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f841b7a697so809761e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 01:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686817237; x=1689409237;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XMlsfgZLwaFXb+N9g5o4MdTI3z1v0qvGTnWntiOQBao=;
        b=oSIC7GffKE130lUEj4jrKtsYhelzdq6evUtya19QotqoHDz7V60LQyUuZIoYUCCDnN
         iCTeT9nwOGybArYq1Z9gt8KhsFMWgR6g4uyFQs7McQiY/Jvl/Kd/egY/9xFzeUzXeiYZ
         zHC+HHUos5I2qQr2t9EohcScyOtKhGFmxh1fUhYhYjXG+KkpQf5eaHTXKI7ahZLJVdz0
         3kNTxX1KXjScNjjbIQzSraeTnNubYv+rEjUfkJyhIbLYM+2Bmlp1SfKOS8qsOgFyiRZc
         sxKO7ERFEYXzMldGFJjibwPKPN2416w8YKmyQdAtbmIpxkSUPtO740gP7tNUpyc8+o8V
         IpOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686817237; x=1689409237;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XMlsfgZLwaFXb+N9g5o4MdTI3z1v0qvGTnWntiOQBao=;
        b=JzLh89PhcCTpOA0hg6xgQwFziMPaDIhEKhGPljQfZTVFzlUg/MTcVQWV2Z87wagGqJ
         dH0RoyNZR+u2pHCkWRWb5g4mbW2cC5MDqngBX5lJnPPyfJvP67x85dyYzgC1t/BvwrSd
         c3pY3LRY0PSvBN2Gu1T6ACNQwddJBbyhpqFRLahVUBWm0FP1wxxfyWhfarQ1Z0oHdoIo
         8PWqnlNzm2BwK6d9Kvx7jz2FRyOoGnOnCt0Z2+HYouGeWBG7oXSvQ+Gg6663LQwUgEcS
         fh64bSKxMjxOjHWBAn5TIXlIY303lj2zwQgv7R2YlHfgxRBHTY12CcEe3Qp80EFpGZDy
         Vk9Q==
X-Gm-Message-State: AC+VfDyIjL3XyNUnUdR3Yp4roRrXmUijimwE45aXB9KD/WDDSPgGJ1xt
        Kbi68mWdBh0iMomH3w9khccKHA==
X-Google-Smtp-Source: ACHHUZ5Nj3PdGNxt6Ji0K419vClPI6VhoNUfiucjsLCBZbaYz1Dm29Yg3AjeJRc312tcPz4Gf4guSQ==
X-Received: by 2002:a19:770b:0:b0:4ec:a18e:f989 with SMTP id s11-20020a19770b000000b004eca18ef989mr7620536lfc.17.1686817237041;
        Thu, 15 Jun 2023 01:20:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:f60a:f5e3:7ae:6745? ([2a01:e0a:982:cbb0:f60a:f5e3:7ae:6745])
        by smtp.gmail.com with ESMTPSA id t11-20020a7bc3cb000000b003f60eb72cf5sm19826825wmj.2.2023.06.15.01.20.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 01:20:36 -0700 (PDT)
Message-ID: <436d1428-9135-d207-7004-82713b015775@linaro.org>
Date:   Thu, 15 Jun 2023 10:20:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH RFC 4/4] input: touchscreen: add SPI support for Goodix
 Berlin Touchscreen IC
Content-Language: en-US
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230606-topic-goodix-berlin-upstream-initial-v1-0-4a0741b8aefd@linaro.org>
 <20230606-topic-goodix-berlin-upstream-initial-v1-4-4a0741b8aefd@linaro.org>
 <ZIaRoTHar/s5yZAh@nixie71> <a87160e5-b895-3dae-bba0-94fc67c92679@linaro.org>
 <ZIdQ723G8/a0tNEZ@nixie71>
Organization: Linaro Developer Services
In-Reply-To: <ZIdQ723G8/a0tNEZ@nixie71>
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

On 12/06/2023 19:07, Jeff LaBundy wrote:
> Hi Neil,
> 
> [...]
> 
>>>> +static const struct input_id goodix_berlin_spi_input_id = {
>>>> +	.bustype = BUS_SPI,
>>>> +	.vendor = 0x0416,
>>>> +	.product = 0x1001,
>>>
>>> After having seen these in the I2C counterpart; consider defining them
>>> in goodix_berlin.h.
>>
>> To be honest, I blindly copied it from goodix.c because the vendor
>> driver puts random values here.
>>
>> input_dev->id.product = 0xDEAD;
>> input_dev->id.vendor = 0xBEEF;
>>
>> So what should I set ?
> 
> If there is no explicit guidance from the vendor, I would simply leave
> these unassigned; in theory one would imagine that this controller would
> have a different product ID than other models.

I'll leave those unassigned for now, and perhaps we could find
some firmware info value that could be used here.

Neil
> 
> [...]
> 
> Kind regards,
> Jeff LaBundy

