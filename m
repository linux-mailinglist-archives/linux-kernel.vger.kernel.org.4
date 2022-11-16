Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2259462BA56
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 11:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiKPKz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 05:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238995AbiKPKyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 05:54:51 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3705D27CC9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:43:49 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id b9so21300007ljr.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/wwS1WpMtgPz84fk4z3RYo3L8Si5NAXcY3z6ElnGDnI=;
        b=pjASv5LiSIwCojxz6IS35/bdflsSswIu38mhsspRvTB39iUOgV3HXpCmDXurnMWIOb
         EznoqSntkVVsYVLloxin+COZ3HOtNiBafzBtUJqd6CewXzoXntZLKaHvMyrez6wV3oui
         4Nlcr0opJLnJFYJUZUuzm9CHidK7Nvh1Vu/h374bwLB841u7lyYaOPXJOI03bnlg+sE7
         mlXONzNNscf+ifo+12N52SBibiDQ0elzCYRoPLmautNg8JeWwY3jpresUvqk5j+yFwoo
         p8NPrveE3q2OXQmw1/AD19fTTSRr77gVYI78A780EkvpLaDfz76ps5BcsYWCQji5UVtg
         enuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/wwS1WpMtgPz84fk4z3RYo3L8Si5NAXcY3z6ElnGDnI=;
        b=uCqaTLVzVnhbcKUE7UZzOMQNsUxZ8Yy198Spn4sqA9TlVT7hvfLiDLNpSfYdbSYA3X
         Fh6a5MdU+1Lh7zQTs/HyBQOmgVDfEbqx4JuGX3xV/q6N0+D9a9mGVhcBedhmOPDhq3t/
         l6QKyjv3sGPr5lHGFWJ/65lsV2qbIDGkjk0uWKLmiMDhKdjU09TU8xx5yQSS5BNWVGaJ
         G/+t55obpUszHGIxghw1ZS/CRE572VhvjyVS4dNgT5MNjZmJuOSodegzOsgBtAjMP5xa
         Y+EvOQaFi2Ruf10Z+g5slo3fdeClDhxw6zw6TPGz9F4vrxtEYVbsh5sSgg5U3NXEgq4U
         gZsw==
X-Gm-Message-State: ANoB5pkN3oyGNlSzmR7q7Ta/0XpmnRcc235A8aqm/TFlKLPaB6wZnXlX
        fg25HqqgYuSsj+C1gYNVbuu/eA==
X-Google-Smtp-Source: AA0mqf6AzjdNFSGNVPplbICKbg+4I+SEXfaS8BvNdFzZ02aBAROm6JOK4jiHW1825OekID+yiAxNnw==
X-Received: by 2002:a2e:94cb:0:b0:277:3df:90d0 with SMTP id r11-20020a2e94cb000000b0027703df90d0mr7372526ljh.234.1668595427342;
        Wed, 16 Nov 2022 02:43:47 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id u2-20020ac258c2000000b004996fbfd75esm2528744lfo.71.2022.11.16.02.43.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 02:43:46 -0800 (PST)
Message-ID: <0505aac0-b861-d8ed-e310-b2723dd1871c@linaro.org>
Date:   Wed, 16 Nov 2022 11:43:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH 2/2] arm64: dts: qcom: clean up 'regulator-allowed-modes'
 indentation
To:     Johan Hovold <johan+linaro@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Parikshit Pareek <quic_ppareek@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221116102054.4673-1-johan+linaro@kernel.org>
 <20221116102054.4673-3-johan+linaro@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221116102054.4673-3-johan+linaro@kernel.org>
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



On 16/11/2022 11:20, Johan Hovold wrote:
> When recently adding the missing 'regulator-allowed-modes' properties it
> appears that the binding example with its four-spaces indentation
> (corresponding to a single tab, which is still to little) was copied
> verbatim.
> 
> Drop the unnecessary first line break after 'regulator-allowed-modes'
> properties and indent the single remaining continuation line properly.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>   arch/arm64/boot/dts/qcom/sa8155p-adp.dts      | 20 ++++++++-----------
>   arch/arm64/boot/dts/qcom/sa8295p-adp.dts      | 20 ++++++++-----------
>   arch/arm64/boot/dts/qcom/sc8280xp-crd.dts     | 10 ++++------
>   .../qcom/sm6350-sony-xperia-lena-pdx213.dts   | 10 ++++------
>   .../boot/dts/qcom/sm7225-fairphone-fp4.dts    | 10 ++++------
>   .../dts/qcom/sm8150-sony-xperia-kumano.dtsi   | 10 ++++------
>   .../boot/dts/qcom/sm8250-sony-xperia-edo.dtsi | 10 ++++------
>   arch/arm64/boot/dts/qcom/sm8350-hdk.dts       | 20 ++++++++-----------
>   8 files changed, 44 insertions(+), 66 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
> index 01ac460d910e..952acfc04adc 100644
> --- a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
> @@ -136,9 +136,8 @@ vreg_l5a_0p88: ldo5 {
>   			regulator-max-microvolt = <880000>;
>   			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>   			regulator-allow-set-load;
> -			regulator-allowed-modes =
> -			    <RPMH_REGULATOR_MODE_LPM
> -			     RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
>   		};
>   
>   		vreg_l7a_1p8: ldo7 {
> @@ -154,9 +153,8 @@ vreg_l10a_2p96: ldo10 {
>   			regulator-max-microvolt = <2960000>;
>   			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>   			regulator-allow-set-load;
> -			regulator-allowed-modes =
> -			    <RPMH_REGULATOR_MODE_LPM
> -			     RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
>   		};
>   
>   		vreg_l11a_0p8: ldo11 {
> @@ -263,9 +261,8 @@ vreg_l5c_1p2: ldo5 {
>   			regulator-max-microvolt = <1200000>;
>   			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>   			regulator-allow-set-load;
> -			regulator-allowed-modes =
> -			    <RPMH_REGULATOR_MODE_LPM
> -			     RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
>   		};
>   
>   		vreg_l7c_1p8: ldo7 {
> @@ -281,9 +278,8 @@ vreg_l8c_1p2: ldo8 {
>   			regulator-max-microvolt = <1200000>;
>   			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>   			regulator-allow-set-load;
> -			regulator-allowed-modes =
> -			    <RPMH_REGULATOR_MODE_LPM
> -			     RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
>   		};
>   
>   		vreg_l10c_3p3: ldo10 {
> diff --git a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> index 6c29d7d757e0..51805106f542 100644
> --- a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> @@ -90,9 +90,8 @@ vreg_l3c: ldo3 {
>   			regulator-max-microvolt = <1200000>;
>   			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>   			regulator-allow-set-load;
> -			regulator-allowed-modes =
> -			    <RPMH_REGULATOR_MODE_LPM
> -			     RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
>   		};
>   
>   		vreg_l4c: ldo4 {
> @@ -108,9 +107,8 @@ vreg_l6c: ldo6 {
>   			regulator-max-microvolt = <1200000>;
>   			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>   			regulator-allow-set-load;
> -			regulator-allowed-modes =
> -			    <RPMH_REGULATOR_MODE_LPM
> -			     RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
>   		};
>   
>   		vreg_l7c: ldo7 {
> @@ -126,9 +124,8 @@ vreg_l10c: ldo10 {
>   			regulator-max-microvolt = <2504000>;
>   			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>   			regulator-allow-set-load;
> -			regulator-allowed-modes =
> -			    <RPMH_REGULATOR_MODE_LPM
> -			     RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
>   		};
>   
>   		vreg_l17c: ldo17 {
> @@ -137,9 +134,8 @@ vreg_l17c: ldo17 {
>   			regulator-max-microvolt = <2504000>;
>   			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>   			regulator-allow-set-load;
> -			regulator-allowed-modes =
> -			    <RPMH_REGULATOR_MODE_LPM
> -			     RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
>   		};
>   	};
>   
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> index f09810e3d956..551768f97729 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> @@ -170,9 +170,8 @@ vreg_l7c: ldo7 {
>   			regulator-max-microvolt = <2504000>;
>   			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>   			regulator-allow-set-load;
> -			regulator-allowed-modes =
> -			    <RPMH_REGULATOR_MODE_LPM
> -			     RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
>   		};
>   
>   		vreg_l13c: ldo13 {
> @@ -195,9 +194,8 @@ vreg_l3d: ldo3 {
>   			regulator-max-microvolt = <1200000>;
>   			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>   			regulator-allow-set-load;
> -			regulator-allowed-modes =
> -			    <RPMH_REGULATOR_MODE_LPM
> -			     RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
>   		};
>   
>   		vreg_l4d: ldo4 {
> diff --git a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> index 20f35623d1ef..94f77d376662 100644
> --- a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> +++ b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> @@ -231,9 +231,8 @@ pm6150l_l6: ldo6 {
>   			regulator-max-microvolt = <2950000>;
>   			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>   			regulator-allow-set-load;
> -			regulator-allowed-modes =
> -			    <RPMH_REGULATOR_MODE_LPM
> -			     RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
>   
>   		};
>   
> @@ -254,9 +253,8 @@ pm6150l_l9: ldo9 {
>   			regulator-max-microvolt = <2960000>;
>   			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>   			regulator-allow-set-load;
> -			regulator-allowed-modes =
> -			    <RPMH_REGULATOR_MODE_LPM
> -			     RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
>   
>   		};
>   
> diff --git a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
> index 1cb14051ab1b..c456e9594ea5 100644
> --- a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
> +++ b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
> @@ -282,9 +282,8 @@ vreg_l6e: ldo6 {
>   			regulator-max-microvolt = <2950000>;
>   			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>   			regulator-allow-set-load;
> -			regulator-allowed-modes =
> -				<RPMH_REGULATOR_MODE_LPM
> -				 RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
>   		};
>   
>   		vreg_l7e: ldo7 {
> @@ -304,9 +303,8 @@ vreg_l9e: ldo9 {
>   			regulator-max-microvolt = <2960000>;
>   			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>   			regulator-allow-set-load;
> -			regulator-allowed-modes =
> -				<RPMH_REGULATOR_MODE_LPM
> -				 RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
>   		};
>   
>   		vreg_l10e: ldo10 {
> diff --git a/arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi b/arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi
> index fb6e5a140c9f..c958a8b16730 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi
> @@ -348,9 +348,8 @@ vreg_l6c_2p9: ldo6 {
>   			regulator-max-microvolt = <2960000>;
>   			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>   			regulator-allow-set-load;
> -			regulator-allowed-modes =
> -			    <RPMH_REGULATOR_MODE_LPM
> -			     RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
>   		};
>   
>   		vreg_l7c_3p0: ldo7 {
> @@ -370,9 +369,8 @@ vreg_l9c_2p9: ldo9 {
>   			regulator-max-microvolt = <2960000>;
>   			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>   			regulator-allow-set-load;
> -			regulator-allowed-modes =
> -			    <RPMH_REGULATOR_MODE_LPM
> -			     RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
>   		};
>   
>   		vreg_l10c_3p3: ldo10 {
> diff --git a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi
> index 2a223ed50102..38746f248969 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi
> @@ -317,9 +317,8 @@ vreg_l6c_2p9: ldo6 {
>   			regulator-max-microvolt = <2960000>;
>   			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>   			regulator-allow-set-load;
> -			regulator-allowed-modes =
> -			    <RPMH_REGULATOR_MODE_LPM
> -			     RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
>   		};
>   
>   		vreg_l7c_2p85: ldo7 {
> @@ -342,9 +341,8 @@ vreg_l9c_2p9: ldo9 {
>   			regulator-max-microvolt = <2960000>;
>   			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>   			regulator-allow-set-load;
> -			regulator-allowed-modes =
> -			    <RPMH_REGULATOR_MODE_LPM
> -			     RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
>   		};
>   
>   		vreg_l10c_3p3: ldo10 {
> diff --git a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
> index 69ae6503c2f6..26a608144886 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
> @@ -107,9 +107,8 @@ vreg_l5b_0p88: ldo5 {
>   			regulator-max-microvolt = <888000>;
>   			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>   			regulator-allow-set-load;
> -			regulator-allowed-modes =
> -			    <RPMH_REGULATOR_MODE_LPM
> -			     RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
>   		};
>   
>   		vreg_l6b_1p2: ldo6 {
> @@ -118,9 +117,8 @@ vreg_l6b_1p2: ldo6 {
>   			regulator-max-microvolt = <1208000>;
>   			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>   			regulator-allow-set-load;
> -			regulator-allowed-modes =
> -			    <RPMH_REGULATOR_MODE_LPM
> -			     RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
>   		};
>   
>   		vreg_l7b_2p96: ldo7 {
> @@ -129,9 +127,8 @@ vreg_l7b_2p96: ldo7 {
>   			regulator-max-microvolt = <2504000>;
>   			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>   			regulator-allow-set-load;
> -			regulator-allowed-modes =
> -			    <RPMH_REGULATOR_MODE_LPM
> -			     RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
>   		};
>   
>   		vreg_l9b_1p2: ldo9 {
> @@ -140,9 +137,8 @@ vreg_l9b_1p2: ldo9 {
>   			regulator-max-microvolt = <1200000>;
>   			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>   			regulator-allow-set-load;
> -			regulator-allowed-modes =
> -			    <RPMH_REGULATOR_MODE_LPM
> -			     RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
>   		};
>   	};
>   
