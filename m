Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD8A7704C8B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 13:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbjEPLmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 07:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbjEPLmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 07:42:11 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2969544B6
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 04:42:10 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9661047f8b8so2191648566b.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 04:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684237328; x=1686829328;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7dd+jxyo01xM6Elj5j3Ewa9arjCRO1A5vQvJrDdMrVA=;
        b=oaKRhLTOsWr0cp5nS3K+eXyGIZa1ZOqW0/peqp88GZloMpkRP+y+/o3V5Tb4FFXs20
         fpryACjparz+FPiaYUorHvJOfMEGRf8HDbnNznP5lewpiWbq6jg6JhINSBTMvCYF52WR
         uQY5cmU2DECoBj4oBX8SEsGz4IM+lA+tvK8nnNKNV7ftxNLTnEe18BZmvlcjQ0UJqFia
         J/6i7ltd9ctq573ZTTZ2j8i5ai2+yG1TgnQrqKY1AoYcOA+9ugDen5++NCHSxB/zwMvB
         KtvXqhV8neKX4dmt0I76P++ttxkRF00KcxkNttLCZXFQVXzD7Rt0heggL3vZNpJAOhHG
         r+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684237328; x=1686829328;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7dd+jxyo01xM6Elj5j3Ewa9arjCRO1A5vQvJrDdMrVA=;
        b=Ar2eZGtFSUSzqBz1K+Kl5/vxBBpz+zuo2PnVxtkksBg29y4hrKT9Y4/6r8E4Y5JbpB
         U8nNIr88VFuVVRKwA9amlQ+aJxukhOVqgod9QB+NgNHPbdYX5zxy3Y2TdjcGyKHhTJ/8
         GG/8vXnJLQSWd/Ihm1MN5c9J4mcwHg+lhA/NOHpzF6NXJHvmznmxB/TALzHjxL3OwK1M
         v7qXNP+DoSXu03j1FrzFDhsUDSzg0gHHyScoK5fWAL6KHhrGr4nkzESoeUnTm+q/s07Q
         nDQIlBtBDHEJcvATwjBo3gEjl8ZBvv+gg4rTZ3Kcxt/kTAe4S0lLVFtye4wmY9mMrR5/
         0GSQ==
X-Gm-Message-State: AC+VfDxX7g+f5DmRoTlrhNKe/FRQvyb+cW0r/esc1YnamD3UvsewBIAe
        vzlou9PT2XZdP5w8yCTdk16HPw==
X-Google-Smtp-Source: ACHHUZ5TORQfsqjiqzlCHtscGpUuOUJ0YIj3T/Sqe16I98quxG9QKlegiw2uX92GUEZYHMlRe7JHZA==
X-Received: by 2002:a17:907:9302:b0:94f:59aa:8a7c with SMTP id bu2-20020a170907930200b0094f59aa8a7cmr30721340ejc.20.1684237328508;
        Tue, 16 May 2023 04:42:08 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:77d1:16a1:abe1:84fc? ([2a02:810d:15c0:828:77d1:16a1:abe1:84fc])
        by smtp.gmail.com with ESMTPSA id n12-20020a1709065dac00b009663cf5dc2fsm10928746ejv.66.2023.05.16.04.42.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 04:42:07 -0700 (PDT)
Message-ID: <f013e9a1-81cd-14ed-0126-6edaee3a73fc@linaro.org>
Date:   Tue, 16 May 2023 13:42:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [EXT] Re: [PATCH 1/2 v7] dt-bindings: watchdog: marvell GTI
 system watchdog driver
Content-Language: en-US
To:     Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230508131515.19403-1-bbhushan2@marvell.com>
 <ea9ae4c9-2808-bf22-70a3-bb7e7b1168d0@linaro.org>
 <DM5PR1801MB1883175A2538B85FEF571B7AE3769@DM5PR1801MB1883.namprd18.prod.outlook.com>
 <8119eec8-0190-b6a5-85a7-301bcb81b0c9@linaro.org>
 <DM5PR1801MB1883A414F47BB56E9537673AE3769@DM5PR1801MB1883.namprd18.prod.outlook.com>
 <8b540cc2-bc0d-9d8b-45e6-98410322b3f6@linaro.org>
 <BY3PR18MB4737947E20CB44CE6DAB940DC6799@BY3PR18MB4737.namprd18.prod.outlook.com>
 <578a743e-dee4-59b7-2f4e-290b551211e0@linaro.org>
 <BY3PR18MB47373D22B01071D5DC2B5F5DC6799@BY3PR18MB4737.namprd18.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <BY3PR18MB47373D22B01071D5DC2B5F5DC6799@BY3PR18MB4737.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2023 13:24, Sunil Kovvuri Goutham wrote:
> 
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: Tuesday, May 16, 2023 3:55 PM
>> To: Sunil Kovvuri Goutham <sgoutham@marvell.com>; Bharat Bhushan
>> <bbhushan2@marvell.com>; wim@linux-watchdog.org; linux@roeck-us.net;
>> robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org; linux-
>> watchdog@vger.kernel.org; devicetree@vger.kernel.org; linux-
>> kernel@vger.kernel.org
>> Subject: Re: [EXT] Re: [PATCH 1/2 v7] dt-bindings: watchdog: marvell GTI system
>> watchdog driver
>>
>> On 16/05/2023 12:06, Sunil Kovvuri Goutham wrote:
>>
>>
>>>>>>> Marvell have octeontx2 series of processor which have watchdog timer.
>>>>>>> In 95xx,98xx,96xx are the processors in octeontx2 series of
>>>>>>> processor. So
>>>>>> octeontx2-95xx is on soc, octeontx2-96xx is another and so on.
>>>>>>
>>>>>> No, 95xx is not a processor. Otherwise please point me to exact
>>>>>> product datasheet. Hint: I checked it.
>>>>>
>>>>> Looks like 95xx data sheet is not public, will remove in that case.
>>>>
>>>> We can talk about 96xx. Can you point me to the SoC named exactly like this?
>>>> Hint: I checked it.
>>>
>>> To recap what Bharat mentioned before along with references to individual
>> processors.
>>> OcteonTx2 is a family of processors
>>> https://www.marvell.com/products/data-processing-units.html
>>> Please check for "OCTEON TX2 DPUs"
>>> CN96xx and CN98xx are two silicon variants in this family.
>>> https://www.marvell.com/content/dam/marvell/en/public-collateral/embed
>>> ded-processors/marvell-infrastructure-processors-octeon-tx2-cn92xx-cn9
>>> 6xx-cn98xx-product-brief-2020-02.pdf
>>
>> This is a product brief which further suggests CN96xx is a family (or sub-family).
>>
>> "xx" is pretty often used as family, not as product. Otherwise how one product
>> CN92XX can come with 12-18 cores *in the same time*?
> 
> "xx" here suggests skews, some 92xx may have 18 cores and some may have
> few cores fused out resulting in 12cores.

Is the DTSI for them the same? IOW, 12-core and 18-core SoCs have
exactly the same DTSI with all properties being the same, valid and not
customized by firmware per skew? If we talk about ARM architecture, DTS
expects CPUs there, so I really wonder how do you write one DTS which
has in the same time 12 and 18 enabled CPUs. Remember - the same time
and not changed by firmware.

> 
>>
>>>
>>> Since the HW block is same in all the variants of silicons in this
>>> family, we would like to use a generic string instead of different
>>> compatible string for each one. ie
>>> - const: marvell,octeontx2-wdt
>>> Hope this is okay.
>>
>> https://urldefense.proofpoint.com/v2/url?u=https-
>> 3A__elixir.bootlin.com_linux_v6.1-
>> 2Drc1_source_Documentation_devicetree_bindings_writing-2Dbindings.rst-
>> 23L42&d=DwIDaQ&c=nKjWec2b6R0mOyPaz7xtfQ&r=q3VKxXQKiboRw_F01ggTz
>> HuhwawxR1P9_tMCN2FODU4&m=GGfz5QI8ldHRqao5OsrfuHZQso5LLNBeBxCZr
>> Ai7Zow-
>> qoKl_S1Yw90OWnSZ3FFx&s=kM0VFY1b15BYvp2EUapQjZ6Eb96aZ_yAE76EKCmA
>> aEQ&e=
>>
>>>
>>> Same with CN10K or Octeon10 family of silicons.
>>> https://www.marvell.com/products/data-processing-units.html
>>> Please check for "OCTEON 10"
>>>
>>> CN103xx and CN106xx are two silicons in this family.
>>
>> Are they? "Up to 8" cores, so how this can be one specific silicon? One customer
>> buys CN10300 with 8 cores, second buys exactly the same CN10300 and has 4
>> cores?
>>
>> You are mixing families and specific devices.
> 
> I was making it simple to understand.
> 
> OcteonTx2 and Octeon10 (CN10K) are two generations of Octeon processors from Marvell.

I know. I don't think we talk about the same thing...

> Within each generation there are multiple silicon variants.
> Again for each variant there are multiple skews.
> 
> Since the watchdog hardware block functionality is same across all of above
> generations / variants / families / skews, is it okay to use below compatible strings ?

You got the link which explains it.

We had this discussions for thousands times. Just a few references from
bookmarks:

https://lore.kernel.org/all/20220822181701.GA89665-robh@kernel.org/
https://lore.kernel.org/all/78651e07-6b3e-4243-8e1f-fcd1dfb3ffe1@www.fastmail.com/
https://lore.kernel.org/all/288f56ba9cfad46354203b7698babe91@walle.cc/
https://lore.kernel.org/all/106e443a-e765-51fe-b556-e4e7e2aa771c@linaro.org/

Explain me how is this different. Please do not repeat the same
arguments as everywhere else, because we covered them.

> 
> - const: marvell,octeontx2-wdt
> - const: marvell,cn10k-wdt
> 
> Also this is the same naming we have been using in other drivers as well.
> drivers/net/ethernet/marvell/octeontx2
> drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c

Ah, the argument "others did it" or "in the past we did". If the
approach is buggy, does it mean you should duplicate the same buggy
approach to new bindings?

Best regards,
Krzysztof

