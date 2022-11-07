Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E800861F1E9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 12:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbiKGLdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 06:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbiKGLdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 06:33:38 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6906352
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 03:33:36 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id c1so14690257lfi.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 03:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VxI8WoIaewd53an8ZdvD6m/HYBA42Wa5t8ObrpsudSE=;
        b=g9hVurBa6N5czBfveJTkVxw8tnfhfMr8lPLRApBXMcEE8bRRP6ar0fJiYumMrnrjfQ
         CYzdYkc38AXlNdcU+yJBwkqHi45hOwK+g/aSM2X2FYeyge27ElevSxfbSqRTiw6CyRZr
         tVbaluZRfbB8arK8mKF5StpTnORSxvEUX+4oU2I/jA0TrSRC4kJRzAfneSuEKpIe78Pe
         OhTOJFVBAfFkThbvjha5U1h3MvCdMMkKshX+ZgaghRFO7QF8/B4v5nBtiQZu4f8h7wgV
         cexqXX8wn46Ic5jL4mi5uXBDbaqH/uzO/FcgHeCP61LugDe5HzM5cXQLwHvgjkLaYY4x
         o2jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VxI8WoIaewd53an8ZdvD6m/HYBA42Wa5t8ObrpsudSE=;
        b=16mO9mIKVA6xq7od/O9rY3x/XnYx6LfsVOQtKhhxELJxRNjWDupbSFPt1aRUq9tZEx
         sVPLKRGe72hsf58b3WJOlG529LwbZPU2eNVHmf8NaQJrT5yjQDXjRnlDjebOBI4lE/jf
         vUnPosjupFa3G/qlh9mruuKq6zJ+nSGfoSufu7xybfRFAOy2vJkE6kOYh/pSbCsLn3aO
         +djoVV29Oz4guDDa3Za/IfxpAFR9zV9Bia4GqQbv8lYkBX93kgOhg+M5ecdhQUFdZiio
         rCQjkfnubJqLeR0P5g4lFMRFn6sWyYmQ2ayCpMnQzYt6ynJE/DwYPrxVMI24xJFxE9Cy
         KHxA==
X-Gm-Message-State: ACrzQf1E2t3Jy0mxdY5PdFfNpCJ412vO/V9rTQOn3CK0XydVevpPb7Th
        33ahH8QvFuul7rUwWr82Sm/UXg==
X-Google-Smtp-Source: AMsMyM7kUFCpOI3evQFFO9fVKPNN9d1xB0Y37za5WBTTwpUm3cCMQBjcuFBvk0h3AQNNC+TUbG3tQw==
X-Received: by 2002:a19:650c:0:b0:4b0:38df:e825 with SMTP id z12-20020a19650c000000b004b038dfe825mr410572lfb.471.1667820814878;
        Mon, 07 Nov 2022 03:33:34 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id o4-20020ac25e24000000b0049c86ca95bfsm1198271lfg.52.2022.11.07.03.33.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 03:33:34 -0800 (PST)
Message-ID: <9bcefe53-5ac8-5265-a0ac-83cdd69798eb@linaro.org>
Date:   Mon, 7 Nov 2022 12:33:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/2] dt-bindings: interrupt-controller: add yaml for
 LoongArch CPU interrupt controller
Content-Language: en-US
To:     Liu Peibao <liupeibao@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     Jianmin Lv <lvjianmin@loongson.cn>,
        Yinbo Zhu <zhuyinbo@loongson.cn>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221107023404.26730-1-liupeibao@loongson.cn>
 <20221107023404.26730-2-liupeibao@loongson.cn>
 <b45b8cf8-de9d-7132-1a35-48deeb4b79d5@linaro.org>
 <196e80d8-f4fb-7393-81a5-bca757c805f5@loongson.cn>
 <e92beaac-aa88-0336-cb30-7de438de67c9@linaro.org>
 <e5910bf9-b662-a733-57f2-5faccb038cb1@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <e5910bf9-b662-a733-57f2-5faccb038cb1@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/2022 12:20, Liu Peibao wrote:
> On 11/7/22 5:55 PM, Krzysztof Kozlowski wrote:
>> On 07/11/2022 10:21, Liu Peibao wrote:
>>> On 11/7/22 4:28 PM, Krzysztof Kozlowski wrote:
>>>> On 07/11/2022 03:34, Liu Peibao wrote:
>>>>
>>>> Add commit msg explaining what you are doing here (e.g. the hardware).
>>>>
>>>
>>> I just add this yaml for what I did in patch 1/2 and the header seems enough
>>> to describe what I want to, so I did not add the commit log.
>>
>> This should instead describe briefly the hardware here.
>>
> 
> How about I add the following comments:
> 
> "Current LoongArch compatible CPUs support 14 CPU IRQs. We can describe how
> the 14 IRQs are wired to the platforms internal interrupt controller cascade
> by devicetree."

Sure.

>>>>> +    const: loongarch,cpu-interrupt-controller
>>>>
>>>> You have exactly one and only one type of CPU interrupt controller for
>>>> all your Loongarch designs? All current and all future? All?
>>>>
>>>
>>> It is sure of that "all current and recent designs". It is really hard to limit the
>>> design in the distant future.
>>>
>>> And if there is updating, maybe I will add additional things like this:
>>> "loongarch,cpu-interrupt-controller-2.0".
>>
>> Unless you have a clear versioning of your hardware, adding 2.0 won't be
>> correct. Don't you have this for specific SoC?
>>
> 
> The "loongarch,cpu-interrupt-controller" now is compatible for all the LoongArch
> compatible CPUs, not specific for one chip. And we may keep this CPU interrupt
> controller for a long time.

Still specific compatibles (as fallbacks) are used for such cases, so
why is this different? Hardware compatible with several other devices
still gets specific compatible, right?

You cannot have "-2.0" suffix in the future just because "you want", so
be sure that your choice is reasonable.

Best regards,
Krzysztof

