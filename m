Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19146C0F6A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 11:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjCTKmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 06:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjCTKmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 06:42:18 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A5827993
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:40:25 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id g17so14296566lfv.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679308798;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=grRH4NuVjt1XazQwua0TqeDWJzVjyHC+00bGvm+991w=;
        b=j3Q/3iuFNvsMRY0v692DqUltXzp1dIJq6dJCikzycfPVfAImbd0U0oT6VgFfWMaQ8a
         vOEgt7P4mtEIoFWZPFm58qC7xlX46jU12HvXM0aqO1rXWmA3jIBXDu+tQvFogRSwJ7Q4
         1B6B6YP6K9m5IybKDJeapTeed9CxCP10C19Syg7a0bqXOvoetNfMsmeX3s7pleR+22Cf
         rQNpScvjnF8GCG8Jbm4qfIlhBoJZO3HDLtUpNxeLgHP/Qz+0vpkhZWp+RZM+ZwlV1JlM
         A2SFw9eZ8Mq66GFBkd39b69cpwSRiowEUdgpv5fbU4XyGasMBiGAHEhPL0d708gyAbZ3
         BX6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679308798;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=grRH4NuVjt1XazQwua0TqeDWJzVjyHC+00bGvm+991w=;
        b=jcHYn1fUHk603GdxcLXJzcXDPBiFqX6byoX8Z/YcoSmJcLQmF1msx2VXhLnTiA4Ckx
         VZFbwQu+twSqklcwuGJ0RznrYp2AJRMlLNa6JO4M/A1BJMqmimhrDyU7yLI2s4a3GYaZ
         fp1TX4yHKvLvrD1T9kO6Y2VN5I+kgjDeRw44kdx5JWj3KrBtVFOO970Mw6eIzeuvGGOU
         hjo8y8iGvyT9HKIrLg5IpdOW3J9uTpgA0ckh8WX2X7SylZwXNVEJlLq0pDTF5dLIJR2O
         iV5dUhy6zXz+uTiN1FOYa6rtsrG3nPxbY1zgT9yuFklL6heQKXUdhXrimUXoR8LvWir/
         5SSw==
X-Gm-Message-State: AO0yUKVbVRiIgqFho+Q7yBzIHZjLp1HOBmjToVRNXE9CN4IDdyTSOn5d
        Vaqj0LSQewNBQMgdJCMABdwgaA==
X-Google-Smtp-Source: AK7set+36z+CyOiyN78yCcUMJLmwtnpXQyLubsOfMRU3Vx0PAfxfr+2Wvji0JpELECJNK6z8plNTSQ==
X-Received: by 2002:a05:6512:3d24:b0:4d8:86c1:478c with SMTP id d36-20020a0565123d2400b004d886c1478cmr3521820lfv.33.1679308798457;
        Mon, 20 Mar 2023 03:39:58 -0700 (PDT)
Received: from [192.168.1.101] (abym238.neoplus.adsl.tpnet.pl. [83.9.32.238])
        by smtp.gmail.com with ESMTPSA id f2-20020a2e9502000000b00298591be990sm1683115ljh.40.2023.03.20.03.39.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 03:39:58 -0700 (PDT)
Message-ID: <6ae97b26-b1e7-b382-b6f6-053afe26a1a2@linaro.org>
Date:   Mon, 20 Mar 2023 11:39:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 3/3] arm64: dts: qcom: Split out SA8155P and use correct
 RPMh power domains
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, agross@kernel.org,
        krzysztof.kozlowski@linaro.org, marijn.suijten@somainline.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230214095435.2192153-1-konrad.dybcio@linaro.org>
 <20230214095435.2192153-3-konrad.dybcio@linaro.org>
 <20230314001052.7qvgbwkl73x22oll@ripper>
 <eaf2ca0d-4d90-b68b-3b36-8bb0148cfb95@linaro.org>
 <ee1ebac4-bf18-019a-f770-5cb88703d06b@linaro.org>
 <20230315230024.wxuqthay74i5zgrq@ripper>
 <3d3117d2-b3eb-1174-7061-b899cdcdf6ce@linaro.org>
 <20230320021957.yzg6zhrhjr36rcz4@ripper>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230320021957.yzg6zhrhjr36rcz4@ripper>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20.03.2023 03:19, Bjorn Andersson wrote:
> On Thu, Mar 16, 2023 at 12:50:49AM +0100, Konrad Dybcio wrote:
>> On 16.03.2023 00:00, Bjorn Andersson wrote:
>>> On Tue, Mar 14, 2023 at 12:41:45PM +0100, Konrad Dybcio wrote:
>>>>
>>>>
>>>> On 14.03.2023 12:36, Konrad Dybcio wrote:
>>>>>
>>>>>
>>>>> On 14.03.2023 01:10, Bjorn Andersson wrote:
>>>>>> On Tue, Feb 14, 2023 at 10:54:35AM +0100, Konrad Dybcio wrote:
>>>>>>> The RPMhPD setup on SA8155P is different compared to SM8150. Correct
>>>>>>> it to ensure the platform will not try accessing forbidden/missing
>>>>>>> RPMh entries at boot, as a bad vote will hang the machine.
>>>>>>>
>>>>>>
>>>>>> I don't see that this will scale, as soon as someone adds a new device
>>>>>> in sm8150.dtsi that has the need to scale a power rail this will be
>>>>>> forgotten and we will have a mix of references to the SM8150 and SA8155P
>>>>>> value space.
>>>>>>
>>>>>> That said, I think it's reasonable to avoid duplicating the entire
>>>>>> sm8150.dtsi.
>>>>> Yeah, this problem has no obvious good solutions and even though it's
>>>>> not very elegant, this seems to be the less bad one..
>>>>>
>>>>>>
>>>>>> How about making the SA8155P_* macros match the SM8150_* macros?
>>>>>> That way things will fail gracefully if a device node references a
>>>>>> resource not defined for either platform...
>>>>> Okay, let's do that
>>>> Re-thinking it, it's good that the indices don't match, as this way the
>>>> board will (should) refuse to function properly if there's an oversight,
>>>> which may have gone unnoticed if they were matching, so this only guards
>>>> us against programmer error which is not great :/
>>>>
>>>
>>> Right, ensuring that the resource indices never collides would be a good
>>> way to capture this issue, as well as copy-paste errors etc. My
>>> pragmatic proposal is that we make SA8155P_x == SM8150_x where a match
>>> exist, and for the ones that doesn't match we pick numbers that doesn't
>>> collide between the platforms.
>>>
>>> The alternative is to start SA8155P_x at 11, but it's different and
>>> forces sa8155p.dtsi to redefine every single power-domains property...
>>>
>>>
>>> This does bring back the feeling that it was a mistake to include the
>>> platform name in these defines in the first place... Not sure if it's
>>> worth mixing generic defines into the picture at this point, given that
>>> we I don't see a way to use them on any existing platform.
>> TBF we could, think:
>>
>> sm1234_rpmpds[] = {
>> 	[CX] = &foobar1,
>> 	[CX_AO] = &foobar1_ao,
>>
>> 	[...]
>>
>> 	/* Legacy DT bindings */
>> 	[SM1234_CX] = &foobar1,
>> 	[SM1234_CX_AO] = &foobar1_ao,
>> };
>>
>> WDYT?
> 
> Given that every platform got these defines different we'd have to start
> at the new generic list at 17 (which would throw away 136 bytes per
> platform), if we're going to allow the scheme for existing platforms.
> Which I don't fancy.
> 
> It's not super-pretty to mix and match, but I think I would be okay
> switching to this scheme for new platforms.
> 
> PS. We'd better prefix the defines with something (perhaps RPM_?)
Perhaps just VDD_{CX/MX/..}? We reference the rpm(h)pd's phandle
each time it's used, anyway.

Konrad
> 
> Regards,
> Bjorn
