Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B366AF4AF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 20:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjCGTSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 14:18:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233820AbjCGTSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 14:18:10 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244C8BCB85
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 11:02:04 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id s22so18394690lfi.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 11:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678215723;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JhAkzn/X0tQcRaS120MqIAqctrCtFwd7yVxmpVK8Ze8=;
        b=ugtRC0/JdfSlkOYQzMYd6ebNUrbAGDfDzM6Y9au0J9rak6KCP/2RNNMSHNOSmhBqzd
         RYMDrNiNTEIyrI71cvc5mZwHFETAjp4bi0rNU5XlKC/ZThEAIDFzTTLB37HQ0t5lsblo
         fgnpMeUIa7JgkuuCUfou+sVClFnuohVWxmiWD46fdcwEn7U2w3emuHB3vWEZYXrvsszG
         sM6HqW/FOMwKca9Nw2s83u4kYPg68n0xIIqKj0cwVqs2qurWc2k6OOBa8bkGh/fTYgDi
         msQQD3+oEThQ5/2ClmvqdaUVZmcJUXXTmFzRtbrIs8+TvDbqVYDRRaGqF2pRzhKABI9n
         RrEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678215723;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JhAkzn/X0tQcRaS120MqIAqctrCtFwd7yVxmpVK8Ze8=;
        b=Beywj4WPy29hjMxEXie/fIiSdncUAA6eOnAwL+gWbB0YVWuCZVizleftHaPoA20E4k
         66O5EV/e5kVaZ4Vy6CgbdjHtYUsFEjJdvaRNHMGYLnBF9v8qWEAdA4ZtSKHdqyOgU9qx
         1FoAosR9Md7uiu0VdVE1wk+OhCt+53boTqfQtBP1KrjKxTiMMo6/6skNb/ljzEYGHVbq
         hOl905v4gcu6IhBc8m+LeFGSYg2Hdz317lvn2pjM2/yNEToNx+JPNZN07OhIMv4l2lJU
         4MirLwp0tQCp1s2PveA+0dn0jDfZqOGhYCd6V7Ixcwxwp+06QfrnPTKlISKw5cXM0QF6
         PF7Q==
X-Gm-Message-State: AO0yUKV37suEliOaEW79AVwmdgXp3q0dVBfitryxJoQMVeUhqxVTglMV
        wM4K0WyjqO5GLG1CuuFk6X0Thg==
X-Google-Smtp-Source: AK7set+ZzCxPUtbFFjgd3Rb9oHP7ljagwX06FHJ57hiAloezLWgC1gkWLmtpQOAaDqcc08spLC2xcA==
X-Received: by 2002:a19:7610:0:b0:4dd:a98b:ae4c with SMTP id c16-20020a197610000000b004dda98bae4cmr3954215lff.14.1678215722993;
        Tue, 07 Mar 2023 11:02:02 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id l8-20020a19c208000000b004db3890cb53sm2119733lfc.223.2023.03.07.11.02.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 11:02:02 -0800 (PST)
Message-ID: <22b91a6c-7a27-039c-21b8-0d3913e73dbc@linaro.org>
Date:   Tue, 7 Mar 2023 20:02:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] arm64: dts: qcom: sdm845-oneplus-common: add PN553 NFC
Content-Language: en-US
To:     Gergo Koteles <soyer@irl.hu>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org
References: <20230307185942.1737867-1-soyer@irl.hu>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230307185942.1737867-1-soyer@irl.hu>
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



On 7.03.2023 19:59, Gergo Koteles wrote:
> The OnePlus 6/6T both have a NQ330 (PN553 + P73N2M0).
> The PN533 supported by the nxp-nci-i2c driver in mainline.
> It detects/reads NFC tags using "nfctool".
> 
> Signed-off-by: Gergo Koteles <soyer@irl.hu>
> ---
Next time include a changelog below this --- line detailing
what changed between revisions.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  .../boot/dts/qcom/sdm845-oneplus-common.dtsi  | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
> index 64638ea94db7..5e45801031d8 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
> @@ -380,6 +380,24 @@ zap-shader {
>  	};
>  };
>  
> +&i2c3 {
> +	clock-frequency = <400000>;
> +	status = "okay";
> +
> +	nfc@28 {
> +		compatible = "nxp,nxp-nci-i2c";
> +		reg = <0x28>;
> +
> +		interrupts-extended = <&tlmm 63 IRQ_TYPE_EDGE_RISING>;
> +
> +		enable-gpios = <&tlmm 12 GPIO_ACTIVE_HIGH>;
> +		firmware-gpios = <&tlmm 62 GPIO_ACTIVE_HIGH>;
> +
> +		pinctrl-0 = <&nfc_int_active &nfc_enable_active &nfc_firmware_active>;
> +		pinctrl-names = "default";
> +	};
> +};
> +
>  &i2c10 {
>  	status = "okay";
>  	clock-frequency = <100000>;
> @@ -753,6 +771,27 @@ &usb_1_hsphy {
>  &tlmm {
>  	gpio-reserved-ranges = <0 4>, <81 4>;
>  
> +	nfc_int_active: nfc-int-active-state {
> +		pins = "gpio63";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-pull-up;
> +	};
> +
> +	nfc_enable_active: nfc-enable-active-state {
> +		pins = "gpio12";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-pull-up;
> +	};
> +
> +	nfc_firmware_active: nfc-firmware-active-state {
> +		pins = "gpio62";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-pull-up;
> +	};
> +
>  	tri_state_key_default: tri-state-key-default-state {
>  		pins = "gpio40", "gpio42", "gpio26";
>  		function = "gpio";
