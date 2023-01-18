Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D31D671F14
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjAROJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:09:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbjAROJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:09:03 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA99654DA
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 05:50:03 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id mp20so36780261ejc.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 05:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G05wduJRdCzsbUdyzAteXIlTvf9uW/zufG8M+iMIX3U=;
        b=a05iRmPG9JIaF65ZM9hOFu9ZjZJVxSt/IoTCk+wZUiS86mEK/ILyTvJvnVTYQnDnaN
         iB44YpZdYqegBktvsPsn9dotAbt/20Px4KBm1UsfDlLY1AG41wELlpg0VN24BJp4z1LT
         vHeHdVgjg9dF0m1S/55aFYzoeE43tDwwPh749PelLvGWM+sf4tPsFHbl86+FRtuEOCHO
         ztSdEG0XJsxxBiHyHa0t1tsx/BbaVA8LJqOOOb1ushaPuSOHEEaVZFiAqIZDTkutoWGm
         oXg/j5AG9DrWhdBpN1ALCMdzBkRIF2K65oFNhjX5Do/l15zn+6remwyfYkGhOTk7cffi
         UPQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G05wduJRdCzsbUdyzAteXIlTvf9uW/zufG8M+iMIX3U=;
        b=T2GLuY8O+VfRNO3wUnn3CGppFWmnohPx9lUke8b/1ROn4xE0bgV9WCJNLQHtHPbpuK
         EAInv5wc8fjJNkxeXs7vHI3KguEHorWFc7z78eM4W3iXxA3ShBMtxOJnK7oR3XEnmQGH
         TTLTzUrqoePhlV2HqLdWFmTCS87wQIgF51TI+exciT99YfSaNlFplrxq+ySPPIk3TtDi
         ikY2Uwps+xDfS+cWQRsHdfosXCRlA4cCNP2o5IMUE6HLcAJ7tVJFMLdHKrQRfwJpcYr7
         NpQsaYfBj0StAfaBdoy4A7sdUkQqx8A5Drr+U5s6oBA2FGoiIu8WeZviIYVpuJtWmTc/
         A1ew==
X-Gm-Message-State: AFqh2krgXRTfzdvIGSKb63S1voRTwdNJTY0KfNVjQSOkE0XZOBb7ibh+
        8UhBU4QDNa1T/T5ieKzFU53Nzw==
X-Google-Smtp-Source: AMrXdXu9TbY+2mUcb8T41dwKNwp9Qz+AjvGZhwYnJh2pZThYE9pgpRfumKqnndR/Luqg++r+NVYZCg==
X-Received: by 2002:a17:906:4094:b0:854:956:1438 with SMTP id u20-20020a170906409400b0085409561438mr7476861ejj.25.1674049802063;
        Wed, 18 Jan 2023 05:50:02 -0800 (PST)
Received: from [192.168.1.101] (abxh252.neoplus.adsl.tpnet.pl. [83.9.1.252])
        by smtp.gmail.com with ESMTPSA id g13-20020a170906538d00b0085a958808c6sm10035517ejo.7.2023.01.18.05.49.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 05:50:01 -0800 (PST)
Message-ID: <cc1e0d0e-c678-ed5d-8874-418e43272f96@linaro.org>
Date:   Wed, 18 Jan 2023 14:49:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 6/8] arm64: dts: qcom: Add msm8939-pm8916.dtsi include
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, agross@kernel.org,
        andersson@kernel.org, djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        benl@squareup.com, shawn.guo@linaro.org, fabien.parent@linaro.org,
        leo.yan@linaro.org, dmitry.baryshkov@linaro.org,
        Stephan Gerhold <stephan@gerhold.net>
References: <20230117024846.1367794-1-bryan.odonoghue@linaro.org>
 <20230117024846.1367794-7-bryan.odonoghue@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230117024846.1367794-7-bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17.01.2023 03:48, Bryan O'Donoghue wrote:
> From: Stephan Gerhold <stephan@gerhold.net>
> 
> The msm8939-pm8916.dtsi include configures the regulator supplies of
> MSM8939 used together with PM8916, as recommended by Qualcomm. In rare
> cases where boards deviate from the recommended design they can just
> avoid using this include.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/msm8939-pm8916.dtsi | 82 ++++++++++++++++++++
>  1 file changed, 82 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8939-pm8916.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8939-pm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8939-pm8916.dtsi
> new file mode 100644
> index 0000000000000..18a1b3cca01d6
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8939-pm8916.dtsi
> @@ -0,0 +1,82 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include "msm8939.dtsi"
> +#include "pm8916.dtsi"
> +
> +&dsi0 {
> +	vdda-supply = <&pm8916_l2>;
> +	vddio-supply = <&pm8916_l6>;
> +};
> +
> +&dsi1 {
> +	vdda-supply = <&pm8916_l2>;
> +	vddio-supply = <&pm8916_l6>;
> +};
> +
> +&dsi_phy0 {
> +	vddio-supply = <&pm8916_l6>;
> +};
> +
> +&dsi_phy1 {
> +	vddio-supply = <&pm8916_l6>;
> +};
> +
> +&mpss {
> +	pll-supply = <&pm8916_l7>;
> +};
> +
> +&pronto {
> +	vddpx-supply = <&pm8916_l7>;
> +
> +	iris {
> +		vddxo-supply = <&pm8916_l7>;
> +		vddrfa-supply = <&pm8916_s3>;
> +		vddpa-supply = <&pm8916_l9>;
> +		vdddig-supply = <&pm8916_l5>;
> +	};
> +};
> +
> +&sdhc_1 {
> +	vmmc-supply = <&pm8916_l8>;
> +	vqmmc-supply = <&pm8916_l5>;
> +};
> +
> +&sdhc_2 {
> +	vmmc-supply = <&pm8916_l11>;
> +	vqmmc-supply = <&pm8916_l12>;
> +};
> +
> +&usb_hs_phy {
> +	v1p8-supply = <&pm8916_l7>;
> +	v3p3-supply = <&pm8916_l13>;
> +};
> +
> +&rpm_requests {
> +	smd_rpm_regulators: regulators {
> +		compatible = "qcom,rpm-pm8916-regulators";
> +
> +		/* pm8916_s1 is managed by rpmpd (MSM8939_VDDMDCX) */
> +		/* pm8916_s2 is managed by rpmpd (MSM8939_VDDCX) */
> +		pm8916_s3: s3 {};
> +		pm8916_s4: s4 {};
> +
> +		pm8916_l1: l1 {};
> +		pm8916_l2: l2 {};
> +		/* pm8916_l3 is managed by rpmpd (MSM8939_VDDMX) */
> +		pm8916_l4: l4 {};
> +		pm8916_l5: l5 {};
> +		pm8916_l6: l6 {};
> +		pm8916_l7: l7 {};
> +		pm8916_l8: l8 {};
> +		pm8916_l9: l9 {};
> +		pm8916_l10: l10 {};
> +		pm8916_l11: l11 {};
> +		pm8916_l12: l12 {};
> +		pm8916_l13: l13 {};
> +		pm8916_l14: l14 {};
> +		pm8916_l15: l15 {};
> +		pm8916_l16: l16 {};
> +		pm8916_l17: l17 {};
> +		pm8916_l18: l18 {};
> +	};
> +};
