Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E6567FB6A
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 23:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjA1Wzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 17:55:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjA1Wzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 17:55:48 -0500
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D2323D99
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 14:55:43 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230128225539euoutp01ab8cbc3415d35b56d9ff3e9785bd131f~_mwDoinaL0851908519euoutp01C
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 22:55:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230128225539euoutp01ab8cbc3415d35b56d9ff3e9785bd131f~_mwDoinaL0851908519euoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1674946539;
        bh=teddXjoVzkAfzf7gd+eRxVt62IjBdeRbie00f/bRDc0=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=UGMFHxdd+WUjqHKfhVFASEZNMkln04cm9KkgeqYSIPDRXn7ziCDILvjWwx0t1UeqW
         OfnCFSY/ujFw5hDRH6Dz2DV15HUfmkCiGFkVl8VqIjZAfKuXnOyPusGv73auwiGHFM
         5jTBk7+co10M4IKpQkC8+AmyjZdWapR2MJP4mKqg=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230128225538eucas1p17edb6104df27edd8cb543840a0137603~_mwCQFVDR0349603496eucas1p1v;
        Sat, 28 Jan 2023 22:55:38 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 98.FA.13597.9E7A5D36; Sat, 28
        Jan 2023 22:55:38 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230128225537eucas1p27906fc36dfcdebd81c65e7bf75dd9fb0~_mwBRp9_I1353613536eucas1p2S;
        Sat, 28 Jan 2023 22:55:37 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230128225537eusmtrp263d866e6aeb23b31410d5fe1b8d6f51e~_mwBQ_6Js0449604496eusmtrp2K;
        Sat, 28 Jan 2023 22:55:37 +0000 (GMT)
X-AuditID: cbfec7f4-1f1ff7000000351d-a4-63d5a7e971be
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D9.EB.02722.8E7A5D36; Sat, 28
        Jan 2023 22:55:36 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230128225536eusmtip20a542bfcf0a4fa80aff350daaa59f66e~_mwAgQVIx0141301413eusmtip2r;
        Sat, 28 Jan 2023 22:55:36 +0000 (GMT)
Message-ID: <6a2b0750-b71b-409e-7e9d-df0f3fa71a2e@samsung.com>
Date:   Sat, 28 Jan 2023 23:55:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 2/9] ARM: dts: exynos: move exynos-bus nodes out of soc
 in Exynos5420
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
In-Reply-To: <4dea3da5-54b6-bc50-a802-cb73ddccf5d8@linaro.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOKsWRmVeSWpSXmKPExsWy7djPc7qvll9NNmj5wGjxYN42NovrX56z
        Wsw/co7V4u2SXYwW/Y9fM1v0vXjIbLH39VZ2i02Pr7FaXN41h81ixvl9TBZn/k1lsVjwx85i
        3RpBi9a9R9gtNn//y+jA77Fz1l12j6NX7rF6bFrVyeZx59oeNo/NS+o9/t9Zy+7xpbmb1aNv
        yypGj8+b5AI4o7hsUlJzMstSi/TtErgyZq+bwFzwQaRi/p4tTA2MnwW6GDk5JARMJB6vfc3U
        xcjFISSwglFi8912NgjnC6PE0r5tjBDOZ0aJA32r2GBabi46yg6RWM4o8XLdZBYI5yOjxNef
        y5lBqngF7CQeXz0MlODgYBFQlfh2ghMiLChxcuYTsLCoQIrEpj9lIGFhgWiJg9O/gs1nFhCX
        uPVkPthJIgLPmCRmbm1lgkg8Z5S4/ResiE3AUKLrbReYzQm0qqtjOSNEjbzE9rdzmEGaJQQ2
        c0rsn7+IFeJqF4m9F+ZAfSAs8er4FnYIW0bi/06IbRIC7YwSC37fh3ImMEo0PL/FCFFlLXHn
        3C82kLOZBTQl1u/Shwg7SmxdvRTsGwkBPokbbwUhjuCTmLRtOjNEmFeio00IolpNYtbxdXBr
        D164xDyBUWkWUrDMQvL/LCTvzELYu4CRZRWjeGppcW56arFRXmq5XnFibnFpXrpecn7uJkZg
        2jv97/iXHYzLX33UO8TIxMF4iFGCg1lJhHer46VkId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rza
        tieThQTSE0tSs1NTC1KLYLJMHJxSDUyLvnWIynzh2dxyad3swgCHdbnMOoJm592vMSd0Cq4U
        kf+3u2q5QCKjsG1KjviVJy9DTcI+ST1cVzr7bCV3s1P9KXlWXdn9s2Uffj569Yot//bnYuw1
        1dZr7V9eXJwz+9TZLfGBCstPrJoefM6IcZP3LMnPk+2eH3j/X97aw2P+O0/D+j1ih89sZUjc
        6xB5P7fJxrpORPGo/xyLm7YZN1ljO5Y/Wpvusq4v/0hC5ydBs47KN+rVabNPf3bxC7yY/kTT
        tXpWx54pNjvOR07465P5I83lrlZf46mJse9W7NpZv6xroQdvXKRnjOGLSKXv8kq81gdeN4n+
        KH23+ffRoPZtwV5Pa+WkXly/G/jmb4ISS3FGoqEWc1FxIgC4OgdN6gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNIsWRmVeSWpSXmKPExsVy+t/xe7ovll9NNjh/3dLiwbxtbBbXvzxn
        tZh/5Byrxdsluxgt+h+/Zrboe/GQ2WLv663sFpseX2O1uLxrDpvFjPP7mCzO/JvKYrHgj53F
        ujWCFq17j7BbbP7+l9GB32PnrLvsHkev3GP12LSqk83jzrU9bB6bl9R7/L+zlt3jS3M3q0ff
        llWMHp83yQVwRunZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJal
        FunbJehlzF43gbngg0jF/D1bmBoYPwt0MXJySAiYSNxcdJS9i5GLQ0hgKaPEz4vXmCESMhIn
        pzWwQtjCEn+udbFBFL1nlNj1qZcNJMErYCfx+Ophli5GDg4WAVWJbyc4IcKCEidnPmEBsUUF
        UiSan58EmyMsEC2xct5esPnMAuISt57MZwKZKSLwjEni8fNtLCAOs8BzRon7W5tYIbZ9YJLY
        ffYXI0gLm4ChRNfbLrDNnECbuzqWM0KMMpPo2toFZctLbH87h3kCo9AsJJfMQrJxFpKWWUha
        FjCyrGIUSS0tzk3PLTbUK07MLS7NS9dLzs/dxAiM9W3Hfm7ewTjv1Ue9Q4xMHIyHGCU4mJVE
        eLc6XkoW4k1JrKxKLcqPLyrNSS0+xGgKDI2JzFKiyfnAZJNXEm9oZmBqaGJmaWBqaWasJM7r
        WdCRKCSQnliSmp2aWpBaBNPHxMEp1cCUqGOSEaFXGZkk2bz8X+QKpTIGd+2J6toNovWKngeM
        zy6VlOauPiCfFF92tzjowOnATzJJEj23T7ZLHxbfnVy3d1qDqcSylqNNTDeuPk24G6f94LjR
        9/ZSaxnx/oiieV3ljLZ2rT/9ZK3PvNKUZvtmu+Tr22LxEIuYDYabtUUMyta8abh8Wmizyxf+
        R6+7PuVt7fb63rr66D0Wua6pilNfHbG4cSdYdu+ZqyrTJZaVLik+9SHO+76szd29TFXGZy6e
        UukWUQ6IfR14hi1DubLlXhF3h+mTSs1rARwcpe7hSz7o55kE7q3yOXzrr4ZQ8NR95TpHMsJU
        lebeWFW5kneT+dLr3B9nSSTqbUqsVWIpzkg01GIuKk4EAOWe/LN+AwAA
X-CMS-MailID: 20230128225537eucas1p27906fc36dfcdebd81c65e7bf75dd9fb0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230125094529eucas1p29b5f25af2c658abef13a93c49eca975f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230125094529eucas1p29b5f25af2c658abef13a93c49eca975f
References: <20230125094513.155063-1-krzysztof.kozlowski@linaro.org>
        <CGME20230125094529eucas1p29b5f25af2c658abef13a93c49eca975f@eucas1p2.samsung.com>
        <20230125094513.155063-2-krzysztof.kozlowski@linaro.org>
        <cd42b8c9-a79a-068c-a967-810c05e818bd@samsung.com>
        <d8f5fa57-da3a-09f9-e297-197068264d26@linaro.org>
        <4dea3da5-54b6-bc50-a802-cb73ddccf5d8@linaro.org>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.01.2023 11:43, Krzysztof Kozlowski wrote:
> On 26/01/2023 11:59, Krzysztof Kozlowski wrote:
>> On 26/01/2023 10:47, Marek Szyprowski wrote:
>>> Hi Krzysztof,
>>>
>>> On 25.01.2023 10:45, Krzysztof Kozlowski wrote:
>>>> The soc node is supposed to have only device nodes with MMIO addresses,
>>>> as reported by dtc W=1:
>>>>
>>>>     arch/arm/boot/dts/exynos5420.dtsi:1070.24-1075.5:
>>>>       Warning (simple_bus_reg): /soc/bus-wcore: missing or empty reg/ranges property
>>>>
>>>> and dtbs_check:
>>>>
>>>>     exynos5420-arndale-octa.dtb: soc: bus-wcore:
>>>>       {'compatible': ['samsung,exynos-bus'], 'clocks': [[2, 769]], 'clock-names': ['bus'], 'status': ['disabled']} should not be valid under {'type': 'object'}
>>>>
>>>> Move the bus nodes and their OPP tables out of SoC to fix this.
>>>> Re-order them alphabetically while moving and put some of the OPP tables
>>>> in device nodes (if they are not shared).
>>>>
>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> Frankly speaking I'm not very keen on moving those bus nodes out of
>>> /soc. Technically speaking this is definitely a part of soc and doesn't
>>> make much sense outside of it. IMHO they describe SoC hardware details
>>> and they might be moved somehow under clock controller device(s),
>>> although this would require some changes in the bindings and drivers.
>> That's the only way to fix it without change of drivers any ABI
>> compatibility issue. The same we do for Qualcomm interconnects, e.g.
>> arch/arm64/boot/dts/qcom/sm8450.dtsi where some interconnects have some
>> do not have MMIO space.
>>
>> I want to achieve finally clean dtbs_check run for all Exynos sources.
>> The in-tree bindings already pass, so now I am fixing the ones coming
>> from dtschema (simple-bus.yaml in particular).
>>
>> If you have any other idea how to seamlessly clean it up, I am happy to
>> hear. But I guess the main problem is that no one is being paid for
>> doing anything for Samsung Exynos, so for free not many put much effort
>> into working on it.
> Marek, I value your feedback a lot and I appreciate your help here. Just
> to be clear that I am not ignoring it, little disclaimer:
>
> Unless there is a clear NAK from you or someone else, with an idea to
> fix or with a commitment to change driver/bindings, I am planning to
> grab these changes.
>
> I really want to get the dtbs_check done. With these and my other fixes,
> the arm64 exynos DTS pass fully all dtschema and in-kernel dtbs_check.

Go ahead. I won't block it.

Best regards

-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

