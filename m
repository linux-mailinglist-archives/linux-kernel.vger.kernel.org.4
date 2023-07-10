Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4262B74D92B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 16:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjGJOlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 10:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjGJOlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 10:41:18 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45145100
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 07:41:17 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230710144113euoutp018b419be1e03f3f74b795a0ed0c959159~wiJ5Tk9lk1329513295euoutp01b
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 14:41:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230710144113euoutp018b419be1e03f3f74b795a0ed0c959159~wiJ5Tk9lk1329513295euoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1689000073;
        bh=MwQOmwymU1eBeIeukQqIHQbMFNBNnL7OZIhhKksmZkw=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=WwD2LmTvxHTryyoGCqnpkraQLhfTjY5KKRQYSPT6eghVVaAiuBaXEWQyjnO5J1+ME
         yPNMSOFzUccm/Hp7YAj1BorD04ztfJrBOewS+W7DF1eKq2IAWQlBDpUbbnaz6mrCY7
         D6C8pbOQHhsCMQdkZAJEsumADbLTsP/YvXenn0cA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230710144113eucas1p1de160100648b36a1d8ef365a0430cd0c~wiJ5EBnFu0505705057eucas1p1Q;
        Mon, 10 Jul 2023 14:41:13 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 14.8B.37758.9881CA46; Mon, 10
        Jul 2023 15:41:13 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230710144113eucas1p1f4063f2e41b1d23a83dc7be40bc0e2ba~wiJ4psC9U0729307293eucas1p18;
        Mon, 10 Jul 2023 14:41:13 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230710144113eusmtrp1b1f06ceea2215d2cea410f25c4e13517~wiJ4pHzW62680526805eusmtrp1v;
        Mon, 10 Jul 2023 14:41:13 +0000 (GMT)
X-AuditID: cbfec7f5-7ffff7000002937e-ad-64ac18897559
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id FB.86.10549.9881CA46; Mon, 10
        Jul 2023 15:41:13 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230710144112eusmtip149150385311f28ed1122bcda27d13b3d~wiJ37eZjX2841128411eusmtip1J;
        Mon, 10 Jul 2023 14:41:12 +0000 (GMT)
Message-ID: <33712296-5887-d810-096b-c95cd718626d@samsung.com>
Date:   Mon, 10 Jul 2023 16:41:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 4/6] iommu/exynos: Convert to
 devm_platform_ioremap_resource()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20230705130416.46710-4-frank.li@vivo.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLKsWRmVeSWpSXmKPExsWy7djP87qdEmtSDL6/lLF4MG8bm8XEIzOY
        LH59sbDonL2B3WLv663sFpseX2O1uLxrDpvFjPP7mCwOfnjCatFyx9SBy+PJwXlMHmvmrWH0
        2LSqk83jzrU9bB6bl9R7vNg8k9Gjb8sqRo/Pm+Q8NnzqYA7gjOKySUnNySxLLdK3S+DKWPmH
        p2AVV8XLZ1fYGhiXcHQxcnJICJhIdPU0MXUxcnEICaxglPj2YhIbhPOFUaL70Vwo5zOjRFfT
        LmaYlvVN99hAbCGB5YwSD05zQNgfGSVu9pt2MXJw8ArYSZxarw4SZhFQlVjzezUTiM0rIChx
        cuYTFhBbVCBVYsftCawgtrBAiMTUzg6wGmYBcYlbT+aDXSQi8BJo5KF+sCOYBZoYJXq/9oMt
        ZhMwlOh62wVmcwqYS2xcepYZolteYvvbOcwgDRICkzklLhy+zwJxtYtEb9MuVghbWOLV8S3s
        ELaMxOnJPSwQDe2MEgt+32eCcCYwSjQ8v8UIUWUtcefcLzaQ35gFNCXW79KHCDtKzPs9lwUk
        LCHAJ3HjrSDEEXwSk7ZNZ4YI80p0tAlBVKtJzDq+Dm7twQuXmCcwKs1CCphZSAEwC8k7sxD2
        LmBkWcUonlpanJueWmycl1quV5yYW1yal66XnJ+7iRGYwk7/O/51B+OKVx/1DjEycTAeYpTg
        YFYS4S04uCpFiDclsbIqtSg/vqg0J7X4EKM0B4uSOK+27clkIYH0xJLU7NTUgtQimCwTB6dU
        A9OKkGffpzRGnH2YUzNBVe1r4TROZsdnzO/2nv6aImr6+Of3/16e6qmVXU+cBJmYGQ3vz/te
        bq49S6/GKsPYukahyPl64GOx7Uv1FDWUVgjwp074Hfb93J3PT0q/qa1Ycep6Lv9DSb9DMfWu
        lrl32+5OChIPnryTNWTbm6MaN6csDtwuEhVQLn/O/MUR62v/GpZqGi1YKMlr+uPIT+1teRtY
        dnaw7iuO+ST5hv3Q7QvbuJI2OX/PvXMq+SqL/OL8utnpiwRvaYSzB7h36i8I+BEZtEB8QvWM
        aX78j/piIqOLjNPWCW+seS+uHVIju2LJtfuM/Yp6fac5Dl57czT27noVOS6x5QemPs0Kc4mO
        +KbEUpyRaKjFXFScCACqNcXS0AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsVy+t/xu7qdEmtSDH7vZLV4MG8bm8XEIzOY
        LH59sbDonL2B3WLv663sFpseX2O1uLxrDpvFjPP7mCwOfnjCatFyx9SBy+PJwXlMHmvmrWH0
        2LSqk83jzrU9bB6bl9R7vNg8k9Gjb8sqRo/Pm+Q8NnzqYA7gjNKzKcovLUlVyMgvLrFVija0
        MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DLWPmHp2AVV8XLZ1fYGhiXcHQxcnJI
        CJhIrG+6x9bFyMUhJLCUUeLZ/R4miISMxMlpDawQtrDEn2tdUEXvGSVmrznB3sXIwcErYCdx
        ar06SA2LgKrEmt+rwXp5BQQlTs58wgJiiwqkSvxq2AU2R1ggRGJqZwdYDbOAuMStJ/OZQGaK
        CLxklLje2wnmMAs0MUp8/rGNFWLbdkaJWce7GEFa2AQMJbregpzBycEpYC6xcelZZohRZhJd
        WyFqmAXkJba/ncM8gVFoFpJLZiHZOAtJyywkLQsYWVYxiqSWFuem5xYb6hUn5haX5qXrJefn
        bmIExu22Yz8372Cc9+qj3iFGJg7GQ4wSHMxKIrwFB1elCPGmJFZWpRblxxeV5qQWH2I0BQbH
        RGYp0eR8YOLIK4k3NDMwNTQxszQwtTQzVhLn9SzoSBQSSE8sSc1OTS1ILYLpY+LglGpgWprn
        cFpnauP5C582uL5t49z/XEvobvobT+XjUv5RP1/f/+axj2nl2ymnHotGrn0cmLVlunbHc9bH
        HLechIXj3hVNklhx1zvZ790pz6kqSudUCmf7Xv+uUHSOaanWtrlVJ43y7x8IffD8eTmD+4Nt
        B2OaV8uJ8WeuKBeOXXvqaKkSS908/tVeqzQ+Fv5yCTrfIrXtaQ6b+HrZI7dZlloKTb28U665
        WWxP2dpJsVwTGd0vyBR8XPr+v42+lfI2sanaR96LNLZkOr1+kNI9scryWbHUv4Cs2s5jdq5C
        +9NEmS3dHgrzeAgHaxx517/ykKmy+BWJ7n1VDzc77n41+xbj+5gj6tMMXQVtK9JNe2XclViK
        MxINtZiLihMBFeEYvmQDAAA=
X-CMS-MailID: 20230710144113eucas1p1f4063f2e41b1d23a83dc7be40bc0e2ba
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230705130438eucas1p231e5c29315bc0c2e15e947079ed4e39a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230705130438eucas1p231e5c29315bc0c2e15e947079ed4e39a
References: <20230705130416.46710-1-frank.li@vivo.com>
        <CGME20230705130438eucas1p231e5c29315bc0c2e15e947079ed4e39a@eucas1p2.samsung.com>
        <20230705130416.46710-4-frank.li@vivo.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.07.2023 15:04, Yangtao Li wrote:
> Use devm_platform_ioremap_resource() to simplify code.
>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>


> ---
>   drivers/iommu/exynos-iommu.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index c275fe71c4db..ab6208015997 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -725,19 +725,17 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
>   	int irq, ret;
>   	struct device *dev = &pdev->dev;
>   	struct sysmmu_drvdata *data;
> -	struct resource *res;
>   
>   	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>   	if (!data)
>   		return -ENOMEM;
>   
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	data->sfrbase = devm_ioremap_resource(dev, res);
> +	data->sfrbase = devm_platform_ioremap_resource(pdev, 0);
>   	if (IS_ERR(data->sfrbase))
>   		return PTR_ERR(data->sfrbase);
>   
>   	irq = platform_get_irq(pdev, 0);
> -	if (irq <= 0)
> +	if (irq < 0)
>   		return irq;
>   
>   	ret = devm_request_irq(dev, irq, exynos_sysmmu_irq, 0,

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

