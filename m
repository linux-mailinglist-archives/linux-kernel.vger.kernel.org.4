Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5A472EB44
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 20:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240279AbjFMSv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 14:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232974AbjFMSvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 14:51:53 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86250E4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 11:51:50 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f62b512fe2so7644036e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 11:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686682309; x=1689274309;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TQohnu7vkGHi4oKeytupm8ufaTLDB+P77Mlr8J1pqCA=;
        b=PEdnT9Al9bhcGo2I2dMhrHVAGJZ7V1Wd10eBg+TTyX3SJ/FUT20SX/VQCun4f1dAkI
         DNvNLe1AJ7OPppP2ZHclHIRKJrDD5nFqh37fA1+LVYEaKaqGdBmofG3EU+bkbmMTYruU
         6m95E0ziULPBxe4vtVY5FNLkMuxTXbJok41mt2MCSTPnj/fl+Ep1O6XN10PFRYq8r3dO
         AxBN3QDhd5RD7ck//UKHQigQL04kZhMqE1XF9HW8QesjyN/zLbiYtiXrx8R0saSZYVbV
         Xh98weUVJX84BWCbkFRUxmL0j6DCmuO8i/JUkP7Ycrm6tnWpaq1kQe89TW5yG8lDWU7T
         WoNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686682309; x=1689274309;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TQohnu7vkGHi4oKeytupm8ufaTLDB+P77Mlr8J1pqCA=;
        b=dd8DCLMyIVqS3ARy3jF5OPzbC7Mnd9r2qGTx9J/ZWqYOxdb//78Zcb4d8vCRxtuTV1
         PEzreJVnAVsNZ85qbk1f3MOejPUTj7TtB0TbYZOG10OC79osoaRfMu1gQPdgsCLS8QYU
         y0+GfPRVdR7PdXSHGIdfjP/N8/Zm0tuQdyXpaGYP9EitE017ZAsZZ5ilwEGzEVHamEO9
         TLyNupS9qnvTbpXV9X5WIfuE8QjBwbEGO7CHN1QgNVeDI99SIdYg5xsCLxN5NGdwXM2z
         3g5PBqw49QYtd1jwfI9TWNJhD7reWbbN7mmO71I9AWwWSKmGmmUH6ALbJxq/iE5/Viio
         IzmA==
X-Gm-Message-State: AC+VfDwptPVUVwldCx5d3zDmPDoPBxc20LcrfwbhECXVuTE9dcHswy/P
        YWrO7iEB3GkdYKYZEerFm7yyew==
X-Google-Smtp-Source: ACHHUZ4uGzG9XAkAYGRekUPM/VLZuoACpiHDrBYNT2WwAXrkRuOCqNbTkMHp33fMO2UKistVb9AuQA==
X-Received: by 2002:a2e:9c83:0:b0:2a8:a859:b5c7 with SMTP id x3-20020a2e9c83000000b002a8a859b5c7mr4810431lji.0.1686682308787;
        Tue, 13 Jun 2023 11:51:48 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id r10-20020a2e94ca000000b002b0488ef239sm2247960ljh.93.2023.06.13.11.51.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 11:51:48 -0700 (PDT)
Message-ID: <de7be6ad-f575-e37c-47dd-4f4d59c0dc2d@linaro.org>
Date:   Tue, 13 Jun 2023 20:51:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sm8550-mtp: add sound card
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
 <20230612173758.286411-2-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230612173758.286411-2-krzysztof.kozlowski@linaro.org>
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
> Not tested on hardware. Should be the same as on QRD8550.
> ---
For that reason:

Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sm8550-mtp.dts | 81 +++++++++++++++++++++++++
>  1 file changed, 81 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
> index 54f8957499a3..34b548b3e43d 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
> @@ -95,6 +95,87 @@ pmic_glink_sbu: endpoint {
>  		};
>  	};
>  
> +	sound {
> +		compatible = "qcom,sm8550-sndcard", "qcom,sm8450-sndcard";
> +		model = "SM8550-MTP";
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
> +				sound-dai = <&left_spkr>, <&right_spkr>, <&swr0 0>, <&lpass_wsamacro 0>;
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
