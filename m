Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38EA96B713A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 09:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjCMIf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 04:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjCMIfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 04:35:25 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294EA22DCF
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 01:35:23 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id by8so11732888ljb.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 01:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678696521;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9fOLfxr2tFyZ8Ujjcq3AaWQ606AZSrOlGsdgzotzics=;
        b=f8pXlW+uVXMvaG9QzGJMVHB6JxGFKjOa6DqBgJHwdOmqSEifTIhY8qUmfM19EMX3Ax
         uIysXmEHF5zyK76o8c04GEbA3xQ0KaHLHT3u5E2ibcCMyKmrgKLGpFrOBHxsRPli3tNL
         y6947MIvBIWTjfoIdypXd+pzNycq5SGEMX1nQAda803kni60npYzL+98+Uy5wg/mtNZF
         bA/AKiioMsB+DbWQ+IQhhxtQkIED0pmuw/er0YvGvbySwfQP4IzAfWKzil1kaWC0fJXS
         fh9EcuBKi0qU7S69l2Mxhcahe0zc4zMpq++yailgIZfRl13YLQhySsunCwG8j9EMXoK7
         qWyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678696521;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9fOLfxr2tFyZ8Ujjcq3AaWQ606AZSrOlGsdgzotzics=;
        b=0OqTZR7mR9Z73lXiBzIZ8JEjtGLQEh5mb/sLAbv/0aRrjuTH26GZPJZlbpr9+iPDvI
         Gw+GW4h9k97wKLnLDPn0mggBjIGQfqtfLB8w4UV1txqEepkIXyPgofI4sX0FYCyVoqu2
         Ll91KU3y2bSwvFAABEY7wUmOcQ/ykiYHYm+qsTAxXd0J7AjGgZGRIhs0vpQ1NT4y9JMu
         jRIAMspSj/hm67tpBVCN5khChzOZn1Zk6oMTcSP7mXSSzcQQi9XwsfgXTnUAKCp4/WyJ
         jj5rCfdlSKQUmiWpO/NgSLIfk7OWYBKQJBYNonTnIYHXJhv3wK/P3VZ09HlqU/PdSJne
         4AIA==
X-Gm-Message-State: AO0yUKWy5BNHMkO2x5yt3Y2FgHaGFg9CIoVJW3mJKXKP97DNL00v7Dcm
        WhpRb0cuQIU+FP81aKhoyASHyg==
X-Google-Smtp-Source: AK7set8gtwxVhuFnjOOT7P0gdtdrNECEDslg2x9ZHbr2yW275L0xatkFwKFoYS4LoiRV4QoyNE0GXg==
X-Received: by 2002:a05:651c:84:b0:293:4b96:1b6b with SMTP id 4-20020a05651c008400b002934b961b6bmr10530413ljq.25.1678696521382;
        Mon, 13 Mar 2023 01:35:21 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id a21-20020a05651c011500b00298704f1324sm923271ljb.33.2023.03.13.01.35.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 01:35:20 -0700 (PDT)
Message-ID: <1bae0e50-7d56-986b-7e07-36a8aab31082@linaro.org>
Date:   Mon, 13 Mar 2023 09:35:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 3/3] arm64: dts: qcom: msm8916-yiming-uz801v3: Add initial
 device tree
Content-Language: en-US
To:     Yang Xiwen <forbidden405@foxmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>
References: <20230310143330.9485-1-forbidden405@foxmail.com>
 <tencent_62395CA0D608DD0078DD3D889F6E4E22BA05@qq.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <tencent_62395CA0D608DD0078DD3D889F6E4E22BA05@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10.03.2023 15:33, Yang Xiwen wrote:
> This commit adds support for the uz801 v3.0 WiFi/LTE dongle made by
> Henan Yiming Technology Co., Ltd. based on MSM8916.
> 
> Note: The original firmware does not support 64-bit OS. It is necessary
> to flash 64-bit TZ firmware to boot arm64.
> 
> Currently supported:
> - All CPU cores
> - Buttons
> - LEDs
> - Modem
> - SDHC
> - USB Device Mode
> - UART
> 
> Signed-off-by: Yang Xiwen <forbidden405@foxmail.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/Makefile             |  1 +
>  .../boot/dts/qcom/msm8916-yiming-uz801v3.dts  | 35 +++++++++++++++++++
>  2 files changed, 36 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8916-yiming-uz801v3.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 31aa54f0428c3..0c4c71d6277b7 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -28,6 +28,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-serranove.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-thwc-uf896.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-thwc-ufi001c.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-wingtech-wt88047.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-yiming-uz801v3.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-motorola-potter.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-xiaomi-daisy.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-xiaomi-mido.dtb
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-yiming-uz801v3.dts b/arch/arm64/boot/dts/qcom/msm8916-yiming-uz801v3.dts
> new file mode 100644
> index 0000000000000..74ce6563be183
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8916-yiming-uz801v3.dts
> @@ -0,0 +1,35 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +/dts-v1/;
> +
> +#include "msm8916-ufi.dtsi"
> +
> +/ {
> +	model = "uz801 v3.0 4G Modem Stick";
> +	compatible = "yiming,uz801-v3", "qcom,msm8916";
> +};
> +
> +&button_restart {
> +	gpios = <&msmgpio 23 GPIO_ACTIVE_LOW>;
> +};
> +
> +&led_r {
> +	gpios = <&msmgpio 7 GPIO_ACTIVE_HIGH>;
> +};
> +
> +&led_g {
> +	gpios = <&msmgpio 8 GPIO_ACTIVE_HIGH>;
> +};
> +
> +&led_b {
> +	gpios = <&msmgpio 6 GPIO_ACTIVE_HIGH>;
> +};
> +
> +&button_default {
> +	pins = "gpio23";
> +	bias-pull-up;
> +};
> +
> +&gpio_leds_default {
> +	pins = "gpio6", "gpio7", "gpio8";
> +};
