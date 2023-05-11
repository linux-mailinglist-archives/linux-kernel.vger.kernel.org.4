Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 086476FF064
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 13:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237655AbjEKLKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 07:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjEKLKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 07:10:39 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8BF65A8
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 04:10:38 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-956ff2399c9so1619458266b.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 04:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683803437; x=1686395437;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q7KxdBG/NeF6sWMIRS2EQ/HmjBGOWua4oCF2RfFjnYc=;
        b=Dyi8ve2u1kiMIWDo8UAn+si7P3sNVvuq0CApWRjlvwBj6ZP4dK29ykmg1GNZ8cX4GN
         HZpNyBjusvuWiJMFksx5I6awxewE+5LnKfpUMIm0iyGrhMLx/Y82PIcsp/u+5VXW8RBm
         WsLCfujGqUrUAKmQYf8vL9SryPdGqj2+4WZb7yxegaaxUeFfELEY/GQQxzzc8rGBvSlV
         AlODw0ga1I5pwhKcfjzsqpopLfIVIcaFeRS/SxTDtyMW7b/vuRUbwmGVUQr7eZ0ulQPC
         veSXvM2/O2gECUGy7KrcaJeHcXgaTjh33oRwi6DrMrD+XjcM2zgBKyG5yfYNcV1CdZAL
         xgOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683803437; x=1686395437;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q7KxdBG/NeF6sWMIRS2EQ/HmjBGOWua4oCF2RfFjnYc=;
        b=JNzpM0twwqgVAs1c+QZKugD9GyA9izP/xAInhkJyMVLoa+c/KiB6m68i6fBdLtdp2r
         e1/MXL6Ao2BU/C6NsAgiIyuhoFvYNq8+WKhC6Yrek8HKSMUg+yHmi0DXfXIedExzWK2c
         +YKzZkVqLsIz8YO/Aj1/DMhLg5/oJicSFvfUQXXlJlmyz1CXiICmS7LtPfXHoMZWBp4L
         W38MXF1HtAhWAdTYGW00eEfxB6F+y/ljs7GZRbub3JdSYFluAN8neIpKM3v56pawwEXG
         jD7xSfB3aWJMF9L1fxXclgY/HyfYIuswZkhFLzhy+CvJg+DmcLYQp1w/PgDOTMI5AL8z
         AsIw==
X-Gm-Message-State: AC+VfDwhUxWYbyL3DzgQiQUG8k5uGsb/cpUyAIBsF8qLOdr29rTwAVJM
        tPoyV44IovfUPxLA/Uufqzn5gg==
X-Google-Smtp-Source: ACHHUZ5nKsEhAnsseBCGuUqg/8Vzj4ZcA5NvGpLmygmAm9j0zZJqO7fOoh4aJ+42swdqT33rFR9mcw==
X-Received: by 2002:a17:907:3d90:b0:968:236:eb17 with SMTP id he16-20020a1709073d9000b009680236eb17mr12046696ejc.24.1683803436971;
        Thu, 11 May 2023 04:10:36 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:41e7:1b68:d38e:1348? ([2a02:810d:15c0:828:41e7:1b68:d38e:1348])
        by smtp.gmail.com with ESMTPSA id ze12-20020a170906ef8c00b009659fa6eeddsm3870844ejb.196.2023.05.11.04.10.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 04:10:36 -0700 (PDT)
Message-ID: <8e98b31a-ef4d-a8bd-32f3-e6f496f2b138@linaro.org>
Date:   Thu, 11 May 2023 13:10:35 +0200
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <7Zga7RBqLNcaG5ylTIY4Qn7CUdE1IJsW@localhost>
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

On 11/05/2023 12:15, Aidan MacDonald wrote:
> 
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:
> 
>> On 10/05/2023 13:23, Aidan MacDonald wrote:
>>> ...
>>> +  ess,max-clock-div:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    description:
>>> +      Sets the maximum MCLK divider for generating the internal CLK.
>>> +      CLK must be at least 20x the I2C bus speed or I2C transactions
>>> +      will fail. The maximum divider should be chosen to ensure that
>>> +      CLK will not fall below the limit.
>>> +    enum:
>>> +      - 1
>>> +      - 2
>>> +      - 4
>>> +      - 8
>>> +    default: 1
>>
>> Why do you need to customize it per board?
>>
> 
> There's no generic API to read or change the bus speed (SCL frequency)
> for I2C adapters, so it's impossible to calculate a limit on the MCLK
> divider automatically.
> 
> Defaulting to 1 is always safe, but means wasting power at lower sample
> rates. If you know what the bus speed is you can use a higher divider
> limit to save power, and it has to be done at the board/firmware level
> because that's the only place where the bus speed is known.

If I understand correctly, you only miss a way to get bus_freq_hz from
i2c_timings to calculate the divider by yourself? This looks like Linux
limitation, so we shouldn't push it into DT, but rather fix Linux. The
I2C bus rate is known, the MCLK rate as well, so divider is possible to
deduce.

I am actually surprised that I2C core does not store the timings
anywhere and each bus host has to deal with it on its own.

Best regards,
Krzysztof

