Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D066AF201
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 19:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233327AbjCGStc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 13:49:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233276AbjCGStK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 13:49:10 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB03BE5DA
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 10:37:40 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id s22so18311719lfi.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 10:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678214239;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QMmwYY2pGzkzSB5ytf8m0RJgBXPWAAa+gKUWc1OULJw=;
        b=so7LEuVRSsWNM9+euTAo1bxo7J/6iHbLQQVZwsXb5HDivVcmtfujaD+VwbqO1Fd41P
         k5IJQWX6zwHjUXKRR8ivCD8Rw3nGDI/lGZ16oq6Kkn45Xb2FddhsSUmbRJZFK1eRnrkY
         1RWLpG9RrHdN+k7lRgu+z/lfBG6CkysKPpTE6ggRQG5rWrA8hkgALMNiFe7oLomhpZN8
         hJtxgq7CFij8NBXXaJLlsl3P7WNIyMkJ00E6jtlY7/wSCkomHhvwdBT5TZeOkyCXMyJ+
         d+nwGSiHDnybScBRXK7OPLFytCrWEsa8J756WZQ1PGnnZHd4WMh6AffQ1nLriATV5417
         /Ycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678214239;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QMmwYY2pGzkzSB5ytf8m0RJgBXPWAAa+gKUWc1OULJw=;
        b=WE6m9MJizMPg3+kLLunV/F2u5wReHVtLDTY/3THe/UGy9WOIZ/K0fRq6KfDDSEvigO
         9nDMV0ZgMoz3MgpFAiWxRj3ndnS1K7NVI70Z8bPq06Jc5r2Qflmhxap++NOEJ0IbiHK7
         w6m/zQjA/w+yZgacLSRVAM8/A0NW3gXUE5Xxe+4iYMLUM5yE1UIDhGFNbCiZjPAgeIaM
         YRQ5XJzZR1ewhLt2ces8xo2RPc9bz7RwMNE+YenxSjySBn8u29MqU5qKWDjdzc7sI2is
         5U2aQA2UuXczBXRyWqRkrpIHpXhzqEEhO/hMTnFoY8WIQHGyx6Pn4t7TpeMkWmkqzec1
         KicQ==
X-Gm-Message-State: AO0yUKWDrUuzZD4r+/EtkG8mXZCFtGLKiymx2hlOf8CziOf4sBKvLshX
        3ow1BuNKcUHSgKJo6faHRQfyYA==
X-Google-Smtp-Source: AK7set+nOGQBW+k8K+d7jpihJIfCw0ggnA5E1cu3X+tgp+RVqS4IKjkohoMrigAYMnhAN5l2mSYvaA==
X-Received: by 2002:ac2:5106:0:b0:4df:c2bd:58e0 with SMTP id q6-20020ac25106000000b004dfc2bd58e0mr4264560lfb.59.1678214239278;
        Tue, 07 Mar 2023 10:37:19 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id m15-20020a056512014f00b004d34238ca44sm2093851lfo.214.2023.03.07.10.37.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 10:37:18 -0800 (PST)
Message-ID: <6897084a-79bd-809f-763e-6451034b40fa@linaro.org>
Date:   Tue, 7 Mar 2023 19:37:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] arm64: dts: qcom: sdm845-oneplus-common: add PN553 NFC
Content-Language: en-US
To:     Gergo Koteles <soyer@irl.hu>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org
References: <20230307183219.1643743-1-soyer@irl.hu>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230307183219.1643743-1-soyer@irl.hu>
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



On 7.03.2023 19:32, Gergo Koteles wrote:
> The OnePlus 6/6T both have a NQ330 (PN553 + P73N2M0).
> The PN533 supported by the nxp-nci-i2c driver in mainline.
> It detects/reads NFC tags using "nfctool".
> 
> Signed-off-by: Gergo Koteles <soyer@irl.hu>
> ---
>  .../boot/dts/qcom/sdm845-oneplus-common.dtsi  | 33 +++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
> index 64638ea94db7..4dfc9ade7596 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
> @@ -380,6 +380,25 @@ zap-shader {
>  	};
>  };
>  
> +&i2c3 {
> +	status = "okay";
> +	clock-frequency = <400000>;
status last

> +
> +	nfc@28 {
> +		compatible = "nxp,nxp-nci-i2c";
> +		reg = <0x28>;
> +
> +		interrupt-parent = <&tlmm>;
> +		interrupts = <63 IRQ_TYPE_EDGE_RISING>;
interrupts-extended = <&tlmm 63 IRQ_TYPE_EDGE_RISING>;
> +
> +		enable-gpios = <&tlmm 12 GPIO_ACTIVE_HIGH>;
> +		firmware-gpios = <&tlmm 62 GPIO_ACTIVE_HIGH>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&nfc_int_active &nfc_enable_active>;
property-n
property-names

> +	};
> +};
> +
>  &i2c10 {
>  	status = "okay";
>  	clock-frequency = <100000>;
> @@ -753,6 +772,20 @@ &usb_1_hsphy {
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
While it works as-is, I think adding a separate gpio node
for the firmware pin would make more sense logically.

Konrad
> +		pins = "gpio12", "gpio62";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-pull-up;
> +	};
> +
>  	tri_state_key_default: tri-state-key-default-state {
>  		pins = "gpio40", "gpio42", "gpio26";
>  		function = "gpio";
