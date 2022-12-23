Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F92B654E2A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 10:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235982AbiLWJM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 04:12:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiLWJMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 04:12:18 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562A120378
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 01:12:17 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id z26so6330449lfu.8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 01:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FVgUyIN2/RuzB95mvwGhcR5QxjY3xxISQ1E8nNu5L44=;
        b=RnsTa+Er2AYud2wDAmuTZre/Wxx92DLSMYECJ0Us7ar9iEga5geseLU9V+QJWJIjtu
         5Iuv9W3bEJguB6covJs1NYK7wk6ajfunDK4AVD/0ZEbD/FT0PS+IeU7JWcV9PnHh/a5I
         qEe4Sreolr3Y7EYtIW8+9mY4f/6F3De7yK5nnBTwMq0blvyUFyfM76mEuq+NTe0CJMRZ
         SDxqwLw8KSZvKGjRD2BQsyHTFt9l/8S0H77H0usvuC/rNF8sLeSEbsUu5WZpd4/JTjsu
         leF5gTszuWUeJtE6ENRU8TlRflMWFafjsIlu3BT5i/WLNs8qIMGZW9ewzsRTojkoGdOh
         KcNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FVgUyIN2/RuzB95mvwGhcR5QxjY3xxISQ1E8nNu5L44=;
        b=EI9JjWSMQreAlXj77wOb8Upa14J5Q2gXSDwzg4dXdsYslQAibH3Sv19jF8iHpKA3+N
         8QMO4kOknnv2rgiL0yd+nNoGwO/gv/qYVlCMt9GT+8pQT8jwYTbToOdMFY2YNTJ7b6oE
         0EW+IsZ0iw5k+qMTRUrOwLybM7SkwBK7gqkrOMLJaR5qopFRmwthFxW7XuCfB4xIjAPC
         B8GrolwWmv49PydGeCnlQUjj9HYQZkxG/JBu3nqsWxcGusR+pwUQwUYlHllr+zHubbIl
         bZmaTPeJ5TuBisnB7KzbsdXnzY4UQ8AKmIcM7KpLjdi2BVLDWYEIQ3vPwE1gPubBnz7M
         SZow==
X-Gm-Message-State: AFqh2kr+0g3j/LklvJkW/UxgssYZv+ZcFt7J1MhxAJTvJjb46P7WzihO
        kVpXUOhTGPoeHIAhzS7Rz3qu9A==
X-Google-Smtp-Source: AMrXdXuZatbwc6hcdwAOTPvKEDgMTnqsU9oIhKWsLO23BieHaeVA6a0DiG4/A/xrVnTPK59xhEHXxw==
X-Received: by 2002:a05:6512:3f26:b0:4a4:68b9:66bf with SMTP id y38-20020a0565123f2600b004a468b966bfmr3397508lfa.10.1671786735694;
        Fri, 23 Dec 2022 01:12:15 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id 11-20020ac25f0b000000b004b5789ecdd7sm431874lfq.274.2022.12.23.01.12.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Dec 2022 01:12:15 -0800 (PST)
Message-ID: <3b80a6ea-d574-fc54-113e-3d0dbccc0607@linaro.org>
Date:   Fri, 23 Dec 2022 10:12:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 3/7] arm64: dts: qcom: sc7280: audioreach: Add lpass pil
 node
Content-Language: en-US
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_rohkumar@quicinc.com, srinivas.kandagatla@linaro.org,
        dianders@chromium.org, swboyd@chromium.org, judyhsiao@chromium.org,
        konrad.dybcio@linaro.org
References: <1671702170-24781-1-git-send-email-quic_srivasam@quicinc.com>
 <1671702170-24781-4-git-send-email-quic_srivasam@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1671702170-24781-4-git-send-email-quic_srivasam@quicinc.com>
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

On 22/12/2022 10:42, Srinivasa Rao Mandadapu wrote:
> Add lpass pil node for sc7280 based audioreach platforms.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Tested-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
> ---
> This patch depends on:
>     -- https://lore.kernel.org/linux-remoteproc/6e0590af-0bd1-cbef-c573-fa62b5bc9e63@quicinc.com/
> 
>  .../qcom/sc7280-herobrine-audioreach-wcd9385.dtsi  | 99 ++++++++++++++++++++++
>  1 file changed, 99 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
> index 1eac94e1..0ce8755 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
> @@ -110,3 +110,102 @@
>  		};
>  	};
>  };
> +
> +&soc {
> +	qcom,lpass@3000000 {

Not correct name.

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

Additionally, why this is not part of SoC DTSI? Defining SoC nodes in
other DTSI files is not readable and not maintainable.

> +		compatible = "qcom,sc7280-adsp-pil";
> +		reg = <0 0x03000000 0 0x5000>,
> +			<0 0x0355b000 0 0x10>;

Misaligned.

> +
> +		reg-names = "qdsp6ss_base",
> +			"lpass_efuse";

Misaligned.

> +
> +		interrupts-extended = <&pdc 6 IRQ_TYPE_LEVEL_HIGH>,
> +					<&adsp_smp2p_in 0 0>,
> +					<&adsp_smp2p_in 1 0>,
> +					<&adsp_smp2p_in 2 0>,
> +					<&adsp_smp2p_in 3 0>,
> +					<&adsp_smp2p_in 7 0>;

Misaligned.

What are the trailing '0'?

> +
> +		interrupt-names = "wdog", "fatal", "ready",
> +			"handover", "stop-ack",  "shutdown-ack";
> +		qcom,qmp = <&aoss_qmp>;
> +
> +		clocks = <&rpmhcc RPMH_CXO_CLK>,
> +			<&gcc GCC_CFG_NOC_LPASS_CLK>,
> +			<&lpasscc LPASS_QDSP6SS_XO_CLK>,
> +			<&lpasscc LPASS_QDSP6SS_SLEEP_CLK>,
> +			<&lpasscc LPASS_QDSP6SS_CORE_CLK>;
> +
> +		clock-names = "xo", "gcc_cfg_noc_lpass",
> +				"lpass_qdsp6ss_xo",
> +				"lpass_qdsp6ss_sleep",
> +				"lpass_qdsp6ss_core";
> +
> +		iommus = <&apps_smmu 0x1800 0x0>;
> +
> +		power-domains =	<&rpmhpd SC7280_LCX>;
> +		power-domain-names = "lcx";
> +		required-opps = <&rpmhpd_opp_nom>;
> +
> +		resets = <&aoss_reset AOSS_CC_LPASS_RESTART>,
> +			<&pdc_reset PDC_AUDIO_SYNC_RESET>;
> +
> +		reset-names = "cc_lpass", "pdc_sync";
> +
> +		qcom,halt-regs = <&tcsr_1 0x3000 0x5000 0x8000 0x13000>;
> +
> +		memory-region = <&adsp_mem>;
> +
> +		status = "okay";

Why do you need this?
> +
> +		qcom,smem-states = <&adsp_smp2p_out 0>;
> +		qcom,smem-state-names = "stop";
> +
> +		glink-edge {
> +			interrupts-extended = <&ipcc IPCC_CLIENT_LPASS
> +						IPCC_MPROC_SIGNAL_GLINK_QMP
> +						IRQ_TYPE_EDGE_RISING>;
> +			mboxes = <&ipcc IPCC_CLIENT_LPASS
> +					IPCC_MPROC_SIGNAL_GLINK_QMP>;
> +
> +			label = "lpass";
> +			qcom,remote-pid = <2>;
> +
> +			gpr {
> +				compatible = "qcom,gpr";
> +				qcom,glink-channels = "adsp_apps";
> +				qcom,domain = <GPR_DOMAIN_ID_ADSP>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				qcom,intents = <512 20>;
> +
> +				q6apm: q6apm {

Does not look like you tested the DTS against bindings. Please run `make
dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
for instructions).

It's not even passing regular test - build with W=1...

> +					reg = <GPR_APM_MODULE_IID>;

Where did you include file that define?

> +					compatible = "qcom,q6apm";
> +					#sound-dai-cells = <0>;
> +					q6apmdai: dais {
> +						compatible = "qcom,q6apm-dais";
> +						#sound-dai-cells = <1>;
> +						iommus = <&apps_smmu 0x1801 0x0>;
> +					};
> +

Best regards,
Krzysztof

