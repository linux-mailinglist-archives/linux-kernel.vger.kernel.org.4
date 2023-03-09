Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDA46B2106
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 11:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjCIKOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 05:14:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjCIKNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 05:13:50 -0500
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2237C1CBE7
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 02:13:16 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230309101301euoutp016ad6bdaa67044a588202d47d77f8423d~KuJm8tdX11153111531euoutp01j
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 10:13:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230309101301euoutp016ad6bdaa67044a588202d47d77f8423d~KuJm8tdX11153111531euoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1678356781;
        bh=QJxMvptBr9R9zrBbrseJ94rw8nv0FTvkVZRlgeEl6xc=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=U6tPEuXiOL4DAsLfFQ6h8sLg8GHbo1LHFtdvAG+YkgeDPtcNb4Am/ooyPtX05Q0Ms
         P3wTbtsnid/cm0Qatvf3mJ0dMaZhv7dxwinH3rP0e/XlOOdmIiJiaQOl0V0d7gvDpH
         CiiK3culUGvgwTF7f0UfBCtUyKEK7bRxQ3QERZ3g=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230309101301eucas1p1b4830baa61bf2729e144dcee95eac0b0~KuJmd29OY0145501455eucas1p1U;
        Thu,  9 Mar 2023 10:13:01 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id B9.90.10014.C21B9046; Thu,  9
        Mar 2023 10:13:00 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230309101300eucas1p2db2eff24d7b1f4073c8a43f49b086d9d~KuJl4luec1056510565eucas1p2T;
        Thu,  9 Mar 2023 10:13:00 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230309101300eusmtrp23ff57ebe6759770f2fbcb6d388253bca~KuJl389C63045430454eusmtrp2F;
        Thu,  9 Mar 2023 10:13:00 +0000 (GMT)
X-AuditID: cbfec7f5-ba1ff7000000271e-34-6409b12ca55a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A5.8C.09583.C21B9046; Thu,  9
        Mar 2023 10:13:00 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230309101259eusmtip1e8505a458710796f05c2baf58f51d7c5~KuJlSa7811427714277eusmtip1N;
        Thu,  9 Mar 2023 10:12:59 +0000 (GMT)
Message-ID: <d1175c3e-301d-1cbc-607c-e94051780806@samsung.com>
Date:   Thu, 9 Mar 2023 11:12:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH 0/6] soc: samsung: pm_domains: Add Exynos850 support
Content-Language: en-US
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20230308230931.27261-1-semen.protsenko@linaro.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBKsWRmVeSWpSXmKPExsWy7djPc7o6GzlTDJbttrJ4MG8bm8Xl/doW
        1788Z7WYf+Qcq8Xe11vZLTY9vsZqcXnXHDaLGef3MVm07j3CbvG8D8g6/v4xowO3x85Zd9k9
        Nq3qZPO4c20Pm8fmJfUefVtWMXp83iQXwBbFZZOSmpNZllqkb5fAlbHyXTtrwWuuium/NzM1
        MG7j6GLk5JAQMJE4vWcxUxcjF4eQwApGie9nTrNDOF8YJd7u/MYC4XxmlPjd+5gZpuXBum1Q
        VcsZJXY0zYVyPjJKLHkxjxWkilfATuLZ1HfsIDaLgIrEm6e/GCHighInZz5hAbFFBVIkdpzf
        DVYjLOAhcf73LzCbWUBc4taT+WBHiQh0MErs3vKQFcRhFljNJLFl0zqwbjYBQ4mut11sIDan
        gINE68YFzBDd8hLb385hBmmQEGjmlNg/6RQLxOEuEpcO/WGFsIUlXh3fwg5hy0j83wmxTkKg
        nVFiwe/7UM4ERomG57cYIaqsJe6c+wW0jgNohabE+l36EGFHiUuHH7ODhCUE+CRuvBWEOIJP
        YtK26cwQYV6JjjYhiGo1iVnH18GtPXjhEvMERqVZSAEzCykAZiF5ZxbC3gWMLKsYxVNLi3PT
        U4uN81LL9YoTc4tL89L1kvNzNzECE9fpf8e/7mBc8eqj3iFGJg7GQ4wSHMxKIrzfpThShHhT
        EiurUovy44tKc1KLDzFKc7AoifNq255MFhJITyxJzU5NLUgtgskycXBKNTBx99wwz//QKafj
        Yh4wIVxbIrxi8f/HBzfozzk3UdnGfFPW6vu2LpyyLgUqm04t/PalPisjTvicWmyfwZSYKq26
        rg/J74L3XF71WNi+deakism/Js8/f/bABbW/dkH5Sw7e//TgC8uFVvFQ4Qv8FzZnXtc5sMr6
        6xeH5nMnv8vX5x5d9p53bVdzfvDWyXeaWY7+jl86e6/zvoqVBdtuljU+MuZ50Z78RCdh1tSO
        E79MOd7evcrJ0rFSNn7SNYtTGu8Oba29NX19y6nJkhp3pkw4blKU+OHVZNn1pdOSzvGdnrxw
        grgwk+I1/wSRdTPfSeeufXp2xdlfs5x+rZv32vPNpokL5Y22NbA/+iv9i0ffMV+JpTgj0VCL
        uag4EQANyXkdywMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJIsWRmVeSWpSXmKPExsVy+t/xu7o6GzlTDK7cEbF4MG8bm8Xl/doW
        1788Z7WYf+Qcq8Xe11vZLTY9vsZqcXnXHDaLGef3MVm07j3CbvG8D8g6/v4xowO3x85Zd9k9
        Nq3qZPO4c20Pm8fmJfUefVtWMXp83iQXwBalZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqln
        aGwea2VkqqRvZ5OSmpNZllqkb5egl7HyXTtrwWuuium/NzM1MG7j6GLk5JAQMJF4sG4bexcj
        F4eQwFJGiQn/29ghEjISJ6c1sELYwhJ/rnWxQRS9Z5Q4dOMGWIJXwE7i2dR3YA0sAioSb57+
        YoSIC0qcnPmEpYuRg0NUIEVidpcOSFhYwEPi/O9fYOXMAuISt57MZwKZKSLQxSgx+04jC4jD
        LLCaCWjbA6iTJjNKNLy4zgzSwiZgKNH1FuQMTg5OAQeJ1o0LmCFGmUl0be1ihLDlJba/ncM8
        gVFoFpJDZiHZOAtJyywkLQsYWVYxiqSWFuem5xYb6RUn5haX5qXrJefnbmIExum2Yz+37GBc
        +eqj3iFGJg7GQ4wSHMxKIrzfpThShHhTEiurUovy44tKc1KLDzGaAkNjIrOUaHI+MFHklcQb
        mhmYGpqYWRqYWpoZK4nzehZ0JAoJpCeWpGanphakFsH0MXFwSjUwbTytXWHewFRX8uXAXNej
        SZpfGUJNv3DqyWZ8eF+wpLxALSZxW471Y5dMtkbHXtbgdTWHZ2uazOzQ/N14PfP7pS/OZXU9
        h0qtXO5YcW78ceNpbFzPxvm7Na5GqRx/78z80N+x85VCbPGhzLBFjcv4lY6nxXk1N+2Zxemx
        ++oTt55net6XJnUcuj77htJemSc31z8TUeiPVyn6mSYwKfjrAckWtVZRyckzNv/p7ojWTzx7
        /OHET1+5/RY6SZ66pO958cGK7N++V7+dPTWpmC0t717xQg0XfeVtTJ5ZF27OlPv0J+ZlxZ/m
        qOueGpaBtkK7Uvp3nexLS2F5xDPd50eFh96tj+IX3nF6RrLJLpypxFKckWioxVxUnAgAOT5Y
        EVwDAAA=
X-CMS-MailID: 20230309101300eucas1p2db2eff24d7b1f4073c8a43f49b086d9d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230308230935eucas1p1e919f4d4b020e3386ce0eac8b4c8d299
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230308230935eucas1p1e919f4d4b020e3386ce0eac8b4c8d299
References: <CGME20230308230935eucas1p1e919f4d4b020e3386ce0eac8b4c8d299@eucas1p1.samsung.com>
        <20230308230931.27261-1-semen.protsenko@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

On 09.03.2023 00:09, Sam Protsenko wrote:
> Power Domains in Exynos850 are not really different from other Exynos
> platforms. Enabling Exynos850 support in the PD driver is really just a
> matter of adding:
>
>      static const struct exynos_pm_domain_config exynos850_cfg = {
>          .local_pwr_cfg = 0x1,
>      };
>
> to the driver. But in the face of recent developments, e.g. this patch:
>
>      arm64: dts: exynos: move MIPI phy to PMU node in Exynos5433
>
> it looked logical to rework the PD driver a bit to support its nesting
> under the PMU node, while adding Exynos850 support to it. Initially I
> only wanted to add syscon regmap support via some dedicated property,
> but pulling PD nodes under the PMU syscon looks like more correct way.

Frankly speaking if you are changing this, you can go even further. 
Simply make PMU node a PM domain provider and specify the power domain 
as a phandle parameter. This is how it should have been done from the 
beginning, but for some unknown reasons wasn't. There is really no need 
to have a separate node for each power domain. This will also move 
implementation details to the PMU / power domain drivers and it will 
make it much easier to extend/modify it in the future. IMHO same applies 
for PHY nodes.


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

