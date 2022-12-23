Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92AB0654FE2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 12:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236010AbiLWL54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 06:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236239AbiLWL5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 06:57:35 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245E72B24E
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 03:57:26 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id b13so6863237lfo.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 03:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W1MqNfvQnxK7WcVE1mQ7e/hxZyGccdrLjMvUlPIFUiY=;
        b=UkVK/LZIxZTiBR+BkqfpY8inJh68syPmg+Qh/SNoFMvBoWDelXFgGHFR/AKNQdqvGy
         8OIQfMaYFVHKl9CE6vlgSB+YleBy2utSLt8YPnIEtHPq2vBw2NdOY6GnELVLrmR5iqyg
         nlPWX3Kcjz+KWb0l4qsCyKD8pIB6RD21fekAI2EZCm1RX0G+rwmp5kiLm9PngmJYDJmy
         3nYfccZqyth1lIgOprWNZdep1EEKXh3+zjSCi01jcvLsVlcbZQm30pmKLrLqVtuNF2E2
         iW8Ek75LHYAmNw5mlHn1p7klLcaV2xhpA7o89vwT3js+eIlBGLdUavN/4ImwoC5MsYfM
         BF2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W1MqNfvQnxK7WcVE1mQ7e/hxZyGccdrLjMvUlPIFUiY=;
        b=KoWDlO/mx1Ed8Vqsl72oL3S2XtM+2xzKNjal1JqhA0FV0lGIZrPSmRz45/Jn4UQXHS
         GACoRN4VTZ7kkzV8JAf0NNooC5hr8B5Uf65u2WGvqc/TyDvRY0XU15xyE8DPAtiRpmnT
         cqR/NfuMx1bYnnvuQKLD5gq04cBHjLrfTUOcd2Mcx9JZs9iNG2RJGjwAJkGUJ5ecC72t
         E1ybQ+Btx42izMYqPIh4GXohSD4RKqj2NaZTcFDOmIKHRWEMlUgflwjs8gxgNTKFwzhs
         iL/zRfkt5bT4raDu6wuX1qBLpBu2/ETTEQOCD+728QKBXmgEgsH46rtvwTb8lRtAanYt
         scYQ==
X-Gm-Message-State: AFqh2koNfAKf/Gi+ZnnhQ1JSPc3UgqMJP+WQK2bdKY0j5rlCB81QFYYA
        EsKlxrXauKBc9pWvlnTLP1W9eIMP+z/bt084
X-Google-Smtp-Source: AMrXdXvhfZ21xGg5smJtbdtUhsDxNI/aFVZnQvlVSHDHUVBUqKrNwp7Aq1tl1GaHeLp1Q6Fk5vebDw==
X-Received: by 2002:a05:6512:b25:b0:4b4:b8fc:4ac5 with SMTP id w37-20020a0565120b2500b004b4b8fc4ac5mr2878465lfu.3.1671796644486;
        Fri, 23 Dec 2022 03:57:24 -0800 (PST)
Received: from [192.168.1.101] (abyl184.neoplus.adsl.tpnet.pl. [83.9.31.184])
        by smtp.gmail.com with ESMTPSA id o1-20020ac25e21000000b004979db5aa5bsm502211lfg.223.2022.12.23.03.57.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Dec 2022 03:57:24 -0800 (PST)
Message-ID: <0238b9e4-206c-398f-8336-71f712bef538@linaro.org>
Date:   Fri, 23 Dec 2022 12:57:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/5] arm64: dts: qcom: sm6125-seine: Configure PM6125
 regulators
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221222203636.250190-1-marijn.suijten@somainline.org>
 <20221222203636.250190-2-marijn.suijten@somainline.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221222203636.250190-2-marijn.suijten@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22.12.2022 21:36, Marijn Suijten wrote:
> Configure PM6125 regulators based on availability and voltages defined
> downstream, to allow powering up (and/or keeping powered) other hardware
> blocks going forward.
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  .../qcom/sm6125-sony-xperia-seine-pdx201.dts  | 139 ++++++++++++++++++
>  1 file changed, 139 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts b/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
> index 4e7c12863d28..4f825c55692b 100644
> --- a/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
> +++ b/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
> @@ -276,6 +276,145 @@ &qupv3_id_0 {
>  	status = "okay";
>  };
>  
> +&rpm_requests {
> +	regulators-0 {
> +		compatible = "qcom,rpm-pm6125-regulators";
> +
> +		vdd_l2_l3_l4-supply = <&pm6125_l7>;
> +		vdd_l5_l15_l19_l20_l21_l22-supply = <&pm6125_l10>;
> +
> +		/*
> +		 * S3/S4 is VDD_CX
> +		 * S5 is VDD_MX/WCSS_MX
> +		 */
> +
> +		pm6125_s6: s6 {
> +			regulator-min-microvolt = <936000>;
> +			regulator-max-microvolt = <1422000>;
> +		};
> +
> +		pm6125_l1: l1 {
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1256000>;
> +		};
> +
> +		pm6125_l2: l2 {
> +			regulator-min-microvolt = <1000000>;
> +			regulator-max-microvolt = <1056000>;
> +		};
> +
> +		pm6125_l3: l3 {
> +			regulator-min-microvolt = <1000000>;
> +			regulator-max-microvolt = <1064000>;
> +		};
> +
> +		pm6125_l4: l4 {
> +			regulator-min-microvolt = <872000>;
> +			regulator-max-microvolt = <976000>;
> +		};
> +
> +		pm6125_l5: l5 {
> +			regulator-min-microvolt = <1648000>;
> +			regulator-max-microvolt = <3104000>;
> +		};
> +
> +		pm6125_l6: l6 {
> +			regulator-min-microvolt = <576000>;
> +			regulator-max-microvolt = <656000>;
> +		};
> +
> +		pm6125_l7: l7 {
> +			regulator-min-microvolt = <872000>;
> +			regulator-max-microvolt = <976000>;
> +		};
> +
> +		pm6125_l8: l8 {
> +			regulator-min-microvolt = <400000>;
> +			regulator-max-microvolt = <728000>;
> +		};
> +
> +		pm6125_l9: l9 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1896000>;
> +		};
> +
> +		pm6125_l10: l10 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1896000>;
> +		};
> +
> +		pm6125_l11: l11 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1952000>;
> +		};
> +
> +		pm6125_l12: l12 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1996000>;
> +		};
> +
> +		pm6125_l13: l13 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1832000>;
> +		};
> +
> +		pm6125_l14: l14 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1904000>;
> +		};
> +
> +		pm6125_l15: l15 {
> +			regulator-min-microvolt = <3104000>;
> +			regulator-max-microvolt = <3232000>;
> +		};
> +
> +		pm6125_l16: l16 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1904000>;
> +		};
> +
> +		pm6125_l17: l17 {
> +			regulator-min-microvolt = <1248000>;
> +			regulator-max-microvolt = <1304000>;
> +		};
> +
> +		pm6125_l18: l18 {
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1264000>;
> +		};
> +
> +		pm6125_l19: l19 {
> +			regulator-min-microvolt = <1648000>;
> +			regulator-max-microvolt = <2952000>;
> +		};
> +
> +		pm6125_l20: l20 {
> +			regulator-min-microvolt = <1648000>;
> +			regulator-max-microvolt = <2952000>;
> +		};
> +
> +		pm6125_l21: l21 {
> +			regulator-min-microvolt = <2600000>;
> +			regulator-max-microvolt = <2856000>;
> +		};
> +
> +		pm6125_l22: l22 {
> +			regulator-min-microvolt = <2944000>;
> +			regulator-max-microvolt = <3304000>;
> +		};
> +
> +		pm6125_l23: l23 {
> +			regulator-min-microvolt = <3000000>;
> +			regulator-max-microvolt = <3400000>;
> +		};
> +
> +		pm6125_l24: l24 {
> +			regulator-min-microvolt = <2944000>;
> +			regulator-max-microvolt = <3304000>;
> +		};
> +	};
> +};
> +
>  &sdc2_off_state {
>  	sd-cd-pins {
>  		pins = "gpio98";
