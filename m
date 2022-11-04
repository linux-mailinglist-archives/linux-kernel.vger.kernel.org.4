Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD246195EB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 13:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbiKDMKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 08:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbiKDMKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 08:10:09 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA841CC4
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 05:10:07 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20221104121005euoutp023f0dd1957255e615381811bccb47e5ef~kYHIm-XRD1899018990euoutp02J
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 12:10:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20221104121005euoutp023f0dd1957255e615381811bccb47e5ef~kYHIm-XRD1899018990euoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1667563805;
        bh=DLleL9gkXPRU0PALPUGD8RAjYG0Vq+E7TnhQG5SlhFc=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=c62YI9cOTwjDLk6SXNiEwJh9VNAQfayfA1tA8k9rzWLM56guqUCepfXQxbvawm0Qg
         C4BFcDXh9oatx26QeTPmjktSGOWnwfYsdjNR1p1BTw9LhIYRZk0XOfMA2SFJ9WCi8d
         KDX2lKmKS45zQo6FFiCTdEhK6qmQn35pBKFaaBRc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20221104121004eucas1p247e148ba44a21a6fddd2ee558a0e3257~kYHHlIAbG2046920469eucas1p2p;
        Fri,  4 Nov 2022 12:10:04 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 82.A7.07817.C1105636; Fri,  4
        Nov 2022 12:10:04 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20221104121003eucas1p2120c1a24faa8941059066370ba228b5f~kYHGqhTrv1771617716eucas1p25;
        Fri,  4 Nov 2022 12:10:03 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221104121003eusmtrp2fcdab1ca1561d2f36ee3ebd36be66bfe~kYHGprAXv1955519555eusmtrp27;
        Fri,  4 Nov 2022 12:10:03 +0000 (GMT)
X-AuditID: cbfec7f4-8abff70000011e89-84-6365011c86c8
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 10.F3.10862.B1105636; Fri,  4
        Nov 2022 12:10:03 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221104121002eusmtip1019abf6ed68bf35d6b202b352474decd~kYHF5jr942986229862eusmtip1S;
        Fri,  4 Nov 2022 12:10:02 +0000 (GMT)
Message-ID: <a7d9cd18-a328-209c-c89f-afdcb7db3eb0@samsung.com>
Date:   Fri, 4 Nov 2022 13:10:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH v2 0/6] iommu/exynos: Convert to a module
Content-Language: en-US
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Janghyuck Kim <janghyuck.kim@samsung.com>,
        Cho KyongHo <pullip.cho@samsung.com>,
        Daniel Mentz <danielmentz@google.com>,
        David Virag <virag.david003@gmail.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20221103195154.21495-1-semen.protsenko@linaro.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFKsWRmVeSWpSXmKPExsWy7djP87oyjKnJBmff8ls8mLeNzWJCRyuT
        xa8vFhab5xRbdM7ewG6x9/VWdotNj6+xWlzeNYfNYsb5fUwW/3oPMloc/PCE1eJ5H5B76u5n
        dovj7x8zWrTcMXXg93hycB6Tx5p5axg9ds66y+6xYFOpx6ZVnWwed67tYfPYvKTe48XmmYwe
        fVtWMXp83iQXwBXFZZOSmpNZllqkb5fAlfHlfGLBDsGKd9vesjcwXuLtYuTkkBAwkTi05yNb
        FyMXh5DACkaJNbvmsUA4XxglFjcehMp8ZpR4c/Q8I0zLow0LoRLLGSVeT9jLBOF8ZJRY+HIv
        G0gVr4CdxMdHC8BsFgEViVfda6HighInZz5hAbFFBVIkdndvA7OFBWwlWuecYAexmQXEJW49
        mc8EYosIpElc/XefFWQBs8B9Zon1TyeBFbEJGEp0ve0CGsrBwSngINHezAbRKy+x/e0cZpB6
        CYH1nBLbDt2EOttF4ubO41C2sMSr41vYIWwZif875zNBNLQzSiz4fR/KmcAo0fD8FlSHtcSd
        c7/AtjELaEqs36UPEXaUeHDtKCNIWEKAT+LGW0GII/gkJm2bzgwR5pXoaBOCqFaTmHV8Hdza
        gxcuMU9gVJqFFCyzkLw/C8k7sxD2LmBkWcUonlpanJueWmyUl1quV5yYW1yal66XnJ+7iRGY
        /E7/O/5lB+PyVx/1DjEycTAeYpTgYFYS4f20LTlZiDclsbIqtSg/vqg0J7X4EKM0B4uSOC/b
        DK1kIYH0xJLU7NTUgtQimCwTB6dUA5P+Y+2amjyXDZe4K8ojNjHtWCddYti756Huay+nGXqL
        rj1/vV9Ya8py7/WbUifXWD4yeNp24KLz5H0uZc/4BD90pqTe+bjkpNqq9Vdq1By0smX9Q5jm
        66jXvjb2/9vSfkXx66n6Wpm9P3Q3hq1+8LWw6axkyOLFxet7XGyq5i4MCDk8xzZZNcfUsHPi
        96C7855wu9xVXRi3ynmvbmyk4XkL9wcrEpNq7ZhfH1OW7Urm0/oknrHtW/9V5V3/Jbqe3j4v
        ze6p6/aXf/NSfZOjakfDH+b8c203Kv+6yn93jWDEpOjtW9Z/Edg75evF/dY3Yt/v/Zh+6e8m
        k6ilxdzNP2YXLoxu8218l73H0LA8X1SJpTgj0VCLuag4EQC+pnBK7QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFIsWRmVeSWpSXmKPExsVy+t/xu7rSjKnJBkdPClg8mLeNzWJCRyuT
        xa8vFhab5xRbdM7ewG6x9/VWdotNj6+xWlzeNYfNYsb5fUwW/3oPMloc/PCE1eJ5H5B76u5n
        dovj7x8zWrTcMXXg93hycB6Tx5p5axg9ds66y+6xYFOpx6ZVnWwed67tYfPYvKTe48XmmYwe
        fVtWMXp83iQXwBWlZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZ
        llqkb5egl/HlfGLBDsGKd9vesjcwXuLtYuTkkBAwkXi0YSFbFyMXh5DAUkaJJYe/MUMkZCRO
        TmtghbCFJf5c64Iqes8o8WrpHHaQBK+AncTHRwvYQGwWARWJV91r2SDighInZz5h6WLk4BAV
        SJH4dq4OJCwsYCvROucEWCuzgLjErSfzmUBsEYE0iX2TXjNCxB8yS8xYqwCxazKjxJo108AS
        bAKGEl1vQY7g4OAUcJBob2aDqDeT6NraBdUrL7H97RzmCYxCs5BcMQvJullIWmYhaVnAyLKK
        USS1tDg3PbfYSK84Mbe4NC9dLzk/dxMjMNK3Hfu5ZQfjylcf9Q4xMnEwHmKU4GBWEuH9tC05
        WYg3JbGyKrUoP76oNCe1+BCjKTAoJjJLiSbnA1NNXkm8oZmBqaGJmaWBqaWZsZI4r2dBR6KQ
        QHpiSWp2ampBahFMHxMHp1QDU+cn7n3zNd9FmMWZTzdb4NYSve5q4JX7j6XtXu3SWKr6S++m
        q+5XIUF360KLfcaabw/lxP3R/7ImjHnxKR/pnNOSQgaL2a623Ntc2auxzngSe0KxwOYLSz7O
        eVrcNEH0UnlO/lu3NZv+FcjMeHj11U+54g0FnzJa7xdcDulYYaF+TabXleeGvFPttmeuNT0i
        XzL4jvi517h9O/Pwp2fSMoHuu2z2TDen3srfPFlX4gG72q+c6Ge/FNL6jd1v5zce/nRfIE9H
        4s3SxWJ6n5acWFF1UG9VasqWif99OlyYuZi7zXYWSDnK7Quq2/JQ6qOZjlO96d16DhcRo0PX
        LiYx6hlUHri/smzW6pPCt9fMVWIpzkg01GIuKk4EAIVlL0l9AwAA
X-CMS-MailID: 20221104121003eucas1p2120c1a24faa8941059066370ba228b5f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20221103195201eucas1p2a6ec2df41ebac3d9ccbb0b252c2cad34
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221103195201eucas1p2a6ec2df41ebac3d9ccbb0b252c2cad34
References: <CGME20221103195201eucas1p2a6ec2df41ebac3d9ccbb0b252c2cad34@eucas1p2.samsung.com>
        <20221103195154.21495-1-semen.protsenko@linaro.org>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.11.2022 20:51, Sam Protsenko wrote:
> As exynos-iommu driver is not a critical platform driver, it can be
> converted to a loadable module to avoid loading it on non-Exynos
> platforms in order to improve the RAM footprint. This patch series
> converts it to a module and does some related cleanups. IOMMU/DMA
> specifics were taken into the account, so remove/exit methods weren't
> added.
>
> There are two drivers using CONFIG_EXYNOS_IOMMU in their code:
> DRM_EXYNOS and S5P_MFC. Both were checked, and only a slight change was
> needed for S5P_MFC driver (patch #6).

Funny, compiling this driver as a module revealed an issue in the driver 
initialization sequence, here is a fix that need to be applied before 
this patchset:

https://lore.kernel.org/all/20221104115511.28256-1-m.szyprowski@samsung.com/

Besides that, the driver nukes with NULL pointer dereference in 
exynos_iommu_of_xlate() when compiled as a module on ARM 64bit 
Exynos5433 based TM2e board. ARM 32bit based board works fine. I'm 
checking this issue now.

> Changes in v2:
>    - Extracted the "shutdown" method addition into a separate patch
>    - Added MODULE_DEVICE_TABLE(of, ...) to support hot-plug loading
>    - Added MODULE_ALIAS("platform:exynos-sysmmu")
>    - Added fix for S5P_MFC driver to work correctly with EXYNOS_IOMMU=m
>    - Fixed checkpatch coding style suggestion with "--strict" flag
>    - Rebased on top of most recent joro/iommu.git:next
>
> Sam Protsenko (6):
>    iommu: Export iommu_group_default_domain() API
>    iommu/exynos: Fix retval on getting clocks in probe
>    iommu/exynos: Modularize the driver
>    iommu/exynos: Implement shutdown driver method
>    iommu/exynos: Rearrange the platform driver code
>    media: platform: Use IS_ENABLED() to check EXYNOS_IOMMU in s5p_mfc
>
>   drivers/iommu/Kconfig                         |   2 +-
>   drivers/iommu/exynos-iommu.c                  | 355 +++++++++---------
>   drivers/iommu/iommu.c                         |   1 +
>   .../platform/samsung/s5p-mfc/s5p_mfc_iommu.h  |   4 +-
>   4 files changed, 191 insertions(+), 171 deletions(-)
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

