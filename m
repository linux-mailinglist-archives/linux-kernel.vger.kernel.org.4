Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4B7691DD1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 12:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbjBJLNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 06:13:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbjBJLNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 06:13:06 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218E672DCA
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 03:12:26 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id l37-20020a05600c1d2500b003dfe46a9801so3837023wms.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 03:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lLMV0ncNMrg+f3xjJTtqNXJ3S4bBrDbONW259RzPBmM=;
        b=Vjl8AteQYrT0PDERakIkSf0gc3kzBhuX2I8XN/z+mrcuAIbJ6zRLHwvfAZUCRrXvBH
         B6gLztzfSuqg7VtfH0UHOeDNcKrVF0isBpXVuBwatsHz8E7BXF/vXPPKpcY4uVJmrccn
         jkubfOlYq+vrVatrsO+QsObw+KKKP9YirrjATORvNihyAeQOqwdoTcvWFsfPas0ODU8+
         VMdyWazMlLVm9Ow23YjgYaOJxAAiQHyYNRm2vVjCQu8MPZ9nagnz6tuIvRGJGOwe1F51
         7fp/mLYvgtk362jA8d68S+nn7NsrKGi1H5MAyR7G7N/6QnoHqCR7gPQ96fvUuEWV2eed
         zrPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lLMV0ncNMrg+f3xjJTtqNXJ3S4bBrDbONW259RzPBmM=;
        b=xBBqZKOM5NcYwsiyYh5HIEjuoFBnBQP3W97Y11TsR7Xez63+G4mW6+NZh8oLAMcsuA
         aBtmxZl0Q3ElLrGTvgy8d55YvonfFU4we8dbn2fpXY1qsNWssFle0oSNLFEYFWMQEfjo
         /er1uU4ujaO+nI1MS7O6CAaSWn0onYYC1HyRvJXMHU2US5vJWCfBMjxvSuABYZD6N9GD
         z6DOc/LI+vt33HWGjwKawEhGd78E/HfSPU4OLjYtG/gzx81Q1maupL/7oW4NxR8/lUbm
         h5BZJMcEDOxXvfgZ9dIFgAsvxd64dL8PUy8JIXpnhwRRerg8GDL7/lzbW+7X+7bZJZWZ
         yqrw==
X-Gm-Message-State: AO0yUKXXFaWxCi8vJ6/xQ4Tk1tB1qLkSBvWBBxEQE9SfeG8TOjLN2dri
        GqeIo3am5OyBUAVfZFBYSwSZuA==
X-Google-Smtp-Source: AK7set+dZbv/MVOBEnEyByUWoFxBo0mZdtkh1BPQhH0fmQdg3RNpSeSLHcaf2uo8PzHzQC9CQsoEOA==
X-Received: by 2002:a05:600c:a292:b0:3df:ee44:e45a with SMTP id hu18-20020a05600ca29200b003dfee44e45amr12801996wmb.15.1676027539910;
        Fri, 10 Feb 2023 03:12:19 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id g9-20020a05600c308900b003dc3f195abesm4544610wmn.39.2023.02.10.03.12.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 03:12:19 -0800 (PST)
Message-ID: <de4b7af2-8918-6c3a-5fb5-cad6c8980d45@linaro.org>
Date:   Fri, 10 Feb 2023 12:12:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v5 3/8] arm64: dts: qcom: sc7280: Add LPASS PIL node
Content-Language: en-US
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        broonie@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_rohkumar@quicinc.com, srinivas.kandagatla@linaro.org,
        dianders@chromium.org, swboyd@chromium.org, judyhsiao@chromium.org,
        alsa-devel@alsa-project.org, quic_rjendra@quicinc.com,
        konrad.dybcio@somainline.org, mka@chromium.org,
        quic_mohs@quicinc.com
References: <1675700201-12890-1-git-send-email-quic_srivasam@quicinc.com>
 <1675700201-12890-4-git-send-email-quic_srivasam@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1675700201-12890-4-git-send-email-quic_srivasam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/02/2023 17:16, Srinivasa Rao Mandadapu wrote:
> Add LPASS PIL node for sc7280 based audioreach platforms.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Tested-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
> ---
>  .../qcom/sc7280-herobrine-audioreach-wcd9385.dtsi  |  4 +
>  arch/arm64/boot/dts/qcom/sc7280.dtsi               | 93 ++++++++++++++++++++++
>  2 files changed, 97 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
> index 1810a36..5e99f49 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
> @@ -107,3 +107,7 @@
>  		};
>  	};
>  };
> +
> +&remoteproc_adsp {

Are you sure this is ordered by name?

> +	status = "okay";
> +};

There is lpasscc@3000000 so aren't you now enabling two nodes for the
same address?

> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 6908bca..27ab992 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -8,6 +8,7 @@
>  #include <dt-bindings/clock/qcom,dispcc-sc7280.h>
>  #include <dt-bindings/clock/qcom,gcc-sc7280.h>
>  #include <dt-bindings/clock/qcom,gpucc-sc7280.h>
> +#include <dt-bindings/clock/qcom,lpass-sc7280.h>
>  #include <dt-bindings/clock/qcom,lpassaudiocc-sc7280.h>
>  #include <dt-bindings/clock/qcom,lpasscorecc-sc7280.h>
>  #include <dt-bindings/clock/qcom,rpmh.h>
> @@ -21,6 +22,7 @@
>  #include <dt-bindings/power/qcom-rpmpd.h>
>  #include <dt-bindings/reset/qcom,sdm845-aoss.h>
>  #include <dt-bindings/reset/qcom,sdm845-pdc.h>
> +#include <dt-bindings/soc/qcom,gpr.h>
>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>  #include <dt-bindings/sound/qcom,lpass.h>
>  #include <dt-bindings/thermal/thermal.h>
> @@ -3439,6 +3441,97 @@
>  			status = "disabled";
>  		};
>  
> +		remoteproc_adsp: remoteproc@3000000 {
> +			compatible = "qcom,sc7280-adsp-pil";
> +			reg = <0 0x03000000 0 0x5000>, <0 0x0355b000 0 0x10>;
> +			reg-names = "qdsp6ss_base", "lpass_efuse";

Does not look like you tested the DTS against bindings. Please run `make
dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
for instructions).

You can test against specific schema with DT_SCHEMA_FILES

> +
> +			interrupts-extended = <&pdc 6 IRQ_TYPE_LEVEL_HIGH>,
> +					      <&adsp_smp2p_in 0 IRQ_TYPE_NONE>,
> +					      <&adsp_smp2p_in 1 IRQ_TYPE_NONE>,
> +					      <&adsp_smp2p_in 2 IRQ_TYPE_NONE>,
> +					      <&adsp_smp2p_in 3 IRQ_TYPE_NONE>,
> +					      <&adsp_smp2p_in 7 IRQ_TYPE_NONE>;
> +
> +			interrupt-names = "wdog", "fatal", "ready",
> +					  "handover", "stop-ack",
> +					  "shutdown-ack";
> +
> +			qcom,qmp = <&aoss_qmp>;
> +
> +			clocks = <&rpmhcc RPMH_CXO_CLK>,
> +				 <&gcc GCC_CFG_NOC_LPASS_CLK>;
> +
> +			clock-names = "xo", "gcc_cfg_noc_lpass";
> +
> +			iommus = <&apps_smmu 0x1800 0x0>;
> +
> +			power-domains =	<&rpmhpd SC7280_CX>;
> +			power-domain-names = "cx";

Here as well. Binding says it is LCX domain.

> +
> +			required-opps = <&rpmhpd_opp_nom>;

This should also fail... please send code for review only if there are
no warnings.

> +
> +			resets = <&pdc_reset PDC_AUDIO_SYNC_RESET>,
> +				 <&aoss_reset AOSS_CC_LPASS_RESTART>;
> +
> +			reset-names =  "pdc_sync", "cc_lpass";
> +			qcom,halt-regs = <&tcsr_1 0x3000 0x5000 0x8000 0x13000>;
> +
> +			memory-region = <&adsp_mem>;
> +
> +			qcom,smem-states = <&adsp_smp2p_out 0>;
> +			qcom,smem-state-names = "stop";
> +
> +			status = "disabled";
> +
> +			glink-edge {
> +				interrupts-extended = <&ipcc IPCC_CLIENT_LPASS
> +						       IPCC_MPROC_SIGNAL_GLINK_QMP
> +						       IRQ_TYPE_EDGE_RISING>;
> +
> +				mboxes = <&ipcc IPCC_CLIENT_LPASS
> +					 IPCC_MPROC_SIGNAL_GLINK_QMP>;
> +
> +				label = "lpass";
> +				qcom,remote-pid = <2>;
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

That's also wrong and test would point the issue.


Best regards,
Krzysztof

