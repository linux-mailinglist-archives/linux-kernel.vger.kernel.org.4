Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEEA6F6551
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 08:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjEDGyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 02:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjEDGx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 02:53:58 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7496C2122
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 23:53:56 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f139de8cefso7313511e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 23:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683183235; x=1685775235;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JN+v9dMjA1giZPkxxS3P8SCGgCWNxpxAeM9/NOoTCcQ=;
        b=MpENUiXYtNq1lFFkrrFgTXDc1q6znl832WAxjdC2bTCa3a6/u7EoBFRzWp8xnGS63c
         RARhT8wrlOjLNf37wsOiGWudbysVponVkJl/Ng7pbeGMv+cOgWGsa79EsjaEhjm0+OxY
         1ytoJTI4xX6+pJI8jGWkRYPUpgdV43+9MhrFNvEQQmcjD2Ips6AHFGFVgpiZkn/tgxc7
         xLoBkQGaFF2ve0SswAixyNBd0MwWfACobFvpXKHg3XbJL+RR0RfOfwstJ+U+K4BD+2qW
         Q/7Cp1G+VqO7R5Rr29tMHKvA0iRVOPM33lhAeqIJPnPP9A7zgqLPe3wlmnzSQVXnGuQQ
         hP1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683183235; x=1685775235;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JN+v9dMjA1giZPkxxS3P8SCGgCWNxpxAeM9/NOoTCcQ=;
        b=TYX89yjTYtDtGXJeeFvHs7lMY+l/3jTpWzPj4DWSeetwhTqsXLRepiTDqKSFmInv0D
         YwZnyHUjWJUuWAKIILNKWzGwE7eaLyt97XsVBAADmFyYdJ7XEvShP8ceQ3DzDTWOCM37
         a+O+b90EymlKK7Jf9AP5LLomE2N9Npz1mZUGZNu0oA68XfQyTEfR2ZtWlBA3qd4dvvkh
         e20rfWagvRVN6wr+FThTe6XjRD/ud8OOzuY1dJqrO8IJR4b4jDLBsQKYdjca6GfO1rOd
         YKgqY2/U9AHxJIDu13jXsR9GwaOxY1LvMTLd8MDP65jlsG1Spyu1ve5nIQuvM1NaaIQs
         pzXw==
X-Gm-Message-State: AC+VfDyT+2lNn8dpQt6WlwXX/rszG27YpQB+gmcG6Iyai2jvZ3OH3KsM
        HfIIloX0wHy75WTbMsLoH0kHYg==
X-Google-Smtp-Source: ACHHUZ7SeG/oZyV8jd9VWgNUOnesva+FzKIshS1OLVWnmFmh9oWrRDHkZqLPAy+xn0HnbeUDmyodBQ==
X-Received: by 2002:a05:6512:b08:b0:4dc:8049:6f36 with SMTP id w8-20020a0565120b0800b004dc80496f36mr960004lfu.1.1683183234687;
        Wed, 03 May 2023 23:53:54 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id w16-20020ac24430000000b004efe9fc130esm5635107lfl.251.2023.05.03.23.53.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 23:53:54 -0700 (PDT)
Message-ID: <c985201e-6916-1ad8-4a11-cfc3bc288733@linaro.org>
Date:   Thu, 4 May 2023 08:53:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 3/6] arm64: dts: qcom: sm8350-hdk: Add QMP & DP to
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
 <20230503-topic-sm8450-graphics-dp-next-v1-3-d1ee9397f2a6@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230503-topic-sm8450-graphics-dp-next-v1-3-d1ee9397f2a6@linaro.org>
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
>  arch/arm64/boot/dts/qcom/sm8350-hdk.dts | 74 ++++++++++++++++++++++++++++++++-
>  1 file changed, 72 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
> index 2ee1b121686a..fa835bdb7408 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
> @@ -58,7 +58,15 @@ port@1 {
>  					reg = <1>;
>  
>  					pmic_glink_ss_in: endpoint {
> -						remote-endpoint = <&usb_1_dwc3_ss>;
> +						remote-endpoint = <&usb_1_qmpphy_out>;
> +					};
> +				};
> +
> +				port@2 {
> +					reg = <2>;
> +
> +					pmic_glink_sbu: endpoint {
> +						remote-endpoint = <&fsa4480_sbu_mux>;
>  					};
>  				};
>  			};
> @@ -326,6 +334,36 @@ zap-shader {
>  	};
>  };
>  
> +&i2c13 {
> +	status = "okay";
> +	clock-frequency = <100000>;
Status last

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
>  &i2c15 {
>  	clock-frequency = <400000>;
>  	status = "okay";
> @@ -370,6 +408,20 @@ &mdss {
>  	status = "okay";
>  };
>  
> +&mdss_dp {
> +	status = "okay";
> +
> +	ports {
> +		port@1 {
> +			reg = <1>;
missing newline

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
> @@ -416,6 +468,10 @@ &qupv3_id_0 {
>  	status = "okay";
>  };
>  
> +&qupv3_id_1 {
> +	status = "okay";
> +};
> +
>  &qupv3_id_2 {
>  	status = "okay";
>  };
> @@ -716,7 +772,7 @@ &usb_1_dwc3_hs {
>  };
>  
>  &usb_1_dwc3_ss {
> -	remote-endpoint = <&pmic_glink_ss_in>;
> +	remote-endpoint = <&usb_1_qmpphy_usb_ss_in>;
>  };
>  
>  &usb_1_hsphy {
> @@ -732,6 +788,20 @@ &usb_1_qmpphy {
>  
>  	vdda-phy-supply = <&vreg_l6b_1p2>;
>  	vdda-pll-supply = <&vreg_l1b_0p88>;
> +
> +	orientation-switch;
this is a common property which will/should be ignored if no
usbc is present

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
'd' < 'o' < 'u'

with that fixed

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  };
>  
>  &usb_2 {
> 
