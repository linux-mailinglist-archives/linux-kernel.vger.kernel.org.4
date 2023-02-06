Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B6468C257
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 16:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjBFP4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 10:56:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjBFP4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 10:56:23 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2250246B4
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 07:56:22 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id mc11so35445682ejb.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 07:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R5aG9yUx3+RsKOGhqIxlDkttMY7Lz3117m3KBfSIG3U=;
        b=ln+WhwS8Uyigxc5Gnss11vx6nzgAuxUrnLrv8bJOxc+RJmOJ3/2kNZZa3NLyn4BMQ9
         /AsMB1tQSVLgU5v1jx1VxYwoeahNi4TRg2Nd6nd0zyz2WObIQTco+ghsOZrlY690Htr3
         5hdkq+PBfo1LgWqSWE4nlCNJJ8+b2geCyh2Z3fUWVYQuBkshVYnnmR9roPheD35qwLAH
         NEw53mfQmxIlqinkB0sXu7Yd329r+XQIt+dkNB1VjEc+wpeeoVJtMJcfir7hftmcaTCn
         dwaECsMyTq3Gw/cLcAoZa3C/Pp5V6IdXrUvmSrTpcot9U8bpIIEfl75pKnWyXHltyHhb
         awxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R5aG9yUx3+RsKOGhqIxlDkttMY7Lz3117m3KBfSIG3U=;
        b=lmpUB/lY5RndYEX9LaGugea4PCJ8btQ0kJiNV1Gf5GBHsyJfZc6H9aF82R/HIXK4td
         PAJQ8XDgFKdDuCPTgZhiVwwd+n3BhHOaa3ozhpWeRHj5PoAV0FgKM8JqRJxlCHe7c8AX
         XjfcY+Am48YSX806RqFHT0qr1oXkL/TLgpA6a6dI47HT3GpI0omdzUPLhYRIGTagNF6b
         R4xInsQO10sZ8ygbwLtKRcoNAG9S0i4eoeNAcbsGRSP5Mf6YUpvmvzebr1Vy/Yur4gQ1
         J0Mm0FsMVR92EFx2/0u0pjz3lxx4oxiuW3MOkIR9xNWibC4D4Wdx8I3bl4HfHXbwHpvb
         tuSw==
X-Gm-Message-State: AO0yUKW7eBWbdCEfY9PTrFENliITMvOBAKE2cbE/maAtRXe5ZB50ZOqv
        xBlaubaUalozaKyjQEaLoB6dBg==
X-Google-Smtp-Source: AK7set/iNMGOtXNUGESWgPCw/qmCvhXZ8ZEIwZILk5ehq2gbfQ+oHtkXOGRKznvedDf1xavrCXRh8g==
X-Received: by 2002:a17:907:9c07:b0:88d:ba89:183b with SMTP id ld7-20020a1709079c0700b0088dba89183bmr15326023ejc.12.1675698980736;
        Mon, 06 Feb 2023 07:56:20 -0800 (PST)
Received: from [192.168.1.101] (abyl20.neoplus.adsl.tpnet.pl. [83.9.31.20])
        by smtp.gmail.com with ESMTPSA id r6-20020a056402018600b0049f29a7c0d6sm5288267edv.34.2023.02.06.07.56.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 07:56:20 -0800 (PST)
Message-ID: <da834fe0-afe2-b701-fe0b-315338bc6c40@linaro.org>
Date:   Mon, 6 Feb 2023 16:56:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] arm64: dts: qcom: sm8550: add GPR and LPASS pin
 controller
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
References: <20230206150744.513967-1-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230206150744.513967-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6.02.2023 16:07, Krzysztof Kozlowski wrote:
> Add the ADSP GPR (Generic Packet Router) and LPASS LPI (Low Power Audio
> SubSystem Low Power Island) pin controller nodes used as part of audio
> subsystem on SM8550.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> LPI bindings:
> https://lore.kernel.org/linux-arm-msm/20230203174645.597053-1-krzysztof.kozlowski@linaro.org/T/#t
> 
> IOMMUS on qcom,q6apm-dais:
> https://lore.kernel.org/linux-arm-msm/20230206150532.513468-1-krzysztof.kozlowski@linaro.org/T/#u
> ---
>  arch/arm64/boot/dts/qcom/sm8550.dtsi | 55 ++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> index 6ff135191ee0..c26892bddcf0 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> @@ -13,7 +13,9 @@
>  #include <dt-bindings/interconnect/qcom,sm8550-rpmh.h>
>  #include <dt-bindings/mailbox/qcom-ipcc.h>
>  #include <dt-bindings/power/qcom-rpmpd.h>
> +#include <dt-bindings/soc/qcom,gpr.h>
>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
> +#include <dt-bindings/sound/qcom,q6dsp-lpass-ports.h>
>  #include <dt-bindings/phy/phy-qcom-qmp.h>
>  #include <dt-bindings/thermal/thermal.h>
>  
> @@ -1996,6 +1998,19 @@ IPCC_MPROC_SIGNAL_GLINK_QMP
>  			};
>  		};
>  
> +		lpass_tlmm: pinctrl@6e80000 {
> +			compatible = "qcom,sm8550-lpass-lpi-pinctrl";
> +			reg = <0 0x06e80000 0 0x20000>,
> +			      <0 0x0725a000 0 0x10000>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			gpio-ranges = <&lpass_tlmm 0 0 23>;
> +
> +			clocks = <&q6prmcc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +				 <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
> +			clock-names = "core", "audio";
> +		};
> +
>  		lpass_lpiaon_noc: interconnect@7400000 {
>  			compatible = "qcom,sm8550-lpass-lpiaon-noc";
>  			reg = <0 0x07400000 0 0x19080>;
> @@ -3513,6 +3528,46 @@ compute-cb@7 {
>  							 <&apps_smmu 0x1067 0x0>;
>  					};
>  				};
> +
> +				gpr {
> +					compatible = "qcom,gpr";
> +					qcom,glink-channels = "adsp_apps";
> +					qcom,domain = <GPR_DOMAIN_ID_ADSP>;
> +					qcom,intents = <512 20>;
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					q6apm: service@1 {
> +						compatible = "qcom,q6apm";
> +						reg = <GPR_APM_MODULE_IID>;
> +						#sound-dai-cells = <0>;
> +						qcom,protection-domain = "avs/audio",
> +									 "msm/adsp/audio_pd";
> +
> +						q6apmdai: dais {
> +							compatible = "qcom,q6apm-dais";
> +							iommus = <&apps_smmu 0x1001 0x0080>,
nit - 0x80

Otherwise:

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> +								 <&apps_smmu 0x1061 0x0>;
> +						};
> +
> +						q6apmbedai: bedais {
> +							compatible = "qcom,q6apm-lpass-dais";
> +							#sound-dai-cells = <1>;
> +						};
> +					};
> +
> +					q6prm: service@2 {
> +						compatible = "qcom,q6prm";
> +						reg = <GPR_PRM_MODULE_IID>;
> +						qcom,protection-domain = "avs/audio",
> +									 "msm/adsp/audio_pd";
> +
> +						q6prmcc: clock-controller {
> +							compatible = "qcom,q6prm-lpass-clocks";
> +							#clock-cells = <2>;
> +						};
> +					};
> +				};
>  			};
>  		};
>  
