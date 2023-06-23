Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3601B73C434
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 00:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbjFWWlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 18:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjFWWlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 18:41:04 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DB4DC
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 15:41:03 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f122ff663eso1587187e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 15:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687560061; x=1690152061;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mkttFFjYoip7fglkU4JNZWNPOXtKhIEuxp+1+hKdO/U=;
        b=iS6ldgnt6553c/cJCr5bKGXW7rMTxxcV5Kr5atVUyPytncBWdL5Ty3ZlnV2Yavg9H4
         gFfEDFUiwSAw2dFwmd4YdkPe7nD8yr9bo54Jo1ZW9b74tnhQh38WlVSGzWrzFMbWPoSn
         ixqljIjRqm0M4xGEaQzqaxCRgIRQlsow10U4THrspYBV/vTtVyquJcSjM4npo7DQGPYn
         CVzqD+zNJBHazq1lCozePDGm841IHZ/jhRoiMUyBrrFkKzu/TODp1fzQjHvw0gDA+zpi
         njuWw+1cPlcx72nDbL2fYAhmzAfh93ACsdabCuHQIHfUD6ly6Mbk7s2M/ENvbDlfuI6u
         Bfgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687560061; x=1690152061;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mkttFFjYoip7fglkU4JNZWNPOXtKhIEuxp+1+hKdO/U=;
        b=GLFbqbOikMN03lieLgdBZc2XU2mYq/Yef8hPzDrm52NeD9f9ee6nv6gNghVUmNgCSl
         UXgpIRbnEUqv6acIVmpEif8IKpixfsdHYZYCO4LiTvysNiYesUKea6oPFnQ8d0DKlMbw
         mRT2r3xRDdXb6+9MQteDM+yIu8jk6v/UM8HRVnPJNM+k+IuweMyn3crIEH6Xczaf89GP
         OzO/RhlvwfjOlE+Q/bBa8WKkL+UUddnwKKVxmq5OoqmkFfKuEPJKmD25hQ08P74eTly2
         w9ahh58WB2aOYagBzhWGb2RanX6a+ff/FNBBksENcgjhi6gxbWplp3pdyLeBckeDI/ql
         cotw==
X-Gm-Message-State: AC+VfDwdI81KBWj/jWbVPmdHO/ZJbIuiQ7KSNn+tbn5DzMZJJ6hgHN/l
        bxRBZ5S9GoGXznLGq3+o9T+xZQ==
X-Google-Smtp-Source: ACHHUZ4iIruCEsrbUwp+7MIaJtuZNGQ/fhxMxNvF7x/sZJvelAU4d/cVOKo8rvwx+Ru4gyMStOAgdg==
X-Received: by 2002:a05:6512:32a8:b0:4f8:6d38:b091 with SMTP id q8-20020a05651232a800b004f86d38b091mr11700111lfe.25.1687560061514;
        Fri, 23 Jun 2023 15:41:01 -0700 (PDT)
Received: from [192.168.1.101] (abyk30.neoplus.adsl.tpnet.pl. [83.9.30.30])
        by smtp.gmail.com with ESMTPSA id eq21-20020a056512489500b004e9bf853c27sm57284lfb.70.2023.06.23.15.40.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 15:41:01 -0700 (PDT)
Message-ID: <115ad8f2-72ff-90fe-c27e-c298b7b00993@linaro.org>
Date:   Sat, 24 Jun 2023 00:40:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v9 09/10] arm64: dts: qcom: sa8295p: Enable tertiary
 controller and its 4 USB ports
Content-Language: en-US
To:     Krishna Kurapati <quic_kriskura@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_ppratap@quicinc.com,
        quic_jackp@quicinc.com, quic_harshq@quicinc.com,
        ahalaney@redhat.com, quic_shazhuss@quicinc.com
References: <20230621043628.21485-1-quic_kriskura@quicinc.com>
 <20230621043628.21485-10-quic_kriskura@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230621043628.21485-10-quic_kriskura@quicinc.com>
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

On 21.06.2023 06:36, Krishna Kurapati wrote:
> Enable tertiary controller for SA8295P (based on SC8280XP).
> Add pinctrl support for usb ports to provide VBUS to connected peripherals.
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sa8295p-adp.dts | 53 ++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> index fd253942e5e5..8b24b3c55769 100644
> --- a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> @@ -9,6 +9,7 @@
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>  #include <dt-bindings/spmi/spmi.h>
> +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
>  
>  #include "sa8540p.dtsi"
>  #include "sa8540p-pmics.dtsi"
> @@ -584,6 +585,20 @@ &usb_1_qmpphy {
>  	status = "okay";
>  };
>  
> +&usb_2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&usb2_en_state>,
> +		    <&usb3_en_state>,
> +		    <&usb4_en_state>,
> +		    <&usb5_en_state>;
Please put property-names after property
> +
> +	status = "okay";
> +};
> +
> +&usb_2_dwc3 {
> +	dr_mode = "host";
> +};
If I understood correctly, the MP controller is host-only. In that case,
I'd say that putting this property in the SoC-dtsi node with an appropriate
comment would be beneficial.

lgtm otherwise

Konrad
> +
>  &usb_2_hsphy0 {
>  	vdda-pll-supply = <&vreg_l5a>;
>  	vdda18-supply = <&vreg_l7g>;
> @@ -729,3 +744,41 @@ wake-n-pins {
>  		};
>  	};
>  };
> +
> +&pmm8540c_gpios {
> +	usb2_en_state: usb2-en-state {
> +		pins = "gpio9";
> +		function = "normal";
> +		qcom,drive-strength = <PMIC_GPIO_STRENGTH_HIGH>;
> +		output-high;
> +		power-source = <0>;
> +	};
> +};
> +
> +&pmm8540e_gpios {
> +	usb3_en_state: usb3-en-state {
> +		pins = "gpio5";
> +		function = "normal";
> +		qcom,drive-strength = <PMIC_GPIO_STRENGTH_HIGH>;
> +		output-high;
> +		power-source = <0>;
> +	};
> +};
> +
> +&pmm8540g_gpios {
> +	usb4_en_state: usb4-en-state {
> +		pins = "gpio5";
> +		function = "normal";
> +		qcom,drive-strength = <PMIC_GPIO_STRENGTH_HIGH>;
> +		output-high;
> +		power-source = <0>;
> +	};
> +
> +	usb5_en_state: usb5-en-state {
> +		pins = "gpio9";
> +		function = "normal";
> +		qcom,drive-strength = <PMIC_GPIO_STRENGTH_HIGH>;
> +		output-high;
> +		power-source = <0>;
> +	};
> +};
