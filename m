Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0777A72EB40
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 20:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240247AbjFMSuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 14:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240180AbjFMSuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 14:50:13 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9512610FC
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 11:50:10 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f6255ad8aeso7387364e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 11:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686682209; x=1689274209;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D1DSI8p4lpThPu5grZs5fnlKovJAT4xKPd4HlMXNlC8=;
        b=JLr1durpMy5essMRLXPMBzCfv5ZwgvUUSVaw4nduWjqavYFMWh3n3M1Z/DBYgADIjr
         U01ZuLJmzXzNbnerTsjnXC8kookB2iNzbuAkqL3I31OZvFs8hRPEB3Dl7S6gUPNR6YfV
         B5iAFxJo92CIE/RxxSLfckiQ+8521cvO+hfr0MvyVGbqzMG7/ZHwIv9YaliuocPy96o9
         ra1txbzIU+2/Q32Irv3cf6u3u8kr1TIaKaiL4mRiwWrGKm5PkFO+HkA+EX/gSX6I0GLE
         E2Hn+ShhBDW1CExogrID3a8/k5Yrh28aIcshWtNuIUlF/4T5Cz0kvGHE7HELqy/fXlLw
         7E2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686682209; x=1689274209;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D1DSI8p4lpThPu5grZs5fnlKovJAT4xKPd4HlMXNlC8=;
        b=l2+iXfYRAjs7uS1lLyYny91pZOPx7aT2Vas49MOmgE2S4Gf4L97B279Ho7zxZsVkJt
         DXnqcQN8LPc6ZqnPDXDmp2xOUbsd6pZfv0v9Mrr45yF1853t7gXu2WsBEG19YAJ04YCQ
         ZV89tWQj74OOne0ZBrMsFSeWgD/hcuhF6ZKcS83JD/WpY19DF+hynn50ooM6RzA1AHQN
         SJSBidrYTrVnKZdh9U8pfJARnCoLN9bfm1GsDyyIc4gxDsYiPYF5ea/r7m/qZAj1edXe
         XpEOcchf9vjbY8gAYpggq1WQYJOXniE1E6SxebH2IKxkLJRES5VN4VgUqhli51uDAQKQ
         g9kg==
X-Gm-Message-State: AC+VfDwiud9QW5zFiavQsd/EW723r5OPKlU00BEzYR3TzjlbbXrSjBXF
        FJP6b0TkkpTArNj77JqsBETsYUWNc5u539BpEdI=
X-Google-Smtp-Source: ACHHUZ5KzIQgOOlj/oQxMuiQycugfMOr4TsX9oEBHQFPr9rK9JgWoXZ9GcbwnSJp2h4ekSBiC3BgfA==
X-Received: by 2002:ac2:46ec:0:b0:4f3:a820:dd98 with SMTP id q12-20020ac246ec000000b004f3a820dd98mr6848305lfo.7.1686682208810;
        Tue, 13 Jun 2023 11:50:08 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id w24-20020a19c518000000b004f62840a0f4sm1878325lfe.108.2023.06.13.11.50.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 11:50:08 -0700 (PDT)
Message-ID: <45261fd3-37c7-ddbe-dd6c-abdc4ee969cd@linaro.org>
Date:   Tue, 13 Jun 2023 20:50:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sm8550-qrd: add sound card
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230612173758.286411-1-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230612173758.286411-1-krzysztof.kozlowski@linaro.org>
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



On 12.06.2023 19:37, Krzysztof Kozlowski wrote:
> Add the sound card node with tested playback over WSA8845 speakers and
> WCD9385 headset over USB Type-C.  The recording links were not tested,
> but should be similar to previous platforms.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Bindings for the sound card were not sent to LKML. Work-in-progress is
> available here:
> https://github.com/krzk/linux/tree/n/audio-wsa884x-on-top-of-wip-sm8450-audio-on-next
> 
> Depends on my previous patch adding WSA8845 speakers:
> https://lore.kernel.org/linux-arm-msm/20230608094323.267278-1-krzysztof.kozlowski@linaro.org/T/#t
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sm8550-qrd.dts | 81 +++++++++++++++++++++++++
>  1 file changed, 81 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
> index 7ef7079dd640..cb0369fbbc81 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
> @@ -97,6 +97,87 @@ pmic_glink_sbu: endpoint {
>  		};
>  	};
>  
> +	sound {
> +		compatible = "qcom,sm8550-sndcard", "qcom,sm8450-sndcard";
> +		model = "SM8550-QRD";
> +		audio-routing = "SpkrLeft IN", "WSA_SPK1 OUT",
> +				"SpkrRight IN", "WSA_SPK2 OUT",
> +				"IN1_HPHL", "HPHL_OUT",
> +				"IN2_HPHR", "HPHR_OUT",
> +				"AMIC2", "MIC BIAS2",
> +				"VA DMIC0", "MIC BIAS1",
> +				"VA DMIC1", "MIC BIAS1",
> +				"VA DMIC2", "MIC BIAS3",
> +				"TX DMIC0", "MIC BIAS1",
> +				"TX DMIC1", "MIC BIAS2",
> +				"TX DMIC2", "MIC BIAS3",
> +				"TX SWR_ADC1", "ADC2_OUTPUT";
> +
> +		wcd-playback-dai-link {
> +			link-name = "WCD Playback";
> +
> +			cpu {
> +				sound-dai = <&q6apmbedai RX_CODEC_DMA_RX_0>;
> +			};
> +
> +			codec {
> +				sound-dai = <&wcd938x 0>, <&swr1 0>, <&lpass_rxmacro 0>;
> +			};
> +
> +			platform {
> +				sound-dai = <&q6apm>;
> +			};
> +		};
> +
> +		wcd-capture-dai-link {
> +			link-name = "WCD Capture";
> +
> +			cpu {
> +				sound-dai = <&q6apmbedai TX_CODEC_DMA_TX_3>;
> +			};
> +
> +			codec {
> +				sound-dai = <&wcd938x 1>, <&swr2 0>, <&lpass_txmacro 0>;
> +			};
> +
> +			platform {
> +				sound-dai = <&q6apm>;
> +			};
> +		};
> +
> +		wsa-dai-link {
> +			link-name = "WSA Playback";
> +
> +			cpu {
> +				sound-dai = <&q6apmbedai WSA_CODEC_DMA_RX_0>;
> +			};
> +
> +			codec {
> +				sound-dai = <&north_spkr>, <&south_spkr>, <&swr0 0>, <&lpass_wsamacro 0>;
> +			};
> +
> +			platform {
> +				sound-dai = <&q6apm>;
> +			};
> +		};
> +
> +		va-dai-link {
> +			link-name = "VA Capture";
> +
> +			cpu {
> +				sound-dai = <&q6apmbedai TX_CODEC_DMA_TX_3>;
> +			};
> +
> +			codec {
> +				sound-dai = <&lpass_vamacro 0>;
> +			};
> +
> +			platform {
> +				sound-dai = <&q6apm>;
> +			};
> +		};
> +	};
> +
>  	vph_pwr: vph-pwr-regulator {
>  		compatible = "regulator-fixed";
>  		regulator-name = "vph_pwr";
