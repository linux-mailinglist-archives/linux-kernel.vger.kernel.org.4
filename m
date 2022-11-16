Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7D962BCA9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbiKPLyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:54:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbiKPLx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:53:59 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C422ED73
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 03:45:29 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id n21so2676028ejb.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 03:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6PU/s3w3VFB3LOTPVe/QK8xohKvAll212EfZyK9lMEI=;
        b=RN6+sDpY2tKrmP1/Cjxk9YzE1Dm2KnvHTiRqNiW/DcnAm0ZaIrpVV+MJOpu54F2pNX
         dqlFjNRkcISPf+XZO9JiB8wjifB3YvAmooGUuAbI0spmjgWJJo6l8LK+WVteC0mxDbsN
         3xLkjb79juPkUbCh9qz5CdsRFBWVPofdcUWvT3STv/1hjmgXCnoyLAAKVKAyR9l5yuMz
         dIX9sdmiYY37BRLjFwfs7d4E9h5ObQ3+mIZ7Nx1qu3BA3NnlX+oeU7gMpp2/J9xj0qZe
         YNUjpqXd4rJsvQ+UpnE6+vrQQePFoCuojgJBhE2WTS8eoSjduZid64pnaVVnShwTRVxF
         K3Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6PU/s3w3VFB3LOTPVe/QK8xohKvAll212EfZyK9lMEI=;
        b=b1KPjamKhvJHLzYdXO74e8naRsdS/hjd45/ryK/gN2pRpBOwJFfY0QiHmLSa1//lmF
         l975xqWQPYSFudKaJa1KQS2DYeE0fijX1BIAlmPfE9EsLEAzYTaxMqUY0X06R8eZWF5W
         pRjo/f0/aPpAz+WComMQsnfNvidcT8V+5nJaumtSPFDdD5c9He0+WV91TuK0yNKeclfI
         rFsR5IAZc21aL08gO5y80E8ErGNsGTwLahv8s87Stin3yT7IrwgUTVs/M6TqAY5tiq+t
         APMY+ygoESYdYorhw6kRPwUVdPvT50Ljb4mFpBvZRY7n9i04EfpcoMRY3N0AZj7x0wTG
         l3Fg==
X-Gm-Message-State: ANoB5pkh6gdUJGZ1SYQ4bK9WJQ+7oobwRSuic9wxY66lLMgAQGurQKra
        1z7+ov5jly4cnCKb/8BAmh+oVQ==
X-Google-Smtp-Source: AA0mqf7D16taZFwNALY3zWl1z0bYVkcAm/B6mp5m6VIkFPQU7p8rg4bwzUtvZqJKBR56uOvs99LOQw==
X-Received: by 2002:a17:907:36c:b0:78d:3341:aa8 with SMTP id rs12-20020a170907036c00b0078d33410aa8mr16843335ejb.96.1668599127888;
        Wed, 16 Nov 2022 03:45:27 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id u1-20020a1709061da100b0078bfff89de4sm6800166ejh.58.2022.11.16.03.45.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 03:45:27 -0800 (PST)
Message-ID: <f4f53117-7f60-6f22-0e0f-bb4f8ee1ea9f@linaro.org>
Date:   Wed, 16 Nov 2022 12:45:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sm8550: add adsp, cdsp & mdss
 support nodes
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20221115-topic-sm8550-upstream-dts-remoteproc-v1-0-379eec11d841@linaro.org>
 <20221115-topic-sm8550-upstream-dts-remoteproc-v1-2-379eec11d841@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221115-topic-sm8550-upstream-dts-remoteproc-v1-2-379eec11d841@linaro.org>
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



On 16/11/2022 11:43, Neil Armstrong wrote:
> This adds support for the aDSP, cDSP and MPSS Subsystems found in
> the SM8550 SoC.
> 
> The aDSP, cDSP and MPSS needs:
> - smp2p support nodes to get event back from the subsystems
> - remoteproc nodes with glink-edge subnodes providing all needed
>    resources to start and run the subsystems
> 
> In addition, the MPSS Subsystem needs a rmtfs_mem dedicated
> memory zone.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
The title and commit message are misleading, you're either adding 
support or adding nodes. There is no such thing as "support nodes".

The code looks good though, so with that fixed:
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

>   arch/arm64/boot/dts/qcom/sm8550.dtsi | 337 +++++++++++++++++++++++++++++++++++
>   1 file changed, 337 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> index 9e00778bb600..cac3adc4504f 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> @@ -543,6 +543,15 @@ adspslpi_mem: adspslpi-region@9ea00000 {
>   
>   		/* Linux kernel image is loaded at 0xa8000000 */
>   
> +		rmtfs_mem: rmtfs-region@d4a80000 {
> +			compatible = "qcom,rmtfs-mem";
> +			reg = <0x0 0xd4a80000 0x0 0x280000>;
> +			no-map;
> +
> +			qcom,client-id = <1>;
> +			qcom,vmid = <15>;
> +		};
> +
>   		mpss_dsm_mem: mpss-dsm-region@d4d00000 {
>   			compatible = "qcom,mpss-dsm-mem";
>   			reg = <0x0 0xd4d00000 0x0 0x3300000>;
> @@ -635,6 +644,89 @@ hyp_ext_reserved_mem: hyp-ext-reserved-region@ff700000 {
>   		};
>   	};
>   
> +	smp2p-adsp {
> +		compatible = "qcom,smp2p";
> +		qcom,smem = <443>, <429>;
> +		interrupts-extended = <&ipcc IPCC_CLIENT_LPASS
> +					     IPCC_MPROC_SIGNAL_SMP2P
> +					     IRQ_TYPE_EDGE_RISING>;
> +		mboxes = <&ipcc IPCC_CLIENT_LPASS
> +				IPCC_MPROC_SIGNAL_SMP2P>;
> +
> +		qcom,local-pid = <0>;
> +		qcom,remote-pid = <2>;
> +
> +		smp2p_adsp_out: master-kernel {
> +			qcom,entry-name = "master-kernel";
> +			#qcom,smem-state-cells = <1>;
> +		};
> +
> +		smp2p_adsp_in: slave-kernel {
> +			qcom,entry-name = "slave-kernel";
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +	};
> +
> +	smp2p-cdsp {
> +		compatible = "qcom,smp2p";
> +		qcom,smem = <94>, <432>;
> +		interrupts-extended = <&ipcc IPCC_CLIENT_CDSP
> +					     IPCC_MPROC_SIGNAL_SMP2P
> +					     IRQ_TYPE_EDGE_RISING>;
> +		mboxes = <&ipcc IPCC_CLIENT_CDSP
> +				IPCC_MPROC_SIGNAL_SMP2P>;
> +
> +		qcom,local-pid = <0>;
> +		qcom,remote-pid = <5>;
> +
> +		smp2p_cdsp_out: master-kernel {
> +			qcom,entry-name = "master-kernel";
> +			#qcom,smem-state-cells = <1>;
> +		};
> +
> +		smp2p_cdsp_in: slave-kernel {
> +			qcom,entry-name = "slave-kernel";
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +	};
> +
> +	smp2p-modem {
> +		compatible = "qcom,smp2p";
> +		qcom,smem = <435>, <428>;
> +		interrupts-extended = <&ipcc IPCC_CLIENT_MPSS
> +					     IPCC_MPROC_SIGNAL_SMP2P
> +					     IRQ_TYPE_EDGE_RISING>;
> +		mboxes = <&ipcc IPCC_CLIENT_MPSS
> +				IPCC_MPROC_SIGNAL_SMP2P>;
> +
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
> +
> +		ipa_smp2p_out: ipa-ap-to-modem {
> +			qcom,entry-name = "ipa";
> +			#qcom,smem-state-cells = <1>;
> +		};
> +
> +		ipa_smp2p_in: ipa-modem-to-ap {
> +			qcom,entry-name = "ipa";
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +	};
> +
>   	soc: soc@0 {
>   		#address-cells = <2>;
>   		#size-cells = <2>;
> @@ -1388,6 +1480,48 @@ tcsr: clock-controller@1fc0000 {
>   			#reset-cells = <1>;
>   		};
>   
> +		remoteproc_mpss: remoteproc@4080000 {
> +			compatible = "qcom,sm8550-mpss-pas";
> +			reg = <0x0 0x04080000 0x0 0x4040>;
> +
> +			interrupts-extended = <&intc GIC_SPI 264 IRQ_TYPE_EDGE_RISING>,
> +					      <&smp2p_modem_in 0 IRQ_TYPE_EDGE_RISING>,
> +					      <&smp2p_modem_in 1 IRQ_TYPE_EDGE_RISING>,
> +					      <&smp2p_modem_in 2 IRQ_TYPE_EDGE_RISING>,
> +					      <&smp2p_modem_in 3 IRQ_TYPE_EDGE_RISING>,
> +					      <&smp2p_modem_in 7 IRQ_TYPE_EDGE_RISING>;
> +			interrupt-names = "wdog", "fatal", "ready", "handover",
> +					  "stop-ack", "shutdown-ack";
> +
> +			clocks = <&rpmhcc RPMH_CXO_CLK>;
> +			clock-names = "xo";
> +
> +			power-domains = <&rpmhpd SM8550_CX>,
> +					<&rpmhpd SM8550_MSS>;
> +			power-domain-names = "cx", "mss";
> +
> +			interconnects = <&mc_virt MASTER_LLCC 0 &mc_virt SLAVE_EBI1 0>;
> +
> +			memory-region = <&mpss_mem &q6_mpss_dtb_mem>;
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
> +				label = "mpss";
> +				qcom,remote-pid = <1>;
> +			};
> +		};
> +
>   		lpass_lpiaon_noc: interconnect@7400000 {
>   			compatible = "qcom,sm8550-lpass-lpiaon-noc";
>   			reg = <0x0 0x07400000 0x0 0x19080>;
> @@ -2865,12 +2999,215 @@ system-cache-controller@25000000 {
>   			interrupts = <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>;
>   		};
>   
> +		remoteproc_adsp: remoteproc@30000000 {
> +			compatible = "qcom,sm8550-adsp-pas";
> +			reg = <0x0 0x30000000 0x0 0x100>;
> +
> +			interrupts-extended = <&pdc 6 IRQ_TYPE_EDGE_RISING>,
> +					      <&smp2p_adsp_in 0 IRQ_TYPE_EDGE_RISING>,
> +					      <&smp2p_adsp_in 1 IRQ_TYPE_EDGE_RISING>,
> +					      <&smp2p_adsp_in 2 IRQ_TYPE_EDGE_RISING>,
> +					      <&smp2p_adsp_in 3 IRQ_TYPE_EDGE_RISING>;
> +			interrupt-names = "wdog", "fatal", "ready",
> +					  "handover", "stop-ack";
> +
> +			clocks = <&rpmhcc RPMH_CXO_CLK>;
> +			clock-names = "xo";
> +
> +			power-domains = <&rpmhpd SM8550_LCX>,
> +					<&rpmhpd SM8550_LMX>;
> +			power-domain-names = "lcx", "lmx";
> +
> +			interconnects = <&lpass_lpicx_noc MASTER_LPASS_PROC 0 &mc_virt SLAVE_EBI1 0>;
> +
> +			memory-region = <&adspslpi_mem &q6_adsp_dtb_mem>;
> +
> +			qcom,qmp = <&aoss_qmp>;
> +
> +			qcom,smem-states = <&smp2p_adsp_out 0>;
> +			qcom,smem-state-names = "stop";
> +
> +			status = "disabled";
> +
> +			remoteproc_adsp_glink: glink-edge {
> +				interrupts-extended = <&ipcc IPCC_CLIENT_LPASS
> +							     IPCC_MPROC_SIGNAL_GLINK_QMP
> +							     IRQ_TYPE_EDGE_RISING>;
> +				mboxes = <&ipcc IPCC_CLIENT_LPASS
> +						IPCC_MPROC_SIGNAL_GLINK_QMP>;
> +
> +				label = "lpass";
> +				qcom,remote-pid = <2>;
> +
> +				fastrpc {
> +					compatible = "qcom,fastrpc";
> +					qcom,glink-channels = "fastrpcglink-apps-dsp";
> +					label = "adsp";
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					compute-cb@3 {
> +						compatible = "qcom,fastrpc-compute-cb";
> +						reg = <3>;
> +						iommus = <&apps_smmu 0x1003 0x80>,
> +						         <&apps_smmu 0x1063 0x0>;
> +					};
> +
> +					compute-cb@4 {
> +						compatible = "qcom,fastrpc-compute-cb";
> +						reg = <4>;
> +						iommus = <&apps_smmu 0x1004 0x80>,
> +							 <&apps_smmu 0x1064 0x0>;
> +					};
> +
> +					compute-cb@5 {
> +						compatible = "qcom,fastrpc-compute-cb";
> +						reg = <5>;
> +						iommus = <&apps_smmu 0x1005 0x80>,
> +							 <&apps_smmu 0x1065 0x0>;
> +					};
> +
> +					compute-cb@6 {
> +						compatible = "qcom,fastrpc-compute-cb";
> +						reg = <6>;
> +						iommus = <&apps_smmu 0x1006 0x80>,
> +						         <&apps_smmu 0x1066 0x0>;
> +					};
> +
> +					compute-cb@7 {
> +						compatible = "qcom,fastrpc-compute-cb";
> +						reg = <7>;
> +						iommus = <&apps_smmu 0x1007 0x80>,
> +						         <&apps_smmu 0x1067 0x0>;
> +					};
> +				};
> +			};
> +		};
> +
>   		nsp_noc: interconnect@320c0000 {
>   			compatible = "qcom,sm8550-nsp-noc";
>   			reg = <0x0 0x320C0000 0x0 0xE080>;
>   			#interconnect-cells = <2>;
>   			qcom,bcm-voters = <&apps_bcm_voter>;
>   		};
> +
> +		remoteproc_cdsp: remoteproc@32300000 {
> +			compatible = "qcom,sm8550-cdsp-pas";
> +			reg = <0x0 0x32300000 0x0 0x1400000>;
> +
> +			interrupts-extended = <&intc GIC_SPI 578 IRQ_TYPE_EDGE_RISING>,
> +					      <&smp2p_cdsp_in 0 IRQ_TYPE_EDGE_RISING>,
> +					      <&smp2p_cdsp_in 1 IRQ_TYPE_EDGE_RISING>,
> +					      <&smp2p_cdsp_in 2 IRQ_TYPE_EDGE_RISING>,
> +					      <&smp2p_cdsp_in 3 IRQ_TYPE_EDGE_RISING>;
> +			interrupt-names = "wdog", "fatal", "ready",
> +					  "handover", "stop-ack";
> +
> +			clocks = <&rpmhcc RPMH_CXO_CLK>;
> +			clock-names = "xo";
> +
> +			power-domains = <&rpmhpd SM8550_CX>,
> +					<&rpmhpd SM8550_MXC>,
> +					<&rpmhpd SM8550_NSP>;
> +			power-domain-names = "cx", "mxc", "nsp";
> +
> +			interconnects = <&nsp_noc MASTER_CDSP_PROC 0 &mc_virt SLAVE_EBI1 0>;
> +
> +			memory-region = <&cdsp_mem &q6_cdsp_dtb_mem>;
> +
> +			qcom,qmp = <&aoss_qmp>;
> +
> +			qcom,smem-states = <&smp2p_cdsp_out 0>;
> +			qcom,smem-state-names = "stop";
> +
> +			status = "disabled";
> +
> +			glink-edge {
> +				interrupts-extended = <&ipcc IPCC_CLIENT_CDSP
> +							     IPCC_MPROC_SIGNAL_GLINK_QMP
> +							     IRQ_TYPE_EDGE_RISING>;
> +				mboxes = <&ipcc IPCC_CLIENT_CDSP
> +						IPCC_MPROC_SIGNAL_GLINK_QMP>;
> +
> +				label = "cdsp";
> +				qcom,remote-pid = <5>;
> +
> +				fastrpc {
> +					compatible = "qcom,fastrpc";
> +					qcom,glink-channels = "fastrpcglink-apps-dsp";
> +					label = "cdsp";
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +
> +					compute-cb@1 {
> +						compatible = "qcom,fastrpc-compute-cb";
> +						reg = <1>;
> +						iommus = <&apps_smmu 0x1961 0x0>,
> +							 <&apps_smmu 0x0c01 0x20>,
> +							 <&apps_smmu 0x19c1 0x10>;
> +					};
> +
> +					compute-cb@2 {
> +						compatible = "qcom,fastrpc-compute-cb";
> +						reg = <2>;
> +						iommus = <&apps_smmu 0x1962 0x0>,
> +							 <&apps_smmu 0x0c02 0x20>,
> +							 <&apps_smmu 0x19c2 0x10>;
> +					};
> +
> +					compute-cb@3 {
> +						compatible = "qcom,fastrpc-compute-cb";
> +						reg = <3>;
> +						iommus = <&apps_smmu 0x1963 0x0>,
> +							 <&apps_smmu 0x0c03 0x20>,
> +							 <&apps_smmu 0x19c3 0x10>;
> +					};
> +
> +					compute-cb@4 {
> +						compatible = "qcom,fastrpc-compute-cb";
> +						reg = <4>;
> +						iommus = <&apps_smmu 0x1964 0x0>,
> +							 <&apps_smmu 0x0c04 0x20>,
> +							 <&apps_smmu 0x19c4 0x10>;
> +					};
> +
> +					compute-cb@5 {
> +						compatible = "qcom,fastrpc-compute-cb";
> +						reg = <5>;
> +						iommus = <&apps_smmu 0x1965 0x0>,
> +							 <&apps_smmu 0x0c05 0x20>,
> +							 <&apps_smmu 0x19c5 0x10>;
> +					};
> +
> +					compute-cb@6 {
> +						compatible = "qcom,fastrpc-compute-cb";
> +						reg = <6>;
> +						iommus = <&apps_smmu 0x1966 0x0>,
> +							 <&apps_smmu 0x0c06 0x20>,
> +							 <&apps_smmu 0x19c6 0x10>;
> +					};
> +
> +					compute-cb@7 {
> +						compatible = "qcom,fastrpc-compute-cb";
> +						reg = <7>;
> +						iommus = <&apps_smmu 0x1967 0x0>,
> +							 <&apps_smmu 0x0c07 0x20>,
> +							 <&apps_smmu 0x19c7 0x10>;
> +					};
> +
> +					compute-cb@8 {
> +						compatible = "qcom,fastrpc-compute-cb";
> +						reg = <8>;
> +						iommus = <&apps_smmu 0x1968 0x0>,
> +							 <&apps_smmu 0x0c08 0x20>,
> +							 <&apps_smmu 0x19c8 0x10>;
> +					};
> +
> +					/* note: secure cb9 in downstream */
> +				};
> +			};
> +		};
>   	};
>   
>   	thermal-zones {
> 
