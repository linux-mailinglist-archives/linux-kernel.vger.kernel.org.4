Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F3367C7B8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 10:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236643AbjAZJr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 04:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjAZJrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 04:47:55 -0500
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04F3EFA3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 01:47:51 -0800 (PST)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230126094748euoutp01c348f37efedc247a75decb51ba5b111e~90tmqHGwj2139921399euoutp01Y
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 09:47:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230126094748euoutp01c348f37efedc247a75decb51ba5b111e~90tmqHGwj2139921399euoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1674726468;
        bh=wzGKNfduvPOJZcb5cjoO4loiJ9e2xj9rVLF30B/Vaww=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=cBYlte0VjImTxmzptvfR5uOsZPn4TBv51kNdIbycRs3MhjXo0XGu+RXKV7yQtvrZ5
         YtKVlF7lhaWniJN3PqB+fWhVv9izd8qSh/M3E4wst6wr7MT2AYmq5VVS6nFncFO+Q7
         op1duwjWPAIecfpgh3BY66RVWpu/nO6YURrCKA18=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230126094748eucas1p2d44de906a0f0dbed8580e6733a48a900~90tmT7MPe2897128971eucas1p2k;
        Thu, 26 Jan 2023 09:47:48 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 2F.12.01471.44C42D36; Thu, 26
        Jan 2023 09:47:48 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230126094747eucas1p2cf09a613efdd1a74363caa0bef757bfe~90tlxcTgo2498824988eucas1p2f;
        Thu, 26 Jan 2023 09:47:47 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230126094747eusmtrp242f54a6c7a10bf2004f3d4007b507c12~90tlwoEJe2133721337eusmtrp2x;
        Thu, 26 Jan 2023 09:47:47 +0000 (GMT)
X-AuditID: cbfec7f2-2b1ff700000105bf-22-63d24c447cad
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 49.49.02722.34C42D36; Thu, 26
        Jan 2023 09:47:47 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230126094746eusmtip1cd4e0be92b4a5f8b861946b304d71752~90tk8xCwz2669726697eusmtip1I;
        Thu, 26 Jan 2023 09:47:46 +0000 (GMT)
Message-ID: <cd42b8c9-a79a-068c-a967-810c05e818bd@samsung.com>
Date:   Thu, 26 Jan 2023 10:47:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 2/9] ARM: dts: exynos: move exynos-bus nodes out of soc
 in Exynos5420
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     replicant@osuosl.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        =?UTF-8?Q?Martin_J=c3=bccker?= <martin.juecker@gmail.com>,
        Henrik Grimler <henrik@grimler.se>,
        Chanwoo Choi <cw00.choi@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20230125094513.155063-2-krzysztof.kozlowski@linaro.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOKsWRmVeSWpSXmKPExsWy7djPc7ouPpeSDRrvC1o8mLeNzeL6l+es
        FvOPnGO1eLtkF6NF/+PXzBZ9Lx4yW+x9vZXdYtPja6wWl3fNYbOYcX4fk8WZf1NZLBb8sbNY
        t0bQonXvEXaLzd//Mjrwe+ycdZfd4+iVe6wem1Z1snncubaHzWPzknqP/3fWsnt8ae5m9ejb
        sorR4/MmuQDOKC6blNSczLLUIn27BK6MZd1/mAu+21b8/r2VpYHxrH4XIyeHhICJRPvUr2wg
        tpDACkaJlr9lXYxcQPYXRokFLxczQjifGSXu39jEDNOxfOkUVojEckaJ5itvmSCcj4wSD77P
        A5vFK2AncffzBrAOFgFViYO9Cxgh4oISJ2c+Yeli5OAQFUiR2PSnDCQsLBAtcXA6xBnMAuIS
        t57MB5spIvCMSWLm1lYmiMRzRonbf8GK2AQMJbredoHZnAKuElsvTGaGqJGX2P52DjNIs4TA
        dk6JxVfesUGc7SLxb9M2qBeEJV4d38IOYctI/N8JsU1CoB3o6d/3oZwJjBINz28xQlRZS9w5
        94sN5GxmAU2J9bugoecosXX1UrBvJAT4JG68FYQ4gk9i0rbpzBBhXomONiGIajWJWcfXwa09
        eOES8wRGpVlIwTILyf+zkLwzC2HvAkaWVYziqaXFuempxYZ5qeV6xYm5xaV56XrJ+bmbGIFp
        7/S/4592MM599VHvECMTB+MhRgkOZiUR3q2Ol5KFeFMSK6tSi/Lji0pzUosPMUpzsCiJ82rb
        nkwWEkhPLEnNTk0tSC2CyTJxcEo1MIU8vWf5Xv2sc7XPwhuFN7WmqTkcyF7AOGGuu8nuLXci
        tDyLkqw3fJY75icw/d6xNRfD6p+53Ld9WXsp7MW8DG6r0qtG2yXsRY4Wr5BemL3zWPfLgHz7
        j2q1suX+3dODjQ+1qVmGrS8IF8wLiBL5JPdL5NE89md2L83b+PbW6MqEuU1XVCttXjHb6p9q
        QKhcyYSlE580Fwurnm6f3HUtrkY01cM3T8dtkdWyMJWDQReDJ23OuSxoJZieN/Pvl5e79vNp
        WPPeml7/vvnaoUU3H9dp7p3WVd/0NnqJXqbHFpc9Ts8mFj5nvZA2cVZ0H2u5m2ek38f1+y5m
        alaqtzClf2O6yKYcZzndd4KyxtM+JZbijERDLeai4kQA1BVsTeoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDIsWRmVeSWpSXmKPExsVy+t/xu7rOPpeSDV5f1rZ4MG8bm8X1L89Z
        LeYfOcdq8XbJLkaL/sevmS36Xjxkttj7eiu7xabH11gtLu+aw2Yx4/w+Josz/6ayWCz4Y2ex
        bo2gReveI+wWm7//ZXTg99g56y67x9Er91g9Nq3qZPO4c20Pm8fmJfUe/++sZff40tzN6tG3
        ZRWjx+dNcgGcUXo2RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWp
        Rfp2CXoZy7r/MBd8t634/XsrSwPjWf0uRk4OCQETieVLp7B2MXJxCAksZZQ483MGI0RCRuLk
        tAZWCFtY4s+1LjaIoveMEtt3PGMHSfAK2Enc/byBGcRmEVCVONi7gBEiLihxcuYTFhBbVCBF
        ovn5SbBBwgLREivn7QWrZxYQl7j1ZD4TyFARgWdMEo+fb2MBcZgFnjNK3N/aBHXTZUaJzpdz
        wFrYBAwlut6C3MHJwSngKrH1wmSoUWYSXVu7GCFseYntb+cwT2AUmoXkkllINs5C0jILScsC
        RpZVjCKppcW56bnFhnrFibnFpXnpesn5uZsYgdG+7djPzTsY5736qHeIkYmD8RCjBAezkgjv
        VsdLyUK8KYmVValF+fFFpTmpxYcYTYHBMZFZSjQ5H5hu8kriDc0MTA1NzCwNTC3NjJXEeT0L
        OhKFBNITS1KzU1MLUotg+pg4OKUamKb/ytRTiVi8TfOZDfOUNU1VGzMWeXyLZ+B+pvK5Z8rl
        H+oM0yY2LzsgHVT+c1/JfsWOJqGa2D+9ipMmXw007d+XplnGPvH6/nfNHoYZC77Pebnw5o1+
        rxeND109ww0uq/5Lnvz8eM+cJeGrpzncXs9qYt1uv+DNY641k1/+7Ahq6pkx737FgSfnhLWv
        hy+4+jDUsN//zb/zPiwvXgad/ro+O7zvZONGDR/egiXyfonL9nDdM/nHrL8x5N2HCft13fin
        JKdnu33KFyuy+WxXdehlYpan3qGZ2yb0+un5uAZv80h/qB0rr8li/+8k89e32SI3V+99vWfz
        dKG2pzVTf6xL1bNboabj2nSRJ1NI6osSS3FGoqEWc1FxIgDvE0HKfwMAAA==
X-CMS-MailID: 20230126094747eucas1p2cf09a613efdd1a74363caa0bef757bfe
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230125094529eucas1p29b5f25af2c658abef13a93c49eca975f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230125094529eucas1p29b5f25af2c658abef13a93c49eca975f
References: <20230125094513.155063-1-krzysztof.kozlowski@linaro.org>
        <CGME20230125094529eucas1p29b5f25af2c658abef13a93c49eca975f@eucas1p2.samsung.com>
        <20230125094513.155063-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 25.01.2023 10:45, Krzysztof Kozlowski wrote:
> The soc node is supposed to have only device nodes with MMIO addresses,
> as reported by dtc W=1:
>
>    arch/arm/boot/dts/exynos5420.dtsi:1070.24-1075.5:
>      Warning (simple_bus_reg): /soc/bus-wcore: missing or empty reg/ranges property
>
> and dtbs_check:
>
>    exynos5420-arndale-octa.dtb: soc: bus-wcore:
>      {'compatible': ['samsung,exynos-bus'], 'clocks': [[2, 769]], 'clock-names': ['bus'], 'status': ['disabled']} should not be valid under {'type': 'object'}
>
> Move the bus nodes and their OPP tables out of SoC to fix this.
> Re-order them alphabetically while moving and put some of the OPP tables
> in device nodes (if they are not shared).
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Frankly speaking I'm not very keen on moving those bus nodes out of 
/soc. Technically speaking this is definitely a part of soc and doesn't 
make much sense outside of it. IMHO they describe SoC hardware details 
and they might be moved somehow under clock controller device(s), 
although this would require some changes in the bindings and drivers.

> ---
>   arch/arm/boot/dts/exynos5420.dtsi | 223 +++++++++++++++---------------
>   1 file changed, 111 insertions(+), 112 deletions(-)
>
> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
> index 7efe72879dc4..cea92f175d46 100644
> --- a/arch/arm/boot/dts/exynos5420.dtsi
> +++ b/arch/arm/boot/dts/exynos5420.dtsi
> @@ -37,6 +37,117 @@ aliases {
>   		spi2 = &spi_2;
>   	};
>   
> +	bus_disp1: bus-disp1 {
> +		compatible = "samsung,exynos-bus";
> +		clocks = <&clock CLK_DOUT_ACLK400_DISP1>;
> +		clock-names = "bus";
> +		status = "disabled";
> +	};
> +
> +	bus_disp1_fimd: bus-disp1-fimd {
> +		compatible = "samsung,exynos-bus";
> +		clocks = <&clock CLK_DOUT_ACLK300_DISP1>;
> +		clock-names = "bus";
> +		status = "disabled";
> +	};
> +
> +	bus_fsys: bus-fsys {
> +		compatible = "samsung,exynos-bus";
> +		clocks = <&clock CLK_DOUT_ACLK200_FSYS>;
> +		clock-names = "bus";
> +		status = "disabled";
> +	};
> +
> +	bus_fsys2: bus-fsys2 {
> +		compatible = "samsung,exynos-bus";
> +		clocks = <&clock CLK_DOUT_ACLK200_FSYS2>;
> +		clock-names = "bus";
> +		status = "disabled";
> +	};
> +
> +	bus_fsys_apb: bus-fsys-apb {
> +		compatible = "samsung,exynos-bus";
> +		clocks = <&clock CLK_DOUT_PCLK200_FSYS>;
> +		clock-names = "bus";
> +		status = "disabled";
> +	};
> +
> +	bus_g2d: bus-g2d {
> +		compatible = "samsung,exynos-bus";
> +		clocks = <&clock CLK_DOUT_ACLK333_G2D>;
> +		clock-names = "bus";
> +		status = "disabled";
> +	};
> +
> +	bus_g2d_acp: bus-g2d-acp {
> +		compatible = "samsung,exynos-bus";
> +		clocks = <&clock CLK_DOUT_ACLK266_G2D>;
> +		clock-names = "bus";
> +		status = "disabled";
> +	};
> +	bus_gen: bus-gen {
> +		compatible = "samsung,exynos-bus";
> +		clocks = <&clock CLK_DOUT_ACLK266>;
> +		clock-names = "bus";
> +		status = "disabled";
> +	};
> +
> +	bus_gscl_scaler: bus-gscl-scaler {
> +		compatible = "samsung,exynos-bus";
> +		clocks = <&clock CLK_DOUT_ACLK300_GSCL>;
> +		clock-names = "bus";
> +		status = "disabled";
> +	};
> +
> +	bus_jpeg: bus-jpeg {
> +		compatible = "samsung,exynos-bus";
> +		clocks = <&clock CLK_DOUT_ACLK300_JPEG>;
> +		clock-names = "bus";
> +		status = "disabled";
> +	};
> +
> +	bus_jpeg_apb: bus-jpeg-apb {
> +		compatible = "samsung,exynos-bus";
> +		clocks = <&clock CLK_DOUT_ACLK166>;
> +		clock-names = "bus";
> +		status = "disabled";
> +	};
> +
> +	bus_mfc: bus-mfc {
> +		compatible = "samsung,exynos-bus";
> +		clocks = <&clock CLK_DOUT_ACLK333>;
> +		clock-names = "bus";
> +		status = "disabled";
> +	};
> +
> +	bus_mscl: bus-mscl {
> +		compatible = "samsung,exynos-bus";
> +		clocks = <&clock CLK_DOUT_ACLK400_MSCL>;
> +		clock-names = "bus";
> +		status = "disabled";
> +	};
> +
> +	bus_noc: bus-noc {
> +		compatible = "samsung,exynos-bus";
> +		clocks = <&clock CLK_DOUT_ACLK100_NOC>;
> +		clock-names = "bus";
> +		status = "disabled";
> +	};
> +
> +	bus_peri: bus-peri {
> +		compatible = "samsung,exynos-bus";
> +		clocks = <&clock CLK_DOUT_ACLK66>;
> +		clock-names = "bus";
> +		status = "disabled";
> +	};
> +
> +	bus_wcore: bus-wcore {
> +		compatible = "samsung,exynos-bus";
> +		clocks = <&clock CLK_DOUT_ACLK400_WCORE>;
> +		clock-names = "bus";
> +		status = "disabled";
> +	};
> +
>   	/*
>   	 * The 'cpus' node is not present here but instead it is provided
>   	 * by exynos5420-cpus.dtsi or exynos5422-cpus.dtsi.
> @@ -1066,118 +1177,6 @@ sysmmu_fimd1_1: sysmmu@14680000 {
>   			power-domains = <&disp_pd>;
>   			#iommu-cells = <0>;
>   		};
> -
> -		bus_wcore: bus-wcore {
> -			compatible = "samsung,exynos-bus";
> -			clocks = <&clock CLK_DOUT_ACLK400_WCORE>;
> -			clock-names = "bus";
> -			status = "disabled";
> -		};
> -
> -		bus_noc: bus-noc {
> -			compatible = "samsung,exynos-bus";
> -			clocks = <&clock CLK_DOUT_ACLK100_NOC>;
> -			clock-names = "bus";
> -			status = "disabled";
> -		};
> -
> -		bus_fsys_apb: bus-fsys-apb {
> -			compatible = "samsung,exynos-bus";
> -			clocks = <&clock CLK_DOUT_PCLK200_FSYS>;
> -			clock-names = "bus";
> -			status = "disabled";
> -		};
> -
> -		bus_fsys: bus-fsys {
> -			compatible = "samsung,exynos-bus";
> -			clocks = <&clock CLK_DOUT_ACLK200_FSYS>;
> -			clock-names = "bus";
> -			status = "disabled";
> -		};
> -
> -		bus_fsys2: bus-fsys2 {
> -			compatible = "samsung,exynos-bus";
> -			clocks = <&clock CLK_DOUT_ACLK200_FSYS2>;
> -			clock-names = "bus";
> -			status = "disabled";
> -		};
> -
> -		bus_mfc: bus-mfc {
> -			compatible = "samsung,exynos-bus";
> -			clocks = <&clock CLK_DOUT_ACLK333>;
> -			clock-names = "bus";
> -			status = "disabled";
> -		};
> -
> -		bus_gen: bus-gen {
> -			compatible = "samsung,exynos-bus";
> -			clocks = <&clock CLK_DOUT_ACLK266>;
> -			clock-names = "bus";
> -			status = "disabled";
> -		};
> -
> -		bus_peri: bus-peri {
> -			compatible = "samsung,exynos-bus";
> -			clocks = <&clock CLK_DOUT_ACLK66>;
> -			clock-names = "bus";
> -			status = "disabled";
> -		};
> -
> -		bus_g2d: bus-g2d {
> -			compatible = "samsung,exynos-bus";
> -			clocks = <&clock CLK_DOUT_ACLK333_G2D>;
> -			clock-names = "bus";
> -			status = "disabled";
> -		};
> -
> -		bus_g2d_acp: bus-g2d-acp {
> -			compatible = "samsung,exynos-bus";
> -			clocks = <&clock CLK_DOUT_ACLK266_G2D>;
> -			clock-names = "bus";
> -			status = "disabled";
> -		};
> -
> -		bus_jpeg: bus-jpeg {
> -			compatible = "samsung,exynos-bus";
> -			clocks = <&clock CLK_DOUT_ACLK300_JPEG>;
> -			clock-names = "bus";
> -			status = "disabled";
> -		};
> -
> -		bus_jpeg_apb: bus-jpeg-apb {
> -			compatible = "samsung,exynos-bus";
> -			clocks = <&clock CLK_DOUT_ACLK166>;
> -			clock-names = "bus";
> -			status = "disabled";
> -		};
> -
> -		bus_disp1_fimd: bus-disp1-fimd {
> -			compatible = "samsung,exynos-bus";
> -			clocks = <&clock CLK_DOUT_ACLK300_DISP1>;
> -			clock-names = "bus";
> -			status = "disabled";
> -		};
> -
> -		bus_disp1: bus-disp1 {
> -			compatible = "samsung,exynos-bus";
> -			clocks = <&clock CLK_DOUT_ACLK400_DISP1>;
> -			clock-names = "bus";
> -			status = "disabled";
> -		};
> -
> -		bus_gscl_scaler: bus-gscl-scaler {
> -			compatible = "samsung,exynos-bus";
> -			clocks = <&clock CLK_DOUT_ACLK300_GSCL>;
> -			clock-names = "bus";
> -			status = "disabled";
> -		};
> -
> -		bus_mscl: bus-mscl {
> -			compatible = "samsung,exynos-bus";
> -			clocks = <&clock CLK_DOUT_ACLK400_MSCL>;
> -			clock-names = "bus";
> -			status = "disabled";
> -		};
>   	};
>   
>   	thermal-zones {

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

