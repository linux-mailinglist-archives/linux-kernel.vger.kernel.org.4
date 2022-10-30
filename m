Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5F3612C7E
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 20:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiJ3TpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 15:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiJ3TpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 15:45:17 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4136624E;
        Sun, 30 Oct 2022 12:45:15 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id a14so13351040wru.5;
        Sun, 30 Oct 2022 12:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NKfS4aLyhcZFouwvRqN+Hdd2h6IBU2o24ivlxdwY0Kk=;
        b=gQD2ly58el8xxV1WXPhVHbGQKb2LoinxKG6ea/7w5TYG3yCnfuD6uDIYTTz8fPthzL
         3TWJ4MnAo7iw8HU3iXq7pSPr74l64y46ogk6IL+dTG12Mn8ZkvhU5d++AACymBJQqrQ9
         mLmZYxbCTTllzu7OpKz4ZbJU7KBEUGZEJFV24az1LLwaOrOgaUQQCHznTsS48GphwBA/
         ymF8XT7gf9x9l3T4F4QsIBHyE17/Mv6fuMSffnVu1AqJ/YcPzHSt0yib8ffnE6NO7Htc
         7YBeXcfOxdcCTIlEbftaUYuN0iR+BsiMu7BGsL6SuvumvlOmMuMOvVz8ANITXUL+IHEL
         3hqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NKfS4aLyhcZFouwvRqN+Hdd2h6IBU2o24ivlxdwY0Kk=;
        b=lllu0vkwcMfPKj5F3OJkH6PNfn77R3OlFFicu08fftAubwab7iU1nv6EHuBNq9LM4Y
         9Z5gfmrvK9ykXICgKcwYuFPeXStxzjo4Sz9FWZMZci5zBGByl5uUWduQdUDF+gT68g73
         FHiNVEAr03emHpHhCcfZiUrHN7ai4E7EJinplqqokZarOKzjRYr/Pu0/bjA3fCHQa0D9
         S3royvhnhDduZHuLjB5qv+oufiXaBOxSxkkTuDAEyKCp9BHuJTH9BBRlF34S+sCsH85R
         T6wScK7ZK6Fjf2nxxYgtE6d2SaFFJ6rj1GPYMjeej8yHIY61odHo7HAzNtt82jb2xKaX
         sMcw==
X-Gm-Message-State: ACrzQf0mCNwkO9ElO66numy8RGHqqQyE7bHluUItUz2uSA9TmCyedf2q
        T+9wazqmKDmLW7r/GcxaIk4=
X-Google-Smtp-Source: AMsMyM5oiGBxjmdAvLKUOJuUhqiRqr3JgCGFBbO7W6nQz88ItVLsAqDzKQPMmSwGOjNl36hM60rB4A==
X-Received: by 2002:a05:6000:1845:b0:236:90d2:f239 with SMTP id c5-20020a056000184500b0023690d2f239mr5912515wri.711.1667159114228;
        Sun, 30 Oct 2022 12:45:14 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id p12-20020a7bcc8c000000b003a682354f63sm5063992wma.11.2022.10.30.12.45.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Oct 2022 12:45:13 -0700 (PDT)
Message-ID: <1e268275-0705-8c30-5ea8-799d17278f08@gmail.com>
Date:   Sun, 30 Oct 2022 20:45:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v1 1/2] arm: rockchip: Kconfig: remove select
 ARM_GLOBAL_TIMER
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     linux@armlinux.org.uk, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <88e93a81-ef9f-adcc-db83-f8b5ba615c47@gmail.com>
 <3935573.e9J7NaK4W3@phil>
Content-Language: en-US
From:   Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <3935573.e9J7NaK4W3@phil>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/30/22 20:30, Heiko Stuebner wrote:
> Hi Johan,
> 
> Am Sonntag, 30. Oktober 2022, 19:36:01 CET schrieb Johan Jonker:
>> The clocksource and the sched_clock provided by the arm_global_timer
>> on Rockchip rk3066a/rk3188 are quite unstable because their rates
>> depend on the cpu frequency.
>>
>> Recent changes to the arm_global_timer driver makes it impossible to use.
>>
>> On the other side, the arm_global_timer has a higher rating than the
>> rockchip_timer, it will be selected by default by the time framework
>> while we want to use the stable rockchip clocksource.
>>
>> Let's disable the arm_global_timer in order to have the ROCKCHIP_TIMER
>> (rk3188) or DW_APB_TIMER (rk3066a) selected by default.
> 
> Doing that change won't help you with the issue you see.
> These days kernel images are supposed to run on as many
> platforms as possible with the _same_ kernel image.
> 
> So the muliplatform image build from the kernel's defconfig will
> include most of the time other platforms that will pull in the
> global-timer again.
> 
> 

How about "imply" instead of "select"?
It's no longer useful. One can get rid of if one wants a really lean kernel.

> I do see that you disable the global-timer
> in the rk3066 dtsi in patch2, though this would leave the rk3188
> still using the global-timer. Why not do this in the rk3xxx.dtsi?
> 
> I.e. keep the global-timer node, but add a disabled property
> together with a comment above the status=disabled, describing
> the issue. [This should keep people from re-adding the global-timer
> in the future :-) ]
> 
> Thanks
> Heiko
> 
>> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>> ---
>>
>> ARM: dts: rockchip: disable arm-global-timer for rk3188
>> https://lore.kernel.org/linux-rockchip/1492374441-23336-26-git-send-email-daniel.lezcano@linaro.org/
>>
>> clocksource: arm_global_timer: implement rate compensation whenever source clock changes
>> https://lore.kernel.org/all/20210406130045.15491-2-andrea.merello@gmail.com/
>> ---
>>  arch/arm/mach-rockchip/Kconfig | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
>> index b7855cc66..0432a4430 100644
>> --- a/arch/arm/mach-rockchip/Kconfig
>> +++ b/arch/arm/mach-rockchip/Kconfig
>> @@ -15,8 +15,6 @@ config ARCH_ROCKCHIP
>>  	select DW_APB_TIMER_OF
>>  	select REGULATOR if PM
>>  	select ROCKCHIP_TIMER
>> -	select ARM_GLOBAL_TIMER
>> -	select CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
>>  	select ZONE_DMA if ARM_LPAE
>>  	select PM
>>  	help
>> --
>> 2.20.1
>>
>>
> 
> 
> 
> 
