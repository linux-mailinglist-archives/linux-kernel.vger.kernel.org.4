Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A286240B4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 12:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbiKJLG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 06:06:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiKJLGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 06:06:51 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BB16C73A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 03:06:50 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id i21so2504090edj.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 03:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R4SelkkSJ9qmNL8gmJtlYz5H1irKwVwcZawIssA/xqU=;
        b=qvx6ajvCTox3J4EpAEIvV7MFBy6T5Kb80pu18iQ5NxyKAAyvQ3jtHsL58PEKWjKU62
         F4XB2oQKN6Jxw1mtFepPAFNzIvMOBQH4jTD2Agn9gNCzfqxn2DgFbowp+gvZl9Pset7E
         3M4pz42YYIFitq0UnAPUaBRGFrTzdlnUtBYj6s+ldd7+JiPkWk1eEWS+9m8nBMyOBcse
         F+DSn/KV3u8xSojPmQ/7BQTOQzOAsclFfcviJqrl9O5VdcX/kRDB0oI8ABiu+l8lrTTG
         WA0FDrICAORo00cRNd+0MkteWqKPQVEjI37lRwdltsxKLu63VyiyMV8I1DpRNfiEunXm
         SGmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R4SelkkSJ9qmNL8gmJtlYz5H1irKwVwcZawIssA/xqU=;
        b=by/2R03EvenOoSVsgrW0EqxY6nn94y+pl+TosuRRzOr51W5Abg+wABBy1Cs5DzdqWE
         r5RTcrju9mS/yw8J6ZxwY1i/z1VUjhrgoXXQkFtrX8wVEdBmDLvj36vTaFdjEm3uAWzL
         tQX8f4IRlFauvM6eGg5uEbqM4OXPboRJRz2QS2SX46uBWiXCVR9Vu/TRNbAwfmvbXUZg
         rZqkkgnVdfaLGSfs5WmNY472UKXDwmRLslp1/zf7KLi905CIwPL/+NU9DsoonOXolN22
         XxP6TialqWEi59JtP8t2GIb1OMXid+6qgENzkwJKeBky2iUONKbaetJ1yXT2nEejErRm
         UmkQ==
X-Gm-Message-State: ACrzQf1akKzj0/SxbD+IRfEE16fHJevC+X4fzwoGauWjBrjJpCcNyl4g
        ByzaZbHmmzxT+vnUnMcC2iz4zE43sFAcrDl8
X-Google-Smtp-Source: AMsMyM4+j5+d/udkmi+eZmZ6u+2s3sTr0ZTrYTHAONtFMeyNFyC5VCfN7vdRknD6q5jKq9yAeKBRtA==
X-Received: by 2002:a50:aad1:0:b0:461:37c2:e85c with SMTP id r17-20020a50aad1000000b0046137c2e85cmr1993013edc.74.1668078408533;
        Thu, 10 Nov 2022 03:06:48 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id r9-20020a17090609c900b007aacfce2a91sm7067279eje.27.2022.11.10.03.06.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 03:06:47 -0800 (PST)
Message-ID: <d3aead5b-413a-e929-1b33-7956fa117d4d@linaro.org>
Date:   Thu, 10 Nov 2022 12:06:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH 4/9] arm64: dts: qcom: sc8280xp-crd: enable NVMe SSD
To:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221110103558.12690-1-johan+linaro@kernel.org>
 <20221110103558.12690-5-johan+linaro@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221110103558.12690-5-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/11/2022 11:35, Johan Hovold wrote:
> Enable the NVMe SSD connected to PCIe2.
>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   arch/arm64/boot/dts/qcom/sc8280xp-crd.dts | 63 +++++++++++++++++++++++
>   1 file changed, 63 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> index 0801bd8c44fb..fd2bdfd1126b 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> @@ -50,6 +50,20 @@ vreg_edp_bl: regulator-edp-bl {
>   		regulator-boot-on;
>   	};
>   
> +	vreg_nvme: regulator-nvme {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "VCC3_SSD";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		gpio = <&tlmm 135 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&nvme_reg_en>;
> +	};
> +
>   	vreg_misc_3p3: regulator-misc-3p3 {
>   		compatible = "regulator-fixed";
>   
> @@ -178,6 +192,25 @@ vreg_l9d: ldo9 {
>   	};
>   };
>   
> +&pcie2a {
> +	perst-gpios = <&tlmm 143 GPIO_ACTIVE_LOW>;
> +	wake-gpios = <&tlmm 145 GPIO_ACTIVE_LOW>;
> +
> +	vddpe-3v3-supply = <&vreg_nvme>;
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie2a_default>;
> +
> +	status = "okay";
> +};
> +
> +&pcie2a_phy {
> +	vdda-phy-supply = <&vreg_l6d>;
> +	vdda-pll-supply = <&vreg_l4d>;
> +
> +	status = "okay";
> +};
> +
>   &pmc8280c_lpg {
>   	status = "okay";
>   };
> @@ -393,6 +426,36 @@ reset-pins {
>   		};
>   	};
>   
> +	nvme_reg_en: nvme-reg-en-state {
> +		pins = "gpio135";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	pcie2a_default: pcie2a-default-state {

Aren't they going to be identical for all boards anyway? Maybe there
could be some commonization..


Konrad

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
> +		       pins = "gpio145";
> +		       function = "gpio";
> +		       drive-strength = <2>;
> +		       bias-pull-up;
> +	       };
> +	};
> +
>   	qup0_i2c4_default: qup0-i2c4-default-state {
>   		pins = "gpio171", "gpio172";
>   		function = "qup4";
