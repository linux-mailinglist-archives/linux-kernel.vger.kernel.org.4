Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A53069747D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 03:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbjBOClE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 21:41:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbjBOClB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 21:41:01 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0EDC32531
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 18:40:59 -0800 (PST)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230215024058epoutp01fc6f16f0e8bf9864000d72aa74ec4e5f~D3yoi6pWq1136211362epoutp01S
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 02:40:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230215024058epoutp01fc6f16f0e8bf9864000d72aa74ec4e5f~D3yoi6pWq1136211362epoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1676428858;
        bh=dTVvHi0PSXlkaiJ8xKjPGGmEQywwSouz1POMk3kJ7r0=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=WcV7Iml3cQBk2xdmTt6DKzB3N0LqofAzcL9i439ju/04/YHetnE1C61dN9seGUcrw
         /9whdyays8TxroKYRlVAwUDIp7skn99keWSJ8XaYRl9PkCRWlQYyWuICfew65E/fk3
         lv3ShItg5ADep07USFNYOPxSjWR80w1pw0VrZzxQ=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20230215024057epcas2p4cdedf47d18e6c9c14f9b2d02758c9e28~D3yoJfhBG1328813288epcas2p4-;
        Wed, 15 Feb 2023 02:40:57 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.102]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4PGj4T2nY2z4x9Q2; Wed, 15 Feb
        2023 02:40:57 +0000 (GMT)
X-AuditID: b6c32a46-4e1ff70000007a4b-35-63ec4639b2d7
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        A6.70.31307.9364CE36; Wed, 15 Feb 2023 11:40:57 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH 5/6] clk: samsung: exynos850: Add AUD and HSI main gate
 clocks
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
In-Reply-To: <20230211064006.14981-6-semen.protsenko@linaro.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230215024056epcms2p28f04cf946f20343643faca944ea147ea@epcms2p2>
Date:   Wed, 15 Feb 2023 11:40:56 +0900
X-CMS-MailID: 20230215024056epcms2p28f04cf946f20343643faca944ea147ea
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJJsWRmVeSWpSXmKPExsWy7bCmua6l25tkg9X/eSwezNvGZnH9y3NW
        i/lHzrFa7H29ld1i0+NrrBYfe+6xWlzeNYfNYsb5fUwWF0+5WrTuPcJucfhNO6vFv2sbWSye
        9wHFT939zG6xatcfRovj7x8zOgh4vL/Ryu6xc9Zddo9NqzrZPO5c28PmsXlJvUffllWMHp83
        yQWwR2XbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gDd
        rqRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMC/QK07MLS7NS9fLSy2xMjQwMDIF
        KkzIzng05SNTwVr9iluvrrM3MF7U6GLk5JAQMJHo27OEqYuRi0NIYAejxOlPL9m6GDk4eAUE
        Jf7uEAapERYIkfj38QojSFhIQFli47ZYiLC+xPf+JhYQm01AV2L+h0+sIGNEBO4zSux++pUR
        xGEWOM4iMevmcUaIZbwSM9qfskDY0hLbl28Fi3MKOEhMuN7BDhHXkPixrJcZwhaVuLn6LTuM
        /f7YfKg5IhKt985C1QhKPPi5G+w4CQFJiUlvIiDCARJN90EOArFzJDYcnMQGYZtLfH86H6yV
        V8BX4uniBUwgNouAqsSLHTdZIca4SFzqcQYJMwvIS2x/O4cZJMwsoCmxfpc+RIWyxJFbLBAV
        fBIdh/+yw/y3Y94TJghbXeLA9ulQv8pKdM/5DHWMh0TH7L/sExgVZyGCeRaSXbMQdi1gZF7F
        KJZaUJybnlpsVGAEj9nk/NxNjOA0rOW2g3HK2w96hxiZOBgPMUpwMCuJ8Ao/fZEsxJuSWFmV
        WpQfX1Sak1p8iNEU6MmJzFKiyfnATJBXEm9oYmlgYmZmaG5kamCuJM4rbXsyWUggPbEkNTs1
        tSC1CKaPiYNTqoFJfkaPzb/Dv3SZzxR81CpdYKw258jWDVf3fb3z+sclfdW2wp1vlu4viBHR
        6lid5HB/p7+77ZP9TTwOL559kzETmKApFM7Q52TZl5i34XiDwTVzxcOv779ZKaiinuHrqag2
        Y6PelZmsM+LO/VpmsdtdTHei2+nw6U633yrOZOJpPMX4s/X7TlP9Gb+aBHPZGgRuT66e3hr4
        /MNJ9iRp9U9T0+otuquXrm9R7tDYKbbAZ++fjQeOlq/2v+WUzXXWb6XsyRPi8ifKGba8VDwn
        doH9hNu6331Pb07scDO1Ubfd3L3+qInNvsPM5yJmPjVZuijX+YRcZ1Py/ruJTL7PTgs33j3x
        nIXrxOttBXUCsZMqlViKMxINtZiLihMBEtTJwkwEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230211063956epcas2p423cb99655dcfdb34c6847bb228aa7324
References: <20230211064006.14981-6-semen.protsenko@linaro.org>
        <20230211064006.14981-1-semen.protsenko@linaro.org>
        <CGME20230211063956epcas2p423cb99655dcfdb34c6847bb228aa7324@epcms2p2>
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
> Subject: [PATCH 5/6] clk: samsung: exynos850: Add AUD and HSI main gate
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
> ---
>  drivers/clk/samsung/clk-exynos850.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/clk/samsung/clk-exynos850.c
> b/drivers/clk/samsung/clk-exynos850.c
> index a24eff42baae..3d776d57cc8f 100644
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
> "dout_aud_cpu_aclk", @@ -1117,12 +1122,15 @@ static const struct
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
> @@ -1132,12 +1140,15 @@ static const unsigned long hsi_clk_regs[]
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
> @@ -1163,6 +1174,9 @@ static const struct samsung_mux_clock hsi_mux_clks[]
> __initconst = {  };
> 
>  static const struct samsung_gate_clock hsi_gate_clks[] __initconst = {
> +	GATE(CLK_GOUT_HSI_CMU_HSI_PCLK, "gout_hsi_cmu_hsi_pclk",
> +	     "mout_hsi_bus_user",
> +	     CLK_CON_GAT_CLK_HSI_CMU_HSI_PCLK, 21, CLK_IGNORE_UNUSED, 0),

You'll need to put /* TODO: */ tag or use CLK_IS_CRITICAL if you make sure it is the critical clock.

>  	GATE(CLK_GOUT_USB_RTC_CLK, "gout_usb_rtc", "mout_hsi_rtc",
>  	     CLK_CON_GAT_HSI_USB20DRD_TOP_I_RTC_CLK__ALV, 21, 0, 0),
>  	GATE(CLK_GOUT_USB_REF_CLK, "gout_usb_ref", "mout_hsi_usb20drd_user",
> @@ -1177,6 +1191,10 @@ static const struct samsung_gate_clock
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
