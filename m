Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAD86F6555
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 08:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjEDGyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 02:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjEDGyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 02:54:24 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EA12122
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 23:54:13 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2ac79d4858dso1354531fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 23:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683183252; x=1685775252;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KHCGOfUYtqR6tCUbzOdPKIgkFgXtwzujgmUslCJyBVI=;
        b=JWR4sASd6R6szCSV3B2M8a1C+bRnpoYuQdUbsHAZ5WY/U2+wyGHJWyjO1wXwpKfqsh
         CsaVHyK0NtB4tyCtxhlS5luUyArzCBrkGeBJm5bMoOzjnvUiV/CJTbsQyiZEtSchEFmH
         GS9BeYN3QLLxixkgH9rY93PMjQVMYnMm4G0Zyk391nJ4P4iq1TlfC5WNSnZs9KRKez6Q
         WpgQpjuIB6Fbnb8EwSIiiIxRySrpBJudTlc2ll7dFLFvlppQoKd1zlHmq58W9Bd6DHGf
         RfNayqFzvle1MHEvlheL4+mnSz3oOjK//Ppk/LZwPw0h6XyshxNQU+cUddGXoqFQzuoy
         202Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683183252; x=1685775252;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KHCGOfUYtqR6tCUbzOdPKIgkFgXtwzujgmUslCJyBVI=;
        b=cefZt03MCX9/3seoxuT2n1fIl9zxxcRTHfWzXCly6e/30RZn3kfdsg44F3/s08MK68
         olc1CG+ujC8IXZKmHqXI5wWRE0BRIzxXe8+eoCGGagwGQT31poAs3ki6mGmcFxbFy1bS
         nHLkjgThA/M9c9uQ/wScBx/Q+e9Q9fBoLX9kuKEw0xgd3Im9zDN1UqwO1mn8lx3BOjhv
         5Y2wIQspdANEmqZAuyxxYGKexzCddjC/hznPXzQU7vM5oTFmv+sWrcmBxE04aIWpirpj
         FoWzwxeh0J2QB8xsXWvEGMdHq7Dtpx+Z3JRC4jA/xCHoMUzdU6P/e8n1ieqwLxCi3bxW
         IHew==
X-Gm-Message-State: AC+VfDzaBNCN+d1WOA54mBA5lQ5DhyxwSonhTCA+w+sIQ/OxRNSOKA/W
        q+1B+FZxm+PUAH9AsCxrwjmuPQ==
X-Google-Smtp-Source: ACHHUZ6IhS/XLQit3LElxmynOzCUvcvuJBWTUfPMwMErPMz2oZe4MyAjg12ARcpkZprdX3CTtK+6+A==
X-Received: by 2002:a2e:8058:0:b0:2a9:b6fe:18b3 with SMTP id p24-20020a2e8058000000b002a9b6fe18b3mr697840ljg.19.1683183251933;
        Wed, 03 May 2023 23:54:11 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id 9-20020a05651c008900b002a776dbc277sm6458331ljq.124.2023.05.03.23.54.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 23:54:11 -0700 (PDT)
Message-ID: <beb24bbe-034e-128b-0a77-84981574adb7@linaro.org>
Date:   Thu, 4 May 2023 08:54:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 4/6] arm64: dts: qcom: sm8450-hdk: Add QMP & DP to
 SuperSpeed graph
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230503-topic-sm8450-graphics-dp-next-v1-0-d1ee9397f2a6@linaro.org>
 <20230503-topic-sm8450-graphics-dp-next-v1-4-d1ee9397f2a6@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230503-topic-sm8450-graphics-dp-next-v1-4-d1ee9397f2a6@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3.05.2023 15:10, Neil Armstrong wrote:
> With support for the QMP combo phy to react to USB Type-C switch events,
> introduce it as the next hop for the SuperSpeed lanes of the Type-C
> connector, and connect the output of the DisplayPort controller
> to the QMP combo phy.
> 
> This allows the TCPM to perform orientation switching of both USB and
> DisplayPort signals.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
same comments as p3

Konrad
>  arch/arm64/boot/dts/qcom/sm8450-hdk.dts | 71 ++++++++++++++++++++++++++++++++-
>  1 file changed, 69 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
> index e931545a2cac..52a14ae0321b 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
> @@ -114,9 +114,18 @@ port@1 {
>  					reg = <1>;
>  
>  					pmic_glink_ss_in: endpoint {
> -						remote-endpoint = <&usb_1_dwc3_ss>;
> +						remote-endpoint = <&usb_1_qmpphy_out>;
>  					};
>  				};
> +
> +				port@2 {
> +					reg = <2>;
> +
> +					pmic_glink_sbu: endpoint {
> +						remote-endpoint = <&fsa4480_sbu_mux>;
> +					};
> +				};
> +
>  			};
>  		};
>  	};
> @@ -494,6 +503,36 @@ lt9611_out: endpoint {
>  	};
>  };
>  
> +&i2c5 {
> +	status = "okay";
> +	clock-frequency = <100000>;
> +
> +	fsa4480@42 {
> +		compatible = "fcs,fsa4480";
> +		reg = <0x42>;
> +
> +		interrupts-extended = <&tlmm 2 IRQ_TYPE_LEVEL_LOW>;
> +
> +		vcc-supply = <&vreg_bob>;
> +		mode-switch;
> +		orientation-switch;
> +		svid = /bits/ 16 <0xff01>;
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;
> +
> +				fsa4480_sbu_mux: endpoint {
> +					remote-endpoint = <&pmic_glink_sbu>;
> +				};
> +			};
> +		};
> +	};
> +};
> +
>  &mdss {
>  	status = "okay";
>  };
> @@ -513,6 +552,20 @@ &mdss_dsi0_phy {
>  	status = "okay";
>  };
>  
> +&mdss_dp0 {
> +	status = "okay";
> +
> +	ports {
> +		port@1 {
> +			reg = <1>;
> +			mdss_dp0_out: endpoint {
> +				data-lanes = <0 1>;
> +				remote-endpoint = <&usb_1_qmpphy_dp_in>;
> +			};
> +		};
> +	};
> +};
> +
>  &mdss_mdp {
>  	status = "okay";
>  };
> @@ -766,7 +819,7 @@ &usb_1_dwc3_hs {
>  };
>  
>  &usb_1_dwc3_ss {
> -	remote-endpoint = <&pmic_glink_ss_in>;
> +	remote-endpoint = <&usb_1_qmpphy_usb_ss_in>;
>  };
>  
>  &usb_1_hsphy {
> @@ -782,6 +835,20 @@ &usb_1_qmpphy {
>  
>  	vdda-phy-supply = <&vreg_l6b_1p2>;
>  	vdda-pll-supply = <&vreg_l1b_0p91>;
> +
> +	orientation-switch;
> +};
> +
> +&usb_1_qmpphy_out {
> +	remote-endpoint = <&pmic_glink_ss_in>;
> +};
> +
> +&usb_1_qmpphy_usb_ss_in {
> +	remote-endpoint = <&usb_1_dwc3_ss>;
> +};
> +
> +&usb_1_qmpphy_dp_in {
> +	remote-endpoint = <&mdss_dp0_out>;
>  };
>  
>  &vamacro {
> 
