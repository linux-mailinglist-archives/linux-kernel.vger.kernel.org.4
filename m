Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDF961704F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 23:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbiKBWHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 18:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbiKBWHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 18:07:24 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3A6DFED
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 15:07:19 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20221102220716euoutp01d06d071515b1a7bc34b462da9e725b52~j49_e3OuT0085300853euoutp01Q
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 22:07:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20221102220716euoutp01d06d071515b1a7bc34b462da9e725b52~j49_e3OuT0085300853euoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1667426836;
        bh=MvIcE5aybyqzRDniRRwm7mnKOS8q8sys3BpNeOUXi5c=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=HeaJhcbRChb1EACfgOLw3tfCoUKJYv6EfeKgm9c0a+w+UtrHmuyYANpExaJykzRgj
         E5x5Vo5/gCbvxAo5dm9ofNo/w6Hwze/zUoSmjKpMiCHlRrIQZ7+2UPs2/NpNRriphN
         ktEZ+mpQOzaqNzIdH3y7qivbSwuFX8PR1d3GNSUc=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20221102220715eucas1p1a665278d4147fc3bbd951e58783a4589~j499y8iEq0205302053eucas1p1x;
        Wed,  2 Nov 2022 22:07:15 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id F6.55.29727.31AE2636; Wed,  2
        Nov 2022 22:07:15 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20221102220715eucas1p287aa4a65c499b9a54351fc5fa6fd961c~j499X1s1N2723527235eucas1p2O;
        Wed,  2 Nov 2022 22:07:15 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221102220715eusmtrp2f49f58fcdb004c1871b7608a35f19d8b~j499XBPTb0674406744eusmtrp2J;
        Wed,  2 Nov 2022 22:07:15 +0000 (GMT)
X-AuditID: cbfec7f2-21dff7000001741f-7f-6362ea1314e1
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id A3.54.07473.31AE2636; Wed,  2
        Nov 2022 22:07:15 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221102220714eusmtip1e75f1ff28c61d5e97e7b6362cc298455~j498msBaE0597605976eusmtip1B;
        Wed,  2 Nov 2022 22:07:14 +0000 (GMT)
Message-ID: <7ed8c884-cee1-7cb0-f2ce-f7ec156cd841@samsung.com>
Date:   Wed, 2 Nov 2022 23:07:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH 3/4] iommu/exynos: Modularize the driver
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
In-Reply-To: <20221028191243.31721-4-semen.protsenko@linaro.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNKsWRmVeSWpSXmKPExsWy7djP87rCr5KSDRrn6Vs8mLeNzWJCRyuT
        xa8vFhab5xRbdM7ewG6x9/VWdotNj6+xWlzeNYfNYsb5fUwW/3oPMloc/PCE1eJ5H5B76u5n
        dovj7x8zWrTcMXXg93hycB6Tx5p5axg9ds66y+6xYFOpx6ZVnWwed67tYfPYvKTe48XmmYwe
        fVtWMXp83iQXwBXFZZOSmpNZllqkb5fAlfGwZTFzwUzFipWt55kaGF9KdTFyckgImEhMXXGC
        vYuRi0NIYAWjxP6LW1ghnC+MEi+/fWCBcD4zShy+uIypi5EDrGXhHUGI+HJGiX0Te9kgnI+M
        Evc332ADmcsrYCdxZMsLMJtFQEWi5elPRoi4oMTJmU9YQGxRgRSJ3d3bwGxhARuJ01t6WEFs
        ZgFxiVtP5jOB2CICaRJX/90HO4lZ4D6zxPqnk9hBEmwChhJdb7vAFnAKOEgcm3ITqlleYvvb
        OcwgDRIC6zklzh84xwTxqYvE/wXdrBC2sMSr41vYIWwZif87QbaBNLQzSiz4fR/KmcAo0fD8
        FiNElbXEnXO/2EABwCygKbF+lz5E2FFiV3cjKyRc+CRuvBWEOIJPYtK26cwQYV6JjjYhiGo1
        iVnH18GtPXjhEvMERqVZSOEyC8n/s5C8Mwth7wJGllWM4qmlxbnpqcWGeanlesWJucWleel6
        yfm5mxiB6e/0v+OfdjDOffVR7xAjEwfjIUYJDmYlEd76s9HJQrwpiZVVqUX58UWlOanFhxil
        OViUxHnZZmglCwmkJ5akZqemFqQWwWSZODilGpjkjxe2sD7WFWnTKyx9sqX8a8H+fr/8jZxP
        OVgYu+KfqqR9vrvPc8pS49WiRy5JmH3KnrOvpHrW3sbJm21k1mtuK1i35oL6973M79OncZw3
        ir/z46hhtHacX9ajuybC5oxzW4oU4oyY1i11Ona9RK/oksqHq9VWX78zXv9c4PuzZ9kZfZu/
        F4p9+eUvvw/5ZPXpQoFD3oHXiosZKopnM71XPqwVz+sZWHVhk4vAbfMPV3kOGf56HzyPdbno
        lBCHVZ8+rnOaGh//Wdn7R3x3bo7VtbKtNty10y9v1WcRCtm7V5LJfpXGm+4c82k7f91/PNNd
        9/HPv2wBMqd4GtwYfuwN+fFg7pta5/wDi/9tPX9YiaU4I9FQi7moOBEA3PoNJe4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNIsWRmVeSWpSXmKPExsVy+t/xu7rCr5KSDe4cErZ4MG8bm8WEjlYm
        i19fLCw2zym26Jy9gd1i7+ut7BabHl9jtbi8aw6bxYzz+5gs/vUeZLQ4+OEJq8XzPiD31N3P
        7BbH3z9mtGi5Y+rA7/Hk4DwmjzXz1jB67Jx1l91jwaZSj02rOtk87lzbw+axeUm9x4vNMxk9
        +rasYvT4vEkugCtKz6Yov7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSez
        LLVI3y5BL+Nhy2LmgpmKFStbzzM1ML6U6mLk4JAQMJFYeEewi5GLQ0hgKaPErI4pzF2MnEBx
        GYmT0xpYIWxhiT/Xutggit4zSmw+uBqsiFfATuLIlhdsIDaLgIpEy9OfjBBxQYmTM5+wgCwQ
        FUiR+HauDiQsLGAjcXpLD9hMZgFxiVtP5jOB2CICaRL7Jr1mhIg/ZJaYsVYBYtdJRolHU6+C
        7WITMJToetsFtotTwEHi2JSbUIPMJLq2dkE1y0tsfzuHeQKj0CwkZ8xCsm8WkpZZSFoWMLKs
        YhRJLS3OTc8tNtQrTswtLs1L10vOz93ECIz1bcd+bt7BOO/VR71DjEwcjIcYJTiYlUR4689G
        JwvxpiRWVqUW5ccXleakFh9iNAWGxURmKdHkfGCyySuJNzQzMDU0MbM0MLU0M1YS5/Us6EgU
        EkhPLEnNTk0tSC2C6WPi4JRqYLIwlOiNX3QrKnd2tN/n7z1dmYUJ77dNfGpkUreCtWvP4qMu
        Fqv8pI5bnp33Sarn+ZGmpHnT82Z8NPvZc2TyQi0TOYW7Gt7Kipfvex6t23YkdE+9WGT01PYp
        P5MOzipxXclz9MpeE9dXSpzrrCe9MzkZanrj+p5+nfqPaYdlN/64pe7Wu3jTQe+FRUdNz2qX
        BJfvLFeRdUxfEHTBotj55iO7Rn7GB88WfVRbfO3Dk5fhrClOrf0d2x9NMi5TtWCeHGlzI3hD
        pbXx8oXPvmtejNI7/1hzuX3oBQGDhZN+pwtHOiedAwa2a6rnuQnOi4RP6so5/Z+i41Y3O3fu
        G7mOCG3xdr8Uj++zdWfFPOvarcRSnJFoqMVcVJwIABVyN45+AwAA
X-CMS-MailID: 20221102220715eucas1p287aa4a65c499b9a54351fc5fa6fd961c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20221028191256eucas1p1a4fd95cbcc44959fa968956a92738f03
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221028191256eucas1p1a4fd95cbcc44959fa968956a92738f03
References: <20221028191243.31721-1-semen.protsenko@linaro.org>
        <CGME20221028191256eucas1p1a4fd95cbcc44959fa968956a92738f03@eucas1p1.samsung.com>
        <20221028191243.31721-4-semen.protsenko@linaro.org>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

On 28.10.2022 21:12, Sam Protsenko wrote:
> Rework the driver so it can be built as a loadable module. That can be
> useful as not all ARM64 platforms need it. And that's ok for it to be a
> module because it's not a critical driver (platform can work when it's
> disabled).
>
> Also add the shutdown driver method, while at it. That was inspired by
> other IOMMU drivers, and can be useful e.g. for performing a kexec. See
> commit 1a4e90f25b2c ("iommu/rockchip: Perform a reset on shutdown") for
> example.
>
> Remove method and module exit function are not implemented, as the
> removal of IOMMUs cannot be done reliably. As Robin Murphy mentioned in
> [1]:
>
>      ...it's better not to even pretend that removing an IOMMU's driver
>      while other drivers are using it (usually via DMA ops without even
>      realising) is going to have anything other than catastrophic
>      results.
>
> [1] https://lore.kernel.org/lkml/20220702213724.3949-2-semen.protsenko@linaro.org/T/#md7e1e3f5b2c9e7fa5bc28fe33e818b6aa4a7237c
>
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>

MODULE_DEVICE_TABLE(of, sysmmu_of_match); is missing, so the driver 
won't be automatically loaded, what breaks its operation if compiled as 
module.

Also Exynos DRM and S5P-MFC drivers rely on the Exynos IOMMU being 
built-in, so they need to be adjusted for modularized builds too imho, 
at least in the Kconfig dependency.

> ---
>   drivers/iommu/Kconfig        |  2 +-
>   drivers/iommu/exynos-iommu.c | 18 +++++++++++++++++-
>   2 files changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index dc5f7a156ff5..6f7055606679 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -259,7 +259,7 @@ config TEGRA_IOMMU_SMMU
>   	  SoCs (Tegra30 up to Tegra210).
>   
>   config EXYNOS_IOMMU
> -	bool "Exynos IOMMU Support"
> +	tristate "Exynos IOMMU Support"
>   	depends on ARCH_EXYNOS || COMPILE_TEST
>   	depends on !CPU_BIG_ENDIAN # revisit driver if we can enable big-endian ptes
>   	select IOMMU_API
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index 0d150b383d04..57492db877e2 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -16,6 +16,7 @@
>   #include <linux/interrupt.h>
>   #include <linux/kmemleak.h>
>   #include <linux/list.h>
> +#include <linux/module.h>
>   #include <linux/of.h>
>   #include <linux/of_platform.h>
>   #include <linux/platform_device.h>
> @@ -752,6 +753,16 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
>   	return ret;
>   }
>   
> +static void exynos_sysmmu_shutdown(struct platform_device *pdev)
> +{
> +	struct sysmmu_drvdata *data = platform_get_drvdata(pdev);
> +	struct device *dev = &pdev->dev;
> +	int irq = platform_get_irq(pdev, 0);
> +
> +	devm_free_irq(dev, irq, data);
> +	pm_runtime_force_suspend(dev);
> +}
> +
>   static int __maybe_unused exynos_sysmmu_suspend(struct device *dev)
>   {
>   	struct sysmmu_drvdata *data = dev_get_drvdata(dev);
> @@ -799,8 +810,9 @@ static const struct of_device_id sysmmu_of_match[] = {
>   	{ },
>   };
>   
> -static struct platform_driver exynos_sysmmu_driver __refdata = {
> +static struct platform_driver exynos_sysmmu_driver = {
>   	.probe	= exynos_sysmmu_probe,
> +	.shutdown = exynos_sysmmu_shutdown,
>   	.driver	= {
>   		.name		= "exynos-sysmmu",
>   		.of_match_table	= sysmmu_of_match,
> @@ -1404,6 +1416,7 @@ static const struct iommu_ops exynos_iommu_ops = {
>   	.release_device = exynos_iommu_release_device,
>   	.pgsize_bitmap = SECT_SIZE | LPAGE_SIZE | SPAGE_SIZE,
>   	.of_xlate = exynos_iommu_of_xlate,
> +	.owner = THIS_MODULE,
>   	.default_domain_ops = &(const struct iommu_domain_ops) {
>   		.attach_dev	= exynos_iommu_attach_device,
>   		.detach_dev	= exynos_iommu_detach_device,
> @@ -1454,3 +1467,6 @@ static int __init exynos_iommu_init(void)
>   	return ret;
>   }
>   core_initcall(exynos_iommu_init);
> +
> +MODULE_DESCRIPTION("IOMMU driver for Exynos SoCs");
> +MODULE_LICENSE("GPL");

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

