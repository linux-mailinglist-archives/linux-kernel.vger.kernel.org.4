Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB1B369228B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 16:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbjBJPoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 10:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbjBJPoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 10:44:34 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838D878D49
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 07:44:33 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id sa10so16899843ejc.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 07:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=opBAKiJAaUbXJ8f0Fh0jXM9OPqOfnIFIHrb6jeC+I0c=;
        b=VC2iGg+GzpJRixykUCYMZW0UfYHovv8kIa2ONla0Py2CwzwKrBta3tMIfxqZfbX1bT
         5+zv35DUorBzkjOHUPF+ZTwx9awnL5X0zwwZR6OpGuWaHaldxvCliGQSefRgd1WRt+FH
         wQ+LciuTNLxILi9M+af0w8uwGTY5kkjdKUZ1ARZ3rk0az0NZbb2tULwtEq+wzcWkhg0g
         lunPMPVm7uPJZInfow9dfMMFrQiorpUmTuIi1Vi7aGxFUQBydxb4XrzKu55mSUUf/hmC
         /z/xcQAba9SdSPr0wRxYD6e4f0o0hS5IMMUG2NrTKyGS4s25/xLqbTn8xcJCn57S4l/z
         YHqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=opBAKiJAaUbXJ8f0Fh0jXM9OPqOfnIFIHrb6jeC+I0c=;
        b=rlLoPwhqahxX2LFt56/gnablo0OxxSZ7EkMVSvfnwqxR1uySlWOs6FJONB3Dei7+Wk
         AnthhFmUXzVAsfjOtwm3NrOVZg2h0W+lkJjjahOcNCjs7GjBlDxogkvwIs90WudQ5YHT
         djKlV+C+PerZrwOcNcjKC4cDdJWlHzjb6ZPJN7pRhQtzrMM3n8lX2thvOvFHcPYPvCeZ
         yWFsj16rlgnE3F+zF6v5HewaBtLa73iBCPg0NFfM26K9GSkjpjO+HyXzTiUPuLF2pv5g
         rMPJK4ad+4rwahqJOhumgYY0uW/THYInA+YmatgiXVnOR1rt62PjBQEYvufv95IenqhD
         l7Sg==
X-Gm-Message-State: AO0yUKUiUj4OVE/sSVVBGFothOxtO3VhK7xFmq6TiBd2I1Kd16Zd6gKW
        TamEJMw5R+WmwjhuR3gghloFkQ==
X-Google-Smtp-Source: AK7set9G2NFedcRvsqYyG2U+9/VJ93t/MwQNwlIRGUSVuLpenKc9AW+17f/c1lGphiIeWQp+GdJzdA==
X-Received: by 2002:a17:907:6d8a:b0:88f:8a5:b4cd with SMTP id sb10-20020a1709076d8a00b0088f08a5b4cdmr21470525ejc.1.1676043872092;
        Fri, 10 Feb 2023 07:44:32 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id a11-20020a170906684b00b008aea5e0938esm2504211ejs.183.2023.02.10.07.44.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 07:44:31 -0800 (PST)
Message-ID: <e03d5698-65d2-41ae-3095-9ab374cb6b77@linaro.org>
Date:   Fri, 10 Feb 2023 17:44:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 08/11] arm64: dts: qcom: sm8350-hdk: add pmic glink
 node
Content-Language: en-GB
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230130-topic-sm8450-upstream-pmic-glink-v2-0-71fea256474f@linaro.org>
 <20230130-topic-sm8450-upstream-pmic-glink-v2-8-71fea256474f@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230130-topic-sm8450-upstream-pmic-glink-v2-8-71fea256474f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/2023 17:02, Neil Armstrong wrote:
> Add the pmic glink node linked with the DWC3 USB controller
> switched to OTG mode and tagged with usb-role-switch.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm8350-hdk.dts | 77 ++++++++++++++++++++++++++++-----
>   1 file changed, 65 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
> index 54654eb75c28..28fc9a835c5d 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
> @@ -31,6 +31,40 @@ hdmi_con: endpoint {
>   		};
>   	};
>   
> +	pmic-glink {
> +		compatible = "qcom,sm8350-pmic-glink", "qcom,pmic-glink";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		connector@0 {
> +			compatible = "usb-c-connector";
> +			reg = <0>;
> +			power-role = "dual";
> +			data-role = "dual";
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +
> +					pmic_glink_hs_in: endpoint {
> +						remote-endpoint = <&usb_1_dwc3_hs>;
> +					};
> +				};
> +
> +				port@1 {
> +					reg = <1>;
> +
> +					pmic_glink_ss_in: endpoint {
> +						remote-endpoint = <&usb_1_dwc3_ss>;
> +					};
> +				};
> +			};
> +		};
> +	};
> +
>   	vph_pwr: vph-pwr-regulator {
>   		compatible = "regulator-fixed";
>   		regulator-name = "vph_pwr";
> @@ -666,23 +700,42 @@ &usb_1 {
>   };
>   
>   &usb_1_dwc3 {
> -	/* TODO: Define USB-C connector properly */
> -	dr_mode = "peripheral";
> -};
> +	dr_mode = "otg";

I could not verify UCSI / OTG on sm8350-HDK, see the GET_PDOS issue.
Unless it is fixed, I suggest fixing this to "host" to get DP to work.

> +	usb-role-switch;
>   
> -&usb_1_hsphy {
> -	status = "okay";
> +	ports {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
>   
> -	vdda-pll-supply = <&vreg_l5b_0p88>;
> -	vdda18-supply = <&vreg_l1c_1p8>;
> -	vdda33-supply = <&vreg_l2b_3p07>;
> +		port@0 {
> +			reg = <0>;
> +
> +			usb_1_dwc3_hs: endpoint {
> +				remote-endpoint = <&pmic_glink_hs_in>;
> +			};
> +		};
> +
> +		port@1 {
> +			reg = <1>;
> +
> +			usb_1_dwc3_ss: endpoint {
> +				remote-endpoint = <&pmic_glink_ss_in>;
> +			};
> +		};
> +	};
>   };
>   
> -&usb_1_qmpphy {
> -	status = "okay";
> +&usb_1_dwc3 {
> +	dr_mode = "otg";
> +	usb-role-switch;
> +};

Duplicate

>   
> -	vdda-phy-supply = <&vreg_l6b_1p2>;
> -	vdda-pll-supply = <&vreg_l1b_0p88>;
> +&usb_1_dwc3_hs {
> +	remote-endpoint = <&pmic_glink_hs_in>;
> +};
> +
> +&usb_1_dwc3_ss {
> +	remote-endpoint = <&pmic_glink_ss_in>;
>   };
>   
>   &usb_2 {
> 

-- 
With best wishes
Dmitry

