Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB45F645A86
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 14:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbiLGNPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 08:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiLGNPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 08:15:15 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754BA56D6A
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 05:15:13 -0800 (PST)
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com [209.85.219.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D1C6E4433E
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 13:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1670418911;
        bh=DmuuK3sor/04zv/036FZHSxekt6dCz2Eb+h+gCZ54ek=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=Ia/YJmy8apfMPNWAup7lYWrRrOPJoJZOHwIMLaSskfagVOr6YdNp2pUsdSr7WSmQy
         uHJY0rS6nWRgSPRkc5VCp/f+QZqGhFL/sP2q6LLaPlOVf3ZqLd6Yf5guAU4qJVuNJy
         hkpjy7n0MyHj/LtN1d+qOBDuJVK2AWMFgbW8hDWxl/fXwOLh0ibHsWUb+qUOE7K0Bq
         9aZdiuvZZDukIYlwlR5BSbVv28cSclvmWbm/+ystaICfX6+q1/AdtDN296+25vlaO6
         RUni8C1azr2a78MjfUfV9G2xgQ2VNoZSM/zk3lbgG7qBhP+BDkZgw7Hzaykjl27v4s
         Zpw4BkS83d0kg==
Received: by mail-yb1-f198.google.com with SMTP id e185-20020a2569c2000000b006f28dd5da75so19029515ybc.19
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 05:15:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DmuuK3sor/04zv/036FZHSxekt6dCz2Eb+h+gCZ54ek=;
        b=uNZhyfyMWmiYl1MXciWGGTJJuEh9GBDNs7ITyy+Fw14CycTq6Wovw+EeZPTl5Tn6wC
         /tUjAbXuvZQmNq9MbQE/CgFPIr78wyRxz4U4TIy24vHfNtv0/kdhBLIp7i0klbRKItrk
         kIe+B36jVjK2C7lwt+rLLAnTP8jge1Os3D9r4/sP9bKmAt7ov36JBcJctulSmeXX9KtC
         oIFDefdP5kAa+mtp0wmlS1xrZGc5kKwvViBe/eD2DOgKuHFmfI8vs0JYuoBsb6ELNorw
         0UlYnzcSSMBhJ2IvkbZ23G/2+v9t5Job/28qlhDU/bUy9sV1Mms3BIyX1pRfxx7ZSWUF
         Z2Gw==
X-Gm-Message-State: ANoB5pnqbJu3OH5RzIZSilAHnix2zVWBg+3wLClbSdKPySCXSAiD93Au
        2B1CkCLV8J9n84UgCVdHUnHodw0nd9Oqd0D/SSQKG8GSx6wOGowfovBbFyxzDJ0X1yCwg6HiaCC
        oQ9YFlFnYLVBYgfvlKze/GUJZs19mqkwxFn3TixWoXrskbOzMlnHJ5bzHDQ==
X-Received: by 2002:a25:d24b:0:b0:6f1:e822:14e8 with SMTP id j72-20020a25d24b000000b006f1e82214e8mr55407393ybg.467.1670418910776;
        Wed, 07 Dec 2022 05:15:10 -0800 (PST)
X-Google-Smtp-Source: AA0mqf40BznsnaH8tL0lAbj3/H3G88+mVHAnBhAF4jWp9c0wUnyEfjN6LLYs3cLERRvvJKwkhWDxYkzkcUZasK/7lK8=
X-Received: by 2002:a25:d24b:0:b0:6f1:e822:14e8 with SMTP id
 j72-20020a25d24b000000b006f1e82214e8mr55407372ybg.467.1670418910456; Wed, 07
 Dec 2022 05:15:10 -0800 (PST)
MIME-Version: 1.0
References: <20221118011108.70715-1-hal.feng@starfivetech.com> <20221118011108.70715-2-hal.feng@starfivetech.com>
In-Reply-To: <20221118011108.70715-2-hal.feng@starfivetech.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Wed, 7 Dec 2022 14:14:53 +0100
Message-ID: <CAJM55Z_8PL3m_AntWLDYj9s0-xwH0h2kqNm0vBBfAkPvj06wJA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] dt-bindings: pinctrl: Add StarFive JH7110 pinctrl definitions
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jianlong Huang <jianlong.huang@starfivetech.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Nov 2022 at 02:11, Hal Feng <hal.feng@starfivetech.com> wrote:
>
> From: Jianlong Huang <jianlong.huang@starfivetech.com>
>
> Add pinctrl definitions for StarFive JH7110 SoC.
>
> Co-developed-by: Emil Renner Berthing <kernel@esmil.dk>
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> Signed-off-by: Jianlong Huang <jianlong.huang@starfivetech.com>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  .../pinctrl/pinctrl-starfive-jh7110.h         | 427 ++++++++++++++++++
>  1 file changed, 427 insertions(+)
>  create mode 100644 include/dt-bindings/pinctrl/pinctrl-starfive-jh7110.h
>
> diff --git a/include/dt-bindings/pinctrl/pinctrl-starfive-jh7110.h b/include/dt-bindings/pinctrl/pinctrl-starfive-jh7110.h
> new file mode 100644
> index 000000000000..fb02345caa27
> --- /dev/null
> +++ b/include/dt-bindings/pinctrl/pinctrl-starfive-jh7110.h
> @@ -0,0 +1,427 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR MIT */
> +/*
> + * Copyright (C) 2022 Emil Renner Berthing <kernel@esmil.dk>
> + * Copyright (C) 2022 StarFive Technology Co., Ltd.
> + */
> +
> +#ifndef __DT_BINDINGS_PINCTRL_STARFIVE_JH7110_H__
> +#define __DT_BINDINGS_PINCTRL_STARFIVE_JH7110_H__
> +
> +/*
> + * mux bits:
> + *  | 31 - 24 | 23 - 16 | 15 - 10 |  9 - 8   |  7 - 0  |
> + *  |  din    |  dout   |  doen   | function | gpio nr |
> + *
> + * dout:     output signal
> + * doen:     output enable signal
> + * din:      optional input signal, 0xff = none
> + * function:
> + * gpio nr:  gpio number, 0 - 63
> + */
> +#define GPIOMUX(n, dout, doen, din) ( \
> +               (((din)  & 0xff) << 24) | \
> +               (((dout) & 0xff) << 16) | \
> +               (((doen) & 0x3f) << 10) | \
> +               ((n) & 0x3f))
> +
> +#define PINMUX(n, func) ((1 << 10) | (((func) & 0x3) << 8) | ((n) & 0xff))
> +
> +/* sys_iomux pin */
> +#define        PAD_GPIO0        0
> +#define        PAD_GPIO1        1
> +#define        PAD_GPIO2        2
> +#define        PAD_GPIO3        3
> +#define        PAD_GPIO4        4
> +#define        PAD_GPIO5        5
> +#define        PAD_GPIO6        6
> +#define        PAD_GPIO7        7
> +#define        PAD_GPIO8        8
> +#define        PAD_GPIO9        9
> +#define        PAD_GPIO10      10
> +#define        PAD_GPIO11      11
> +#define        PAD_GPIO12      12
> +#define        PAD_GPIO13      13
> +#define        PAD_GPIO14      14
> +#define        PAD_GPIO15      15
> +#define        PAD_GPIO16      16
> +#define        PAD_GPIO17      17
> +#define        PAD_GPIO18      18
> +#define        PAD_GPIO19      19
> +#define        PAD_GPIO20      20
> +#define        PAD_GPIO21      21
> +#define        PAD_GPIO22      22
> +#define        PAD_GPIO23      23
> +#define        PAD_GPIO24      24
> +#define        PAD_GPIO25      25
> +#define        PAD_GPIO26      26
> +#define        PAD_GPIO27      27
> +#define        PAD_GPIO28      28
> +#define        PAD_GPIO29      29
> +#define        PAD_GPIO30      30
> +#define        PAD_GPIO31      31
> +#define        PAD_GPIO32      32
> +#define        PAD_GPIO33      33
> +#define        PAD_GPIO34      34
> +#define        PAD_GPIO35      35
> +#define        PAD_GPIO36      36
> +#define        PAD_GPIO37      37
> +#define        PAD_GPIO38      38
> +#define        PAD_GPIO39      39
> +#define        PAD_GPIO40      40
> +#define        PAD_GPIO41      41
> +#define        PAD_GPIO42      42
> +#define        PAD_GPIO43      43
> +#define        PAD_GPIO44      44
> +#define        PAD_GPIO45      45
> +#define        PAD_GPIO46      46
> +#define        PAD_GPIO47      47
> +#define        PAD_GPIO48      48
> +#define        PAD_GPIO49      49
> +#define        PAD_GPIO50      50
> +#define        PAD_GPIO51      51
> +#define        PAD_GPIO52      52
> +#define        PAD_GPIO53      53
> +#define        PAD_GPIO54      54
> +#define        PAD_GPIO55      55
> +#define        PAD_GPIO56      56
> +#define        PAD_GPIO57      57
> +#define        PAD_GPIO58      58
> +#define        PAD_GPIO59      59
> +#define        PAD_GPIO60      60
> +#define        PAD_GPIO61      61
> +#define        PAD_GPIO62      62
> +#define        PAD_GPIO63      63
> +#define        PAD_SD0_CLK     64
> +#define        PAD_SD0_CMD     65
> +#define        PAD_SD0_DATA0   66
> +#define        PAD_SD0_DATA1   67
> +#define        PAD_SD0_DATA2   68
> +#define        PAD_SD0_DATA3   69
> +#define        PAD_SD0_DATA4   70
> +#define        PAD_SD0_DATA5   71
> +#define        PAD_SD0_DATA6   72
> +#define        PAD_SD0_DATA7   73
> +#define        PAD_SD0_STRB    74
> +#define        PAD_GMAC1_MDC   75
> +#define        PAD_GMAC1_MDIO  76
> +#define        PAD_GMAC1_RXD0  77
> +#define        PAD_GMAC1_RXD1  78
> +#define        PAD_GMAC1_RXD2  79
> +#define        PAD_GMAC1_RXD3  80
> +#define        PAD_GMAC1_RXDV  81
> +#define        PAD_GMAC1_RXC   82
> +#define        PAD_GMAC1_TXD0  83
> +#define        PAD_GMAC1_TXD1  84
> +#define        PAD_GMAC1_TXD2  85
> +#define        PAD_GMAC1_TXD3  86
> +#define        PAD_GMAC1_TXEN  87
> +#define        PAD_GMAC1_TXC   88
> +#define        PAD_QSPI_SCLK   89
> +#define        PAD_QSPI_CS0    90
> +#define        PAD_QSPI_DATA0  91
> +#define        PAD_QSPI_DATA1  92
> +#define        PAD_QSPI_DATA2  93
> +#define        PAD_QSPI_DATA3  94
> +
> +/* aon_iomux pin */
> +#define        PAD_TESTEN      0
> +#define        PAD_RGPIO0      1
> +#define        PAD_RGPIO1      2
> +#define        PAD_RGPIO2      3
> +#define        PAD_RGPIO3      4
> +#define        PAD_RSTN        5
> +#define        PAD_GMAC0_MDC   6
> +#define        PAD_GMAC0_MDIO  7
> +#define        PAD_GMAC0_RXD0  8
> +#define        PAD_GMAC0_RXD1  9
> +#define        PAD_GMAC0_RXD2  10
> +#define        PAD_GMAC0_RXD3  11
> +#define        PAD_GMAC0_RXDV  12
> +#define        PAD_GMAC0_RXC   13
> +#define        PAD_GMAC0_TXD0  14
> +#define        PAD_GMAC0_TXD1  15
> +#define        PAD_GMAC0_TXD2  16
> +#define        PAD_GMAC0_TXD3  17
> +#define        PAD_GMAC0_TXEN  18
> +#define        PAD_GMAC0_TXC   19
> +
> +/* sys_iomux dout */
> +#define GPOUT_LOW                                0
> +#define GPOUT_HIGH                               1
> +#define GPOUT_SYS_WAVE511_UART_TX                2
> +#define GPOUT_SYS_CAN0_STBY                      3
> +#define GPOUT_SYS_CAN0_TST_NEXT_BIT              4
> +#define GPOUT_SYS_CAN0_TST_SAMPLE_POINT                  5
> +#define GPOUT_SYS_CAN0_TXD                       6
> +#define GPOUT_SYS_USB_DRIVE_VBUS                 7
> +#define GPOUT_SYS_QSPI_CS1                       8
> +#define GPOUT_SYS_SPDIF                                  9
> +#define GPOUT_SYS_HDMI_CEC_SDA                  10
> +#define GPOUT_SYS_HDMI_DDC_SCL                  11
> +#define GPOUT_SYS_HDMI_DDC_SDA                  12
> +#define GPOUT_SYS_WATCHDOG                      13
> +#define GPOUT_SYS_I2C0_CLK                      14
> +#define GPOUT_SYS_I2C0_DATA                     15
> +#define GPOUT_SYS_SDIO0_BACK_END_POWER          16
> +#define GPOUT_SYS_SDIO0_CARD_POWER_EN           17
> +#define GPOUT_SYS_SDIO0_CCMD_OD_PULLUP_EN       18
> +#define GPOUT_SYS_SDIO0_RST                     19
> +#define GPOUT_SYS_UART0_TX                      20
> +#define GPOUT_SYS_HIFI4_JTAG_TDO                21
> +#define GPOUT_SYS_JTAG_TDO                      22
> +#define GPOUT_SYS_PDM_MCLK                      23
> +#define GPOUT_SYS_PWM_CHANNEL0                  24
> +#define GPOUT_SYS_PWM_CHANNEL1                  25
> +#define GPOUT_SYS_PWM_CHANNEL2                  26
> +#define GPOUT_SYS_PWM_CHANNEL3                  27
> +#define GPOUT_SYS_PWMDAC_LEFT                   28
> +#define GPOUT_SYS_PWMDAC_RIGHT                  29
> +#define GPOUT_SYS_SPI0_CLK                      30
> +#define GPOUT_SYS_SPI0_FSS                      31
> +#define GPOUT_SYS_SPI0_TXD                      32
> +#define GPOUT_SYS_GMAC_PHYCLK                   33
> +#define GPOUT_SYS_I2SRX_BCLK                    34
> +#define GPOUT_SYS_I2SRX_LRCK                    35
> +#define GPOUT_SYS_I2STX0_BCLK                   36
> +#define GPOUT_SYS_I2STX0_LRCK                   37
> +#define GPOUT_SYS_MCLK                          38
> +#define GPOUT_SYS_TDM_CLK                       39
> +#define GPOUT_SYS_TDM_SYNC                      40
> +#define GPOUT_SYS_TDM_TXD                       41
> +#define GPOUT_SYS_TRACE_DATA0                   42
> +#define GPOUT_SYS_TRACE_DATA1                   43
> +#define GPOUT_SYS_TRACE_DATA2                   44
> +#define GPOUT_SYS_TRACE_DATA3                   45
> +#define GPOUT_SYS_TRACE_REF                     46
> +#define GPOUT_SYS_CAN1_STBY                     47
> +#define GPOUT_SYS_CAN1_TST_NEXT_BIT             48
> +#define GPOUT_SYS_CAN1_TST_SAMPLE_POINT                 49
> +#define GPOUT_SYS_CAN1_TXD                      50
> +#define GPOUT_SYS_I2C1_CLK                      51
> +#define GPOUT_SYS_I2C1_DATA                     52
> +#define GPOUT_SYS_SDIO1_BACK_END_POWER          53
> +#define GPOUT_SYS_SDIO1_CARD_POWER_EN           54
> +#define GPOUT_SYS_SDIO1_CLK                     55
> +#define GPOUT_SYS_SDIO1_CMD_OD_PULLUP_EN        56
> +#define GPOUT_SYS_SDIO1_CMD                     57
> +#define GPOUT_SYS_SDIO1_DATA0                   58
> +#define GPOUT_SYS_SDIO1_DATA1                   59
> +#define GPOUT_SYS_SDIO1_DATA2                   60
> +#define GPOUT_SYS_SDIO1_DATA3                   61
> +#define GPOUT_SYS_SDIO1_DATA4                   63
> +#define GPOUT_SYS_SDIO1_DATA5                   63
> +#define GPOUT_SYS_SDIO1_DATA6                   64
> +#define GPOUT_SYS_SDIO1_DATA7                   65
> +#define GPOUT_SYS_SDIO1_RST                     66
> +#define GPOUT_SYS_UART1_RTS                     67
> +#define GPOUT_SYS_UART1_TX                      68
> +#define GPOUT_SYS_I2STX1_SDO0                   69
> +#define GPOUT_SYS_I2STX1_SDO1                   70
> +#define GPOUT_SYS_I2STX1_SDO2                   71
> +#define GPOUT_SYS_I2STX1_SDO3                   72
> +#define GPOUT_SYS_SPI1_CLK                      73
> +#define GPOUT_SYS_SPI1_FSS                      74
> +#define GPOUT_SYS_SPI1_TXD                      75
> +#define GPOUT_SYS_I2C2_CLK                      76
> +#define GPOUT_SYS_I2C2_DATA                     77
> +#define GPOUT_SYS_UART2_RTS                     78
> +#define GPOUT_SYS_UART2_TX                      79
> +#define GPOUT_SYS_SPI2_CLK                      80
> +#define GPOUT_SYS_SPI2_FSS                      81
> +#define GPOUT_SYS_SPI2_TXD                      82
> +#define GPOUT_SYS_I2C3_CLK                      83
> +#define GPOUT_SYS_I2C3_DATA                     84
> +#define GPOUT_SYS_UART3_TX                      85
> +#define GPOUT_SYS_SPI3_CLK                      86
> +#define GPOUT_SYS_SPI3_FSS                      87
> +#define GPOUT_SYS_SPI3_TXD                      88
> +#define GPOUT_SYS_I2C4_CLK                      89
> +#define GPOUT_SYS_I2C4_DATA                     90
> +#define GPOUT_SYS_UART4_RTS                     91
> +#define GPOUT_SYS_UART4_TX                      92
> +#define GPOUT_SYS_SPI4_CLK                      93
> +#define GPOUT_SYS_SPI4_FSS                      94
> +#define GPOUT_SYS_SPI4_TXD                      95
> +#define GPOUT_SYS_I2C5_CLK                      96
> +#define GPOUT_SYS_I2C5_DATA                     97
> +#define GPOUT_SYS_UART5_RTS                     98
> +#define GPOUT_SYS_UART5_TX                      99
> +#define GPOUT_SYS_SPI5_CLK                     100
> +#define GPOUT_SYS_SPI5_FSS                     101
> +#define GPOUT_SYS_SPI5_TXD                     102
> +#define GPOUT_SYS_I2C6_CLK                     103
> +#define GPOUT_SYS_I2C6_DATA                    104
> +#define GPOUT_SYS_SPI6_CLK                     105
> +#define GPOUT_SYS_SPI6_FSS                     106
> +#define GPOUT_SYS_SPI6_TXD                     107
> +
> +/* aon_iomux dout */
> +#define GPOUT_AON_CLK_32K_OUT                  2
> +#define GPOUT_AON_PTC0_PWM4                    3
> +#define GPOUT_AON_PTC0_PWM5                    4
> +#define GPOUT_AON_PTC0_PWM6                    5
> +#define GPOUT_AON_PTC0_PWM7                    6
> +#define GPOUT_AON_CLK_GCLK0                    7
> +#define GPOUT_AON_CLK_GCLK1                    8
> +#define GPOUT_AON_CLK_GCLK2                    9
> +
> +/* sys_iomux doen */
> +#define GPOEN_ENABLE                            0
> +#define GPOEN_DISABLE                           1
> +#define GPOEN_SYS_HDMI_CEC_SDA                  2
> +#define GPOEN_SYS_HDMI_DDC_SCL                  3
> +#define GPOEN_SYS_HDMI_DDC_SDA                  4
> +#define GPOEN_SYS_I2C0_CLK                      5
> +#define GPOEN_SYS_I2C0_DATA                     6
> +#define GPOEN_SYS_HIFI4_JTAG_TDO                7
> +#define GPOEN_SYS_JTAG_TDO                      8
> +#define GPOEN_SYS_PWM0_CHANNEL0                         9
> +#define GPOEN_SYS_PWM0_CHANNEL1                        10
> +#define GPOEN_SYS_PWM0_CHANNEL2                        11
> +#define GPOEN_SYS_PWM0_CHANNEL3                        12
> +#define GPOEN_SYS_SPI0_NSSPCTL                 13
> +#define GPOEN_SYS_SPI0_NSSP                    14
> +#define GPOEN_SYS_TDM_SYNC                     15
> +#define GPOEN_SYS_TDM_TXD                      16
> +#define GPOEN_SYS_I2C1_CLK                     17
> +#define GPOEN_SYS_I2C1_DATA                    18
> +#define GPOEN_SYS_SDIO1_CMD                    19
> +#define GPOEN_SYS_SDIO1_DATA0                  20
> +#define GPOEN_SYS_SDIO1_DATA1                  21
> +#define GPOEN_SYS_SDIO1_DATA2                  22
> +#define GPOEN_SYS_SDIO1_DATA3                  23
> +#define GPOEN_SYS_SDIO1_DATA4                  24
> +#define GPOEN_SYS_SDIO1_DATA5                  25
> +#define GPOEN_SYS_SDIO1_DATA6                  26
> +#define GPOEN_SYS_SDIO1_DATA7                  27
> +#define GPOEN_SYS_SPI1_NSSPCTL                 28
> +#define GPOEN_SYS_SPI1_NSSP                    29
> +#define GPOEN_SYS_I2C2_CLK                     30
> +#define GPOEN_SYS_I2C2_DATA                    31
> +#define GPOEN_SYS_SPI2_NSSPCTL                 32
> +#define GPOEN_SYS_SPI2_NSSP                    33
> +#define GPOEN_SYS_I2C3_CLK                     34
> +#define GPOEN_SYS_I2C3_DATA                    35
> +#define GPOEN_SYS_SPI3_NSSPCTL                 36
> +#define GPOEN_SYS_SPI3_NSSP                    37
> +#define GPOEN_SYS_I2C4_CLK                     38
> +#define GPOEN_SYS_I2C4_DATA                    39
> +#define GPOEN_SYS_SPI4_NSSPCTL                 40
> +#define GPOEN_SYS_SPI4_NSSP                    41
> +#define GPOEN_SYS_I2C5_CLK                     42
> +#define GPOEN_SYS_I2C5_DATA                    43
> +#define GPOEN_SYS_SPI5_NSSPCTL                 44
> +#define GPOEN_SYS_SPI5_NSSP                    45
> +#define GPOEN_SYS_I2C6_CLK                     46
> +#define GPOEN_SYS_I2C6_DATA                    47
> +#define GPOEN_SYS_SPI6_NSSPCTL                 48
> +#define GPOEN_SYS_SPI6_NSSP                    49
> +
> +/* aon_iomux doen */
> +#define GPOEN_AON_PTC0_OE_N_4                  2
> +#define GPOEN_AON_PTC0_OE_N_5                  3
> +#define GPOEN_AON_PTC0_OE_N_6                  4
> +#define GPOEN_AON_PTC0_OE_N_7                  5
> +
> +/* sys_iomux gin */
> +#define GPI_NONE                               255
> +
> +#define GPI_SYS_WAVE511_UART_RX                         0
> +#define GPI_SYS_CAN0_RXD                        1
> +#define GPI_SYS_USB_OVERCURRENT                         2
> +#define GPI_SYS_SPDIF                           3
> +#define GPI_SYS_JTAG_RST                        4
> +#define GPI_SYS_HDMI_CEC_SDA                    5
> +#define GPI_SYS_HDMI_DDC_SCL                    6
> +#define GPI_SYS_HDMI_DDC_SDA                    7
> +#define GPI_SYS_HDMI_HPD                        8
> +#define GPI_SYS_I2C0_CLK                        9
> +#define GPI_SYS_I2C0_DATA                      10
> +#define GPI_SYS_SDIO0_CD                       11
> +#define GPI_SYS_SDIO0_INT                      12
> +#define GPI_SYS_SDIO0_WP                       13
> +#define GPI_SYS_UART0_RX                       14
> +#define GPI_SYS_HIFI4_JTAG_TCK                 15
> +#define GPI_SYS_HIFI4_JTAG_TDI                 16
> +#define GPI_SYS_HIFI4_JTAG_TMS                 17
> +#define GPI_SYS_HIFI4_JTAG_RST                 18
> +#define GPI_SYS_JTAG_TDI                       19
> +#define GPI_SYS_JTAG_TMS                       20
> +#define GPI_SYS_PDM_DMIC0                      21
> +#define GPI_SYS_PDM_DMIC1                      22
> +#define GPI_SYS_I2SRX_SDIN0                    23
> +#define GPI_SYS_I2SRX_SDIN1                    24
> +#define GPI_SYS_I2SRX_SDIN2                    25
> +#define GPI_SYS_SPI0_CLK                       26
> +#define GPI_SYS_SPI0_FSS                       27
> +#define GPI_SYS_SPI0_RXD                       28
> +#define GPI_SYS_JTAG_TCK                       29
> +#define GPI_SYS_MCLK_EXT                       30
> +#define GPI_SYS_I2SRX_BCLK                     31
> +#define GPI_SYS_I2SRX_LRCK                     32
> +#define GPI_SYS_I2STX0_BCLK                    33
> +#define GPI_SYS_I2STX0_LRCK                    34
> +#define GPI_SYS_TDM_CLK                                35
> +#define GPI_SYS_TDM_RXD                                36
> +#define GPI_SYS_TDM_SYNC                       37
> +#define GPI_SYS_CAN1_RXD                       38
> +#define GPI_SYS_I2C1_CLK                       39
> +#define GPI_SYS_I2C1_DATA                      40
> +#define GPI_SYS_SDIO1_CD                       41
> +#define GPI_SYS_SDIO1_INT                      42
> +#define GPI_SYS_SDIO1_WP                       43
> +#define GPI_SYS_SDIO1_CMD                      44
> +#define GPI_SYS_SDIO1_DATA0                    45
> +#define GPI_SYS_SDIO1_DATA1                    46
> +#define GPI_SYS_SDIO1_DATA2                    47
> +#define GPI_SYS_SDIO1_DATA3                    48
> +#define GPI_SYS_SDIO1_DATA4                    49
> +#define GPI_SYS_SDIO1_DATA5                    50
> +#define GPI_SYS_SDIO1_DATA6                    51
> +#define GPI_SYS_SDIO1_DATA7                    52
> +#define GPI_SYS_SDIO1_STRB                     53
> +#define GPI_SYS_UART1_CTS                      54
> +#define GPI_SYS_UART1_RX                       55
> +#define GPI_SYS_SPI1_CLK                       56
> +#define GPI_SYS_SPI1_FSS                       57
> +#define GPI_SYS_SPI1_RXD                       58
> +#define GPI_SYS_I2C2_CLK                       59
> +#define GPI_SYS_I2C2_DATA                      60
> +#define GPI_SYS_UART2_CTS                      61
> +#define GPI_SYS_UART2_RX                       62
> +#define GPI_SYS_SPI2_CLK                       63
> +#define GPI_SYS_SPI2_FSS                       64
> +#define GPI_SYS_SPI2_RXD                       65
> +#define GPI_SYS_I2C3_CLK                       66
> +#define GPI_SYS_I2C3_DATA                      67
> +#define GPI_SYS_UART3_RX                       68
> +#define GPI_SYS_SPI3_CLK                       69
> +#define GPI_SYS_SPI3_FSS                       70
> +#define GPI_SYS_SPI3_RXD                       71
> +#define GPI_SYS_I2C4_CLK                       72
> +#define GPI_SYS_I2C4_DATA                      73
> +#define GPI_SYS_UART4_CTS                      74
> +#define GPI_SYS_UART4_RX                       75
> +#define GPI_SYS_SPI4_CLK                       76
> +#define GPI_SYS_SPI4_FSS                       77
> +#define GPI_SYS_SPI4_RXD                       78
> +#define GPI_SYS_I2C5_CLK                       79
> +#define GPI_SYS_I2C5_DATA                      80
> +#define GPI_SYS_UART5_CTS                      81
> +#define GPI_SYS_UART5_RX                       82
> +#define GPI_SYS_SPI5_CLK                       83
> +#define GPI_SYS_SPI5_FSS                       84
> +#define GPI_SYS_SPI5_RXD                       85
> +#define GPI_SYS_I2C6_CLK                       86
> +#define GPI_SYS_I2C6_DATA                      87
> +#define GPI_SYS_SPI6_CLK                       88
> +#define GPI_SYS_SPI6_FSS                       89
> +#define GPI_SYS_SPI6_RXD                       90

You seem to have removed the comments documenting what these lines are
called in the documentation. Please don't do that. The names in the
documentation are overly long for macro names, but these comments are
really helpful to map the macro names back to the name used in the
docs.

> +/* aon_iomux gin */
> +#define GPI_AON_PMU_GPIO_WAKEUP_0              0
> +#define GPI_AON_PMU_GPIO_WAKEUP_1              1
> +#define GPI_AON_PMU_GPIO_WAKEUP_2              2
> +#define GPI_AON_PMU_GPIO_WAKEUP_3              3
> +
> +#endif
> --
> 2.38.1
>
