Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDCA2743FDE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 18:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbjF3Qc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 12:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbjF3QcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 12:32:07 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6764649ED
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 09:31:26 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-31297125334so1883785f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 09:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688142667; x=1690734667;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=f0qt0frxxKKp+v1aQwP5ebt6u2uU8PqBkcHGbpgYSx0=;
        b=jN13Cff+QWLqExNK/0jHIyoZOp/FRgNBzMHvGbweedixXHCqCflaAc6VmRQnLRCMl6
         QkVeRYiT/2M1iiJSJlIXXALVquw0GX7iHQ/tcw/CYisZ+uCL+KFzwqT9AaMh8n1r4MT8
         llpOy5LqrCCuQVNyQrDiuQvEOHwRMP88unjVy9pAIPg9EYhZ1m9sHzHl+m2qMO9zjD3G
         gxhBDy9R/OMZOfLhJYEoE1ZfuoS4g9VTcHUK1aqiWBvuMSYa4iGL+VMip2i9qluz11Yc
         aRQYQ82NQ0m7PdlLjlCtGsvmh1DurWT3BzKsHhhMfQom9ZXTtHUfZvyvnLD6EJK1MqTT
         palg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688142667; x=1690734667;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f0qt0frxxKKp+v1aQwP5ebt6u2uU8PqBkcHGbpgYSx0=;
        b=bQIAyjnuOiQTm3vdygMt5Z8nuzlSHrrU07KcP00Eb5hd76U7b4746R8bKKzlwsti+K
         SngSfRezhkY/Zuz//wj+jwKhLoa8NXyU1o7iX/E8dpDGgfFd9lWVH+Ps283LNUN6EZPg
         7rvhNRlzzEqUIK2CF1H77lhmoamClKg8S+U7P/eI0IVvrgLP8TqEWnQ+L8R20vYj2qbL
         lJSsjwyI/VvwmF20i5Y1oldseaVD6qbu1ejqc+FuxvFzwJN6uyWpCEbtgqyMOoK0ie+S
         B+sCSfoFzcU31Fu5wER1jXWJyFPnXj7BNfCtPcERLgyWzlTADGPszxXlWpGlC1MUGibP
         LdHA==
X-Gm-Message-State: ABy/qLYI5XrjUqtVSCepGI67Urdnuil8V9NxzB8ROKjeeBEFLMhQDQzn
        3bFydX7pzMzZF/E56GenSkfdEQ==
X-Google-Smtp-Source: APBJJlFRXVru6bzc3ZqFIQTYVBOPXO2D4SZ1ANqnJwL4EQVagGGQD26rE+6763+kt6xCmMZbnxmibw==
X-Received: by 2002:a5d:69cf:0:b0:307:7959:6461 with SMTP id s15-20020a5d69cf000000b0030779596461mr2768421wrw.31.1688142666708;
        Fri, 30 Jun 2023 09:31:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:eac6:eb92:cae4:cfd2? ([2a01:e0a:982:cbb0:eac6:eb92:cae4:cfd2])
        by smtp.gmail.com with ESMTPSA id d13-20020a5d4f8d000000b003063db8f45bsm18645263wru.23.2023.06.30.09.31.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jun 2023 09:31:04 -0700 (PDT)
Message-ID: <1f190620-2c83-0dce-b295-fa1a2860312e@linaro.org>
Date:   Fri, 30 Jun 2023 18:31:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/3] dt-bindings: reset: Add compatible and DT bindings
 for Meson-C3 Reset Controller
Content-Language: en-US
To:     zelong dong <zelong.dong@amlogic.com>, narmstrong@baylibre.com,
        p.zabel@pengutronix.de, khilman@baylibre.com,
        Rob Herring <robh+dt@kernel.org>,
        martin.blumenstingl@googlemail.com
Cc:     linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, jbrunet@baylibre.com,
        devicetree@vger.kernel.org, kelvin.zhang@amlogic.com
References: <20230630121059.28748-1-zelong.dong@amlogic.com>
 <20230630121059.28748-2-zelong.dong@amlogic.com>
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <20230630121059.28748-2-zelong.dong@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 30/06/2023 14:10, zelong dong wrote:
> From: Zelong Dong <zelong.dong@amlogic.com>
> 
> Add new compatible and DT bindings for Amlogic's Meson-C3 Reset Controller
> 
> Change-Id: Ie8941818bde5b736689e43367f66827c5bc0449e

Please drop Change-Id when sending patches upstream, same for patch 2

Thanks,
Neil

> Signed-off-by: Zelong Dong <zelong.dong@amlogic.com>
> ---
>   .../bindings/reset/amlogic,meson-reset.yaml   |   1 +
>   .../reset/amlogic,meson-c3-reset.h            | 119 ++++++++++++++++++
>   2 files changed, 120 insertions(+)
>   create mode 100644 include/dt-bindings/reset/amlogic,meson-c3-reset.h
> 
> diff --git a/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml b/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
> index d3fdee89d4f8..cf1da9f7bc51 100644
> --- a/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
> +++ b/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
> @@ -18,6 +18,7 @@ properties:
>         - amlogic,meson-axg-reset # Reset Controller on AXG and compatible SoCs
>         - amlogic,meson-a1-reset # Reset Controller on A1 and compatible SoCs
>         - amlogic,meson-s4-reset # Reset Controller on S4 and compatible SoCs
> +      - amlogic,meson-c3-reset # Reset Controller on C3 and compatible SoCs
>   
>     reg:
>       maxItems: 1
> diff --git a/include/dt-bindings/reset/amlogic,meson-c3-reset.h b/include/dt-bindings/reset/amlogic,meson-c3-reset.h
> new file mode 100644
> index 000000000000..24b39d60b2f7
> --- /dev/null
> +++ b/include/dt-bindings/reset/amlogic,meson-c3-reset.h
> @@ -0,0 +1,119 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> +/*
> + * Copyright (c) 2023 Amlogic, Inc. All rights reserved.
> + */
> +
> +#ifndef _DT_BINDINGS_AMLOGIC_MESON_C3_RESET_H
> +#define _DT_BINDINGS_AMLOGIC_MESON_C3_RESET_H
> +
> +/* RESET0 */
> +/*						0-3 */
> +#define RESET_USBCTRL				4
> +/*						5-7 */
> +#define RESET_USBPHY20				8
> +/*						9 */
> +#define RESET_USB2DRD				10
> +#define RESET_MIPI_DSI_HOST			11
> +#define RESET_MIPI_DSI_PHY			12
> +/*						13-20 */
> +#define RESET_GE2D				21
> +#define RESET_DWAP				22
> +/*						23-31 */
> +
> +/* RESET1 */
> +#define RESET_AUDIO				32
> +/*						33-34 */
> +#define RESET_DDRAPB				35
> +#define RESET_DDR				36
> +#define RESET_DOS_CAPB3				37
> +#define RESET_DOS				38
> +/*						39-46 */
> +#define RESET_NNA				47
> +#define RESET_ETHERNET				48
> +#define RESET_ISP				49
> +#define RESET_VC9000E_APB			50
> +#define RESET_VC9000E_A				51
> +/*						52 */
> +#define RESET_VC9000E_CORE			53
> +/*						54-63 */
> +
> +/* RESET2 */
> +#define RESET_ABUS_ARB				64
> +#define RESET_IRCTRL				65
> +/*						66 */
> +#define RESET_TEMP_PII				67
> +/*						68-72 */
> +#define RESET_SPICC_0				73
> +#define RESET_SPICC_1				74
> +#define RESET_RSA				75
> +
> +/*						76-79 */
> +#define RESET_MSR_CLK				80
> +#define RESET_SPIFC				81
> +#define RESET_SAR_ADC				82
> +/*						83-87 */
> +#define RESET_ACODEC				88
> +/*						89-90 */
> +#define RESET_WATCHDOG				91
> +/*						92-95 */
> +
> +/* RESET3 */
> +#define RESET_ISP_NIC_GPV			96
> +#define RESET_ISP_NIC_MAIN			97
> +#define RESET_ISP_NIC_VCLK			98
> +#define RESET_ISP_NIC_VOUT			99
> +#define RESET_ISP_NIC_ALL			100
> +#define RESET_VOUT				101
> +#define RESET_VOUT_VENC				102
> +/*						103 */
> +#define RESET_CVE_NIC_GPV			104
> +#define RESET_CVE_NIC_MAIN			105
> +#define RESET_CVE_NIC_GE2D			106
> +#define RESET_CVE_NIC_DW			106
> +#define RESET_CVE_NIC_CVE			108
> +#define RESET_CVE_NIC_ALL			109
> +#define RESET_CVE				110
> +/*						112-127 */
> +
> +/* RESET4 */
> +#define RESET_RTC				128
> +#define RESET_PWM_AB				129
> +#define RESET_PWM_CD				130
> +#define RESET_PWM_EF				131
> +#define RESET_PWM_GH				132
> +#define RESET_PWM_IJ				133
> +#define RESET_PWM_KL				134
> +#define RESET_PWM_MN				135
> +/*						136-137 */
> +#define RESET_UART_A				138
> +#define RESET_UART_B				139
> +#define RESET_UART_C				140
> +#define RESET_UART_D				141
> +#define RESET_UART_E				142
> +#define RESET_UART_F				143
> +#define RESET_I2C_S_A				144
> +#define RESET_I2C_M_A				145
> +#define RESET_I2C_M_B				146
> +#define RESET_I2C_M_C				147
> +#define RESET_I2C_M_D				148
> +/*						149-151 */
> +#define RESET_SD_EMMC_A				152
> +#define RESET_SD_EMMC_B				153
> +#define RESET_SD_EMMC_C				154
> +
> +/* RESET5 */
> +/*						160-172 */
> +#define RESET_BRG_NIC_NNA			173
> +#define RESET_BRG_MUX_NIC_MAIN			174
> +#define RESET_BRG_AO_NIC_ALL			175
> +/*						176-183 */
> +#define RESET_BRG_NIC_VAPB			184
> +#define RESET_BRG_NIC_SDIO_B			185
> +#define RESET_BRG_NIC_SDIO_A			186
> +#define RESET_BRG_NIC_EMMC			187
> +#define RESET_BRG_NIC_DSU			188
> +#define RESET_BRG_NIC_SYSCLK			189
> +#define RESET_BRG_NIC_MAIN			190
> +#define RESET_BRG_NIC_ALL			191
> +
> +#endif

