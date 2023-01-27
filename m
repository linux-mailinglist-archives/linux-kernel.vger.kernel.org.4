Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFDC767F17E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 23:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbjA0WyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 17:54:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbjA0Wxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 17:53:51 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345CD301B9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 14:53:40 -0800 (PST)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230127225338euoutp02ca67bd84bf6e9257aab353796ed5f675~_TFASKRqw0332903329euoutp02C
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 22:53:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230127225338euoutp02ca67bd84bf6e9257aab353796ed5f675~_TFASKRqw0332903329euoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1674860018;
        bh=VZOH4jIUdq2gOgALK8fM+qFCpqJUr5QB0gQLCS2apvE=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=ikYW7in9CNR++//ClodTGCVBPbhqu/7JG5A+nMSjejVH8vXG4/wPPWmI6dy5/1m5+
         lznygzFW75wz5S3yojoqkdbeK9wzVuiLAnB1u2zX/qcaXH1GzXMPPajjg5dr7kx9gB
         UbvVvBhIoP4mqFV9dP+xtOPondK9RvSLZts9xJKg=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230127225337eucas1p27174f5bf1578c697c3a94a6b7e5c0e79~_TE-2HYay2426024260eucas1p2Q;
        Fri, 27 Jan 2023 22:53:37 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id A5.FA.01471.1F554D36; Fri, 27
        Jan 2023 22:53:37 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230127225337eucas1p2f4f0d1df2b1d3d08aecb01f9bf66ef17~_TE-eGz5W2173921739eucas1p2_;
        Fri, 27 Jan 2023 22:53:37 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230127225337eusmtrp22bfc54dc693ecc310664c002f5729cc0~_TE-cBkl43034330343eusmtrp2M;
        Fri, 27 Jan 2023 22:53:37 +0000 (GMT)
X-AuditID: cbfec7f2-29bff700000105bf-b2-63d455f1e52c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 39.B1.00518.1F554D36; Fri, 27
        Jan 2023 22:53:37 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230127225336eusmtip2dc8fca4793414a01f31cd39f696f2e7b~_TE_ny5mP0138201382eusmtip2t;
        Fri, 27 Jan 2023 22:53:36 +0000 (GMT)
Message-ID: <efc36b04-9362-0987-05e0-3a989c8e3958@samsung.com>
Date:   Fri, 27 Jan 2023 23:53:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 7/8] ARM: dts: exynos: move DP and MIPI phys to PMU node
 in Exynos5250
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     replicant@osuosl.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        =?UTF-8?Q?Martin_J=c3=bccker?= <martin.juecker@gmail.com>,
        Henrik Grimler <henrik@grimler.se>,
        Chanwoo Choi <cw00.choi@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20230127194057.186458-8-krzysztof.kozlowski@linaro.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKKsWRmVeSWpSXmKPExsWy7djP87ofQ68kG7zsV7N4MG8bm8X1L89Z
        LeYfOcdq8XbJLkaLo63/mS36Xjxkttj7eiu7xabH11gtLu+aw2YxYdU3FosZ5/cxWZz5N5XF
        YsEfO4t1awQtWvceYbc4/Kad1WLnnRPMFpu//2V0EPLYOesuu8fRK/dYPTat6mTzuHNtD5vH
        5iX1Hv/vrGX3+NLczerRt2UVo8fnTXIBnFFcNimpOZllqUX6dglcGUef7mAseChUcW7FNOYG
        xnd8XYycHBICJhJ3lraxgNhCAisYJTbeDe9i5AKyvzBKbJ5whAXC+cwo8XH7XuYuRg6wjkvv
        iyHiyxklZr78zAjhfGSUWN+4ihVkFK+AncTpoxvYQGwWAVWJ9mUX2CDighInZz5hARkkKpAi
        selPGUhYWCBG4v+nE0wgNrOAuMStJ/OZQGaKCDxglri37Q07ROI5o8Ttv2Bz2AQMJbredoHZ
        nAKuEjsn7ISqkZfY/nYOM0izhMAlTolDTcdZIP50kfj2ZQ0rhC0s8er4FnYIW0bi/06IbRIC
        7YwSC37fh3ImMEo0PL/FCFFlLXHn3C82kLOZBTQl1u/Shwg7SrTMa2WCBAufxI23ghBH8ElM
        2jYdGlq8Eh1tQhDVahKzjq+DW3vwwiXmCYxKs5CCZRaS/2cheWcWwt4FjCyrGMVTS4tz01OL
        DfNSy/WKE3OLS/PS9ZLzczcxAlPi6X/HP+1gnPvqo94hRiYOxkOMEhzMSiK8Wx0vJQvxpiRW
        VqUW5ccXleakFh9ilOZgURLn1bY9mSwkkJ5YkpqdmlqQWgSTZeLglGpgSsvQaK7ddj1pXumG
        t9b7I6dWrZ6/u9r6W2v0ir1tD22yZH7fTYnazjtRPTPun6faR99pjI8jGHSXFhYIuLG8+nDg
        xJOWpA411dh5O5JvFnUfitu94o78iklL/sSyGpZH/HzEGf32k6HC3a3TJ7zkWMy7JdS65e0n
        Hc9HDWzT5s5k/bms6pr7tbmLyrg/2cz6r/37nK3L/v7GHTxfvd+Ec8qlayys8S81Xda1WVzy
        6POQdp1elVOZ19pX/umfqqHusmLBNevJnY5zJsnW8pkry8vOksw6t/KYtuu916pJ3h8XCWaa
        zhTYfewlwwb/K0nsBW94fn6vOPfgqdaEKPGwzKN9yxZPtjny9cFjEbUMJiWW4oxEQy3mouJE
        AK58ZOL4AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFIsWRmVeSWpSXmKPExsVy+t/xe7ofQ68kGyxfwm/xYN42NovrX56z
        Wsw/co7V4u2SXYwWR1v/M1v0vXjIbLH39VZ2i02Pr7FaXN41h81iwqpvLBYzzu9jsjjzbyqL
        xYI/dhbr1ghatO49wm5x+E07q8XOOyeYLTZ//8voIOSxc9Zddo+jV+6xemxa1cnmcefaHjaP
        zUvqPf7fWcvu8aW5m9Wjb8sqRo/Pm+QCOKP0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUM
        jc1jrYxMlfTtbFJSczLLUov07RL0Mo4+3cFY8FCo4tyKacwNjO/4uhg5OCQETCQuvS/uYuTi
        EBJYyihx5dJD1i5GTqC4jMTJaQ1QtrDEn2tdbBBF7xklzr2bzQyS4BWwkzh9dAMbiM0ioCrR
        vuwCG0RcUOLkzCcsILaoQIpE8/OTYIOEBWIk/n86wQRiMwuIS9x6Mp8JZKiIwCNmic1zvrCA
        OMwCzxkl7m9tYoVYd5lRYlXjFrB1bAKGEl1vu8BWcAq4SuycsJMdYpSZRNfWLkYIW15i+9s5
        zBMYhWYhuWQWko2zkLTMQtKygJFlFaNIamlxbnpusZFecWJucWleul5yfu4mRmAi2Hbs55Yd
        jCtffdQ7xMjEwXiIUYKDWUmEd6vjpWQh3pTEyqrUovz4otKc1OJDjKbA4JjILCWanA9MRXkl
        8YZmBqaGJmaWBqaWZsZK4ryeBR2JQgLpiSWp2ampBalFMH1MHJxSDUzTWFM0H6cwlLWdunV6
        8rVixqXrr9awPrnBFzz1+bNqyXtxdm/er6joNT33LvbWDuc9ljFd/AtUPu+P/rLimmJooPp/
        9raNqSncfpZvDwfFO0WIC56ySb07sdU1usbmojObtOh1ebWW4lr9RS5nm57NWz5bQ4n5fOC5
        3Kbi5Vde611neqgZLHvfL21ygO78iTeunnuxfIWHzdPj1W9T8w6ejdr3xZkrd26//8SY1opv
        LdXCes7FsXu5+3atEzo5o+7L6z3uzAGvegr+Zz5I/FV/JIV9nsiCTXEfT387ImNS83bZL52k
        7Zs01nQ6e++9oD3FZNaHxYXTJD9nhWu+iRLksj4Sa2KyynT/jx2O/bpKLMUZiYZazEXFiQAh
        RgA1jQMAAA==
X-CMS-MailID: 20230127225337eucas1p2f4f0d1df2b1d3d08aecb01f9bf66ef17
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230127194122eucas1p240a9b4959e4690652862753354681232
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230127194122eucas1p240a9b4959e4690652862753354681232
References: <20230127194057.186458-1-krzysztof.kozlowski@linaro.org>
        <CGME20230127194122eucas1p240a9b4959e4690652862753354681232@eucas1p2.samsung.com>
        <20230127194057.186458-8-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.01.2023 20:40, Krzysztof Kozlowski wrote:
> The DisplayPort and MIPI phys are actually part of the Power Management
> Unit system controller.  They do not have their own address space, thus
> keeping the nodes under soc causes warnings:
>
>    exynos5250-arndale.dtb: soc: video-phy-0: {'compatible': ['samsung,exynos5250-dp-video-phy'],
>      'samsung,pmu-syscon': [[20]], '#phy-cells': [[0]], 'phandle': [[24]]} should not be valid under {'type': 'object'}
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>   arch/arm/boot/dts/exynos5250.dtsi | 24 +++++++++++-------------
>   1 file changed, 11 insertions(+), 13 deletions(-)
>
> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
> index 97e89859ba3d..a35c00f055a3 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -290,7 +290,7 @@ pinctrl_3: pinctrl@3860000 {
>   		};
>   
>   		pmu_system_controller: system-controller@10040000 {
> -			compatible = "samsung,exynos5250-pmu", "syscon";
> +			compatible = "samsung,exynos5250-pmu", "simple-mfd", "syscon";
>   			reg = <0x10040000 0x5000>;
>   			clock-names = "clkout16";
>   			clocks = <&clock CLK_FIN_PLL>;
> @@ -298,6 +298,16 @@ pmu_system_controller: system-controller@10040000 {
>   			interrupt-controller;
>   			#interrupt-cells = <3>;
>   			interrupt-parent = <&gic>;
> +
> +			dp_phy: dp-phy {
> +				compatible = "samsung,exynos5250-dp-video-phy";
> +				#phy-cells = <0>;
> +			};
> +
> +			mipi_phy: mipi-phy {
> +				compatible = "samsung,s5pv210-mipi-video-phy";
> +				#phy-cells = <1>;
> +			};
>   		};
>   
>   		watchdog@101d0000 {
> @@ -810,18 +820,6 @@ mixer: mixer@14450000 {
>   			status = "disabled";
>   		};
>   
> -		dp_phy: video-phy-0 {
> -			compatible = "samsung,exynos5250-dp-video-phy";
> -			samsung,pmu-syscon = <&pmu_system_controller>;
> -			#phy-cells = <0>;
> -		};
> -
> -		mipi_phy: video-phy-1 {
> -			compatible = "samsung,s5pv210-mipi-video-phy";
> -			#phy-cells = <1>;
> -			syscon = <&pmu_system_controller>;
> -		};
> -
>   		dsi_0: dsi@14500000 {
>   			compatible = "samsung,exynos4210-mipi-dsi";
>   			reg = <0x14500000 0x10000>;

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

