Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C921F6240A2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 12:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbiKJLCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 06:02:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiKJLCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 06:02:22 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5727A6CA0E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 03:02:19 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id bj12so3919972ejb.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 03:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L0kPvLa286AkbDNXKbVvuHvXORMmCyLOgPXXU67P4LE=;
        b=PHYzcSvS5Cg+0YumNw0/zyCi6KbcdAz8iyrHoBxvgLqGUYBNRUnc1WrXPJmaWEpL3i
         hGnVhaAVckFbEIYT9wOyJ5RSEiwgzzdl4kDJSAEu21lrddYdV5FWf9W880mjMwAz6BZr
         e1H0ipusQX91xQmYYPpi8cq2d3QYG7R09fSNMAw3/+D9iNB8ih0QUDtMSA1b5ADA3Elt
         Ej9sd1t4sdaJPxZcmbXU00fBIkE8HXWedbysX5BRBSabYClBzYXxx2Vm4461nL6UYvAu
         ZnATUNr59HdihMAAv2fovqhUa+nLfxa3PRH2nG0AgF+3iYU0ee+PkdEKmcHL14peOhh4
         DoYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L0kPvLa286AkbDNXKbVvuHvXORMmCyLOgPXXU67P4LE=;
        b=kU0RvEbm+kWL2vOsKwXrwMn8D+gxFWQeeRzMt2x/OrR32DQwm0ssLzxph32FkPrdoH
         r/Ld6n2duC8D2ClFPeOwhp3hxQH8KeadxfThcHzcr2G4JMEVlF7AmODUUcGOnG50e0Kv
         3yLTYGU6Yq3UI7K3Edb1UyngoDSm2dI3pm3ZzfYuZzz7x24WBo2Qn58Alj3Sk0oF3tzt
         nrwRI2fEpozFraTfTyifVH2Bi4bwrHvc0W0MVlOeFe7CMBcqxMvbCQK2QtZCo52wz7V5
         VLc3DK1KPVkHaXU7uCWIZQmHO38n9AYC5XlMYJuN0vdRLMvvz+doNrtbOCC0zG0ccg6/
         BnTw==
X-Gm-Message-State: ACrzQf3DFd8KS09TpJIwiz9ukGFcELeJ2uInMdP+LAYaULtbmLD4+xfB
        MyIQqQveNXouZJw9hvaonAAckA==
X-Google-Smtp-Source: AMsMyM4eoIcB1m6CVRlycwyz47fsHzxOyh/cX46U03mvjMK3MHFI9FrnDPjDwAbTgGFH2BeKjf+TtA==
X-Received: by 2002:a17:907:7b93:b0:770:1d4f:4de9 with SMTP id ne19-20020a1709077b9300b007701d4f4de9mr59897802ejc.201.1668078138469;
        Thu, 10 Nov 2022 03:02:18 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id w16-20020a170906481000b007a9a56e2a07sm7041267ejq.49.2022.11.10.03.02.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 03:02:18 -0800 (PST)
Message-ID: <517cde25-83b3-e9be-a56b-e08c4e84b660@linaro.org>
Date:   Thu, 10 Nov 2022 12:02:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH 2/9] arm64: dts: qcom: sa8295p-adp: enable PCIe
To:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221110103558.12690-1-johan+linaro@kernel.org>
 <20221110103558.12690-3-johan+linaro@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221110103558.12690-3-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/11/2022 11:35, Johan Hovold wrote:
> The SA8295P-ADP has up to four PCIe interfaces implemented by three or
> four controllers: PCIe2A, PCIe3A/PCIe3B and PCIe4.
>
> PCIe2 is used in x4 mode, while PCIe3 can be used in either x2 or x4
> mode. Enable both PCIe3A and PCI3B in x2 mode for now.
>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>


Konrad

>   arch/arm64/boot/dts/qcom/sa8295p-adp.dts | 171 +++++++++++++++++++++++
>   1 file changed, 171 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> index b608b82dff03..ff1e6a674913 100644
> --- a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> @@ -57,6 +57,13 @@ vreg_l13a: ldo13 {
>   			regulator-max-microvolt = <3072000>;
>   			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>   		};
> +
> +		vreg_l11a: ldo11 {
> +			regulator-name = "vreg_l11a";
> +			regulator-min-microvolt = <880000>;
> +			regulator-max-microvolt = <880000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
>   	};
>   
>   	pmm8540-c-regulators {
> @@ -151,6 +158,76 @@ vreg_l8g: ldo8 {
>   	};
>   };
>   
> +&pcie2a {
> +	perst-gpios = <&tlmm 143 GPIO_ACTIVE_LOW>;
> +	wake-gpios = <&tlmm 145 GPIO_ACTIVE_LOW>;
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie2a_default>;
> +
> +	status = "okay";
> +};
> +
> +&pcie2a_phy {
> +	vdda-phy-supply = <&vreg_l11a>;
> +	vdda-pll-supply = <&vreg_l3a>;
> +
> +	status = "okay";
> +};
> +
> +&pcie3a {
> +	num-lanes = <2>;
> +
> +	perst-gpios = <&tlmm 151 GPIO_ACTIVE_LOW>;
> +	wake-gpios = <&tlmm 56 GPIO_ACTIVE_LOW>;
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie3a_default>;
> +
> +	status = "okay";
> +};
> +
> +&pcie3a_phy {
> +	vdda-phy-supply = <&vreg_l11a>;
> +	vdda-pll-supply = <&vreg_l3a>;
> +
> +	status = "okay";
> +};
> +
> +&pcie3b {
> +	perst-gpios = <&tlmm 153 GPIO_ACTIVE_LOW>;
> +	wake-gpios = <&tlmm 130 GPIO_ACTIVE_LOW>;
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie3b_default>;
> +
> +	status = "okay";
> +};
> +
> +&pcie3b_phy {
> +	vdda-phy-supply = <&vreg_l11a>;
> +	vdda-pll-supply = <&vreg_l3a>;
> +
> +	status = "okay";
> +};
> +
> +&pcie4 {
> +	perst-gpios = <&tlmm 141 GPIO_ACTIVE_LOW>;
> +	wake-gpios = <&tlmm 139 GPIO_ACTIVE_LOW>;
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie4_default>;
> +
> +	status = "okay";
> +};
> +
> +&pcie4_phy {
> +	vdda-phy-supply = <&vreg_l11a>;
> +	vdda-pll-supply = <&vreg_l3a>;
> +
> +	status = "okay";
> +};
> +
>   &qup2 {
>   	status = "okay";
>   };
> @@ -380,3 +457,97 @@ &xo_board_clk {
>   };
>   
>   /* PINCTRL */
> +
> +&tlmm {
> +	pcie2a_default: pcie2a-default-state {
> +		clkreq-n-pins {
> +			pins = "gpio142";
> +			function = "pcie2a_clkreq";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +
> +		perst-n-pins {
> +			pins = "gpio143";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-pull-down;
> +		};
> +
> +		wake-n-pins {
> +			pins = "gpio145";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +	};
> +
> +	pcie3a_default: pcie3a-default-state {
> +		clkreq-n-pins {
> +			pins = "gpio150";
> +			function = "pcie3a_clkreq";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +
> +		perst-n-pins {
> +			pins = "gpio151";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-pull-down;
> +		};
> +
> +		wake-n-pins {
> +			pins = "gpio56";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +	};
> +
> +	pcie3b_default: pcie3b-default-state {
> +		clkreq-n-pins {
> +			pins = "gpio152";
> +			function = "pcie3b_clkreq";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +
> +		perst-n-pins {
> +			pins = "gpio153";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-pull-down;
> +		};
> +
> +		wake-n-pins {
> +			pins = "gpio130";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +	};
> +
> +	pcie4_default: pcie4-default-state {
> +		clkreq-n-pins {
> +			pins = "gpio140";
> +			function = "pcie4_clkreq";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +
> +		perst-n-pins {
> +			pins = "gpio141";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-pull-down;
> +		};
> +
> +		wake-n-pins {
> +			pins = "gpio139";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +	};
> +};
