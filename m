Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8362B62FABB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 17:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242265AbiKRQru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 11:47:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242267AbiKRQrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 11:47:43 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B2B6A778
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 08:47:42 -0800 (PST)
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D72703F1C4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 16:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1668790059;
        bh=bqUmREpKqp419mokmhm4Yfd6ZwVhvAs8FgLzRjDgzu8=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=IgxmfyKlG3D42S3z4rPELgYAPSRJyG6yGBGS5MFcLwSi+YyDfFlaT9+3SvSARD2IH
         evsQrHA3oyySt6W0QcaR3NPRxXyrX5V0UMvmBUFHryVmLO2bc19+YMuq1j9+eS6N2r
         aGX0CpE4cauKhZz8oJ/Jz/A3x6RVCuDmGOhUZt4cf6Bmc7nK/sff60fO0bgxqI2Cs0
         AiYXmIsOYQIz3LKUhI1l5Whm0fPsQxBhOXU/aGWEBqGpl1NAwRWk/nGeiXtBeZlm55
         s0Pe0+YKVzJEzQNUq7U4Ubb2q6C8+bWdSZOSWxxhDWb855RX3LWRWSDsypZVvmbQDN
         XA+rXzcmBYadg==
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-39562b26a76so22063377b3.15
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 08:47:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bqUmREpKqp419mokmhm4Yfd6ZwVhvAs8FgLzRjDgzu8=;
        b=esY6zmC/3e8pdmPAa6nzzv2MP2pwENuJycPz3j4jl10J1JAEvnj1Ivc2/nHtqbn1p8
         RWp4CtbUJcjm+ZUuA7VlqmLUFpvQNS4QDbDX1mwh6VwAKGw0N4bc3HH1qPM/zRH+6aPw
         fGPNiTjc1eMC4nAcS039CrDTtcDvXriVK8WLZb9Ke5wIGc0itxIyah7UqhLn9Oc+NLQ9
         xkDzMq88p5zL6AEHQcTQfFXqK9SRjTGerASjguihDRIDqae9OLsre1f6kXx5IYai0u9N
         1zoR54CfFooGypzfhTGuz4qhZpIOwHCSN6UkC/slCbXafebnmbLPdu/LpsYokH6ehRFZ
         91mQ==
X-Gm-Message-State: ANoB5plt32UhgLLFRisl+KPRWOToebOa/4rj1yeqApLjNo3aEvVdx7g3
        cklOLjxOTVuDjbSG5+A00Sm5mDDszDal2nZzEHcFF0VQyqN2C35722fGvFQjsk0W7Dzc7A15elC
        aVsf/jBx/5l/57yRS+D2c+Llr8kRguJeKxtiuxiWSvkfo1Tw8HjRZHuuo8A==
X-Received: by 2002:a25:7492:0:b0:6d3:6341:2cb2 with SMTP id p140-20020a257492000000b006d363412cb2mr7432024ybc.551.1668790058343;
        Fri, 18 Nov 2022 08:47:38 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5Zd4kEY4nMPFhuKdN3ImmQqdGWeYpHUC0cuxx5m60Am9dqXXSjTEpe/WBI+epfWbWIt8gub/Cr3c45ZoldbuQ=
X-Received: by 2002:a25:7492:0:b0:6d3:6341:2cb2 with SMTP id
 p140-20020a257492000000b006d363412cb2mr7432003ybc.551.1668790058111; Fri, 18
 Nov 2022 08:47:38 -0800 (PST)
MIME-Version: 1.0
References: <20221118010627.70576-1-hal.feng@starfivetech.com> <20221118010627.70576-9-hal.feng@starfivetech.com>
In-Reply-To: <20221118010627.70576-9-hal.feng@starfivetech.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Fri, 18 Nov 2022 17:47:21 +0100
Message-ID: <CAJM55Z80xyve9JHXT__E2FfsLUH5njmj75Wj8B3H81dxp9Zh-w@mail.gmail.com>
Subject: Re: [PATCH v2 08/14] dt-bindings: reset: Add StarFive JH7110 system
 and always-on reset definitions
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Nov 2022 at 02:06, Hal Feng <hal.feng@starfivetech.com> wrote:
>
> From: Emil Renner Berthing <kernel@esmil.dk>
>
> Add resets for the StarFive JH7110 system (SYS) and always-on (AON)
> reset controller.
>
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  MAINTAINERS                                 |   5 +-
>  include/dt-bindings/reset/starfive-jh7110.h | 154 ++++++++++++++++++++
>  2 files changed, 157 insertions(+), 2 deletions(-)
>  create mode 100644 include/dt-bindings/reset/starfive-jh7110.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e97dac9c0ee4..eeab26f5597c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19614,12 +19614,13 @@ F:    Documentation/devicetree/bindings/pinctrl/starfive,jh7100-pinctrl.yaml
>  F:     drivers/pinctrl/starfive/
>  F:     include/dt-bindings/pinctrl/pinctrl-starfive-jh7100.h
>
> -STARFIVE JH7100 RESET CONTROLLER DRIVERS
> +STARFIVE RESET CONTROLLER DRIVERS
>  M:     Emil Renner Berthing <kernel@esmil.dk>
> +M:     Hal Feng <hal.feng@starfivetech.com>
>  S:     Maintained
>  F:     Documentation/devicetree/bindings/reset/starfive,jh7100-reset.yaml
>  F:     drivers/reset/starfive/
> -F:     include/dt-bindings/reset/starfive-jh7100.h
> +F:     include/dt-bindings/reset/starfive*
>
>  STATIC BRANCH/CALL
>  M:     Peter Zijlstra <peterz@infradead.org>
> diff --git a/include/dt-bindings/reset/starfive-jh7110.h b/include/dt-bindings/reset/starfive-jh7110.h
> new file mode 100644
> index 000000000000..1a5bab671161
> --- /dev/null
> +++ b/include/dt-bindings/reset/starfive-jh7110.h
> @@ -0,0 +1,154 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR MIT */
> +/*
> + * Copyright (C) 2021-2022 Emil Renner Berthing <kernel@esmil.dk>

I'm not sure how this ended up here, but I definitely didn't start
working on this before 2022.

> + */
> +
> +#ifndef __DT_BINDINGS_RESET_STARFIVE_JH7110_H__
> +#define __DT_BINDINGS_RESET_STARFIVE_JH7110_H__
> +
> +/* SYSCRG resets */
> +#define JH7110_SYSRST_JTAG2APB                 0
> +#define JH7110_SYSRST_SYSCON                   1
> +#define JH7110_SYSRST_IOMUX                    2
> +#define JH7110_SYSRST_BUS                      3
> +#define JH7110_SYSRST_DEBUG                    4
> +#define JH7110_SYSRST_CORE0                    5
> +#define JH7110_SYSRST_CORE1                    6
> +#define JH7110_SYSRST_CORE2                    7
> +#define JH7110_SYSRST_CORE3                    8
> +#define JH7110_SYSRST_CORE4                    9
> +#define JH7110_SYSRST_CORE0_ST                 10
> +#define JH7110_SYSRST_CORE1_ST                 11
> +#define JH7110_SYSRST_CORE2_ST                 12
> +#define JH7110_SYSRST_CORE3_ST                 13
> +#define JH7110_SYSRST_CORE4_ST                 14
> +#define JH7110_SYSRST_TRACE0                   15
> +#define JH7110_SYSRST_TRACE1                   16
> +#define JH7110_SYSRST_TRACE2                   17
> +#define JH7110_SYSRST_TRACE3                   18
> +#define JH7110_SYSRST_TRACE4                   19
> +#define JH7110_SYSRST_TRACE_COM                        20
> +#define JH7110_SYSRST_GPU_APB                  21
> +#define JH7110_SYSRST_GPU_DOMA                 22
> +#define JH7110_SYSRST_NOC_BUS_APB_BUS          23
> +#define JH7110_SYSRST_NOC_BUS_AXICFG0_AXI      24
> +#define JH7110_SYSRST_NOC_BUS_CPU_AXI          25
> +#define JH7110_SYSRST_NOC_BUS_DISP_AXI         26
> +#define JH7110_SYSRST_NOC_BUS_GPU_AXI          27
> +#define JH7110_SYSRST_NOC_BUS_ISP_AXI          28
> +#define JH7110_SYSRST_NOC_BUS_DDRC             29
> +#define JH7110_SYSRST_NOC_BUS_STG_AXI          30
> +#define JH7110_SYSRST_NOC_BUS_VDEC_AXI         31
> +
> +#define JH7110_SYSRST_NOC_BUS_VENC_AXI         32
> +#define JH7110_SYSRST_AXI_CFG1_DEC_AHB         33
> +#define JH7110_SYSRST_AXI_CFG1_DEC_MAIN                34
> +#define JH7110_SYSRST_AXI_CFG0_DEC_MAIN                35
> +#define JH7110_SYSRST_AXI_CFG0_DEC_MAIN_DIV    36
> +#define JH7110_SYSRST_AXI_CFG0_DEC_HIFI4       37
> +#define JH7110_SYSRST_DDR_AXI                  38
> +#define JH7110_SYSRST_DDR_OSC                  39
> +#define JH7110_SYSRST_DDR_APB                  40
> +#define JH7110_SYSRST_DOM_ISP_TOP_N            41
> +#define JH7110_SYSRST_DOM_ISP_TOP_AXI          42
> +#define JH7110_SYSRST_DOM_VOUT_TOP_SRC         43
> +#define JH7110_SYSRST_CODAJ12_AXI              44
> +#define JH7110_SYSRST_CODAJ12_CORE             45
> +#define JH7110_SYSRST_CODAJ12_APB              46
> +#define JH7110_SYSRST_WAVE511_AXI              47
> +#define JH7110_SYSRST_WAVE511_BPU              48
> +#define JH7110_SYSRST_WAVE511_VCE              49
> +#define JH7110_SYSRST_WAVE511_APB              50
> +#define JH7110_SYSRST_VDEC_JPG_ARB_JPG         51
> +#define JH7110_SYSRST_VDEC_JPG_ARB_MAIN                52
> +#define JH7110_SYSRST_AXIMEM0_AXI              53
> +#define JH7110_SYSRST_WAVE420L_AXI             54
> +#define JH7110_SYSRST_WAVE420L_BPU             55
> +#define JH7110_SYSRST_WAVE420L_VCE             56
> +#define JH7110_SYSRST_WAVE420L_APB             57
> +#define JH7110_SYSRST_AXIMEM1_AXI              58
> +#define JH7110_SYSRST_AXIMEM2_AXI              59
> +#define JH7110_SYSRST_INTMEM                   60
> +#define JH7110_SYSRST_QSPI_AHB                 61
> +#define JH7110_SYSRST_QSPI_APB                 62
> +#define JH7110_SYSRST_QSPI_REF                 63
> +
> +#define JH7110_SYSRST_SDIO0_AHB                        64
> +#define JH7110_SYSRST_SDIO1_AHB                        65
> +#define JH7110_SYSRST_GMAC1_AXI                        66
> +#define JH7110_SYSRST_GMAC1_AHB                        67
> +#define JH7110_SYSRST_MAILBOX                  68
> +#define JH7110_SYSRST_SPI0_APB                 69
> +#define JH7110_SYSRST_SPI1_APB                 70
> +#define JH7110_SYSRST_SPI2_APB                 71
> +#define JH7110_SYSRST_SPI3_APB                 72
> +#define JH7110_SYSRST_SPI4_APB                 73
> +#define JH7110_SYSRST_SPI5_APB                 74
> +#define JH7110_SYSRST_SPI6_APB                 75
> +#define JH7110_SYSRST_I2C0_APB                 76
> +#define JH7110_SYSRST_I2C1_APB                 77
> +#define JH7110_SYSRST_I2C2_APB                 78
> +#define JH7110_SYSRST_I2C3_APB                 79
> +#define JH7110_SYSRST_I2C4_APB                 80
> +#define JH7110_SYSRST_I2C5_APB                 81
> +#define JH7110_SYSRST_I2C6_APB                 82
> +#define JH7110_SYSRST_UART0_APB                        83
> +#define JH7110_SYSRST_UART0_CORE               84
> +#define JH7110_SYSRST_UART1_APB                        85
> +#define JH7110_SYSRST_UART1_CORE               86
> +#define JH7110_SYSRST_UART2_APB                        87
> +#define JH7110_SYSRST_UART2_CORE               88
> +#define JH7110_SYSRST_UART3_APB                        89
> +#define JH7110_SYSRST_UART3_CORE               90
> +#define JH7110_SYSRST_UART4_APB                        91
> +#define JH7110_SYSRST_UART4_CORE               92
> +#define JH7110_SYSRST_UART5_APB                        93
> +#define JH7110_SYSRST_UART5_CORE               94
> +#define JH7110_SYSRST_SPDIF_APB                        95
> +
> +#define JH7110_SYSRST_PWMDAC_APB               96
> +#define JH7110_SYSRST_PDM_DMIC                 97
> +#define JH7110_SYSRST_PDM_APB                  98
> +#define JH7110_SYSRST_I2SRX_APB                        99
> +#define JH7110_SYSRST_I2SRX_BCLK               100
> +#define JH7110_SYSRST_I2STX0_APB               101
> +#define JH7110_SYSRST_I2STX0_BCLK              102
> +#define JH7110_SYSRST_I2STX1_APB               103
> +#define JH7110_SYSRST_I2STX1_BCLK              104
> +#define JH7110_SYSRST_TDM_AHB                  105
> +#define JH7110_SYSRST_TDM_CORE                 106
> +#define JH7110_SYSRST_TDM_APB                  107
> +#define JH7110_SYSRST_PWM_APB                  108
> +#define JH7110_SYSRST_WDT_APB                  109
> +#define JH7110_SYSRST_WDT_CORE                 110
> +#define JH7110_SYSRST_CAN0_APB                 111
> +#define JH7110_SYSRST_CAN0_CORE                        112
> +#define JH7110_SYSRST_CAN0_TIMER               113
> +#define JH7110_SYSRST_CAN1_APB                 114
> +#define JH7110_SYSRST_CAN1_CORE                        115
> +#define JH7110_SYSRST_CAN1_TIMER               116
> +#define JH7110_SYSRST_TIMER_APB                        117
> +#define JH7110_SYSRST_TIMER0                   118
> +#define JH7110_SYSRST_TIMER1                   119
> +#define JH7110_SYSRST_TIMER2                   120
> +#define JH7110_SYSRST_TIMER3                   121
> +#define JH7110_SYSRST_INT_CTRL_APB             122
> +#define JH7110_SYSRST_TEMP_APB                 123
> +#define JH7110_SYSRST_TEMP_CORE                        124
> +#define JH7110_SYSRST_JTAG_CERTIFICATION       125
> +
> +#define        JH7110_SYSRST_END                       126
> +
> +/* AONCRG resets */
> +#define JH7110_AONRST_GMAC0_AXI                        0
> +#define JH7110_AONRST_GMAC0_AHB                        1
> +#define JH7110_AONRST_AON_IOMUX                        2
> +#define JH7110_AONRST_PMU_APB                  3
> +#define JH7110_AONRST_PMU_WKUP                 4
> +#define JH7110_AONRST_RTC_APB                  5
> +#define JH7110_AONRST_RTC_CAL                  6
> +#define JH7110_AONRST_RTC_32K                  7
> +
> +#define        JH7110_AONRST_END                       8
> +
> +#endif /* __DT_BINDINGS_RESET_STARFIVE_JH7110_H__ */
> --
> 2.38.1
>
