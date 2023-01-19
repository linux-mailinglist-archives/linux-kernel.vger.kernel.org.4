Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA09B67452B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 22:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbjASVo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 16:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbjASVjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 16:39:55 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E52358289
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 13:29:57 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id tz11so9288584ejc.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 13:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EV6ZOdHLpVLEd2Hq0qGmJXaPwCG4236lUZ/7q8yUJSg=;
        b=pRpGvkoWdmNmQk0imawLFuST3ZxUIixoX2hGwVA1Zy7YgVsZmpJQIKvPg0i7+tQetv
         nKzHBd7/X9z9sRKv8cISuJJDCap2JcdYOxCK46bs0b0sgluT0oRlrftenqtOJL+IYvCN
         tcbt3L7B+xXhkvO/LhY7DXL4VPGc5afv0t88EoKSziep/9QUePEpKJ50kejAdEXH7Vzd
         mxgtyH3jYJG9qCrXnm4suRaLaoci9bZjSJbjOljP7nUipmf2GO0R0MLUazLuMH7rH9UC
         XCLR6TWkJjvl93sNR32FQebD0WP1OifQP6/hxKWnCV7fn5OXGmoZf5orjEOhrm7DKU8t
         dzpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EV6ZOdHLpVLEd2Hq0qGmJXaPwCG4236lUZ/7q8yUJSg=;
        b=Gj4FeGgwHEQtdNiHqc7bZKA3A1HzwzyCv4b4LSy0xbngie3Yxb9e2Lh2/4TnVbwDCV
         TLhpzXXnh3Rqh99aGg6gqrd3UATSVyH53oPz926KBSk3wyTdmVKdFHzXBVdnQ6MFZ1OP
         RqbiCKkHDzSnFd8pxpPsvajQpo6wVpI9/VhymORl9Gho5g4huKOW1YhPdUu1V5p5TA8p
         E9dWjAssrH/hQ2iW2qL02nX2qWN6Djvw+WUxOmfaQYkDQA0cSx/MaresJKbsiB8vdAZw
         WCb16pKxrWVf3/RFgfDfHGXcEV2+DcALDyzZ62ko6FKn/MeCTZIGH4UCRZBU77HEtxtx
         pn0w==
X-Gm-Message-State: AFqh2kocgBQ2M0jhcsUzMx9MXt4jkmDU+6TkpYnD7njoI0wKgm4eMC4b
        FDw5kC+TVgkP3Y8A85N3st4WlrCItgnbWDBs
X-Google-Smtp-Source: AMrXdXsSWrQGAW9Rru27369DMQvsYPJubNbjzLQ+Jq+7hpTVPxttgSbfhPVIe6056/tW0acPQcTRTQ==
X-Received: by 2002:a17:907:88cd:b0:859:5541:f3ff with SMTP id rq13-20020a17090788cd00b008595541f3ffmr14513943ejc.32.1674163795433;
        Thu, 19 Jan 2023 13:29:55 -0800 (PST)
Received: from [192.168.1.101] (abyk37.neoplus.adsl.tpnet.pl. [83.9.30.37])
        by smtp.gmail.com with ESMTPSA id q27-20020a1709066b1b00b0087329ff593fsm4349178ejr.144.2023.01.19.13.29.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 13:29:55 -0800 (PST)
Message-ID: <235cb7e9-a954-53f1-3f4a-86b5dbd5dc5c@linaro.org>
Date:   Thu, 19 Jan 2023 22:29:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: Use labels with generic node
 names for ADC channels
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Jonathan Cameron <jic23@kernel.org>, iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20230119212632.185881-1-marijn.suijten@somainline.org>
 <20230119212632.185881-3-marijn.suijten@somainline.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230119212632.185881-3-marijn.suijten@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19.01.2023 22:26, Marijn Suijten wrote:
> As discussed in [1] it is more convenient to use a generic adc-chan node
> name for ADC channels while storing a friendly - board-specific instead
> of PMIC-specific - name in the label, if/when desired to overwrite the
> channel description already contained (but previously unused) in the
> driver [2].  Follow up on the dt-bindings adc-chan node name
> requirement, and instead provide this (sometimes per-board) channel
> description through a label property.
> 
> Also remove all the unused label references (not to be confused with
> label properties) from pm660, pmp8074 and pms405.
> 
> [1]: https://lore.kernel.org/linux-arm-msm/20221106193018.270106-1-marijn.suijten@somainline.org/T/#u
> [2]: https://lore.kernel.org/linux-arm-msm/20230116220909.196926-4-marijn.suijten@somainline.org/
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/pm6125.dtsi          | 18 ++++++---
>  arch/arm64/boot/dts/qcom/pm660.dtsi           | 33 ++++++++++------
>  arch/arm64/boot/dts/qcom/pm8150.dtsi          |  6 +--
>  arch/arm64/boot/dts/qcom/pm8150b.dtsi         |  8 ++--
>  arch/arm64/boot/dts/qcom/pm8150l.dtsi         |  6 +--
>  arch/arm64/boot/dts/qcom/pm8950.dtsi          | 39 ++++++++++++-------
>  arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi     |  6 +--
>  arch/arm64/boot/dts/qcom/pmm8155au_2.dtsi     |  6 +--
>  arch/arm64/boot/dts/qcom/pmp8074.dtsi         | 27 ++++++++-----
>  arch/arm64/boot/dts/qcom/pms405.dtsi          | 21 ++++++----
>  arch/arm64/boot/dts/qcom/qrb5165-rb5.dts      | 15 ++++---
>  .../dts/qcom/sc7180-trogdor-coachz-r1.dts     |  4 +-
>  .../boot/dts/qcom/sc7180-trogdor-coachz.dtsi  |  3 +-
>  .../dts/qcom/sc7180-trogdor-homestar.dtsi     |  3 +-
>  .../boot/dts/qcom/sc7180-trogdor-lazor.dtsi   |  2 +-
>  .../dts/qcom/sc7180-trogdor-pompom-r1.dts     |  2 +-
>  .../dts/qcom/sc7180-trogdor-pompom-r2.dts     |  2 +-
>  .../boot/dts/qcom/sc7180-trogdor-pompom.dtsi  |  3 +-
>  .../dts/qcom/sc7180-trogdor-wormdingler.dtsi  |  3 +-
>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi  |  3 +-
>  arch/arm64/boot/dts/qcom/sc7280-idp.dts       |  2 +-
>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi      |  2 +-
>  arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi    |  4 +-
>  .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 39 ++++++++++++-------
>  .../qcom/sm6125-sony-xperia-seine-pdx201.dts  | 15 ++++---
>  arch/arm64/boot/dts/qcom/sm8250-mtp.dts       | 21 ++++++----
>  26 files changed, 187 insertions(+), 106 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/pm6125.dtsi b/arch/arm64/boot/dts/qcom/pm6125.dtsi
> index 59092a551a16..7cfd73f8707e 100644
> --- a/arch/arm64/boot/dts/qcom/pm6125.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm6125.dtsi
> @@ -85,36 +85,42 @@ pm6125_adc: adc@3100 {
>  			interrupts = <0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
>  			#io-channel-cells = <1>;
>  
> -			ref-gnd@0 {
> +			adc-chan@0 {
>  				reg = <ADC5_REF_GND>;
>  				qcom,pre-scaling = <1 1>;
> +				label = "ref_gnd";
>  			};
>  
> -			vref-1p25@1 {
> +			adc-chan@1 {
>  				reg = <ADC5_1P25VREF>;
>  				qcom,pre-scaling = <1 1>;
> +				label = "vref_1p25";
>  			};
>  
> -			die-temp@6 {
> +			adc-chan@6 {
>  				reg = <ADC5_DIE_TEMP>;
>  				qcom,pre-scaling = <1 1>;
> +				label = "die_temp";
>  			};
>  
> -			vph-pwr@83 {
> +			adc-chan@83 {
>  				reg = <ADC5_VPH_PWR>;
>  				qcom,pre-scaling = <1 3>;
> +				label = "vph_pwr";
>  			};
>  
> -			vcoin@85 {
> +			adc-chan@85 {
>  				reg = <ADC5_VCOIN>;
>  				qcom,pre-scaling = <1 3>;
> +				label = "vcoin";
>  			};
>  
> -			xo-therm@4c {
> +			adc-chan@4c {
>  				reg = <ADC5_XO_THERM_100K_PU>;
>  				qcom,pre-scaling = <1 1>;
>  				qcom,hw-settle-time = <200>;
>  				qcom,ratiometric;
> +				label = "xo_therm";
>  			};
>  		};
>  
> diff --git a/arch/arm64/boot/dts/qcom/pm660.dtsi b/arch/arm64/boot/dts/qcom/pm660.dtsi
> index fc0eccaccdf6..d05bd8f2170b 100644
> --- a/arch/arm64/boot/dts/qcom/pm660.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm660.dtsi
> @@ -91,82 +91,93 @@ pm660_adc: adc@3100 {
>  			#size-cells = <0>;
>  			#io-channel-cells = <1>;
>  
> -			ref_gnd: ref_gnd@0 {
> +			adc-chan@0 {
>  				reg = <ADC5_REF_GND>;
>  				qcom,decimation = <1024>;
>  				qcom,pre-scaling = <1 1>;
> +				label = "ref_gnd";
>  			};
>  
> -			vref_1p25: vref_1p25@1 {
> +			adc-chan@1 {
>  				reg = <ADC5_1P25VREF>;
>  				qcom,decimation = <1024>;
>  				qcom,pre-scaling = <1 1>;
> +				label = "vref_1p25";
>  			};
>  
> -			die_temp: die_temp@6 {
> +			adc-chan@6 {
>  				reg = <ADC5_DIE_TEMP>;
>  				qcom,decimation = <1024>;
>  				qcom,pre-scaling = <1 1>;
> +				label = "die_temp";
>  			};
>  
> -			xo_therm: xo_therm@4c {
> +			adc-chan@4c {
>  				reg = <ADC5_XO_THERM_100K_PU>;
>  				qcom,pre-scaling = <1 1>;
>  				qcom,decimation = <1024>;
>  				qcom,hw-settle-time = <200>;
>  				qcom,ratiometric;
> +				label = "xo_therm";
>  			};
>  
> -			msm_therm: msm_therm@4d {
> +			adc-chan@4d {
>  				reg = <ADC5_AMUX_THM1_100K_PU>;
>  				qcom,pre-scaling = <1 1>;
>  				qcom,decimation = <1024>;
>  				qcom,hw-settle-time = <200>;
>  				qcom,ratiometric;
> +				label = "msm_therm";
>  			};
>  
> -			emmc_therm: emmc_therm@4e {
> +			adc-chan@4e {
>  				reg = <ADC5_AMUX_THM2_100K_PU>;
>  				qcom,pre-scaling = <1 1>;
>  				qcom,decimation = <1024>;
>  				qcom,hw-settle-time = <200>;
>  				qcom,ratiometric;
> +				label = "emmc_therm";
>  			};
>  
> -			pa_therm0: thermistor0@4f {
> +			adc-chan@4f {
>  				reg = <ADC5_AMUX_THM3_100K_PU>;
>  				qcom,pre-scaling = <1 1>;
>  				qcom,decimation = <1024>;
>  				qcom,hw-settle-time = <200>;
>  				qcom,ratiometric;
> +				label = "pa_therm0";
>  			};
>  
> -			pa_therm1: thermistor1@50 {
> +			adc-chan@50 {
>  				reg = <ADC5_AMUX_THM4_100K_PU>;
>  				qcom,pre-scaling = <1 1>;
>  				qcom,decimation = <1024>;
>  				qcom,hw-settle-time = <200>;
>  				qcom,ratiometric;
> +				label = "pa_therm1";
>  			};
>  
> -			quiet_therm: quiet_therm@51 {
> +			adc-chan@51 {
>  				reg = <ADC5_AMUX_THM5_100K_PU>;
>  				qcom,pre-scaling = <1 1>;
>  				qcom,decimation = <1024>;
>  				qcom,hw-settle-time = <200>;
>  				qcom,ratiometric;
> +				label = "quiet_therm";
>  			};
>  
> -			vadc_vph_pwr: vph_pwr@83 {
> +			adc-chan@83 {
>  				reg = <ADC5_VPH_PWR>;
>  				qcom,decimation = <1024>;
>  				qcom,pre-scaling = <1 3>;
> +				label = "vph_pwr";
>  			};
>  
> -			vcoin: vcoin@85 {
> +			adc-chan@85 {
>  				reg = <ADC5_VCOIN>;
>  				qcom,decimation = <1024>;
>  				qcom,pre-scaling = <1 3>;
> +				label = "vcoin";
>  			};
>  		};
>  
> diff --git a/arch/arm64/boot/dts/qcom/pm8150.dtsi b/arch/arm64/boot/dts/qcom/pm8150.dtsi
> index db90c55fa2cf..ba145699eac5 100644
> --- a/arch/arm64/boot/dts/qcom/pm8150.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm8150.dtsi
> @@ -90,19 +90,19 @@ pm8150_adc: adc@3100 {
>  			#io-channel-cells = <1>;
>  			interrupts = <0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
>  
> -			ref-gnd@0 {
> +			adc-chan@0 {
>  				reg = <ADC5_REF_GND>;
>  				qcom,pre-scaling = <1 1>;
>  				label = "ref_gnd";
>  			};
>  
> -			vref-1p25@1 {
> +			adc-chan@1 {
>  				reg = <ADC5_1P25VREF>;
>  				qcom,pre-scaling = <1 1>;
>  				label = "vref_1p25";
>  			};
>  
> -			die-temp@6 {
> +			adc-chan@6 {
>  				reg = <ADC5_DIE_TEMP>;
>  				qcom,pre-scaling = <1 1>;
>  				label = "die_temp";
> diff --git a/arch/arm64/boot/dts/qcom/pm8150b.dtsi b/arch/arm64/boot/dts/qcom/pm8150b.dtsi
> index 66752cc063d6..f413651d07e4 100644
> --- a/arch/arm64/boot/dts/qcom/pm8150b.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm8150b.dtsi
> @@ -76,25 +76,25 @@ pm8150b_adc: adc@3100 {
>  			#io-channel-cells = <1>;
>  			interrupts = <0x2 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
>  
> -			ref-gnd@0 {
> +			adc-chan@0 {
>  				reg = <ADC5_REF_GND>;
>  				qcom,pre-scaling = <1 1>;
>  				label = "ref_gnd";
>  			};
>  
> -			vref-1p25@1 {
> +			adc-chan@1 {
>  				reg = <ADC5_1P25VREF>;
>  				qcom,pre-scaling = <1 1>;
>  				label = "vref_1p25";
>  			};
>  
> -			die-temp@6 {
> +			adc-chan@6 {
>  				reg = <ADC5_DIE_TEMP>;
>  				qcom,pre-scaling = <1 1>;
>  				label = "die_temp";
>  			};
>  
> -			chg-temp@9 {
> +			adc-chan@9 {
>  				reg = <ADC5_CHG_TEMP>;
>  				qcom,pre-scaling = <1 1>;
>  				label = "chg_temp";
> diff --git a/arch/arm64/boot/dts/qcom/pm8150l.dtsi b/arch/arm64/boot/dts/qcom/pm8150l.dtsi
> index 135bfb8d629b..7c46c6d454d0 100644
> --- a/arch/arm64/boot/dts/qcom/pm8150l.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm8150l.dtsi
> @@ -70,19 +70,19 @@ pm8150l_adc: adc@3100 {
>  			#io-channel-cells = <1>;
>  			interrupts = <0x4 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
>  
> -			ref-gnd@0 {
> +			adc-chan@0 {
>  				reg = <ADC5_REF_GND>;
>  				qcom,pre-scaling = <1 1>;
>  				label = "ref_gnd";
>  			};
>  
> -			vref-1p25@1 {
> +			adc-chan@1 {
>  				reg = <ADC5_1P25VREF>;
>  				qcom,pre-scaling = <1 1>;
>  				label = "vref_1p25";
>  			};
>  
> -			die-temp@6 {
> +			adc-chan@6 {
>  				reg = <ADC5_DIE_TEMP>;
>  				qcom,pre-scaling = <1 1>;
>  				label = "die_temp";
> diff --git a/arch/arm64/boot/dts/qcom/pm8950.dtsi b/arch/arm64/boot/dts/qcom/pm8950.dtsi
> index 5ec38b7e335a..054c783166fa 100644
> --- a/arch/arm64/boot/dts/qcom/pm8950.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm8950.dtsi
> @@ -50,77 +50,90 @@ pm8950_vadc: adc@3100 {
>  			#size-cells = <0>;
>  			#io-channel-cells = <1>;
>  
> -			vcoin@5 {
> +			adc-chan@5 {
>  				reg = <VADC_VCOIN>;
>  				qcom,pre-scaling = <1 1>;
> +				label = "vcoin";
>  			};
>  
> -			vph-pwr@7 {
> +			adc-chan@7 {
>  				reg = <VADC_VSYS>;
>  				qcom,pre-scaling = <1 1>;
> +				label = "vph_pwr";
>  			};
>  
> -			die-temp@8 {
> +			adc-chan@8 {
>  				reg = <VADC_DIE_TEMP>;
>  				qcom,pre-scaling = <1 1>;
> +				label = "die_temp";
>  			};
>  
> -			ref-625mv@9 {
> +			adc-chan@9 {
>  				reg = <VADC_REF_625MV>;
>  				qcom,pre-scaling = <1 1>;
> +				label = "ref_625mv";
>  			};
>  
> -			ref-1250mv@a {
> +			adc-chan@a {
>  				reg = <VADC_REF_1250MV>;
>  				qcom,pre-scaling = <1 1>;
> +				label = "ref_1250mv";
>  			};
>  
> -			ref-buf-625mv@c {
> +			adc-chan@c {
>  				reg = <VADC_SPARE1>;
>  				qcom,pre-scaling = <1 1>;
> +				label = "ref_buf_625mv";
>  			};
>  
> -			ref-gnd@e {
> +			adc-chan@e {
>  				reg = <VADC_GND_REF>;
> +				label = "ref_gnd";
>  			};
>  
> -			ref-vdd@f {
> +			adc-chan@f {
>  				reg = <VADC_VDD_VADC>;
> +				label = "ref_vdd";
>  			};
>  
> -			pa-therm1@11 {
> +			adc-chan@11 {
>  				reg = <VADC_P_MUX2_1_1>;
>  				qcom,pre-scaling = <1 1>;
>  				qcom,ratiometric;
>  				qcom,hw-settle-time = <200>;
> +				label = "pa_therm1";
>  			};
>  
> -			case-therm@13 {
> +			adc-chan@13 {
>  				reg = <VADC_P_MUX4_1_1>;
>  				qcom,pre-scaling = <1 1>;
>  				qcom,ratiometric;
>  				qcom,hw-settle-time = <200>;
> +				label = "case_therm";
>  			};
>  
> -			xo-therm@32 {
> +			adc-chan@32 {
>  				reg = <VADC_LR_MUX3_XO_THERM>;
>  				qcom,pre-scaling = <1 1>;
>  				qcom,ratiometric;
>  				qcom,hw-settle-time = <200>;
> +				label = "xo_therm";
>  			};
>  
> -			pa-therm0@36 {
> +			adc-chan@36 {
>  				reg = <VADC_LR_MUX7_HW_ID>;
>  				qcom,pre-scaling = <1 1>;
>  				qcom,ratiometric;
>  				qcom,hw-settle-time = <200>;
> +				label = "pa_therm0";
>  			};
>  
> -			xo-therm-buf@3c {
> +			adc-chan@3c {
>  				reg = <VADC_LR_MUX3_BUF_XO_THERM>;
>  				qcom,pre-scaling = <1 1>;
>  				qcom,ratiometric;
>  				qcom,hw-settle-time = <200>;
> +				label = "xo_therm_buf";
>  			};
>  		};
>  
> diff --git a/arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi b/arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi
> index ee1e428d3a6e..c32ccb1105db 100644
> --- a/arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi
> @@ -77,19 +77,19 @@ pmm8155au_1_adc: adc@3100 {
>  			#io-channel-cells = <1>;
>  			interrupts = <0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
>  
> -			ref-gnd@0 {
> +			adc-chan@0 {
>  				reg = <ADC5_REF_GND>;
>  				qcom,pre-scaling = <1 1>;
>  				label = "ref_gnd";
>  			};
>  
> -			vref-1p25@1 {
> +			adc-chan@1 {
>  				reg = <ADC5_1P25VREF>;
>  				qcom,pre-scaling = <1 1>;
>  				label = "vref_1p25";
>  			};
>  
> -			die-temp@6 {
> +			adc-chan@6 {
>  				reg = <ADC5_DIE_TEMP>;
>  				qcom,pre-scaling = <1 1>;
>  				label = "die_temp";
> diff --git a/arch/arm64/boot/dts/qcom/pmm8155au_2.dtsi b/arch/arm64/boot/dts/qcom/pmm8155au_2.dtsi
> index 1da4606e8ee6..98bbfec06d0b 100644
> --- a/arch/arm64/boot/dts/qcom/pmm8155au_2.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pmm8155au_2.dtsi
> @@ -69,19 +69,19 @@ pmm8155au_2_adc: adc@3100 {
>  			#io-channel-cells = <1>;
>  			interrupts = <0x4 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
>  
> -			ref-gnd@0 {
> +			adc-chan@0 {
>  				reg = <ADC5_REF_GND>;
>  				qcom,pre-scaling = <1 1>;
>  				label = "ref_gnd";
>  			};
>  
> -			vref-1p25@1 {
> +			adc-chan@1 {
>  				reg = <ADC5_1P25VREF>;
>  				qcom,pre-scaling = <1 1>;
>  				label = "vref_1p25";
>  			};
>  
> -			die-temp@6 {
> +			adc-chan@6 {
>  				reg = <ADC5_DIE_TEMP>;
>  				qcom,pre-scaling = <1 1>;
>  				label = "die_temp";
> diff --git a/arch/arm64/boot/dts/qcom/pmp8074.dtsi b/arch/arm64/boot/dts/qcom/pmp8074.dtsi
> index 580684411d74..9c98c284182c 100644
> --- a/arch/arm64/boot/dts/qcom/pmp8074.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pmp8074.dtsi
> @@ -18,57 +18,66 @@ pmp8074_adc: adc@3100 {
>  			#size-cells = <0>;
>  			#io-channel-cells = <1>;
>  
> -			ref-gnd@0 {
> +			adc-chan@0 {
>  				reg = <ADC5_REF_GND>;
>  				qcom,pre-scaling = <1 1>;
> +				label = "ref_gnd";
>  			};
>  
> -			vref-1p25@1 {
> +			adc-chan@1 {
>  				reg = <ADC5_1P25VREF>;
>  				qcom,pre-scaling = <1 1>;
> +				label = "vref_1p25";
>  			};
>  
> -			vref-vadc@2 {
> +			adc-chan@2 {
>  				reg = <ADC5_VREF_VADC>;
>  				qcom,pre-scaling = <1 1>;
> +				label = "vref_vadc";
>  			};
>  
> -			pmic_die: die-temp@6 {
> +			adc-chan@6 {
>  				reg = <ADC5_DIE_TEMP>;
>  				qcom,pre-scaling = <1 1>;
> +				label = "pmic_die";
>  			};
>  
> -			xo_therm: xo-temp@76 {
> +			adc-chan@76 {
>  				reg = <ADC5_XO_THERM_100K_PU>;
>  				qcom,ratiometric;
>  				qcom,hw-settle-time = <200>;
>  				qcom,pre-scaling = <1 1>;
> +				label = "xo_therm";
>  			};
>  
> -			pa_therm1: thermistor1@77 {
> +			adc-chan@77 {
>  				reg = <ADC5_AMUX_THM1_100K_PU>;
>  				qcom,ratiometric;
>  				qcom,hw-settle-time = <200>;
>  				qcom,pre-scaling = <1 1>;
> +				label = "pa_therm1";
>  			};
>  
> -			pa_therm2: thermistor2@78 {
> +			adc-chan@78 {
>  				reg = <ADC5_AMUX_THM2_100K_PU>;
>  				qcom,ratiometric;
>  				qcom,hw-settle-time = <200>;
>  				qcom,pre-scaling = <1 1>;
> +				label = "pa_therm2";
>  			};
>  
> -			pa_therm3: thermistor3@79 {
> +			adc-chan@79 {
>  				reg = <ADC5_AMUX_THM3_100K_PU>;
>  				qcom,ratiometric;
>  				qcom,hw-settle-time = <200>;
>  				qcom,pre-scaling = <1 1>;
> +				label = "pa_therm3";
>  			};
>  
> -			vph-pwr@131 {
> +			adc-chan@131 {
>  				reg = <ADC5_VPH_PWR>;
>  				qcom,pre-scaling = <1 3>;
> +				label = "vph_pwr";
>  			};
>  		};
>  
> diff --git a/arch/arm64/boot/dts/qcom/pms405.dtsi b/arch/arm64/boot/dts/qcom/pms405.dtsi
> index 22edb47c6a84..9f7ceafd1e50 100644
> --- a/arch/arm64/boot/dts/qcom/pms405.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pms405.dtsi
> @@ -81,45 +81,52 @@ pms405_adc: adc@3100 {
>  			#size-cells = <0>;
>  			#io-channel-cells = <1>;
>  
> -			ref_gnd@0 {
> +			adc-chan@0 {
>  				reg = <ADC5_REF_GND>;
>  				qcom,pre-scaling = <1 1>;
> +				label = "ref_gnd";
>  			};
>  
> -			vref_1p25@1 {
> +			adc-chan@1 {
>  				reg = <ADC5_1P25VREF>;
>  				qcom,pre-scaling = <1 1>;
> +				label = "vref_1p25";
>  			};
>  
> -			pon_1: vph_pwr@131 {
> +			adc-chan@131 {
>  				reg = <ADC5_VPH_PWR>;
>  				qcom,pre-scaling = <1 3>;
> +				label = "vph_pwr";
>  			};
>  
> -			die_temp@6 {
> +			adc-chan@6 {
>  				reg = <ADC5_DIE_TEMP>;
>  				qcom,pre-scaling = <1 1>;
> +				label = "die_temp";
>  			};
>  
> -			pa_therm1: thermistor1@77 {
> +			adc-chan@77 {
>  				reg = <ADC5_AMUX_THM1_100K_PU>;
>  				qcom,ratiometric;
>  				qcom,hw-settle-time = <200>;
>  				qcom,pre-scaling = <1 1>;
> +				label = "pa_therm1";
>  			};
>  
> -			pa_therm3: thermistor3@79 {
> +			adc-chan@79 {
>  				reg = <ADC5_AMUX_THM3_100K_PU>;
>  				qcom,ratiometric;
>  				qcom,hw-settle-time = <200>;
>  				qcom,pre-scaling = <1 1>;
> +				label = "pa_therm3";
>  			};
>  
> -			xo_therm: xo_temp@76 {
> +			adc-chan@76 {
>  				reg = <ADC5_XO_THERM_100K_PU>;
>  				qcom,ratiometric;
>  				qcom,hw-settle-time = <200>;
>  				qcom,pre-scaling = <1 1>;
> +				label = "xo_therm";
>  			};
>  		};
>  
> diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> index 8c64cb060e21..4ebf2e0fe838 100644
> --- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> +++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> @@ -644,16 +644,18 @@ &mdss_mdp {
>  };
>  
>  &pm8150_adc {
> -	xo-therm@4c {
> +	adc-chan@4c {
>  		reg = <ADC5_XO_THERM_100K_PU>;
>  		qcom,ratiometric;
>  		qcom,hw-settle-time = <200>;
> +		label = "xo_therm";
>  	};
>  
> -	wifi-therm@4e {
> +	adc-chan@4e {
>  		reg = <ADC5_AMUX_THM2_100K_PU>;
>  		qcom,ratiometric;
>  		qcom,hw-settle-time = <200>;
> +		label = "wifi_therm";
>  	};
>  };
>  
> @@ -721,10 +723,11 @@ &pm8150_gpios {
>  };
>  
>  &pm8150b_adc {
> -	conn-therm@4f {
> +	adc-chan@4f {
>  		reg = <ADC5_AMUX_THM3_100K_PU>;
>  		qcom,ratiometric;
>  		qcom,hw-settle-time = <200>;
> +		label = "conn_therm";
>  	};
>  };
>  
> @@ -756,16 +759,18 @@ &pm8150b_gpios {
>  };
>  
>  &pm8150l_adc {
> -	skin-msm-therm@4e {
> +	adc-chan@4e {
>  		reg = <ADC5_AMUX_THM2_100K_PU>;
>  		qcom,ratiometric;
>  		qcom,hw-settle-time = <200>;
> +		label = "skin_msm_therm";
>  	};
>  
> -	pm8150l-therm@4f {
> +	adc-chan@4f {
>  		reg = <ADC5_AMUX_THM3_100K_PU>;
>  		qcom,ratiometric;
>  		qcom,hw-settle-time = <200>;
> +		label = "pm8150l_therm";
>  	};
>  };
>  
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dts
> index edfcd47e1a00..2db57ecd71c5 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dts
> @@ -24,8 +24,8 @@ &charger_thermal {
>  };
>  
>  &pm6150_adc {
> -	/delete-node/ skin-temp-thermistor@4e;
> -	/delete-node/ charger-thermistor@4f;
> +	/delete-node/ adc-chan@4e;
> +	/delete-node/ adc-chan@4f;
>  };
>  
>  &pm6150_adc_tm {
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
> index 8b8ea8af165d..4dd51ba62f6f 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
> @@ -119,10 +119,11 @@ &panel {
>  };
>  
>  &pm6150_adc {
> -	skin-temp-thermistor@4e {
> +	adc-chan@4e {
>  		reg = <ADC5_AMUX_THM2_100K_PU>;
>  		qcom,ratiometric;
>  		qcom,hw-settle-time = <200>;
> +		label = "skin_therm";
>  	};
>  };
>  
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
> index b3ba23a88a0b..9df8114e1183 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
> @@ -145,10 +145,11 @@ &panel {
>  };
>  
>  &pm6150_adc {
> -	skin-temp-thermistor@4d {
> +	adc-chan@4d {
>  		reg = <ADC5_AMUX_THM1_100K_PU>;
>  		qcom,ratiometric;
>  		qcom,hw-settle-time = <200>;
> +		label = "skin_therm";
>  	};
>  };
>  
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
> index 269007d73162..508d7e4bdf62 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
> @@ -55,7 +55,7 @@ &panel {
>  };
>  
>  &pm6150_adc {
> -	/delete-node/ charger-thermistor@4f;
> +	/delete-node/ adc-chan@4f;
>  };
>  
>  &pm6150_adc_tm {
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dts
> index 8467ff41e6d5..b2a0164529d4 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dts
> @@ -27,7 +27,7 @@ &charger_thermal {
>  };
>  
>  &pm6150_adc {
> -	/delete-node/ charger-thermistor@4f;
> +	/delete-node/ adc-chan@4f;
>  };
>  
>  &pm6150_adc_tm {
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2.dts
> index 88cf2246c18a..e620001240db 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2.dts
> @@ -24,7 +24,7 @@ &charger_thermal {
>  };
>  
>  &pm6150_adc {
> -	/delete-node/ charger-thermistor@4f;
> +	/delete-node/ adc-chan@4f;
>  };
>  
>  &pm6150_adc_tm {
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi
> index 6c5287bd27d6..701ec7892b42 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi
> @@ -148,10 +148,11 @@ &pen_insert {
>  };
>  
>  &pm6150_adc {
> -	5v-choke-thermistor@4e {
> +	adc-chan@4e {
>  		reg = <ADC5_AMUX_THM2_100K_PU>;
>  		qcom,ratiometric;
>  		qcom,hw-settle-time = <200>;
> +		label = "5v_choke_therm";
>  	};
>  };
>  
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi
> index 9832e752da35..5eccb7860711 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi
> @@ -168,10 +168,11 @@ ap_ts: touchscreen@1 {
>  };
>  
>  &pm6150_adc {
> -	skin-temp-thermistor@4d {
> +	adc-chan@4d {
>  		reg = <ADC5_AMUX_THM1_100K_PU>;
>  		qcom,ratiometric;
>  		qcom,hw-settle-time = <200>;
> +		label = "skin_therm";
>  	};
>  };
>  
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> index 895c836a8cb5..0ef53b0eedad 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> @@ -824,10 +824,11 @@ &mdss_dp_out {
>  };
>  
>  &pm6150_adc {
> -	charger-thermistor@4f {
> +	adc-chan@4f {
>  		reg = <ADC5_AMUX_THM3_100K_PU>;
>  		qcom,ratiometric;
>  		qcom,hw-settle-time = <200>;
> +		label = "charger_therm";
>  	};
>  };
>  
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dts b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
> index ba64316b4427..4b901dde2adb 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
> @@ -73,7 +73,7 @@ &nvme_3v3_regulator {
>  };
>  
>  &pmk8350_vadc {
> -	pmr735a-die-temp@403 {
> +	adc-chan@403 {
>  		reg = <PMR735A_ADC7_DIE_TEMP>;
>  		label = "pmr735a_die_temp";
>  		qcom,pre-scaling = <1 1>;
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> index fa10dddadbb0..c9cffb071cfb 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> @@ -436,7 +436,7 @@ &pcie1_phy {
>  };
>  
>  &pmk8350_vadc {
> -	pmk8350-die-temp@3 {
> +	adc-chan@3 {
>  		reg = <PMK8350_ADC7_DIE_TEMP>;
>  		label = "pmk8350_die_temp";
>  		qcom,pre-scaling = <1 1>;
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
> index cd6ee84b36fd..b0142394a716 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
> @@ -382,13 +382,13 @@ &pm8350c_pwm {
>  };
>  
>  &pmk8350_vadc {
> -	pmk8350-die-temp@3 {
> +	adc-chan@3 {
>  		reg = <PMK8350_ADC7_DIE_TEMP>;
>  		label = "pmk8350_die_temp";
>  		qcom,pre-scaling = <1 1>;
>  	};
>  
> -	pmr735a-die-temp@403 {
> +	adc-chan@403 {
>  		reg = <PMR735A_ADC7_DIE_TEMP>;
>  		label = "pmr735a_die_temp";
>  		qcom,pre-scaling = <1 1>;
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> index 55ecbee19a58..c7d73b286acb 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> @@ -518,78 +518,91 @@ &pmk8280_pon_resin {
>  &pmk8280_vadc {
>  	status = "okay";
>  
> -	pmic-die-temp@3 {
> +	adc-chan@3 {
>  		reg = <PMK8350_ADC7_DIE_TEMP>;
>  		qcom,pre-scaling = <1 1>;
> +		label = "pmic_die_temp";
>  	};
>  
> -	xo-therm@44 {
> +	adc-chan@44 {
>  		reg = <PMK8350_ADC7_AMUX_THM1_100K_PU>;
>  		qcom,hw-settle-time = <200>;
>  		qcom,ratiometric;
> +		label = "xo_therm";
>  	};
>  
> -	pmic-die-temp@103 {
> +	adc-chan@103 {
>  		reg = <PM8350_ADC7_DIE_TEMP(1)>;
>  		qcom,pre-scaling = <1 1>;
> +		label = "pmic_die_temp";
>  	};
>  
> -	sys-therm@144 {
> +	adc-chan@144 {
>  		reg = <PM8350_ADC7_AMUX_THM1_100K_PU(1)>;
>  		qcom,hw-settle-time = <200>;
>  		qcom,ratiometric;
> +		label = "sys_therm";
>  	};
>  
> -	sys-therm@145 {
> +	adc-chan@145 {
>  		reg = <PM8350_ADC7_AMUX_THM2_100K_PU(1)>;
>  		qcom,hw-settle-time = <200>;
>  		qcom,ratiometric;
> +		label = "sys_therm";
>  	};
>  
> -	sys-therm@146 {
> +	adc-chan@146 {
>  		reg = <PM8350_ADC7_AMUX_THM3_100K_PU(1)>;
>  		qcom,hw-settle-time = <200>;
>  		qcom,ratiometric;
> +		label = "sys_therm";
>  	};
>  
> -	sys-therm@147 {
> +	adc-chan@147 {
>  		reg = <PM8350_ADC7_AMUX_THM4_100K_PU(1)>;
>  		qcom,hw-settle-time = <200>;
>  		qcom,ratiometric;
> +		label = "sys_therm";
>  	};
>  
> -	pmic-die-temp@303 {
> +	adc-chan@303 {
>  		reg = <PM8350_ADC7_DIE_TEMP(3)>;
>  		qcom,pre-scaling = <1 1>;
> +		label = "pmic_die_temp";
>  	};
>  
> -	sys-therm@344 {
> +	adc-chan@344 {
>  		reg = <PM8350_ADC7_AMUX_THM1_100K_PU(3)>;
>  		qcom,hw-settle-time = <200>;
>  		qcom,ratiometric;
> +		label = "sys_therm";
>  	};
>  
> -	sys-therm@345 {
> +	adc-chan@345 {
>  		reg = <PM8350_ADC7_AMUX_THM2_100K_PU(3)>;
>  		qcom,hw-settle-time = <200>;
>  		qcom,ratiometric;
> +		label = "sys_therm";
>  	};
>  
> -	sys-therm@346 {
> +	adc-chan@346 {
>  		reg = <PM8350_ADC7_AMUX_THM3_100K_PU(3)>;
>  		qcom,hw-settle-time = <200>;
>  		qcom,ratiometric;
> +		label = "sys_therm";
>  	};
>  
> -	sys-therm@347 {
> +	adc-chan@347 {
>  		reg = <PM8350_ADC7_AMUX_THM4_100K_PU(3)>;
>  		qcom,hw-settle-time = <200>;
>  		qcom,ratiometric;
> +		label = "sys_therm";
>  	};
>  
> -	pmic-die-temp@403 {
> +	adc-chan@403 {
>  		reg = <PMR735A_ADC7_DIE_TEMP>;
>  		qcom,pre-scaling = <1 1>;
> +		label = "pmic_die_temp";
>  	};
>  };
>  
> diff --git a/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts b/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
> index 04a3b54feb93..e22a9da62cb5 100644
> --- a/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
> +++ b/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
> @@ -242,39 +242,44 @@ &pm6125_adc {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&camera_flash_therm &emmc_ufs_therm &rf_pa1_therm>;
>  
> -	rf-pa0-therm@4d {
> +	adc-chan@4d {
>  		reg = <ADC5_AMUX_THM1_100K_PU>;
>  		qcom,ratiometric;
>  		qcom,hw-settle-time = <200>;
>  		qcom,pre-scaling = <1 1>;
> +		label = "rf_pa0_therm";
>  	};
>  
> -	quiet-therm@4e {
> +	adc-chan@4e {
>  		reg = <ADC5_AMUX_THM2_100K_PU>;
>  		qcom,ratiometric;
>  		qcom,hw-settle-time = <200>;
>  		qcom,pre-scaling = <1 1>;
> +		label = "quiet_therm";
>  	};
>  
> -	camera-flash-therm@52 {
> +	adc-chan@52 {
>  		reg = <ADC5_GPIO1_100K_PU>;
>  		qcom,ratiometric;
>  		qcom,hw-settle-time = <200>;
>  		qcom,pre-scaling = <1 1>;
> +		label = "camera_flash_therm";
>  	};
>  
> -	emmc-ufs-therm@54 {
> +	adc-chan@54 {
>  		reg = <ADC5_GPIO3_100K_PU>;
>  		qcom,ratiometric;
>  		qcom,hw-settle-time = <200>;
>  		qcom,pre-scaling = <1 1>;
> +		label = "emmc_ufs_therm";
>  	};
>  
> -	rf-pa1-therm@55 {
> +	adc-chan@55 {
>  		reg = <ADC5_GPIO4_100K_PU>;
>  		qcom,ratiometric;
>  		qcom,hw-settle-time = <200>;
>  		qcom,pre-scaling = <1 1>;
> +		label = "rf_pa1_therm";
>  	};
>  };
>  
> diff --git a/arch/arm64/boot/dts/qcom/sm8250-mtp.dts b/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
> index b741b7da1afc..933265806f52 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
> @@ -521,22 +521,25 @@ &i2c15 {
>  };
>  
>  &pm8150_adc {
> -	xo-therm@4c {
> +	adc-chan@4c {
>  		reg = <ADC5_XO_THERM_100K_PU>;
>  		qcom,ratiometric;
>  		qcom,hw-settle-time = <200>;
> +		label = "xo_therm";
>  	};
>  
> -	skin-therm@4d {
> +	adc-chan@4d {
>  		reg = <ADC5_AMUX_THM1_100K_PU>;
>  		qcom,ratiometric;
>  		qcom,hw-settle-time = <200>;
> +		label = "skin_therm";
>  	};
>  
> -	pa-therm1@4e {
> +	adc-chan@4e {
>  		reg = <ADC5_AMUX_THM2_100K_PU>;
>  		qcom,ratiometric;
>  		qcom,hw-settle-time = <200>;
> +		label = "pa_therm1";
>  	};
>  };
>  
> @@ -566,10 +569,11 @@ pa-therm1@2 {
>  };
>  
>  &pm8150b_adc {
> -	conn-therm@4f {
> +	adc-chan@4f {
>  		reg = <ADC5_AMUX_THM3_100K_PU>;
>  		qcom,ratiometric;
>  		qcom,hw-settle-time = <200>;
> +		label = "conn_therm";
>  	};
>  };
>  
> @@ -610,22 +614,25 @@ pa-therm2@2 {
>  };
>  
>  &pm8150l_adc {
> -	camera-flash-therm@4d {
> +	adc-chan@4d {
>  		reg = <ADC5_AMUX_THM1_100K_PU>;
>  		qcom,ratiometric;
>  		qcom,hw-settle-time = <200>;
> +		label = "camera_flash_therm";
>  	};
>  
> -	skin-msm-therm@4e {
> +	adc-chan@4e {
>  		reg = <ADC5_AMUX_THM2_100K_PU>;
>  		qcom,ratiometric;
>  		qcom,hw-settle-time = <200>;
> +		label = "skin_msm_therm";
>  	};
>  
> -	pa-therm2@4f {
> +	adc-chan@4f {
>  		reg = <ADC5_AMUX_THM3_100K_PU>;
>  		qcom,ratiometric;
>  		qcom,hw-settle-time = <200>;
> +		label = "pa_therm2";
>  	};
>  };
>  
