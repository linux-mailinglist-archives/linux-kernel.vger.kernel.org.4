Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A10969A72A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 09:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbjBQIk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 03:40:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjBQIkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 03:40:55 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7AB271B
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 00:40:54 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id v11so10220273edx.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 00:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yNlzdhkOQHzq20NVyGLukWTdEN+zeap3hr8OBMls538=;
        b=xD6/IJpi470BpQTRI/51fSBug+Im2ui4QtKq+o4q97OX5PiWIG3hNYI27KdZnkUYgh
         kosxXQJkJhA0oRORMQKnD2L8v3TsBt1bcb/Wp5wxbdmKuejaoBsrPMKGYWa3l3xM4NIu
         SDYChuxobHu2bS4v0WbwIm/U3GMasJcboFEumhaepTHUzGNo+2oTYY0MfjaQYPVaXYcE
         vpSbqMdqCaRcdbcPqAzLbFISfPMETDr9GZSS5h17oYPSPy9RmjgamOAyCMnfrar5xmaC
         11YwTblo+ykwObG+HDz4V2xHFmwBj/X3WYOt8+acK5thggzxlI2bThv6thANwTn5D7T6
         JE9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yNlzdhkOQHzq20NVyGLukWTdEN+zeap3hr8OBMls538=;
        b=mbbxLIII/tpgI0vqFRJg/0ymRgVgEZCHjuwPgtUDjh3XTItuxPfRZTlExLc05DulYQ
         8QE97XxjkBinFQAr4L4+v1VxJfWAgCcv1bF8qnhCkhHH+eK4fWtinSYS1CicBPah2KIR
         Dt5xeDoFpReBYcr9HMQouy+ya2jQJnB2MkaAmjFcBnngYDRw/mFSElfn6F0KYEAq/rNw
         eGq91hfNsqx97DB5JNtLOzxOFUB6Jc04P0Vez9Q0biT22JfRVFw1TsHkaYVcfjnr5L/9
         ImboDcbX/b9u4B64qI9I2lmC9bf4pNXY/9aNnmio6ZQ6t2s1vWNzbGyQdE58kJNJvRE2
         adWg==
X-Gm-Message-State: AO0yUKXiHuJ0zbr+tfD/vsOMU/u0qDzTuZgeH6c1qjL/9yRjuklvecQ0
        qnmmVlXCBG/q0QKjLcBUtFgrVA==
X-Google-Smtp-Source: AK7set9PRGCfdro26MLR7ocLmnYzrc1z44bpXULKIiN9W8O9OqdmP07SWABEAtqN/zho+4rT/h7Ovw==
X-Received: by 2002:a17:906:308a:b0:8b1:81eb:159e with SMTP id 10-20020a170906308a00b008b181eb159emr1395860ejv.7.1676623252738;
        Fri, 17 Feb 2023 00:40:52 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id lt13-20020a170906fa8d00b00888d593ce76sm1859298ejb.72.2023.02.17.00.40.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 00:40:52 -0800 (PST)
Message-ID: <4dcaaa70-11e0-fc9d-da03-224d34e36983@linaro.org>
Date:   Fri, 17 Feb 2023 09:40:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH V2 1/2] dt-bindings: interrupt-controller: Add Loongson
 EIOINTC
Content-Language: en-US
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
 <CAMpQs4K+aYGrOoWy04vrbEy53kba9zUzGkOwD34pwAH0c=D8iA@mail.gmail.com>
 <49c8255e-66f3-fa1f-2949-1f03f77a0fa4@linaro.org>
 <CAMpQs4KennWg60ccQ5NYOs=5a9gqTk_bKY26noQ3u0qLQSBg_w@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAMpQs4KennWg60ccQ5NYOs=5a9gqTk_bKY26noQ3u0qLQSBg_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/02/2023 07:09, Binbin Zhou wrote:

>>> Hi Krzysztof:
>>>
>>> Allow me to give a brief overview of the current status of eiointc (DT-based):
>>>      Loongson-3A series supports eiointc;
>>>      Loongson-2K1000 does not support eiointc now;
>>>      Loongson-2K0500 supports eiointc, with differences from
>>> Loongson-3, e.g. only up to 128 devices are supported;
>>>      Loongson-2K2000 supports eiointc, similar to Loongson-3.
>>>      ....
>>>
>>> As can be seen, there is now a bit of confusion in the chip's design of eiointc.
>>>
>>> The design of eiointc is probably refined step by step with the chip.
>>> The same version of eiointc can be used for multiple chips, and the
>>> same chip series may also use different versions of eiointc. Low-end
>>> chips may use eiointc-2.0, and high-end chips may use eiointc-1.0,
>>> depending on the time it's produced.
>>>
>>> So in the Loongson-2K series I have defined the current state as
>>> eiointc-1.0, using the dts property to indicate the maximum number of
>>> devices supported by eiointc that can be used directly in the driver.
>>>
>>> If there are new changes to the design later on, such as the
>>> definition of registers, we can call it eiointc-2.0, which can also
>>> cover more than one chip.
>>
>> Just go with SoC-based compatibles. If your version is not specific
>> enough, then it is not a good way to represent the hardware.
>>
> 
> Hi Krzysztof:
> 
> I have tried to write the following  SoC-based compatibles,  is it fine?
> 
> compatible:
>     enum:
>       - loongson,ls3a-eiointc  # For MIPS Loongson-3A if necessary.
>       - loongson,ls2k0500-eiointc
>       - loongson,ls2k200-eiointc

Looks good, but didn't you state these are compatible between each
other? I have impression there is a common set, so maybe one compatible
work on other device with reduced number of devices?

Best regards,
Krzysztof

