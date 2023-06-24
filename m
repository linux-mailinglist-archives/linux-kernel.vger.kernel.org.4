Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C7A73CAB5
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 14:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbjFXMMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 08:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjFXMMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 08:12:09 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A322117
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 05:12:05 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b698371937so2036301fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 05:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687608723; x=1690200723;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nrorAtyXHDvK4+yqW8BTAi4MuXFlsJT6rKJPKPCZNHs=;
        b=HIyq4wwbvds5XlEzlSzOV+h4xpqjTasXpmzDGwc24e/uvWgsMOg7uO6MSHUV4aIOGy
         MrVpiZJNvfYy6D/V33mymRkSjMSZEHQ5XYDjGEpHMyp7LpOxt+k5woazj2FhiRzLVgHb
         ESQ809FGNqmPnjZox5cRZMeBOIOqiZB4l+xKp/rRMpn7noKKfrK+WX1iuK6uXHfPPqIk
         qIsp9JO3HOwgGP+JucE9b4MTptwqvXiGyXrWHZmHlLEUIZ2GOcoR2J7E76urP+GJfJwG
         sDDGcMBBF20uFHM4e3LPQ+oIXbEOqvhf9EORgzHtvoEz4YY4+kAMRQQ/OqG2Ym2wuYaw
         Kv2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687608723; x=1690200723;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nrorAtyXHDvK4+yqW8BTAi4MuXFlsJT6rKJPKPCZNHs=;
        b=ecEeIJYeJ2MJ8WLAChWrYodNvW2wzpgYIpTFsU1lj7wEBJ9l7LBmb9dLYl+5dQHmIk
         fAW0rCGv1ZTup9VVWK36QrkklgfRhfHIRNGVFyv9KTx8F2dbprTYHZsM/0VbqbkX1uKu
         n1M6fYk/9B964IdykMJgWHZ1rrIcdP139HDX6jo9oLhtxswIYfLF6AgeTh1ArrNqlARg
         G8LOu3fxu7GLj72CL47cF555ZR+F6o37nXZwrriyEqmegwtFe8W2yPbpQIUN6y9AiV4c
         agJckFELLtNerVfz7wxQMrLtUFWuAY4cISVQjgQUewE+iy7+yTOy9BghNOXykYxBtdDu
         lInQ==
X-Gm-Message-State: AC+VfDzB/JXe+vVZFlqLAMevMU7CmFxHGdp41MBUkz9WX9ZusapnGxMw
        bJuAz0ZboVWGkxZcSofBCrreHQ==
X-Google-Smtp-Source: ACHHUZ5JuQotkQg4A/yksNX+MMCmt7KprzwkInCnhFdFAVBu8ip0CLQrIjTcHDguCpPn0syGIWPY4g==
X-Received: by 2002:a05:651c:8b:b0:2b5:8ff0:4134 with SMTP id 11-20020a05651c008b00b002b58ff04134mr5466649ljq.34.1687608723129;
        Sat, 24 Jun 2023 05:12:03 -0700 (PDT)
Received: from [192.168.1.101] (abyk197.neoplus.adsl.tpnet.pl. [83.9.30.197])
        by smtp.gmail.com with ESMTPSA id i20-20020a05651c121400b002b465bf0d7asm253761lja.68.2023.06.24.05.12.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jun 2023 05:12:02 -0700 (PDT)
Message-ID: <851790f2-f673-f754-08b8-d07cc2c809fb@linaro.org>
Date:   Sat, 24 Jun 2023 14:12:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 2/3] pinctrl: qcom: sm8350-lpass-lpi: add SM8350 LPASS
 TLMM
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230619092735.20323-1-krzysztof.kozlowski@linaro.org>
 <20230619092735.20323-2-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230619092735.20323-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
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

On 19.06.2023 11:27, Krzysztof Kozlowski wrote:
> Add driver for pin controller in Low Power Audio SubSystem (LPASS).  The
> driver is similar to SM8250 LPASS pin controller, with difference in one
> new pin (gpio14).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
diff <(sed s/8350/8250/g drivers/pinctrl/qcom/pinctrl-sm8350-lpass-lpi.c) drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c

<  * Copyright (c) 20202-2023 Linaro Ltd.
---
>  * Copyright (c) 2020 Linaro Ltd.
33d32
<       LPI_MUX_swr_tx_data2,
54d52
< static int gpio14_pins[] = { 14 };
71d68
<       PINCTRL_PIN(14, "gpio14"),
75c72
< static const char * const swr_tx_data_groups[] = { "gpio1", "gpio2", "gpio5", "gpio14" };
---
> static const char * const swr_tx_data_groups[] = { "gpio1", "gpio2", "gpio5" };
111d107
<       LPI_PINGROUP(14, 6, swr_rx_data, _, _, _),



I really think adding just these pin14 entries to the 8250 driver would
be a good idea..

Konrad
> 
> Changes in v2:
> 1. Typo in commit msg SM8450->SM8250
> 2. Typo in Kconfig entry (SM3550->SM8350)
> ---
>  drivers/pinctrl/qcom/Kconfig                  |  10 ++
>  drivers/pinctrl/qcom/Makefile                 |   1 +
>  .../pinctrl/qcom/pinctrl-sm8350-lpass-lpi.c   | 167 ++++++++++++++++++
>  3 files changed, 178 insertions(+)
>  create mode 100644 drivers/pinctrl/qcom/pinctrl-sm8350-lpass-lpi.c
> 
> diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
> index 634c75336983..643f1d7a531e 100644
> --- a/drivers/pinctrl/qcom/Kconfig
> +++ b/drivers/pinctrl/qcom/Kconfig
> @@ -77,6 +77,16 @@ config PINCTRL_SM8250_LPASS_LPI
>  	  Qualcomm Technologies Inc LPASS (Low Power Audio SubSystem) LPI
>  	  (Low Power Island) found on the Qualcomm Technologies Inc SM8250 platform.
>  
> +config PINCTRL_SM8350_LPASS_LPI
> +	tristate "Qualcomm Technologies Inc SM8350 LPASS LPI pin controller driver"
> +	depends on ARM64 || COMPILE_TEST
> +	depends on PINCTRL_LPASS_LPI
> +	help
> +	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> +	  Qualcomm Technologies Inc LPASS (Low Power Audio SubSystem) LPI
> +	  (Low Power Island) found on the Qualcomm Technologies Inc SM8350
> +	  platform.
> +
>  config PINCTRL_SM8450_LPASS_LPI
>  	tristate "Qualcomm Technologies Inc SM8450 LPASS LPI pin controller driver"
>  	depends on ARM64 || COMPILE_TEST
> diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
> index 426ddbf35f32..76ffcfbffc8e 100644
> --- a/drivers/pinctrl/qcom/Makefile
> +++ b/drivers/pinctrl/qcom/Makefile
> @@ -52,6 +52,7 @@ obj-$(CONFIG_PINCTRL_SM8150) += pinctrl-sm8150.o
>  obj-$(CONFIG_PINCTRL_SM8250) += pinctrl-sm8250.o
>  obj-$(CONFIG_PINCTRL_SM8250_LPASS_LPI) += pinctrl-sm8250-lpass-lpi.o
>  obj-$(CONFIG_PINCTRL_SM8350) += pinctrl-sm8350.o
> +obj-$(CONFIG_PINCTRL_SM8350_LPASS_LPI) += pinctrl-sm8350-lpass-lpi.o
>  obj-$(CONFIG_PINCTRL_SM8450) += pinctrl-sm8450.o
>  obj-$(CONFIG_PINCTRL_SM8450_LPASS_LPI) += pinctrl-sm8450-lpass-lpi.o
>  obj-$(CONFIG_PINCTRL_SM8550) += pinctrl-sm8550.o
> diff --git a/drivers/pinctrl/qcom/pinctrl-sm8350-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-sm8350-lpass-lpi.c
> new file mode 100644
> index 000000000000..23cce59d1a95
> --- /dev/null
> +++ b/drivers/pinctrl/qcom/pinctrl-sm8350-lpass-lpi.c
> @@ -0,0 +1,167 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2016-2019, The Linux Foundation. All rights reserved.
> + * Copyright (c) 20202-2023 Linaro Ltd.
> + */
> +
> +#include <linux/gpio/driver.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +#include "pinctrl-lpass-lpi.h"
> +
> +enum lpass_lpi_functions {
> +	LPI_MUX_dmic1_clk,
> +	LPI_MUX_dmic1_data,
> +	LPI_MUX_dmic2_clk,
> +	LPI_MUX_dmic2_data,
> +	LPI_MUX_dmic3_clk,
> +	LPI_MUX_dmic3_data,
> +	LPI_MUX_i2s1_clk,
> +	LPI_MUX_i2s1_data,
> +	LPI_MUX_i2s1_ws,
> +	LPI_MUX_i2s2_clk,
> +	LPI_MUX_i2s2_data,
> +	LPI_MUX_i2s2_ws,
> +	LPI_MUX_qua_mi2s_data,
> +	LPI_MUX_qua_mi2s_sclk,
> +	LPI_MUX_qua_mi2s_ws,
> +	LPI_MUX_swr_rx_clk,
> +	LPI_MUX_swr_rx_data,
> +	LPI_MUX_swr_tx_clk,
> +	LPI_MUX_swr_tx_data,
> +	LPI_MUX_swr_tx_data2,
> +	LPI_MUX_wsa_swr_clk,
> +	LPI_MUX_wsa_swr_data,
> +	LPI_MUX_gpio,
> +	LPI_MUX__,
> +};
> +
> +static int gpio0_pins[] = { 0 };
> +static int gpio1_pins[] = { 1 };
> +static int gpio2_pins[] = { 2 };
> +static int gpio3_pins[] = { 3 };
> +static int gpio4_pins[] = { 4 };
> +static int gpio5_pins[] = { 5 };
> +static int gpio6_pins[] = { 6 };
> +static int gpio7_pins[] = { 7 };
> +static int gpio8_pins[] = { 8 };
> +static int gpio9_pins[] = { 9 };
> +static int gpio10_pins[] = { 10 };
> +static int gpio11_pins[] = { 11 };
> +static int gpio12_pins[] = { 12 };
> +static int gpio13_pins[] = { 13 };
> +static int gpio14_pins[] = { 14 };
> +
> +static const struct pinctrl_pin_desc sm8350_lpi_pins[] = {
> +	PINCTRL_PIN(0, "gpio0"),
> +	PINCTRL_PIN(1, "gpio1"),
> +	PINCTRL_PIN(2, "gpio2"),
> +	PINCTRL_PIN(3, "gpio3"),
> +	PINCTRL_PIN(4, "gpio4"),
> +	PINCTRL_PIN(5, "gpio5"),
> +	PINCTRL_PIN(6, "gpio6"),
> +	PINCTRL_PIN(7, "gpio7"),
> +	PINCTRL_PIN(8, "gpio8"),
> +	PINCTRL_PIN(9, "gpio9"),
> +	PINCTRL_PIN(10, "gpio10"),
> +	PINCTRL_PIN(11, "gpio11"),
> +	PINCTRL_PIN(12, "gpio12"),
> +	PINCTRL_PIN(13, "gpio13"),
> +	PINCTRL_PIN(14, "gpio14"),
> +};
> +
> +static const char * const swr_tx_clk_groups[] = { "gpio0" };
> +static const char * const swr_tx_data_groups[] = { "gpio1", "gpio2", "gpio5", "gpio14" };
> +static const char * const swr_rx_clk_groups[] = { "gpio3" };
> +static const char * const swr_rx_data_groups[] = { "gpio4", "gpio5" };
> +static const char * const dmic1_clk_groups[] = { "gpio6" };
> +static const char * const dmic1_data_groups[] = { "gpio7" };
> +static const char * const dmic2_clk_groups[] = { "gpio8" };
> +static const char * const dmic2_data_groups[] = { "gpio9" };
> +static const char * const i2s2_clk_groups[] = { "gpio10" };
> +static const char * const i2s2_ws_groups[] = { "gpio11" };
> +static const char * const dmic3_clk_groups[] = { "gpio12" };
> +static const char * const dmic3_data_groups[] = { "gpio13" };
> +static const char * const qua_mi2s_sclk_groups[] = { "gpio0" };
> +static const char * const qua_mi2s_ws_groups[] = { "gpio1" };
> +static const char * const qua_mi2s_data_groups[] = { "gpio2", "gpio3", "gpio4" };
> +static const char * const i2s1_clk_groups[] = { "gpio6" };
> +static const char * const i2s1_ws_groups[] = { "gpio7" };
> +static const char * const i2s1_data_groups[] = { "gpio8", "gpio9" };
> +static const char * const wsa_swr_clk_groups[] = { "gpio10" };
> +static const char * const wsa_swr_data_groups[] = { "gpio11" };
> +static const char * const i2s2_data_groups[] = { "gpio12", "gpio12" };
> +
> +static const struct lpi_pingroup sm8350_groups[] = {
> +	LPI_PINGROUP(0, 0, swr_tx_clk, qua_mi2s_sclk, _, _),
> +	LPI_PINGROUP(1, 2, swr_tx_data, qua_mi2s_ws, _, _),
> +	LPI_PINGROUP(2, 4, swr_tx_data, qua_mi2s_data, _, _),
> +	LPI_PINGROUP(3, 8, swr_rx_clk, qua_mi2s_data, _, _),
> +	LPI_PINGROUP(4, 10, swr_rx_data, qua_mi2s_data, _, _),
> +	LPI_PINGROUP(5, 12, swr_tx_data, swr_rx_data, _, _),
> +	LPI_PINGROUP(6, LPI_NO_SLEW, dmic1_clk, i2s1_clk, _,  _),
> +	LPI_PINGROUP(7, LPI_NO_SLEW, dmic1_data, i2s1_ws, _, _),
> +	LPI_PINGROUP(8, LPI_NO_SLEW, dmic2_clk, i2s1_data, _, _),
> +	LPI_PINGROUP(9, LPI_NO_SLEW, dmic2_data, i2s1_data, _, _),
> +	LPI_PINGROUP(10, 16, i2s2_clk, wsa_swr_clk, _, _),
> +	LPI_PINGROUP(11, 18, i2s2_ws, wsa_swr_data, _, _),
> +	LPI_PINGROUP(12, LPI_NO_SLEW, dmic3_clk, i2s2_data, _, _),
> +	LPI_PINGROUP(13, LPI_NO_SLEW, dmic3_data, i2s2_data, _, _),
> +	LPI_PINGROUP(14, 6, swr_rx_data, _, _, _),
> +};
> +
> +static const struct lpi_function sm8350_functions[] = {
> +	LPI_FUNCTION(dmic1_clk),
> +	LPI_FUNCTION(dmic1_data),
> +	LPI_FUNCTION(dmic2_clk),
> +	LPI_FUNCTION(dmic2_data),
> +	LPI_FUNCTION(dmic3_clk),
> +	LPI_FUNCTION(dmic3_data),
> +	LPI_FUNCTION(i2s1_clk),
> +	LPI_FUNCTION(i2s1_data),
> +	LPI_FUNCTION(i2s1_ws),
> +	LPI_FUNCTION(i2s2_clk),
> +	LPI_FUNCTION(i2s2_data),
> +	LPI_FUNCTION(i2s2_ws),
> +	LPI_FUNCTION(qua_mi2s_data),
> +	LPI_FUNCTION(qua_mi2s_sclk),
> +	LPI_FUNCTION(qua_mi2s_ws),
> +	LPI_FUNCTION(swr_rx_clk),
> +	LPI_FUNCTION(swr_rx_data),
> +	LPI_FUNCTION(swr_tx_clk),
> +	LPI_FUNCTION(swr_tx_data),
> +	LPI_FUNCTION(wsa_swr_clk),
> +	LPI_FUNCTION(wsa_swr_data),
> +};
> +
> +static const struct lpi_pinctrl_variant_data sm8350_lpi_data = {
> +	.pins = sm8350_lpi_pins,
> +	.npins = ARRAY_SIZE(sm8350_lpi_pins),
> +	.groups = sm8350_groups,
> +	.ngroups = ARRAY_SIZE(sm8350_groups),
> +	.functions = sm8350_functions,
> +	.nfunctions = ARRAY_SIZE(sm8350_functions),
> +};
> +
> +static const struct of_device_id lpi_pinctrl_of_match[] = {
> +	{
> +	       .compatible = "qcom,sm8350-lpass-lpi-pinctrl",
> +	       .data = &sm8350_lpi_data,
> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, lpi_pinctrl_of_match);
> +
> +static struct platform_driver lpi_pinctrl_driver = {
> +	.driver = {
> +		   .name = "qcom-sm8350-lpass-lpi-pinctrl",
> +		   .of_match_table = lpi_pinctrl_of_match,
> +	},
> +	.probe = lpi_pinctrl_probe,
> +	.remove = lpi_pinctrl_remove,
> +};
> +
> +module_platform_driver(lpi_pinctrl_driver);
> +MODULE_DESCRIPTION("QTI SM8350 LPI GPIO pin control driver");
> +MODULE_LICENSE("GPL");
