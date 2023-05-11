Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44A16FF90C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 19:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239021AbjEKR63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 13:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239069AbjEKR6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 13:58:08 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22E11727
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 10:57:46 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-965ab8ed1fcso1630956766b.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 10:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683827862; x=1686419862;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KKEWKy4QsgEP6Phxafvcaa/nk7o4U4bQeym+7fv4t84=;
        b=dxc9baUC6WhtT9/YH80Q5hWdOF98PVdFTsDiFwUaP4ZAZECOdsk4dUleu/VKs7W+rU
         cGzxrfVHuxZCfHjNv59oXotQ1x1X+SZE1i4CdPll9Ct+0J6YHP+r/gVSf2SVWEDbw2PI
         VDmHW8kvLjURCuVuitM5NAlb7BKLhsd3jUZPkG70RO28Q+fCCYG3ioGD4XU2XZozrQ2T
         ZwrF+tW2r5n0xAgYIkBrsU0ylfqkdH9JgxKsWa8gwE9SdICFTHBQJ/YmJTYTQDmwbEiv
         hN3XRYNVxP9XVTH1qLPAKSBH2UB697r1x9zPDA97RunKTDawO4CqAxS0mcE/Qc03K6tF
         y1gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683827862; x=1686419862;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KKEWKy4QsgEP6Phxafvcaa/nk7o4U4bQeym+7fv4t84=;
        b=Z9DW3t1dWa578POV0kXXumetiIvhVySyBQbpRKjFUdTIWtBPDNgf6zG9VZKq8SiwCE
         OJaMpCLoHEzg7wiwO2uRJv6N5qATzmTIsNn8SqnOnXgeMyOQ5BCI3kcuB5JpIePWUVJM
         WGh95Fl9Zk3m5MWspEPeZSLq7alICLpuZZgvS/neiFqwOWd0l3REm56ogJQdg28A3/YN
         /W/tL+h8NnjKAIM7MfMakWr0VCRUnoIrXdnjlsvFz5UWBQW8J2MC0bFxfQDfDlCWpSq5
         IIVofyQHy0lZTGTDDi8xuqtCfIfeIjTPq9+MItvR/K9usR2TXYabL7rA7F/oyeQrBZ1C
         oVdg==
X-Gm-Message-State: AC+VfDxwJ5o+oh+bL8uA3iHi1fUt7NqoI6AqjY/bF4v4CoG9pKAQMBXU
        fHjFD5vdDPADVEUHioZh4sTsfQ==
X-Google-Smtp-Source: ACHHUZ6ZNYNy8A+C05L0Pkvx8jTChxFxNF9aHHsbShC3/zp+v6BL8/lv3zW1fvRU9umtfIqfzDbPsA==
X-Received: by 2002:a17:907:7b9c:b0:966:7a0a:28c0 with SMTP id ne28-20020a1709077b9c00b009667a0a28c0mr15820879ejc.58.1683827862247;
        Thu, 11 May 2023 10:57:42 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d7cd:1be6:f89d:7218? ([2a02:810d:15c0:828:d7cd:1be6:f89d:7218])
        by smtp.gmail.com with ESMTPSA id nr1-20020a1709068b8100b0094f1b8901e1sm4351538ejc.68.2023.05.11.10.57.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 10:57:41 -0700 (PDT)
Message-ID: <3c131132-35ce-e5da-2608-36d53abc6c83@linaro.org>
Date:   Thu, 11 May 2023 19:57:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 3/3] dt-bindings: ASoC: Add ESS ES9218P codec bindings
Content-Language: en-US
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230510112349.939991-1-aidanmacdonald.0x0@gmail.com>
 <20230510112349.939991-3-aidanmacdonald.0x0@gmail.com>
 <7b3a37e8-0210-c539-5b5b-bf8e587707ea@linaro.org>
 <7Zga7RBqLNcaG5ylTIY4Qn7CUdE1IJsW@localhost>
 <8e98b31a-ef4d-a8bd-32f3-e6f496f2b138@linaro.org>
 <zfuvar6MiqIaW9nvjgvUIhA1t3DkZ9tE@localhost>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <zfuvar6MiqIaW9nvjgvUIhA1t3DkZ9tE@localhost>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2023 13:26, Aidan MacDonald wrote:
> 
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:
> 
>> On 11/05/2023 12:15, Aidan MacDonald wrote:
>>>
>>> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:
>>>
>>>> On 10/05/2023 13:23, Aidan MacDonald wrote:
>>>>> ...
>>>>> +  ess,max-clock-div:
>>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>>> +    description:
>>>>> +      Sets the maximum MCLK divider for generating the internal CLK.
>>>>> +      CLK must be at least 20x the I2C bus speed or I2C transactions
>>>>> +      will fail. The maximum divider should be chosen to ensure that
>>>>> +      CLK will not fall below the limit.
>>>>> +    enum:
>>>>> +      - 1
>>>>> +      - 2
>>>>> +      - 4
>>>>> +      - 8
>>>>> +    default: 1
>>>>
>>>> Why do you need to customize it per board?
>>>>
>>>
>>> There's no generic API to read or change the bus speed (SCL frequency)
>>> for I2C adapters, so it's impossible to calculate a limit on the MCLK
>>> divider automatically.
>>>
>>> Defaulting to 1 is always safe, but means wasting power at lower sample
>>> rates. If you know what the bus speed is you can use a higher divider
>>> limit to save power, and it has to be done at the board/firmware level
>>> because that's the only place where the bus speed is known.
>>
>> If I understand correctly, you only miss a way to get bus_freq_hz from
>> i2c_timings to calculate the divider by yourself? This looks like Linux
>> limitation, so we shouldn't push it into DT, but rather fix Linux. The
>> I2C bus rate is known, the MCLK rate as well, so divider is possible to
>> deduce.
>>
>> I am actually surprised that I2C core does not store the timings
>> anywhere and each bus host has to deal with it on its own.
>>
>> Best regards,
>> Krzysztof
> 
> I agree it'd be better if Linux provided access the bus frequency, but
> even if that API was added it will take time for every I2C adapter to
> support it. So in that case we would still need a DT property to provide
> a safe limit or use a safe default, and miss potential power savings.
> 
> I'd prefer to add the DT property to allow power savings to be had now,
> and drop it if/when the kernel gets an API for bus frequency. That will
> be safe from a compatibility point of view -- the property won't be
> providing any useful information so it won't matter if old DTs have it.

OK, sounds good.

Best regards,
Krzysztof

