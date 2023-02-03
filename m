Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D474E68981E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 12:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbjBCLvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 06:51:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbjBCLvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 06:51:33 -0500
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CEF9DCAC
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 03:51:29 -0800 (PST)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230203115127euoutp0159c874f5acd3382632a40ebebc3895eb~ATj2FoA4j1831518315euoutp01M
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 11:51:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230203115127euoutp0159c874f5acd3382632a40ebebc3895eb~ATj2FoA4j1831518315euoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1675425087;
        bh=WS3pSOlmfoAAffW4BPQUdPE1/YhAN9GcS9+6n5EKuLo=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=IoZQrYhOx6QrCzmB3tLBG9Lyy+RzvWSuuflmea5oU3Y2xF4SpEiAH19sSfTD8i2qG
         zvDGsy+B+fwmz9wuarGo8iSIMc3uB8yRRtX0upMWFgj+j7tH+zTaQmgLmvqGzBhwpy
         tYj1N7R1glnWuGvoiiGi7eGOTqM9bFFcREJmrXMs=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230203115127eucas1p2ea5b970e55bc5977348b926aa981b01a~ATj1yrEbk1464914649eucas1p22;
        Fri,  3 Feb 2023 11:51:27 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 4B.EA.61197.F35FCD36; Fri,  3
        Feb 2023 11:51:27 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230203115126eucas1p25bd687fd87f175bb188eaebfaf29a2d5~ATj1MjnuR0219902199eucas1p2W;
        Fri,  3 Feb 2023 11:51:26 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230203115126eusmtrp2be5b88f7437bd274b94a89a2f0c66e3f~ATj1LvLrf1102911029eusmtrp2M;
        Fri,  3 Feb 2023 11:51:26 +0000 (GMT)
X-AuditID: cbfec7f5-7dbff7000000ef0d-dc-63dcf53f871a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 75.31.00518.E35FCD36; Fri,  3
        Feb 2023 11:51:26 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230203115125eusmtip1a06a047d619741c4aa652e33a6cd7339~ATj0b3HJc0326103261eusmtip1G;
        Fri,  3 Feb 2023 11:51:25 +0000 (GMT)
Message-ID: <111f7364-0d7b-b4c5-721f-69c00d4619e2@samsung.com>
Date:   Fri, 3 Feb 2023 12:51:25 +0100
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
In-Reply-To: <d54792c5-2842-e5b9-26b8-1f52471211a9@linaro.org>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKKsWRmVeSWpSXmKPExsWy7djPc7r2X+8kG/xcwWrxYN42NovrX56z
        Wsw/co7V4u2SXYwW/Y9fM1v0vXjIbLH39VZ2i02Pr7FaXN41h81ixvl9TBZn/k1lsVjwx85i
        3RpBi9a9R9gtNn//y+jA77Fz1l12j6NX7rF6bFrVyeZx59oeNo/NS+o9/t9Zy+7xpbmb1aNv
        yypGj8+b5AI4o7hsUlJzMstSi/TtErgyuiZcZSvYJVNxcs8HlgbGJeJdjBwcEgImEk13RLoY
        uTiEBFYwSjxcOZEJwvnCKNHybzl7FyMnkPOZUeLlsjSYhhWTNSFqljNKXH6zmBnC+cgoMf/E
        O2aQBl4BO4npf26CNbMIqEjcWL6OBSIuKHFy5hMWkEGiAikSm/6UgYSFBaIlFv29wwpiMwuI
        S9x6Mh/sCBGBZ0wSM7e2MkEknjNK3P7LBmKzCRhKdL3tArM5gXatbVoG1Swv0bx1NthBEgLb
        OSV+vbkBViQh4CLxrmsfE4QtLPHq+BZ2CFtG4v9OiG0SAu2MEgt+34dyJjBKNDy/xQhRZS1x
        59wvNpCzmQU0Jdbv0ocIO0o83PKXDRIsfBI33gpCHMEnMWnbdGaIMK9ER5sQRLWaxKzj6+DW
        HrxwiXkCo9IspGCZheT/WUjemYWwdwEjyypG8dTS4tz01GLjvNRyveLE3OLSvHS95PzcTYzA
        lHf63/GvOxhXvPqod4iRiYPxEKMEB7OSCO/y03eShXhTEiurUovy44tKc1KLDzFKc7AoifNq
        255MFhJITyxJzU5NLUgtgskycXBKNTC1MBz+KOcynTO6r1LNNWzWD64NtTtypJYsPbWIp0D0
        +KU/kZ3t5StPul9el5B4lqV5Y0vFSztpx8ltVXxX0oXV17voNSp2uaza6vb+hlbj5YoPC8xC
        xGbU//P9/0N5f2r481eL4gIsmRc1Vq+L2hPJop9lpCMlXBUwP9x1ku71C2Y7HJbka1wwfngy
        8OAG9jefuF9Nsyx7Via+qudrbFbaKsH1wtp8y21n3T3IYv091vTlsXVTgjpdQv9tnPN2ea6q
        AXdJx988hSNyUi+6JvbbfDy+srIpRyjGLHhB/52crLcHDh08oKzH9/DcSrWTR6b5VLI0fprb
        x7X3yl+Pki/38q5Pkxf5eKFnwtkDe3WUWIozEg21mIuKEwELw6Ay6AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNIsWRmVeSWpSXmKPExsVy+t/xu7p2X+8kG0zZIG3xYN42NovrX56z
        Wsw/co7V4u2SXYwW/Y9fM1v0vXjIbLH39VZ2i02Pr7FaXN41h81ixvl9TBZn/k1lsVjwx85i
        3RpBi9a9R9gtNn//y+jA77Fz1l12j6NX7rF6bFrVyeZx59oeNo/NS+o9/t9Zy+7xpbmb1aNv
        yypGj8+b5AI4o/RsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstS
        i/TtEvQyuiZcZSvYJVNxcs8HlgbGJeJdjBwcEgImEisma3YxcnEICSxllDj56wpzFyMnUFxG
        4uS0BlYIW1jiz7UuNoii94wSq/Z0MIIkeAXsJKb/uckOYrMIqEjcWL6OBSIuKHFy5hMwW1Qg
        RaL5+UmwQcIC0RJrnh9hArGZBcQlbj2ZzwQyVETgGZPE4+fbWEAcZoHnjBL3tzaxQqz7wCSx
        7/tzsHY2AUOJrrcgd3BycAKtXtu0jBVilJlE19YuRghbXqJ562zmCYxCs5BcMgvJxllIWmYh
        aVnAyLKKUSS1tDg3PbfYSK84Mbe4NC9dLzk/dxMjMNa3Hfu5ZQfjylcf9Q4xMnEwHmKU4GBW
        EuFdfvpOshBvSmJlVWpRfnxRaU5q8SFGU2BwTGSWEk3OByabvJJ4QzMDU0MTM0sDU0szYyVx
        Xs+CjkQhgfTEktTs1NSC1CKYPiYOTqkGplrVjbf2buQWeGZy2/bSv6lKfstCoz/O+24Sd87l
        q7AxXy7zQc/i+xEaG+fNDdmiFpmpu3mdW8yeoigFS9fNm9VV3WUTeK+L8TTEfprjUniqfPrJ
        A/68W3OkrM+VPtz2eHbvrmn3tvpP80hRYvo5/+F3DtZ5B7fLntr/2O3Vml33ZGZ840k28div
        7LYjzOPDjg0ZYVtzbn8w/DrxpJfBI53oa//3uHTI+axyv/uNO2hyy5xkmzjlxOccmhadm1+q
        Pa1M2bXbzSVASVQt52rm3YBPnJsbDJXzTJmze17HBkazTno9+8PJK+cVdDbpqNgVlUfb5Xr+
        9irudvz4cmLty2Kzu6f3JZjdKDv111itVYmlOCPRUIu5qDgRAGPveb1+AwAA
X-CMS-MailID: 20230203115126eucas1p25bd687fd87f175bb188eaebfaf29a2d5
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
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.02.2023 12:46, Krzysztof Kozlowski wrote:
> On 03/02/2023 12:45, Marek Szyprowski wrote:
>> On 29.01.2023 11:42, Krzysztof Kozlowski wrote:
>>> On 25/01/2023 10:45, Krzysztof Kozlowski wrote:
>>>> The soc node is supposed to have only device nodes with MMIO addresses,
>>>> as reported by dtc W=1:
>>>>
>>>>     exynos4412.dtsi:407.20-413.5:
>>>>       Warning (simple_bus_reg): /soc/bus-acp: missing or empty reg/ranges property
>>>>
>>>> and dtbs_check:
>>>>
>>>>     exynos4412-i9300.dtb: soc: bus-acp:
>>>>       {'compatible': ['samsung,exynos-bus'], 'clocks': [[7, 456]], 'clock-names': ['bus'], 'operating-points-v2': [[132]], 'status': ['okay'], 'devfreq': [[117]]} should not be valid under {'type': 'object'}
>>>>
>>>> Move the bus nodes and their OPP tables out of SoC to fix this.
>>>> Re-order them alphabetically while moving and put some of the OPP tables
>>>> in device nodes (if they are not shared).
>>>>
>>> Applied.
>> I don't have a good news. It looks that this change is responsible for
>> breaking boards that were rock-stable so far, like Odroid U3. I didn't
>> manage to analyze what exactly causes the issue, but it looks that the
>> exynos-bus devfreq driver somehow depends on the order of the nodes:
>>
>> (before)
>>
>> # dmesg | grep exynos-bus
>> [    6.415266] exynos-bus: new bus device registered: soc:bus-dmc
>> (100000 KHz ~ 400000 KHz)
>> [    6.422717] exynos-bus: new bus device registered: soc:bus-acp
>> (100000 KHz ~ 267000 KHz)
>> [    6.454323] exynos-bus: new bus device registered: soc:bus-c2c
>> (100000 KHz ~ 400000 KHz)
>> [    6.489944] exynos-bus: new bus device registered: soc:bus-leftbus
>> (100000 KHz ~ 200000 KHz)
>> [    6.493990] exynos-bus: new bus device registered: soc:bus-rightbus
>> (100000 KHz ~ 200000 KHz)
>> [    6.494612] exynos-bus: new bus device registered: soc:bus-display
>> (160000 KHz ~ 200000 KHz)
>> [    6.494932] exynos-bus: new bus device registered: soc:bus-fsys
>> (100000 KHz ~ 134000 KHz)
>> [    6.495246] exynos-bus: new bus device registered: soc:bus-peri (
>> 50000 KHz ~ 100000 KHz)
>> [    6.495577] exynos-bus: new bus device registered: soc:bus-mfc
>> (100000 KHz ~ 200000 KHz)
>>
>> (after)
>>
>> # dmesg | grep exynos-bus
>>
>> [    6.082032] exynos-bus: new bus device registered: bus-dmc (100000
>> KHz ~ 400000 KHz)
>> [    6.122726] exynos-bus: new bus device registered: bus-leftbus
>> (100000 KHz ~ 200000 KHz)
>> [    6.146705] exynos-bus: new bus device registered: bus-mfc (100000
>> KHz ~ 200000 KHz)
>> [    6.181632] exynos-bus: new bus device registered: bus-peri ( 50000
>> KHz ~ 100000 KHz)
>> [    6.204770] exynos-bus: new bus device registered: bus-rightbus
>> (100000 KHz ~ 200000 KHz)
>> [    6.211087] exynos-bus: new bus device registered: bus-acp (100000
>> KHz ~ 267000 KHz)
>> [    6.216936] exynos-bus: new bus device registered: bus-c2c (100000
>> KHz ~ 400000 KHz)
>> [    6.225748] exynos-bus: new bus device registered: bus-display
>> (160000 KHz ~ 200000 KHz)
>> [    6.242978] exynos-bus: new bus device registered: bus-fsys (100000
>> KHz ~ 134000 KHz)
>>
>> This is definitely a driver bug, but so far it worked fine, so this is a
>> regression that need to be addressed somehow...
>
> Thanks for checking, but what is exactly the bug? The devices registered
> - just with different name.

The bug is that the board fails to boot from time to time, freezing 
after registering PPMU counters...

Best regards

-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

