Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB77724AFB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 20:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237716AbjFFSMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 14:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235673AbjFFSMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 14:12:15 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890B11706
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 11:12:07 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-30af86a96b4so5240661f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 11:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686075126; x=1688667126;
        h=content-transfer-encoding:in-reply-to:subject:organization
         :references:cc:to:content-language:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kYoqAND0o4BTOUj5sWEzm+/BHDSbhCWoaP3pRrbOvnA=;
        b=bnio+IJxvuO9HXe0vGhyEhDhF6pAAy7aBhSPJDOJzsCiZZGe9PAkzHeROllMfCXdpH
         V36EzPcr1yVaLDOgUTBiiQ7jyXiWvLdGwoO7F1ZthZHxMG1Tcgh+Ro+7cc2NJEHJabpJ
         JsySQycsMVypyhq6yM3Am+EbPoV9rtrNTwARsAi567Fhk+v3wiTD8a2Z9JaLtnDYG4do
         agE67HcVt8HKI5YPZ0MxTItLm80+4WNsZNV2ic65li1BguKhFTUs8/u6izZhaar3Ge83
         O3PH82aK/FWVb0vWY3JnyaVvtYJK+u90m7FIjreMslf/RBJNgYQNXG3uvGUnxwKomkRh
         0Kdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686075126; x=1688667126;
        h=content-transfer-encoding:in-reply-to:subject:organization
         :references:cc:to:content-language:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kYoqAND0o4BTOUj5sWEzm+/BHDSbhCWoaP3pRrbOvnA=;
        b=iggh9NPW7ntLgyySY4eRTiv0OYAuxegJ0wMUurYjJ8NaRVpZJMytTHpt+JEuu9rng1
         sxLYePAl1dC9kV0CAm6QnaDbcW21GwWIExr5i20QCz98RoWx5Y1JIoRfbWr1y9EIOkrf
         frxj35Lo50jkDt4D8xY6NzpWhv152RP6P53szvfF5DsJeqGGb/1oASczDUZC5d6UuNHq
         K+ANJYoHSqidq7D1ghJ81XeAFBbM72fFSSGSY230Ga3n0uK12WKwlgmlYmbzsviU6/+I
         nbp6jSsD3uWNDSY53lUaqvoyXZePUpzlGBxIGoLGKsQjkVyfpXknfjnfvB7UXYnzMU3u
         Dwkw==
X-Gm-Message-State: AC+VfDz+D8qE/bnf3YeLKAZZiMQvR7/lHSDX63VKVAanj0wxdceRvFOM
        Yyh3hKpNzhilIaiAhM1AnB/vsA==
X-Google-Smtp-Source: ACHHUZ6HSztp6UVppsTYnipYHlgsZqFOwW2WmOoYocekK9mHRxrdmR0MwdUdA5lCgkvEmSXCq6mphA==
X-Received: by 2002:a05:6000:149:b0:306:297b:927f with SMTP id r9-20020a056000014900b00306297b927fmr2094739wrx.25.1686075125909;
        Tue, 06 Jun 2023 11:12:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:4973:1165:b171:fa69? ([2a01:e0a:982:cbb0:4973:1165:b171:fa69])
        by smtp.gmail.com with ESMTPSA id y6-20020a5d4ac6000000b002c70ce264bfsm13397523wrs.76.2023.06.06.11.12.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 11:12:05 -0700 (PDT)
Message-ID: <2677ae8c-59d3-b658-dc3f-918838ac0fb6@linaro.org>
Date:   Tue, 6 Jun 2023 20:12:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Henrik Rydberg <rydberg@bitmath.org>
Cc:     linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230606-topic-goodix-berlin-upstream-initial-v1-0-4a0741b8aefd@linaro.org>
 <f5f20de8-851a-fe20-4664-62b6de14ebd7@redhat.com>
Organization: Linaro Developer Services
Subject: Re: [PATCH RFC 0/4] input: touchscreen: add initial support for
 Goodix Berlin touchscreen IC
In-Reply-To: <f5f20de8-851a-fe20-4664-62b6de14ebd7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06/06/2023 17:31, Hans de Goede wrote:
> Hi Neil,
> 
> On 6/6/23 16:31, Neil Armstrong wrote:
>> These touchscreen ICs support SPI, I2C and I3C interface, up to
>> 10 finger touch, stylus and gestures events.
>>
>> This initial driver is derived from the Goodix goodix_ts_berlin
>> available at [1] and [2] and only supports the GT9916 IC
>> present on the Qualcomm SM8550 MTP & QRD touch panel.
>>
>> The current implementation only supports BerlinD, aka GT9916.
>>
>> Support for advanced features like:
>> - Firmware & config update
>> - Stylus events
>> - Gestures events
>> - Previous revisions support (BerlinA or BerlinB)
>> is not included in current version.
>>
>> The current support will work with currently flashed firmware
>> and config, and bail out if firmware or config aren't flashed yet.
> 
> What I'm missing here / in the commit msg of
> "input: touchscreen: add core support for Goodix Berlin Touchscreen IC"
> 
> is an explanation why this is a new driver instead of adding
> support to the existing goodix.c code.
> 
> I assume you have good reasons for this, but it would be good
> if you can write the reasons for this down.

Sure, should I write it down here and/or update the commit message in a new revision ?

Anyway, here's the reasons:
- globally the event handling "looks like" the current goodix.c, but again the offsets
are again different and none of the register address are the same, and unlike the current
support all registers are provided by the "ic_info" structure
- while with the current code it *could* be possible to merge it, with a lot of changes,
the firmware management looks really different, and it would be really hard to merge.

But I may be wrong, and may be misleaded by the goodix driver structure (even if it
went through a really heavy cleaning process).

Globally it seems they tried to match the "event handling" process of the previous
generations, but the firmware interface is completely different.

Neil

> 
> Regards,
> 
> Hans
> 
> 
> 
>>
>> [1] https://github.com/goodix/goodix_ts_berlin
>> [2] https://git.codelinaro.org/clo/la/platform/vendor/opensource/touch-drivers
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>> Neil Armstrong (4):
>>        dt-bindings: input: document Goodix Berlin Touchscreen IC
>>        input: touchscreen: add core support for Goodix Berlin Touchscreen IC
>>        input: touchscreen: add I2C support for Goodix Berlin Touchscreen IC
>>        input: touchscreen: add SPI support for Goodix Berlin Touchscreen IC
>>
>>   .../bindings/input/touchscreen/goodix-berlin.yaml  |  81 ++
>>   drivers/input/touchscreen/Kconfig                  |  33 +
>>   drivers/input/touchscreen/Makefile                 |   3 +
>>   drivers/input/touchscreen/goodix_berlin.h          | 228 +++++
>>   drivers/input/touchscreen/goodix_berlin_core.c     | 935 +++++++++++++++++++++
>>   drivers/input/touchscreen/goodix_berlin_i2c.c      |  76 ++
>>   drivers/input/touchscreen/goodix_berlin_spi.c      | 183 ++++
>>   7 files changed, 1539 insertions(+)
>> ---
>> base-commit: 6db29e14f4fb7bce9eb5290288e71b05c2b0d118
>> change-id: 20230606-topic-goodix-berlin-upstream-initial-ba97e8ec8f4c
>>
>> Best regards,
> 

