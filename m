Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407C3663F1A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 12:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237639AbjAJLOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 06:14:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238373AbjAJLNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 06:13:50 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E876E50E67
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 03:12:44 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id m26-20020a05600c3b1a00b003d9811fcaafso9582169wms.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 03:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3hWpYN6LpdI1bCNJeRuTYWRUAN/AJkpmmZGPLEqRg/A=;
        b=ggzET2pFF0LAlCsnjkRPjrVBQh4GA9P7gvS4q2pAnysqwkV/BZL0XaHZSuXSjWIttf
         ouYFXLLs7FaR9MuoVscbACK5FIPwDzInS5JO1lVyaa6q00IMm5Ih1Sr73a20S93yeaFi
         QVCeR1RyJH/eyVF6MgACzYUXHP/S5RRxwj14lTK/A6+DNB3fK3fKaWFbBYU0sWGtsIKK
         U0vwZDx6nI+pkpUwAJS5lBYdvHUCp6GyRyrjtlxH8stGwvDvDvKPUId8RWYJqnNge8uI
         b3UO0qEjkXN2Bcs/bxPcG2oJ64A9Rrrk2vcwK1vWkZkFX1WSKMNUDsoYyYXNl4ggSvLx
         8UaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3hWpYN6LpdI1bCNJeRuTYWRUAN/AJkpmmZGPLEqRg/A=;
        b=c5fByyyRi1CwIOjz5MY2OlsdzEp0VTnhW8Xly82OvGy7v2AaLUZi3/dNs2SQEAavhU
         1rkA+vlHker9/F4jrpUupaiOb5VNrEDJsc4DF8MuKZd6nFCTjv6QMq4rKsntyzsTRT07
         S/ctmy8AoGU6+Xj7FjJfj/L37F6tmuwA30ccYJ9BQBrTIKBoB1pg4eZzOG1cglleyglk
         lP7m9lDA9n9/Dycy06nG1K4uqVSEtgWg4PqXluFuFl1SsZh5fJ8K5CStyILVspqrBcAs
         FtLk8dvrBbGDw6IP0s/5sqTLK7chvO9l+xHkh8ZnU29/NDdvQj6VrtYjAO73ZvdzCxgc
         y/GQ==
X-Gm-Message-State: AFqh2krWo59SLmA174lKZlYDdrEhCBx0G7NaOzrlR2EEKiEjuW5dWJl/
        7yEj+k/HhU61+QnzN+sbyPeFqQ==
X-Google-Smtp-Source: AMrXdXu6Vhwt0UN5RdB31tzzwSXtsoLlL+SluQw2JS6tb6gr/rteWJ0GTc9JEC4wg6KwQw/9Eb/jtw==
X-Received: by 2002:a05:600c:1d03:b0:3d3:4aa6:4fe6 with SMTP id l3-20020a05600c1d0300b003d34aa64fe6mr48092613wms.3.1673349163374;
        Tue, 10 Jan 2023 03:12:43 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id az28-20020a05600c601c00b003cf57329221sm18894302wmb.14.2023.01.10.03.12.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 03:12:42 -0800 (PST)
Message-ID: <19e61226-c0b9-657d-c36f-38067c6b01a7@linaro.org>
Date:   Tue, 10 Jan 2023 12:12:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 4/8] arm64: dts: qcom: sc7280: audioreach: Update
 VA/RX/TX macro clock nodes
Content-Language: en-US
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_rohkumar@quicinc.com, srinivas.kandagatla@linaro.org,
        dianders@chromium.org, swboyd@chromium.org, judyhsiao@chromium.org,
        konrad.dybcio@linaro.org, mka@chromium.org
References: <1672925875-2107-1-git-send-email-quic_srivasam@quicinc.com>
 <1672925875-2107-5-git-send-email-quic_srivasam@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1672925875-2107-5-git-send-email-quic_srivasam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/01/2023 14:37, Srinivasa Rao Mandadapu wrote:
> Update VA, RX and TX macro and lpass_tlmm clock properties and
> enable them.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Tested-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
> ---
>  .../qcom/sc7280-herobrine-audioreach-wcd9385.dtsi  | 62 ++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
> index e1fe56c..8c55753 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
> @@ -8,6 +8,10 @@
>  
>  #include <dt-bindings/sound/qcom,q6afe.h>
>  
> +/delete-node/ &lpass_rx_macro;
> +/delete-node/ &lpass_tx_macro;
> +/delete-node/ &lpass_va_macro;
> +
>  /{
>  	/* BOARD-SPECIFIC TOP LEVEL NODES */
>  	sound: sound {
> @@ -107,3 +111,61 @@
>  		};
>  	};
>  };
> +
> +&soc {
> +	lpass_rx_macro: codec@3200000 {

These should be properties of DTSI. The SoC either has them or not. It's
not conditional or dual-setup...

> +		compatible = "qcom,sc7280-lpass-rx-macro";
> +		reg = <0 0x03200000 0 0x1000>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&lpass_rx_swr_clk>, <&lpass_rx_swr_data>;
> +
> +		clocks = <&q6prmcc LPASS_CLK_ID_TX_CORE_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +			 <&q6prmcc LPASS_CLK_ID_TX_CORE_NPL_MCLK  LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +			 <&q6prmcc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +			 <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +			 <&lpass_va_macro>;
> +
> +		clock-names = "mclk", "npl", "macro", "dcodec", "fsgen";
> +
> +		#clock-cells = <0>;
> +		#sound-dai-cells = <1>;
> +	};

/home/krzk/dev/linux/linux/out/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dtb:
codec@3370000: clock-names: 'oneOf' conditional failed, one must be fixed:
	['mclk', 'macro', 'dcodec'] is too long
	'core' was expected
	From schema:
/home/krzk/dev/linux/linux/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
/home/krzk/dev/linux/linux/out/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dtb:
codec@3370000: Unevaluated properties are not allowed ('clock-names' was
unexpected)
	From schema:
/home/krzk/dev/linux/linux/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
/home/krzk/dev/linux/linux/out/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dtb:
audio@3987000: clocks: [[218, 4], [221, 12], [221, 11], [221, 6], [221,
8], [223, 8], [223, 5], [223, 6], [223, 7], [218, 10]] is too long
	From schema:
/home/krzk/dev/linux/linux/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml
/home/krzk/dev/linux/linux/out/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dtb:
audio@3987000: clock-names: 'oneOf' conditional failed, one must be fixed:
	['aon_cc_audio_hm_h', 'audio_cc_ext_mclk0',
'core_cc_sysnoc_mport_core', 'core_cc_ext_if0_ibit',
'core_cc_ext_if1_ibit', 'audio_cc_codec_mem', 'audio_cc_codec_mem0',
'audio_cc_codec_mem1', 'audio_cc_codec_mem2', 'aon_cc_va_mem0'] is too long
	'core_cc_sysnoc_mport_core' was expected
	'audio_cc_codec_mem' was expected
	'audio_cc_codec_mem0' was expected
	'audio_cc_codec_mem1' was expected
	'audio_cc_codec_mem2' was expected
	'aon_cc_va_mem0' was expected
	From schema:
/home/krzk/dev/linux/linux/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml

I posted recently several fixes, so some of the warnings might be
skipped. But I think you did not test this at all...

> +
> +	lpass_tx_macro: codec@3220000 {
> +		compatible = "qcom,sc7280-lpass-tx-macro";
> +		reg = <0 0x03220000 0 0x1000>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&lpass_tx_swr_clk>, <&lpass_tx_swr_data>;
> +
> +		clocks = <&q6prmcc LPASS_CLK_ID_TX_CORE_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +			 <&q6prmcc LPASS_CLK_ID_TX_CORE_NPL_MCLK  LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +			 <&q6prmcc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +			 <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +			 <&lpass_va_macro>;
> +
> +		clock-names = "mclk", "npl", "macro", "dcodec", "fsgen";
> +
> +		#clock-cells = <0>;
> +		#sound-dai-cells = <1>;
> +

Drop blank line

> +	};
> +
> +	lpass_va_macro: codec@3370000 {
> +		compatible = "qcom,sc7280-lpass-va-macro";
> +		reg = <0 0x03370000 0 0x1000>;
> +
> +		pinctrl-0 = <&lpass_dmic01_clk>, <&lpass_dmic01_data>;
> +		pinctrl-names = "default";
> +
> +		clocks = <&q6prmcc LPASS_CLK_ID_TX_CORE_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +			 <&q6prmcc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +			 <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
> +
> +		clock-names = "mclk", "macro", "dcodec";
> +
> +		#clock-cells = <0>;
> +		#sound-dai-cells = <1>;
> +	};
> +};

Best regards,
Krzysztof

