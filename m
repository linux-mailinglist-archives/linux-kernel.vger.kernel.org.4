Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69026907DD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 12:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjBIL4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 06:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjBILzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 06:55:47 -0500
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2524AD02
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 03:44:55 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230209114451euoutp01f924837d7444d3134db7ca804c65e569~CJVzRZP-p0485404854euoutp01t
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 11:44:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230209114451euoutp01f924837d7444d3134db7ca804c65e569~CJVzRZP-p0485404854euoutp01t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1675943091;
        bh=MaSLN/NNg2/noTq4bWBoUtrpGKTfjbHhpAaxxEMNSfQ=;
        h=Date:Subject:To:From:In-Reply-To:References:From;
        b=RLY/gqnaLAgXnGiVSbQiaFVPa4TpEem6jjBKDcoK74x78PpyMDY2Ce1UT6+duUXCk
         313R+9rTBQBx67ys4wi+vhR3I7Jd/zKoia01pIuvyGniUTD3RphplMdea+mEYuVTiz
         yxgRITorJycZyHYc1PD+Ir6ySGBCPx/036Zv6tfw=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230209114451eucas1p1dba9b4fdff6509e8bcc1d0a2fc6ae2ed~CJVy0RKsm0126101261eucas1p1M;
        Thu,  9 Feb 2023 11:44:51 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 9B.1D.13597.3BCD4E36; Thu,  9
        Feb 2023 11:44:51 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230209114451eucas1p2de6ec04f18cf81fe7722758676ee5fb8~CJVyii11V0449004490eucas1p2Q;
        Thu,  9 Feb 2023 11:44:51 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230209114451eusmtrp1e3e79a4cfa4f3e31ff5a685a00ee92f6~CJVyhxGfv2212322123eusmtrp1B;
        Thu,  9 Feb 2023 11:44:51 +0000 (GMT)
X-AuditID: cbfec7f4-1f1ff7000000351d-7b-63e4dcb37003
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 70.EE.00518.2BCD4E36; Thu,  9
        Feb 2023 11:44:50 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230209114450eusmtip16c66865c658c702409f400bba1d57c0c~CJVyBMipb0705507055eusmtip1U;
        Thu,  9 Feb 2023 11:44:50 +0000 (GMT)
Message-ID: <f5d314df-5e22-0df5-add7-d70c13116198@samsung.com>
Date:   Thu, 9 Feb 2023 12:44:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] ARM: dts: exynos: correct max98090 DAI argument in Snow
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20230208160424.371678-1-krzysztof.kozlowski@linaro.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIKsWRmVeSWpSXmKPExsWy7djPc7qb7zxJNvj6VtTiwbxtbBbzj5xj
        teh78ZDZYu/rrewWmx5fY7W4vGsOm8WM8/uYLFr3HmF34PDYtKqTzePOtT1sHpuX1Hv0bVnF
        6PF5k1wAaxSXTUpqTmZZapG+XQJXxvpdH1kKNnNW7Jw4k7WBcR97FyMnh4SAicTvz9eZuxi5
        OIQEVjBK7H72mhXC+cIocXfXDyYI5zOjxLF3Z1hhWk7+awOzhQSWM0pM+SwOUfSRUeLsxLmM
        IAleATuJf9NPsoDYLAIqEvPmr2GDiAtKnJz5BCjOwSEqkCKx6U8ZSFhYwEdiz9wHYK3MAuIS
        t57MB1ssInCUSWLpjJ9MIAk2AUOJrrddYHM4BVwljp6+zA7RIC+x/e0csB8kBG5wSFxZdIUd
        ZIGEgIvEszUFEEcLS7w6vgXqZxmJ05N7WCDq2xklFvy+zwThTGCUaHh+ixGiylrizrlfbCCD
        mAU0Jdbv0ocIO0q0ta5mhJjPJ3HjrSDEDXwSk7ZNZ4YI80p0tAlBVKtJzDq+Dm7twQuXmCFs
        D4k/rxtYJjAqzkIKlVlI3p+F5LNZCDcsYGRZxSieWlqcm55abJSXWq5XnJhbXJqXrpecn7uJ
        EZiKTv87/mUH4/JXH/UOMTJxMB5ilOBgVhLh/T7xcbIQb0piZVVqUX58UWlOavEhRmkOFiVx
        Xm3bk8lCAumJJanZqakFqUUwWSYOTqkGpqX/OeJTRT99i7lY6p8QeklKV6V6y8qpyzovXxd8
        GPhut8Q27iWZK2e5SXpO5j/JsKOE7+/ymA38N28smPh32p2WVre1YSuKJ/I+DOKSPi39edva
        646KSg12Fz5nNXjteTkzJ25PZ7W9y89TMnXWb0W/3GXtc0u72fR3grwI2x9lppAIne3te+fv
        D+jKjphiEubUUDbt9svVKlWSPKe1xTWb/OdxdKddrfvKPr0lNXD1q2LHQzf/u21tnriRr8wp
        aa6j0gox4YAuvizjRzfnaYXoC1YsbX1T1lb9t/FwXllqTrRbsdzfBrk2k0sfTrfZHE/WiL5c
        OuNDZxVbc9rUyP2n9k/V/+P4m4PxbOcBJZbijERDLeai4kQAneukkbQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsVy+t/xu7qb7jxJNvh11MbiwbxtbBbzj5xj
        teh78ZDZYu/rrewWmx5fY7W4vGsOm8WM8/uYLFr3HmF34PDYtKqTzePOtT1sHpuX1Hv0bVnF
        6PF5k1wAa5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZapG+
        XYJexvpdH1kKNnNW7Jw4k7WBcR97FyMnh4SAicTJf22sXYxcHEICSxklTv4/BJWQkTg5rYEV
        whaW+HOtiw2i6D2jxI5di5lBErwCdhL/pp9kAbFZBFQk5s1fwwYRF5Q4OfMJWFxUIEWi+flJ
        sEHCAj4Se+Y+YASxmQXEJW49mc8EMlRE4DiTxKdJC5ghNsxglLh47QnYBjYBQ4mut11gUzkF
        XCWOnr7MDtFtJtG1tQtqkrzE9rdzmCcwCs5CsnwWkiWzkLTMQtKygJFlFaNIamlxbnpusZFe
        cWJucWleul5yfu4mRmCkbTv2c8sOxpWvPuodYmTiYDzEKMHBrCTC+33i42Qh3pTEyqrUovz4
        otKc1OJDjKbAEJjILCWanA+M9bySeEMzA1NDEzNLA1NLM2MlcV7Pgo5EIYH0xJLU7NTUgtQi
        mD4mDk6pBqbyHaqvE8vXT/564WnNY+eNfRdDjjgHil2+feBeoPPyuIT/QW56ly947m/c+Fj1
        dN6MhJTjjxY6Ox+fHKZ37Ofa1TKOSjX/27IkQ+QDF58o7bqt/9xqWX3e5sSt8xiFlgW9Pl/4
        LfSn//9HLA5Hr6odrRCYYLhht6n69btTJNmkLbu/stmwq++ZfIftUBCnzLK7D9Ys1Kpe7z+p
        gfndwQk5Wp8F++1DgrxTa0+mPFvvf93w9M513pMnbpt4i8/4X/KU5Gr/paJayz1sXI/nMR9n
        Ngg8HP3WpC2qTpjncbxw/mGxB+EXdvA4GOj3MK0P8wywO1FR3WF0QM3w2z+Rv7uFsw6/y2v6
        kNhWu3/vvnolluKMREMt5qLiRABIIrHTPQMAAA==
X-CMS-MailID: 20230209114451eucas1p2de6ec04f18cf81fe7722758676ee5fb8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230208160502eucas1p1701d218cd13235cad7cbd6275ff18c26
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230208160502eucas1p1701d218cd13235cad7cbd6275ff18c26
References: <CGME20230208160502eucas1p1701d218cd13235cad7cbd6275ff18c26@eucas1p1.samsung.com>
        <20230208160424.371678-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.02.2023 17:04, Krzysztof Kozlowski wrote:
> The max98090 has only one DAI and does not take argument to DAI
> phandles:
>
>    exynos5250-snow-rev5.dtb: audio-codec@10: #sound-dai-cells:0:0: 0 was expected
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>   arch/arm/boot/dts/exynos5250-snow-rev5.dts | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/exynos5250-snow-rev5.dts b/arch/arm/boot/dts/exynos5250-snow-rev5.dts
> index 0a47597d6f0d..3d32c3476e84 100644
> --- a/arch/arm/boot/dts/exynos5250-snow-rev5.dts
> +++ b/arch/arm/boot/dts/exynos5250-snow-rev5.dts
> @@ -27,7 +27,7 @@ cpu {
>   		};
>   
>   		codec {
> -			sound-dai = <&max98090 0>, <&hdmi>;
> +			sound-dai = <&max98090>, <&hdmi>;
>   		};
>   	};
>   };
> @@ -42,7 +42,7 @@ max98090: audio-codec@10 {
>   		pinctrl-0 = <&max98090_irq>;
>   		clocks = <&pmu_system_controller 0>;
>   		clock-names = "mclk";
> -		#sound-dai-cells = <1>;
> +		#sound-dai-cells = <0>;
>   	};
>   };
>   

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

