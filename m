Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12B368A655
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 23:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbjBCWuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 17:50:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232580AbjBCWut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 17:50:49 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD521BFD
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 14:50:46 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230203225043euoutp02d47ebeff39afe7df9e0ee76dbfd53238~AcjdnDqNW0035400354euoutp02p
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 22:50:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230203225043euoutp02d47ebeff39afe7df9e0ee76dbfd53238~AcjdnDqNW0035400354euoutp02p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1675464643;
        bh=fmzngyA8ptBKcBGSeyS4q9rTlL5d3Gfnfw9j7mZIjew=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=G83F5yZohko677CXDxsm9+wX+0QqlRqocryUuvygHOvRhWC72+AqidHzvmKccYJZA
         cKreZXStxG/X9yU1Wd5ltRBI7VB9fb+XB8TqicSQxycyu/LebCnDXx/YdBokPY1qRd
         ZY0JY2jd4AoYzsi8vXp3dYllPlzjlEn6GlTrM7ls=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230203225042eucas1p17b82825c8a6c34ad9bd70aa99868f4a0~Acjc9Fb0Y0556505565eucas1p1K;
        Fri,  3 Feb 2023 22:50:42 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 9C.82.13597.2CF8DD36; Fri,  3
        Feb 2023 22:50:42 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230203225041eucas1p10fa99a1d02eeeb50a49289ad2b39302f~AcjcCpfjB2824928249eucas1p1j;
        Fri,  3 Feb 2023 22:50:41 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230203225041eusmtrp2b0bc4b5eeda725df3cb025d940ad7e39~Acjb9a5310986709867eusmtrp2M;
        Fri,  3 Feb 2023 22:50:41 +0000 (GMT)
X-AuditID: cbfec7f4-1f1ff7000000351d-1d-63dd8fc2af08
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 15.1E.02722.1CF8DD36; Fri,  3
        Feb 2023 22:50:41 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230203225041eusmtip2acb48be8f3acb4a078920434e4894b12~AcjbL58-30811508115eusmtip2w;
        Fri,  3 Feb 2023 22:50:41 +0000 (GMT)
Message-ID: <6a9fcdc9-3fe7-e8fc-3a51-385d516c6323@samsung.com>
Date:   Fri, 3 Feb 2023 23:50:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 5/9] ARM: dts: exynos: move exynos-bus nodes out of soc
 in Exynos4412
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <697aa7b5-9c9b-eb4f-8111-c9a396d9d191@linaro.org>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKKsWRmVeSWpSXmKPExsWy7djP87qH+u8mG8ycbGzxYN42NovrX56z
        Wsw/co7V4u2SXYwW/Y9fM1v0vXjIbLH39VZ2i02Pr7FaXN41h81ixvl9TBZn/k1lsVjwx85i
        3RpBi9a9R9gtNn//y+jA77Fz1l12j6NX7rF6bFrVyeZx59oeNo/NS+o9/t9Zy+7xpbmb1aNv
        yypGj8+b5AI4o7hsUlJzMstSi/TtErgymp4vYS7oVK/oPuHXwLhOoYuRk0NCwERi/fI1zF2M
        XBxCAisYJdpWX2SDcL4wSlyZPpcFwvnMKDFv+kV2mJaJ3+cwQSSWM0osW3+OEcL5yCgxaepl
        FpAqXgE7iZsLr4F1sAioSCy5N48dIi4ocXLmE6AaDg5RgRSJTX/KQMLCAtESi/7eYQWxmQXE
        JW49mQ+2QETgGZPEzK2tTBCJ54wSt/+ygdhsAoYSXW+72EDmcALtWr4mBaJEXqJ562xmiEM3
        c0rsu8wPYbtIzJmxhw3CFpZ4dXwL1DMyEv93QuySEGhnlFjw+z6UM4FRouH5LUaIKmuJO+d+
        gS1jFtCUWL9LHyLsKPFwy1+wsIQAn8SNt4IQN/BJTNo2nRkizCvR0SYEUa0mMev4Ori1By9c
        Yp7AqDQLKVBmIfl+FpJvZiHsXcDIsopRPLW0ODc9tdgoL7Vcrzgxt7g0L10vOT93EyMw5Z3+
        d/zLDsblrz7qHWJk4mA8xCjBwawkwrv89J1kId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzatieT
        hQTSE0tSs1NTC1KLYLJMHJxSDUzuQqvulS5md0s/lu8eKKPDHfFR58vChg/3FrR9vSjFLXKg
        fOWb2ZPMr4sUBUU0nni4Tq1oeVuu5xHVK2wS505eEc7PPXsnXSpP27X29r1dJ5xFWZJr1jFu
        qlE5qXem1++6+I2T4to7Vps2t04wL07uXtDSqfL6ZzV7sdU6w7JXApePeh1e/nYlx4QrKSvm
        eVXldyUpXZSrPvFuEZ/K97e7D87IvyoWfbtWe0rEv3ufK3ptOUu09t54t+Pf1DscDvtcPGvf
        MJhceZ+mzSl4fd3GGyX8hYlvGTXvRD8W9zOtPDLjUKfyS3nh7Q9t38YHT7SOLJHd3GfvXefk
        +qbyOee/ldx/pf4bp/h/y1oy1U2JpTgj0VCLuag4EQB6WRuA6AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJIsWRmVeSWpSXmKPExsVy+t/xe7oH++8mG7z6YmDxYN42NovrX56z
        Wsw/co7V4u2SXYwW/Y9fM1v0vXjIbLH39VZ2i02Pr7FaXN41h81ixvl9TBZn/k1lsVjwx85i
        3RpBi9a9R9gtNn//y+jA77Fz1l12j6NX7rF6bFrVyeZx59oeNo/NS+o9/t9Zy+7xpbmb1aNv
        yypGj8+b5AI4o/RsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstS
        i/TtEvQymp4vYS7oVK/oPuHXwLhOoYuRk0NCwERi4vc5TCC2kMBSRom7F4Ug4jISJ6c1sELY
        whJ/rnWxdTFyAdW8Z5ToaL8IluAVsJO4ufAaO4jNIqAiseTePHaIuKDEyZlPWEBsUYEUiebn
        J8HqhQWiJdY8PwK2jFlAXOLWk/lMIENFBJ4xSTx+vo0FxGEWeM4ocX9rEyvEul4WickTZ4CN
        YhMwlOh6C3IHBwcn0Orla1IgJplJdG3tYoSw5SWat85mnsAoNAvJIbOQLJyFpGUWkpYFjCyr
        GEVSS4tz03OLDfWKE3OLS/PS9ZLzczcxAuN827Gfm3cwznv1Ue8QIxMH4yFGCQ5mJRHe5afv
        JAvxpiRWVqUW5ccXleakFh9iNAWGxkRmKdHkfGCiySuJNzQzMDU0MbM0MLU0M1YS5/Us6EgU
        EkhPLEnNTk0tSC2C6WPi4JRqYArqeOh05M0u3bWlSyLOT2WbzR17UDjh+gQuA0HND6teCqcd
        3T37IE/65o9chYuPvPnyY6JO5QuxSXMvxNYyzYtQnV00P3h7MNdV8++GH7a4SvQ2xU1y3338
        tpzf/U8XVRe8OK/1P/ZJslnkS6WftdrrbsVw3JxVEvlHOjc3Ija/u3KX7j3j1w37K74crnyQ
        8mGdwZ9563e5cK/5s0I3T0zmuqidLvfvaz8/FnIeSAh/VGezM+vBASk91TOvDGyVz1fyvOGQ
        f7fBniHr44LEyM9LHO7eel6adLdFbKXPVsv+z881UuXcnd4te6De3dnL3yg3VW/h5N/93RPM
        Yl9OXv9mz/wn4aXGoUemX7HNeM2qxFKckWioxVxUnAgAuUDV+nwDAAA=
X-CMS-MailID: 20230203225041eucas1p10fa99a1d02eeeb50a49289ad2b39302f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230129104220eucas1p15b70f73be86fa5600cfe170d22869836
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230129104220eucas1p15b70f73be86fa5600cfe170d22869836
References: <20230125094513.155063-1-krzysztof.kozlowski@linaro.org>
        <20230125094513.155063-5-krzysztof.kozlowski@linaro.org>
        <CGME20230129104220eucas1p15b70f73be86fa5600cfe170d22869836@eucas1p1.samsung.com>
        <29841f64-360b-1426-e1fd-dd4c64ee5455@linaro.org>
        <b3f31e71-fa1a-e0c0-fdfa-f65674ccc5cd@samsung.com>
        <d54792c5-2842-e5b9-26b8-1f52471211a9@linaro.org>
        <111f7364-0d7b-b4c5-721f-69c00d4619e2@samsung.com>
        <dc0c3fa9-a6d4-e1c1-7cc8-13b206e3b31f@linaro.org>
        <697aa7b5-9c9b-eb4f-8111-c9a396d9d191@linaro.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.02.2023 22:12, Krzysztof Kozlowski wrote:
> On 03/02/2023 21:34, Krzysztof Kozlowski wrote:
>> On 03/02/2023 12:51, Marek Szyprowski wrote:
>>> On 03.02.2023 12:46, Krzysztof Kozlowski wrote:
>>>> On 03/02/2023 12:45, Marek Szyprowski wrote:
>>>>> On 29.01.2023 11:42, Krzysztof Kozlowski wrote:
>>>>>> On 25/01/2023 10:45, Krzysztof Kozlowski wrote:
>>>>>>> The soc node is supposed to have only device nodes with MMIO addresses,
>>>>>>> as reported by dtc W=1:
>>>>>>>
>>>>>>>      exynos4412.dtsi:407.20-413.5:
>>>>>>>        Warning (simple_bus_reg): /soc/bus-acp: missing or empty reg/ranges property
>>>>>>>
>>>>>>> and dtbs_check:
>>>>>>>
>>>>>>>      exynos4412-i9300.dtb: soc: bus-acp:
>>>>>>>        {'compatible': ['samsung,exynos-bus'], 'clocks': [[7, 456]], 'clock-names': ['bus'], 'operating-points-v2': [[132]], 'status': ['okay'], 'devfreq': [[117]]} should not be valid under {'type': 'object'}
>>>>>>>
>>>>>>> Move the bus nodes and their OPP tables out of SoC to fix this.
>>>>>>> Re-order them alphabetically while moving and put some of the OPP tables
>>>>>>> in device nodes (if they are not shared).
>>>>>>>
>>>>>> Applied.
>>>>> I don't have a good news. It looks that this change is responsible for
>>>>> breaking boards that were rock-stable so far, like Odroid U3. I didn't
>>>>> manage to analyze what exactly causes the issue, but it looks that the
>>>>> exynos-bus devfreq driver somehow depends on the order of the nodes:
>>>>>
>>>>> (before)
>>>>>
>>>>> # dmesg | grep exynos-bus
>>>>> [    6.415266] exynos-bus: new bus device registered: soc:bus-dmc
>>>>> (100000 KHz ~ 400000 KHz)
>>>>> [    6.422717] exynos-bus: new bus device registered: soc:bus-acp
>>>>> (100000 KHz ~ 267000 KHz)
>>>>> [    6.454323] exynos-bus: new bus device registered: soc:bus-c2c
>>>>> (100000 KHz ~ 400000 KHz)
>>>>> [    6.489944] exynos-bus: new bus device registered: soc:bus-leftbus
>>>>> (100000 KHz ~ 200000 KHz)
>>>>> [    6.493990] exynos-bus: new bus device registered: soc:bus-rightbus
>>>>> (100000 KHz ~ 200000 KHz)
>>>>> [    6.494612] exynos-bus: new bus device registered: soc:bus-display
>>>>> (160000 KHz ~ 200000 KHz)
>>>>> [    6.494932] exynos-bus: new bus device registered: soc:bus-fsys
>>>>> (100000 KHz ~ 134000 KHz)
>>>>> [    6.495246] exynos-bus: new bus device registered: soc:bus-peri (
>>>>> 50000 KHz ~ 100000 KHz)
>>>>> [    6.495577] exynos-bus: new bus device registered: soc:bus-mfc
>>>>> (100000 KHz ~ 200000 KHz)
>>>>>
>>>>> (after)
>>>>>
>>>>> # dmesg | grep exynos-bus
>>>>>
>>>>> [    6.082032] exynos-bus: new bus device registered: bus-dmc (100000
>>>>> KHz ~ 400000 KHz)
>>>>> [    6.122726] exynos-bus: new bus device registered: bus-leftbus
>>>>> (100000 KHz ~ 200000 KHz)
>>>>> [    6.146705] exynos-bus: new bus device registered: bus-mfc (100000
>>>>> KHz ~ 200000 KHz)
>>>>> [    6.181632] exynos-bus: new bus device registered: bus-peri ( 50000
>>>>> KHz ~ 100000 KHz)
>>>>> [    6.204770] exynos-bus: new bus device registered: bus-rightbus
>>>>> (100000 KHz ~ 200000 KHz)
>>>>> [    6.211087] exynos-bus: new bus device registered: bus-acp (100000
>>>>> KHz ~ 267000 KHz)
>>>>> [    6.216936] exynos-bus: new bus device registered: bus-c2c (100000
>>>>> KHz ~ 400000 KHz)
>>>>> [    6.225748] exynos-bus: new bus device registered: bus-display
>>>>> (160000 KHz ~ 200000 KHz)
>>>>> [    6.242978] exynos-bus: new bus device registered: bus-fsys (100000
>>>>> KHz ~ 134000 KHz)
>>>>>
>>>>> This is definitely a driver bug, but so far it worked fine, so this is a
>>>>> regression that need to be addressed somehow...
>>>> Thanks for checking, but what is exactly the bug? The devices registered
>>>> - just with different name.
>>> The bug is that the board fails to boot from time to time, freezing
>>> after registering PPMU counters...
>> My U3 with and without this patch, reports several warnings:
>> iommu_group_do_set_platform_dma()
>> exynos_iommu_domain_free()
>> clk_core_enable()
>>
>> and finally:
>> rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
>>
>> and keeps stalling.
>>
>> At least on next-20230203. Except all these (which anyway make board
>> unbootable) look fine around PMU and exynos-bus.
> I also booted few times my next/dt branch (with this patch) and no
> problems. How reproducible is the issue you experience?

IOMMU needs a fixup, that has been merged today:

https://lore.kernel.org/all/20230123093102.12392-1-m.szyprowski@samsung.com/

I was initially convinced that this freeze is somehow related to this 
IOMMU fixup, but it turned out that the devfreq is a source of the problems.

The freeze happens here about 1 of 10 boots, usually with kernel 
compiled from multi_v7_defconfig, while loading the PPMU modules. It 
happens on your next/dt branch too.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

