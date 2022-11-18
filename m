Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B86862F937
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 16:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241808AbiKRPXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 10:23:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233929AbiKRPXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 10:23:12 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B271CB08
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 07:23:10 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id o30so3848128wms.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 07:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LcYxX7CS1Ufy2jDrgHKfbNrWxSi6NEkFbdecW+66ckA=;
        b=kwWawBEtv8KFgdpgtP1kcjBH2zrLUgAusesVgFEwCuWYdfBgcA5wc/sBbYz/Gt60Fy
         C04zvP0H/tOcx1EzY9ytQLrDGGHiqrxOfRPa50i7nY8v2N9LDYc8xgnsLc/GZOvrT6Io
         vgTVe81WD/VJ1nVjtmE6LngjjQyGBUzEN3/SmMFWgHw+lrjQQjRIXbWlHn4WzsJsNGOP
         sPy26VddXhOo5vWQpwZLlHy2CKNb/+D19+uuEKIcgHsHbUSe7ZvGcxDHweoT7IX+YDH1
         0WeINkG/1vPNI8sPqxpkZFM+gQT4iTwUltg1AANvcWWf/B8iH+ezxZFEvkTs5mo/vXkr
         WiQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LcYxX7CS1Ufy2jDrgHKfbNrWxSi6NEkFbdecW+66ckA=;
        b=7S4NCchyYpiMfv/CPmERvDr2BFx7YD8pQaxhihSe0rMvyd0EvwTn/ueUrZ6CipE771
         nu5l30e0jaowkQP5NqNceXUF+wd02tig7/SKAy7AEh/KUjJY9FkZQ7gbTA1M7Bk96+ge
         WAaRMjJTYjOgVm9VYLbZZ9P29V6j6YbmWEuQvaY/YHuuG0EIqlYVFQ5zOIwk3rFTLbM0
         bc257qK5nzCww5D1cpPIRnqi4si3YY1ZZ0rK16H8QyYg8dNZi4XwaLDgTBiN9W414nNq
         /MLCiAaE62aQjW0CgvQf8m2fXlfzmILTiNlKETCOIUutTDfsjPWnRDd54ohZL5Hzk1Ky
         MF7w==
X-Gm-Message-State: ANoB5pn0amh9OWQSPmNs2rriviIhgEDxkhEjyrmnZ1S9WzcrntzkKurS
        GivV/hjf3n6GAh92j+RccaDAvwTrNzmZow==
X-Google-Smtp-Source: AA0mqf63aZ9cQQYw+4CNq3MjA++NwUGZ8iaNAcaISCCd+7/g1EHsFBDOhLklLe1GPigwlYD6F1nL5Q==
X-Received: by 2002:a05:600c:348d:b0:3cf:88d3:5685 with SMTP id a13-20020a05600c348d00b003cf88d35685mr5340839wmq.38.1668784989562;
        Fri, 18 Nov 2022 07:23:09 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:f7cc:460c:56ae:45a? ([2a01:e0a:982:cbb0:f7cc:460c:56ae:45a])
        by smtp.gmail.com with ESMTPSA id e18-20020adfdbd2000000b0022da3977ec5sm3801120wrj.113.2022.11.18.07.23.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 07:23:09 -0800 (PST)
Message-ID: <b5970487-9326-9d41-a004-6369e854e530@linaro.org>
Date:   Fri, 18 Nov 2022 16:23:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3] dt-bindings: pinctrl: convert semtech,sx150xq bindings
 to dt-schema
Content-Language: en-US
To:     Sander Vanheule <sander@svanheule.net>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>, linux-gpio@vger.kernel.org
References: <20221005-mdm9615-sx1509q-yaml-v3-0-e8b349eb1900@linaro.org>
 <79ba65cc117db8102bd8f7e30d6d44fdbd0542f1.camel@svanheule.net>
Organization: Linaro Developer Services
In-Reply-To: <79ba65cc117db8102bd8f7e30d6d44fdbd0542f1.camel@svanheule.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/11/2022 16:19, Sander Vanheule wrote:
> Hi,
> 
> On Tue, 2022-11-15 at 11:06 +0100, Neil Armstrong wrote:
>> This converts the Semtech SX150Xq bindings to dt-schemas, add necessary
>> bindings documentation to cover all differences between HW variants
>> and current bindings usage.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> ---
>> To: Linus Walleij <linus.walleij@linaro.org>
>> To: Rob Herring <robh+dt@kernel.org>
>> To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
>> Cc: linux-gpio@vger.kernel.org
>> Cc: devicetree@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> ---
>> Changes in v3:
>> - Resent with missing To: Linus Walleij
>> - Link to v2: https://lore.kernel.org/r/20221005-mdm9615-sx1509q-yaml-v2-0-a4a5b8eecc7b@linaro.org
>>
>> Changes in v2:
>> - fixed rob comments
>> - added rob's Reviewed-by
>> - Link to v1: https://lore.kernel.org/r/20221005-mdm9615-sx1509q-yaml-v1-0-0c26649b637c@linaro.org
>> ---
> 
> [snip]
> 
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - semtech,sx1503q
>> +              - semtech,sx1506q
>> +    then:
>> +      patternProperties:
>> +        '-cfg$':
>> +          properties:
>> +            pins:
>> +              items:
>> +                pattern: '^gpio[0-15]$'
> 
> [snip]
> 
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: semtech,sx1509q
>> +    then:
>> +      patternProperties:
>> +        '-cfg$':
>> +          properties:
>> +            pins:
>> +              items:
>> +                pattern: '^(oscio|gpio[0-15])$'
> 
> Sorry to be so late to reply, but don't these patterns only match "gpio0", "gpio1", and "gpio5"?
> 
> A quick search for some datasheets turned up the SX1503 and SX1509Q with 16 GPIOs, so I assume the
> intention was to match "gpio0" to "gpio15". I think this should be "^(gpio[0-9]|gpio1[0-5])$" (or
> something equivalent).

Damn you're right, Linus should I resend or send a fixup ?

Thanks,
Neil

> 
> Best,
> Sander

