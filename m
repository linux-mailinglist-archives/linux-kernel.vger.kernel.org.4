Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90B362DBF4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 13:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbiKQMuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 07:50:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234693AbiKQMun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 07:50:43 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E1249082
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 04:50:41 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id j4so2688575lfk.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 04:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ARYXAZHhMEgLTfXetwcBF0cbKF9/e+04aoVLVW1wVow=;
        b=aQ+xchw9M5MoOZjnc4aO3E9uab32EZ1pO1Du8TnpA5qQVrGoajYRQ3chy19iNHDzqi
         Wb4SfyrJrrsPo3WT1Zez2IsgxXSL9CjoXtcbvhqqkYZlPFWHzs7CbNG34vlS5fezNvaJ
         jBOsi8I1EiEF5Mnkk/N5v4FTAbkYA2QAopHkS3H2+Z7VUWD216gBIX44ejei2R0ckI2r
         GTrKPpYAN2mzqKYc77D09JeWXIuwgU96fqRNy74lxWr2wi9+c2TgU78Q9wv/btXl5yJV
         aEIZXabV5yLTkY9G0iUXXKKjbG33ktEWpGDoafCnMADwJ4LZhqWbWIOa0AECofaWsp1o
         Zz4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ARYXAZHhMEgLTfXetwcBF0cbKF9/e+04aoVLVW1wVow=;
        b=rIHte7jiIQHWJer3SyvuzEaeJ/mL/631F2W7GaTrpJ76s4FTjrju8S7/hykWwGtmpr
         P0SvvzEcxA02PTuRbZAPtdoqBKC1nIB0daB3H7rtS9BN8FFcZviYKphuJohuZJJ/E6sJ
         cwzVHoAVk5yAvn69St9vxwwt/26eoEecuAZubljgD7HZCSUfTaVlbt9pE4Efb+hsL4/c
         R/2exd1SgllY2ShDJQ6uz84J3fXEXMpA3czitT8k3N2t38BzHFt8GC/p2c8/INZDM8ff
         FkQEw/Dc7mh0jv1YNdIMtvisufU9JrAz6zj6OeQPoBfRHQxHMC3c/8UkhIJVum0ghwsV
         i2Sg==
X-Gm-Message-State: ANoB5pmOwqYy3BC46wI8lNdl3DNEpYhEoXbZKP9sb/wePNcKL5WXQyrk
        5C5tPdyCcKHmeozJfaKjKZF0IQ==
X-Google-Smtp-Source: AA0mqf57AM7aP5L1oGxEmdRFaD0gNFRENxc9FiHh77UYOuVYXhOQ83EZ+3KVFd/JVtiXjP5sAfekGQ==
X-Received: by 2002:a05:6512:340d:b0:497:456d:890 with SMTP id i13-20020a056512340d00b00497456d0890mr737174lfr.687.1668689440319;
        Thu, 17 Nov 2022 04:50:40 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id o15-20020a05651205cf00b0049ad2619becsm135530lfo.131.2022.11.17.04.50.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 04:50:39 -0800 (PST)
Message-ID: <4fec7b4e-432f-8aa9-3218-2df96d880dc1@linaro.org>
Date:   Thu, 17 Nov 2022 13:50:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 02/10] arm64: dts: qcom: Add base SM8550 dtsi
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
References: <20221116103146.2556846-1-abel.vesa@linaro.org>
 <20221116103146.2556846-3-abel.vesa@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221116103146.2556846-3-abel.vesa@linaro.org>
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

On 16/11/2022 11:31, Abel Vesa wrote:
> Add base dtsi for SM8550 SoC and includes base description of
> CPUs, GCC, RPMHCC, UART, interrupt controller, TLMM, reserved
> memory, RPMh PD, TCSRCC, ITS, IPCC, AOSS QMP, LLCC, cpufreq,
> interconnect, thermal sensor, cpu cooling maps and SMMU nodes
> which helps boot to shell with console on boards with this SoC.
> 
> Co-developed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8550.dtsi | 3986 ++++++++++++++++++++++++++
>  1 file changed, 3986 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sm8550.dtsi
> 

Thank you for your patch. There is something to discuss/improve.

> +
> +		pmu@240b6400 {
> +			compatible = "qcom,sm8550-cpu-bwmon", "qcom,msm8998-bwmon";
> +			reg = <0x0 0x240b6400 0x0 0x600>;
> +			interrupts = <GIC_SPI 581 IRQ_TYPE_LEVEL_HIGH>;
> +			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &gem_noc SLAVE_LLCC 3>;
> +
> +			operating-points-v2 = <&cpu_bwmon_opp_table>;
> +
> +			cpu_bwmon_opp_table: opp-table {
> +				compatible = "operating-points-v2";
> +
> +				opp-0 {
> +					opp-peak-kBps = <4577000>;
> +				};
> +				opp-1 {
> +					opp-peak-kBps = <7110000>;
> +				};
> +				opp-2 {
> +					opp-peak-kBps = <9155000>;
> +				};
> +				opp-3 {
> +					opp-peak-kBps = <12298000>;
> +				};
> +				opp-4 {
> +					opp-peak-kBps = <14236000>;
> +				};
> +				opp-5 {
> +					opp-peak-kBps = <16265000>;
> +				};
> +			};
> +		};
> +
> +		pmu@24091000 {

Nodes should be ordered by the address. Mostly they are, but at least
BWMONs are not.

> +			compatible = "qcom,sm8550-llcc-bwmon", "qcom,sc7280-llcc-bwmon";
> +			reg = <0x0 0x24091000 0x0 0x1000>;
> +			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
> +			interconnects = <&mc_virt MASTER_LLCC 3 &mc_virt SLAVE_EBI1 3>;
> +
> +			operating-points-v2 = <&llcc_bwmon_opp_table>;
> +
> +			llcc_bwmon_opp_table: opp-table {
> +				compatible = "operating-points-v2";
> +
> +				opp-0 {
> +					opp-peak-kBps = <2086000>;
> +

Drop empty lines here and in places below.

> +				};
> +				opp-1 {
> +					opp-peak-kBps = <2929000>;
> +
> +				};
> +				opp-2 {
> +					opp-peak-kBps = <5931000>;
> +
> +				};
> +				opp-3 {
> +					opp-peak-kBps = <6515000>;
> +
> +				};
> +				opp-4 {
> +					opp-peak-kBps = <7980000>;
> +
> +				};
> +				opp-5 {
> +					opp-peak-kBps = <10437000>;
> +
> +				};
> +				opp-6 {
> +					opp-peak-kBps = <12157000>;
> +
> +				};
> +				opp-7 {
> +					opp-peak-kBps = <14060000>;
> +
> +				};
> +				opp-8 {
> +					opp-peak-kBps = <16113000>;
> +
> +				};
> +			};


Best regards,
Krzysztof

