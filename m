Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A07F69854D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 21:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjBOUMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 15:12:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjBOUMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 15:12:23 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543AA1E29D
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 12:12:22 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id fj20so25472498edb.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 12:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZWoZA8qGgq7/x6EJNe+HmaR5fU3v8UqOPtojqnq1sKg=;
        b=MsGryKrtxHBLaqw/J3F42LFYUz5sSQzBldJ0cMFEzla/sx+xMPqtLJEDuKS1QNi98k
         iWAUSYZxKkhY5NCUw04aRg9xrjCr12i3b1r4pQLuNUZILpblRbtFk6pg1Wo7qhpzGF7q
         naNqeo4EW7i2JDAQeW/Q/XLtRk2JXPaDQ9AZIJTlJOJNL7dMCGelqkY7TNUiCbeJKPtB
         3JIuJxAmdsyA07dsHFlAqcrYdRvbVgsCsU3bm1jtUaVQkgcpSsSh979kSjKcXxtenKHh
         kgaU78naEAHo+Yb6LTN1O02s8gsrlo01HK7r4C0Obi1E3qs0LQAy6GJaPzLHwyMYJ9tg
         bA5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZWoZA8qGgq7/x6EJNe+HmaR5fU3v8UqOPtojqnq1sKg=;
        b=nQmgl4s7c3jkKFkSHpdhH+UxtEkVpenTUZiz25BTC4097RNfsOfj95poHL0MZX5fUn
         gV+0//rmjxnGoxSHdR83Ey8P4xu9h7mIOPyFTKzoAGShzoH/aSl8UQNWWykVcRZwxkgj
         kmOv3LyynRONhhPVqKhjsNPGTTxvRQSpkYZMb6/Tfs0+1VBI2byZxR8ld/bcKNvUISz5
         2wU6YecJnoxzNZ4MlOXd66reRhIU8nxFmgeyKa9YxRt/UiyQIqXdqP6bYbEWlBu04o62
         fArdb6foWfHAP+kubHZfgQ8qTvaVHrGE8wNtpnL7Y1OW4VNpuFKKRJaNSOkcuR6hTvYK
         SLfA==
X-Gm-Message-State: AO0yUKWIxgjwtfXojvByla2IFf5N2nPB32Ygx4LZzAdeb7Ayjp0q0umT
        PiYBVWrPnDdihB3i51PRt/t/mg==
X-Google-Smtp-Source: AK7set/jHl1Odp5mSZbVYnAK8AAz4shx+jKhUVZbGwC/0QQ2RDATXndC8SUR3jQp9W3UQU0pjK4lyA==
X-Received: by 2002:aa7:dc18:0:b0:4ad:152a:9ded with SMTP id b24-20020aa7dc18000000b004ad152a9dedmr967831edu.32.1676491940846;
        Wed, 15 Feb 2023 12:12:20 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id 29-20020a508e5d000000b004acdef7baaesm2709053edx.96.2023.02.15.12.12.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 12:12:20 -0800 (PST)
Message-ID: <730f6bf9-ce57-6834-12e0-b60abbfb2e1f@linaro.org>
Date:   Wed, 15 Feb 2023 21:12:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH V2 1/2] dt-bindings: interrupt-controller: Add Loongson
 EIOINTC
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Binbin Zhou <zhoubb.aaron@gmail.com>
Cc:     Binbin Zhou <zhoubinbin@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        loongarch@lists.linux.dev, devicetree@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
References: <cover.1676289084.git.zhoubinbin@loongson.cn>
 <a9f697906df6599e6b001981e668479da71aa7a0.1676289084.git.zhoubinbin@loongson.cn>
 <df464409-9a93-c057-5f66-923a9e24696a@linaro.org>
 <CAMpQs4JX0Vgf5tvv5Yw5eLGANFfn1p=iQ_kMS0yQPV6kE2tN1g@mail.gmail.com>
 <23068d0c-d37c-0563-e1c1-e4d112059f5b@linaro.org>
In-Reply-To: <23068d0c-d37c-0563-e1c1-e4d112059f5b@linaro.org>
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

On 14/02/2023 13:43, Krzysztof Kozlowski wrote:
>>
>>>
>>>> +
>>>> +  reg:
>>>> +    minItems: 1
>>>> +    maxItems: 3
>>>
>>> You need to describe the items.>>>
>>>> +
>>>> +  interrupt-controller: true
>>>> +
>>>> +  interrupts:
>>>> +    description:
>>>> +      Interrupt source of the CPU interrupts.
>>>
>>> You need to describe the items.
>>
>> Do you mean a more detailed description?
> 
> I mean constraints on interrupts and/or description if they are not obvious.


Actually I noticed that for interrupts you provided the name, so it is
description and you just need maxItems:1.

The reg however need list of items which clearly documents what is there.

Best regards,
Krzysztof

