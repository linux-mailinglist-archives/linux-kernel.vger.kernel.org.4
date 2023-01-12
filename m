Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332DB667AE7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 17:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239546AbjALQcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 11:32:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239713AbjALQam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 11:30:42 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A546563
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 08:29:43 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id v25so29167681lfe.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 08:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ilEi74IrFuCrkVhzGsZjWLn3I71eXKXoDMxZ7J74eqQ=;
        b=Ugupxptx0i7QcoD+HK5DoSvpHp/RlGh65KKqjeqsKo0vgF7UVy3whNGXUxIZ5x4K+W
         BdxOyjl5lJpxaY9gbV7bIesByKELl4BjWPISkIplgE1dEeemSxpp3yEMpgQPDSnBSQoC
         Zzx9PSPuIX1JyYlxfvjIp1VRAR/3+twBzY5OQofHIHR4R06i9KnN1uCyhHZpOpDSwD9H
         1Xj0Idm1gvulyLoFeiTrRHH1xIcuOEGsQmvekmv+Y65/P/Iqsu/ooHitXOv53e25u6u5
         EJpwt1trYKIOewqVoxCR3Rt8HeQ3dU4sqBnQmICfyxWLHjYqvVhxzL7ltjzw7p6gr1BW
         7VLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ilEi74IrFuCrkVhzGsZjWLn3I71eXKXoDMxZ7J74eqQ=;
        b=xfZz6TVbXGI4QxAP6sSWrQ1VkSohD1MKpMeOAY+6Ng990mYFR5j5VqX+pE/WbT1yKS
         gdXr62sPAHMKUEvYKJUkkuLYY1IFlN4gI7o5NZS59PeOSlqjHpGFqkWPp8FrqIiQTTfe
         8vv9ZGvfcEWKgwK1YpjfnWea1yEcq4jb3U0PbB0/JcDwBhGGscSvh3IHrf3MVZ8Mk5cK
         xS6XQJJG+XhWc9IfoMsL43B0b/x5eHfZ6zwtNN1F99jAc6wDdGlGQJsH8aoQbYmVik3u
         XTZE13yNgLjFgivJAKXkOpVX/7BMT3xFQuADoX2qwdpOGzMwFDoc7E5KcT13D/jwJjcw
         v+7A==
X-Gm-Message-State: AFqh2kpyDQa41nGbfsSmt5+IS6fzLgLO0aIg10haevPEpdYinfRqVWw2
        omO0xuPrA+GSC7RP0D+9B85Axg==
X-Google-Smtp-Source: AMrXdXuVtn1eOd8SLJ2dWeafTMNDCFwbvN6M3bpHVsrnnW/GtgZfyABySmirKKy4P0PgUSh8duLW8A==
X-Received: by 2002:a05:6512:3e0d:b0:4a9:a1f1:3f57 with SMTP id i13-20020a0565123e0d00b004a9a1f13f57mr30346645lfv.50.1673540982272;
        Thu, 12 Jan 2023 08:29:42 -0800 (PST)
Received: from [192.168.1.101] (abym53.neoplus.adsl.tpnet.pl. [83.9.32.53])
        by smtp.gmail.com with ESMTPSA id a5-20020ac25e65000000b0049fff3f645esm3344109lfr.70.2023.01.12.08.29.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 08:29:41 -0800 (PST)
Message-ID: <6dfca582-3ec5-f652-4285-b2a1b34b5981@linaro.org>
Date:   Thu, 12 Jan 2023 17:29:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: msm8916-thwc: Add initial device
 tree for Tong Heng Wei Chuang Wifi/LTE dongle UFI-001C and uf896
Content-Language: en-US
To:     Nikita Travkin <nikita@trvn.ru>
Cc:     Yang Xiwen <forbidden405@foxmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jaime Breva <jbreva@nayarsystems.com>,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20230111141311.14682-1-forbidden405@foxmail.com>
 <tencent_F934F7427EB7B986E8AF70A95A397436E007@qq.com>
 <86e30740-6f12-1ef9-376f-85ce3fbca7b4@linaro.org>
 <2d4bf18409d7b34f0ae7905b212346f6@trvn.ru>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <2d4bf18409d7b34f0ae7905b212346f6@trvn.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12.01.2023 17:28, Nikita Travkin wrote:
> Konrad Dybcio писал(а) 12.01.2023 21:16:
>> On 11.01.2023 15:13, Yang Xiwen wrote:
>>> This commit adds support for the ufi-001C and uf896 WiFi/LTE dongle made by
>>> Tong Heng Wei Chuang based on MSM8916.
>>> uf896 is another variant for the usb stick. The board design
>>> differs by using different gpios for the keys and leds.
>>>
>>> Note: The original firmware does not support 64-bit OS. It is necessary
>>> to flash 64-bit TZ firmware to boot arm64.
>>>
>>> Currently supported:
>>> - All CPU cores
>>> - Buttons
>>> - LEDs
>>> - Modem
>>> - SDHC
>>> - USB Device Mode
>>> - UART
>>>
>>> Co-developed-by: Jaime Breva <jbreva@nayarsystems.com>
>>> Signed-off-by: Jaime Breva <jbreva@nayarsystems.com>
>>> Co-developed-by: Nikita Travkin <nikita@trvn.ru>
>>> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
>>> Signed-off-by: Yang Xiwen <forbidden405@foxmail.com>
>>> ---
>>>  arch/arm64/boot/dts/qcom/Makefile             |   2 +
>>>  .../boot/dts/qcom/msm8916-thwc-uf896.dts      |  41 +++
>>>  .../boot/dts/qcom/msm8916-thwc-ufi001c.dts    |  39 +++
>>>  arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi     | 246 ++++++++++++++++++
>>>  4 files changed, 328 insertions(+)
>>>  create mode 100644 arch/arm64/boot/dts/qcom/msm8916-thwc-uf896.dts
>>>  create mode 100644 arch/arm64/boot/dts/qcom/msm8916-thwc-ufi001c.dts
>>>  create mode 100644 arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>>> index b42362c7be1bf..523dbe6d06be8 100644
>>> --- a/arch/arm64/boot/dts/qcom/Makefile
>>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>>> @@ -21,6 +21,8 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-e7.dtb
>>>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-grandmax.dtb
>>>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-j5.dtb
>>>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-serranove.dtb
>>> +dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-thwc-uf896.dtb
>>> +dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-thwc-ufi001c.dtb
>>>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-wingtech-wt88047.dtb
>>>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-motorola-potter.dtb
>>>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-xiaomi-daisy.dtb
>>> diff --git a/arch/arm64/boot/dts/qcom/msm8916-thwc-uf896.dts b/arch/arm64/boot/dts/qcom/msm8916-thwc-uf896.dts
>>> new file mode 100644
>>> index 0000000000000..79447ca48dd3a
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/qcom/msm8916-thwc-uf896.dts
>>> @@ -0,0 +1,41 @@
>>> +// SPDX-License-Identifier: GPL-2.0-only
>>> +
>>> +/dts-v1/;
>>> +
>>> +#include "msm8916-ufi.dtsi"
>>> +
>>> +/ {
>>> +	model = "uf896 4G Modem Stick";
>>> +	compatible = "thwc,uf896", "qcom,msm8916";
>>> +};
>>> +
>>> +&button_restart {
>>> +	gpios = <&msmgpio 35 GPIO_ACTIVE_LOW>;
>>> +};
>>> +
>>> +&led_r {
>>> +	gpios = <&msmgpio 82 GPIO_ACTIVE_HIGH>;
>>> +};
>>> +
>>> +&led_g {
>>> +	gpios = <&msmgpio 83 GPIO_ACTIVE_HIGH>;
>>> +	function = LED_FUNCTION_WLAN;
>> This is a software property, maybe it would be worth
>> commonizing?
>>
> 
> The functions are put in-line with the labels on the housing.
> The uf896 has green and blue leds labeled with icons but I was told
> by Yang that the uf001c doesn't have any labels.
Okay, that probably deserves a comment.

> 
>>> +};
>>> +
>>> +&led_b {
>>> +	gpios = <&msmgpio 81 GPIO_ACTIVE_HIGH>;
>>> +	function = LED_FUNCTION_WAN;
>>> +};
>>> +
>>> +&button_default {
>>> +	pins = "gpio35";
>>> +	bias-pull-up;
>>> +};
>>> +
>>> +&gpio_leds_default {
>>> +	pins = "gpio81", "gpio82", "gpio83";
>>> +};
>>> +
>>> +&sim_ctrl_default {
>>> +	pins = "gpio1", "gpio2";
>>> +};
>>> diff --git a/arch/arm64/boot/dts/qcom/msm8916-thwc-ufi001c.dts b/arch/arm64/boot/dts/qcom/msm8916-thwc-ufi001c.dts
>>> new file mode 100644
>>> index 0000000000000..700cf81cbf8c0
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/qcom/msm8916-thwc-ufi001c.dts
>>> @@ -0,0 +1,39 @@
>>> +// SPDX-License-Identifier: GPL-2.0-only
>>> +
>>> +/dts-v1/;
>>> +
>>> +#include "msm8916-ufi.dtsi"
>>> +
>>> +/ {
>>> +	model = "ufi-001c/ufi-001b 4G Modem Stick";
>>> +	compatible = "thwc,ufi001c", "qcom,msm8916";
>>> +};
>>> +
>>> +&button_restart {
>>> +	gpios = <&msmgpio 37 GPIO_ACTIVE_HIGH>;
>>> +};
>>> +
>>> +&led_r {
>>> +	gpios = <&msmgpio 22 GPIO_ACTIVE_HIGH>;
>>> +};
>>> +
>>> +&led_g {
>>> +	gpios = <&msmgpio 21 GPIO_ACTIVE_HIGH>;
>>> +};
>>> +
>>> +&led_b {
>>> +	gpios = <&msmgpio 20 GPIO_ACTIVE_HIGH>;
>>> +};
>>> +
>>> +&button_default {
>>> +	pins = "gpio37";
>>> +	bias-pull-down;
>>> +};
>>> +
>>> +&gpio_leds_default {
>>> +	pins = "gpio20", "gpio21", "gpio22";
>>> +};
>>> +
>>> +&sim_ctrl_default {
>>> +	pins = "gpio1", "gpio2";
>> Identical between both boards, move to common please.
>>
>>> +};
>>> diff --git a/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi b/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi
>>> new file mode 100644
>>> index 0000000000000..286768d0fbe70
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi
>>> @@ -0,0 +1,246 @@
>>> +// SPDX-License-Identifier: GPL-2.0-only
>>> +
>>> +#include "msm8916-pm8916.dtsi"
>>> +
>>> +#include <dt-bindings/gpio/gpio.h>
>>> +#include <dt-bindings/leds/common.h>
>>> +
>>> +/ {
>>> +	chassis-type = "embedded";
>>> +
>>> +	aliases {
>>> +		serial0 = &blsp1_uart2;
>>> +	};
>>> +
>>> +	chosen {
>>> +		stdout-path = "serial0";
>>> +	};
>>> +
>>> +	reserved-memory {
>>> +		mpss_mem: mpss@86800000 {
>>> +			reg = <0x0 0x86800000 0x0 0x5500000>;
>>> +			no-map;
>>> +		};
>>> +
>>> +		gps_mem: gps@8bd00000 {
>>> +			reg = <0x0 0x8bd00000 0x0 0x200000>;
>>> +			no-map;
>>> +		};
>>> +	};
>>> +
>>> +	gpio-keys {
>>> +		compatible = "gpio-keys";
>>> +
>>> +		pinctrl-0 = <&button_default>;
>>> +		pinctrl-names = "default";
>>> +
>>> +		label = "GPIO Buttons";
>>> +
>>> +		/* gpio is board-specific */
>> GPIO is an acronym, please make it uppercase, as you
>> did 10 lines below..
>>
>>> +		button_restart: button-restart {
>>> +			label = "Restart";
>>> +			linux,code = <KEY_RESTART>;
>>> +		};
>>> +	};
>>> +
>>> +	leds {
>>> +		compatible = "gpio-leds";
>>> +
>>> +		pinctrl-0 = <&gpio_leds_default>;
>>> +		pinctrl-names = "default";
>>> +
>>> +		/* GPIOs are board-specific */
>>> +		led_r: led-r {
>>> +			color = <LED_COLOR_ID_RED>;
>>> +			default-state = "on";
>>> +			function = LED_FUNCTION_INDICATOR;
>>> +		};
>>> +
>>> +		led_g: led-g {
>>> +			color = <LED_COLOR_ID_GREEN>;
>>> +			default-state = "off";
>>> +			function = LED_FUNCTION_INDICATOR;
>>> +		};
>>> +
>>> +		led_b: led-b {
>>> +			color = <LED_COLOR_ID_BLUE>;
>>> +			default-state = "off";
>>> +			function = LED_FUNCTION_INDICATOR;
>>> +		};
>>> +	};
>>> +};
>>> +
>>> +&bam_dmux {
>>> +	status = "okay";
>>> +};
>>> +
>>> +&bam_dmux_dma {
>>> +	status = "okay";
>>> +};
>>> +
>>> +&blsp1_uart2 {
>>> +	status = "okay";
>>> +};
>>> +
>>> +/* Remove &dsi_phy0 from clocks to make sure that gcc probes with display disabled */
>> That sounds like a bad regression and shouldn't be an issue..
>>
>>> +&gcc {
>>> +	clocks = <&xo_board>, <&sleep_clk>, <0>, <0>, <0>, <0>, <0>;
>>> +};
>>> +
>>> +&mpss {
>>> +	pinctrl-0 = <&sim_ctrl_default>;
>>> +	pinctrl-names = "default";
>>> +
>>> +	status = "okay";
>>> +};
>>> +
>>> +&pm8916_usbin {
>>> +	status = "okay";
>>> +};
>>> +
>>> +&pronto {
>>> +	status = "okay";
>>> +};
>>> +
>>> +&sdhc_1 {
>>> +	pinctrl-0 = <&sdc1_clk_on &sdc1_cmd_on &sdc1_data_on>;
>>> +	pinctrl-1 = <&sdc1_clk_off &sdc1_cmd_off &sdc1_data_off>;
>>> +	pinctrl-names = "default", "sleep";
>>> +
>>> +	status = "okay";
>>> +};
>>> +
>>> +&usb {
>>> +	extcon = <&pm8916_usbin>;
>>> +	dr_mode = "peripheral";
>>> +
>>> +	status = "okay";
>>> +};
>>> +
>>> +&usb_hs_phy {
>>> +	extcon = <&pm8916_usbin>;
>>> +};
>>> +
>>> +&smd_rpm_regulators {
>> Please sort this reference alphabetically.
>>
> 
> The regulators and tlmm nodes are deliberately put last,
> in line with all other msm8916 devices. We move them away
> so they don't clutter more interesting nodes with these "dry"
> and somewhat uninteresting voltage/pin definitions.
> 
> Thanks for the review,
> Nikita
Ugh, I don't know anymore.. wild west..

Konrad
> 
>> Konrad
>>> +	vdd_l1_l2_l3-supply = <&pm8916_s3>;
>>> +	vdd_l4_l5_l6-supply = <&pm8916_s4>;
>>> +	vdd_l7-supply = <&pm8916_s4>;
>>> +
>>> +	s3 {
>>> +		regulator-min-microvolt = <1200000>;
>>> +		regulator-max-microvolt = <1300000>;
>>> +	};
>>> +
>>> +	s4 {
>>> +		regulator-min-microvolt = <1800000>;
>>> +		regulator-max-microvolt = <2100000>;
>>> +	};
>>> +
>>> +	l1 {
>>> +		regulator-min-microvolt = <1225000>;
>>> +		regulator-max-microvolt = <1225000>;
>>> +	};
>>> +
>>> +	l2 {
>>> +		regulator-min-microvolt = <1200000>;
>>> +		regulator-max-microvolt = <1200000>;
>>> +	};
>>> +
>>> +	l4 {
>>> +		regulator-min-microvolt = <2050000>;
>>> +		regulator-max-microvolt = <2050000>;
>>> +	};
>>> +
>>> +	l5 {
>>> +		regulator-min-microvolt = <1800000>;
>>> +		regulator-max-microvolt = <1800000>;
>>> +	};
>>> +
>>> +	l6 {
>>> +		regulator-min-microvolt = <1800000>;
>>> +		regulator-max-microvolt = <1800000>;
>>> +	};
>>> +
>>> +	l7 {
>>> +		regulator-min-microvolt = <1800000>;
>>> +		regulator-max-microvolt = <1800000>;
>>> +	};
>>> +
>>> +	l8 {
>>> +		regulator-min-microvolt = <2850000>;
>>> +		regulator-max-microvolt = <2900000>;
>>> +	};
>>> +
>>> +	l9 {
>>> +		regulator-min-microvolt = <3300000>;
>>> +		regulator-max-microvolt = <3300000>;
>>> +	};
>>> +
>>> +	l10 {
>>> +		regulator-min-microvolt = <2700000>;
>>> +		regulator-max-microvolt = <2800000>;
>>> +	};
>>> +
>>> +	l11 {
>>> +		regulator-min-microvolt = <1800000>;
>>> +		regulator-max-microvolt = <2950000>;
>>> +		regulator-system-load = <200000>;
>>> +		regulator-allow-set-load;
>>> +	};
>>> +
>>> +	l12 {
>>> +		regulator-min-microvolt = <1800000>;
>>> +		regulator-max-microvolt = <2950000>;
>>> +	};
>>> +
>>> +	l13 {
>>> +		regulator-min-microvolt = <3075000>;
>>> +		regulator-max-microvolt = <3075000>;
>>> +	};
>>> +
>>> +	l14 {
>>> +		regulator-min-microvolt = <1800000>;
>>> +		regulator-max-microvolt = <3300000>;
>>> +	};
>>> +
>>> +	l15 {
>>> +		regulator-min-microvolt = <1800000>;
>>> +		regulator-max-microvolt = <3300000>;
>>> +	};
>>> +
>>> +	l16 {
>>> +		regulator-min-microvolt = <1800000>;
>>> +		regulator-max-microvolt = <3300000>;
>>> +	};
>>> +
>>> +	l17 {
>>> +		regulator-min-microvolt = <2850000>;
>>> +		regulator-max-microvolt = <2850000>;
>>> +	};
>>> +
>>> +	l18 {
>>> +		regulator-min-microvolt = <2700000>;
>>> +		regulator-max-microvolt = <2700000>;
>>> +	};
>>> +};
>>> +
>>> +&msmgpio {
>>> +	/* pins are board-specific */
>>> +	button_default: button-default-state {
>>> +		function = "gpio";
>>> +		drive-strength = <2>;
>>> +	};
>>> +
>>> +	gpio_leds_default: gpio-leds-default-state {
>>> +		function = "gpio";
>>> +		drive-strength = <2>;
>>> +		bias-disable;
>>> +	};
>>> +
>>> +	sim_ctrl_default: sim-ctrl-default-state {
>>> +		function = "gpio";
>>> +		drive-strength = <2>;
>>> +		bias-disable;
>>> +		output-low;
>>> +	};
>>> +};
