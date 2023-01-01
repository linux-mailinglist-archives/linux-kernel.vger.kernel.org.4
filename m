Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2916E65AA74
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 16:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjAAPof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 10:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjAAPoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 10:44:32 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1105A5590
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 07:44:31 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id cf42so38405781lfb.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jan 2023 07:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MQmnB80I9cJgJY0s3MQo9q3VV9Uh6izq71o/UJT78Jo=;
        b=CuI8GPRA90j6ZBI/fMSKjfbzM7gvQzorHW1qEWlRFACc8IQ5oBgGvwA5AMvRrHCH9Y
         E/feHJCcnoWkppszSmrBmnMDN8XNpVWZb7m1e7rFxpd915WNbeEFzmdOgSGt9RCnnULg
         TLsSmQ/ypbPy2HFfdQpZHnNmgEFKNw6x0XkYj+QkvlL6CnkaZVbreGXkl5aowFi6w7Ni
         ZIHZtm6LxFeEaYgBonwYYPiwZuo5pjXgWzrGSM76TFMFAZke9SSyHmpWt8MOFYA/H39w
         7e8hadvfcS0wtGy6f7zXwvAHrtccArBMxdmmF9y1Fn+SMuocmRLYhOnYNpB6DS/tfimd
         DrAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MQmnB80I9cJgJY0s3MQo9q3VV9Uh6izq71o/UJT78Jo=;
        b=8FPvWhL8mJqUkiSRLJrzegNoohjkPSKvoftZVoOMXikZ31MQuYYiKwiBBWuVuEsn5O
         YTRA1WjmzERq246fCWuAAx0BiHQXpiDljEC2qUxtH78xEQPliqzeZqBtXwGrSQmS8Ft2
         /iOrCDd3nqqvYdtpcnf0Blv+G3fVjejS8dQRdFiZQbj9mb2TkmAp5B2BHDf9A6DrGmBe
         8iIawpIlPz2I6b5M+9MiLOf1GnTGpyp0/6saUdmNPnB8qDdaZ3mod6jOlJ7FKdWWiB/H
         5ojvO5YaMfD4ZRBDv9byH3+f/k++uyq3rzNvF5gYjVMEc247UH8xc2qH2qsLvacKMkw0
         vqaQ==
X-Gm-Message-State: AFqh2krdWCHGFBM3w8IPm7e5ghEDprH0Gw95XKO0MhkZPSnlgp0fgd5A
        gxXig+3z2fWLLRGSYSQQYG/+aA==
X-Google-Smtp-Source: AMrXdXtIhwfJxF6Q6rWWLXpIcgwDM/eZMeXAYb6J/UJrejxpympVA6DYsW4C2s88PUHtLn75d7zgkQ==
X-Received: by 2002:ac2:43a4:0:b0:4cb:3a60:65cc with SMTP id t4-20020ac243a4000000b004cb3a6065ccmr53650lfl.5.1672587869269;
        Sun, 01 Jan 2023 07:44:29 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id y2-20020ac24202000000b004bd8534ebbcsm4150100lfh.37.2023.01.01.07.44.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Jan 2023 07:44:28 -0800 (PST)
Message-ID: <cd9d74eb-a3bb-7996-7c5c-0777c26a23f4@linaro.org>
Date:   Sun, 1 Jan 2023 16:44:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5 6/6] arm64: dts: qcom: sm6125: Initial support for
 xiaomi-laurel-sprout
Content-Language: en-US
To:     Lux Aliaga <they@mint.lgbt>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        marijn.suijten@somainline.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20221231222420.75233-1-they@mint.lgbt>
 <20221231222420.75233-7-they@mint.lgbt>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221231222420.75233-7-they@mint.lgbt>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/12/2022 23:24, Lux Aliaga wrote:
> Adds support for the Xiaomi Mi A3 (xiaomi-laurel-sprout). Here's a
> summary on what's working.
> 
> - dmesg output to bootloader preconfigured display
> - USB
> - UFS
> - SD card


(...)

> +	};
> +
> +	extcon_usb: usb-id {
> +		compatible = "linux,extcon-usb-gpio";
> +		id-gpio = <&tlmm 102 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	gpio-keys {
> +		status = "okay";

Drop.

> +		compatible = "gpio-keys";
> +		autorepeat;
> +
> +		key-vol-up {
> +			label = "Volume Up";
> +			gpios = <&pm6125_gpio 5 GPIO_ACTIVE_LOW>;
> +			linux,input-type = <1>;
> +			linux,code = <KEY_VOLUMEUP>;
> +			gpio-key,wakeup;
> +			debounce-interval = <15>;
> +		};
> +	};
> +
> +	thermal-zones {
> +		rf-pa0-thermal {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&pm6125_adc_tm 0>;
> +
> +			trips {
> +				active-config0 {
> +					temperature = <125000>;
> +					hysteresis = <1000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		quiet-thermal {
> +			polling-delay-passive = <0>;
> +			polling-delay = <5000>;
> +			thermal-sensors = <&pm6125_adc_tm 1>;
> +
> +			trips {
> +				active-config0 {
> +					temperature = <125000>;
> +					hysteresis = <1000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		xo-thermal {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&pm6125_adc_tm 2>;
> +
> +			trips {
> +				active-config0 {
> +					temperature = <125000>;
> +					hysteresis = <1000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&hsusb_phy1 {
> +	vdd-supply = <&vreg_l7a>;
> +	vdda-pll-supply = <&vreg_l10a>;
> +	vdda-phy-dpdm-supply = <&vreg_l15a>;
> +	status = "okay";
> +};
> +
> +&pm6125_adc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&camera_flash_therm &emmc_ufs_therm>;
> +
> +	rf-pa0-therm@4d {
> +		reg = <ADC5_AMUX_THM1_100K_PU>;
> +		qcom,ratiometric;
> +		qcom,hw-settle-time = <200>;
> +		qcom,pre-scaling = <1 1>;
> +	};
> +
> +	quiet-therm@4e {
> +		reg = <ADC5_AMUX_THM2_100K_PU>;
> +		qcom,ratiometric;
> +		qcom,hw-settle-time = <200>;
> +		qcom,pre-scaling = <1 1>;
> +	};
> +
> +	camera-flash-therm@52 {
> +		reg = <ADC5_GPIO1_100K_PU>;
> +		qcom,ratiometric;
> +		qcom,hw-settle-time = <200>;
> +		qcom,pre-scaling = <1 1>;
> +	};
> +
> +	emmc-ufs-therm@54 {
> +		reg = <ADC5_GPIO3_100K_PU>;
> +		qcom,ratiometric;
> +		qcom,hw-settle-time = <200>;
> +		qcom,pre-scaling = <1 1>;
> +	};
> +};
> +
> +&pm6125_adc_tm {
> +	status = "okay";
> +
> +	rf-pa0-therm@0 {
> +		reg = <0>;
> +		io-channels = <&pm6125_adc ADC5_AMUX_THM1_100K_PU>;
> +		qcom,ratiometric;
> +		qcom,hw-settle-time-us = <200>;
> +	};
> +
> +	quiet-therm@1 {
> +		reg = <1>;
> +		io-channels = <&pm6125_adc ADC5_AMUX_THM2_100K_PU>;
> +		qcom,ratiometric;
> +		qcom,hw-settle-time-us = <200>;
> +	};
> +
> +	xo-therm@2 {
> +		reg = <2>;
> +		io-channels = <&pm6125_adc ADC5_XO_THERM_100K_PU>;
> +		qcom,ratiometric;
> +		qcom,hw-settle-time-us = <200>;
> +	};
> +};
> +
> +&pm6125_gpio {
> +	camera_flash_therm: camera-flash-therm-state {
> +		pins = "gpio3";
> +		function = PMIC_GPIO_FUNC_NORMAL;
> +		bias-high-impedance;
> +	};
> +
> +	emmc_ufs_therm: emmc-ufs-therm-state {
> +		pins = "gpio6";
> +		function = PMIC_GPIO_FUNC_NORMAL;
> +		bias-high-impedance;
> +	};
> +
> +	key_vol_up: key_vol_up {


No underscores in node names, missing state suffix.

> +		pins = "gpio5";
> +		function = PMIC_GPIO_FUNC_NORMAL;
> +		input-enable;
> +		bias-pull-up;
> +	};
> +};
> +

Best regards,
Krzysztof

