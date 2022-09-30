Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD46A5F09D7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 13:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiI3LRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 07:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbiI3LQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 07:16:48 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D257A6AC3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 04:00:22 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id i26so6286024lfp.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 04:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=KRFSOkeS1Ap09O1yWo21pxUPyzsRWzytfx0rE00U7c4=;
        b=lALc84Qm64HVS6ylE8OGL/yahgyStULfD0Ade5NLYuvmCJGrF2YiJfqddBujo8OVLY
         V/OVSvF08b5owvnPoAku0X3aDYQae3NnOd+//jYMPrwudmsehkO7OP8ndB6ieOrW9EsA
         6gd67/hEGfF2cjEC3v2GJc9/LM7VG20RNcrWvMRFIan2ITZdDWzBIqc6b9br89Z0vRdR
         ltH2BjSPztf2YndG0yRtTN2TnqFnz/gHvm6A5I3Uc+m276Xn8NHB8fpnPGuMOKG8qHHE
         MfIa6tlOnbFQrEECbvZ5K3HwL6cD3bJHnAPCcyWSbg13KDSMUtmXV3sDp6qOkRy1uNEc
         QF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=KRFSOkeS1Ap09O1yWo21pxUPyzsRWzytfx0rE00U7c4=;
        b=t318+6tktQkZ3a6KlUowIjyapEH/1cVZq2LK4EEPBWiSsQmjqZ64L7Es+da1nLqBMa
         5V3CYCee3XC+V5XAzCQX5obCfsaLMhfZgGqmaUEY+xS6ga6HGrLOsw+ZL2QEeQ+Pz4ZZ
         S4lRY3i+UeYrzGQz2/bPMA4j3gqjOjJY6Jbf0B+eywNViTDp/HaR58/Mn9GjFRAAOEXz
         M7jSP0rOWN4CETtc5y/7ZPY/6MqJFD32z/gUvBVAQht0sdoTi6MwmmL+vxAdFBCgjBBi
         5X1b3O+7aCeeBmRtzLv1c3M8xTroYfZ3r5Sq/HBsq394a5zpvNj6oJjKyMWktnMyOShe
         ZGCw==
X-Gm-Message-State: ACrzQf04P4cGjpdyb1h4E5mpahEYtyKzFyHiu7GsaMQZ9eM4LBFaZZVx
        S/SGuz8DbwJ3qA7/IojHTKLXGA==
X-Google-Smtp-Source: AMsMyM7zkKqHeOBVzmUngk+dhMlsFAmQbQhsGqLwVAwCQ6cHYvMmA/s7+R4gMG/gkCytWbI3/3uEFg==
X-Received: by 2002:a05:6512:312a:b0:498:f5d4:52fa with SMTP id p10-20020a056512312a00b00498f5d452famr3292214lfd.311.1664535620749;
        Fri, 30 Sep 2022 04:00:20 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id bi30-20020a0565120e9e00b004948497e07esm267763lfb.15.2022.09.30.04.00.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 04:00:20 -0700 (PDT)
Message-ID: <b70b4fc4-5d55-135c-17c4-6d65e386378e@linaro.org>
Date:   Fri, 30 Sep 2022 13:00:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v1 24/30] dt-bindings: pinctrl: Add StarFive JH7110
 pinctrl definitions
Content-Language: en-US
To:     Hal Feng <hal.feng@linux.starfivetech.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        linux-kernel@vger.kernel.org
References: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
 <20220930073328.6204-1-hal.feng@linux.starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220930073328.6204-1-hal.feng@linux.starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/09/2022 09:33, Hal Feng wrote:
> From: Jianlong Huang <jianlong.huang@starfivetech.com>
> 
> Add pinctrl definitions for StarFive JH7110 SoC.
> 
> Signed-off-by: Jianlong Huang <jianlong.huang@starfivetech.com>
> Signed-off-by: Hal Feng <hal.feng@linux.starfivetech.com>
> ---
>  .../pinctrl/pinctrl-starfive-jh7110.h         | 931 ++++++++++++++++++
>  1 file changed, 931 insertions(+)
>  create mode 100644 include/dt-bindings/pinctrl/pinctrl-starfive-jh7110.h
> 
> diff --git a/include/dt-bindings/pinctrl/pinctrl-starfive-jh7110.h b/include/dt-bindings/pinctrl/pinctrl-starfive-jh7110.h
> new file mode 100644
> index 000000000000..159cfcf6b915
> --- /dev/null
> +++ b/include/dt-bindings/pinctrl/pinctrl-starfive-jh7110.h
> @@ -0,0 +1,931 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR MIT */
> +/*
> + * Copyright (C) 2022 StarFive Technology Co., Ltd.
> + */
> +
> +#ifndef __DT_BINDINGS_PINCTRL_STARFIVE_JH7110_H__
> +#define __DT_BINDINGS_PINCTRL_STARFIVE_JH7110_H__
> +
> +/* aon_iomux pin */
> +#define	PAD_TESTEN	0
> +#define	PAD_RGPIO0	1
> +#define	PAD_RGPIO1	2
> +#define	PAD_RGPIO2	3
> +#define	PAD_RGPIO3	4
> +#define	PAD_RSTN	5
> +#define	PAD_GMAC0_MDC	6
> +#define	PAD_GMAC0_MDIO	7
> +#define	PAD_GMAC0_RXD0	8
> +#define	PAD_GMAC0_RXD1	9
> +#define	PAD_GMAC0_RXD2	10
> +#define	PAD_GMAC0_RXD3	11
> +#define	PAD_GMAC0_RXDV	12
> +#define	PAD_GMAC0_RXC	13
> +#define	PAD_GMAC0_TXD0	14
> +#define	PAD_GMAC0_TXD1	15
> +#define	PAD_GMAC0_TXD2	16
> +#define	PAD_GMAC0_TXD3	17
> +#define	PAD_GMAC0_TXEN	18
> +#define	PAD_GMAC0_TXC	19
> +
> +/* aon_iomux dout */
> +#define GPO_AON_CLK_32K_OUT		2
> +#define GPO_AON_PTC0_PWM4		3
> +#define GPO_AON_PTC0_PWM5		4
> +#define GPO_AON_PTC0_PWM6		5
> +#define GPO_AON_PTC0_PWM7		6
> +#define GPO_AON_CLK_GCLK0		7
> +#define GPO_AON_CLK_GCLK1		8
> +#define GPO_AON_CLK_GCLK2		9
> +
> +/* aon_iomux doen */
> +#define OEN_AON_PTC0_OE_N_4		2
> +#define OEN_AON_PTC0_OE_N_5		3
> +#define OEN_AON_PTC0_OE_N_6		4
> +#define OEN_AON_PTC0_OE_N_7		5
> +
> +/* aon_iomux gin */
> +#define GPI_AON_PMU_GPIO_WAKEUP_0	0
> +#define GPI_AON_PMU_GPIO_WAKEUP_1	1
> +#define GPI_AON_PMU_GPIO_WAKEUP_2	2
> +#define GPI_AON_PMU_GPIO_WAKEUP_3	3
> +
> +/* aon_iomux gmac0 syscon */
> +#define PADCFG_PAD_GMAC0_MDC_SYSCON	0x58
> +#define PADCFG_PAD_GMAC0_MDIO_SYSCON	0x5c
> +#define PADCFG_PAD_GMAC0_RXD0_SYSCON	0x60
> +#define PADCFG_PAD_GMAC0_RXD1_SYSCON	0x64
> +#define PADCFG_PAD_GMAC0_RXD2_SYSCON	0x68
> +#define PADCFG_PAD_GMAC0_RXD3_SYSCON	0x6c
> +#define PADCFG_PAD_GMAC0_RXDV_SYSCON	0x70
> +#define PADCFG_PAD_GMAC0_RXC_SYSCON	0x74
> +#define PADCFG_PAD_GMAC0_TXD0_SYSCON	0x78
> +#define PADCFG_PAD_GMAC0_TXD1_SYSCON	0x7c
> +#define PADCFG_PAD_GMAC0_TXD2_SYSCON	0x80
> +#define PADCFG_PAD_GMAC0_TXD3_SYSCON	0x84
> +#define PADCFG_PAD_GMAC0_TXEN_SYSCON	0x88
> +#define PADCFG_PAD_GMAC0_TXC_SYSCON	0x8c

Register values do not belong to bindings. D

> +
> +/* aon_iomux func sel */
> +#define AON_IOMUX_CFGSAIF_144_ADDR	0x90
> +#define PAD_GMAC0_RXC_FUNC_SEL_SHIFT	0x0
> +#define PAD_GMAC0_RXC_FUNC_SEL_MASK	0x3

Register values do not belong to bindings. D

> +
> +#define PAD_GMAC0_RXC_FUNC_SEL		\
> +	AON_IOMUX_CFGSAIF_144_ADDR	\
> +	PAD_GMAC0_RXC_FUNC_SEL_SHIFT	\
> +	PAD_GMAC0_RXC_FUNC_SEL_MASK
> +
> +/* sys_iomux pin */
> +#define	PAD_GPIO0	0
> +#define	PAD_GPIO1	1
> +#define	PAD_GPIO2	2
> +#define	PAD_GPIO3	3
> +#define	PAD_GPIO4	4
> +#define	PAD_GPIO5	5
> +#define	PAD_GPIO6	6
> +#define	PAD_GPIO7	7
> +#define	PAD_GPIO8	8
> +#define	PAD_GPIO9	9
> +#define	PAD_GPIO10	10
> +#define	PAD_GPIO11	11
> +#define	PAD_GPIO12	12
> +#define	PAD_GPIO13	13
> +#define	PAD_GPIO14	14
> +#define	PAD_GPIO15	15
> +#define	PAD_GPIO16	16
> +#define	PAD_GPIO17	17
> +#define	PAD_GPIO18	18
> +#define	PAD_GPIO19	19
> +#define	PAD_GPIO20	20
> +#define	PAD_GPIO21	21
> +#define	PAD_GPIO22	22
> +#define	PAD_GPIO23	23
> +#define	PAD_GPIO24	24
> +#define	PAD_GPIO25	25
> +#define	PAD_GPIO26	26
> +#define	PAD_GPIO27	27
> +#define	PAD_GPIO28	28
> +#define	PAD_GPIO29	29
> +#define	PAD_GPIO30	30
> +#define	PAD_GPIO31	31
> +#define	PAD_GPIO32	32
> +#define	PAD_GPIO33	33
> +#define	PAD_GPIO34	34
> +#define	PAD_GPIO35	35
> +#define	PAD_GPIO36	36
> +#define	PAD_GPIO37	37
> +#define	PAD_GPIO38	38
> +#define	PAD_GPIO39	39
> +#define	PAD_GPIO40	40
> +#define	PAD_GPIO41	41
> +#define	PAD_GPIO42	42
> +#define	PAD_GPIO43	43
> +#define	PAD_GPIO44	44
> +#define	PAD_GPIO45	45
> +#define	PAD_GPIO46	46
> +#define	PAD_GPIO47	47
> +#define	PAD_GPIO48	48
> +#define	PAD_GPIO49	49
> +#define	PAD_GPIO50	50
> +#define	PAD_GPIO51	51
> +#define	PAD_GPIO52	52
> +#define	PAD_GPIO53	53
> +#define	PAD_GPIO54	54
> +#define	PAD_GPIO55	55
> +#define	PAD_GPIO56	56
> +#define	PAD_GPIO57	57
> +#define	PAD_GPIO58	58
> +#define	PAD_GPIO59	59
> +#define	PAD_GPIO60	60
> +#define	PAD_GPIO61	61
> +#define	PAD_GPIO62	62
> +#define	PAD_GPIO63	63
> +#define	PAD_SD0_CLK	64
> +#define	PAD_SD0_CMD	65
> +#define	PAD_SD0_DATA0	66
> +#define	PAD_SD0_DATA1	67
> +#define	PAD_SD0_DATA2	68
> +#define	PAD_SD0_DATA3	69
> +#define	PAD_SD0_DATA4	70
> +#define	PAD_SD0_DATA5	71
> +#define	PAD_SD0_DATA6	72
> +#define	PAD_SD0_DATA7	73
> +#define	PAD_SD0_STRB	74
> +#define	PAD_GMAC1_MDC	75
> +#define	PAD_GMAC1_MDIO	76
> +#define	PAD_GMAC1_RXD0	77
> +#define	PAD_GMAC1_RXD1	78
> +#define	PAD_GMAC1_RXD2	79
> +#define	PAD_GMAC1_RXD3	80
> +#define	PAD_GMAC1_RXDV	81
> +#define	PAD_GMAC1_RXC	82
> +#define	PAD_GMAC1_TXD0	83
> +#define	PAD_GMAC1_TXD1	84
> +#define	PAD_GMAC1_TXD2	85
> +#define	PAD_GMAC1_TXD3	86
> +#define	PAD_GMAC1_TXEN	87
> +#define	PAD_GMAC1_TXC	88
> +#define	PAD_QSPI_SCLK	89
> +#define	PAD_QSPI_CSn0	90
> +#define	PAD_QSPI_DATA0	91
> +#define	PAD_QSPI_DATA1	92
> +#define	PAD_QSPI_DATA2	93
> +#define	PAD_QSPI_DATA3	94
> +
> +#define GPO_LOW					0
> +#define GPO_HIGH				1
> +#define GPO_WAVE511_0_O_UART_TXSOUT		2
> +#define GPO_CAN0_CTRL_STBY			3
> +#define GPO_CAN0_CTRL_TST_NEXT_BIT		4
> +#define GPO_CAN0_CTRL_TST_SAMPLE_POINT		5
> +#define GPO_CAN0_CTRL_TXD			6
> +#define GPO_USB0_DRIVE_VBUS_IO			7
> +#define GPO_QSPI0_CSN1				8
> +#define GPO_SPDIF0_SPDIFO			9
> +#define GPO_HDMI0_CEC_SDA_OUT			10
> +#define GPO_HDMI0_DDC_SCL_OUT			11
> +#define GPO_HDMI0_DDC_SDA_OUT			12
> +#define GPO_WDT0_WDOGRES			13
> +#define GPO_I2C0_IC_CLK_OUT_A			14
> +#define GPO_I2C0_IC_DATA_OUT_A			15
> +#define GPO_SDIO0_BACK_END_POWER		16
> +#define GPO_SDIO0_CARD_POWER_EN			17
> +#define GPO_SDIO0_CCMD_OD_PULLUP_EN_N		18
> +#define GPO_SDIO0_RST_N				19
> +#define GPO_UART0_SOUT				20
> +#define GPO_JTAG_DSP_TDO			21
> +#define GPO_JTAG_CPU_CERTIFICATION_TDO		22
> +#define GPO_PDM_4MIC0_DMIC_MCLK			23
> +#define GPO_PTC0_PWM_0				24
> +#define GPO_PTC0_PWM_1				25
> +#define GPO_PTC0_PWM_2				26
> +#define GPO_PTC0_PWM_3				27
> +#define GPO_PWMDAC0_LEFT_OUTPUT			28
> +#define GPO_PWMDAC0_RIGHT_OUTPUT		29
> +#define GPO_SPI0_SSPCLKOUT			30
> +#define GPO_SPI0_SSPFSSOUT			31
> +#define GPO_SPI0_SSPTXD				32
> +#define GPO_GMAC0_CLK_PHY			33
> +#define GPO_I2SRX0_BCLK_MST			34
> +#define GPO_I2SRX0_LRCK_MST			35
> +#define GPO_I2STX0_BCLK_MST			36
> +#define GPO_I2STX0_LRCK_MST			37
> +#define GPO_CRG0_MCLK_OUT			38
> +#define GPO_TDM0_CLK_MST			39
> +#define GPO_TDM0_PCM_SYNCOUT			40
> +#define GPO_TDM0_PCM_TXD			41
> +#define GPO_U7MC_TRACE0_TDATA_0			42
> +#define GPO_U7MC_TRACE0_TDATA_1			43
> +#define GPO_U7MC_TRACE0_TDATA_2			44
> +#define GPO_U7MC_TRACE0_TDATA_3			45
> +#define GPO_U7MC_TRACE0_TREF			46
> +#define GPO_CAN1_CTRL_STBY			47
> +#define GPO_CAN1_CTRL_TST_NEXT_BIT		48
> +#define GPO_CAN1_CTRL_TST_SAMPLE_POINT		49
> +#define GPO_CAN1_CTRL_TXD			50
> +#define GPO_I2C1_IC_CLK_OUT_A			51
> +#define GPO_I2C1_IC_DATA_OUT_A			52
> +#define GPO_SDIO1_BACK_END_POWER		53
> +#define GPO_SDIO1_CARD_POWER_EN			54
> +#define GPO_SDIO1_CCLK_OUT			55
> +#define GPO_SDIO1_CCMD_OD_PULLUP_EN_N		56
> +#define GPO_SDIO1_CCMD_OUT			57
> +#define GPO_SDIO1_CDATA_OUT_0			58
> +#define GPO_SDIO1_CDATA_OUT_1			59
> +#define GPO_SDIO1_CDATA_OUT_2			60
> +#define GPO_SDIO1_CDATA_OUT_3			61
> +#define GPO_SDIO1_CDATA_OUT_4			62
> +#define GPO_SDIO1_CDATA_OUT_5			63
> +#define GPO_SDIO1_CDATA_OUT_6			64
> +#define GPO_SDIO1_CDATA_OUT_7			65
> +#define GPO_SDIO1_RST_N				66
> +#define GPO_UART1_RTS_N				67
> +#define GPO_UART1_SOUT				68
> +#define GPO_I2STX_4CH1_SDO0			69
> +#define GPO_I2STX_4CH1_SDO1			70
> +#define GPO_I2STX_4CH1_SDO2			71
> +#define GPO_I2STX_4CH1_SDO3			72
> +#define GPO_SPI1_SSPCLKOUT			73
> +#define GPO_SPI1_SSPFSSOUT			74
> +#define GPO_SPI1_SSPTXD				75
> +#define GPO_I2C2_IC_CLK_OUT_A			76
> +#define GPO_I2C2_IC_DATA_OUT_A			77
> +#define GPO_UART2_RTS_N				78
> +#define GPO_UART2_SOUT				79
> +#define GPO_SPI2_SSPCLKOUT			80
> +#define GPO_SPI2_SSPFSSOUT			81
> +#define GPO_SPI2_SSPTXD				82
> +#define GPO_I2C3_IC_CLK_OUT_A			83
> +#define GPO_I2C3_IC_DATA_OUT_A			84
> +#define GPO_UART3_SOUT				85
> +#define GPO_SPI3_SSPCLKOUT			86
> +#define GPO_SPI3_SSPFSSOUT			87
> +#define GPO_SPI3_SSPTXD				88
> +#define GPO_I2C4_IC_CLK_OUT_A			89
> +#define GPO_I2C4_IC_DATA_OUT_A			90
> +#define GPO_UART4_RTS_N				91
> +#define GPO_UART4_SOUT				92
> +#define GPO_SPI4_SSPCLKOUT			93
> +#define GPO_SPI4_SSPFSSOUT			94
> +#define GPO_SPI4_SSPTXD				95
> +#define GPO_I2C5_IC_CLK_OUT_A			96
> +#define GPO_I2C5_IC_DATA_OUT_A			97
> +#define GPO_UART5_RTS_N				98
> +#define GPO_UART5_SOUT				99
> +#define GPO_SPI5_SSPCLKOUT			100
> +#define GPO_SPI5_SSPFSSOUT			101
> +#define GPO_SPI5_SSPTXD				102
> +#define GPO_I2C6_IC_CLK_OUT_A			103
> +#define GPO_I2C6_IC_DATA_OUT_A			104
> +#define GPO_SPI6_SSPCLKOUT			105
> +#define GPO_SPI6_SSPFSSOUT			106
> +#define GPO_SPI6_SSPTXD				107
> +#define GPO_NONE				108
> +
> +#define OEN_LOW					0
> +#define OEN_HIGH				1
> +#define OEN_HDMI0_CEC_SDA_OEN			2
> +#define OEN_HDMI0_DDC_SCL_OEN			3
> +#define OEN_HDMI0_DDC_SDA_OEN			4
> +#define OEN_I2C0_IC_CLK_OE			5
> +#define OEN_I2C0_IC_DATA_OE			6
> +#define OEN_JTAG_DSP_TDO_OEN			7
> +#define OEN_JTAG_CPU_CERTIFICATION_TDO_OE	8
> +#define OEN_PTC0_PWM_0_OE_N			9
> +#define OEN_PTC0_PWM_1_OE_N			10
> +#define OEN_PTC0_PWM_2_OE_N			11
> +#define OEN_PTC0_PWM_3_OE_N			12
> +#define OEN_SPI0_NSSPCTLOE			13
> +#define OEN_SPI0_NSSPOE				14
> +#define OEN_TDM0_NPCM_SYNCOE			15
> +#define OEN_TDM0_NPCM_TXDOE			16
> +#define OEN_I2C1_IC_CLK_OE			17
> +#define OEN_I2C1_IC_DATA_OE			18
> +#define OEN_SDIO1_CCMD_OUT_EN			19
> +#define OEN_SDIO1_CDATA_OUT_EN_0		20
> +#define OEN_SDIO1_CDATA_OUT_EN_1		21
> +#define OEN_SDIO1_CDATA_OUT_EN_2		22
> +#define OEN_SDIO1_CDATA_OUT_EN_3		23
> +#define OEN_SDIO1_CDATA_OUT_EN_4		24
> +#define OEN_SDIO1_CDATA_OUT_EN_5		25
> +#define OEN_SDIO1_CDATA_OUT_EN_6		26
> +#define OEN_SDIO1_CDATA_OUT_EN_7		27
> +#define OEN_SPI1_NSSPCTLOE			28
> +#define OEN_SPI1_NSSPOE				29
> +#define OEN_I2C2_IC_CLK_OE			30
> +#define OEN_I2C2_IC_DATA_OE			31
> +#define OEN_SPI2_NSSPCTLOE			32
> +#define OEN_SPI2_NSSPOE				33
> +#define OEN_I2C3_IC_CLK_OE			34
> +#define OEN_I2C3_IC_DATA_OE			35
> +#define OEN_SPI3_NSSPCTLOE			36
> +#define OEN_SPI3_NSSPOE				37
> +#define OEN_I2C4_IC_CLK_OE			38
> +#define OEN_I2C4_IC_DATA_OE			39
> +#define OEN_SPI4_NSSPCTLOE			40
> +#define OEN_SPI4_NSSPOE				41
> +#define OEN_I2C5_IC_CLK_OE			42
> +#define OEN_I2C5_IC_DATA_OE			43
> +#define OEN_SPI5_NSSPCTLOE			44
> +#define OEN_SPI5_NSSPOE				45
> +#define OEN_I2C6_IC_CLK_OE			46
> +#define OEN_I2C6_IC_DATA_OE			47
> +#define OEN_SPI6_NSSPCTLOE			48
> +#define OEN_SPI6_NSSPOE				49
> +#define OEN_NONE				50
> +
> +#define GPI_WAVE511_0_I_UART_RXSIN		0
> +#define GPI_CAN0_CTRL_RXD			1
> +#define GPI_USB0_OVERCURRENT_N_IO		2
> +#define GPI_SPDIF0_SPDIFI			3
> +#define GPI_JTAG_CPU_CERTIFICATION_BYPASS_TRSTN	4
> +#define GPI_HDMI0_CEC_SDA_IN			5
> +#define GPI_HDMI0_DDC_SCL_IN			6
> +#define GPI_HDMI0_DDC_SDA_IN			7
> +#define GPI_HDMI0_HPD				8
> +#define GPI_I2C0_IC_CLK_IN_A			9
> +#define GPI_I2C0_IC_DATA_IN_A			10
> +#define GPI_SDIO0_CARD_DETECT_N			11
> +#define GPI_SDIO0_CARD_INT_N			12
> +#define GPI_SDIO0_CARD_WRITE_PRT		13
> +#define GPI_UART0_SIN				14
> +#define GPI_JTAG_DSP_TCK			15
> +#define GPI_JTAG_DSP_TDI			16
> +#define GPI_JTAG_DSP_TMS			17
> +#define GPI_JTAG_DSP_TRST_N			18
> +#define GPI_JTAG_CPU_CERTIFICATION_TDI		19
> +#define GPI_JTAG_CPU_CERTIFICATION_TMS		20
> +#define GPI_PDM_4MIC0_DMIC0_DIN			21
> +#define GPI_PDM_4MIC0_DMIC1_DIN			22
> +#define GPI_I2SRX0_EXT_SDIN0			23
> +#define GPI_I2SRX0_EXT_SDIN1			24
> +#define GPI_I2SRX0_EXT_SDIN2			25
> +#define GPI_SPI0_SSPCLKIN			26
> +#define GPI_SPI0_SSPFSSIN			27
> +#define GPI_SPI0_SSPRXD				28
> +#define GPI_JTAG_CPU_CERTIFICATION_TCK		29
> +#define GPI_CRG0_EXT_MCLK			30
> +#define GPI_I2SRX0_BCLK_SLV			31
> +#define GPI_I2SRX0_LRCK_SLV			32
> +#define GPI_I2STX0_BCLK_SLV			33
> +#define GPI_I2STX0_LRCK_SLV			34
> +#define GPI_TDM0_CLK_SLV			35
> +#define GPI_TDM0_PCM_RXD			36
> +#define GPI_TDM0_PCM_SYNCIN			37
> +#define GPI_CAN1_CTRL_RXD			38
> +#define GPI_I2C1_IC_CLK_IN_A			39
> +#define GPI_I2C1_IC_DATA_IN_A			40
> +#define GPI_SDIO1_CARD_DETECT_N			41
> +#define GPI_SDIO1_CARD_INT_N			42
> +#define GPI_SDIO1_CARD_WRITE_PRT		43
> +#define GPI_SDIO1_CCMD_IN			44
> +#define GPI_SDIO1_CDATA_IN_0			45
> +#define GPI_SDIO1_CDATA_IN_1			46
> +#define GPI_SDIO1_CDATA_IN_2			47
> +#define GPI_SDIO1_CDATA_IN_3			48
> +#define GPI_SDIO1_CDATA_IN_4			49
> +#define GPI_SDIO1_CDATA_IN_5			50
> +#define GPI_SDIO1_CDATA_IN_6			51
> +#define GPI_SDIO1_CDATA_IN_7			52
> +#define GPI_SDIO1_DATA_STROBE			53
> +#define GPI_UART1_CTS_N				54
> +#define GPI_UART1_SIN				55
> +#define GPI_SPI1_SSPCLKIN			56
> +#define GPI_SPI1_SSPFSSIN			57
> +#define GPI_SPI1_SSPRXD				58
> +#define GPI_I2C2_IC_CLK_IN_A			59
> +#define GPI_I2C2_IC_DATA_IN_A			60
> +#define GPI_UART2_CTS_N				61
> +#define GPI_UART2_SIN				62
> +#define GPI_SPI2_SSPCLKIN			63
> +#define GPI_SPI2_SSPFSSIN			64
> +#define GPI_SPI2_SSPRXD				65
> +#define GPI_I2C3_IC_CLK_IN_A			66
> +#define GPI_I2C3_IC_DATA_IN_A			67
> +#define GPI_UART3_SIN				68
> +#define GPI_SPI3_SSPCLKIN			69
> +#define GPI_SPI3_SSPFSSIN			70
> +#define GPI_SPI3_SSPRXD				71
> +#define GPI_I2C4_IC_CLK_IN_A			72
> +#define GPI_I2C4_IC_DATA_IN_A			73
> +#define GPI_UART4_CTS_N				74
> +#define GPI_UART4_SIN				75
> +#define GPI_SPI4_SSPCLKIN			76
> +#define GPI_SPI4_SSPFSSIN			77
> +#define GPI_SPI4_SSPRXD				78
> +#define GPI_I2C5_IC_CLK_IN_A			79
> +#define GPI_I2C5_IC_DATA_IN_A			80
> +#define GPI_UART5_CTS_N				81
> +#define GPI_UART5_SIN				82
> +#define GPI_SPI5_SSPCLKIN			83
> +#define GPI_SPI5_SSPFSSIN			84
> +#define GPI_SPI5_SSPRXD				85
> +#define GPI_I2C6_IC_CLK_IN_A			86
> +#define GPI_I2C6_IC_DATA_IN_A			87
> +#define GPI_SPI6_SSPCLKIN			88
> +#define GPI_SPI6_SSPFSSIN			89
> +#define GPI_SPI6_SSPRXD				90
> +#define	GPI_NONE				91
> +
> +/* sys_iomux syscon */
> +#define PADCFG_PAD_GMAC1_MDC_SYSCON		0x24c
> +#define PADCFG_PAD_GMAC1_MDIO_SYSCON		0x250
> +#define PADCFG_PAD_GMAC1_RXD0_SYSCON		0x254

Register values do not belong to bindings. Drop everything also below.

> +#define PADCFG_PAD_GMAC1_RXD1_SYSCON		0x258
> +#define PADCFG_PAD_GMAC1_RXD2_SYSCON		0x25c
> +#define PADCFG_PAD_GMAC1_RXD3_SYSCON		0x260
> +#define PADCFG_PAD_GMAC1_RXDV_SYSCON		0x264
> +#define PADCFG_PAD_GMAC1_RXC_SYSCON		0x268
> +#define PADCFG_PAD_GMAC1_TXD0_SYSCON		0x26c


Best regards,
Krzysztof

