Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2435C642F9E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 19:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbiLESJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 13:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiLESJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 13:09:50 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A2FB10
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 10:09:49 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id b3so19866236lfv.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 10:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ygEPlHYIIbXAkVkRyyQhAxFfq5zBnEqOicPGwf/WsU=;
        b=Vw/JTpQ1krpQXq0KPjaPn1fOgZbVwgTiAQdsY1mYISovHNk+XYvP7hgdmJ/pWU0Hqf
         OiRGQfNlL9qzbpfQHbKwGuFE0VWht5/D5tRhz8v7r7wlQFADcOjqbkaREyEw97ey1izT
         qFFOQ766ada8SHct1HuqMXC/nQA3FtsDuU3wnV1XCBnKQ8d95C9Um7tAYFYwXJI/+iSp
         4/lrsIvuKwfNsGffK9dldjEa1/gqb53EhAjajlW5Rr1AxVVqGCvYvzuhS++GZt0Vue86
         uKBVavXbAm+FUQuhJXBsMjNIYfOEVmTC9vDH7ybCvpXh6e6BwBIGB3SFCJHXs0Jj9e79
         d3JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1ygEPlHYIIbXAkVkRyyQhAxFfq5zBnEqOicPGwf/WsU=;
        b=4woIqBBZ6meJf+X3nFBKY7QYY6epjf6oCqdLrMIpYCsNZYZQ+TotJ7ZVTuCB09JQsc
         r0e8Nz24iRl1fwwCThPTMxoioW9KCPOK5re9AELILFIkrrFu28SAzK1lu0o+lO38Iepz
         iMkJ1OGfDZISsxKJc/geZqSov2NmCvn9Gb0QsadYwy5sExRiT1OmXTPmVawMvE5FRHw6
         GSwzoUakV5/iTe/w2Q3M6svLrQaE8gZDXAFpEeKKnnB8J8myJxMSuSDgM+bV52me3BIF
         OsJ7LtpCDFtFFU6/9vzWbsb7HKI2z576TR+/1IOz62qkp/vvrYDl81S+RX/aVopqv5/4
         BPAg==
X-Gm-Message-State: ANoB5plvl1YGg28MsMfIRE2uMUQEoBaGQA62V9qYEwksXlNidMxeH3ZH
        soxTOeYbD2ktFIzTLX7ASeZK/Q==
X-Google-Smtp-Source: AA0mqf5z7wLp2Dz1hSeqBNT+xZUYZDY1Sc5BuFV3VZ6xSH3BN6dWJXybUuNwSewVfTY3XHvEJRNJlg==
X-Received: by 2002:a05:6512:2215:b0:4b5:5efb:7d29 with SMTP id h21-20020a056512221500b004b55efb7d29mr4113966lfu.477.1670263787929;
        Mon, 05 Dec 2022 10:09:47 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id a2-20020a19ca02000000b004946a1e045fsm2175600lfg.197.2022.12.05.10.09.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 10:09:47 -0800 (PST)
Message-ID: <b58f6935-b6ac-128b-2fec-a06dccc3210f@linaro.org>
Date:   Mon, 5 Dec 2022 19:09:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH v4 13/13] arm64: dts: qcom: sa8295-adp: Enable DP
 instances
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Kalyan Thota <quic_kalyant@quicinc.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221205174433.16847-1-quic_bjorande@quicinc.com>
 <20221205174433.16847-14-quic_bjorande@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221205174433.16847-14-quic_bjorande@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/12/2022 18:44, Bjorn Andersson wrote:
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> The SA8295P ADP has, among other interfaces, six MiniDP connectors which
> are connected to MDSS0 DP2 and DP3, and MDSS1 DP0 through DP3.
> 
> Enable Display Clock controllers, MDSS instanced, MDPs, DP controllers,
> DP PHYs and link them all together.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
> 
> Changes since v3:
> - None
> 
>   arch/arm64/boot/dts/qcom/sa8295p-adp.dts | 243 ++++++++++++++++++++++-
>   1 file changed, 241 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> index 6c29d7d757e0..d55c8c5304cc 100644
> --- a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> @@ -23,6 +23,90 @@ aliases {
>   	chosen {
>   		stdout-path = "serial0:115200n8";
>   	};
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
>   };
>   
>   &apps_rsc {
> @@ -163,13 +247,168 @@ vreg_l7g: ldo7 {
>   
>   		vreg_l8g: ldo8 {
>   			regulator-name = "vreg_l8g";
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
>   			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>   		};
>   	};
>   };
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
> +	status = "okay";
status should go last.

> +
> +	data-lanes = <0 1 2 3>;
> +
> +	ports {
> +		port@1 {
> +			reg = <1>;
> +			mdss0_dp2_phy_out: endpoint {
That's quite a lot of indentation.. couldn't these endpoints be defined 
in the SoC DT?

Konrad
> +				remote-endpoint = <&edp0_connector_in>;
> +			};
> +		};
> +	};
> +};
> +
> +&mdss0_dp2_phy {
> +	status = "okay";
> +
> +	vdda-phy-supply = <&vreg_l8g>;
> +	vdda-pll-supply = <&vreg_l3g>;
> +};
> +
> +&mdss0_dp3 {
> +	status = "okay";
> +
> +	data-lanes = <0 1 2 3>;
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
> +	status = "okay";
> +
> +	vdda-phy-supply = <&vreg_l8g>;
> +	vdda-pll-supply = <&vreg_l3g>;
> +};
> +
> +&mdss1 {
> +	status = "okay";
> +};
> +
> +&mdss1_dp0 {
> +	status = "okay";
> +
> +	data-lanes = <0 1 2 3>;
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
> +	status = "okay";
> +
> +	vdda-phy-supply = <&vreg_l11g>;
> +	vdda-pll-supply = <&vreg_l3g>;
> +};
> +
> +&mdss1_dp1 {
> +	status = "okay";
> +
> +	data-lanes = <0 1 2 3>;
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
> +	status = "okay";
> +
> +	vdda-phy-supply = <&vreg_l11g>;
> +	vdda-pll-supply = <&vreg_l3g>;
> +};
> +
> +&mdss1_dp2 {
> +	status = "okay";
> +
> +	data-lanes = <0 1 2 3>;
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
> +	status = "okay";
> +
> +	vdda-phy-supply = <&vreg_l11g>;
> +	vdda-pll-supply = <&vreg_l3g>;
> +};
> +
> +&mdss1_dp3 {
> +	status = "okay";
> +
> +	data-lanes = <0 1 2 3>;
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
> +	status = "okay";
> +
> +	vdda-phy-supply = <&vreg_l11g>;
> +	vdda-pll-supply = <&vreg_l3g>;
> +};
> +
>   &pcie2a {
>   	perst-gpios = <&tlmm 143 GPIO_ACTIVE_LOW>;
>   	wake-gpios = <&tlmm 145 GPIO_ACTIVE_LOW>;
