Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A83373C641
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 04:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbjFXCFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 22:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbjFXCFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 22:05:14 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB35273E
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 19:05:11 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f954d78bf8so1763464e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 19:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687572310; x=1690164310;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A95yabU0fWahrV4bS2jxEmyDFJAUbPcvq1i/SCHm4mA=;
        b=yBZbnHP6xQHbX5Ew0k1UF0mcbKylxKWFvoDlyKTfSTFRW4tqsY6NX/OUrtNpv25UAu
         JE50jLZxSOpU8CPiwKrBU8MM4/t8Ag2gIyxcib8oey2arnql7nkHm+sufTXaFrK4OBVW
         Ujm0e1hZMXkmtbNLxV5+Ow2m2tLh8yX6XH4Ti9dJKn38vtSQVa4zeiMUOCVzvB0e6crb
         fjpNvSut82M8vvr/RS94FUFiqb0/QwccfxCdRGgBiam8EaSNHuYmV4Iprzvc6TmfbwpJ
         59Fq01rfzuwBpVueWQ2TWyoazo+vLZWrsV23JWUCeccHT2CljYypvwlrvaLre3a4AG3I
         htHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687572310; x=1690164310;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A95yabU0fWahrV4bS2jxEmyDFJAUbPcvq1i/SCHm4mA=;
        b=cqL1TvrIeoj7GjHH17aHmc3MKeATaGxeokCC+OiS27e2Yebzhhfjy1nkFB1JSWOJCl
         C/H7QRzwqzvXh9QTzk2uDC/ve3pV04vpoA1/PZoZg/KIshmFQu32i0yynxicqXXlH7s+
         KLVZJ8lVY8aAE1R17M0xR+9otNCEpzgRragCWcAt55f09EXOMKe7xdCKzwjyy8vuI/2v
         TLEgA49KD0Ntc8FSaL2H0d6RIF9TcTZouEsaGss2xpC4d04e38BK65GT1Muzm4MivoQn
         fBdeVZxpMxKP5ZYY+SUmnGeJ6ICTKMtG1WQtYUIS+bTVQJ11PI9RJllt75NblsVdbmXb
         5kQg==
X-Gm-Message-State: AC+VfDyVF1eo3A/gLxNE5z0C4pAL1Kn4Y9+iqZGv2Ax987zp+Drc2D9F
        z/kf3zagBjmlQ4HQoBAh61A5IQ==
X-Google-Smtp-Source: ACHHUZ5VwUscOJVaCZcOr5PgyyRI9SqU9w0qmjhv9ekhj7bzHSBiPMEZmXHTAboYwxWVSp6MCtkbLw==
X-Received: by 2002:a19:5f5c:0:b0:4f8:6b57:87f9 with SMTP id a28-20020a195f5c000000b004f86b5787f9mr10925746lfj.22.1687572309664;
        Fri, 23 Jun 2023 19:05:09 -0700 (PDT)
Received: from [192.168.1.101] (abyk30.neoplus.adsl.tpnet.pl. [83.9.30.30])
        by smtp.gmail.com with ESMTPSA id m17-20020a056512015100b004f873303457sm92327lfo.303.2023.06.23.19.05.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 19:05:09 -0700 (PDT)
Message-ID: <d8f4e665-984a-5a36-3ffe-14e33d09f031@linaro.org>
Date:   Sat, 24 Jun 2023 04:05:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, Lux Aliaga <they@mint.lgbt>
References: <20230624-sm6125-dpu-v1-0-1d5a638cebf2@somainline.org>
 <20230624-sm6125-dpu-v1-14-1d5a638cebf2@somainline.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH 14/15] arm64: dts: qcom: sm6125: Add display hardware
 nodes
In-Reply-To: <20230624-sm6125-dpu-v1-14-1d5a638cebf2@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.06.2023 02:41, Marijn Suijten wrote:
> Add the DT nodes that describe the MDSS hardware on SM6125, containing
> one MDP (display controller) together with a single DSI and DSI PHY.  No
> DisplayPort support is added for now.
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>  arch/arm64/boot/dts/qcom/sm6125.dtsi | 190 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 186 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> index 7d78b4e48ebe..6852dacf54e6 100644
> --- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> @@ -1204,16 +1204,198 @@ sram@4690000 {
>  			reg = <0x04690000 0x10000>;
>  		};
>  
> +		mdss: display-subsystem@5e00000 {
> +			compatible = "qcom,sm6125-mdss";
> +			reg = <0x05e00000 0x1000>;
> +			reg-names = "mdss";
> +
> +			power-domains = <&dispcc MDSS_GDSC>;
> +
> +			clocks = <&gcc GCC_DISP_AHB_CLK>,
> +				 <&dispcc DISP_CC_MDSS_AHB_CLK>,
> +				 <&dispcc DISP_CC_MDSS_MDP_CLK>;
> +			clock-names = "iface", "ahb", "core";
One per line would be nice
> +
> +			interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +
> +			iommus = <&apps_smmu 0x400 0x0>;
> +
Every node has a different scramble of property orders :P

To roughly align with what I ask most people to do (and what I should
work on codifying and automating ehhh) would be:

[compat]
[reg]

[interrupt]

[clock]

[reset]
(btw there should be a MDSS_CORE reset at DISP_CC+0x2000, try writing 1 there
and see if MDSS dies)

[opp]
[pd]

[iommus]
[icc]

[phy]

[addresssizeranges]

[status]

> +			status = "disabled";
> +
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +
> +			mdss_mdp: display-controller@5e01000 {
> +				compatible = "qcom,sm6125-dpu";
> +				reg = <0x05e01000 0x83208>,
> +				      <0x05eb0000 0x2008>;
> +				reg-names = "mdp", "vbif";
> +
> +				clocks = <&gcc GCC_DISP_HF_AXI_CLK>,
> +					 <&dispcc DISP_CC_MDSS_AHB_CLK>,
> +					 <&dispcc DISP_CC_MDSS_ROT_CLK>,
> +					 <&dispcc DISP_CC_MDSS_MDP_LUT_CLK>,
> +					 <&dispcc DISP_CC_MDSS_MDP_CLK>,
> +					 <&dispcc DISP_CC_MDSS_VSYNC_CLK>;
> +				clock-names = "bus",
> +					      "iface",
> +					      "rot",
> +					      "lut",
> +					      "core",
> +					      "vsync";
> +				assigned-clocks = <&dispcc DISP_CC_MDSS_VSYNC_CLK>;
> +				assigned-clock-rates = <19200000>;
> +
> +				operating-points-v2 = <&mdp_opp_table>;
> +				power-domains = <&rpmpd SM6125_VDDCX>;
> +
> +				interrupt-parent = <&mdss>;
> +				interrupts = <0>;
> +
> +				ports {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					port@0 {
> +						reg = <0>;
> +						dpu_intf1_out: endpoint {
> +							remote-endpoint = <&mdss_dsi0_in>;
> +						};
> +					};
> +				};
> +
> +				mdp_opp_table: opp-table {
> +					compatible = "operating-points-v2";
> +
> +					opp-192000000 {
> +						opp-hz = /bits/ 64 <192000000>;
> +						required-opps = <&rpmpd_opp_low_svs>;
> +					};
> +
> +					opp-256000000 {
> +						opp-hz = /bits/ 64 <256000000>;
> +						required-opps = <&rpmpd_opp_svs>;
> +					};
> +
> +					opp-307200000 {
> +						opp-hz = /bits/ 64 <307200000>;
> +						required-opps = <&rpmpd_opp_svs_plus>;
> +					};
> +
> +					opp-384000000 {
> +						opp-hz = /bits/ 64 <384000000>;
> +						required-opps = <&rpmpd_opp_nom>;
> +					};
> +
> +					opp-400000000 {
> +						opp-hz = /bits/ 64 <400000000>;
> +						required-opps = <&rpmpd_opp_turbo>;
> +					};
> +				};
> +			};
> +
> +			mdss_dsi0: dsi@5e94000 {
> +				compatible = "qcom,sm6125-dsi-ctrl", "qcom,mdss-dsi-ctrl";
> +				reg = <0x05e94000 0x400>;
> +				reg-names = "dsi_ctrl";
> +
> +				interrupt-parent = <&mdss>;
> +				interrupts = <4>;
> +
> +				clocks = <&dispcc DISP_CC_MDSS_BYTE0_CLK>,
> +					 <&dispcc DISP_CC_MDSS_BYTE0_INTF_CLK>,
> +					 <&dispcc DISP_CC_MDSS_PCLK0_CLK>,
> +					 <&dispcc DISP_CC_MDSS_ESC0_CLK>,
> +					 <&dispcc DISP_CC_MDSS_AHB_CLK>,
> +					 <&gcc GCC_DISP_HF_AXI_CLK>;
> +				clock-names = "byte",
> +					      "byte_intf",
> +					      "pixel",
> +					      "core",
> +					      "iface",
> +					      "bus";
> +
> +				assigned-clocks = <&dispcc DISP_CC_MDSS_BYTE0_CLK_SRC>,
> +						  <&dispcc DISP_CC_MDSS_PCLK0_CLK_SRC>;
> +				assigned-clock-parents = <&mdss_dsi0_phy 0>, <&mdss_dsi0_phy 1>;
> +
> +				operating-points-v2 = <&dsi_opp_table>;
> +				power-domains = <&rpmpd SM6125_VDDMX>;
CX

> +
> +				phys = <&mdss_dsi0_phy>;
> +				phy-names = "dsi";
> +
> +				status = "disabled";
> +
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				ports {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					port@0 {
> +						reg = <0>;
> +						mdss_dsi0_in: endpoint {
> +							remote-endpoint = <&dpu_intf1_out>;
> +						};
> +					};
> +
> +					port@1 {
> +						reg = <1>;
> +						mdss_dsi0_out: endpoint {
> +						};
> +					};
> +				};
> +
> +				dsi_opp_table: opp-table {
> +					compatible = "operating-points-v2";
> +
> +					opp-164000000 {
> +						opp-hz = /bits/ 64 <164000000>;
> +						required-opps = <&rpmpd_opp_low_svs>;
> +					};
> +
> +					opp-187500000 {
> +						opp-hz = /bits/ 64 <187500000>;
> +						required-opps = <&rpmpd_opp_svs>;
> +					};
> +				};
> +			};
> +
> +			mdss_dsi0_phy: phy@5e94400 {
> +				compatible = "qcom,dsi-phy-14nm-6125";
> +				reg = <0x05e94400 0x100>,
> +				      <0x05e94500 0x300>,
> +				      <0x05e94800 0x188>;
> +				reg-names = "dsi_phy",
> +					    "dsi_phy_lane",
> +					    "dsi_pll";
> +
> +				#clock-cells = <1>;
> +				#phy-cells = <0>;
> +
> +				clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
> +					 <&rpmcc RPM_SMD_XO_CLK_SRC>;
> +				clock-names = "iface", "ref";
> +
> +				status = "disabled";
> +			};
> +		};
> +
>  		dispcc: clock-controller@5f00000 {
>  			compatible = "qcom,sm6125-dispcc";
>  			reg = <0x05f00000 0x20000>;
>  			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
> +				 <&gcc GCC_DISP_GPLL0_DIV_CLK_SRC>,
> +				 <&mdss_dsi0_phy 0>,
> +				 <&mdss_dsi0_phy 1>,
>  				 <0>,
>  				 <0>,
> -				 <0>,
> -				 <0>,
> -				 <0>,
> -				 <&gcc GCC_DISP_GPLL0_DIV_CLK_SRC>;
> +				 <0>;
>  			clock-names = "bi_tcxo",
Wrong patch

Konrad
>  				      "gcc_disp_gpll0_div_clk_src",
>  				      "dsi0_phy_pll_out_byteclk",
> 
