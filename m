Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88808653057
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 12:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234500AbiLULlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 06:41:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLULlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 06:41:15 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFEEDEA6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 03:41:14 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id cf42so23117130lfb.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 03:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TFr+KkgF0f2zsju3on50AY6Jqv8wMu+vCgWh7SKVHvU=;
        b=a2EUh3XRGsS46OpUUPOejw8y2YIi+wRZ3E9NbbtKa16cGTd+sMjTKjBtYMbjgClYen
         +fLzFb+nskcXKLmkZaNaO1ieTjC+oJ3wy7O4NDF+1zmHsj0UFJBGRaxsxxjHm2Yrr7J/
         HD/Y25cJ58bdyREnEe1nqQJQsBPe03KSi5r2ovgkObqPEBGGvQKY5Oj5nUOHlPp9e6Ly
         reFgdBt6JNfcY4LfLAoObxVIG0a8qYY4XQkCM0vIKeD+uAsmm47CgeFDTUI/Drrp4+Jw
         cww7q/I/Ds/Rw7sa+vjwQS2GQzZEbwHWGG22HCGeJknxoJYOfvuhzNza/DEpSqvag4BG
         xkLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TFr+KkgF0f2zsju3on50AY6Jqv8wMu+vCgWh7SKVHvU=;
        b=CUe6L6ljvrWijFts+afE9TkI4AG2ZULjecAx3M6nAITojKo2HQqz7h11DcakyTE63D
         PdoMX6Ll2/WoofiL3/CFRtzulC+6vlA7IGU39oniyRymv5a3MJxirqAHmtB1LnTtAhN9
         fydE8aHcl99xt+7rxB/PASnomsQPilGfHLl22qKmbCd3hqF/Eu4c6WtMi3vj0MRrfBcp
         FsMisZjU+XLBqaoUJExJXeldACHV46aVKjfvTW8z6Zb7yqege8sP57fWtej1QbuyB34m
         RMSzkha5xAKq7WjgMdJnfvU2Np06unZF3R391zsLKMjW4dQbdpO2lT5WaN3T96LsqZZO
         zVeQ==
X-Gm-Message-State: AFqh2kp5DRFQHK65QUJGPReaX3GVxU4GNCfBuNj6ijejaijpzP+y5ijx
        VYJ/B4TpXxcTYLtyjo4vJHPzWA==
X-Google-Smtp-Source: AMrXdXsyPsMudczLvkigBGwO5mqibV7RZCAK5DqU/SA/VLHDDLkZTKPd3hjMSTk2tDvZ0oatgeXkNw==
X-Received: by 2002:a05:6512:3e0c:b0:4b5:a5c7:3286 with SMTP id i12-20020a0565123e0c00b004b5a5c73286mr681061lfv.9.1671622872355;
        Wed, 21 Dec 2022 03:41:12 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id f14-20020a056512360e00b004b551cdfe13sm1800382lfs.279.2022.12.21.03.41.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 03:41:11 -0800 (PST)
Message-ID: <3f7dc970-4cc0-7d8e-b33f-83c9dd368b11@linaro.org>
Date:   Wed, 21 Dec 2022 12:41:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v4 2/2] dt-bindings: arm: rockchip: Add EmbedFire LubanCat
 1
Content-Language: en-US
To:     ty <zonyitoo@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, DHDAXCW <lasstp5011@gmail.com>
References: <Y6KfFEChA67E7oX/@VM-66-53-centos>
 <5a7907e3-f79e-5de9-ed1b-ec24ea52c437@linaro.org>
 <CAMmci2UgwqDyPPJXwGRsMW1Y1Cy2c6LMybk+7v7pGz-LtYzGTw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAMmci2UgwqDyPPJXwGRsMW1Y1Cy2c6LMybk+7v7pGz-LtYzGTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/12/2022 11:46, ty wrote:
> Dear Kozlowski,
> 
> Sorry that we didn't fully get the idea in your previous comments.
> 
>>
>> On 21/12/2022 06:52, Yuteng Zhong wrote:
>>> from: DHDAXCW <lasstp5011@gmail.com>
>>>
>>> LubanCat 1 is a Rockchip RK3566 SBC based
>>> is developed by EmbedFire Electronics Co., Ltd.
>>> Mini Linux Card Type Cheap Computer Development Board
>>
>> This is a friendly reminder during the review process.
>>
>> It seems my previous comments were not fully addressed. Maybe my
>> feedback got lost between the quotes, maybe you just forgot to apply it.
>> Please go back to the previous discussion and either implement all
>> requested changes or keep discussing them.
>>
>> Thank you.
> 
> Your pervious comment were:
> 
>> Please wrap commit message according to Linux coding style / submission
>> process:
>> https://elixir.bootlin.com/linux/v5.18-rc4/source/Documentation/process/submitting-patches.rst#L586
> 
> So I think there must be something wrong in the message but I didn't
> notice. This message has a `from` line, and the body was wrapped at 75
> columns. Please help me make it better.

You do not wrap at 75, but at some other place. Just put it to editor
and check where is wrapping (count characters).

> 
> 
> 
>>>
>>> Signed-off-by: Yuteng Zhong <zonyitoo@gmail.com>
>>> Signed-off-by: DHDAXCW <lasstp5011@gmail.com>
>>> ---
>>>  Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
>>> index 88ff4422a8c1..84d39a3a8843 100644
>>> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
>>> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
>>> @@ -781,6 +781,11 @@ properties:
>>>            - const: rockchip,rk3568-bpi-r2pro
>>>            - const: rockchip,rk3568
>>>
>>> +      - description: EmbedFire LubanCat 1
>>> +        items:
>>> +          - const: embedfire,lubancat-1
>>> +          - const: rockchip,rk3566
>>
>> Here as well.
> 
> This change was addressing the previous comment in V2:
> 
>> This is separate patch. Does not look like properly ordered. Don't add
>> stuff at the end of files/lists.
> 
> The previous PATCH v2 merged changes in 3 diffent files:
> 
> 1. arch/arm64/boot/dts/rockchip/Makefile
> 2. arch/arm64/boot/dts/rockchip/rk3566-lubancat-1.dts
> 3. Documentation/devicetree/bindings/arm/rockchip.yaml
> 
> What we do in this PATCH v4 was separated the 3 into a separated patch.

So how did you solve the comment "Does not look like properly ordered.
Don't add stuff at the end of files/lists."? What did you change to
solve it?

Best regards,
Krzysztof

