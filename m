Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11BA46C8563
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 19:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbjCXSwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 14:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjCXSwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 14:52:50 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A89035BE
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 11:52:47 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id h8so11575363ede.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 11:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679683966;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0NUsMoZ4vPDEoNGXohzk54SNbSs6g4GHYDuwJNIwkcc=;
        b=Qw6N/yhpAPzyV2z5MzL5WKXBYCLiJd8CQP7otE2cL0zfhxFFLIky9FXF+iKKWLaF7p
         L78JBlA3mzx9l7mBJgf6gcfIwMh+3Hj7Mr3DQRs5BIbz6FlxX963mHNHcv+U7B8xZ1oY
         wyDUO4LPPVCegfifRqnwEJrAmB93QufJuLH0kcjFgtnoPb2lREdHbh+PhPvDTRun3Ib6
         4fHCm8AS7fXNKdniXfEPKNhkzvRUFst50Ef5dUnTMtBQ5VF2dP/MbLgnZbu/VWSPNwjh
         m4Se8gg3yHSwA4XrTMTSAeVltEoU1C22x8w7X6khkxpTG3iIOOcybvx90YZtxqIYOawc
         N3yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679683966;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0NUsMoZ4vPDEoNGXohzk54SNbSs6g4GHYDuwJNIwkcc=;
        b=invfBy4kh+MN/eahLoXXZ6gb6jrR/NDt8Tl3vnWbwEPc84FPsFCbXuHfzq4cP4TAs1
         cHFgmQDt93NUXdfmsuu29w1sA9fXGJtyu1/Oe3hFUGmjh+m91yheIbe7kv+DMqB5gRfm
         ZN91F2Muy8ebXpNgJBH0uABSph8x40CnsgmvaseDDf6CssPSgqp2EIsX3x1y4MRUimVh
         yWBPPTMhE8Zm3mBXgTXthepr/mQHms5+8jQLgYy78zRlXtWQIkLekV3g0nmQyGVzg3jU
         EMkamBeWsfddk6NY9K3o3U8WGh+fgTroAYzd+/M7z6eQoZ59heALUa++GSAvns8A5N1C
         3SSg==
X-Gm-Message-State: AO0yUKVhPfVgWQZ8or9hImV8xzfcf4TW6WGvIS6AbtRku/AX0C7v5rzk
        Dx4FVOglpx9NHFsuMdLC9UAcsA==
X-Google-Smtp-Source: AK7set8CLRlcaIJiT4m8UDQdlno7L+EJA7EXsQ41DcNtUX77qnq86VnfoStuTl26ufwdV6wCI+qZDA==
X-Received: by 2002:a17:906:8297:b0:931:cd1b:3c0 with SMTP id h23-20020a170906829700b00931cd1b03c0mr9478205ejx.3.1679683965713;
        Fri, 24 Mar 2023 11:52:45 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:3027:fb0b:ae08:588? ([2a02:810d:15c0:828:3027:fb0b:ae08:588])
        by smtp.gmail.com with ESMTPSA id vq11-20020a170907a4cb00b0093e6f40d124sm1049217ejc.139.2023.03.24.11.52.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 11:52:45 -0700 (PDT)
Message-ID: <d287ca9f-b056-d39a-aa93-b0e2cb279f73@linaro.org>
Date:   Fri, 24 Mar 2023 19:52:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 5/9] ARM: dts: exynos: move exynos-bus nodes out of soc in
 Exynos4412
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     replicant@osuosl.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        =?UTF-8?Q?Martin_J=c3=bccker?= <martin.juecker@gmail.com>,
        Henrik Grimler <henrik@grimler.se>
References: <20230125094513.155063-1-krzysztof.kozlowski@linaro.org>
 <20230125094513.155063-5-krzysztof.kozlowski@linaro.org>
 <CGME20230129104220eucas1p15b70f73be86fa5600cfe170d22869836@eucas1p1.samsung.com>
 <29841f64-360b-1426-e1fd-dd4c64ee5455@linaro.org>
 <b3f31e71-fa1a-e0c0-fdfa-f65674ccc5cd@samsung.com>
 <d54792c5-2842-e5b9-26b8-1f52471211a9@linaro.org>
 <111f7364-0d7b-b4c5-721f-69c00d4619e2@samsung.com>
 <dc0c3fa9-a6d4-e1c1-7cc8-13b206e3b31f@linaro.org>
 <697aa7b5-9c9b-eb4f-8111-c9a396d9d191@linaro.org>
 <6a9fcdc9-3fe7-e8fc-3a51-385d516c6323@samsung.com>
 <a72f8b1a-1fcc-a090-69e7-f56072185e81@linaro.org>
 <9e5d9952-0295-40b2-5f4b-a1412cc933ce@samsung.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <9e5d9952-0295-40b2-5f4b-a1412cc933ce@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/03/2023 18:07, Marek Szyprowski wrote:
> On 06.02.2023 17:12, Krzysztof Kozlowski wrote:
>> On 03/02/2023 23:50, Marek Szyprowski wrote:
>>> On 03.02.2023 22:12, Krzysztof Kozlowski wrote:
>>>> On 03/02/2023 21:34, Krzysztof Kozlowski wrote:
>>>>> On 03/02/2023 12:51, Marek Szyprowski wrote:
>>>>>> On 03.02.2023 12:46, Krzysztof Kozlowski wrote:
>>>>>>> On 03/02/2023 12:45, Marek Szyprowski wrote:
>>>>>>>> On 29.01.2023 11:42, Krzysztof Kozlowski wrote:
>>>>>>>>> On 25/01/2023 10:45, Krzysztof Kozlowski wrote:
>>>>>>>>>> The soc node is supposed to have only device nodes with MMIO addresses,
>>>>>>>>>> as reported by dtc W=1:
>>>>>>>>>>
>>>>>>>>>>       exynos4412.dtsi:407.20-413.5:
>>>>>>>>>>         Warning (simple_bus_reg): /soc/bus-acp: missing or empty reg/ranges property
>>>>>>>>>>
>>>>>>>>>> and dtbs_check:
>>>>>>>>>>
>>>>>>>>>>       exynos4412-i9300.dtb: soc: bus-acp:
>>>>>>>>>>         {'compatible': ['samsung,exynos-bus'], 'clocks': [[7, 456]], 'clock-names': ['bus'], 'operating-points-v2': [[132]], 'status': ['okay'], 'devfreq': [[117]]} should not be valid under {'type': 'object'}
>>>>>>>>>>
>>>>>>>>>> Move the bus nodes and their OPP tables out of SoC to fix this.
>>>>>>>>>> Re-order them alphabetically while moving and put some of the OPP tables
>>>>>>>>>> in device nodes (if they are not shared).
>>>>>>>>>>
>>>>>>>>> Applied.
>>>>>>>> I don't have a good news. It looks that this change is responsible for
>>>>>>>> breaking boards that were rock-stable so far, like Odroid U3. I didn't
>>>>>>>> manage to analyze what exactly causes the issue, but it looks that the
>>>>>>>> exynos-bus devfreq driver somehow depends on the order of the nodes:
>>>>>>>>
>>>>>>>> (before)
>>>>>>>>
>>>>>>>> # dmesg | grep exynos-bus
>>>>>>>> [    6.415266] exynos-bus: new bus device registered: soc:bus-dmc
>>>>>>>> (100000 KHz ~ 400000 KHz)
>>>>>>>> [    6.422717] exynos-bus: new bus device registered: soc:bus-acp
>>>>>>>> (100000 KHz ~ 267000 KHz)
>>>>>>>> [    6.454323] exynos-bus: new bus device registered: soc:bus-c2c
>>>>>>>> (100000 KHz ~ 400000 KHz)
>>>>>>>> [    6.489944] exynos-bus: new bus device registered: soc:bus-leftbus
>>>>>>>> (100000 KHz ~ 200000 KHz)
>>>>>>>> [    6.493990] exynos-bus: new bus device registered: soc:bus-rightbus
>>>>>>>> (100000 KHz ~ 200000 KHz)
>>>>>>>> [    6.494612] exynos-bus: new bus device registered: soc:bus-display
>>>>>>>> (160000 KHz ~ 200000 KHz)
>>>>>>>> [    6.494932] exynos-bus: new bus device registered: soc:bus-fsys
>>>>>>>> (100000 KHz ~ 134000 KHz)
>>>>>>>> [    6.495246] exynos-bus: new bus device registered: soc:bus-peri (
>>>>>>>> 50000 KHz ~ 100000 KHz)
>>>>>>>> [    6.495577] exynos-bus: new bus device registered: soc:bus-mfc
>>>>>>>> (100000 KHz ~ 200000 KHz)
>>>>>>>>
>>>>>>>> (after)
>>>>>>>>
>>>>>>>> # dmesg | grep exynos-bus
>>>>>>>>
>>>>>>>> [    6.082032] exynos-bus: new bus device registered: bus-dmc (100000
>>>>>>>> KHz ~ 400000 KHz)
>>>>>>>> [    6.122726] exynos-bus: new bus device registered: bus-leftbus
>>>>>>>> (100000 KHz ~ 200000 KHz)
>>>>>>>> [    6.146705] exynos-bus: new bus device registered: bus-mfc (100000
>>>>>>>> KHz ~ 200000 KHz)
>>>>>>>> [    6.181632] exynos-bus: new bus device registered: bus-peri ( 50000
>>>>>>>> KHz ~ 100000 KHz)
>>>>>>>> [    6.204770] exynos-bus: new bus device registered: bus-rightbus
>>>>>>>> (100000 KHz ~ 200000 KHz)
>>>>>>>> [    6.211087] exynos-bus: new bus device registered: bus-acp (100000
>>>>>>>> KHz ~ 267000 KHz)
>>>>>>>> [    6.216936] exynos-bus: new bus device registered: bus-c2c (100000
>>>>>>>> KHz ~ 400000 KHz)
>>>>>>>> [    6.225748] exynos-bus: new bus device registered: bus-display
>>>>>>>> (160000 KHz ~ 200000 KHz)
>>>>>>>> [    6.242978] exynos-bus: new bus device registered: bus-fsys (100000
>>>>>>>> KHz ~ 134000 KHz)
>>>>>>>>
>>>>>>>> This is definitely a driver bug, but so far it worked fine, so this is a
>>>>>>>> regression that need to be addressed somehow...
>>>>>>> Thanks for checking, but what is exactly the bug? The devices registered
>>>>>>> - just with different name.
>>>>>> The bug is that the board fails to boot from time to time, freezing
>>>>>> after registering PPMU counters...
>>>>> My U3 with and without this patch, reports several warnings:
>>>>> iommu_group_do_set_platform_dma()
>>>>> exynos_iommu_domain_free()
>>>>> clk_core_enable()
>>>>>
>>>>> and finally:
>>>>> rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
>>>>>
>>>>> and keeps stalling.
>>>>>
>>>>> At least on next-20230203. Except all these (which anyway make board
>>>>> unbootable) look fine around PMU and exynos-bus.
>>>> I also booted few times my next/dt branch (with this patch) and no
>>>> problems. How reproducible is the issue you experience?
>>> IOMMU needs a fixup, that has been merged today:
>>>
>>> https://lore.kernel.org/all/20230123093102.12392-1-m.szyprowski@samsung.com/
>>>
>>> I was initially convinced that this freeze is somehow related to this
>>> IOMMU fixup, but it turned out that the devfreq is a source of the problems.
>>>
>>> The freeze happens here about 1 of 10 boots, usually with kernel
>>> compiled from multi_v7_defconfig, while loading the PPMU modules. It
>>> happens on your next/dt branch too.
>> I was able to reproduce it easily with multi_v7. Then I commented out
>> dmc bus which fixed the issue. Then I commented out acp and c2c buses
>> (children/passive) which also fixed the issue. Then I uncommented
>> everything and went back to next/dt - exactly the same as it was failing
>> - and since then I cannot reproduce it. I triple checked, but now my
>> multi_v7 on U3 on next/dt boots perfectly fine. Every time.
> 
> This issue still happens from time to time. I quick workaround to fix it 
> is to add:
> 
> MODULE_SOFTDEP("pre: exynos_ppmu");
> 
> to the exynos-bus driver. Is it acceptable solution?

I initially thought it might be caused by deferred probe, but it happens
even in successful boot. I guess we can go with this workaround because
I really do not have other idea.

Best regards,
Krzysztof

