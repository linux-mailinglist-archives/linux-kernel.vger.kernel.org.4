Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9489F6B6BA9
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 22:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbjCLVDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 17:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjCLVDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 17:03:38 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710D123DBB;
        Sun, 12 Mar 2023 14:03:37 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id a23-20020a4ad5d7000000b005250867d3d9so1561210oot.10;
        Sun, 12 Mar 2023 14:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678655016;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ZLdtVQcLFMkKKieblSnLcBuNgLLD1qkCuhFst+Po+Jk=;
        b=DwxGvS+SFoc8/Zc/T780x7ZNiS1SGdRCixQ0v6b1ocprhfHzDwX3WQGXvvBVfKx2m9
         XmmTay7XllhbFstFIycRotHgYPhrh9U1EFl1oA6J1rEosI60dVJPMHr8czViSKtdfO7m
         3Rx2+QKOkEpoLCFgwmt+RsEZecD4YbUwRV0KwUu8svq4VR1OXLUK12uuLEKUEmIX/yME
         JefUUJLwSOV5PxfBMUw6Jw7zJHJSj0XaoOr1Kw81/KQ2ABrvIN9bzpVWKmxzjMlScAUL
         wP45HbcuMCvCrxoHNwqM9V8GFQgQZNY9bWdg1IKNs9v8lurL9lmCtAf7PE/nIjRh83X3
         UJNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678655016;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZLdtVQcLFMkKKieblSnLcBuNgLLD1qkCuhFst+Po+Jk=;
        b=Zbkx5d24YUuNZm18FfC7Jq+LiuUVFieMwOmWh0ZdkF/HZ6021YS9LCOQNHli9DLu4g
         zQzqTQdeqLpNOF12l4ZzJifE2Ji84MIUiFZSeJB1zaQT9BtstRafAqJdneDv+vVGpGUH
         OoD2qtCYxdQD3KIORSvPdP9s7TB0cEI59gxvK1e+O06MhCV+c9YzTM59bTyeS1/8cbC8
         DXL4OvUOdocb7d9l0d521/IIF85skBPeZts8EGm8qBCejWoIc2U5zh72HMpOLG24TnbN
         OjQBtfSAFSA2sq7dF5hmZsLzdZsaynsujfZ0l0F6FU9s6LXNuueCS7Mi52k3/TevGasF
         W2XA==
X-Gm-Message-State: AO0yUKWT2WAT5n5vE6uITCvxoSnRNwA7U4dcgSFoOGqW1wHqy9L2N2wU
        Ifrq/Vm0ebwJOzGNdyQkMNk=
X-Google-Smtp-Source: AK7set8c2TifFtZL2+w8ZDqwVi646qn40ZMZOkyHsQAgXFl8zPcbWipxym0Xl/vRiTyNYt8X25bEDw==
X-Received: by 2002:a05:6820:61f:b0:525:456f:b96f with SMTP id e31-20020a056820061f00b00525456fb96fmr18700214oow.2.1678655016757;
        Sun, 12 Mar 2023 14:03:36 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g27-20020a4a755b000000b0051a6cb524b6sm2411226oof.2.2023.03.12.14.03.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 14:03:36 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <062a2834-ece9-49ed-0e15-30730b65ef50@roeck-us.net>
Date:   Sun, 12 Mar 2023 14:03:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/2] hwmon: gpio-fan: mark OF related data as maybe unused
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Eric Tremblay <etremblay@distech-controls.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230311111610.251774-1-krzysztof.kozlowski@linaro.org>
 <cd9067c7-0b99-4d62-9d5a-cdc028f33ba5@roeck-us.net>
 <48b6689e-f045-5e24-ead7-f6da5b8fe454@linaro.org>
 <9343421e-d35d-8d99-1ea7-1f81e28fbabb@roeck-us.net>
 <688b6817-9d57-6c92-1ce0-6f97cb8c4cc2@linaro.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <688b6817-9d57-6c92-1ce0-6f97cb8c4cc2@linaro.org>
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

On 3/12/23 12:32, Krzysztof Kozlowski wrote:
> On 12/03/2023 19:48, Guenter Roeck wrote:
>> On 3/12/23 11:08, Krzysztof Kozlowski wrote:
>>> On 12/03/2023 19:06, Guenter Roeck wrote:
>>>> On Sat, Mar 11, 2023 at 12:16:09PM +0100, Krzysztof Kozlowski wrote:
>>>>> The driver can be compile tested with !CONFIG_OF making certain data
>>>>> unused:
>>>>>
>>>>>     drivers/hwmon/gpio-fan.c:484:34: error: ‘of_gpio_fan_match’ defined but not used [-Werror=unused-const-variable=]
>>>>>
>>>>
>>>> How do you trigger that ? The driver depends on OF_GPIO which
>>>> in turn depends on OF. Arguably that means that of_match_ptr()
>>>> doesnot really make sense, but still I don't see how you can
>>>> trigger the above error message.
>>>
>>> I can drop of_match_ptr, it's indeed in many cases not needed.
>>>
>>> I just build x86_64 allyesconfig minus OF, with W=1.
>>>
>>
>> x86_64 allyesconfig minus OF minus results in SENSORS_GPIO_FAN being
>> deselected (it doesn't show up in the configuration anymore at all
>> after "make olddefconfig").
>>
>> $ make allyesconfig
>> $ grep SENSORS_GPIO_FAN .config
>> CONFIG_SENSORS_GPIO_FAN=y
>> $ sed -i -e 's/CONFIG_OF=y/# CONFIG_OF is not set/' .config
>> $ make olddefconfig
>> #
>> # configuration written to .config
>> #
>> $ grep SENSORS_GPIO_FAN .config
>> $
>>
>> I suspect what you did is to disable CONFIG_OF, and then you built
>> the driver without realizing that is was deselected.
> 
> The driver would not built. I mean, I did not cheat here to built it
> with incorrect config.
> 
> I rather suspect that config is broken due to:
> WARNING: unmet direct dependencies detected for OF_GPIO
> WARNING: unmet direct dependencies detected for GPIO_SYSCON
> WARNING: unmet direct dependencies detected for MFD_STMFX
> 
> This was next-20230308
> 
Interesting. That has been fixed in next-20230310, where
SENSORS_GPIO_FAN is again deselected if CONFIG_OF is disabled.

>>
>>> Do you want to me to drop of_match_ptr?
>>>
>>
>> Yes, sure, that makes more sense. The reason though is that the
>> driver depends on CONFIG_OF=y, not because of the build failure.
> 
> I'll send v2 of both patches because anyway dropping of_match_ptr is
> preferred.
> 
Ok.

Thanks,
Guenter

