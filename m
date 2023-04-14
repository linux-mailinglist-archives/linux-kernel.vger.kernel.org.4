Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013746E1D65
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 09:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjDNHmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 03:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjDNHml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 03:42:41 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5D0E65
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 00:42:38 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id q23so33990480ejz.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 00:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681458157; x=1684050157;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PYpcf8R8QGaHDcrBQ4ZMSmtY+ByQQt2dDOsbEdCIjII=;
        b=LwcIlKmI6UzDZBCRtIWOfCPYlTd7RYyc99ld0pahVWPdEXnLp99R7nrXyBFaIVTqrw
         nDLfjsV5BOB+PuVDckpdfxpvMM4kARClb2odEin4VvUsLahRP8NVlIpOAYT2K26AcNPF
         M2cLMR+WnERfdeoxTfTUmG4ex7hWXpivWe+JO7l5t3lp9TDcCVTIbwz78JhrDASs8jza
         fxdnbLaWNC/LSfqIcQ1Zk6k+/DENu8VRvxUh2vtu8vNPhFrR6suKrCJOaGYyB0OO90fM
         /iKmBu6zP3UvYlMKeWldnWGlw7KCUEqe619h8phllrueWf7dsf/pmqpeQ/hvd+IHFBXT
         GYXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681458157; x=1684050157;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PYpcf8R8QGaHDcrBQ4ZMSmtY+ByQQt2dDOsbEdCIjII=;
        b=i4d5u1YQvUznMClVawMiFiOM90XyAe4eiOdowNzWw66w+ghZ46GgRTWCVHZwHAVdk2
         g4kNYEhQ/ngCBsRA4+J4JH3aEhpodd4SjVqSXyHhJeNqlfA2tRZDeG+gJfMFYxidkntL
         u2c9llX8U4r5hNMArKsf6C2h6w2g9Pw7Z4/tnNxeqwk5RNBbqDZiRwqvX/ysvay4COey
         KIVMSzi9ht7rvgbgL5uKEjr971UWvqr5c46xgOxy/J5F3OoOXMB4XW3utTFU8q82paPr
         +4oy7p7wTyTxSYB5TzMW1w9UiYATIEOXL2xpavHnD9xpxy8YdIs1CytXwH8duyMRsUL8
         NZUQ==
X-Gm-Message-State: AAQBX9ezWkwXTerUjX14xaAHGuoGLgYuUcbmypQSPM/+3Syfj0Q024tD
        tsKZmXmb+gWe5ONvt3CSoGr6Rg==
X-Google-Smtp-Source: AKy350Y/SU83zzrO89a/MUOol+3Nh+8JvARjeI1fMpnaKc1PS6yUx0kxHH92K6xpptIL1S4nI4jEhA==
X-Received: by 2002:a17:906:480f:b0:94a:7225:92f with SMTP id w15-20020a170906480f00b0094a7225092fmr5547165ejq.11.1681458156921;
        Fri, 14 Apr 2023 00:42:36 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:8a60:6b0f:105a:eefb? ([2a02:810d:15c0:828:8a60:6b0f:105a:eefb])
        by smtp.gmail.com with ESMTPSA id b24-20020a05640202d800b005068053b53dsm626237edx.73.2023.04.14.00.42.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 00:42:36 -0700 (PDT)
Message-ID: <111eabde-3a23-6e07-cd94-96d20670f3de@linaro.org>
Date:   Fri, 14 Apr 2023 09:42:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 tty-next 1/2] dt-bindings: serial: ni,ni16650: add
 bindings
Content-Language: en-US
To:     Brenda Streiff <brenda.streiff@ni.com>
Cc:     ilpo.jarvinen@linux.intel.com,
        Gratian Crisan <gratian.crisan@ni.com>,
        Jason Smith <jason.smith@ni.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230329154235.615349-1-brenda.streiff@ni.com>
 <20230410211152.94332-1-brenda.streiff@ni.com>
 <20230410211152.94332-2-brenda.streiff@ni.com>
 <b2f81c57-9b7c-9ad6-6ce6-cc94703599db@linaro.org>
 <b92e2f18-4fd0-0510-4a85-36d7a200c9fe@ni.com>
 <6f9cfd54-c8cf-7395-e7bd-c350a06c8f16@linaro.org>
 <c7adbaf3-346e-cafd-e831-95f9c2900d13@ni.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <c7adbaf3-346e-cafd-e831-95f9c2900d13@ni.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2023 22:44, Brenda Streiff wrote:
> 
> 
> On 4/13/23 02:39, Krzysztof Kozlowski wrote:
>> On 13/04/2023 00:24, Brenda Streiff wrote:
>>> On 4/11/23 00:44, Krzysztof Kozlowski wrote:
>>>> On 10/04/2023 23:11, Brenda Streiff wrote:
>>>>> +
>>>>> +  interrupts:
>>>>> +    maxItems: 1
>>>>> +
>>>>> +  clock-frequency: true
>>>>
>>>> I missed it last time - why do you need this property? You do not have
>>>> any clock input, so which clock's frequency is it?
>>>>
>>>
>>> This is the clock frequency of the UART; on our x86-based platforms this
>>> comes from the LPC clock, on Zynq-7000 it's derived from a clock in the
>>> FPGA. This is used to set struct uart_port::uartclk in the serial core,
>>> as it is for other UARTs.
>>>
>>> This clock frequency can vary based on board design (especially on the
>>> x86 side, due to different LPC clocks) but for a given design is fixed-
>>> frequency.
>>
>> So you must have clock input - clocks property. Once you add this, use
>> assigned-clocks to get the rate you want.
>>
>>>
>>> Would you prefer this be documented further? I was following 8250.yaml's
>>> lead here with the simple `true`.
>>
>> I prefer to drop it. It is not correct and a legacy property. Without
>> clock inputs how can you even configure some clock?
> 
> Configure in what respect? Software can't change this clock; it's
> effectively a fixed oscillator.

So where is the clock located? Physically.

> 
> In practice, this would always be pointing at a compatible="fixed-clock"
> which declares a clock-frequency; this seems like "clock-frequency but
> more steps". I can add that, but I'm not clear on what value that adds.

Aren't we talking about two different things? Based on limited
informamtion, I claimed you have clock input. If you have clock input,
then you miss clocks property.

What value would that add? I don't know... the rules that bindings
describe hardware?

> 
> We also have shipping devices with ACPI tables using "clock-frequency",
> so independent of support for "clocks" and "assigned-clocks" for
> devicetree-using systems, I would still have to keep support in the
> driver for a "clock-frequency" device property for ACPI-using systems.

I don't care about ACPI and ACPI has nothing to do with Bindings. We do
not write bindings for ACPI.

What your driver has or has not to do, it's also separate question. I2C
camera sensors solved it long time ago. I don't see why this must be
special.

> 
> (Is there documentation on a standalone clock-property being a legacy
> property that I've missed? 
> I don't see anything of the sort in
> writing-bindings.rst or in dt-schema and I want to make sure that I

dtschema:
  # Legacy clock properties
  clock-frequency:
    description: Legacy property ...

> haven't missed the proper guidance here.)

Best regards,
Krzysztof

