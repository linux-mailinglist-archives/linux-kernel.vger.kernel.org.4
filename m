Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26343735841
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 15:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjFSNP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 09:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbjFSNOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 09:14:49 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB01E7B
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 06:14:47 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b46d4e1b0aso25452691fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 06:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687180485; x=1689772485;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tcj3NgSJHNrpvgWfJbBXR+bZkNG9EFiu9bbURhhosaA=;
        b=RLO6MM8TXFsT3oOn8v/mGvkYIq11JAWT829LZcZ4GAolCZDGVY5YsRNajeV9vUsV8v
         0bsEeNVa6r0L60KjsFzc/tfyuYkWw0v75bfHNnnhzcgo15xWaTz0aY6TC5ufeRf0RXJY
         yhio93TlHx2jHRW+rczj03of6rhrwKcsaBGEtGwHVt5csnmasPVhamAvQcsgzWw3v81w
         ZDANXop0XZQ8VukaD9mA+shPrA/Upj7azQRjYNyvSkKBhIyk0sFMFQLXbcXHxDqOlkT9
         e9ks0B2lazfsulRkNNigaSQbfeD2EhWm19lF9r4/JzcGGSYrX6iPlC4kMIa8cb4JLR8m
         0p8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687180485; x=1689772485;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tcj3NgSJHNrpvgWfJbBXR+bZkNG9EFiu9bbURhhosaA=;
        b=XU86N9lrkfl+TftkRER81RBOd2O2tRZVIvhOCseekMUeTEnCtNvUouimhPmPzIlS01
         NIMEkN52Kr4m7Ha7lEjKLemptpUfC3tEiE9pYkxUEdoAtmijNbeZMmI8fniLBs/cqlI0
         lXgIDre43IqaVa4xo1ck0aG1KDguYRptI5oQ2x9ImVAg1kxGZl+vWuf5ZyXB+rQ4PQ0B
         0/zD6WeDW6koouZQCeh73DvwJubHRFUfXCQ9kgBnj54OBQleTE/PMqxBlUarHMjHpsFd
         dJF6FHkVlMW9vzw7xS9GgBklcoEGvJ7DVETWGwYcOjBDU0xRd685Q9d1eLKV85RGrVyH
         DT/g==
X-Gm-Message-State: AC+VfDztr4ZcKstUX9jhDJ1WnCxFLC6QNHZX0YP2S4/geLcbvsYdYCGm
        Zn5Wf1KelxUJ4KmZAMp2O8ErKw==
X-Google-Smtp-Source: ACHHUZ6ITSS1FxrBbjhl0GO9DoOJSdqFL7BOy8Ld9jFBZihfO4X2f02H5hsgnZsqmWizyXDWE0xEuw==
X-Received: by 2002:a2e:998c:0:b0:2b1:a3ce:b709 with SMTP id w12-20020a2e998c000000b002b1a3ceb709mr6276446lji.39.1687180485468;
        Mon, 19 Jun 2023 06:14:45 -0700 (PDT)
Received: from [192.168.1.101] (abyl242.neoplus.adsl.tpnet.pl. [83.9.31.242])
        by smtp.gmail.com with ESMTPSA id d21-20020a2eb055000000b002aeee2a093csm5173181ljl.59.2023.06.19.06.14.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 06:14:45 -0700 (PDT)
Message-ID: <abddd4e4-86b1-fd04-846f-e9ed498f5c80@linaro.org>
Date:   Mon, 19 Jun 2023 15:14:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 10/15] arm64: dts: qcom: sc8180x: use generic ADC channel
 node names
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Nikita Travkin <nikita@trvn.ru>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230617171541.286957-1-krzysztof.kozlowski@linaro.org>
 <20230617171541.286957-10-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230617171541.286957-10-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.06.2023 19:15, Krzysztof Kozlowski wrote:
> ADC channel node names were changed to require generic 'channel'.  The
> user-visible part is defined via label.
> 
>   sc8180x-lenovo-flex-5g.dtb: adc@3100: 'die-temp@6', 'ref-gnd@0', 'vref-1p25@1' do not match any of the regexes: '^channel@[0-9a-f]+$', 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sc8180x-pmics.dtsi | 24 ++++++++++-----------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8180x-pmics.dtsi b/arch/arm64/boot/dts/qcom/sc8180x-pmics.dtsi
> index 8247af01c84a..4556af6cd103 100644
> --- a/arch/arm64/boot/dts/qcom/sc8180x-pmics.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8180x-pmics.dtsi
> @@ -105,19 +105,19 @@ pmc8180_adc: adc@3100 {
>  			#io-channel-cells = <1>;
>  			interrupts = <0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
>  
> -			ref-gnd@0 {
> +			channel@0 {
>  				reg = <ADC5_REF_GND>;
>  				qcom,pre-scaling = <1 1>;
>  				label = "ref_gnd";
>  			};
>  
> -			vref-1p25@1 {
> +			channel@1 {
>  				reg = <ADC5_1P25VREF>;
>  				qcom,pre-scaling = <1 1>;
>  				label = "vref_1p25";
>  			};
>  
> -			die-temp@6 {
> +			channel@6 {
>  				reg = <ADC5_DIE_TEMP>;
>  				qcom,pre-scaling = <1 1>;
>  				label = "die_temp";
> @@ -172,19 +172,19 @@ adc@3100 {
>  			#io-channel-cells = <1>;
>  			interrupts = <0x2 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
>  
> -			ref-gnd@0 {
> +			channel@0 {
>  				reg = <ADC5_REF_GND>;
>  				qcom,pre-scaling = <1 1>;
>  				label = "ref_gnd";
>  			};
>  
> -			vref-1p25@1 {
> +			channel@1 {
>  				reg = <ADC5_1P25VREF>;
>  				qcom,pre-scaling = <1 1>;
>  				label = "vref_1p25";
>  			};
>  
> -			vcoin@85 {
> +			channel@85 {
>  				reg = <0x85>;
>  				qcom,pre-scaling = <1 1>;
>  				label = "vcoin2";
> @@ -220,19 +220,19 @@ adc@3100 {
>  			#io-channel-cells = <1>;
>  			interrupts = <0xa 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
>  
> -			ref-gnd@0 {
> +			channel@0 {
>  				reg = <ADC5_REF_GND>;
>  				qcom,pre-scaling = <1 1>;
>  				label = "ref_gnd";
>  			};
>  
> -			vref-1p25@1 {
> +			channel@1 {
>  				reg = <ADC5_1P25VREF>;
>  				qcom,pre-scaling = <1 1>;
>  				label = "vref_1p25";
>  			};
>  
> -			vcoin@85 {
> +			channel@85 {
>  				reg = <0x85>;
>  				qcom,pre-scaling = <1 1>;
>  				label = "vcoin";
> @@ -270,19 +270,19 @@ pmc8180c_adc: adc@3100 {
>  			#io-channel-cells = <1>;
>  			interrupts = <0x4 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
>  
> -			ref-gnd@0 {
> +			channel@0 {
>  				reg = <ADC5_REF_GND>;
>  				qcom,pre-scaling = <1 1>;
>  				label = "ref_gnd";
>  			};
>  
> -			vref-1p25@1 {
> +			channel@1 {
>  				reg = <ADC5_1P25VREF>;
>  				qcom,pre-scaling = <1 1>;
>  				label = "vref_1p25";
>  			};
>  
> -			die-temp@6 {
> +			channel@6 {
>  				reg = <ADC5_DIE_TEMP>;
>  				qcom,pre-scaling = <1 1>;
>  				label = "die_temp";
