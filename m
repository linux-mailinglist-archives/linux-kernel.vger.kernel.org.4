Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759D968C2B2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 17:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbjBFQNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 11:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbjBFQND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 11:13:03 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE93D2F7B5
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 08:12:39 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id m16-20020a05600c3b1000b003dc4050c94aso9231610wms.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 08:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DKHwytajiOAR9nY12DKXuVDIqgp8eXSf4A1PQJbS+U0=;
        b=rGKG7RBS7I/8vrLgjCKgyFWhKsvajQVtYanXK9FRzTibVuMOS309fl217TtWae3tb6
         AoxnCXFwMBuYcPgjPuvyJfFC+wKjSem4B0dbuOV6Jx5bcQHqPNtGp1VBFymOsE6TO5fi
         rOuc5C46K9s3/cV6uJMoDadxBtr+oFNiZ53tj5iugLThEHu2G6HbWqqeiNPa388f4Ryl
         qBK5G9E836H9juaOfI6ytmpTWZ/Eq0luyX5QMouZ/zp7Nq6LuVSb83Bx4HSShKS5ffRj
         IW8MrHVapHrq9hx2b0GUmnxhS3VritTqY6EWyHrqP0rISdau3bJoNdpFPIwFN16SiPn9
         M9Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DKHwytajiOAR9nY12DKXuVDIqgp8eXSf4A1PQJbS+U0=;
        b=t0ElQmMDrz5811kHCBMlPVyN4JPToy189n63Cyqbe5pNuUTxs8beZfErHwA8pmInwc
         WaDdPBVnCQBdsvufT0mIyvcogI+516Hv2fMfvN5oJT7BwBWpVdmUf814ECTvQtGYAzwS
         dgBjRR4ihr6cRfzgwrtLb2d2tAlYypGs++1XEWWbI0W89I1CUjThojw7ncWjcKW1pq+b
         /AyxiV+XG7z2L5nKBXioPnMOY7zThyIAK3fkVTa65TXxHjLhsYSu49kw7pLaU6BIfFNp
         uoidh913h2eBmVKJb+PmEhLCt5gPUD1DZEGgtvWObBp/jirevc1L1dMluryokvSFGxRR
         7H5A==
X-Gm-Message-State: AO0yUKUDJ56joPDWJLkkkcCytV5Hnb0XDYFUuo3dVOkFEDnFPzUG/By/
        /1HuqUctzeVTKFDb+O6/T8yrxA==
X-Google-Smtp-Source: AK7set+in52AJriVcyBtTG4oXRb8OjlLdfXu3armhgkzE7x8wQzvOcf9Mdeu31PPbyMscL730X3tYA==
X-Received: by 2002:a05:600c:13c8:b0:3da:28a9:a900 with SMTP id e8-20020a05600c13c800b003da28a9a900mr177983wmg.41.1675699958378;
        Mon, 06 Feb 2023 08:12:38 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id r12-20020a05600c35cc00b003d9fba3c7a4sm17816889wmq.16.2023.02.06.08.12.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 08:12:37 -0800 (PST)
Message-ID: <a72f8b1a-1fcc-a090-69e7-f56072185e81@linaro.org>
Date:   Mon, 6 Feb 2023 17:12:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 5/9] ARM: dts: exynos: move exynos-bus nodes out of soc in
 Exynos4412
Content-Language: en-US
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     replicant@osuosl.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        =?UTF-8?Q?Martin_J=c3=bccker?= <martin.juecker@gmail.com>,
        Henrik Grimler <henrik@grimler.se>,
        Chanwoo Choi <cw00.choi@samsung.com>
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <6a9fcdc9-3fe7-e8fc-3a51-385d516c6323@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/2023 23:50, Marek Szyprowski wrote:
> On 03.02.2023 22:12, Krzysztof Kozlowski wrote:
>> On 03/02/2023 21:34, Krzysztof Kozlowski wrote:
>>> On 03/02/2023 12:51, Marek Szyprowski wrote:
>>>> On 03.02.2023 12:46, Krzysztof Kozlowski wrote:
>>>>> On 03/02/2023 12:45, Marek Szyprowski wrote:
>>>>>> On 29.01.2023 11:42, Krzysztof Kozlowski wrote:
>>>>>>> On 25/01/2023 10:45, Krzysztof Kozlowski wrote:
>>>>>>>> The soc node is supposed to have only device nodes with MMIO addresses,
>>>>>>>> as reported by dtc W=1:
>>>>>>>>
>>>>>>>>      exynos4412.dtsi:407.20-413.5:
>>>>>>>>        Warning (simple_bus_reg): /soc/bus-acp: missing or empty reg/ranges property
>>>>>>>>
>>>>>>>> and dtbs_check:
>>>>>>>>
>>>>>>>>      exynos4412-i9300.dtb: soc: bus-acp:
>>>>>>>>        {'compatible': ['samsung,exynos-bus'], 'clocks': [[7, 456]], 'clock-names': ['bus'], 'operating-points-v2': [[132]], 'status': ['okay'], 'devfreq': [[117]]} should not be valid under {'type': 'object'}
>>>>>>>>
>>>>>>>> Move the bus nodes and their OPP tables out of SoC to fix this.
>>>>>>>> Re-order them alphabetically while moving and put some of the OPP tables
>>>>>>>> in device nodes (if they are not shared).
>>>>>>>>
>>>>>>> Applied.
>>>>>> I don't have a good news. It looks that this change is responsible for
>>>>>> breaking boards that were rock-stable so far, like Odroid U3. I didn't
>>>>>> manage to analyze what exactly causes the issue, but it looks that the
>>>>>> exynos-bus devfreq driver somehow depends on the order of the nodes:
>>>>>>
>>>>>> (before)
>>>>>>
>>>>>> # dmesg | grep exynos-bus
>>>>>> [    6.415266] exynos-bus: new bus device registered: soc:bus-dmc
>>>>>> (100000 KHz ~ 400000 KHz)
>>>>>> [    6.422717] exynos-bus: new bus device registered: soc:bus-acp
>>>>>> (100000 KHz ~ 267000 KHz)
>>>>>> [    6.454323] exynos-bus: new bus device registered: soc:bus-c2c
>>>>>> (100000 KHz ~ 400000 KHz)
>>>>>> [    6.489944] exynos-bus: new bus device registered: soc:bus-leftbus
>>>>>> (100000 KHz ~ 200000 KHz)
>>>>>> [    6.493990] exynos-bus: new bus device registered: soc:bus-rightbus
>>>>>> (100000 KHz ~ 200000 KHz)
>>>>>> [    6.494612] exynos-bus: new bus device registered: soc:bus-display
>>>>>> (160000 KHz ~ 200000 KHz)
>>>>>> [    6.494932] exynos-bus: new bus device registered: soc:bus-fsys
>>>>>> (100000 KHz ~ 134000 KHz)
>>>>>> [    6.495246] exynos-bus: new bus device registered: soc:bus-peri (
>>>>>> 50000 KHz ~ 100000 KHz)
>>>>>> [    6.495577] exynos-bus: new bus device registered: soc:bus-mfc
>>>>>> (100000 KHz ~ 200000 KHz)
>>>>>>
>>>>>> (after)
>>>>>>
>>>>>> # dmesg | grep exynos-bus
>>>>>>
>>>>>> [    6.082032] exynos-bus: new bus device registered: bus-dmc (100000
>>>>>> KHz ~ 400000 KHz)
>>>>>> [    6.122726] exynos-bus: new bus device registered: bus-leftbus
>>>>>> (100000 KHz ~ 200000 KHz)
>>>>>> [    6.146705] exynos-bus: new bus device registered: bus-mfc (100000
>>>>>> KHz ~ 200000 KHz)
>>>>>> [    6.181632] exynos-bus: new bus device registered: bus-peri ( 50000
>>>>>> KHz ~ 100000 KHz)
>>>>>> [    6.204770] exynos-bus: new bus device registered: bus-rightbus
>>>>>> (100000 KHz ~ 200000 KHz)
>>>>>> [    6.211087] exynos-bus: new bus device registered: bus-acp (100000
>>>>>> KHz ~ 267000 KHz)
>>>>>> [    6.216936] exynos-bus: new bus device registered: bus-c2c (100000
>>>>>> KHz ~ 400000 KHz)
>>>>>> [    6.225748] exynos-bus: new bus device registered: bus-display
>>>>>> (160000 KHz ~ 200000 KHz)
>>>>>> [    6.242978] exynos-bus: new bus device registered: bus-fsys (100000
>>>>>> KHz ~ 134000 KHz)
>>>>>>
>>>>>> This is definitely a driver bug, but so far it worked fine, so this is a
>>>>>> regression that need to be addressed somehow...
>>>>> Thanks for checking, but what is exactly the bug? The devices registered
>>>>> - just with different name.
>>>> The bug is that the board fails to boot from time to time, freezing
>>>> after registering PPMU counters...
>>> My U3 with and without this patch, reports several warnings:
>>> iommu_group_do_set_platform_dma()
>>> exynos_iommu_domain_free()
>>> clk_core_enable()
>>>
>>> and finally:
>>> rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
>>>
>>> and keeps stalling.
>>>
>>> At least on next-20230203. Except all these (which anyway make board
>>> unbootable) look fine around PMU and exynos-bus.
>> I also booted few times my next/dt branch (with this patch) and no
>> problems. How reproducible is the issue you experience?
> 
> IOMMU needs a fixup, that has been merged today:
> 
> https://lore.kernel.org/all/20230123093102.12392-1-m.szyprowski@samsung.com/
> 
> I was initially convinced that this freeze is somehow related to this 
> IOMMU fixup, but it turned out that the devfreq is a source of the problems.
> 
> The freeze happens here about 1 of 10 boots, usually with kernel 
> compiled from multi_v7_defconfig, while loading the PPMU modules. It 
> happens on your next/dt branch too.

I was able to reproduce it easily with multi_v7. Then I commented out
dmc bus which fixed the issue. Then I commented out acp and c2c buses
(children/passive) which also fixed the issue. Then I uncommented
everything and went back to next/dt - exactly the same as it was failing
- and since then I cannot reproduce it. I triple checked, but now my
multi_v7 on U3 on next/dt boots perfectly fine. Every time.

Best regards,
Krzysztof

