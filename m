Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1907184EF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 16:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjEaO1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 10:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236084AbjEaO12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 10:27:28 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2618194
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 07:27:18 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f4b0a0b557so6703478e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 07:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685543237; x=1688135237;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ibRavn+wX5+msAj09M0EWRs8rIYs/zZ+2Fkj0xJZO7Q=;
        b=gfvMrw2N9/F54FNlreQR4aLyfq3lme+iAa0Fg/vVuyJGYydqZQLuxT6lyzbWpRS5rH
         3e8+g7eCqTtV5ZP9MWDjEACqLRT3qliPXb/dvIZtgNRvhKVgGta7QmuqkNXfaeTt7VCK
         2DH3iOCLJlsS1j4r/so+wGxfrIXcmbzkKVFBtdwutBKO2Vdmzjw7dIrbnlnM8uM8wCXZ
         +ciprs5IAY273Sxtz0gFGPkEx8HVlJaTjCPT8Db3OGXir3iir6X41Kk0FcWbbQxIYQ3h
         F65CG8LCPnQV9ynbb2pM6NpF5eOYtIZlGKZ1tsSAO1mhs1y8w3NZFompB8EtjNUF8YqA
         YLkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685543237; x=1688135237;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ibRavn+wX5+msAj09M0EWRs8rIYs/zZ+2Fkj0xJZO7Q=;
        b=cRdg9+PBTqaSRrD8euY+vV1vwhN2aQD09aQN0oJenwAcN2/QLLa5xI8FQ+JHxHSeHT
         MzpUojL7yhJCaGLq5lA5OZR+MWhG7N2J+wg3ldugI8HTKCM3DnQH1bD8EbM17zE7LAVR
         cML+xx871dcttCneDJkDb543thoMurNhxJeE8kky0Gfr90NN57rUBOrCWTkmS/v57pEd
         vLHUN0AJY4S0ipxt1GIaieqjp4dSG0yJExrTlGb+rffKqSYWij3AhilFBbYr5NBIzwuo
         mixWx+PA5nDYAKRN0Ko2HFH10UfRVt94H+WCGCAU71zlu/d+04nDNNFQ6B45jnP7d4Qo
         0dAg==
X-Gm-Message-State: AC+VfDy5PLEbHyW7Knu50q4dvCXJtrhsZPnfGotmJDfeS/UPBPV/nvaO
        JGH/OS5s3mJbWet0ADccrY8ebg==
X-Google-Smtp-Source: ACHHUZ6cZDxVaGVsjHJLrjnMmpLueOfFSg6ct2+pvtMlJHc8y97TqJ7ym5DpeaMdiDXr2ZU2eHsbkQ==
X-Received: by 2002:ac2:5edd:0:b0:4f1:30cc:3dae with SMTP id d29-20020ac25edd000000b004f130cc3daemr3083071lfq.10.1685543237015;
        Wed, 31 May 2023 07:27:17 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id c20-20020a197614000000b004f122a378d4sm736372lff.163.2023.05.31.07.27.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 07:27:16 -0700 (PDT)
Message-ID: <eef42615-ed5e-626b-f096-8c81e921e17a@linaro.org>
Date:   Wed, 31 May 2023 16:27:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 4/4] arm64: dts: qcom: sm8550-qrd: enable PMIC Volume
 and Power buttons
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230525-topic-sm8550-upstream-pm8550-lpg-dt-v2-0-a3b890604c49@linaro.org>
 <20230525-topic-sm8550-upstream-pm8550-lpg-dt-v2-4-a3b890604c49@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230525-topic-sm8550-upstream-pm8550-lpg-dt-v2-4-a3b890604c49@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31.05.2023 14:22, Neil Armstrong wrote:
> The Volume Down & Power buttons are controlled by the PMIC via
> the PON hardware, and the Volume Up is connected to a PMIC gpio.
> 
> Enable the necessary hardware and setup the GPIO state for the
> Volume Up gpio key.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8550-qrd.dts | 36 +++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
> index efff15225e67..24fc368de97b 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
> @@ -54,6 +54,22 @@ chosen {
>  		stdout-path = "serial0:115200n8";
>  	};
>  
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&volume_up_n>;
property-n
property-names

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> +
> +		key-volume-up {
> +			label = "Volume Up";
> +			linux,code = <KEY_VOLUMEUP>;
> +			gpios = <&pm8550_gpios 6 GPIO_ACTIVE_LOW>;
> +			debounce-interval = <15>;
> +			linux,can-disable;
> +			wakeup-source;
> +		};
> +	};
> +
>  	pmic-glink {
>  		compatible = "qcom,sm8550-pmic-glink", "qcom,pmic-glink";
>  		#address-cells = <1>;
> @@ -516,6 +532,16 @@ led-1 {
>  	};
>  };
>  
> +&pm8550_gpios {
> +	volume_up_n: volume-up-n-state {
> +		pins = "gpio6";
> +		function = "normal";
> +		power-source = <1>;
> +		bias-pull-up;
> +		input-enable;
> +	};
> +};
> +
>  &pm8550_pwm {
>  	status = "okay";
>  
> @@ -548,6 +574,16 @@ &pm8550b_eusb2_repeater {
>  	vdd3-supply = <&vreg_l5b_3p1>;
>  };
>  
> +&pon_pwrkey {
> +	status = "okay";
> +};
> +
> +&pon_resin {
> +	linux,code = <KEY_VOLUMEDOWN>;
> +
> +	status = "okay";
> +};
> +
>  &pcie_1_phy_aux_clk {
>  	clock-frequency = <1000>;
>  };
> 
