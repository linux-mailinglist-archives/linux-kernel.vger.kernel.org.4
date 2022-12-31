Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D0965A3D5
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 12:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbiLaLxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 06:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbiLaLxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 06:53:33 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52464BC3A
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 03:53:32 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id bt23so18363388lfb.5
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 03:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NkJmVYb2dSqPK/T7xVy4KTErmNKrOgLp0utmNWQPWi4=;
        b=wfl3JVQ8n+sNbLjY5/+fsKauppg5jNdt+0eo+HuO7p5iJatGrznD3OSXqOemUl33eJ
         EWJdfEeDGcw6gApvR3DA3/RR2yG3/xbAQOPvswgF+tJ4riqZ29uA4TWm0rCrceL1Rlnc
         ZmRJQ4qdiGnd6ZpOuMtliniD60yy8QGSqyzB7zcZJnZactp/TGmHxalQ9d2wNePYcF+w
         jHIwxZ0nRHgAtbjX/LBGG+3CuG1lyOPSlWTZaYH01E+mv6mwp+PnOAio7svBKOJeH27r
         OIvAwr3cW3AOuC5Z6x6DnuJPLUglCRY119NVH7SJXgx2GE6wTKe4AXCQVJPqxSlFQH0h
         O7KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NkJmVYb2dSqPK/T7xVy4KTErmNKrOgLp0utmNWQPWi4=;
        b=1/NzjwF7xrTuL6k6kcs+XS3rVYAy3oheKoRZetdg02kMnEajBRMoxjf86MQ3Hpfnti
         8DS6Ix/AQmRQvk3/4w8t2IMkxnmx0dLEipXv/kNOaHXARiD3Gt8KvDfmQCpoPkc9vFLG
         L9wq2NfwQrBJDv3y7pVdY3ZIX/PlmDe1RUrI6DS/HUI7oXe9Tf552RQcliNcbp9fotk1
         11/mVGUpxKUthDpQXAOh8d0SZN0xawD8aJedijQaz8IaOuv1Jahite0/NOhO0y48RW5w
         41KLNYgVroWh32zHr362Kl3EYRzagXfVaUWBgxulLR0nvsx9e1bh2Vhc59detrqr1MAS
         APdA==
X-Gm-Message-State: AFqh2kq/KtFAriVSH46658Nh4WwsXjoQqPrLVUWRwXjMa8ELNHJP+QUU
        MYtIRSUbLzosbrkQHCkUpCWFMQ==
X-Google-Smtp-Source: AMrXdXsqhfCs5oCPwHv1Q86YNRQTjtDZEtkD9c8AvGEnqihG5mKAUmdDltHhuIVNKFWorwu+H8ipHA==
X-Received: by 2002:ac2:50d9:0:b0:4cb:2c19:ec21 with SMTP id h25-20020ac250d9000000b004cb2c19ec21mr1098080lfm.0.1672487610585;
        Sat, 31 Dec 2022 03:53:30 -0800 (PST)
Received: from [192.168.1.101] (abyl184.neoplus.adsl.tpnet.pl. [83.9.31.184])
        by smtp.gmail.com with ESMTPSA id c8-20020a056512324800b00499aefcf68esm3851977lfr.292.2022.12.31.03.53.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Dec 2022 03:53:30 -0800 (PST)
Message-ID: <398531b5-d556-00c8-3998-0120aadb3143@linaro.org>
Date:   Sat, 31 Dec 2022 12:53:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/2] arm64: dts: qcom: use qcom,gsi-loader for IPA
Content-Language: en-US
To:     Alex Elder <elder@linaro.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, andersson@kernel.org,
        agross@kernel.org
Cc:     caleb.connolly@linaro.org, mka@chromium.org, evgreen@chromium.org,
        quic_cpratapa@quicinc.com, quic_avuyyuru@quicinc.com,
        quic_jponduru@quicinc.com, quic_subashab@quicinc.com,
        elder@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221231002716.2367375-1-elder@linaro.org>
 <20221231002716.2367375-3-elder@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221231002716.2367375-3-elder@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31.12.2022 01:27, Alex Elder wrote:
> Depending on the platform, either the modem or the AP must load GSI
> firmware for IPA before it can be used.  To date, this has been
> indicated by the presence or absence of a "modem-init" property.
> 
> That mechanism has been deprecated.  Instead, we indicate how GSI
> firmware should be loaded by the value of the "qcom,gsi-loader"
> property.
> 
> Update all arm64 platforms that use IPA to use the "qcom,gsi-loader"
> property to specify how the GSI firmware is loaded.
> 
> Update the affected nodes so the status property is last.
> 
> Signed-off-by: Alex Elder <elder@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-lte-sku.dtsi         | 5 ++---
>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi                     | 2 +-
>  arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi                   | 2 +-
>  arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi                   | 2 +-
>  arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi               | 2 +-
>  arch/arm64/boot/dts/qcom/sdm845-mtp.dts                      | 3 ++-
>  arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi          | 4 ++--
>  arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts            | 4 ++--
>  arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi | 3 ++-
>  arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts           | 1 +
>  arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts         | 3 ++-
>  arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts             | 3 ++-
>  arch/arm64/boot/dts/qcom/sm8350-microsoft-surface-duo2.dts   | 4 ++--
>  arch/arm64/boot/dts/qcom/sm8350-mtp.dts                      | 4 ++--
>  arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi      | 3 ++-
>  15 files changed, 25 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lte-sku.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lte-sku.dtsi
> index fd4b712037542..bffcbd141bd7c 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lte-sku.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lte-sku.dtsi
> @@ -19,12 +19,11 @@ &remoteproc_mpss {
>  };
>  
>  &ipa {
> -	status = "okay";
> -
>  	/*
>  	 * Trogdor doesn't have QHEE (Qualcomm's EL2 blob), so the
>  	 * modem needs to cover certain init steps (GSI init), and
>  	 * the AP needs to wait for it.
>  	 */
> -	modem-init;
> +	qcom,gsi-loader = "modem";
> +	status = "okay";
>  };
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> index f7efb9966afd1..5ad97cd5f1b75 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> @@ -377,8 +377,8 @@ &gpi_dma1 {
>  };
>  
>  &ipa {
> +	qcom,gsi-loader = "modem";
>  	status = "okay";
> -	modem-init;
>  };
>  
>  &lpass_cpu {
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
> index df49564ae6dc1..6d80c64097e97 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
> @@ -337,8 +337,8 @@ vreg_bob: bob {
>  /* ADDITIONS TO NODES DEFINED IN PARENT DEVICE TREE FILES */
>  
>  &ipa {
> +	qcom,gsi-loader = "modem";
>  	status = "okay";
> -	modem-init;
>  };
>  
>  &lpass_va_macro {
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
> index ca676e04687b0..c194a88f91fd1 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
> @@ -756,8 +756,8 @@ &gpu {
>  };
>  
>  &ipa {
> +	qcom,gsi-loader = "modem";
>  	status = "okay";
> -	modem-init;
>  };
>  
>  &lpasscc {
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
> index 1eb423e4be24c..b62beffc27bf7 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
> @@ -474,8 +474,8 @@ zap-shader {
>  };
>  
>  &ipa {
> +	qcom,gsi-loader = "modem";
>  	status = "okay";
> -	modem-init;
>  };
>  
>  &mss_pil {
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> index de2d10e0315af..f5a186fd7c72b 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> @@ -518,8 +518,9 @@ &i2c10 {
>  };
>  
>  &ipa {
> -	status = "okay";
> +	qcom,gsi-loader = "self";
>  	memory-region = <&ipa_fw_mem>;
> +	status = "okay";
>  };
>  
>  &mdss {
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
> index 42cf4dd5ea284..d8a601d36c6df 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
> @@ -424,10 +424,10 @@ rmi4_f12: rmi4-f12@12 {
>  };
>  
>  &ipa {
> -	status = "okay";
> -
> +	qcom,gsi-loader = "self";
>  	memory-region = <&ipa_fw_mem>;
>  	firmware-name = "qcom/sdm845/oneplus6/ipa_fws.mbn";
> +	status = "okay";
>  };
>  
>  &mdss {
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
> index bb77ccfdc68c0..fcd401f460456 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
> @@ -495,10 +495,10 @@ touchscreen@38 {
>  };
>  
>  &ipa {
> -	status = "okay";
> -
> +	qcom,gsi-loader = "self";
>  	memory-region = <&ipa_fw_mem>;
>  	firmware-name = "qcom/sdm845/axolotl/ipa_fws.mbn";
> +	status = "okay";
>  };
>  
>  &mdss {
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
> index eb6b2b676eca4..d6b11d56ebb37 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
> @@ -299,9 +299,10 @@ &mss_pil {
>  };
>  
>  &ipa {
> -	status = "okay";
> +	qcom,gsi-loader = "self";
>  	memory-region = <&ipa_fw_mem>;
>  	firmware-name = "qcom/sdm845/beryllium/ipa_fws.mbn";
> +	status = "okay";
>  };
>  
>  &pm8998_gpio {
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
> index 38ba809a95cd6..9ca4682aea1b2 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
> @@ -449,6 +449,7 @@ &ibb {
>  };
>  
>  &ipa {
> +	qcom,gsi-loader = "self";
>  	memory-region = <&ipa_fw_mem>;
>  	firmware-name = "qcom/sdm845/polaris/ipa_fws.mbn";
>  	status = "okay";
> diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> index f32b7445f7c96..15da94808b21d 100644
> --- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> @@ -465,8 +465,9 @@ ecsh: hid@5c {
>  };
>  
>  &ipa {
> -	status = "okay";
> +	qcom,gsi-loader = "self";
>  	memory-region = <&ipa_fw_mem>;
> +	status = "okay";
>  };
>  
>  &mdss {
> diff --git a/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts b/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
> index daca1e0ad62ad..15f6059b75757 100644
> --- a/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
> @@ -383,9 +383,10 @@ digitizer@9 {
>  };
>  
>  &ipa {
> -	status = "okay";
> +	qcom,gsi-loader = "self";
>  	memory-region = <&ipa_fw_mem>;
>  	firmware-name = "qcom/sdm850/samsung/w737/ipa_fws.elf";
> +	status = "okay";
>  };
>  
>  /* No idea why it causes an SError when enabled */
> diff --git a/arch/arm64/boot/dts/qcom/sm8350-microsoft-surface-duo2.dts b/arch/arm64/boot/dts/qcom/sm8350-microsoft-surface-duo2.dts
> index 9c4cfd995ff29..00f16cde6c4ac 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350-microsoft-surface-duo2.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8350-microsoft-surface-duo2.dts
> @@ -290,9 +290,9 @@ &i2c11 {
>  };
>  
>  &ipa {
> -	status = "okay";
> -
> +	qcom,gsi-loader = "self";
>  	memory-region = <&pil_ipa_fw_mem>;
> +	status = "okay";
>  };
>  
>  &mpss {
> diff --git a/arch/arm64/boot/dts/qcom/sm8350-mtp.dts b/arch/arm64/boot/dts/qcom/sm8350-mtp.dts
> index 52cf3045602f9..f70e0de0509c5 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8350-mtp.dts
> @@ -376,7 +376,7 @@ &usb_2_qmpphy {
>  };
>  
>  &ipa {
> -	status = "okay";
> -
> +	qcom,gsi-loader = "self";
>  	memory-region = <&pil_ipa_fw_mem>;
> +	status = "okay";
>  };
> diff --git a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
> index 1f2d660f8f86c..d00e8d922ceeb 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
> @@ -524,9 +524,10 @@ &i2c17 {
>  };
>  
>  &ipa {
> -	status = "okay";
> +	qcom,gsi-loader = "self";
>  	memory-region = <&pil_ipa_fw_mem>;
>  	firmware-name = "qcom/sm8350/Sony/sagami/ipa_fws.mbn";
> +	status = "okay";
>  };
>  
>  &mpss {
