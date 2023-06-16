Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB53732FD3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 13:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345090AbjFPLZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 07:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241049AbjFPLZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 07:25:32 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A8E1BF3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 04:25:30 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b45c289615so3606861fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 04:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686914729; x=1689506729;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9GW/uDRlzPJLMcNzpir0nUo7q0aBLIGibM0KeqUJw/U=;
        b=Kz/ZRfmXcv7pBwcHSe5ZZatIbk1PGCrx9pdip+jY7+0vyhf0guri9vERs0vDHI11/t
         x41kT56FNrH2ovS/y8xUXle9VIFoqp1C/zjlw/wa3vndew0tThL5RNLRLGCxPpF26Dov
         1DMVoqHZY20Q+njcnvpRhpTjkQUf+2fMlQpndaYBVTEj8i1Ef90GsKp85YNUXvdJC+2t
         29VqHQEcpuBHiDQr0CM25Vi8P0KcmPucXSgCWZl8PE5wHdaU6/vQKnS6x6CL9FlWpCrY
         9K3lVt8hYIDsuxHaCXJ8uB9O46MTg8+xph3LQ+VThFKevfIPqNBJJ+h11qv4Jly4kxlz
         6dgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686914729; x=1689506729;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9GW/uDRlzPJLMcNzpir0nUo7q0aBLIGibM0KeqUJw/U=;
        b=NC04VVBTwlvzc2FMEbRQdUF48pQFWKx26Q5ghw8MYfG7xxdSQw8xwGNnJ9x+vLGHho
         fAUIbU7eb9NMeW75DsI1bKczuJsaTIMHF0OlvV4nPN0z7FsZHZr2+EscHCpELsPjVDnI
         2Uae1cX95mwwBoknnn8+RlHCzOj22Z1WdKpGIzFsemIAfptt10QMVvu+wTujrPgt4+Ty
         jcjZmKP829pcjd7EeX0jAUCmmqIos3+lOY6iKbeHEBSRjDo+Ovx8Jv084Nan8XgbIsht
         +qItPesrEMeDd7+u5bu188nW0bAHRyoepVo/qj8UjPUU3SPjMxlvWdQPSGbsctfHDv+l
         ev6A==
X-Gm-Message-State: AC+VfDxjFTvvyzIGBiC9DLO95z11bbHXY9eLM/BFtNsBmgdZUc4SLjqi
        pLgEm24MQvnQywWTif1rMysFKQ==
X-Google-Smtp-Source: ACHHUZ4n7qrhv77hn2VEU+GudfZ/21qgiakxzWg6FEAfSf814L64WE4XliQvW319ZaAXF9XD0wIx5g==
X-Received: by 2002:a2e:8187:0:b0:2b3:4581:4a2d with SMTP id e7-20020a2e8187000000b002b345814a2dmr1703408ljg.3.1686914728987;
        Fri, 16 Jun 2023 04:25:28 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id x5-20020a2e9c85000000b002b216ef9f5dsm3578902lji.43.2023.06.16.04.25.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 04:25:28 -0700 (PDT)
Message-ID: <353fe482-62f7-6252-5123-6907f84762b9@linaro.org>
Date:   Fri, 16 Jun 2023 13:25:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [RESEND v6 5/8] arm64: dts: qcom: sc7280: Add LPASS PIL node
Content-Language: en-US
To:     Mohammad Rafi Shaik <quic_mohs@quicinc.com>,
        krzysztof.kozlowski+dt@linaro.org, swboyd@chromium.org,
        andersson@kernel.org, broonie@kernel.org, agross@kernel.org
Cc:     robh+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_rohkumar@quicinc.com, srinivas.kandagatla@linaro.org,
        dianders@chromium.org, judyhsiao@chromium.org,
        quic_visr@quicinc.com,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
References: <20230616103534.4031331-1-quic_mohs@quicinc.com>
 <20230616103534.4031331-6-quic_mohs@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230616103534.4031331-6-quic_mohs@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.06.2023 12:35, Mohammad Rafi Shaik wrote:
> From: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> 
> Add LPASS PIL node for sc7280 based audioreach platforms.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
> ---
The node should reside in the SoC DTSI, ideally the bindings should
be compatible with the PAS setup to the point where only a compatible
swap is needed..

Konrad
>  .../sc7280-herobrine-audioreach-wcd9385.dtsi  | 90 +++++++++++++++++++
>  1 file changed, 90 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
> index 95d3aa08ebde..9daea1b25656 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
> @@ -7,6 +7,8 @@
>   */
>  
>  #include <dt-bindings/sound/qcom,q6afe.h>
> +#include <dt-bindings/clock/qcom,lpass-sc7280.h>
> +#include <dt-bindings/soc/qcom,gpr.h>
>  
>  /{
>  	/* BOARD-SPECIFIC TOP LEVEL NODES */
> @@ -105,4 +107,92 @@ platform {
>  			};
>  		};
>  	};
> +
> +	remoteproc_adsp: remoteproc@3000000 {
> +		compatible = "qcom,sc7280-adsp-pil";
> +		reg = <0 0x03000000 0 0x5000>, <0 0x0355b000 0 0x10>;
> +		reg-names = "qdsp6ss_base", "lpass_efuse";
> +
> +		interrupts-extended = <&pdc 6 IRQ_TYPE_LEVEL_HIGH>,
> +				      <&adsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
> +				      <&adsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
> +				      <&adsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
> +				      <&adsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>,
> +				      <&adsp_smp2p_in 7 IRQ_TYPE_EDGE_RISING>;
> +
> +		interrupt-names = "wdog", "fatal", "ready",
> +				  "handover", "stop-ack",
> +				  "shutdown-ack";
> +
> +		qcom,qmp = <&aoss_qmp>;
> +
> +		clocks = <&rpmhcc RPMH_CXO_CLK>,
> +			 <&gcc GCC_CFG_NOC_LPASS_CLK>;
> +		clock-names = "xo", "gcc_cfg_noc_lpass";
> +
> +		iommus = <&apps_smmu 0x1800 0x0>;
> +
> +		power-domains =	<&rpmhpd SC7280_CX>;
> +		power-domain-names = "cx";
> +
> +		required-opps = <&rpmhpd_opp_nom>;
> +
> +		resets = <&pdc_reset PDC_AUDIO_SYNC_RESET>,
> +			 <&aoss_reset AOSS_CC_LPASS_RESTART>;
> +		reset-names =  "pdc_sync", "cc_lpass";
> +
> +		qcom,halt-regs = <&tcsr_1 0x3000 0x5000 0x8000 0x13000>;
> +
> +		memory-region = <&adsp_mem>;
> +
> +		qcom,smem-states = <&adsp_smp2p_out 0>;
> +		qcom,smem-state-names = "stop";
> +
> +		glink-edge {
> +			interrupts-extended = <&ipcc IPCC_CLIENT_LPASS
> +					      IPCC_MPROC_SIGNAL_GLINK_QMP
> +					      IRQ_TYPE_EDGE_RISING>;
> +
> +			mboxes = <&ipcc IPCC_CLIENT_LPASS
> +				 IPCC_MPROC_SIGNAL_GLINK_QMP>;
> +
> +			label = "lpass";
> +			qcom,remote-pid = <2>;
> +
> +			gpr {
> +				compatible = "qcom,gpr";
> +				qcom,glink-channels = "adsp_apps";
> +				qcom,domain = <GPR_DOMAIN_ID_ADSP>;
> +				qcom,intents = <512 20>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				q6apm: service@1 {
> +					compatible = "qcom,q6apm";
> +					reg = <GPR_APM_MODULE_IID>;
> +					#sound-dai-cells = <0>;
> +
> +					q6apmdai: dais {
> +						compatible = "qcom,q6apm-dais";
> +						iommus = <&apps_smmu 0x1801 0x0>;
> +					};
> +
> +					q6apmbedai: bedais {
> +						compatible = "qcom,q6apm-lpass-dais";
> +						#sound-dai-cells = <1>;
> +					};
> +				};
> +
> +				q6prm: service@2 {
> +					compatible = "qcom,q6prm";
> +					reg = <GPR_PRM_MODULE_IID>;
> +
> +					q6prmcc: clock-controller {
> +						compatible = "qcom,q6prm-lpass-clocks";
> +						#clock-cells = <2>;
> +					};
> +				};
> +			};
> +		};
> +	};
>  };
