Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C05A72BA09
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 10:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjFLIQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 04:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjFLIQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 04:16:48 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F1D1AD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 01:16:45 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-977c8423dccso1054747466b.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 01:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686557804; x=1689149804;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=81HGPWtAHcoj4MGq+asBDEpD8CKCjuMMVkQmG5qPgmg=;
        b=YPOZhtA7hANwDQUmlXvVMP4eb9WKXMhJDY0KJUr9vJ7FLEbEMApwJKEXFoR1k2qUZL
         uobhy/NjWgItNWdbzJ3WvKtks6fjR/cYgvaFQN28o85JTVx934rieLglxJbw6jQgcHlN
         du8vBMGl55LFgsPDS5GMhlMySjIDq7lSI4oyd7v8ACvp+A/xDn9doI1oV/BHPgJj0VPa
         JuloBQ6e7HtRyRS/Zrw3YMppdNAZvTDgMmiiwCZdK00JSBGUis/JvauWDwX6zPh/OFvU
         gHNkO7HVkZq4gbTWP3MQm4hkNj1N1ZFQv4ARRKtOPQ1FMERdFIXs76gD91WyTcpDHM5O
         OyQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686557804; x=1689149804;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=81HGPWtAHcoj4MGq+asBDEpD8CKCjuMMVkQmG5qPgmg=;
        b=FnvR9zvAN/AUayWYbZdFy5HIl+e/sr8eU4lrf4KdI/xT76qsNQKVb5k7VXfhjiwtp3
         xFN63GaRTS59dqVwb0fITMO4Q+NzjK31X3eo4Z2rYG2yXn7JCHtr/jtvKsa+4R019oYN
         kGpAg9tlMMEqiVy78ccGIuG5UdmS0IcSy2I8bSE8V9y6V8paPjZlMH6gLwQXUuC5O2cE
         xuUhqjRdBAiR2pSD0orBithWYKYwnoQhc1RB4s454xKgLpMZqA46T8YPNAfNh5DmeHtN
         AnekcYW77Lvx8m9em+sYCybrtWFFGw2VUMwNUIcFIWNE8LHrYMgWUwSducMXsTlMjgyq
         8ZHQ==
X-Gm-Message-State: AC+VfDwn5P6w/pCf+D7sNQWwcCLXWvMhPUNDdkHAscCZ5b7hYqGO3Rlj
        hz3R1qoXZNduBoWD0ldbZQnswQ==
X-Google-Smtp-Source: ACHHUZ4/9kW8EA3qDwmtmg1KAWHGBhqtlbWwrnPt1f23DTverEEj1APChP1sjDuvSV9n4bHt5r6e6Q==
X-Received: by 2002:a17:907:6d16:b0:96f:a412:8b03 with SMTP id sa22-20020a1709076d1600b0096fa4128b03mr8239353ejc.5.1686557804177;
        Mon, 12 Jun 2023 01:16:44 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id fi5-20020a170906da0500b00965d294e633sm4867694ejb.58.2023.06.12.01.16.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 01:16:43 -0700 (PDT)
Message-ID: <d24f1e60-0ef3-2cb9-9675-846d861ef0c8@linaro.org>
Date:   Mon, 12 Jun 2023 10:16:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v12 1/2] spi: add loongson spi bindings
To:     zhuyinbo <zhuyinbo@loongson.cn>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
References: <20230608072819.25930-1-zhuyinbo@loongson.cn>
 <20230608072819.25930-2-zhuyinbo@loongson.cn>
 <6ebed84c-2b42-c981-7b3f-e71cc88e4c2c@linaro.org>
 <4bf747c4-b767-b20c-e00f-724b50f44edb@loongson.cn>
 <6bfc2a22-6901-0858-7b90-bc4c52c66810@linaro.org>
 <bd2d7830-3ab6-0906-b06a-83d3e0a96749@loongson.cn>
 <11ca2b90-544d-18c2-fb15-7909ca60507f@linaro.org>
 <f6d4ecb5-e9df-346e-4aab-772fd01689c8@loongson.cn>
 <a9952e76-1204-5bc7-7856-0c7f8a411d76@linaro.org>
 <9c94397d-1e31-02fa-bdbe-af888c72eac4@loongson.cn>
 <657f8d19-de83-8be6-4a9d-5f13b1df7383@linaro.org>
 <b0e5e13e-6746-bd90-2a49-31ee6dd3e8a2@loongson.cn>
 <84ccf4cc-072d-adbf-0361-95ceae13f333@linaro.org>
 <5d060cac-ff28-60e9-98a8-f2bd4d378455@loongson.cn>
 <4e30870d-86e2-8536-8e0d-aab4ce5027d2@linaro.org>
 <0c532e09-4821-5e07-92e6-7bc3cd79869e@loongson.cn>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <0c532e09-4821-5e07-92e6-7bc3cd79869e@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/2023 09:40, zhuyinbo wrote:
> 
> 
> 在 2023/6/12 下午3:17, Krzysztof Kozlowski 写道:
>> On 12/06/2023 09:13, zhuyinbo wrote:
>>>
>>>
>>> 在 2023/6/10 上午12:45, Krzysztof Kozlowski 写道:
>>>> On 09/06/2023 05:13, zhuyinbo wrote:
>>>>>
>>>>>
>>>>> 在 2023/6/8 下午9:26, Krzysztof Kozlowski 写道:
>>>>>> On 08/06/2023 14:10, zhuyinbo wrote:
>>>>>>>
>>>>>>>
>>>>>>> 在 2023/6/8 下午7:45, Krzysztof Kozlowski 写道:
>>>>>>>> On 08/06/2023 13:42, zhuyinbo wrote:
>>>>>>>>> --- a/Documentation/devicetree/bindings/spi/loongson,ls2k-spi.yaml
>>>>>>>>> +++ b/Documentation/devicetree/bindings/spi/loongson,ls2k-spi.yaml
>>>>>>>>> @@ -16,6 +16,7 @@ properties:
>>>>>>>>>         compatible:
>>>>>>>>>           enum:
>>>>>>>>>             - loongson,ls2k1000-spi
>>>>>>>>> +      - loongson,ls2k0500-spi
>>>>>>>>
>>>>>>>> Aren't they compatible?
>>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> Are you saying that the spi driver is compatible with 2k0500 ?
>>>>>>
>>>>>> Didn't you say this through 11 previous revisions?
>>>>>
>>>>>
>>>>> Yes, did I understand your meaning incorrectly ?
>>>>
>>>> If they are compatible, then they are not part of one enum. They could
>>>> not be as this would easily fail in testing of your DTS.
>>>>
>>>
>>>
>>> The "loongson,ls2k0500-spi" wasn't a compatible in previous version and
>>> I will add "loongson,ls2k0500-spi" as a compatible in spi driver and
>>> added it as a part of the one enum in dt-binding.
>>
>> No, because you claimed - if I understood correctly - that they are
>> compatible. Don't add fake entries to the driver.
>>
> 
> 
> I'm a bit confused, and I just need to add 'loongson,ls2k0500-spi' as
> one enum in dt-bindings, but driver don't add this entry ?

Compatibility is expressed with a list:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#compatible
so it cannot be just one enum, but "items". There are hundreds of
examples including example-schema.


Best regards,
Krzysztof

