Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C158697514
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 04:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjBODxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 22:53:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbjBODxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 22:53:01 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B864144B8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 19:52:57 -0800 (PST)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230215035255epoutp032145cf0aeb1285dc1b58c51ff8e88522~D4xc1TtYw1442314423epoutp03I
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 03:52:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230215035255epoutp032145cf0aeb1285dc1b58c51ff8e88522~D4xc1TtYw1442314423epoutp03I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1676433175;
        bh=QsnsKiX4g5clYeHYRisOZQuZkyjcH0pEP/7uoDA8J0U=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=bpQNbgX6fARZX/GzeA0dtWF2I+lYLjL0LHFJkxkuRCJgxBHF48/9APnpnuSI3IAD8
         wYVPENg59tJwYwuUmWRCkbwudiotU0AwRiDER0vCiTe2jV6N8JFjY1Vq38tGHPYYcP
         0DiWiROsZJmQFJPcRsNB/2IgTOATcRnYLr2QU0/c=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20230215035254epcas2p209a722e9bf68a6b7c4d6a69d1bfa4c76~D4xcfvQ5E0362103621epcas2p2x;
        Wed, 15 Feb 2023 03:52:54 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.88]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4PGkgV1VkRz4x9Pv; Wed, 15 Feb
        2023 03:52:54 +0000 (GMT)
X-AuditID: b6c32a47-d47fe7000000e044-d5-63ec57163f09
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        E3.B8.57412.6175CE36; Wed, 15 Feb 2023 12:52:54 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH 6/6] arm64: dts: exynos: Add CMU_G3D node for Exynos850
 SoC
Reply-To: chanho61.park@samsung.com
Sender: CHANHO PARK <chanho61.park@samsung.com>
From:   CHANHO PARK <chanho61.park@samsung.com>
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     David Virag <virag.david003@gmail.com>,
        ALIM AKHTAR <alim.akhtar@samsung.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20230211064006.14981-7-semen.protsenko@linaro.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230215035253epcms2p5fae6ef12a139583311ec5a5395ae4048@epcms2p5>
Date:   Wed, 15 Feb 2023 12:52:53 +0900
X-CMS-MailID: 20230215035253epcms2p5fae6ef12a139583311ec5a5395ae4048
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFJsWRmVeSWpSXmKPExsWy7bCmma5Y+Jtkg6lv2C0ezNvGZnH9y3NW
        i/lHzrFa7H29ld1i0+NrrBYfe+6xWlzeNYfNYsb5fUwWF0+5WrTuPcJucfhNO6vFv2sbWSye
        9wHFT939zG6xatcfRovj7x8zOgh4vL/Ryu6xc9Zddo9NqzrZPO5c28PmsXlJvUffllWMHp83
        yQWwR2XbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gDd
        rqRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMC/QK07MLS7NS9fLSy2xMjQwMDIF
        KkzIzpj3cilTwXT+ir7WbqYGxtc8XYycHBICJhLN/xtYuxi5OIQEdjBK/L+wBMjh4OAVEJT4
        u0MYpEZYIFCi8+BudpCwkICyxMZtsRBhfYnv/U0sIDabgK7E/A+fwMaICNxnlNj99CsjiMMs
        cJxFYtbN44wQy3glZrQ/ZYGwpSW2L98KFucUcJCYvWUVVFxD4seyXmYIW1Ti5uq37DD2+2Pz
        oeaISLTeOwtVIyjx4OduRpDjJAQkJSa9iYAIB0g03Qc5CMTOkdhwcBIbhG0u8f3pfLBWXgFf
        iYd7usFGsgioSnTNuQh1govEw/uHwOLMAvIS29/OYQYZzyygKbF+lz7EJmWJI7dYICr4JDoO
        /2WHeXDHvCdMELa6xIHt06Emykp0z/kMdY2HxOcJ3ewTGBVnIcJ5FpJdsxB2LWBkXsUollpQ
        nJueWmxUYAyP2uT83E2M4ESs5b6DccbbD3qHGJk4GA8xSnAwK4nwCj99kSzEm5JYWZValB9f
        VJqTWnyI0RToy4nMUqLJ+cBckFcSb2hiaWBiZmZobmRqYK4kzittezJZSCA9sSQ1OzW1ILUI
        po+Jg1Oqgcm1KZJ7tZmVTXjzz186v+Yl/ZtX5xcXZrU5XNGkT2qqYOQcxcjelSsPZbY7JP1L
        X/pe2fKqSUBu+e5/i1yeda9Meqh61HZCS9mJ/JLXMS6PlRLSGnfekS+9pHi+d5KeReavzHLd
        Z29v9S+zVn4gZlM3ZcHML7XGEar9LBfl5J6sMMvvPcQ01/x2+Nsde14p8y9dof7Gfco+588V
        FdNjtQ89qTkUGfLJecHUq+aLdnRk7f4Tt272tX1n+ZTDn/9V+bTUufP7c2U1xvB/cQv3Xu7N
        v/XH6yCzo6Aw55HlV7OOz+hKP+pyZud+7u2iqyKiL+kol39gmlpiwP37Zq6alMPdh4JS2lef
        /S57zHHlqYQSS3FGoqEWc1FxIgCrlFsWTQQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230211063959epcas2p2500790b0402f151030ac65d405419649
References: <20230211064006.14981-7-semen.protsenko@linaro.org>
        <20230211064006.14981-1-semen.protsenko@linaro.org>
        <CGME20230211063959epcas2p2500790b0402f151030ac65d405419649@epcms2p5>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Sam Protsenko <semen.protsenko@linaro.org>
> Sent: Saturday, February 11, 2023 3:40 PM
> To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>; Chanwoo Choi
> <cw00.choi@samsung.com>; Sylwester Nawrocki <s.nawrocki@samsung.com>; Rob
> Herring <robh+dt@kernel.org>
> Cc: David Virag <virag.david003@gmail.com>; Chanho Park
> <chanho61.park@samsung.com>; Alim Akhtar <alim.akhtar@samsung.com>; Sumit
> Semwal <sumit.semwal@linaro.org>; Tomasz Figa <tomasz.figa@gmail.com>;
> Michael Turquette <mturquette@baylibre.com>; Stephen Boyd
> <sboyd@kernel.org>; linux-samsung-soc@vger.kernel.org; linux-
> clk@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: [PATCH 6/6] arm64: dts: exynos: Add CMU_G3D node for Exynos850
> SoC
> 
> Add missing G3D clock domain to Exynos850 SoC device tree.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>

Reviewed-by: Chanho Park <chanho61.park@samsung.com>

> ---
>  arch/arm64/boot/dts/exynos/exynos850.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/exynos/exynos850.dtsi
> b/arch/arm64/boot/dts/exynos/exynos850.dtsi
> index a38fe5129937..d67e98120313 100644
> --- a/arch/arm64/boot/dts/exynos/exynos850.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos850.dtsi
> @@ -245,6 +245,15 @@ cmu_peri: clock-controller@10030000 {
>  				      "dout_peri_uart", "dout_peri_ip";
>  		};
> 
> +		cmu_g3d: clock-controller@11400000 {
> +			compatible = "samsung,exynos850-cmu-g3d";
> +			reg = <0x11400000 0x8000>;
> +			#clock-cells = <1>;
> +
> +			clocks = <&oscclk>, <&cmu_top CLK_DOUT_G3D_SWITCH>;
> +			clock-names = "oscclk", "dout_g3d_switch";
> +		};
> +
>  		cmu_apm: clock-controller@11800000 {
>  			compatible = "samsung,exynos850-cmu-apm";
>  			reg = <0x11800000 0x8000>;
> --
> 2.39.1
