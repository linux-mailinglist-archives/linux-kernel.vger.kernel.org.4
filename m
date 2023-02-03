Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 544F968A4AF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 22:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233618AbjBCVcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 16:32:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjBCVcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 16:32:48 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17AF2A7ECC
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 13:32:41 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id u21so6452992edv.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 13:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yey0p1seFXAn6EiSrTtRYpFOK3n1vR3Pqn+tImPmqv0=;
        b=sMOcOPyCJHng+vKzMoKNrmhoxpsv+WFZnQZtLMhBZnBbAYZWwULAFdxbc7vw4AGUP6
         S3NSGz43vPUYpNZnA6278i8gFvic2hLO/STm9mA/Fku4xUpDbMhBo4OEuRfOqsAQx+4p
         YZME2Yga5CiSlSaa9zE2n6FSK+ndDvBw8eZNUb4uKryWnnQmgnDKPzn/M/9VHk1qcFMO
         Ka7cRwJPNUweRw0thbn0kAx1ykyXsaYPIH6fE7mL14ybYGHqJOBbxprvCPTHqbfQwTgR
         0/Sz2NyM22okUgwG+vGfQG/gWylf2CI8N66jK7OcV3N/yj/P60Zh/yF9T7t/UWKmVTmB
         T94g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yey0p1seFXAn6EiSrTtRYpFOK3n1vR3Pqn+tImPmqv0=;
        b=XuG1wdXv/mwplh+Ok0YZjKUg9Vj423/tEcMzfuOji0Y+9c4+F9nf42DnB1c/p7hCS/
         wVyscOriD75my6DKfSxuHPgy21SdMLXzbLEWU9/AnBmF3gavbiCXsrBKSbiT6BiHSnuk
         0i50MKCcOkZ8ebUC1nKWLr9thNVK4415aLuEVPLChd2ZxcXsFHxU5/vle9cBDabPwhk5
         tpJVmy4YKCh58xvT9fN0IJXrZPCctH+oI/cZLlSJIeSp0v42gQWRJ5Huji9puxluoSro
         fmm30hkkt2xqCd+cDCykfxRKV4ittUigTQqD374MTAcceX7q9qY93Ny42+PmCjVLKIcq
         RxvQ==
X-Gm-Message-State: AO0yUKW7SPGWcROF+U/QUFuB4xDG6225JURdKxsX5kHw0vu0phtVItiv
        eZ3Suq9ZNNCQUvzEIgpzBsZVgA==
X-Google-Smtp-Source: AK7set/grZmJOl/DE1+GJSHJGyTY8mkZ07+xkqeG5xKUTb3yXnJXa8OSEG+pEe8bSsFzl8jbwmVo8Q==
X-Received: by 2002:aa7:d98d:0:b0:4a2:1b8c:5b58 with SMTP id u13-20020aa7d98d000000b004a21b8c5b58mr12328438eds.34.1675459959494;
        Fri, 03 Feb 2023 13:32:39 -0800 (PST)
Received: from [192.168.1.101] (abyl20.neoplus.adsl.tpnet.pl. [83.9.31.20])
        by smtp.gmail.com with ESMTPSA id by25-20020a0564021b1900b004a914e093bdsm1579861edb.84.2023.02.03.13.32.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 13:32:39 -0800 (PST)
Message-ID: <a193f1ed-868c-d2de-adf3-5084cae50be3@linaro.org>
Date:   Fri, 3 Feb 2023 22:32:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 2/2] pinctrl: qcom: pinctrl-sm8550-lpass-lpi: add SM8550
 LPASS
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230203174645.597053-1-krzysztof.kozlowski@linaro.org>
 <20230203174645.597053-2-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230203174645.597053-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3.02.2023 18:46, Krzysztof Kozlowski wrote:
> Add druver for pin controller in Low Power Audio SubSystem (LPASS).  The
> driver is similar to SM8450 LPASS pin controller, with differences in
> few pin groups (qua_mi2s -> i2s0).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/pinctrl/qcom/Kconfig                  |  11 +
>  drivers/pinctrl/qcom/Makefile                 |   1 +
>  .../pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c   | 240 ++++++++++++++++++
>  3 files changed, 252 insertions(+)
>  create mode 100644 drivers/pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c
> 
> diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
> index 8d4f871e07cf..6e306992fad9 100644
> --- a/drivers/pinctrl/qcom/Kconfig
> +++ b/drivers/pinctrl/qcom/Kconfig
> @@ -486,6 +486,17 @@ config PINCTRL_SM8550
>  	  Qualcomm Technologies Inc TLMM block found on the Qualcomm
>  	  Technologies Inc SM8550 platform.
>  
> +config PINCTRL_SM8550_LPASS_LPI
> +	tristate "Qualcomm Technologies Inc SM8550 LPASS LPI pin controller driver"
> +	depends on GPIOLIB
> +	depends on ARM64 || COMPILE_TEST
> +	depends on PINCTRL_LPASS_LPI
> +	help
> +	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> +	  Qualcomm Technologies Inc LPASS (Low Power Audio SubSystem) LPI
> +	  (Low Power Island) found on the Qualcomm Technologies Inc SM8550
> +	  platform.
> +
>  config PINCTRL_LPASS_LPI
>  	tristate "Qualcomm Technologies Inc LPASS LPI pin controller driver"
>  	select PINMUX
> diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
> index 6763aa8d319c..37bfbcf8234b 100644
> --- a/drivers/pinctrl/qcom/Makefile
> +++ b/drivers/pinctrl/qcom/Makefile
> @@ -50,5 +50,6 @@ obj-$(CONFIG_PINCTRL_SM8350) += pinctrl-sm8350.o
>  obj-$(CONFIG_PINCTRL_SM8450) += pinctrl-sm8450.o
>  obj-$(CONFIG_PINCTRL_SM8450_LPASS_LPI) += pinctrl-sm8450-lpass-lpi.o
>  obj-$(CONFIG_PINCTRL_SM8550) += pinctrl-sm8550.o
> +obj-$(CONFIG_PINCTRL_SM8550_LPASS_LPI) += pinctrl-sm8550-lpass-lpi.o
>  obj-$(CONFIG_PINCTRL_SC8280XP_LPASS_LPI) += pinctrl-sc8280xp-lpass-lpi.o
>  obj-$(CONFIG_PINCTRL_LPASS_LPI) += pinctrl-lpass-lpi.o
> diff --git a/drivers/pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c
> new file mode 100644
> index 000000000000..c2bdd936d27f
> --- /dev/null
> +++ b/drivers/pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c
> @@ -0,0 +1,240 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022-2023 Linaro Ltd.
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
> +	LPI_MUX_dmic4_clk,
> +	LPI_MUX_dmic4_data,
> +	LPI_MUX_i2s0_clk,
> +	LPI_MUX_i2s0_data,
> +	LPI_MUX_i2s0_ws,
> +	LPI_MUX_i2s1_clk,
> +	LPI_MUX_i2s1_data,
> +	LPI_MUX_i2s1_ws,
> +	LPI_MUX_i2s2_clk,
> +	LPI_MUX_i2s2_data,
> +	LPI_MUX_i2s2_ws,
> +	LPI_MUX_i2s3_clk,
> +	LPI_MUX_i2s3_data,
> +	LPI_MUX_i2s3_ws,
> +	LPI_MUX_i2s4_clk,
> +	LPI_MUX_i2s4_data,
> +	LPI_MUX_i2s4_ws,
> +	LPI_MUX_slimbus_clk,
> +	LPI_MUX_slimbus_data,
> +	LPI_MUX_swr_rx_clk,
> +	LPI_MUX_swr_rx_data,
> +	LPI_MUX_swr_tx_clk,
> +	LPI_MUX_swr_tx_data,
> +	LPI_MUX_wsa_swr_clk,
> +	LPI_MUX_wsa_swr_data,
> +	LPI_MUX_wsa2_swr_clk,
> +	LPI_MUX_wsa2_swr_data,
> +	LPI_MUX_ext_mclk1_a,
> +	LPI_MUX_ext_mclk1_b,
> +	LPI_MUX_ext_mclk1_c,
> +	LPI_MUX_ext_mclk1_d,
> +	LPI_MUX_ext_mclk1_e,
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
> +static int gpio15_pins[] = { 15 };
> +static int gpio16_pins[] = { 16 };
> +static int gpio17_pins[] = { 17 };
> +static int gpio18_pins[] = { 18 };
> +static int gpio19_pins[] = { 19 };
> +static int gpio20_pins[] = { 20 };
> +static int gpio21_pins[] = { 21 };
> +static int gpio22_pins[] = { 22 };
> +
> +static const struct pinctrl_pin_desc sm8550_lpi_pins[] = {
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
> +	PINCTRL_PIN(15, "gpio15"),
> +	PINCTRL_PIN(16, "gpio16"),
> +	PINCTRL_PIN(17, "gpio17"),
> +	PINCTRL_PIN(18, "gpio18"),
> +	PINCTRL_PIN(19, "gpio19"),
> +	PINCTRL_PIN(20, "gpio20"),
> +	PINCTRL_PIN(21, "gpio21"),
> +	PINCTRL_PIN(22, "gpio22"),
> +};
> +
> +static const char * const dmic1_clk_groups[] = { "gpio6" };
> +static const char * const dmic1_data_groups[] = { "gpio7" };
> +static const char * const dmic2_clk_groups[] = { "gpio8" };
> +static const char * const dmic2_data_groups[] = { "gpio9" };
> +static const char * const dmic3_clk_groups[] = { "gpio12" };
> +static const char * const dmic3_data_groups[] = { "gpio13" };
> +static const char * const dmic4_clk_groups[] = { "gpio17" };
> +static const char * const dmic4_data_groups[] = { "gpio18" };
> +static const char * const i2s0_clk_groups[] = { "gpio0" };
> +static const char * const i2s0_ws_groups[] = { "gpio1" };
> +static const char * const i2s0_data_groups[] = { "gpio2", "gpio3", "gpio4", "gpio5" };
> +static const char * const i2s1_clk_groups[] = { "gpio6" };
> +static const char * const i2s1_ws_groups[] = { "gpio7" };
> +static const char * const i2s1_data_groups[] = { "gpio8", "gpio9" };
> +static const char * const i2s2_clk_groups[] = { "gpio10" };
> +static const char * const i2s2_ws_groups[] = { "gpio11" };
> +static const char * const i2s2_data_groups[] = { "gpio15", "gpio16" };
> +static const char * const i2s3_clk_groups[] = { "gpio12" };
> +static const char * const i2s3_ws_groups[] = { "gpio13" };
> +static const char * const i2s3_data_groups[] = { "gpio17", "gpio18" };
> +static const char * const i2s4_clk_groups[] = { "gpio19"};
> +static const char * const i2s4_ws_groups[] = { "gpio20"};
> +static const char * const i2s4_data_groups[] = { "gpio21", "gpio22"};
> +static const char * const slimbus_clk_groups[] = { "gpio19"};
> +static const char * const slimbus_data_groups[] = { "gpio20"};
> +static const char * const swr_tx_clk_groups[] = { "gpio0" };
> +static const char * const swr_tx_data_groups[] = { "gpio1", "gpio2", "gpio14" };
> +static const char * const swr_rx_clk_groups[] = { "gpio3" };
> +static const char * const swr_rx_data_groups[] = { "gpio4", "gpio5", "gpio15" };
> +static const char * const wsa_swr_clk_groups[] = { "gpio10" };
> +static const char * const wsa_swr_data_groups[] = { "gpio11" };
> +static const char * const wsa2_swr_clk_groups[] = { "gpio15" };
> +static const char * const wsa2_swr_data_groups[] = { "gpio16" };
> +static const char * const ext_mclk1_c_groups[] = { "gpio5" };
> +static const char * const ext_mclk1_b_groups[] = { "gpio9" };
> +static const char * const ext_mclk1_a_groups[] = { "gpio13" };
> +static const char * const ext_mclk1_d_groups[] = { "gpio14" };
> +static const char * const ext_mclk1_e_groups[] = { "gpio22" };
> +
> +static const struct lpi_pingroup sm8550_groups[] = {
> +	LPI_PINGROUP(0, 0, swr_tx_clk, i2s0_clk, _, _),
> +	LPI_PINGROUP(1, 2, swr_tx_data, i2s0_ws, _, _),
> +	LPI_PINGROUP(2, 4, swr_tx_data, i2s0_data, _, _),
> +	LPI_PINGROUP(3, 8, swr_rx_clk, i2s0_data, _, _),
> +	LPI_PINGROUP(4, 10, swr_rx_data, i2s0_data, _, _),
> +	LPI_PINGROUP(5, 12, swr_rx_data, ext_mclk1_c, i2s0_data, _),
> +	LPI_PINGROUP(6, LPI_NO_SLEW, dmic1_clk, i2s1_clk, _,  _),
> +	LPI_PINGROUP(7, LPI_NO_SLEW, dmic1_data, i2s1_ws, _, _),
> +	LPI_PINGROUP(8, LPI_NO_SLEW, dmic2_clk, i2s1_data, _, _),
> +	LPI_PINGROUP(9, LPI_NO_SLEW, dmic2_data, i2s1_data, ext_mclk1_b, _),
> +	LPI_PINGROUP(10, 16, i2s2_clk, wsa_swr_clk, _, _),
> +	LPI_PINGROUP(11, 18, i2s2_ws, wsa_swr_data, _, _),
> +	LPI_PINGROUP(12, LPI_NO_SLEW, dmic3_clk, i2s3_clk, _, _),
> +	LPI_PINGROUP(13, LPI_NO_SLEW, dmic3_data, i2s3_ws, ext_mclk1_a, _),
> +	LPI_PINGROUP(14, 6, swr_tx_data, ext_mclk1_d, _, _),
> +	LPI_PINGROUP(15, 20, i2s2_data, wsa2_swr_clk, _, _),
> +	LPI_PINGROUP(16, 22, i2s2_data, wsa2_swr_data, _, _),
> +	LPI_PINGROUP(17, LPI_NO_SLEW, dmic4_clk, i2s3_data, _, _),
> +	LPI_PINGROUP(18, LPI_NO_SLEW, dmic4_data, i2s3_data, _, _),
> +	LPI_PINGROUP(19, LPI_NO_SLEW, i2s4_clk, slimbus_clk, _, _),
> +	LPI_PINGROUP(20, LPI_NO_SLEW, i2s4_ws, slimbus_data, _, _),
> +	LPI_PINGROUP(21, LPI_NO_SLEW, i2s4_data, _, _, _),
> +	LPI_PINGROUP(22, LPI_NO_SLEW, i2s4_data, ext_mclk1_e, _, _),
> +};
> +
> +static const struct lpi_function sm8550_functions[] = {
> +	LPI_FUNCTION(dmic1_clk),
> +	LPI_FUNCTION(dmic1_data),
> +	LPI_FUNCTION(dmic2_clk),
> +	LPI_FUNCTION(dmic2_data),
> +	LPI_FUNCTION(dmic3_clk),
> +	LPI_FUNCTION(dmic3_data),
> +	LPI_FUNCTION(dmic4_clk),
> +	LPI_FUNCTION(dmic4_data),
> +	LPI_FUNCTION(i2s0_clk),
> +	LPI_FUNCTION(i2s0_data),
> +	LPI_FUNCTION(i2s0_ws),
> +	LPI_FUNCTION(i2s1_clk),
> +	LPI_FUNCTION(i2s1_data),
> +	LPI_FUNCTION(i2s1_ws),
> +	LPI_FUNCTION(i2s2_clk),
> +	LPI_FUNCTION(i2s2_data),
> +	LPI_FUNCTION(i2s2_ws),
> +	LPI_FUNCTION(i2s3_clk),
> +	LPI_FUNCTION(i2s3_data),
> +	LPI_FUNCTION(i2s3_ws),
> +	LPI_FUNCTION(i2s4_clk),
> +	LPI_FUNCTION(i2s4_data),
> +	LPI_FUNCTION(i2s4_ws),
> +	LPI_FUNCTION(slimbus_clk),
> +	LPI_FUNCTION(slimbus_data),
> +	LPI_FUNCTION(swr_rx_clk),
> +	LPI_FUNCTION(swr_rx_data),
> +	LPI_FUNCTION(swr_tx_clk),
> +	LPI_FUNCTION(swr_tx_data),
> +	LPI_FUNCTION(wsa_swr_clk),
> +	LPI_FUNCTION(wsa_swr_data),
> +	LPI_FUNCTION(wsa2_swr_clk),
> +	LPI_FUNCTION(wsa2_swr_data),
> +	LPI_FUNCTION(ext_mclk1_a),
> +	LPI_FUNCTION(ext_mclk1_b),
> +	LPI_FUNCTION(ext_mclk1_c),
> +	LPI_FUNCTION(ext_mclk1_d),
> +	LPI_FUNCTION(ext_mclk1_e),
> +};
> +
> +static const struct lpi_pinctrl_variant_data sm8550_lpi_data = {
> +	.pins = sm8550_lpi_pins,
> +	.npins = ARRAY_SIZE(sm8550_lpi_pins),
> +	.groups = sm8550_groups,
> +	.ngroups = ARRAY_SIZE(sm8550_groups),
> +	.functions = sm8550_functions,
> +	.nfunctions = ARRAY_SIZE(sm8550_functions),
> +};
> +
> +static const struct of_device_id lpi_pinctrl_of_match[] = {
> +	{
> +	       .compatible = "qcom,sm8550-lpass-lpi-pinctrl",
> +	       .data = &sm8550_lpi_data,
> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, lpi_pinctrl_of_match);
> +
> +static struct platform_driver lpi_pinctrl_driver = {
> +	.driver = {
> +		   .name = "qcom-sm8550-lpass-lpi-pinctrl",
> +		   .of_match_table = lpi_pinctrl_of_match,
> +	},
> +	.probe = lpi_pinctrl_probe,
> +	.remove = lpi_pinctrl_remove,
> +};
> +
> +module_platform_driver(lpi_pinctrl_driver);
> +MODULE_DESCRIPTION("Qualcomm SM8550 LPI GPIO pin control driver");
> +MODULE_LICENSE("GPL");
