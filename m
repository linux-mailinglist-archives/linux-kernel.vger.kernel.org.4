Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417876D3DC2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 09:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbjDCHE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 03:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbjDCHEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 03:04:34 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17BE6F748
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 00:04:01 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230403070356euoutp015c91c5d06067825bef8774b90e335c73~SWspziNa01706417064euoutp01v
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 07:03:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230403070356euoutp015c91c5d06067825bef8774b90e335c73~SWspziNa01706417064euoutp01v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680505436;
        bh=GqYSXkFFwqBFzhMRUvQBL+nFf4rkIeNW0LsEK9MUwI4=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=AQBNW8VL2TIfqp+8gAkFNmNTF41TI/csM1nVWiocYHZTOiOrkXMXgWHo+lgi427go
         WIxC7UcJl6b7d6UR14Cr21HXNzARzZs1BqYu8BeBQrorTq+Cey1//SX+wM2FkqO97M
         AzWY0wzJ9uwTOWZ7HzfOwXREU8T3+aKiG+JinRPo=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230403070356eucas1p25d23cdfe4080655555d0c77e27aa9fa0~SWspiwfwP2363523635eucas1p2Z;
        Mon,  3 Apr 2023 07:03:56 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 6D.EA.10014.C5A7A246; Mon,  3
        Apr 2023 08:03:56 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230403070355eucas1p1d33a597fcef51a9889611a7c19fa6284~SWspPJmIj2947229472eucas1p1K;
        Mon,  3 Apr 2023 07:03:55 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230403070355eusmtrp1cb77d3daf94d8f2f8e9a12806f23a9a8~SWspOkd_Y0449404494eusmtrp1u;
        Mon,  3 Apr 2023 07:03:55 +0000 (GMT)
X-AuditID: cbfec7f5-ba1ff7000000271e-37-642a7a5cebff
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 30.60.08862.B5A7A246; Mon,  3
        Apr 2023 08:03:55 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230403070355eusmtip2c575d7b70c6251460ee28c1ca4416b1b~SWsorV-zD1953919539eusmtip21;
        Mon,  3 Apr 2023 07:03:55 +0000 (GMT)
Message-ID: <5f324b20-6710-4612-d78a-ea294ad283aa@samsung.com>
Date:   Mon, 3 Apr 2023 09:03:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH] iommu/exynos: Use the devm_clk_get_optional() helper
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <99c0d5ce643737ee0952df41fd60433a0bbeb447.1679834256.git.christophe.jaillet@wanadoo.fr>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEKsWRmVeSWpSXmKPExsWy7djPc7oxVVopBl3fuS0ezNvGZrH14FxW
        i19fLCw6Z29gt9h6S9pi7+ut7BabHl9jtbi8aw6bxYzz+5gsDn54wmrRcsfUgdvjycF5TB5r
        5q1h9Ni0qpPN4861PWwem5fUe7zYPJPRo2/LKkaPz5vkPD7fXc8awBnFZZOSmpNZllqkb5fA
        lbF30yGWgrMCFRseTGFsYDzB28XIySEhYCLx8ttu1i5GLg4hgRWMEk+n7meBcL4wSsy6MJcd
        pEpI4DOjxPbPeTAdzV3tUB3LGSWWPloA1fGRUeLi2jPMIFW8AnYSJ37MZQGxWQRUJJqXLYOK
        C0qcnPkELC4qkCKx++RTsA3CAp4SbxfvYgWxmQXEJW49mc8EMlRE4C+jxLoL69ggEksZJR5s
        jgCx2QQMJbredoHFOYEG3W87wAxRIy+x/e0cZpBmCYF+TomHDRcZuxg5gBwXiYunhCFeEJZ4
        dXwLO4QtI3F6cg8LRH07o8SC3/eZIJwJjBINz28xQlRZS9w594sNZBCzgKbE+l36EGFHiR+/
        VzFDzOeTuPFWEOIGPolJ26ZDhXklOtqEIKrVJGYdXwe39uCFS8wTGJVmIQXLLCTvz0LyzSyE
        vQsYWVYxiqeWFuempxYb56WW6xUn5haX5qXrJefnbmIEJrPT/45/3cG44tVHvUOMTByMhxgl
        OJiVRHjtNTRThHhTEiurUovy44tKc1KLDzFKc7AoifNq255MFhJITyxJzU5NLUgtgskycXBK
        NTBN/xAQzH/cqfNfqgVXgcoazS8RHw5c/6C5+f0/J273oGDmczYPnaxbxIQnddhdmmB5s+rJ
        gmeW787p7tdc5DNvdv1v219Bi091vLvylUP5XtrDXal2q3X21FYwiK29dydI68KSf1zqH7g+
        7vvH4t1qwPRX/+1MYaNDJx9Grv7xU8LPeHKzqOQ/JsGKzd+6wjMTag34c/g3RzDrXFuqFf2t
        PqJacdqrsgCJ8pV7PrZK9nNOec3cqHl3xuSl2Zcdt07JC222zwuf2WGxIP2ivJ/03WlnS5Ky
        Xl/k1255KPFumanyU21fw885kdUKua+fHznBlHf94sQJhyLTPNe67Ctaw9e6dLlLQZKy8CGf
        tkNKLMUZiYZazEXFiQBp3dPL1QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGIsWRmVeSWpSXmKPExsVy+t/xe7rRVVopBlc3mVg8mLeNzWLrwbms
        Fr++WFh0zt7AbrH1lrTF3tdb2S02Pb7GanF51xw2ixnn9zFZHPzwhNWi5Y6pA7fHk4PzmDzW
        zFvD6LFpVSebx51re9g8Ni+p93ixeSajR9+WVYwenzfJeXy+u541gDNKz6Yov7QkVSEjv7jE
        Vina0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL2PvpkMsBWcFKjY8mMLYwHiC
        t4uRk0NCwESiuaudtYuRi0NIYCmjRNfxycwQCRmJk9MaWCFsYYk/17rYIIreM0osfbWXDSTB
        K2AnceLHXBYQm0VARaJ52TJmiLigxMmZT8DiogIpErsmLGUCsYUFPCXeLt4FNpRZQFzi1pP5
        TCBDRQT+M0rsXHWaESIBdMblX/EQ27YzSjz//RtsEpuAoUTX2y6wzZxAU++3HWCGaDCT6Nra
        BdUsL7H97RzmCYxCs5AcMgvJwllIWmYhaVnAyLKKUSS1tDg3PbfYUK84Mbe4NC9dLzk/dxMj
        MIK3Hfu5eQfjvFcf9Q4xMnEwHmKU4GBWEuG119BMEeJNSaysSi3Kjy8qzUktPsRoCgyNicxS
        osn5wBSSVxJvaGZgamhiZmlgamlmrCTO61nQkSgkkJ5YkpqdmlqQWgTTx8TBKdXApM8t41Kv
        z3jTff/2k5Yauxab5vTXVCd1GOysf19ToPhf6vIfleIUt01vE6Ky6w9k67z3T1+efXARo97c
        wJZdizdkbXr2fePW1u2/L3tIpsUYHffV6NP8Pf2pW3jDtOPcR+8dM1qqM8do08mWB7nL+Op2
        XPiunp9y0rFJSEv948Q8u9ebVVql54t+Oz2FN8Qljv/m2pl2ywSmTwrbqTFX7VXEx80eTPty
        NTZdXL/3wqTN1fcjVOwXpD2UvpFkM31t8sMVrPcNbjy5PLWGy2TjYTnuDSXMLiui9py4prBS
        Yzaj1N3W2Zvvxks6PC5OO6axy8AxKuNhww9F9TvCvz7ENAp9eF66fKFSMH+Dzud/k5RYijMS
        DbWYi4oTAWLaIqRpAwAA
X-CMS-MailID: 20230403070355eucas1p1d33a597fcef51a9889611a7c19fa6284
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230326123802eucas1p2f9e22c91fe4134d086d9dfe1d6bfd029
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230326123802eucas1p2f9e22c91fe4134d086d9dfe1d6bfd029
References: <CGME20230326123802eucas1p2f9e22c91fe4134d086d9dfe1d6bfd029@eucas1p2.samsung.com>
        <99c0d5ce643737ee0952df41fd60433a0bbeb447.1679834256.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-7.6 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.03.2023 14:37, Christophe JAILLET wrote:
> Use devm_clk_get_optional() instead of hand writing it.
> This saves some loC and improves the semantic.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>   drivers/iommu/exynos-iommu.c | 24 ++++++++----------------
>   1 file changed, 8 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index 483aaaeb6dae..867f409e0325 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -747,22 +747,16 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
>   		return ret;
>   	}
>   
> -	data->clk = devm_clk_get(dev, "sysmmu");
> -	if (PTR_ERR(data->clk) == -ENOENT)
> -		data->clk = NULL;
> -	else if (IS_ERR(data->clk))
> +	data->clk = devm_clk_get_optional(dev, "sysmmu");
> +	if (IS_ERR(data->clk))
>   		return PTR_ERR(data->clk);
>   
> -	data->aclk = devm_clk_get(dev, "aclk");
> -	if (PTR_ERR(data->aclk) == -ENOENT)
> -		data->aclk = NULL;
> -	else if (IS_ERR(data->aclk))
> +	data->aclk = devm_clk_get_optional(dev, "aclk");
> +	if (IS_ERR(data->aclk))
>   		return PTR_ERR(data->aclk);
>   
> -	data->pclk = devm_clk_get(dev, "pclk");
> -	if (PTR_ERR(data->pclk) == -ENOENT)
> -		data->pclk = NULL;
> -	else if (IS_ERR(data->pclk))
> +	data->pclk = devm_clk_get_optional(dev, "pclk");
> +	if (IS_ERR(data->pclk))
>   		return PTR_ERR(data->pclk);
>   
>   	if (!data->clk && (!data->aclk || !data->pclk)) {
> @@ -770,10 +764,8 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
>   		return -ENOSYS;
>   	}
>   
> -	data->clk_master = devm_clk_get(dev, "master");
> -	if (PTR_ERR(data->clk_master) == -ENOENT)
> -		data->clk_master = NULL;
> -	else if (IS_ERR(data->clk_master))
> +	data->clk_master = devm_clk_get_optional(dev, "master");
> +	if (IS_ERR(data->clk_master))
>   		return PTR_ERR(data->clk_master);
>   
>   	data->sysmmu = dev;

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

