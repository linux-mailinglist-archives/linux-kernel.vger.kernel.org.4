Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB876BCCDC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 11:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjCPKci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 06:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjCPKcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 06:32:35 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3F29E662
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 03:32:25 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230316103223euoutp02763c183c12d3a152632f6e55626377ef~M37gp0JVr1209312093euoutp02d
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 10:32:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230316103223euoutp02763c183c12d3a152632f6e55626377ef~M37gp0JVr1209312093euoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1678962743;
        bh=ZmeyBd8te5kI9oD6jhl0sEaVzw9qHtdyeAc3swb1yls=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=XZo7aoOnEnZ1d9ZNqyn4zrZuW0cSCnCadD22ryxB0rZyRTqjrVn1n5/Z8ziIsD+mO
         uY2H0ww6HNm741fBVdY2hczx9vx7XY4nmwCHcjcCLIsM+HxweP8pX/6AUzaT+SiPnO
         FBgfBLu3YZBS6rXR++h3Z1zw/1UA1tG04kVP9rvY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230316103222eucas1p299288b7fadc8470d7b87db3df57a0dd0~M37gUVp5r3190431904eucas1p2f;
        Thu, 16 Mar 2023 10:32:22 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id CF.E2.10014.630F2146; Thu, 16
        Mar 2023 10:32:22 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230316103222eucas1p214f06f10db9fee4f1d52a77eb3616af3~M37f-hv7r0161301613eucas1p2f;
        Thu, 16 Mar 2023 10:32:22 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230316103222eusmtrp16c87f182a5f20586828c96b94aeedc1f~M37f_zgHN2761027610eusmtrp1W;
        Thu, 16 Mar 2023 10:32:22 +0000 (GMT)
X-AuditID: cbfec7f5-b8bff7000000271e-39-6412f036c006
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id B2.CA.09583.630F2146; Thu, 16
        Mar 2023 10:32:22 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230316103221eusmtip1dfcef164b05e184cb107baa9ff9681de~M37fK-AyA1918419184eusmtip14;
        Thu, 16 Mar 2023 10:32:21 +0000 (GMT)
Message-ID: <e66ccc6a-5cfb-56cf-767c-115c8d3d940d@samsung.com>
Date:   Thu, 16 Mar 2023 11:32:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v4 2/2] ARM: dts: exynos: add mmc aliases
Content-Language: en-US
To:     Henrik Grimler <henrik@grimler.se>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, alim.akhtar@samsung.com,
        jenneron@protonmail.com, markuss.broks@gmail.com,
        martin.juecker@gmail.com, virag.david003@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Cc:     Valentine Iourine <iourine@iourine.msk.su>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20230315212644.15764-3-henrik@grimler.se>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHKsWRmVeSWpSXmKPExsWy7djPc7pmH4RSDD5P17N4MG8bm8X8I+dY
        Ld4u2cVoMfXRMSaLHZcusFr0vXjIbLHp8TVWi8u75rBZzDi/j8ni3IF1zBZn/k1lsVjwx86i
        de8Rdovj7x8zWmz+/pfRgd9j56y77B5Hr9xj9Vi4+x+bx6ZVnWwed67tYfPYvKTe4/+dtewe
        PW2bmDz6tqxi9Pi8SS6AK4rLJiU1J7MstUjfLoEro7XlK2PBTpaKq7fPsjUw3mLuYuTkkBAw
        kXh/fR9rFyMXh5DACkaJ7XuvM0E4XxglVr18D+V8ZpS4/3EVUAsHWMvkRhaI+HJGiT3TX7BB
        OB8ZJWacfA42l1fATqJrXyM7iM0ioCqx5MsFJoi4oMTJmU9YQGxRgRSJHed3g9UIC9hKLDnf
        DlbDLCAucevJfLDNIgLrmSWenn7CDpHQk5jxdjGYzSZgKNH1tosNxOYUMJfY1rCWBaJGXmL7
        2znMIM0SAvs5JVadu8oO8amLxL8PD9ggbGGJV8e3QMVlJE5P7mGBaGhnlFjw+z4ThDOBUaLh
        +S1GiCpriTvnfrGBAoBZQFNi/S59iLCjxIVF25kg4cInceOtIMQRfBKTtk2HBhevREebEES1
        msSs4+vg1h68cIl5AqPSLKRwmYXk/1lI3pmFsHcBI8sqRvHU0uLc9NRi47zUcr3ixNzi0rx0
        veT83E2MwCR4+t/xrzsYV7z6qHeIkYmD8RCjBAezkghvOItAihBvSmJlVWpRfnxRaU5q8SFG
        aQ4WJXFebduTyUIC6YklqdmpqQWpRTBZJg5OqQamJZsXx7pU7p/ed+L8NWX1N6eSZsZpXX8o
        dyBY8LZVztravX+fy8aoLFA99Y53Q8cv1YeWSv5K6pea9u+e+eh0utndKO54phP3Dh5//nrK
        yzCxUqUPT8skZOdcz+v+I7v33bITG1m4nz51/vyi+tbVqFSzpDV3d88xu31jsUGL1uGzezqZ
        fgt82rEtXeWAvGWf7dS5niZlGkrrWv4EtGU/XumXHiM3dc/M6yY9ubpO7lFKMpElsw1msWQ/
        5r7jsmrWAsZdlofOXl1+cuFl40kHm56L3706+7lJ0f6bbyrfrOM9tX+Ft6dDQlXOnw5lwaKS
        5wxCrkyOS/bZ5PRxTD7ycnqR4m2ffdaPn2UqqIjJJymxFGckGmoxFxUnAgC0fIOh8QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRmVeSWpSXmKPExsVy+t/xu7pmH4RSDP7NFbV4MG8bm8X8I+dY
        Ld4u2cVoMfXRMSaLHZcusFr0vXjIbLHp8TVWi8u75rBZzDi/j8ni3IF1zBZn/k1lsVjwx86i
        de8Rdovj7x8zWmz+/pfRgd9j56y77B5Hr9xj9Vi4+x+bx6ZVnWwed67tYfPYvKTe4/+dtewe
        PW2bmDz6tqxi9Pi8SS6AK0rPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/O
        JiU1J7MstUjfLkEvo7XlK2PBTpaKq7fPsjUw3mLuYuTgkBAwkZjcyNLFyMkhJLCUUeJIN5gt
        ISAjcXJaAyuELSzx51oXWxcjF1DNe0aJlWfugyV4BewkuvY1soPYLAKqEku+XGCCiAtKnJz5
        hAVkvqhAisTsLh2QsLCArcSS8+1gJcwC4hK3nsxnApkpIrCeWWLV5G52iISexIy3i9khlm1n
        lJi29R3YRWwChhJdb0Gu4OTgFDCX2NawlgWiwUyia2sXI4QtL7H97RzmCYxCs5DcMQvJwllI
        WmYhaVnAyLKKUSS1tDg3PbfYSK84Mbe4NC9dLzk/dxMjMOK3Hfu5ZQfjylcf9Q4xMnEwHmKU
        4GBWEuENZxFIEeJNSaysSi3Kjy8qzUktPsRoCgyMicxSosn5wJSTVxJvaGZgamhiZmlgamlm
        rCTO61nQkSgkkJ5YkpqdmlqQWgTTx8TBKdXAJKG+SKh3Zc/sn6bGW6/udp33aOOPomnvlF1n
        WDP8C16io78v4zib+M0W/Wl9G2oX9CofvVH/J2xd7/m9ptp3eAzZLYvnObI5/C2c/Pj3zg/q
        u6auKWHjK1nLcTAw5c51PuZT5cv9t56z3vxO99jpjT9jH121t78bXfbI9hRHwGnx3PC0XTtW
        PcgwvNz1rLE+4+vjL0sm9aXXRmSIzi1V43t4K1DIdOOt4MKLrvNOrD1ss+rntVKJD1U7w+tl
        YncnOn7y3OfK9C/U5VH5nP3r1p0Mu3FC6etv7wpJZgHmEyXvv2xRyeo9H/9j8pKWUGuZjwmv
        S7Ys917H9srizDaH2YYqSnzLJ527VTpterxSupoSS3FGoqEWc1FxIgD/nnNZgQMAAA==
X-CMS-MailID: 20230316103222eucas1p214f06f10db9fee4f1d52a77eb3616af3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230315212733eucas1p2d4d9599dbd561cdd0c963ae3251162a3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230315212733eucas1p2d4d9599dbd561cdd0c963ae3251162a3
References: <20230315212644.15764-1-henrik@grimler.se>
        <CGME20230315212733eucas1p2d4d9599dbd561cdd0c963ae3251162a3@eucas1p2.samsung.com>
        <20230315212644.15764-3-henrik@grimler.se>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.03.2023 22:26, Henrik Grimler wrote:
> Add aliases for eMMC, SD card and WiFi where applicable, so that
> assigned mmc indeces are always the same.
>
> Co-developed-by: Anton Bambura <jenneron@protonmail.com>
> Signed-off-by: Anton Bambura <jenneron@protonmail.com>
> [ Tested on exynos5800-peach-pi ]
> Tested-by: Valentine Iourine <iourine@iourine.msk.su>
> Signed-off-by: Henrik Grimler <henrik@grimler.se>

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

 > ...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

