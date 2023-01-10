Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B2B663F09
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 12:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbjAJLKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 06:10:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238357AbjAJLIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 06:08:52 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCCA45642
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 03:08:09 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id l26so8491539wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 03:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FNeXgKnEbLZaArQRftAzM3xIXiNgl2iUGd6733GbOj0=;
        b=MmLkHE2yVceezpoQ1aaNKn7d8ZTKwLVGinX9/nfAVSh5uvfSd+Pef+a0i1YSdpKjHI
         KG4Ub6G9AbsK+8oU7yp8TX1iZvJCzzIoQqxI3EbtJTW/z9S3z8bttdyZrHHteiIOMq+Q
         5AmfchTISh2ieCR6Ht5CqUlAYoK55y4NorO4ih+EvBqeNMLJnjbXemiUBbIHPIyN+VmO
         ptjB0OHZ4nHKwEzn+th+f0YMa/9Opwx0y/jHHbagoFOyKolCFqj00MpD/DmDKY+uytGN
         5IWsr9E9qclJumbAfv6Msa03c4ghUFMfcsaBoRGZIAasEYZAodgx5BNAMeq5zWF4weBu
         j9Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FNeXgKnEbLZaArQRftAzM3xIXiNgl2iUGd6733GbOj0=;
        b=pRQiSz9sslO59KnIflZEhA2dBZUstHYCDJVyMi9NGLsRQCiQsxR+LucDYTLh/YhL5m
         1K5LjvsF0duJhwjlaYFWsUDW4qe/VHg5/RB/3HrSpnWAhA5ArpupSdVAfmicN1W2Fl+D
         12Ra1QvkRiU6M3ACY8Kj9LTCfqZC69NSzch7qn7tvEhlpFkJtl6F17+vhcBzpR+/6rG9
         ZUjsyKXZo2BXoOtmpjHfHmVSMeqBd32CoKJMU9tNmOJAnCPRMATTh6Oq8S2xKxWn7B/3
         LqG5yo6HTKalVg+VoybJU4BUYt0Ae5cNbCp+HPLbo/Tsff7huhtUKIly+s2SxHzwltvn
         31Zg==
X-Gm-Message-State: AFqh2kpJxCYK5+aS3Q3IKTpuh9ADlf/cSD+X8um8W+dPtO+7IYjApVXS
        hn/PLxwPRJXDPdmnJSEPF3fRjw==
X-Google-Smtp-Source: AMrXdXt+uWAPTwOuu8nqh+Vyyvqd94lH9EYTp/akqONNCrL0L7vqsSAPKLeUuvXGzgvBtO45LZGkZA==
X-Received: by 2002:a7b:c851:0:b0:3d9:f067:1c32 with SMTP id c17-20020a7bc851000000b003d9f0671c32mr4690647wml.29.1673348888039;
        Tue, 10 Jan 2023 03:08:08 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id o21-20020a1c7515000000b003d995a704fdsm14432787wmc.33.2023.01.10.03.08.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 03:08:07 -0800 (PST)
Message-ID: <bc44d4fe-9ffc-0270-1c74-e6190ea063f2@linaro.org>
Date:   Tue, 10 Jan 2023 12:08:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 3/8] arm64: dts: qcom: sc7280: audioreach: Add lpass
 pil node
Content-Language: en-US
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_rohkumar@quicinc.com, srinivas.kandagatla@linaro.org,
        dianders@chromium.org, swboyd@chromium.org, judyhsiao@chromium.org,
        konrad.dybcio@linaro.org, mka@chromium.org
References: <1672925875-2107-1-git-send-email-quic_srivasam@quicinc.com>
 <1672925875-2107-4-git-send-email-quic_srivasam@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1672925875-2107-4-git-send-email-quic_srivasam@quicinc.com>
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
> Add lpass pil node for sc7280 based audioreach platforms.

LPASS PIL - these are acronyms.
> 

Subject: drop "audioreach" from every patch. Not a directory.

Both comments apply to all your patches.

> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Tested-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>

Your patchset (with dependency) does not apply. Please rebase.

> ---
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 90 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 90 insertions(+)

There are several dtbs_check warnings:

/home/krzk/dev/linux/linux/out/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1-lte.dtb:
sound: '#sound-dai-cells', 'qcom,msm-mbhc-gnd-swh',
'qcom,msm-mbhc-hphl-swh' do not match any of the regexes:
'^dai-link@[0-9a-f]$', 'pinctrl-[0-9]+'
	From schema:
/home/krzk/dev/linux/linux/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml
/home/krzk/dev/linux/linux/out/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dtb:
sound: dai-link@0: 'platform' does not match any of the regexes:
'pinctrl-[0-9]+'
	From schema:
/home/krzk/dev/linux/linux/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml
/home/krzk/dev/linux/linux/out/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dtb:
sound: dai-link@1: 'platform' does not match any of the regexes:
'pinctrl-[0-9]+'
	From schema:
/home/krzk/dev/linux/linux/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml
/home/krzk/dev/linux/linux/out/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dtb:
sound: dai-link@2: 'platform' does not match any of the regexes:
'pinctrl-[0-9]+'
	From schema:
/home/krzk/dev/linux/linux/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml
/home/krzk/dev/linux/linux/out/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dtb:
sound: dai-link@3: 'platform' does not match any of the regexes:
'pinctrl-[0-9]+'
	From schema:
/home/krzk/dev/linux/linux/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml
/home/krzk/dev/linux/linux/out/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dtb:
sound: '#sound-dai-cells', 'adsp-mode', 'qcom,msm-mbhc-gnd-swh',
'qcom,msm-mbhc-hphl-swh' do not match any of the regexes:
'^dai-link@[0-9a-f]$', 'pinctrl-[0-9]+'
	From schema:
/home/krzk/dev/linux/linux/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml
/home/krzk/dev/linux/linux/out/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dtb:
sound: '#sound-dai-cells', 'qcom,msm-mbhc-gnd-swh',
'qcom,msm-mbhc-hphl-swh' do not match any of the regexes:
'^dai-link@[0-9a-f]$', 'pinctrl-[0-9]+'
	From schema:
/home/krzk/dev/linux/linux/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml
/home/krzk/dev/linux/linux/out/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dtb:
sound: '#sound-dai-cells', 'qcom,msm-mbhc-gnd-swh',
'qcom,msm-mbhc-hphl-swh' do not match any of the regexes:
'^dai-link@[0-9a-f]$', 'pinctrl-[0-9]+'
	From schema:
/home/krzk/dev/linux/linux/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml
make[1]: Leaving directory '/home/krzk/dev/linux/linux/out'


/home/krzk/dev/linux/linux/out/arch/arm64/boot/dts/qcom/sc7280-idp.dtb:
remoteproc@3000000: qcom,halt-regs:0: [228] is too short
	From schema:
/home/krzk/dev/linux/linux/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-adsp-pil.yaml
/home/krzk/dev/linux/linux/out/arch/arm64/boot/dts/qcom/sc7280-idp.dtb:
remoteproc@3000000: glink-edge:gpr: 'q6apm', 'q6prm' do not match any of
the regexes: '^service@[1-9a-d]$', 'pinctrl-[0-9]+'
	From schema:
/home/krzk/dev/linux/linux/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-adsp-pil.yaml
/home/krzk/dev/linux/linux/out/arch/arm64/boot/dts/qcom/sc7280-idp.dtb:
remoteproc@3000000: 'power-domain-names', 'reg-names', 'required-opps'
do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema:
/home/krzk/dev/linux/linux/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-adsp-pil.yaml


> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 0adf133..f10a663 100644
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
> @@ -3436,6 +3438,94 @@
>  			status = "disabled";
>  		};
>  
> +		remoteproc_adsp: remoteproc@3000000 {
> +			compatible = "qcom,sc7280-adsp-pil";
> +			reg = <0 0x03000000 0 0x5000>, <0 0x0355b000 0 0x10>;
> +			reg-names = "qdsp6ss_base", "lpass_efuse";
> +
> +			interrupts-extended = <&pdc 6 IRQ_TYPE_LEVEL_HIGH>,
> +					      <&adsp_smp2p_in 0 IRQ_TYPE_NONE>,
> +					      <&adsp_smp2p_in 1 IRQ_TYPE_NONE>,
> +					      <&adsp_smp2p_in 2 IRQ_TYPE_NONE>,
> +					      <&adsp_smp2p_in 3 IRQ_TYPE_NONE>,
> +					      <&adsp_smp2p_in 7 IRQ_TYPE_NONE>;
> +
> +			interrupt-names = "wdog", "fatal", "ready",
> +				"handover", "stop-ack",  "shutdown-ack";
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
> +
> +			required-opps = <&rpmhpd_opp_nom>;
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
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +					qcom,intents = <512 20>;
> +
> +					q6apm: q6apm {

This is for sure wrong. Please send your code based on newest
submissions. Do not start work on some old DTS full of issues, but the
new one with corrected.

You also did not run automated tools which would point all this out -
wrong name, missing unit address (you have address-cells above, right?)

> +						reg = <GPR_APM_MODULE_IID>;
> +						compatible = "qcom,q6apm";
> +						#sound-dai-cells = <0>;

Blank line

> +						q6apmdai: dais {
> +							compatible = "qcom,q6apm-dais";
> +							#sound-dai-cells = <1>;
> +							iommus = <&apps_smmu 0x1801 0x0>;
> +						};
> +
> +						q6apmbedai: bedais {
> +							compatible = "qcom,q6apm-lpass-dais";
> +							#sound-dai-cells = <1>;
> +						};
> +					};
> +
> +					q6prm: q6prm {
> +						reg = <GPR_PRM_MODULE_IID>;
> +						compatible = "qcom,q6prm";
> +						#clock-cells = <2>;
> +						q6prmcc: cc {
> +							compatible = "qcom,q6prm-lpass-clocks";
> +							#clock-cells = <2>;
> +						};
> +					};
> +				};
> +			};
> +		};
> +
>  		remoteproc_wpss: remoteproc@8a00000 {
>  			compatible = "qcom,sc7280-wpss-pil";
>  			reg = <0 0x08a00000 0 0x10000>;

Best regards,
Krzysztof

