Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0393B6A39E3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 04:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjB0D5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 22:57:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjB0D5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 22:57:01 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111C91E1FE
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 19:56:29 -0800 (PST)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230227035621epoutp014a8df1f3a0fe72527cd42fe49e85a0cb~Hkj34YAms1960119601epoutp01T
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 03:56:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230227035621epoutp014a8df1f3a0fe72527cd42fe49e85a0cb~Hkj34YAms1960119601epoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677470181;
        bh=O3yMs7/UanLc4TbZp0s6QYMPIuSJFIHEjD7r8qj2KRA=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=n4KrTTC19hbbfgaGqZwXPt/5BU00hdNGyG06aS9GGgMPILSOCyD5k4K0v7wtdjxHn
         mcUwU67ck569AMJnrFlNqyURG78C3A7A6gJLoMN2A6U7/eDR0txzQr9gXWAq2lDpTC
         L7dHPNiFr3+kY27MU0PCuBMCYfRqbLg7vtXsYiJA=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230227035620epcas2p3ad969b5b279ce460ef1b2084bebf696d~Hkj3Wl5UL2802828028epcas2p3R;
        Mon, 27 Feb 2023 03:56:20 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.90]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4PQ69v5tKxz4x9Q1; Mon, 27 Feb
        2023 03:56:19 +0000 (GMT)
X-AuditID: b6c32a48-1f7ff70000021624-5f-63fc29e3c67c
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        34.78.05668.3E92CF36; Mon, 27 Feb 2023 12:56:19 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH v2 5/6] clk: samsung: exynos850: Add AUD and HSI main
 gate clocks
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
In-Reply-To: <20230223042133.26551-6-semen.protsenko@linaro.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230227035619epcms2p5aeb63759aa2c9fd40eabf6dd70f2e95f@epcms2p5>
Date:   Mon, 27 Feb 2023 12:56:19 +0900
X-CMS-MailID: 20230227035619epcms2p5aeb63759aa2c9fd40eabf6dd70f2e95f
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFJsWRmVeSWpSXmKPExsWy7bCmhe5jzT/JBhMO6Fg8mLeNzeL6l+es
        FvOPnGO12Pt6K7vFpsfXWC0+9txjtbi8aw6bxYzz+5gsLp5ytWjde4Td4vCbdlaLf9c2slg8
        7wOKn7r7md1i1a4/jBbH3z9mdBDweH+jld1j56y77B6bVnWyedy5tofNY/OSeo++LasYPT5v
        kgtgj8q2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAG6
        XUmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYF6gV5yYW1yal66Xl1piZWhgYGQK
        VJiQnfF0ax9LwQGDivvrFrI2MB7X7GLk5JAQMJFYuOsOWxcjF4eQwA5GickzG1m7GDk4eAUE
        Jf7uEAapERYIl5h7ZDo7SFhIQFli47ZYiLC+xPf+JhYQm01AV2L+h0+sIGNEBO4zSux++pUR
        xGEWOM4iMevmcUaIZbwSM9qfskDY0hLbl28Fi3MKOEjc7VnMBBHXkPixrJcZwhaVuLn6LTuM
        /f7YfKg5IhKt985C1QhKPPi5mxHkOAkBSYlJbyIgwgESTfdBDgKxcyQ2HJzEBmGbS3x/Oh+s
        lVfAV+LJg5Ng57AIqEq8+XIDaryLxLzHv8DWMgvIS2x/O4cZZDyzgKbE+l36EJuUJY7cYoGo
        4JPoOPyXHebBHfOeQD2iLnFg+3SoZ2Uluud8hrrGQ6Lr7WWmCYyKsxDhPAvJrlkIuxYwMq9i
        FEstKM5NTy02KjCBR21yfu4mRnAi1vLYwTj77Qe9Q4xMHIyHGCU4mJVEeO+c/JEsxJuSWFmV
        WpQfX1Sak1p8iNEU6MuJzFKiyfnAXJBXEm9oYmlgYmZmaG5kamCuJM4rbXsyWUggPbEkNTs1
        tSC1CKaPiYNTqoFprqWY/dnL9e9NpjMtST8jdO+dX1S8tcQ7uUXnUyxXsqco//6x77nOpGOx
        YQb7f35dvWnbrGma3+ViVuT2Sx968bFF9c6labJGp5n3rtnadbrZ1+Byxdxlf5ZeTl7i+WLv
        xb8Suw81urAsPZm2/0sUg6K857S/O+5XKd+WKdPdfy+wdKbqUdvjtYzJK0/zX+2ftEExsPmy
        nZ36n20bhdae3Trr5apbgiqHC97VNicmrJ7Jv7f5ds6daQ0e1y1t1CqaHgdcVZ5oEJN7acEM
        56XHjm4PvXjIpHrttb1/BC93fDskeT8y9duJf3WfIj89+GiYP2FStdvW69V/eNbx9BX4Bgrv
        msmnnCwYLbTkovuOO/FKLMUZiYZazEXFiQAo096ITQQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230223042126epcas2p11c50a7be714a7f305d743faa68dee3ca
References: <20230223042133.26551-6-semen.protsenko@linaro.org>
        <20230223042133.26551-1-semen.protsenko@linaro.org>
        <CGME20230223042126epcas2p11c50a7be714a7f305d743faa68dee3ca@epcms2p5>
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
> Sent: Thursday, February 23, 2023 1:22 PM
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
> Subject: [PATCH v2 5/6] clk: samsung: exynos850: Add AUD and HSI main gate
> clocks
> 
> Add main gate clocks for controlling AUD and HSI CMUs:
>   - gout_aud_cmu_aud_pclk
>   - gout_hsi_cmu_hsi_pclk
> 
> Those clocks were marked as CLK_IGNORE_UNUSED, as system hangs on boot
> otherwise.
> 
> While at it, add missing PPMU (Performance Profiling Monitor Unit) clocks
> for CMU_HSI.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>

Reviewed-by: Chanho Park <chanho61.park@samsung.com>

> ---
> Changes in v2:
>   - Rebased on top of most recent soc/for-next tree
>   - Added comment for CLK_IGNORE_UNUSED flag usage
> 
>  drivers/clk/samsung/clk-exynos850.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/clk/samsung/clk-exynos850.c
> b/drivers/clk/samsung/clk-exynos850.c
> index 601fe05e8555..6ab5fa8c2ef3 100644
> --- a/drivers/clk/samsung/clk-exynos850.c
> +++ b/drivers/clk/samsung/clk-exynos850.c
> @@ -674,6 +674,7 @@ static const struct samsung_cmu_info apm_cmu_info
> __initconst = {
>  #define CLK_CON_GAT_GOUT_AUD_ABOX_BCLK_UAIF4	0x2014
>  #define CLK_CON_GAT_GOUT_AUD_ABOX_BCLK_UAIF5	0x2018
>  #define CLK_CON_GAT_GOUT_AUD_ABOX_BCLK_UAIF6	0x201c
> +#define CLK_CON_GAT_CLK_AUD_CMU_AUD_PCLK	0x2020
>  #define CLK_CON_GAT_GOUT_AUD_ABOX_ACLK		0x2048
>  #define CLK_CON_GAT_GOUT_AUD_ABOX_BCLK_SPDY	0x204c
>  #define CLK_CON_GAT_GOUT_AUD_ABOX_CCLK_ASB	0x2050
> @@ -729,6 +730,7 @@ static const unsigned long aud_clk_regs[] __initconst
> = {
>  	CLK_CON_GAT_GOUT_AUD_ABOX_BCLK_UAIF4,
>  	CLK_CON_GAT_GOUT_AUD_ABOX_BCLK_UAIF5,
>  	CLK_CON_GAT_GOUT_AUD_ABOX_BCLK_UAIF6,
> +	CLK_CON_GAT_CLK_AUD_CMU_AUD_PCLK,
>  	CLK_CON_GAT_GOUT_AUD_ABOX_ACLK,
>  	CLK_CON_GAT_GOUT_AUD_ABOX_BCLK_SPDY,
>  	CLK_CON_GAT_GOUT_AUD_ABOX_CCLK_ASB,
> @@ -848,6 +850,9 @@ static const struct samsung_div_clock aud_div_clks[]
> __initconst = {  };
> 
>  static const struct samsung_gate_clock aud_gate_clks[] __initconst = {
> +	GATE(CLK_GOUT_AUD_CMU_AUD_PCLK, "gout_aud_cmu_aud_pclk",
> +	     "dout_aud_busd",
> +	     CLK_CON_GAT_CLK_AUD_CMU_AUD_PCLK, 21, CLK_IGNORE_UNUSED, 0),
>  	GATE(CLK_GOUT_AUD_CA32_CCLK, "gout_aud_ca32_cclk",
> "mout_aud_cpu_hch",
>  	     CLK_CON_GAT_GOUT_AUD_ABOX_CCLK_CA32, 21, 0, 0),
>  	GATE(CLK_GOUT_AUD_ASB_CCLK, "gout_aud_asb_cclk",
> "dout_aud_cpu_aclk", @@ -1116,12 +1121,15 @@ static const struct
> samsung_cmu_info g3d_cmu_info __initconst = {
>  #define PLL_CON0_MUX_CLKCMU_HSI_MMC_CARD_USER			0x0610
>  #define PLL_CON0_MUX_CLKCMU_HSI_USB20DRD_USER			0x0620
>  #define CLK_CON_MUX_MUX_CLK_HSI_RTC				0x1000
> +#define CLK_CON_GAT_CLK_HSI_CMU_HSI_PCLK			0x2000
>  #define CLK_CON_GAT_HSI_USB20DRD_TOP_I_RTC_CLK__ALV		0x2008
>  #define CLK_CON_GAT_HSI_USB20DRD_TOP_I_REF_CLK_50		0x200c
>  #define CLK_CON_GAT_HSI_USB20DRD_TOP_I_PHY_REFCLK_26		0x2010
>  #define CLK_CON_GAT_GOUT_HSI_GPIO_HSI_PCLK			0x2018
>  #define CLK_CON_GAT_GOUT_HSI_MMC_CARD_I_ACLK			0x2024
>  #define CLK_CON_GAT_GOUT_HSI_MMC_CARD_SDCLKIN			0x2028
> +#define CLK_CON_GAT_GOUT_HSI_PPMU_ACLK				0x202c
> +#define CLK_CON_GAT_GOUT_HSI_PPMU_PCLK				0x2030
>  #define CLK_CON_GAT_GOUT_HSI_SYSREG_HSI_PCLK			0x2038
>  #define CLK_CON_GAT_GOUT_HSI_USB20DRD_TOP_ACLK_PHYCTRL_20	0x203c
>  #define CLK_CON_GAT_GOUT_HSI_USB20DRD_TOP_BUS_CLK_EARLY		0x2040
> @@ -1131,12 +1139,15 @@ static const unsigned long hsi_clk_regs[]
> __initconst = {
>  	PLL_CON0_MUX_CLKCMU_HSI_MMC_CARD_USER,
>  	PLL_CON0_MUX_CLKCMU_HSI_USB20DRD_USER,
>  	CLK_CON_MUX_MUX_CLK_HSI_RTC,
> +	CLK_CON_GAT_CLK_HSI_CMU_HSI_PCLK,
>  	CLK_CON_GAT_HSI_USB20DRD_TOP_I_RTC_CLK__ALV,
>  	CLK_CON_GAT_HSI_USB20DRD_TOP_I_REF_CLK_50,
>  	CLK_CON_GAT_HSI_USB20DRD_TOP_I_PHY_REFCLK_26,
>  	CLK_CON_GAT_GOUT_HSI_GPIO_HSI_PCLK,
>  	CLK_CON_GAT_GOUT_HSI_MMC_CARD_I_ACLK,
>  	CLK_CON_GAT_GOUT_HSI_MMC_CARD_SDCLKIN,
> +	CLK_CON_GAT_GOUT_HSI_PPMU_ACLK,
> +	CLK_CON_GAT_GOUT_HSI_PPMU_PCLK,
>  	CLK_CON_GAT_GOUT_HSI_SYSREG_HSI_PCLK,
>  	CLK_CON_GAT_GOUT_HSI_USB20DRD_TOP_ACLK_PHYCTRL_20,
>  	CLK_CON_GAT_GOUT_HSI_USB20DRD_TOP_BUS_CLK_EARLY,
> @@ -1162,6 +1173,10 @@ static const struct samsung_mux_clock hsi_mux_clks[]
> __initconst = {  };
> 
>  static const struct samsung_gate_clock hsi_gate_clks[] __initconst = {
> +	/* TODO: Should be enabled in corresponding driver */
> +	GATE(CLK_GOUT_HSI_CMU_HSI_PCLK, "gout_hsi_cmu_hsi_pclk",
> +	     "mout_hsi_bus_user",
> +	     CLK_CON_GAT_CLK_HSI_CMU_HSI_PCLK, 21, CLK_IGNORE_UNUSED, 0),
>  	GATE(CLK_GOUT_USB_RTC_CLK, "gout_usb_rtc", "mout_hsi_rtc",
>  	     CLK_CON_GAT_HSI_USB20DRD_TOP_I_RTC_CLK__ALV, 21, 0, 0),
>  	GATE(CLK_GOUT_USB_REF_CLK, "gout_usb_ref", "mout_hsi_usb20drd_user",
> @@ -1176,6 +1191,10 @@ static const struct samsung_gate_clock
> hsi_gate_clks[] __initconst = {
>  	GATE(CLK_GOUT_MMC_CARD_SDCLKIN, "gout_mmc_card_sdclkin",
>  	     "mout_hsi_mmc_card_user",
>  	     CLK_CON_GAT_GOUT_HSI_MMC_CARD_SDCLKIN, 21, CLK_SET_RATE_PARENT,
> 0),
> +	GATE(CLK_GOUT_HSI_PPMU_ACLK, "gout_hsi_ppmu_aclk",
> "mout_hsi_bus_user",
> +	     CLK_CON_GAT_GOUT_HSI_PPMU_ACLK, 21, 0, 0),
> +	GATE(CLK_GOUT_HSI_PPMU_PCLK, "gout_hsi_ppmu_pclk",
> "mout_hsi_bus_user",
> +	     CLK_CON_GAT_GOUT_HSI_PPMU_PCLK, 21, 0, 0),
>  	GATE(CLK_GOUT_SYSREG_HSI_PCLK, "gout_sysreg_hsi_pclk",
>  	     "mout_hsi_bus_user",
>  	     CLK_CON_GAT_GOUT_HSI_SYSREG_HSI_PCLK, 21, 0, 0),
> --
> 2.39.1
