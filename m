Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC5D6C82E2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 18:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbjCXRHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 13:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbjCXRHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 13:07:34 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A49D18B35
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 10:07:30 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230324170728euoutp01624c3810ad3adf174d812776a15f795f~PaewhdbeZ0648306483euoutp015
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 17:07:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230324170728euoutp01624c3810ad3adf174d812776a15f795f~PaewhdbeZ0648306483euoutp015
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1679677648;
        bh=+aOR0akoEpOaoKW5OfmP7feBQwlYcLLckUXPpLXTj/o=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=cs75+ccxOanD6raG9uCCCURrLgFpCxYPi6wCEzDWbp6VJN9tpcDMXaUmrclAEdzdM
         vJW+alHvlwmObZtr4TbKp9dm7QKm+VwiQ8rjVNh0mMdKf3CXLTLzJJyJGYxodLNXS2
         JR/C+ea5IXHvQRirFEUvO79H6/IRzLN0uEt6koTc=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230324170728eucas1p1d92f705fe1d8a4b52c7c5f19d1fc92b6~Paev__qab3212732127eucas1p1T;
        Fri, 24 Mar 2023 17:07:28 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 1A.F2.10014.0D8DD146; Fri, 24
        Mar 2023 17:07:28 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230324170727eucas1p15ad61c2256a6b6a241f73e2c134c62c3~PaevUedtI1165911659eucas1p1u;
        Fri, 24 Mar 2023 17:07:27 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230324170727eusmtrp2741936b8fa8af2bb87018cf00d854ef0~PaevSOVGP1106111061eusmtrp2l;
        Fri, 24 Mar 2023 17:07:27 +0000 (GMT)
X-AuditID: cbfec7f5-b8bff7000000271e-94-641dd8d05523
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id B6.23.08862.FC8DD146; Fri, 24
        Mar 2023 17:07:27 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230324170726eusmtip11a861a3c2d4842040c854d9b47cd10f5~PaeuhB1M81417214172eusmtip13;
        Fri, 24 Mar 2023 17:07:26 +0000 (GMT)
Message-ID: <9e5d9952-0295-40b2-5f4b-a1412cc933ce@samsung.com>
Date:   Fri, 24 Mar 2023 18:07:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH 5/9] ARM: dts: exynos: move exynos-bus nodes out of soc
 in Exynos4412
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <a72f8b1a-1fcc-a090-69e7-f56072185e81@linaro.org>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOKsWRmVeSWpSXmKPExsWy7djPc7oXbsimGCx5LmDxYN42NovrX56z
        Wsw/co7V4u2SXYwW/Y9fM1v0vXjIbLH39VZ2i02Pr7FaXN41h81ixvl9TBZn/k1lsVjwx85i
        3RpBi9a9R9gtNn//y+jA77Fz1l12j6NX7rF6bFrVyeZx59oeNo/NS+o9/t9Zy+7xpbmb1aNv
        yypGj8+b5AI4o7hsUlJzMstSi/TtErgynu47yFSwWK9i4+09jA2MW9S6GDk5JARMJI5cuMfW
        xcjFISSwglFi8snJ7BDOF0aJi8d2s4BUCQl8ZpQ49jgIpuPA0nZmiPhyRolzi1ghGj4ySlx/
        +44NJMErYCdx//ofVhCbRUBV4nrTUSaIuKDEyZlPwIaKCqRITJyxASwuLBAtsejvHbB6ZgFx
        iVtP5oPFRQR6mCWaD4WALGAW2M8osbnrCdhmNgFDia63XWDLOIGW/T7/hwmiWV6ieetsZpAG
        CYHNnBJ/b3UzQZztInF98mc2CFtY4tXxLewQtozE/50g20Aa2hklFvy+D+VMYJRoeH6LEaLK
        WuLOuV9A3RxAKzQl1u/Shwg7Sjzc8hcsLCHAJ3HjrSDEEXwSk7ZNZ4YI80p0tAlBVKtJzDq+
        Dm7twQuXmCcwKs1CCpdZSP6fheSdWQh7FzCyrGIUTy0tzk1PLTbOSy3XK07MLS7NS9dLzs/d
        xAhMe6f/Hf+6g3HFq496hxiZOBgPMUpwMCuJ8L4LkU0R4k1JrKxKLcqPLyrNSS0+xCjNwaIk
        zqttezJZSCA9sSQ1OzW1ILUIJsvEwSnVwMR2uimkYhWLv9eu861vmBMqLCecnqQWXWLX8TPJ
        OvXlA9OzJ9/fkPkxcYKf9GLWx0J6K3y4nvabSbDevN6tKzuD50Ox1SKL3p4HewTs5080cLmt
        enhHFCPz/bKJe+MUYy5v+JoY3n+o5fLkSXOPpuw8svSIvWTapeUTH+3XijZUvPqq0uBbRsMZ
        sRaNbMWoH27f/xUz+DyN6d6x7IKYt3JkdeBSsXfTdk/jytJ6I+y/03XGt9NHov3FWoPVNrHb
        lJ4PPLHCN0c3zGSdSvM6yymm6Xzb38xzeMPPEDNLrOXwLdOHsQtffjoXWB9f8LB6Z88889Pc
        CxnLvdpVylYFMgb9y3nh+Pdr74dF2tLBH5RYijMSDbWYi4oTAc6T9vnqAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDIsWRmVeSWpSXmKPExsVy+t/xu7rnb8imGPR/l7Z4MG8bm8X1L89Z
        LeYfOcdq8XbJLkaL/sevmS36Xjxkttj7eiu7xabH11gtLu+aw2Yx4/w+Josz/6ayWCz4Y2ex
        bo2gReveI+wWm7//ZXTg99g56y67x9Er91g9Nq3qZPO4c20Pm8fmJfUe/++sZff40tzN6tG3
        ZRWjx+dNcgGcUXo2RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWp
        Rfp2CXoZT/cdZCpYrFex8fYexgbGLWpdjJwcEgImEgeWtjN3MXJxCAksZZRo+76HGSIhI3Fy
        WgMrhC0s8edaFxtE0XtGiamb77GAJHgF7CTuX/8DVsQioCpxvekoE0RcUOLkzCdgNaICKRIT
        l15mA7GFBaIl1jw/AlbDLCAucevJfCaQoSICfcwScw+1sII4zAIHGSX2XFjODrHuG4vE+Sdt
        jCAtbAKGEl1vu8BGcQKt/n3+D9QoM4murV2MELa8RPPW2cwTGIVmIblkFpKNs5C0zELSsoCR
        ZRWjSGppcW56brGhXnFibnFpXrpecn7uJkZgtG879nPzDsZ5rz7qHWJk4mA8xCjBwawkwvsu
        RDZFiDclsbIqtSg/vqg0J7X4EKMpMDgmMkuJJucD001eSbyhmYGpoYmZpYGppZmxkjivZ0FH
        opBAemJJanZqakFqEUwfEwenVAPTxljvg6p7mI5rr/o261F6xLOpKsdzhPw3JK9XSNx6U/WP
        /wbj5s8PxFO2ZU5gmV8d4C+8v957eerup+cZZjyyitrOeW3vth+1C5zO9yotEnXvFd8oJpF+
        2ba7/Alz2BsRTZEXTpe1fWXnf12ZsVNLtpX9dG/btE0O2Rv68448mNK4d/n9J31iv09/Vzfb
        dm+u39FTifaKX0sXiKbdvpDpFr9+sckilw7HS3+0ditFhUTMeDfp2A/ZDUbm5zRYM/tv2Khy
        +3aFPuJdcnrm5BjBy4aLbuueq025xPpgouGhmH9tTf8WKt3XC9hVfe6G/7d9c9eUtutNs+LK
        6QkKVO9JCXVIMFh43WVBWJywuv0dJZbijERDLeai4kQAkhxF/H8DAAA=
X-CMS-MailID: 20230324170727eucas1p15ad61c2256a6b6a241f73e2c134c62c3
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
        <6a9fcdc9-3fe7-e8fc-3a51-385d516c6323@samsung.com>
        <a72f8b1a-1fcc-a090-69e7-f56072185e81@linaro.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.02.2023 17:12, Krzysztof Kozlowski wrote:
> On 03/02/2023 23:50, Marek Szyprowski wrote:
>> On 03.02.2023 22:12, Krzysztof Kozlowski wrote:
>>> On 03/02/2023 21:34, Krzysztof Kozlowski wrote:
>>>> On 03/02/2023 12:51, Marek Szyprowski wrote:
>>>>> On 03.02.2023 12:46, Krzysztof Kozlowski wrote:
>>>>>> On 03/02/2023 12:45, Marek Szyprowski wrote:
>>>>>>> On 29.01.2023 11:42, Krzysztof Kozlowski wrote:
>>>>>>>> On 25/01/2023 10:45, Krzysztof Kozlowski wrote:
>>>>>>>>> The soc node is supposed to have only device nodes with MMIO addresses,
>>>>>>>>> as reported by dtc W=1:
>>>>>>>>>
>>>>>>>>>       exynos4412.dtsi:407.20-413.5:
>>>>>>>>>         Warning (simple_bus_reg): /soc/bus-acp: missing or empty reg/ranges property
>>>>>>>>>
>>>>>>>>> and dtbs_check:
>>>>>>>>>
>>>>>>>>>       exynos4412-i9300.dtb: soc: bus-acp:
>>>>>>>>>         {'compatible': ['samsung,exynos-bus'], 'clocks': [[7, 456]], 'clock-names': ['bus'], 'operating-points-v2': [[132]], 'status': ['okay'], 'devfreq': [[117]]} should not be valid under {'type': 'object'}
>>>>>>>>>
>>>>>>>>> Move the bus nodes and their OPP tables out of SoC to fix this.
>>>>>>>>> Re-order them alphabetically while moving and put some of the OPP tables
>>>>>>>>> in device nodes (if they are not shared).
>>>>>>>>>
>>>>>>>> Applied.
>>>>>>> I don't have a good news. It looks that this change is responsible for
>>>>>>> breaking boards that were rock-stable so far, like Odroid U3. I didn't
>>>>>>> manage to analyze what exactly causes the issue, but it looks that the
>>>>>>> exynos-bus devfreq driver somehow depends on the order of the nodes:
>>>>>>>
>>>>>>> (before)
>>>>>>>
>>>>>>> # dmesg | grep exynos-bus
>>>>>>> [    6.415266] exynos-bus: new bus device registered: soc:bus-dmc
>>>>>>> (100000 KHz ~ 400000 KHz)
>>>>>>> [    6.422717] exynos-bus: new bus device registered: soc:bus-acp
>>>>>>> (100000 KHz ~ 267000 KHz)
>>>>>>> [    6.454323] exynos-bus: new bus device registered: soc:bus-c2c
>>>>>>> (100000 KHz ~ 400000 KHz)
>>>>>>> [    6.489944] exynos-bus: new bus device registered: soc:bus-leftbus
>>>>>>> (100000 KHz ~ 200000 KHz)
>>>>>>> [    6.493990] exynos-bus: new bus device registered: soc:bus-rightbus
>>>>>>> (100000 KHz ~ 200000 KHz)
>>>>>>> [    6.494612] exynos-bus: new bus device registered: soc:bus-display
>>>>>>> (160000 KHz ~ 200000 KHz)
>>>>>>> [    6.494932] exynos-bus: new bus device registered: soc:bus-fsys
>>>>>>> (100000 KHz ~ 134000 KHz)
>>>>>>> [    6.495246] exynos-bus: new bus device registered: soc:bus-peri (
>>>>>>> 50000 KHz ~ 100000 KHz)
>>>>>>> [    6.495577] exynos-bus: new bus device registered: soc:bus-mfc
>>>>>>> (100000 KHz ~ 200000 KHz)
>>>>>>>
>>>>>>> (after)
>>>>>>>
>>>>>>> # dmesg | grep exynos-bus
>>>>>>>
>>>>>>> [    6.082032] exynos-bus: new bus device registered: bus-dmc (100000
>>>>>>> KHz ~ 400000 KHz)
>>>>>>> [    6.122726] exynos-bus: new bus device registered: bus-leftbus
>>>>>>> (100000 KHz ~ 200000 KHz)
>>>>>>> [    6.146705] exynos-bus: new bus device registered: bus-mfc (100000
>>>>>>> KHz ~ 200000 KHz)
>>>>>>> [    6.181632] exynos-bus: new bus device registered: bus-peri ( 50000
>>>>>>> KHz ~ 100000 KHz)
>>>>>>> [    6.204770] exynos-bus: new bus device registered: bus-rightbus
>>>>>>> (100000 KHz ~ 200000 KHz)
>>>>>>> [    6.211087] exynos-bus: new bus device registered: bus-acp (100000
>>>>>>> KHz ~ 267000 KHz)
>>>>>>> [    6.216936] exynos-bus: new bus device registered: bus-c2c (100000
>>>>>>> KHz ~ 400000 KHz)
>>>>>>> [    6.225748] exynos-bus: new bus device registered: bus-display
>>>>>>> (160000 KHz ~ 200000 KHz)
>>>>>>> [    6.242978] exynos-bus: new bus device registered: bus-fsys (100000
>>>>>>> KHz ~ 134000 KHz)
>>>>>>>
>>>>>>> This is definitely a driver bug, but so far it worked fine, so this is a
>>>>>>> regression that need to be addressed somehow...
>>>>>> Thanks for checking, but what is exactly the bug? The devices registered
>>>>>> - just with different name.
>>>>> The bug is that the board fails to boot from time to time, freezing
>>>>> after registering PPMU counters...
>>>> My U3 with and without this patch, reports several warnings:
>>>> iommu_group_do_set_platform_dma()
>>>> exynos_iommu_domain_free()
>>>> clk_core_enable()
>>>>
>>>> and finally:
>>>> rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
>>>>
>>>> and keeps stalling.
>>>>
>>>> At least on next-20230203. Except all these (which anyway make board
>>>> unbootable) look fine around PMU and exynos-bus.
>>> I also booted few times my next/dt branch (with this patch) and no
>>> problems. How reproducible is the issue you experience?
>> IOMMU needs a fixup, that has been merged today:
>>
>> https://lore.kernel.org/all/20230123093102.12392-1-m.szyprowski@samsung.com/
>>
>> I was initially convinced that this freeze is somehow related to this
>> IOMMU fixup, but it turned out that the devfreq is a source of the problems.
>>
>> The freeze happens here about 1 of 10 boots, usually with kernel
>> compiled from multi_v7_defconfig, while loading the PPMU modules. It
>> happens on your next/dt branch too.
> I was able to reproduce it easily with multi_v7. Then I commented out
> dmc bus which fixed the issue. Then I commented out acp and c2c buses
> (children/passive) which also fixed the issue. Then I uncommented
> everything and went back to next/dt - exactly the same as it was failing
> - and since then I cannot reproduce it. I triple checked, but now my
> multi_v7 on U3 on next/dt boots perfectly fine. Every time.

This issue still happens from time to time. I quick workaround to fix it 
is to add:

MODULE_SOFTDEP("pre: exynos_ppmu");

to the exynos-bus driver. Is it acceptable solution?


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

