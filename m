Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94B6665B25
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 13:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbjAKMO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 07:14:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239341AbjAKMNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 07:13:46 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C9CD2DB
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 04:13:39 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id f34so23174363lfv.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 04:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N01GqMhg99YMVbIVfYT5Yff2jZDnYTTUg1UAgZGvEcE=;
        b=iqCvlvwxpHx47f9Ui6Pqz0Euzs6dlwr6ocNDN872ZRLbQzOAr9glsfw6IMMy7wZW3U
         /diCrIcxA1oeh2xsoGd1HmTkgFr6sZYtR1r225WCrhd/OC69PLSxg+SXX9Yeo4HGVs9I
         aZ1fC4d8YdHOpvXqGIjro64SD7feRJYoIgax6Amg88suHygDSpK2yOCgTSDAnlEvlqtG
         eE0ZL4VZzFL0ierXK6dHXYszV59rIncoYynTx+JYVFzIixLsjJU/axw7/2mgnjcnk2rl
         xUc3bL7wJhmCzfXILyBHKJ7VFpZRGIP/xzEOquvgVZ1M071/oAUkejmPWoMJTk4bqIk1
         sNeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N01GqMhg99YMVbIVfYT5Yff2jZDnYTTUg1UAgZGvEcE=;
        b=uwahBtyivaDZWS+4vHeShKWEa419YKA7rxvCPcFHCFHAVYaBMG+U8g4iJ9GsDJN5eu
         0ssNZG6WsOQXzjc3JfPAoRt3qYBfpOEX4++O0f5sfjalDgBZ4JV39XQ8A2xzbaFwKvQS
         bhPG29lWdBa6Qt+xAIUR/4qCIs2Aa8GUC7An1Hi9+5K/2AYIn7yV94oqExjWpeyYp1nk
         7Gsu+TA1iYYNBRZcrP7cmocXMOil/GDMMpt4W+oCHvY+y6AJZYLnnW8odAPw97d8rkrs
         9pVlOT0PbApDFJmZwIXvAyqE5XUYYXf/wEie00Y+EoZPlVMfWD7atQsgm/YYn3doPkcv
         9VDQ==
X-Gm-Message-State: AFqh2kpZcuN9VEaT31P6OOMqyt0ItBtVD0wzSGkO3ymUjuBrHk76/LIK
        PJC1eRHgvB9H3EAJulc3YOX5Eg==
X-Google-Smtp-Source: AMrXdXu7BUdGtjg28KV2X2UxialiRxiO3PFOL2RqE1tWoFqnSVGRpKZccvc9zR6v0iBEG5PjY9FN/A==
X-Received: by 2002:a05:6512:2a90:b0:4ac:b7bf:697a with SMTP id dt16-20020a0565122a9000b004acb7bf697amr2258602lfb.4.1673439217485;
        Wed, 11 Jan 2023 04:13:37 -0800 (PST)
Received: from [192.168.1.101] (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id q6-20020a056512210600b004aa0870b5e5sm2702193lfr.147.2023.01.11.04.13.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 04:13:36 -0800 (PST)
Message-ID: <e095a785-4dc3-2703-0567-7a759e3a73f2@linaro.org>
Date:   Wed, 11 Jan 2023 13:13:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v7 3/4] arm64: dts: qcom: sa8295-adp: Enable DP instances
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Johan Hovold <johan@kernel.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230111035906.2975494-1-quic_bjorande@quicinc.com>
 <20230111035906.2975494-4-quic_bjorande@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230111035906.2975494-4-quic_bjorande@quicinc.com>
Content-Type: text/plain; charset=UTF-8
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



On 11.01.2023 04:59, Bjorn Andersson wrote:
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> The SA8295P ADP has, among other interfaces, six MiniDP connectors which
> are connected to MDSS0 DP2 and DP3, and MDSS1 DP0 through DP3.
That's a lot of displayports..

> 
> Enable Display Clock controllers, MDSS instanced, MDPs, DP controllers,
> DP PHYs and link them all together.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> 
> Changes since v6:
> - None
> 
>  arch/arm64/boot/dts/qcom/sa8295p-adp.dts | 243 ++++++++++++++++++++++-
>  1 file changed, 241 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> index 84cb6f3eeb56..c35e16b087b8 100644
> --- a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> @@ -23,6 +23,90 @@ aliases {
>  	chosen {
>  		stdout-path = "serial0:115200n8";
>  	};
> +
> +	dp2-connector {
> +		compatible = "dp-connector";
> +		label = "DP2";
> +		type = "mini";
> +
> +		hpd-gpios = <&tlmm 20 GPIO_ACTIVE_HIGH>;
> +
> +		port {
> +			dp2_connector_in: endpoint {
> +				remote-endpoint = <&mdss1_dp0_phy_out>;
> +			};
> +		};
> +	};
> +
> +	dp3-connector {
> +		compatible = "dp-connector";
> +		label = "DP3";
> +		type = "mini";
> +
> +		hpd-gpios = <&tlmm 45 GPIO_ACTIVE_HIGH>;
> +
> +		port {
> +			dp3_connector_in: endpoint {
> +				remote-endpoint = <&mdss1_dp1_phy_out>;
> +			};
> +		};
> +	};
> +
> +	edp0-connector {
> +		compatible = "dp-connector";
> +		label = "EDP0";
> +		type = "mini";
> +
> +		hpd-gpios = <&tlmm 2 GPIO_ACTIVE_HIGH>;
> +
> +		port {
> +			edp0_connector_in: endpoint {
> +				remote-endpoint = <&mdss0_dp2_phy_out>;
> +			};
> +		};
> +	};
> +
> +	edp1-connector {
> +		compatible = "dp-connector";
> +		label = "EDP1";
> +		type = "mini";
> +
> +		hpd-gpios = <&tlmm 3 GPIO_ACTIVE_HIGH>;
> +
> +		port {
> +			edp1_connector_in: endpoint {
> +				remote-endpoint = <&mdss0_dp3_phy_out>;
> +			};
> +		};
> +	};
> +
> +	edp2-connector {
> +		compatible = "dp-connector";
> +		label = "EDP2";
> +		type = "mini";
> +
> +		hpd-gpios = <&tlmm 7 GPIO_ACTIVE_HIGH>;
> +
> +		port {
> +			edp2_connector_in: endpoint {
> +				remote-endpoint = <&mdss1_dp2_phy_out>;
> +			};
> +		};
> +	};
> +
> +	edp3-connector {
> +		compatible = "dp-connector";
> +		label = "EDP3";
> +		type = "mini";
> +
> +		hpd-gpios = <&tlmm 6 GPIO_ACTIVE_HIGH>;
> +
> +		port {
> +			edp3_connector_in: endpoint {
> +				remote-endpoint = <&mdss1_dp3_phy_out>;
> +			};
> +		};
> +	};
>  };
>  
>  &apps_rsc {
> @@ -159,13 +243,168 @@ vreg_l7g: ldo7 {
>  
>  		vreg_l8g: ldo8 {
>  			regulator-name = "vreg_l8g";
> -			regulator-min-microvolt = <880000>;
> -			regulator-max-microvolt = <880000>;
> +			regulator-min-microvolt = <912000>;
> +			regulator-max-microvolt = <912000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l11g: ldo11 {
> +			regulator-name = "vreg_l11g";
> +			regulator-min-microvolt = <912000>;
> +			regulator-max-microvolt = <912000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  	};
>  };
>  
> +&dispcc0 {
> +	status = "okay";
> +};
> +
> +&dispcc1 {
> +	status = "okay";
> +};
> +
> +&mdss0 {
> +	status = "okay";
> +};
> +
> +&mdss0_dp2 {
> +	data-lanes = <0 1 2 3>;
> +
> +	status = "okay";
> +
> +	ports {
> +		port@1 {
> +			reg = <1>;
> +			mdss0_dp2_phy_out: endpoint {
> +				remote-endpoint = <&edp0_connector_in>;
> +			};
> +		};
> +	};
> +};
> +
> +&mdss0_dp2_phy {
> +	vdda-phy-supply = <&vreg_l8g>;
> +	vdda-pll-supply = <&vreg_l3g>;
> +
> +	status = "okay";
> +};
> +
> +&mdss0_dp3 {
> +	data-lanes = <0 1 2 3>;
> +
> +	status = "okay";
> +
> +	ports {
> +		port@1 {
> +			reg = <1>;
> +			mdss0_dp3_phy_out: endpoint {
> +				remote-endpoint = <&edp1_connector_in>;
> +			};
> +		};
> +	};
> +};
> +
> +&mdss0_dp3_phy {
> +	vdda-phy-supply = <&vreg_l8g>;
> +	vdda-pll-supply = <&vreg_l3g>;
> +
> +	status = "okay";
> +};
> +
> +&mdss1 {
> +	status = "okay";
> +};
> +
> +&mdss1_dp0 {
> +	data-lanes = <0 1 2 3>;
> +
> +	status = "okay";
> +
> +	ports {
> +		port@1 {
> +			reg = <1>;
> +			mdss1_dp0_phy_out: endpoint {
> +				remote-endpoint = <&dp2_connector_in>;
> +			};
> +		};
> +	};
> +};
> +
> +&mdss1_dp0_phy {
> +	vdda-phy-supply = <&vreg_l11g>;
> +	vdda-pll-supply = <&vreg_l3g>;
> +
> +	status = "okay";
> +};
> +
> +&mdss1_dp1 {
> +	data-lanes = <0 1 2 3>;
> +
> +	status = "okay";
> +
> +	ports {
> +		port@1 {
> +			reg = <1>;
> +			mdss1_dp1_phy_out: endpoint {
> +				remote-endpoint = <&dp3_connector_in>;
> +			};
> +		};
> +	};
> +};
> +
> +&mdss1_dp1_phy {
> +	vdda-phy-supply = <&vreg_l11g>;
> +	vdda-pll-supply = <&vreg_l3g>;
> +
> +	status = "okay";
> +};
> +
> +&mdss1_dp2 {
> +	data-lanes = <0 1 2 3>;
> +
> +	status = "okay";
> +
> +	ports {
> +		port@1 {
> +			reg = <1>;
> +			mdss1_dp2_phy_out: endpoint {
> +				remote-endpoint = <&edp2_connector_in>;
> +			};
> +		};
> +	};
> +};
> +
> +&mdss1_dp2_phy {
> +	vdda-phy-supply = <&vreg_l11g>;
> +	vdda-pll-supply = <&vreg_l3g>;
> +
> +	status = "okay";
> +};
> +
> +&mdss1_dp3 {
> +	data-lanes = <0 1 2 3>;
> +
> +	status = "okay";
> +
> +	ports {
> +		port@1 {
> +			reg = <1>;
> +			mdss1_dp3_phy_out: endpoint {
> +				remote-endpoint = <&edp3_connector_in>;
> +			};
> +		};
> +	};
> +};
> +
> +&mdss1_dp3_phy {
> +	vdda-phy-supply = <&vreg_l11g>;
> +	vdda-pll-supply = <&vreg_l3g>;
> +
> +	status = "okay";
> +};
> +
>  &pcie2a {
>  	perst-gpios = <&tlmm 143 GPIO_ACTIVE_LOW>;
>  	wake-gpios = <&tlmm 145 GPIO_ACTIVE_LOW>;
