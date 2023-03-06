Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62FA6ABBF6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 11:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjCFKXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 05:23:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbjCFKXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 05:23:33 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA0A2055A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 02:23:27 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id i28so12100629lfv.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 02:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678098205;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JWM3uoIWSBi9gdfe15K0CB/2af2xrB7cRCboAng8434=;
        b=h/5jrvXjyn4X3yazsCQGVrdM17weqY/s+CjorCY2yuVRHY/oY1QOBNX9ta3dvsBPtz
         Ysj2KEMTsz+6bH30J3o9MB5b8aK2gnWalqJGa2pMQW4d6FtoRJkTjuEgo9x87MHZpDL5
         29GipkhEBMWKdP6k/SPglSyeEdSfntLFQZsozSMQFJdV0qW8j18xsCMjPpSAToxJSHQo
         B+15Bhad8qPXMXW/dg09rdRekvLNyI9Pxdk3vV/1s3LnRA94tSUd9IuKR94GNh37+Cq2
         Me9khQBWsJmk73NyCAHenSVMjBH3FMfM0f/S2Yo5tOjvu9HArHpSAvCT7A5fYHSqZV4c
         ofxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678098205;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JWM3uoIWSBi9gdfe15K0CB/2af2xrB7cRCboAng8434=;
        b=JIIRjmw7pIaN/Hdfji59TfzeNt3JUQ+9/gVdrKTrQeFeAPm8HmHD95aKjt+DFNZadK
         7ljW5p8/BDx5yuJyFzR5tBtRAF+JkUPRiM05EkyjBseOQGKjuQTkzFjZI5VtxrRn4wc/
         KAkGPa1lqs1evOffdBgge3b6/slrBXvhWyDZJ7EERvlFVWLITBOwEG5SDQdY6Yk5WSc6
         qf/91QiAh4Gkie5iNjRkQLp90XmflFVcPiCn1mNKRcPX45bBj59tJZo0EaqdlqFiWP8a
         ysnr33QorXmRr6CyY4gY/jNuUoeZEAHmcgC+cJtS5KUjG0kciKHki6chZMEwmz0D7G0E
         MDRg==
X-Gm-Message-State: AO0yUKVV4V4a7qklQ8mL7H5uiJnb5Ehz2+eestRn7OGcWUF+xeB6XzBE
        60xL/13iB/avpfoL+XAdNNzTbA==
X-Google-Smtp-Source: AK7set8AnDMwoH9i6/EQvYNulKkWNktaCrlqRIA4ToRjxT//IExasNkrN/eFvVdcQo+FZpqki5v49Q==
X-Received: by 2002:ac2:518c:0:b0:4dd:cb1d:b3cc with SMTP id u12-20020ac2518c000000b004ddcb1db3ccmr2938902lfi.11.1678098205117;
        Mon, 06 Mar 2023 02:23:25 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id i27-20020a056512007b00b004db0d26adb4sm1439772lfo.182.2023.03.06.02.23.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 02:23:24 -0800 (PST)
Message-ID: <5374b9ae-5c3d-8a4c-4274-a166af23d2ba@linaro.org>
Date:   Mon, 6 Mar 2023 11:23:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/2] arm64: dts: qcom: drop redundant line breaks
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230306081430.28491-1-krzysztof.kozlowski@linaro.org>
 <20230306081430.28491-2-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230306081430.28491-2-krzysztof.kozlowski@linaro.org>
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



On 6.03.2023 09:14, Krzysztof Kozlowski wrote:
> Remove trailing, redundant line breaks.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/apq8096-db820c.dts                 | 1 -
>  arch/arm64/boot/dts/qcom/msm8916.dtsi                       | 1 -
>  arch/arm64/boot/dts/qcom/msm8996.dtsi                       | 2 --
>  arch/arm64/boot/dts/qcom/sc7180.dtsi                        | 1 -
>  arch/arm64/boot/dts/qcom/sc7280.dtsi                        | 3 ---
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi                      | 2 --
>  arch/arm64/boot/dts/qcom/sdm670-google-sargo.dts            | 1 -
>  arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dts          | 1 -
>  arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts | 2 --
>  arch/arm64/boot/dts/qcom/sm6350.dtsi                        | 2 --
>  arch/arm64/boot/dts/qcom/sm6375.dtsi                        | 1 -
>  arch/arm64/boot/dts/qcom/sm8150.dtsi                        | 1 -
>  arch/arm64/boot/dts/qcom/sm8250.dtsi                        | 4 ----
>  arch/arm64/boot/dts/qcom/sm8350-hdk.dts                     | 1 -
>  arch/arm64/boot/dts/qcom/sm8350.dtsi                        | 1 -
>  arch/arm64/boot/dts/qcom/sm8450-hdk.dts                     | 1 -
>  arch/arm64/boot/dts/qcom/sm8450-qrd.dts                     | 1 -
>  arch/arm64/boot/dts/qcom/sm8450.dtsi                        | 3 ---
>  18 files changed, 29 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
> index 842836ed680a..5ceaab5d4039 100644
> --- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
> +++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
> @@ -1137,7 +1137,6 @@ &usb3phy {
>  
>  	vdda-phy-supply = <&vreg_l28a_0p925>;
>  	vdda-pll-supply = <&vreg_l12a_1p8>;
> -
>  };
>  
>  &venus {
> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> index 0733c2f4f379..bea56955cb30 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> @@ -2180,7 +2180,6 @@ modem_alert0: trip-point0 {
>  				};
>  			};
>  		};
> -
>  	};
>  
>  	timer {
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> index 293ed2e60691..0efef2efd847 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -1882,7 +1882,6 @@ pcie0: pcie@600000 {
>  						"cfg",
>  						"bus_master",
>  						"bus_slave";
> -
>  			};
>  
>  			pcie1: pcie@608000 {
> @@ -3468,7 +3467,6 @@ q6routing: routing {
>  						};
>  					};
>  				};
> -
>  			};
>  		};
>  
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index 51bb0a2f25ef..99ec844da32e 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -3019,7 +3019,6 @@ opp-460000000 {
>  						required-opps = <&rpmhpd_opp_nom>;
>  					};
>  				};
> -
>  			};
>  
>  			dsi0: dsi@ae94000 {
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 71179182c3b8..90ed277dc821 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -935,7 +935,6 @@ opp-384000000 {
>  					opp-avg-kBps = <390000 0>;
>  				};
>  			};
> -
>  		};
>  
>  		gpi_dma0: dma-controller@900000 {
> @@ -3289,7 +3288,6 @@ opp-202000000 {
>  					opp-avg-kBps = <200000 0>;
>  				};
>  			};
> -
>  		};
>  
>  		usb_1_hsphy: phy@88e3000 {
> @@ -3757,7 +3755,6 @@ opp-460000048 {
>  					required-opps = <&rpmhpd_opp_turbo>;
>  				};
>  			};
> -
>  		};
>  
>  		videocc: clock-controller@aaf0000 {
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index 1bb4b658065d..1a3d15e6d381 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -2772,7 +2772,6 @@ data-pins {
>  					drive-strength = <2>;
>  					slew-rate = <1>;
>  					bias-bus-hold;
> -
>  				};
>  			};
>  
> @@ -4397,7 +4396,6 @@ opp-810000000 {
>  						required-opps = <&rpmhpd_opp_nom>;
>  					};
>  				};
> -
>  			};
>  
>  			mdss1_dp1: displayport-controller@22098000 {
> diff --git a/arch/arm64/boot/dts/qcom/sdm670-google-sargo.dts b/arch/arm64/boot/dts/qcom/sdm670-google-sargo.dts
> index e3e61b9d1b9d..32a7bd59e1ec 100644
> --- a/arch/arm64/boot/dts/qcom/sdm670-google-sargo.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm670-google-sargo.dts
> @@ -395,7 +395,6 @@ vreg_bob: bob {
>  			regulator-enable-ramp-delay = <500>;
>  		};
>  	};
> -
>  };
>  
>  &gcc {
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dts b/arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dts
> index 086d14e2de92..d82c0d4407f0 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dts
> @@ -45,7 +45,6 @@ &sound {
>  			"AMIC3", "MIC BIAS4",
>  			"AMIC4", "MIC BIAS1",
>  			"AMIC5", "MIC BIAS3";
> -
>  };
>  
>  /*
> diff --git a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> index 4916d0db5b47..2a3ad478892b 100644
> --- a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> +++ b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> @@ -233,7 +233,6 @@ pm6150l_l6: ldo6 {
>  			regulator-allow-set-load;
>  			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
>  						   RPMH_REGULATOR_MODE_HPM>;
> -
>  		};
>  
>  		pm6150l_l7: ldo7 {
> @@ -255,7 +254,6 @@ pm6150l_l9: ldo9 {
>  			regulator-allow-set-load;
>  			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
>  						   RPMH_REGULATOR_MODE_HPM>;
> -
>  		};
>  
>  		pm6150l_l10: ldo10 {
> diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
> index 1e1d366c92c1..1668f05ade12 100644
> --- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
> @@ -170,7 +170,6 @@ L2_500: l2-cache {
>  				cache-level = <2>;
>  				next-level-cache = <&L3_0>;
>  			};
> -
>  		};
>  
>  		CPU6: cpu@600 {
> @@ -880,7 +879,6 @@ i2c10: i2c@990000 {
>  				interconnect-names = "qup-core", "qup-config", "qup-memory";
>  				status = "disabled";
>  			};
> -
>  		};
>  
>  		config_noc: interconnect@1500000 {
> diff --git a/arch/arm64/boot/dts/qcom/sm6375.dtsi b/arch/arm64/boot/dts/qcom/sm6375.dtsi
> index 31b88c738510..a99a5641623f 100644
> --- a/arch/arm64/boot/dts/qcom/sm6375.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6375.dtsi
> @@ -132,7 +132,6 @@ L2_500: l2-cache {
>  			      compatible = "cache";
>  			      next-level-cache = <&L3_0>;
>  			};
> -
>  		};
>  
>  		CPU6: cpu@600 {
> diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> index f89abf131e01..d565f56ec4d2 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> @@ -90,7 +90,6 @@ L2_100: l2-cache {
>  				cache-level = <2>;
>  				next-level-cache = <&L3_0>;
>  			};
> -
>  		};
>  
>  		CPU2: cpu@200 {
> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> index 88870d9e3348..79d67b466856 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> @@ -241,7 +241,6 @@ L2_500: l2-cache {
>  				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
> -
>  		};
>  
>  		CPU6: cpu@600 {
> @@ -2420,7 +2419,6 @@ data-pins {
>  					drive-strength = <2>;
>  					slew-rate = <1>;
>  					bias-bus-hold;
> -
>  				};
>  			};
>  
> @@ -2439,7 +2437,6 @@ data-pins {
>  					drive-strength = <2>;
>  					input-enable;
>  					bias-pull-down;
> -
>  				};
>  			};
>  
> @@ -2923,7 +2920,6 @@ funnel_swao_in_funnel_merg: endpoint {
>  					};
>  				};
>  			};
> -
>  		};
>  
>  		etf@6b05000 {
> diff --git a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
> index 09baf6959c71..b0fbfac43df7 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
> @@ -644,7 +644,6 @@ wake-pins {
>  			bias-pull-up;
>  		};
>  	};
> -
>  };
>  
>  &uart2 {
> diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> index 1c97e28da6ad..2431b77e38d8 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> @@ -149,7 +149,6 @@ L2_500: l2-cache {
>  			      cache-level = <2>;
>  			      next-level-cache = <&L3_0>;
>  			};
> -
>  		};
>  
>  		CPU6: cpu@600 {
> diff --git a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
> index feef3837e4cd..9fa1a83d9554 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
> @@ -343,7 +343,6 @@ vreg_l3h_0p91: ldo3 {
>  			regulator-max-microvolt = <912000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
> -
>  	};
>  
>  	regulators-3 {
> diff --git a/arch/arm64/boot/dts/qcom/sm8450-qrd.dts b/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
> index f7592946c783..65a94dfaf5ae 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
> @@ -282,7 +282,6 @@ vreg_l3h_0p91: ldo3 {
>  			regulator-max-microvolt = <912000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
> -
>  	};
>  
>  	regulators-3 {
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index 1a744a33bcf4..42833188a257 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -154,7 +154,6 @@ L2_500: l2-cache {
>  			      cache-level = <2>;
>  			      next-level-cache = <&L3_0>;
>  			};
> -
>  		};
>  
>  		CPU6: cpu@600 {
> @@ -2762,7 +2761,6 @@ dpu_intf2_out: endpoint {
>  							remote-endpoint = <&mdss_dsi1_in>;
>  						};
>  					};
> -
>  				};
>  
>  				mdp_opp_table: opp-table {
> @@ -3569,7 +3567,6 @@ qup_uart20_default: qup-uart20-default-state {
>  				pins = "gpio76", "gpio77", "gpio78", "gpio79";
>  				function = "qup20";
>  			};
> -
>  		};
>  
>  		lpass_tlmm: pinctrl@3440000 {
