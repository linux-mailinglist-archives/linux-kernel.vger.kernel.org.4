Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D3169521F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 21:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjBMUoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 15:44:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjBMUoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 15:44:19 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D12E07E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 12:44:17 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id rp23so34923771ejb.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 12:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l5eOlbFOXFpVJdg43ZgJC+B0PkBzGXrwvp+d8ss5b/A=;
        b=hYQFmlTs94yiQ2qwYJ3aausbUw2W2TzTiMo5DTqRzzLgjXO5+gqFMjCetwM2GXThbx
         C3bf3ynhUMI8ldORVG6e7nr0XuAvw49wY/YiEJhb1rwZ7GEY4dhdKdAPG/GDWUbVXZ2M
         TMFFolUvyQqdM6Pg75NA+yyZtzq8WXSqj3mVm3ie85rEJHZIo5yf+GJfYBSYw+gMGzN9
         +M/ZBK5xYqT65tKv2ngG0TD/cy3Wg1jl8zN/fldh1D5N/f+CVof0LAQdsPi9aVfXEc/M
         TIdP8+MC3mRsjAPrX5g2uPjHf3SLrXVdaEKEFlokJjmjKkKZSIlx585Z29R5J8x3rDZ/
         o7bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l5eOlbFOXFpVJdg43ZgJC+B0PkBzGXrwvp+d8ss5b/A=;
        b=SVQ9NMYnQJ4pJYIYS74k+MpVZm3M8TKNegSt23OAmVdwFSfszYkyTshKUJ1O32shLx
         Z/r3FzGdySsTiT1iJB8M6HlNI+4rorGiSWAb7/pivZajA7bCFhkIqxWTOMcAyVMnW2rh
         UK6fytKJilgI3WYpRf+uAFI4L9OWlMikIerr1cGvgPfdMcZF7OGx8sjIwn9frOb4xTKO
         RmjitYPkwRx1XQlYj0N+Sz/9iDxaYl5PBcJlMxDwNqQwqc23NTwmqyCW94YTgk3OnpwA
         1WtsJAPzr+tan76Ej3u/5uPaV0Ta3HgNKI+U2q3zB34yaiRph4MbjNMXQjP5+EGMhq/d
         BzUA==
X-Gm-Message-State: AO0yUKVDNp71AiKyd6z8h/5g6curfv5vrIuJhbWyNrS4KDWH6zcAvIh+
        W6E/FzrjRthRNSN6SJSVD/gKpA==
X-Google-Smtp-Source: AK7set+rtXoLowk4LdSzSoqMllVW/EX7f6YFdq8GYTukx0BdluxBtYaXvHvCAwngwhqrBrcFV5jMRg==
X-Received: by 2002:a17:906:e2d1:b0:879:ab3:93d1 with SMTP id gr17-20020a170906e2d100b008790ab393d1mr332947ejb.4.1676321055879;
        Mon, 13 Feb 2023 12:44:15 -0800 (PST)
Received: from [192.168.1.101] (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id p18-20020a170906839200b008b112db78f9sm1549544ejx.51.2023.02.13.12.44.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 12:44:15 -0800 (PST)
Message-ID: <4a3964c8-8824-cb4e-9262-58b6a1cedc7c@linaro.org>
Date:   Mon, 13 Feb 2023 21:44:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 2/4] arm64: dts: qcom: sc8280xp-crd: Introduce
 pmic_glink
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230213162821.1253831-1-quic_bjorande@quicinc.com>
 <20230213162821.1253831-3-quic_bjorande@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230213162821.1253831-3-quic_bjorande@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13.02.2023 17:28, Bjorn Andersson wrote:
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> The SC8280XP CRD control over battery management and its two USB Type-C
> port using pmic_glink and two GPIO-based SBU muxes.
> 
> Enable the two DisplayPort instances, GPIO SBU mux instance and
> pmic_glink with the two connectors on the CRD.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
> 
[...]

> +&mdss0_dp0 {
> +	data-lanes = <0 1>;
> +	status = "okay";
> +
> +	ports {
> +		port@1 {
> +			reg = <1>;
> +
> +			mdss0_dp0_out: endpoint {
> +				remote-endpoint = <&pmic_glink_con0_ss>;
> +			};
> +		};
> +	};
> +};
> +
> +&mdss0_dp1 {
> +	data-lanes = <0 1>;
> +	status = "okay";
> +
> +	ports {
> +		port@1 {
> +			reg = <1>;
This way you're redefining this node.. I suppose going with
something like:

8280:
mdss0_dp1 {
	compatible
	blahblah

	ports {
		[..]

		port@1 {
		reg = <1>;

			mdss0_dp1_out : endpoint {
			};
		};
	}
}

crd:
&mdss0_dp1_out {
	//btw data-lanes should be there and not in mdss_dp, I think
	remote-endpoint = <&pmic_glink_...>
}

would be better, and that's what we're already doing for DSI..

I think I missed all this during the 8[34]50 review too..

With that addressed, for both crd and x13s (as the patch is essentially
identical)

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

> +
> +			mdss0_dp1_out: endpoint {
> +				remote-endpoint = <&pmic_glink_con1_ss>;
> +			};
> +		};
> +	};
> +};
> +
>  &mdss0_dp3 {
>  	compatible = "qcom,sc8280xp-edp";
>  	/delete-property/ #sound-dai-cells;
> @@ -480,7 +628,6 @@ &usb_0 {
>  };
>  
>  &usb_0_dwc3 {
> -	/* TODO: Define USB-C connector properly */
>  	dr_mode = "host";
>  };
>  
> @@ -499,12 +646,15 @@ &usb_0_qmpphy {
>  	status = "okay";
>  };
>  
> +&usb_0_role_switch {
> +	remote-endpoint = <&pmic_glink_con0_hs>;
> +};
> +
>  &usb_1 {
>  	status = "okay";
>  };
>  
>  &usb_1_dwc3 {
> -	/* TODO: Define USB-C connector properly */
>  	dr_mode = "host";
>  };
>  
> @@ -523,6 +673,10 @@ &usb_1_qmpphy {
>  	status = "okay";
>  };
>  
> +&usb_1_role_switch {
> +	remote-endpoint = <&pmic_glink_con1_hs>;
> +};
> +
>  &xo_board_clk {
>  	clock-frequency = <38400000>;
>  };
> @@ -709,4 +863,54 @@ reset-n-pins {
>  			drive-strength = <16>;
>  		};
>  	};
> +
> +	usb0_sbu_default: usb0-sbu-state {
> +		oe-n-pins {
> +			pins = "gpio101";
> +			function = "gpio";
> +			bias-disable;
> +			drive-strengh = <16>;
> +			output-high;
> +		};
> +
> +		sel-pins {
> +			pins = "gpio164";
> +			function = "gpio";
> +			bias-disable;
> +			drive-strength = <16>;
> +		};
> +
> +		mode-pins {
> +			pins = "gpio167";
> +			function = "gpio";
> +			bias-disable;
> +			drive-strength = <16>;
> +			output-high;
> +		};
> +	};
> +
> +	usb1_sbu_default: usb1-sbu-state {
> +		oe-n-pins {
> +			pins = "gpio48";
> +			function = "gpio";
> +			bias-disable;
> +			drive-strengh = <16>;
> +			output-high;
> +		};
> +
> +		sel-pins {
> +			pins = "gpio47";
> +			function = "gpio";
> +			bias-disable;
> +			drive-strength = <16>;
> +		};
> +
> +		mode-pins {
> +			pins = "gpio50";
> +			function = "gpio";
> +			bias-disable;
> +			drive-strength = <16>;
> +			output-high;
> +		};
> +	};
>  };
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index 92d5b5e21e50..7897d33f1416 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -3040,6 +3040,11 @@ usb_0_dwc3: usb@a600000 {
>  				iommus = <&apps_smmu 0x820 0x0>;
>  				phys = <&usb_0_hsphy>, <&usb_0_qmpphy QMP_USB43DP_USB3_PHY>;
>  				phy-names = "usb2-phy", "usb3-phy";
> +
> +				port {
> +					usb_0_role_switch: endpoint {
> +					};
> +				};
>  			};
>  		};
>  
> @@ -3095,6 +3100,11 @@ usb_1_dwc3: usb@a800000 {
>  				iommus = <&apps_smmu 0x860 0x0>;
>  				phys = <&usb_1_hsphy>, <&usb_1_qmpphy QMP_USB43DP_USB3_PHY>;
>  				phy-names = "usb2-phy", "usb3-phy";
> +
> +				port {
> +					usb_1_role_switch: endpoint {
> +					};
> +				};
>  			};
>  		};
>  
