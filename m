Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A21656D11
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 17:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbiL0Qoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 11:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiL0QoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 11:44:23 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBCF1F0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 08:44:21 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id f34so20287507lfv.10
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 08:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iSSmBFbM1dUp8BQXcBkFZc09Iec6Jot4VF8P/JAzjNs=;
        b=My3fVk4mBdxNFOiuo6lKunblDZWH+qJb/tKHAYhhKW3tseNnkKmhK8NxZh7SdJZpBh
         ROpHhKnTIa4sD9yqzdBzUu6Kkyc/3sjLpVg1RSMF1c1pkBKjKnzKw0uShxW2vbYUHrPL
         Ft07vQU8wMndlMTZK4K3jLJbRQG6duiloSIVjBGN/XBLRm27Wu+Gtj8gTCJQOUBR+mUc
         mIex0oeTXjHw2fCq1nqKO42xdoWmDKOgcVSzGewCh8GpSm3urvZWJYNIsLJM7ajn/0fE
         FOsFVBs2opRlXB3KzRZnu3w62Vx1kWVBgpo8ves3fEHKAjjMJkRWzAcyPKHug/LqrsmY
         K7VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iSSmBFbM1dUp8BQXcBkFZc09Iec6Jot4VF8P/JAzjNs=;
        b=77nLfIYCE9AiE5nKrwoLwet9RdVj/hSMN498i1lYar5MnEgSeOkVrSX8ioOJMDzLrT
         dBeAUf93hVSTcdWqd6Bz25Q464a62lAbvVOmS/I6ZH5d7qszue36H8M7lyZJ+x0TEYlg
         ug9av44J8dDS6yn2rzcrV2Ijc41QA1XK3ZZ1lrmwtJUdtmZz4fRjcjn/6hj1oVRxgep9
         5xdYFzlTQuEK7SIetQR81C7hOYaQAcUcvydGRdsaYwGriMddv+f5JKJoDoMpX3xVeu8V
         LA8WGWn/un5gQQecbTiAD+maC6X0av84NDsC9xDRR6LEGtA0R0VjxFGYYLK8ZX757a7k
         xVTg==
X-Gm-Message-State: AFqh2kpwmjKWUL6qsSX9rFW+CmuT6JWf2eWaNa3OXKGD2zRonj/mc2JK
        xIWPUYFHhx9dlmeT+ME/hSDCXw==
X-Google-Smtp-Source: AMrXdXuP51u9ToggXenQtHR/wOO1q9WzWFUCfyKdDqoxRMrdeEj6807Innx1WbYqV4AwDQ0yBbx2mg==
X-Received: by 2002:a05:6512:1594:b0:4b5:6a20:ca90 with SMTP id bp20-20020a056512159400b004b56a20ca90mr7490685lfb.10.1672159459723;
        Tue, 27 Dec 2022 08:44:19 -0800 (PST)
Received: from [192.168.1.101] (abyl184.neoplus.adsl.tpnet.pl. [83.9.31.184])
        by smtp.gmail.com with ESMTPSA id d9-20020ac25ec9000000b00492ce573726sm2340358lfq.47.2022.12.27.08.44.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Dec 2022 08:44:19 -0800 (PST)
Message-ID: <dd119bf8-7477-4da7-dadf-d5d89397a01b@linaro.org>
Date:   Tue, 27 Dec 2022 17:44:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] arm64: dts: qcom: fix resin node duplication
Content-Language: en-US
To:     Dzmitry Sankouski <dsankouski@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <20221227163810.71121-1-dsankouski@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221227163810.71121-1-dsankouski@gmail.com>
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



On 27.12.2022 17:38, Dzmitry Sankouski wrote:
> resin node was moved to pm8998.dtsi file, and introduced duplication
> with other dts files, defining resin node.
> 
> Fixes: f86ae6f23a9e ("arm64: dts: qcom: sagit: add initial device tree for sagit")
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts       | 11 +++--------
>  .../boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi    | 11 +++--------
>  arch/arm64/boot/dts/qcom/sdm845-db845c.dts            | 11 +++--------
>  arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi        | 11 +++--------
>  arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts     | 11 +++--------
>  .../boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi | 11 +++--------
>  arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts    | 11 +++--------
>  7 files changed, 21 insertions(+), 56 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts b/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts
> index 310f7a2df1e8..510d12c8c512 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts
> @@ -364,14 +364,9 @@ cam_snapshot_pin_a: cam-snapshot-btn-active-state {
>  	};
>  };
>  
> -&pm8998_pon {
> -	resin {
> -		compatible = "qcom,pm8941-resin";
> -		interrupts = <GIC_SPI 0x8 1 IRQ_TYPE_EDGE_BOTH>;
> -		bias-pull-up;
> -		debounce = <15625>;
> -		linux,code = <KEY_VOLUMEDOWN>;
> -	};
> +&pm8998_resin {
> +	linux,code = <KEY_VOLUMEDOWN>;
> +	status = "okay";
>  };
>  
>  &qusb2phy {
> diff --git a/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
> index 5da87baa2b23..3bbd5df196bf 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
> @@ -357,14 +357,9 @@ vib_default: vib-en-state {
>  	};
>  };
>  
> -&pm8998_pon {
> -	resin {
> -		compatible = "qcom,pm8941-resin";
> -		interrupts = <GIC_SPI 0x8 1 IRQ_TYPE_EDGE_BOTH>;
> -		debounce = <15625>;
> -		bias-pull-up;
> -		linux,code = <KEY_VOLUMEUP>;
> -	};
> +&pm8998_resin {
> +	linux,code = <KEY_VOLUMEUP>;
> +	status = "okay";
>  };
>  
>  &qusb2phy {
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> index f41c6d600ea8..878801f540c5 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> @@ -615,14 +615,9 @@ vol_up_pin_a: vol-up-active-state {
>  	};
>  };
>  
> -&pm8998_pon {
> -	resin {
> -		compatible = "qcom,pm8941-resin";
> -		interrupts = <0x0 0x8 1 IRQ_TYPE_EDGE_BOTH>;
> -		debounce = <15625>;
> -		bias-pull-up;
> -		linux,code = <KEY_VOLUMEDOWN>;
> -	};
> +&pm8998_resin {
> +	linux,code = <KEY_VOLUMEDOWN>;
> +	status = "okay";
>  };
>  
>  &pmi8998_lpg {
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
> index 1eb423e4be24..943287804e1a 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
> @@ -482,14 +482,9 @@ &mss_pil {
>  	status = "okay";
>  };
>  
> -&pm8998_pon {
> -	resin {
> -		compatible = "qcom,pm8941-resin";
> -		interrupts = <0x0 0x8 1 IRQ_TYPE_EDGE_BOTH>;
> -		debounce = <15625>;
> -		bias-pull-up;
> -		linux,code = <KEY_VOLUMEDOWN>;
> -	};
> +&pm8998_resin {
> +	linux,code = <KEY_VOLUMEDOWN>;
> +	status = "okay";
>  };
>  
>  &sdhc_2 {
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
> index bb77ccfdc68c..e6191602c70a 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
> @@ -522,14 +522,9 @@ pinconf {
>  	};
>  };
>  
> -&pm8998_pon {
> -	volume_down_resin: resin {
> -		compatible = "qcom,pm8941-resin";
> -		interrupts = <0x0 0x8 1 IRQ_TYPE_EDGE_BOTH>;
> -		debounce = <15625>;
> -		bias-pull-up;
> -		linux,code = <KEY_VOLUMEDOWN>;
> -	};
> +&pm8998_resin {
> +	linux,code = <KEY_VOLUMEDOWN>;
> +	status = "okay";
>  };
>  
>  &pmi8998_lpg {
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
> index eb6b2b676eca..1b12b1a4dcbc 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
> @@ -325,14 +325,9 @@ &pmi8998_wled {
>  	qcom,cabc;
>  };
>  
> -&pm8998_pon {
> -	resin {
> -		compatible = "qcom,pm8941-resin";
> -		interrupts = <0x0 0x8 1 IRQ_TYPE_EDGE_BOTH>;
> -		debounce = <15625>;
> -		bias-pull-up;
> -		linux,code = <KEY_VOLUMEDOWN>;
> -	};
> +&pm8998_resin {
> +	linux,code = <KEY_VOLUMEDOWN>;
> +	status = "okay";
>  };
>  
>  &pmi8998_rradc {
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
> index 38ba809a95cd..fba229d0bd10 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
> @@ -530,14 +530,9 @@ pinconf {
>  	};
>  };
>  
> -&pm8998_pon {
> -	resin {
> -		interrupts = <0x0 0x8 1 IRQ_TYPE_EDGE_BOTH>;
> -		compatible = "qcom,pm8941-resin";
> -		linux,code = <KEY_VOLUMEDOWN>;
> -		debounce = <15625>;
> -		bias-pull-up;
> -	};
> +&pm8998_resin {
> +	linux,code = <KEY_VOLUMEDOWN>;
> +	status = "okay";
>  };
>  
>  &q6afedai {
