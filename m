Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC875F1349
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 22:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbiI3UK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 16:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232440AbiI3UKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 16:10:15 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2786956B5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 13:10:08 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id a2so8478276lfb.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 13:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=hE8hq9/oLZg/ugxnoeYHfAR8kWWIKnShL8VjClO7B7I=;
        b=DuMu+EWxt+qrp1kO50KmiVaZQMD9bUbDEsSzHHIZ4XfHkzDPh4MpbgnYLclNsoDlXM
         qsvCENlGRug7bN4oJJ/Rd0V3L5njIGmXcDnTe95tcK2n9hvv30yRL4lwSkC8gxPgzdK5
         bHYhYCod5Wr8XUezmzTOdIuB20kiHvE07z4S9waabgBKRqqCPed0v1/hsFOkO5oYj2Lh
         GxkXz0aPr4OwUWwEVckjQ1gGs/rJOtB+Nh+TqsiOSqd4PbCfxDULwFa/MWmpKql2bHyk
         yebNk9/vI0NDIAPowHBvJUaGPjHhaJGmAUjA8r9CqTEiSJKfOMCqHTMr4vxabH86A1Fu
         ohJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=hE8hq9/oLZg/ugxnoeYHfAR8kWWIKnShL8VjClO7B7I=;
        b=5bgkGHfB45YiL0M9N7fXj2AYqh7gxEC4DgKwsksDaLKPfKpFkVxS7B0wXTLnPZNrEk
         5bxCCNkLi+YG0A69ZHUXPwMsu0GoNU4Z9SWbPMfLmGZags8ho1W0BgmOeaKqJ1xfYswL
         25GhkQOah17kjRM9C81v8KVoV5g5j4t37riRFc1aWRU6VNrvw8FVkfIcq4G8A3EM+LmZ
         yLFpxLMD5HKNw7+Zec8FDiqTPolaNLpSLhPUBSpNGm8yxUc6sCruoEi9ipfzg+F8GaVo
         4nZWyB6W6AalSu/5zlCv6gC0MyyvRAOXHpXNmkSsVMgO69OKjk7Hw3jfRvyZrlNBc8Ic
         VIiA==
X-Gm-Message-State: ACrzQf0f0FOpWjqZx0i8a7QFhWRViqwnA09Mbxv0/cMtHERbbLAsIsk8
        n3N7hYGArI7KuCB1huTzjDarUGaUXC2rnA==
X-Google-Smtp-Source: AMsMyM5YYdLv0LT1uNUtMJjvydPi69ku740a5F2lsvIJWjlm2LdThGqv1mknp35IVYVQERXV1zNuFQ==
X-Received: by 2002:a05:6512:e9e:b0:4a2:1503:c2e7 with SMTP id bi30-20020a0565120e9e00b004a21503c2e7mr1440195lfb.476.1664568606633;
        Fri, 30 Sep 2022 13:10:06 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id q3-20020a0565123a8300b004a03d5c2140sm408295lfu.136.2022.09.30.13.10.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 13:10:06 -0700 (PDT)
Message-ID: <2c1c5d8a-fb7f-bc98-ed6b-021eb00f990f@linaro.org>
Date:   Fri, 30 Sep 2022 22:10:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 1/8] arm64: dts: qcom: sdm845-tama: Add display nodes
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220930191049.123256-1-konrad.dybcio@somainline.org>
 <20220930191049.123256-2-konrad.dybcio@somainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220930191049.123256-2-konrad.dybcio@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/09/2022 21:10, Konrad Dybcio wrote:
> Add required nodes to support display on XZ2/XZ2c. XZ3 has a
> different power rail setup and needs to be handled separately.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
>  .../qcom/sdm845-sony-xperia-tama-akari.dts    |  4 +
>  .../qcom/sdm845-sony-xperia-tama-akatsuki.dts | 44 ++++++++-
>  .../qcom/sdm845-sony-xperia-tama-apollo.dts   |  6 ++
>  .../dts/qcom/sdm845-sony-xperia-tama.dtsi     | 96 +++++++++++++++++++
>  4 files changed, 149 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akari.dts b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akari.dts
> index 34f84f1f1eb4..d97b7f1e7140 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akari.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akari.dts
> @@ -11,3 +11,7 @@ / {
>  	model = "Sony Xperia XZ2";
>  	compatible = "sony,akari-row", "qcom,sdm845";
>  };
> +
> +&panel {
> +	compatible = "sony,td4353-jdi-tama";

git grep suggests it is not documented. Is it coming via different patchset?

> +};
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akatsuki.dts b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akatsuki.dts
> index 2f5e12deaada..2a16305ac5da 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akatsuki.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akatsuki.dts
> @@ -10,9 +10,51 @@
>  / {
>  	model = "Sony Xperia XZ3";
>  	compatible = "sony,akatsuki-row", "qcom,sdm845";
> +
> +	/* Fixed DCDC for the OLED panel */
> +	ts_vddio_supply: ts-vddio-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "ts_vddio";
> +
> +		regulator-min-microvolt = <1840000>;
> +		regulator-max-microvolt = <1840000>;
> +
> +		gpio = <&tlmm 133 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		regulator-boot-on;
> +	};
> +};
> +
> +&ibb {
> +	status = "disabled";
> +};
> +
> +&lab {
> +	status = "disabled";
> +};
> +
> +&panel {
> +	/* Akatsuki uses an OLED panel. */
> +	/delete-property/ backlight;
> +	/delete-property/ vsp-supply;
> +	/delete-property/ vsn-supply;
> +	/delete-property/ treset-gpios;
> +};
> +
> +&pmi8998_wled {
> +	status = "disabled";
> +};
> +
> +&tlmm {
> +	ts_vddio_en: ts-vddio-en {

ts-vddio-en-state

DT schema is coming:
https://lore.kernel.org/linux-devicetree/20220930200529.331223-1-krzysztof.kozlowski@linaro.org/T/#t

> +		pins = "gpio133";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +		output-high;
> +	};

Best regards,
Krzysztof

