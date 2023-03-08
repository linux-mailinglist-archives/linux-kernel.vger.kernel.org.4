Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C304E6B040C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 11:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjCHKYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 05:24:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbjCHKXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 05:23:52 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01023801D
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 02:23:39 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id g18so16071366ljl.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 02:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678271018;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fBIGDP2vKV1LTDXQf5uKoGGFDI8J7NvyxEFCkhslPEg=;
        b=DIhKKQQqnL8LCW4Ll07bucDFBQ51cWxpmJ59KX4m32MNQJUFOTWnY3NUViKi/FOmh8
         FVOvVV7eZtKp7bDOQxfowgUHhQoR/uDB+p58NPsMCnxYVwWCFaD/JjqEA6mhh2b6buOw
         TQdczWNv7UuGrWwWtUPqobWyopIig7C7JWK0Z1xnTRjx8tN+iHTOZNOb2llZtW7KH9eG
         NEotJeAzP1cjev2jW10uZmPKaStWDKxfiFh1ie2eXCznBc12ll+g39pv3cpmtSMHNIaw
         gCp2sK39rx/DyJW2OnFdljSbbGS9zwG9LrWQUMNZ/hGCn883i3oycWSpKVe3Rn0ZE0Gj
         K1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678271018;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fBIGDP2vKV1LTDXQf5uKoGGFDI8J7NvyxEFCkhslPEg=;
        b=x3cCdkT6vHwnXEWl2z5ndQMIy1NQWC2yhHMUNMqcEVokFtXj7r1QCSuPA8bCyrVUpe
         lxVZ6TJ6t4mTID79PXVZm3z+QBOMoWmuv+2bgds9nfJIHUwEelZBV01DDKi8pw+7Si6v
         bvATfjqVLFdnrVMkxvfHAjQ+YeJk2bLbcbdZmpseIq03PlbdPs9h1PbUnZMPsWZJNsB9
         YAyv1shpwRSh2NJF62R3XhF4rq9TdSU7uqpgavhCr4lYu8G2S6AQXb8zBz1uggKKoPRY
         Sl1by9NgUbPwQAoF2TEaZu31IIXgspVx1txsonsfDk9UuaX0KeN9GDMCZuySezDJ1K9S
         PyCw==
X-Gm-Message-State: AO0yUKWpE64ZPUIALQBReaYWxbn0JGvj0rMGvIHszUv2JRuaLBf9+hhW
        qAHsEt+CEF3IxA1hseZD1KWtxw==
X-Google-Smtp-Source: AK7set/K7tmBeXNUWmKlGFH1fkoeUZNQgjuz2ExHPZumgnhKVL44CrwXRANCpM+XAU5OkRih5Lr9oQ==
X-Received: by 2002:a2e:96cb:0:b0:295:c333:2a24 with SMTP id d11-20020a2e96cb000000b00295c3332a24mr6696348ljj.19.1678271017967;
        Wed, 08 Mar 2023 02:23:37 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id p28-20020ac246dc000000b004db4b7ad6d1sm2282369lfo.31.2023.03.08.02.23.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 02:23:37 -0800 (PST)
Message-ID: <af21f499-5895-c564-3e6f-d23ba188544b@linaro.org>
Date:   Wed, 8 Mar 2023 11:23:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 1/3] arm64: dts: qcom: qdu1000: Add IPCC, MPSS, AOSS
 nodes
Content-Language: en-US
To:     Melody Olvera <quic_molvera@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230306231719.22263-1-quic_molvera@quicinc.com>
 <20230306231719.22263-2-quic_molvera@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230306231719.22263-2-quic_molvera@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7.03.2023 00:17, Melody Olvera wrote:
> Add nodes for IPCC, MPSS, and AOSS drivers. Also update
> the scm node to include its interconnect.
Quite a bit of stuff in a single commit, this could be
separated into:

- scm icc
- aoss+ipcc
- smp2p+mpss

> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qdu1000.dtsi | 104 ++++++++++++++++++++++++++
>  1 file changed, 104 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qdu1000.dtsi b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
> index f234159d2060..6cc96a7c33e8 100644
> --- a/arch/arm64/boot/dts/qcom/qdu1000.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
> @@ -8,6 +8,7 @@
>  #include <dt-bindings/dma/qcom-gpi.h>
>  #include <dt-bindings/interconnect/qcom,qdu1000-rpmh.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/mailbox/qcom-ipcc.h>
>  #include <dt-bindings/power/qcom-rpmpd.h>
>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>  
> @@ -141,6 +142,7 @@ CLUSTER_SLEEP_1: cluster-sleep-1 {
>  	firmware {
>  		scm {
>  			compatible = "qcom,scm-qdu1000", "qcom,scm";
> +			interconnects = <&system_noc MASTER_CRYPTO 0 &mc_virt SLAVE_EBI1 0>;
>  		};
>  	};
>  
> @@ -326,6 +328,11 @@ q6_mpss_dtb_mem: q6-mpss-dtb@9ec00000 {
>  			no-map;
>  		};
>  
> +		mpss_dsm_mem: mpss-dsm@9ec80000 {
> +			reg = <0x0 0x9ec80000 0x0 0x880000>;
> +			no-map;
> +		};
> +
>  		tenx_mem: tenx@a0000000 {
>  			reg = <0x0 0xa0000000 0x0 0x19600000>;
>  			no-map;
> @@ -347,6 +354,28 @@ ipa_buffer_mem: ipa-buffer@c3200000 {
>  		};
>  	};
>  
> +	smp2p-modem {
> +		compatible = "qcom,smp2p";
> +		qcom,smem = <435>, <428>;
> +		interrupts-extended = <&ipcc IPCC_CLIENT_MPSS
> +					   IPCC_MPROC_SIGNAL_SMP2P
> +					   IRQ_TYPE_EDGE_RISING>;
Not sure if thunderfox is acting up again or the indentation here
is not quite right

> +		mboxes = <&ipcc IPCC_CLIENT_MPSS IPCC_MPROC_SIGNAL_SMP2P>;
> +		qcom,local-pid = <0>;
> +		qcom,remote-pid = <1>;
> +
> +		smp2p_modem_out: master-kernel {
> +			qcom,entry-name = "master-kernel";
> +			#qcom,smem-state-cells = <1>;
> +		};
> +
> +		smp2p_modem_in: slave-kernel {
> +			qcom,entry-name = "slave-kernel";
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +	};
> +
>  	soc: soc@0 {
>  		compatible = "simple-bus";
>  		#address-cells = <2>;
> @@ -367,6 +396,15 @@ gcc: clock-controller@80000 {
>  			#power-domain-cells = <1>;
>  		};
>  
> +		ipcc: mailbox@408000 {
> +			compatible = "qcom,qdu1000-ipcc", "qcom,ipcc";
> +			reg = <0x0 0x408000 0x0 0x1000>;
The address part should be padded to 8 hex digits. I'd appreciate it
if you could submit a fixup for the other nodes in this dtsi!

> +			interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-controller;
> +			#interrupt-cells = <3>;
> +			#mbox-cells = <2>;
> +		};
> +
>  		gpi_dma0: dma-controller@900000  {
>  			compatible = "qcom,qdu1000-gpi-dma", "qcom,sm6350-gpi-dma";
>  			reg = <0x0 0x900000 0x0 0x60000>;
> @@ -842,6 +880,49 @@ tcsr_mutex: hwlock@1f40000 {
>  			#hwlock-cells = <1>;
>  		};
>  
> +		remoteproc_mpss: remoteproc@4080000 {
> +			compatible = "qcom,qdu1000-mpss-pas";
> +			reg = <0x0 0x4080000 0x0 0x4040>,
The address part should be padded to 8 hex digits

> +			      <0x0 0x4180000 0x0 0x1000>;
No reg-names?

> +
> +			interrupts-extended = <&intc GIC_SPI 264 IRQ_TYPE_EDGE_RISING>,
> +					      <&smp2p_modem_in 0 IRQ_TYPE_EDGE_RISING>,
> +					      <&smp2p_modem_in 1 IRQ_TYPE_EDGE_RISING>,
> +					      <&smp2p_modem_in 2 IRQ_TYPE_EDGE_RISING>,
> +					      <&smp2p_modem_in 3 IRQ_TYPE_EDGE_RISING>,
> +					      <&smp2p_modem_in 7 IRQ_TYPE_EDGE_RISING>;
> +			interrupt-names = "wdog", "fatal", "ready", "handover",
> +					  "stop-ack", "shutdown-ack";
This could be a vertical list, similar to the interrupts-extended itself

> +
> +			clocks = <&rpmhcc RPMH_CXO_CLK>;
> +			clock-names = "xo";
> +
> +			power-domains = <&rpmhpd QDU1000_CX>,
> +					<&rpmhpd QDU1000_MSS>;
> +			power-domain-names = "cx", "mss";
> +
> +			memory-region = <&mpss_mem>, <&q6_mpss_dtb_mem>, <&mpss_dsm_mem>;
> +
> +			interconnects = <&mc_virt MASTER_LLCC 0 &mc_virt SLAVE_EBI1 0>;
> +
> +			qcom,qmp = <&aoss_qmp>;
> +
> +			qcom,smem-states = <&smp2p_modem_out 0>;
> +			qcom,smem-state-names = "stop";
> +
> +			status = "disabled";
> +
> +			glink-edge {
> +				interrupts-extended = <&ipcc IPCC_CLIENT_MPSS
> +							     IPCC_MPROC_SIGNAL_GLINK_QMP
> +							     IRQ_TYPE_EDGE_RISING>;
> +				mboxes = <&ipcc IPCC_CLIENT_MPSS
> +						IPCC_MPROC_SIGNAL_GLINK_QMP>;
> +				label = "modem";
> +				qcom,remote-pid = <1>;
> +			};
> +		};
> +
>  		pdc: interrupt-controller@b220000 {
>  			compatible = "qcom,qdu1000-pdc", "qcom,pdc";
>  			reg = <0x0 0xb220000 0x0 0x30000>, <0x0 0x174000f0 0x0 0x64>;
> @@ -852,6 +933,29 @@ pdc: interrupt-controller@b220000 {
>  			interrupt-controller;
>  		};
>  
> +		aoss_qmp: qmp@c300000 {
> +			compatible = "qcom,qdu1000-aoss-qmp", "qcom,aoss-qmp";
> +			reg = <0x0 0xc300000 0x0 0x400>;
The address part should be padded to 8 hex digits

> +			interrupts-extended = <&ipcc IPCC_CLIENT_AOP
> +						     IPCC_MPROC_SIGNAL_GLINK_QMP
> +						     IRQ_TYPE_EDGE_RISING>;
> +			mboxes = <&ipcc IPCC_CLIENT_AOP IPCC_MPROC_SIGNAL_GLINK_QMP>;
> +
> +			#clock-cells = <0>;
> +
> +			cx_cdev: cx {
> +				#cooling-cells = <2>;
> +			};
> +
> +			mx_cdev: mx {
> +				#cooling-cells = <2>;
> +			};
> +
> +			ebi_cdev: ebi {
> +				#cooling-cells = <2>;
> +			};
cx
ebi
mx

would be alphabetical, unless there's some strong ordering required,
not sure


Konrad
> +		};
> +
>  		spmi_bus: spmi@c400000 {
>  			compatible = "qcom,spmi-pmic-arb";
>  			reg = <0x0 0xc400000 0x0 0x3000>,
