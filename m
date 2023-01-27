Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB7B67F183
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 23:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbjA0Wyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 17:54:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbjA0Wyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 17:54:38 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AFC8B788
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 14:54:13 -0800 (PST)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230127225410euoutp02b7a0d23411397f742341746d3a3e1a33~_TFeIHt2p0332903329euoutp02G
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 22:54:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230127225410euoutp02b7a0d23411397f742341746d3a3e1a33~_TFeIHt2p0332903329euoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1674860050;
        bh=RcZRPw8Plnj7wdfMl/nmohlZX1lhH2EoBGUja9QNHmc=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=he9cFyIceuh9lu+yqoBGy2IBXxKObX9iK7NkARaoyT5Xd/7fONTfFPLEZIY2vOL8b
         qsgX2puIAd63GeUMLHGf+3r6f/UypWmBY1QZFoWfQ9A7O8AQXDyAytf/i1VupIDOkt
         N5MuWrVjWKy/ATyuBxQtVsZy8CzIHT1LPDAvQCYY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230127225409eucas1p15ced1a7c6787daa75313bbaa99b79a3f~_TFd09akD2015820158eucas1p1m;
        Fri, 27 Jan 2023 22:54:09 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 31.0C.61197.11654D36; Fri, 27
        Jan 2023 22:54:09 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230127225409eucas1p1eb01de4567daf6830bfadf1d6c5ead1e~_TFdR_oxw2285022850eucas1p1k;
        Fri, 27 Jan 2023 22:54:09 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230127225409eusmtrp18dfe73480062b1e07f44ddeffcfe80c3~_TFdQPCVM0787007870eusmtrp18;
        Fri, 27 Jan 2023 22:54:09 +0000 (GMT)
X-AuditID: cbfec7f5-7dbff7000000ef0d-8d-63d45611352e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id BB.B1.00518.11654D36; Fri, 27
        Jan 2023 22:54:09 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230127225408eusmtip24a5ca7d29fefbaef246bdf66e8d92080~_TFcZ328I0135501355eusmtip21;
        Fri, 27 Jan 2023 22:54:08 +0000 (GMT)
Message-ID: <bc5d8c21-dad4-a24e-f8bf-e24611600b01@samsung.com>
Date:   Fri, 27 Jan 2023 23:54:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 6/8] ARM: dts: exynos: move DP and MIPI phys to PMU node
 in Exynos5420
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
In-Reply-To: <20230127194057.186458-7-krzysztof.kozlowski@linaro.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEKsWRmVeSWpSXmKPExsWy7djPc7qCYVeSDZ6sMbR4MG8bm8X1L89Z
        LeYfOcdq8XbJLkaLo63/mS36Xjxkttj7eiu7xabH11gtLu+aw2YxYdU3FosZ5/cxWZz5N5XF
        YsEfO4t1awQtWvceYbc4/Kad1WLnnRPMFpu//2V0EPLYOesuu8fRK/dYPTat6mTzuHNtD5vH
        5iX1Hv/vrGX3+NLczerRt2UVo8fnTXIBnFFcNimpOZllqUX6dglcGQf2mBS8FKo4dqWBuYHx
        K18XIyeHhICJxNwNLaxdjFwcQgIrGCX+/N8N5XxhlLhx5DsLhPOZUWLnlD1MXYwcYC2b5uVB
        xJczSkxb388E4XxklLh/+z47SBGvgJ3Eze8WICaLgKrEuvNRINt4BQQlTs58wgISFhVIkdj0
        pwwkLCwQI3Hs7WRmEJtZQFzi1pP5YBNFBB4wS9zb9oYdIvGcUeL2XzYQm03AUKLrbReYzSng
        KnHzxzRGiBp5ie1v5zBDfHaOU2JrZw2E7SJx+9trNghbWOLV8S3sELaMxOnJPWA/Sgi0M0os
        +H2fCcKZwCjR8PwWI0SVtcSdc7/YQK5mFtCUWL9LHyLsKDF93zs2SJjwSdx4KwhxA5/EpG3T
        mSHCvBIdbUIQ1WoSs46vg1t78MIl5gmMSrOQQmUWkvdnIflmFsLeBYwsqxjFU0uLc9NTi43z
        Usv1ihNzi0vz0vWS83M3MQKT4el/x7/uYFzx6qPeIUYmDsZDjBIczEoivFsdLyUL8aYkVlal
        FuXHF5XmpBYfYpTmYFES59W2PZksJJCeWJKanZpakFoEk2Xi4JRqYFIXidxWv+ascvjqzUs7
        vF4dYUwTiPmXbaVZwGtbn/4r1tNJ3PrFwi+RYsJxK0VzVn4LEVyxQXl3s8J+zn/GcpW//28I
        jnDfz2H2prbwU1nrCYYpt6//bs7h+vPouL9g2kHNCvP6K09DLe4IV+gc9QrZ4Rh3yHjCNOdL
        /Ooq0hvnH3+1b6+GdPmtrQdT+zkT84V+HsvL3vgx9kLMld23+eoPuUwx3n2zVFFOMsrBKX8Z
        d0igev3eNoupS/RCL/2yrXn3P+jGf96dXZHLHx6pkC88826D/cZJWRMq7T6IZx7hq+1fG9fQ
        OsGpXOwrf/rjj88SPc7FWB1Z/Mts2rnuCzJP3+1SPcp2994C7qavv5RYijMSDbWYi4oTAcBl
        8hX1AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGIsWRmVeSWpSXmKPExsVy+t/xe7qCYVeSDTb081s8mLeNzeL6l+es
        FvOPnGO1eLtkF6PF0db/zBZ9Lx4yW+x9vZXdYtPja6wWl3fNYbOYsOobi8WM8/uYLM78m8pi
        seCPncW6NYIWrXuPsFscftPOarHzzglmi83f/zI6CHnsnHWX3ePolXusHptWdbJ53Lm2h81j
        85J6j/931rJ7fGnuZvXo27KK0ePzJrkAzig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1D
        Y/NYKyNTJX07m5TUnMyy1CJ9uwS9jAN7TApeClUcu9LA3MD4la+LkYNDQsBEYtO8vC5GLg4h
        gaWMEjNvPGDtYuQEistInJzWAGULS/y51sUGYgsJvGeUmP6NE6SXV8BO4uZ3CxCTRUBVYt35
        KJAKXgFBiZMzn7CA2KICKRLNz0+CTREWiJE49nYyM4jNLCAucevJfCaQtSICj5glNs/5wgLi
        MAs8Z5S4v7WJFeKgy4wSu69dARvFJmAo0fUW4ghOAVeJmz+mMUKMMpPo2toFZctLbH87h3kC
        o9AsJJfMQrJxFpKWWUhaFjCyrGIUSS0tzk3PLTbSK07MLS7NS9dLzs/dxAhMANuO/dyyg3Hl
        q496hxiZOBgPMUpwMCuJ8G51vJQsxJuSWFmVWpQfX1Sak1p8iNEUGBoTmaVEk/OBKSivJN7Q
        zMDU0MTM0sDU0sxYSZzXs6AjUUggPbEkNTs1tSC1CKaPiYNTqoGpskjK9+HiBwWqqVPV/7n+
        eWfsVVKS//anpcNFWY/jCu4mR0PVL5pcE3516MjW1G0/hevbMlwev1pnJb/otYJ66vrOe486
        N7/5Ht5ya/8SR4/9hQefq6/05vg7+4gxv9wP4/4nGkc/HjqU83D384lrUwOyn7O37RYWOhjJ
        c97J3Jd/+/KNtlKFEz4/XhsmtO/Vyy18/p5a9+ubcis8HySw5L+p+hmUHTFr2SZzA7vP97+X
        Pw5t0pOfcfhCTgCn6haD/eW8zHM+hki7xxxk6mtuFxFIVN+QPTnW7FlEm8ecJxXRjKsjOR96
        dBUx/yxe//bj/yS5j+t+vtWRtmnfzWT7VO7WyaqZ52Wya1UiU54rsRRnJBpqMRcVJwIA6Eer
        84kDAAA=
X-CMS-MailID: 20230127225409eucas1p1eb01de4567daf6830bfadf1d6c5ead1e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230127194123eucas1p20a54329d03b2e5c0c2b1089ab2db2673
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230127194123eucas1p20a54329d03b2e5c0c2b1089ab2db2673
References: <20230127194057.186458-1-krzysztof.kozlowski@linaro.org>
        <CGME20230127194123eucas1p20a54329d03b2e5c0c2b1089ab2db2673@eucas1p2.samsung.com>
        <20230127194057.186458-7-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
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
>    exynos5420-smdk5420.dtb: soc: dp-video-phy: {'compatible': ['samsung,exynos5420-dp-video-phy'],
>      'samsung,pmu-syscon': [[11]], '#phy-cells': [[0]], 'phandle': [[16]]} should not be valid under {'type': 'object'}
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>   arch/arm/boot/dts/exynos5420.dtsi | 24 +++++++++++-------------
>   1 file changed, 11 insertions(+), 13 deletions(-)
>
> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
> index b1051a7d07af..6cdb1a832fb9 100644
> --- a/arch/arm/boot/dts/exynos5420.dtsi
> +++ b/arch/arm/boot/dts/exynos5420.dtsi
> @@ -585,18 +585,6 @@ spi_2: spi@12d40000 {
>   			status = "disabled";
>   		};
>   
> -		dp_phy: dp-video-phy {
> -			compatible = "samsung,exynos5420-dp-video-phy";
> -			samsung,pmu-syscon = <&pmu_system_controller>;
> -			#phy-cells = <0>;
> -		};
> -
> -		mipi_phy: mipi-video-phy {
> -			compatible = "samsung,exynos5420-mipi-video-phy";
> -			syscon = <&pmu_system_controller>;
> -			#phy-cells = <1>;
> -		};
> -
>   		dsi: dsi@14500000 {
>   			compatible = "samsung,exynos5410-mipi-dsi";
>   			reg = <0x14500000 0x10000>;
> @@ -822,7 +810,7 @@ jpeg_1: jpeg@11f60000 {
>   		};
>   
>   		pmu_system_controller: system-controller@10040000 {
> -			compatible = "samsung,exynos5420-pmu", "syscon";
> +			compatible = "samsung,exynos5420-pmu", "simple-mfd", "syscon";
>   			reg = <0x10040000 0x5000>;
>   			clock-names = "clkout16";
>   			clocks = <&clock CLK_FIN_PLL>;
> @@ -830,6 +818,16 @@ pmu_system_controller: system-controller@10040000 {
>   			interrupt-controller;
>   			#interrupt-cells = <3>;
>   			interrupt-parent = <&gic>;
> +
> +			dp_phy: dp-phy {
> +				compatible = "samsung,exynos5420-dp-video-phy";
> +				#phy-cells = <0>;
> +			};
> +
> +			mipi_phy: mipi-phy {
> +				compatible = "samsung,exynos5420-mipi-video-phy";
> +				#phy-cells = <1>;
> +			};
>   		};
>   
>   		tmu_cpu0: tmu@10060000 {

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

