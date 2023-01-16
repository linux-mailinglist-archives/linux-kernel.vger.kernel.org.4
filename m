Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82A466C830
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 17:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbjAPQgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 11:36:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbjAPQgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 11:36:22 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6296A31E39
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 08:25:04 -0800 (PST)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230116162459euoutp02dbbe1a445a4c8578a3db02957aec1140~61riVw1T71108011080euoutp02C
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 16:24:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230116162459euoutp02dbbe1a445a4c8578a3db02957aec1140~61riVw1T71108011080euoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1673886299;
        bh=rIeNW4HYLmJYLi39+ryxT727xkchYje+Z8ssq4AC+3Y=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=toaGEGvpCZmvgJH7VKzEy0YxwYLXDA1FnWt4g89kK0arSk9ht6EPEZWKe+wRMt+v1
         ZuDTjgF77dYuK+ghz9AT0n1KsLyVzK7C1rztQ7Krqx/sYCBxi8ijpJDUUZmOKrOmVD
         gw0Z0eztC8Ap2tbDf7VF8RsLArUhIhBEXlKoa35E=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230116162459eucas1p1de38d093e8dc85e48f795fb75742de3b~61rh4Vie51596915969eucas1p1P;
        Mon, 16 Jan 2023 16:24:59 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id A6.38.61936.B5A75C36; Mon, 16
        Jan 2023 16:24:59 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230116162458eucas1p2cd56987b67ace5aaead81665a3377fa1~61rhThD183050730507eucas1p2E;
        Mon, 16 Jan 2023 16:24:58 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230116162458eusmtrp1b9344dbfae703eb2e7f69933c7ad5552~61rhRIpIE2350823508eusmtrp1T;
        Mon, 16 Jan 2023 16:24:58 +0000 (GMT)
X-AuditID: cbfec7f4-a2dff7000002f1f0-74-63c57a5b9804
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id C1.B1.23420.A5A75C36; Mon, 16
        Jan 2023 16:24:58 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230116162457eusmtip19f8a293be5ebd606327ef17fd220b136~61rgBuxd71495514955eusmtip1D;
        Mon, 16 Jan 2023 16:24:57 +0000 (GMT)
Message-ID: <b756e833-71c5-e43a-b222-ab9bdcc4f494@samsung.com>
Date:   Mon, 16 Jan 2023 17:24:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v5 0/5] iommu: Retire detach_dev callback
Content-Language: en-US
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Rob Clark <robdclark@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20230110025408.667767-1-baolu.lu@linux.intel.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02ScUxbVRTGve+9vr7WFR8F5ToUYxUTMXSiklzd3NRo9hCdLjFuOg3ryrPF
        0bK0gI4YrYgbqzq6ocJaYAWEzlJZobRIR+Ook4pkgMOga9kY0DkowcHEDCijUt6m/HNzzne+
        3z3n3FwKF7eR66kcdT6rUctyJaSQcHUv9KXuKvpJ/mikdh3qGw8TyFW6CUU83QA5jjhJ1Guo
        w1BkbIqHFucQ0jUN8NBvy50AHTLZ+ahh2slHnqmVY9BdteIdMvNRccnjyF5vwlHFjAmgK7Xz
        OOqaCfLQkXkzQEuBCIYW3DUE6i4rJtGCtx9DJcPpaOSog0CWS27+M4lMsKsGYz49d4NkbDU2
        wNjHmnhMh/ECn3GcSGHqOycxptV6iGSGhzpJpmP0ScZQdxowNT3bmQnHMcDUN3aQTEnPDwTz
        xSd/ka/GvSnclM3m5hSymg2bdwuV/ou1/H066fsBw1meDpgleiCgIP0EbLxkIvVASInpEwAW
        V1gBl8wB2GW18bjkbwCbR6+Rt5BQ9QE+V7AA6OofuOmaBfD0uGHFRVEiejPs/Tg+ChB0MrS7
        m1ZhER0Le44FiajlTjobti4VRuU4+mno6Tm8asHpBOgPHseiV8bTLRhstDetJjgd4ME2a4iI
        ukg6Deqn9auEgN4Cf/lykeDo+2D7dBUeBSDtEULP1egO0bGfh77vvgJcHAdDvjY+F98De8s/
        JzjgIIDm8AjGJQYAdVf8N4mNcLhvcXU1nH4YnnRv4ORnobduDERlSMfAP6ZjuSFi4FFXBc7J
        Ilh6QMy5H4JGX/N/bbsGzuEGIDGueRfjmgcwrlnH+H9fMyCsIIEt0KoUrPYxNfueVCtTaQvU
        Cqk8T9UKVj5277Jv7ntgCc1KvQCjgBdACpfEi7a5f5SLRdmy/UWsJi9LU5DLar0gkSIkCaJK
        53G5mFbI8tm9LLuP1dyqYpRgvQ5r0etGJ1iQEbpjSKF8Knfevff19v7R268ujeixxetQPel4
        qeytR66pPpJsdJ5ftqT40177NtaVnvRu5oQor4JMI6/f+85YLKwvTTrpqNoveHH2tqxIZsNd
        6wbdM4EzFns5KHrZbk5MyQn4NAUuXjoKB/XfJG6ZUkwL9mQvtusbqKXdPVlYwB/+Wc9m5JQ3
        3vBk/H5BJhEURna23r2cZD1VKR7MjEuV27bn5NssLTt2hcJvSC8/YOsm749Pl+xRasYrU5Pf
        7jTVfR1WjmAPnidc0q2ntj23Q3VWnOyaq29+wa2NKfv18pmd1dUXD/o/cH7I/mn6DE9QTWYc
        nvL+M/+KhNAqZWkpuEYr+xfTiSWyRwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKKsWRmVeSWpSXmKPExsVy+t/xu7pRVUeTDd4cV7Q49/g3i8W2DhuL
        /3uPMVpsnriVzeL0hEVMFv8fvWa1+PXFwqJh9QVWiyv/9jBadM7ewG6x9O1Wdou9r4HE5V1z
        gGqvLWC3aGoxttiweDazxfQPsxktni/8wWxx8MMTVouJPxYwWvy5/Z/J4ueueSwWx/qb2Cx+
        HjrPZNFyx9Ti/qTNLBbLH+xid5D2eHJwHpNH66W/bB5r5q1h9NjwaDWrx85Zd9k9Nq/Q8li8
        5yWTx6ZVnWwed67tYfPY+dDSY8KiA4we804GerzYPJPRY/GynWweLSf3s3j0Nr9jCxCO0rMp
        yi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0Mu4dW8he0GD
        XsXtCWdZGxgXKHUxcnJICJhIvJrbxt7FyMUhJLCUUeL6n+3sEAkZiZPTGlghbGGJP9e62CCK
        3jNKnOq/wNjFyMHBK2AncbpRBKSGRUBVYsOu1WwgNq+AoMTJmU9YQGxRgRSJ5ucnweYIC9hK
        7D3ZB1bDLCAucevJfCYQW0RgI5NE37oUkPnMAndZJQ7+OwdWJCQwiVFix9cqEJtNwFCi620X
        WJxTwF7i1JRfLBCDzCS6tnYxQtjyEtvfzmGewCg0C8kds5Dsm4WkZRaSlgWMLKsYRVJLi3PT
        c4sN9YoTc4tL89L1kvNzNzEC09O2Yz8372Cc9+qj3iFGJg7GQ4wSHMxKIrx+uw4nC/GmJFZW
        pRblxxeV5qQWH2I0BQbGRGYp0eR8YILMK4k3NDMwNTQxszQwtTQzVhLn9SzoSBQSSE8sSc1O
        TS1ILYLpY+LglGpgslST9WLW2ss25eAxhvyN9hHfGgQL3jSJXtP93Dtl/9airVVhJwJ7Nn/Q
        nhGhmt63U0pA8AE3h5Hr+YzbboFudxUt9tnY+WptVtlU4eX4cYnRxT0H6+ZU+f5jjNyp88HA
        t7ln0/bdDxXYko9n9nFeV/BfyH1vQkdMYd6zp9pb3kfc+pLR+cpt0gwJzYcJgdXXFiq/Nf+Z
        F6DXvu2KknjklZUmDPyn3eec4Kp81sFV9E5P93nIE2e1/u36jdpf9mq6e9ycKXXPU+fza/M6
        +TnX5xt1z5LfxCeu8tlORd/irI7f8Y3Ms9WnlgiteLj33KXqp7ZScX4Pr3TcWvzX4+Z3oxlz
        xJ7lX772nT1JU9dFiaU4I9FQi7moOBEAPfWcKtgDAAA=
X-CMS-MailID: 20230116162458eucas1p2cd56987b67ace5aaead81665a3377fa1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230110030211eucas1p10834ec4cc8c227e2cd7051dc85026dbb
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230110030211eucas1p10834ec4cc8c227e2cd7051dc85026dbb
References: <CGME20230110030211eucas1p10834ec4cc8c227e2cd7051dc85026dbb@eucas1p1.samsung.com>
        <20230110025408.667767-1-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,


On 10.01.2023 03:54, Lu Baolu wrote:
> Hi folks,
>
> The iommu core calls the driver's detach_dev domain op callback only when
> a device is finished assigning to user space and
> iommu_group_release_dma_owner() is called to return the device to the
> kernel, where iommu core wants to set the default domain to the device but
> the driver didn't provide one. The code looks like:
>
>          /*
>           * New drivers should support default domains and so the detach_dev() op
>           * will never be called. Otherwise the NULL domain represents some
>           * platform specific behavior.
>           */
>          if (!new_domain) {
>                  if (WARN_ON(!group->domain->ops->detach_dev))
>                          return -EINVAL;
>                  __iommu_group_for_each_dev(group, group->domain,
>                                             iommu_group_do_detach_device);
>                  group->domain = NULL;
>                  return 0;
>          }
>
> In other words, if the iommu driver provides default domains, the
> .detach_dev callback will never be called; Otherwise, the .detach_dev
> callback is actually called to return control back to the platform DMA
> ops, other than detaching the domain from device.
>
> This series cleanups this by:
>
> - If the IOMMU driver provides default domains, remove .detach_dev
>    callback.
> - Adds a new set_platform_dma iommu op. Any IOMMU driver that doesn't
>    provide default domain should implement set_platform_dma callback
>    instead.
> - Retire .detach_dev callback.
>
> This series originates from various discussion in the community. Thanks
> to Jason, Robin and all others for their ideas.

I wonder how to handle the ARM 32bit case, which doesn't use the default 
domain solution. Today, once this patchset has been merged to 
linux-next, I've noticed that it broke booting of ARM 32bit Exynos based 
boards.

The final solution would be to switch ARM 32bit to generic DMA-IOMMU 
glue, but I'm not sure it this will happen soon. I will try to check if 
any kind of quick workaround can be applied to get it working again.


> The whole series is available on github:
> https://protect2.fireeye.com/v1/url?k=ef2183b6-b0bababa-ef2008f9-000babff3563-336828b3433153d2&q=1&e=4ae5dae4-383f-4a82-9449-3f08f0422cb1&u=https%3A%2F%2Fgithub.com%2FLuBaolu%2Fintel-iommu%2Fcommits%2Fiommu-retire-detach_dev-v5
>
> Change log:
> v5:
>   - Merge some patches to make the series cute. No functionality changes.
>   - Check the op directly and WARN_ON the lack of any necessary
>     callbacks. Get rid of the ret and EINVAL.
>
> v4:
>   - https://lore.kernel.org/linux-iommu/20230104125725.271850-1-baolu.lu@linux.intel.com/
>   - Drop the patch which renamed .attach_dev to .set_dev. As Robin said,
>     "... I also wouldn't say that "attach" loses its meaning in a context
>     where an equivalent "detach" operation is only ever implicit in
>     reattaching to something else...". If we have a better name in the
>     future, we can do it in other series.
>   - Adjust the patch of "iommu: Add set_platform_dma_ops iommu ops"
>     according to Jason's following suggestion " ... This is a bit ugly,
>     it would be better to make the previous patch call set_platform_dma
>     if it is set instead of detach_dev and then these patches should just
>     rename the driver's fsl_pamu_detach_device to
>     fsl_pamu_set_platform_dma ..."
>   - Add a new patch to remove deferred attach check from
>     __iommu_detach_domain() path. Make it a separate patch as the
>     prerequisite to remove __iommu_detach_device() helper.
>   - Rename set_platform_dma to set_platform_dma_ops to make it more
>     meaningful.
>
> v3:
>   - https://lore.kernel.org/linux-iommu/20221128064648.1934720-1-baolu.lu@linux.intel.com/
>   - Setting blocking domain is not conceptually equal to detach_dev.
>     Dropped all blocking domain related staffs in the previous version.
>
> v2:
>   - https://lore.kernel.org/linux-iommu/20220826123014.52709-1-baolu.lu@linux.intel.com/
>   - Replace .detach_dev callback with static block domain ops;
>   - Rename .attach_dev to .set_dev.
>
> v1:
>   - https://lore.kernel.org/linux-iommu/20220516015759.2952771-1-baolu.lu@linux.intel.com/
>
> Jason Gunthorpe (1):
>    iommu: Remove deferred attach check from __iommu_detach_device()
>
> Lu Baolu (4):
>    iommu: Remove detach_dev callbacks
>    iommu: Add set_platform_dma_ops iommu ops
>    iommu: Add set_platform_dma_ops callbacks
>    iommu: Remove detach_dev callback
>
>   include/linux/iommu.h                   |  8 ++-
>   include/trace/events/iommu.h            |  7 --
>   drivers/iommu/amd/iommu.c               | 26 -------
>   drivers/iommu/apple-dart.c              | 24 -------
>   drivers/iommu/arm/arm-smmu/qcom_iommu.c | 23 ------
>   drivers/iommu/exynos-iommu.c            |  1 -
>   drivers/iommu/fsl_pamu_domain.c         |  6 +-
>   drivers/iommu/iommu-traces.c            |  1 -
>   drivers/iommu/iommu.c                   | 94 ++++++++++++-------------
>   drivers/iommu/ipmmu-vmsa.c              | 16 -----
>   drivers/iommu/msm_iommu.c               |  6 +-
>   drivers/iommu/mtk_iommu.c               |  9 ---
>   drivers/iommu/mtk_iommu_v1.c            |  4 +-
>   drivers/iommu/omap-iommu.c              |  6 +-
>   drivers/iommu/rockchip-iommu.c          |  1 -
>   drivers/iommu/s390-iommu.c              |  7 +-
>   drivers/iommu/sprd-iommu.c              | 16 -----
>   drivers/iommu/sun50i-iommu.c            |  1 -
>   drivers/iommu/tegra-gart.c              |  6 +-
>   drivers/iommu/tegra-smmu.c              |  5 +-
>   20 files changed, 69 insertions(+), 198 deletions(-)
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

