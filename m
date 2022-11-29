Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D5763C456
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 16:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235887AbiK2P6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 10:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235803AbiK2P5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 10:57:24 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772196454C
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 07:57:22 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id j4so22747599lfk.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 07:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mDFVPNh4/71qMRqEkALWrbJbV59lQnRr29JZ5Ud10II=;
        b=pHoptnjw71Za8weSzrMZuoqO/WMNgzMO4tC8LVNQprtmxusuAU4+ZnzsYXHcOZ0TXg
         qD76FmCaKxAjfR/zH4WzAicE43pmndPRcPpfKAcr3ZSIjHgFieRGMR2gFrNGKJbXFicC
         GPDFhDCmlLJWOvwvsAcRu8wOIqszrq7QlJNwAZOOMVL18ZpsqfWrTWdJR6AZPD3hs1DC
         dx4XJiHyqaCslldRDtlUHWafs/0iT372J6K58XgpiFTFkB8tQu6fVqjVglzSnkP7R5vn
         YfotcZ8Rpymspq5zxVWU3f0203YTWkHG/7I4jccw2IZTWdUtq2KpYS7sVLQhDFBZm+oC
         vdVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mDFVPNh4/71qMRqEkALWrbJbV59lQnRr29JZ5Ud10II=;
        b=Z81Dwz1rzXDJsK3Plv/fVNTlEwrvaiJUd3kOXid9OkumpL/slXxxcWPOBqZ7YPgZOF
         cpO60iiI+H5EGaRGOscl5Zs2pHDD/5lFFfugiqgIkAazHu3RyFsKkdhwmvU9l4LOFeUO
         1owew6W+zN6fV+P9Fb89D4H8G9dvTGzkAxrAa2/5KtdPSpBYcom2dUIk+HJVsCEuap9L
         SCQ74n37vl/2wQ/d8ceNcdPE9wvJzbgJL4lCD2Wib1wOyxj9pSHrbEOGsV0NzLTXdjT/
         lCLrYZTKuAg10XDHkNTAPBYLvE4pHWVNAFh0Pb0XMXFAejIIeMJyt1Kp3d2ZkZnhIX90
         B29w==
X-Gm-Message-State: ANoB5pniyUP/B1auXxJ0Jjo07L+HoubVJzTpndlvL/h7Uvm/far1sXFR
        hgwDGn/+xVG/kMwaFMozIfG+EgG/MOcUl8tV
X-Google-Smtp-Source: AA0mqf6+Hvb2/BZUZ6/6JjMgajEPlzD5UDHF+uyv1L7CN3Vz/MpOwoe4OgBBJsjuwKPYH+BgsbC1Mg==
X-Received: by 2002:ac2:5dd3:0:b0:4a2:6e1d:f996 with SMTP id x19-20020ac25dd3000000b004a26e1df996mr14144260lfq.114.1669737440717;
        Tue, 29 Nov 2022 07:57:20 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id s11-20020a056512202b00b004979e1ff641sm2220303lfs.115.2022.11.29.07.57.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 07:57:20 -0800 (PST)
Message-ID: <a5e9ecca-b17e-3045-db37-e109ecca3235@linaro.org>
Date:   Tue, 29 Nov 2022 16:57:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v7 1/4] dt-bindings: hwmon: fan: Add fan binding to schema
Content-Language: en-US
To:     Naresh Solanki <naresh.solanki@9elements.com>,
        devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>
References: <20221121122932.2493174-1-Naresh.Solanki@9elements.com>
 <20221121122932.2493174-2-Naresh.Solanki@9elements.com>
 <c35917d1-dfbd-f7d9-5c94-a9f0ee3b7ed8@linaro.org>
 <2487f032-1261-be6e-2e2a-38ca0af7c83c@9elements.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <2487f032-1261-be6e-2e2a-38ca0af7c83c@9elements.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/11/2022 16:46, Naresh Solanki wrote:
> Hi Krzysztof,
> 
> On 29-11-2022 01:42 pm, Krzysztof Kozlowski wrote:
>> On 21/11/2022 13:29, Naresh Solanki wrote:
>>
>>> +  pulses-per-revolution:
>>> +    description:
>>> +      The number of pulse from fan sensor per revolution.
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +
>>> +  target-rpm:
>>> +    description:
>>> +      Target RPM the fan should be configured during driver probe.
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +
>>> +  pwms:
>>> +    description:
>>> +      PWM provider.
>>
>> Ah, so it is not a PWM provider by this FAN controller? A bit confusing
>> description. Instead maybe:
>> 	PWM signal for the fan
> Sure.
>>
>> and do you expect more than one PWM for one fan?
> One pwm per fan

then:
  maxItems: 1

Best regards,
Krzysztof

