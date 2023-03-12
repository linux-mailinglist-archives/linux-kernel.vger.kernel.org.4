Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66A06B6AAD
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 20:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjCLTdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 15:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjCLTdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 15:33:03 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D011FD7
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 12:33:01 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id cy23so40470335edb.12
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 12:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678649580;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZB/LIIyZjPl2nWkKXjfWGUMD4MI6EoT8Bzwl9SY7KhY=;
        b=MrPKoI+RZmJUmxugnHn1C6zBsclcPIRqSQIpFdvDQWFc8ty5HTRo5iYLH/d5UG/gyb
         kPyjpY78j2w720EMkpoB6I7ZWVP+IzYBN9vp4dUuGk0/o7vwfiBdk1dTF3U3V2bhszQd
         VEHo2WLlfWKiqLDrIca3XhW3Su3FUcyWDZ7EAzvJc+NeMTmMYFqpbQz6VbdkTtBYlN52
         iGJZC7f5mMXM1vq+r9bb8bTDxsdQvAefTlz8QpMLdbEWtDl51Fi6tILaN07dQ05LE9Ul
         yg/CS4awsTAVTiyYZUdzLrTb7Y1g1A71IDIFdG8mFKAHas8q5kPUbdEtTLECk+DnVgoX
         inmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678649580;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZB/LIIyZjPl2nWkKXjfWGUMD4MI6EoT8Bzwl9SY7KhY=;
        b=axcZ3RsqhE6rBfMbGtdbgVbX1GfiMFHJFEVFLq0CGpM7mfYwa7cnsquZ8Azxr+G/f9
         XY3RxL3R9HdNXrdCk+c8HfSRdNsVZcxb0Aj09l/xkrdyJYho+3J8AWt5Lbe9uienaX5q
         OGrXXnRlpPv9bIbjNUem43UWlsoaO6jJblh8RW2p3Mod1OvmWPT6ny3sDbav9cjvRgjY
         8a9RI7HE/8UZAujBhNF3Yelhj/qr5azqFW5st+UYJoKk0IYVokuEpOY5wJMUpMQKv0MT
         uGky6q/YVtp1KUNYwSmSppTburXxdk+bWPWujiDVUBdGbxzAMXS+iDsLuzu0NoGENXzs
         a7wg==
X-Gm-Message-State: AO0yUKVnasyl8p3tY02+aKXO8hVBNENjeYPFyhBwIoe/wDfGZ0SSoSyg
        c0+VeK/aejX8P1mNNeCmOzAsLg==
X-Google-Smtp-Source: AK7set8K8Oraek/eD3gW5AGcq/GufMiREyTE9pJ/+3gLzsteBCdvKG+cej39DT2gi6LwAK12DzD5DA==
X-Received: by 2002:a05:6402:1207:b0:4aa:a4dd:9746 with SMTP id c7-20020a056402120700b004aaa4dd9746mr27477650edw.39.1678649579976;
        Sun, 12 Mar 2023 12:32:59 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d9f6:3e61:beeb:295a? ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id g26-20020a50d5da000000b004fc86fcc4b3sm325013edj.80.2023.03.12.12.32.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 12:32:59 -0700 (PDT)
Message-ID: <688b6817-9d57-6c92-1ce0-6f97cb8c4cc2@linaro.org>
Date:   Sun, 12 Mar 2023 20:32:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] hwmon: gpio-fan: mark OF related data as maybe unused
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Eric Tremblay <etremblay@distech-controls.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230311111610.251774-1-krzysztof.kozlowski@linaro.org>
 <cd9067c7-0b99-4d62-9d5a-cdc028f33ba5@roeck-us.net>
 <48b6689e-f045-5e24-ead7-f6da5b8fe454@linaro.org>
 <9343421e-d35d-8d99-1ea7-1f81e28fbabb@roeck-us.net>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <9343421e-d35d-8d99-1ea7-1f81e28fbabb@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03/2023 19:48, Guenter Roeck wrote:
> On 3/12/23 11:08, Krzysztof Kozlowski wrote:
>> On 12/03/2023 19:06, Guenter Roeck wrote:
>>> On Sat, Mar 11, 2023 at 12:16:09PM +0100, Krzysztof Kozlowski wrote:
>>>> The driver can be compile tested with !CONFIG_OF making certain data
>>>> unused:
>>>>
>>>>    drivers/hwmon/gpio-fan.c:484:34: error: ‘of_gpio_fan_match’ defined but not used [-Werror=unused-const-variable=]
>>>>
>>>
>>> How do you trigger that ? The driver depends on OF_GPIO which
>>> in turn depends on OF. Arguably that means that of_match_ptr()
>>> doesnot really make sense, but still I don't see how you can
>>> trigger the above error message.
>>
>> I can drop of_match_ptr, it's indeed in many cases not needed.
>>
>> I just build x86_64 allyesconfig minus OF, with W=1.
>>
> 
> x86_64 allyesconfig minus OF minus results in SENSORS_GPIO_FAN being
> deselected (it doesn't show up in the configuration anymore at all
> after "make olddefconfig").
> 
> $ make allyesconfig
> $ grep SENSORS_GPIO_FAN .config
> CONFIG_SENSORS_GPIO_FAN=y
> $ sed -i -e 's/CONFIG_OF=y/# CONFIG_OF is not set/' .config
> $ make olddefconfig
> #
> # configuration written to .config
> #
> $ grep SENSORS_GPIO_FAN .config
> $
> 
> I suspect what you did is to disable CONFIG_OF, and then you built
> the driver without realizing that is was deselected.

The driver would not built. I mean, I did not cheat here to built it
with incorrect config.

I rather suspect that config is broken due to:
WARNING: unmet direct dependencies detected for OF_GPIO
WARNING: unmet direct dependencies detected for GPIO_SYSCON
WARNING: unmet direct dependencies detected for MFD_STMFX

This was next-20230308

> 
>> Do you want to me to drop of_match_ptr?
>>
> 
> Yes, sure, that makes more sense. The reason though is that the
> driver depends on CONFIG_OF=y, not because of the build failure.

I'll send v2 of both patches because anyway dropping of_match_ptr is
preferred.

Best regards,
Krzysztof

