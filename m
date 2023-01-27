Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F14067F108
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 23:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbjA0WQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 17:16:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbjA0WQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 17:16:50 -0500
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E2B86E8D
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 14:16:46 -0800 (PST)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230127221645euoutp01d6c83575747768a962ee6c6ec539e448~_SkzLvSZ91390113901euoutp01I
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 22:16:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230127221645euoutp01d6c83575747768a962ee6c6ec539e448~_SkzLvSZ91390113901euoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1674857805;
        bh=EtfKma/Lxeex/Fy3hraePlaRMxLT4YpzyN2J0Leb17k=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=j66X8wq0dsRyG+7lOghasWWPWIUnOaHrFpDM1mxI0he1gwYI207wNv8H7vpSWxgPM
         RpWej3YFmgINrDOCWLBb1lYgIBVXsoIkA/aHNjLClotRybFYCXuAPErS9IZseSi2l8
         crOE8cRB3ABIvRmEmLweNo+yl2T9mvucIfaSqAsI=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230127221644eucas1p1a3e977ed198e77a9818172a6ec492bb0~_SkypCr1w1221112211eucas1p1Z;
        Fri, 27 Jan 2023 22:16:44 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 71.39.01471.C4D44D36; Fri, 27
        Jan 2023 22:16:44 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230127221643eucas1p107fdae814ec00a7a4169893b2af94c4a~_SkyAN5QD1111511115eucas1p1V;
        Fri, 27 Jan 2023 22:16:43 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230127221643eusmtrp2e7ca78664bf622ab3c84f5f9727597e0~_Skx-f1D21379413794eusmtrp2C;
        Fri, 27 Jan 2023 22:16:43 +0000 (GMT)
X-AuditID: cbfec7f2-2b1ff700000105bf-dd-63d44d4c86c6
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 1B.51.00518.B4D44D36; Fri, 27
        Jan 2023 22:16:43 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230127221642eusmtip176a03f21bb1442bd3faffd5172c8982f~_SkxGO75p3074430744eusmtip1O;
        Fri, 27 Jan 2023 22:16:42 +0000 (GMT)
Message-ID: <e2bca7ec-4e0d-e4b5-9933-a5be81d63f2b@samsung.com>
Date:   Fri, 27 Jan 2023 23:16:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 8/8] arm64: dts: exynos: move MIPI phy to PMU node in
 Exynos5433
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
In-Reply-To: <20230127194057.186458-9-krzysztof.kozlowski@linaro.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKKsWRmVeSWpSXmKPExsWy7djPc7o+vleSDQ4ekbB4MG8bm8X1L89Z
        LeYfOcdq8XbJLkaLo63/mS36Xjxkttj7eiu7xabH11gtLu+aw2YxYdU3FosZ5/cxWZz5N5XF
        YsEfO4t1awQtWvceYbc4/Kad1WLnnRPMFpu//2V0EPLYOesuu8fRK/dYPTat6mTzuHNtD5vH
        5iX1Hv/vrGX3+NLczerRt2UVo8fnTXIBnFFcNimpOZllqUX6dglcGa86L7MVfBSsuHL6PVsD
        4zK+LkYODgkBE4kv7626GLk4hARWMEq8OLafHcL5wiix6/sVVgjnM6PEyd79TF2MnGAdF5pn
        sEAkljNKPP14DarqI6PEqWdnmUGqeAXsJHZ8v8YIYrMIqEq0zjvCBBEXlDg58wkLyG5RgRSJ
        TX/KQMLCAmESjcves4PYzALiEreezGcCmSki8IBZ4t62N1CJ54wSt/+ygdhsAoYSXW+7wGxO
        AVeJ83tOMELUyEtsfzuHGaRZQuASp8TahaugznaR2HnkKCOELSzx6vgWdghbRuL/TohtEgLt
        jBILft+HciYwSjQ8vwXVYS1x59wvNpCzmQU0Jdbv0oeEnqPE6usRECafxI23ghA38ElM2jad
        GSLMK9HRJgQxQ01i1vF1cFsPXrjEPIFRaRZSqMxC8v4sJN/MQli7gJFlFaN4amlxbnpqsWFe
        arlecWJucWleul5yfu4mRmBKPP3v+KcdjHNffdQ7xMjEwXiIUYKDWUmEd6vjpWQh3pTEyqrU
        ovz4otKc1OJDjNIcLErivNq2J5OFBNITS1KzU1MLUotgskwcnFINTD4Ltr1jPRfz9WevzftH
        PBbeHxaZhc5ceG7jwVchNhYMEe/DTbonKP1mrpc33bhdzN7Tgj+h9JCxwZKEwyZi+YWuTl8V
        4l77+WcZlbLNiQy6mVV/Jf6lBeuSczmpSjdYuNbJfZBU7153TO1pr75j8sKWDXO3tVYKGmSX
        x/XM9rQ5znKyhaP1j+hHJelu0XcFXkcFWpxOib+LKc47lLNzSvtEBuW3fHHbE/fM3/s7MTg9
        /RfvltsTeiJD2+u1CopnCwo9PJH7l6vnzPN1R/3P9Z/Qmd7isORk0b8PQkfvShp1n5yr9lNA
        554HY1ES/wyuF9kralhlNtf82vzV4uOcY6vz32Q/vv7nw/IInmP9SizFGYmGWsxFxYkAhh7q
        hvgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNIsWRmVeSWpSXmKPExsVy+t/xu7revleSDb7N1bd4MG8bm8X1L89Z
        LeYfOcdq8XbJLkaLo63/mS36Xjxkttj7eiu7xabH11gtLu+aw2YxYdU3FosZ5/cxWZz5N5XF
        YsEfO4t1awQtWvceYbc4/Kad1WLnnRPMFpu//2V0EPLYOesuu8fRK/dYPTat6mTzuHNtD5vH
        5iX1Hv/vrGX3+NLczerRt2UVo8fnTXIBnFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqG
        xuaxVkamSvp2NimpOZllqUX6dgl6Ga86L7MVfBSsuHL6PVsD4zK+LkZODgkBE4kLzTNYuhi5
        OIQEljJKHHu2jAkiISNxcloDK4QtLPHnWhcbRNF7Rok3xw4wgyR4Bewkdny/xghiswioSrTO
        O8IEEReUODnzCQuILSqQItH8/CTYIGGBMInGZe/ZQWxmAXGJW0/mM4EMFRF4xCyxec4XsDOY
        BZ4zStzf2sQKse4yo0Tvsh1g69gEDCW63oLcwcnBKeAqcX7PCUaIUWYSXVu7oGx5ie1v5zBP
        YBSaheSSWUg2zkLSMgtJywJGllWMIqmlxbnpucVGesWJucWleel6yfm5mxiBqWDbsZ9bdjCu
        fPVR7xAjEwfjIUYJDmYlEd6tjpeShXhTEiurUovy44tKc1KLDzGaAoNjIrOUaHI+MBnllcQb
        mhmYGpqYWRqYWpoZK4nzehZ0JAoJpCeWpGanphakFsH0MXFwSjUwzXZY5+13KSrlDGfnGc4M
        s9srWljWbGdKSjoR6bLB6qkKN3v1vHcqofomunke+XVFpTGLrmsuKiv1dHH8/Cd9wlnZV/Nm
        3im+0NJ+J2tdV/oZX83VW3/lrQl+Utd4w2DhqilFrgdj+IOW/eVbKLGsq8Fp6sKorm+ZZzee
        XHyG+26N1g2jFxl+0oK7vyX/9gliMeXJ/Dh/B6+z36N5G8wu//18YU/k/QlPXDNZe1cVnLf9
        d9f6yvJ7R74G+C3/yrzjc/E6xqfzpj/nC1N9kjwldnqN22H29+eu7+l+UvXcX2/3M7tWy/Dl
        LxczprbLOAcb12y8OLcm4bDPTOEpz7bNf3TXrUqz7OOe7OldjKU7vyixFGckGmoxFxUnAgCC
        Kw09jgMAAA==
X-CMS-MailID: 20230127221643eucas1p107fdae814ec00a7a4169893b2af94c4a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230127194124eucas1p1c50cfe8e10e61e6718913dc00e4db0bd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230127194124eucas1p1c50cfe8e10e61e6718913dc00e4db0bd
References: <20230127194057.186458-1-krzysztof.kozlowski@linaro.org>
        <CGME20230127194124eucas1p1c50cfe8e10e61e6718913dc00e4db0bd@eucas1p1.samsung.com>
        <20230127194057.186458-9-krzysztof.kozlowski@linaro.org>
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
> The MIPI phy is actually part of the Power Management Unit system
> controller.  It does not have own address space, thus keeping the node
> under soc causes warnings:
>
>    exynos5433-tm2e.dtb: soc@0: video-phy: {'compatible': ['samsung,exynos5433-mipi-video-phy'], ...
>      should not be valid under {'type': 'object'}
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>   arch/arm64/boot/dts/exynos/exynos5433.dtsi | 19 +++++++++----------
>   1 file changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
> index 9da24fe958a3..842976addbd9 100644
> --- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
> @@ -911,12 +911,20 @@ pinctrl_touch: pinctrl@14ce0000 {
>   		};
>   
>   		pmu_system_controller: system-controller@105c0000 {
> -			compatible = "samsung,exynos5433-pmu", "syscon";
> +			compatible = "samsung,exynos5433-pmu", "simple-mfd", "syscon";
>   			reg = <0x105c0000 0x5008>;
>   			#clock-cells = <1>;
>   			clock-names = "clkout16";
>   			clocks = <&xxti>;
>   
> +			mipi_phy: mipi-phy {
> +				compatible = "samsung,exynos5433-mipi-video-phy";
> +				#phy-cells = <1>;
> +				samsung,cam0-sysreg = <&syscon_cam0>;
> +				samsung,cam1-sysreg = <&syscon_cam1>;
> +				samsung,disp-sysreg = <&syscon_disp>;
> +			};
> +
>   			reboot: syscon-reboot {
>   				compatible = "syscon-reboot";
>   				regmap = <&pmu_system_controller>;
> @@ -936,15 +944,6 @@ gic: interrupt-controller@11001000 {
>   			interrupts = <GIC_PPI 9 0xf04>;
>   		};
>   
> -		mipi_phy: video-phy {
> -			compatible = "samsung,exynos5433-mipi-video-phy";
> -			#phy-cells = <1>;
> -			samsung,pmu-syscon = <&pmu_system_controller>;
> -			samsung,cam0-sysreg = <&syscon_cam0>;
> -			samsung,cam1-sysreg = <&syscon_cam1>;
> -			samsung,disp-sysreg = <&syscon_disp>;
> -		};
> -
>   		decon: decon@13800000 {
>   			compatible = "samsung,exynos5433-decon";
>   			reg = <0x13800000 0x2104>;

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

