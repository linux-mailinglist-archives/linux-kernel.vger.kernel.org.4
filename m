Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4406CBA19
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 11:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbjC1JFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 05:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbjC1JFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 05:05:11 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA5059CA
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 02:05:08 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id bi9so14837017lfb.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 02:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679994306;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C3GjN3p9ccpD2B5O58h3xZEaPlGMGrYBwTgOTQdFGIg=;
        b=pSisNiBNNob3zSKZAxcqGeY2LLXQsg6LDJPfFT2VvZWc5mUnnfn7cYZsMPepVeptpS
         uJ4Sf4UTMoyfkBBTfpzE74IQq1GW4OxR0fQoKm+fSDf/P9ucnmM+0p0rn+f+0h1RUnwj
         8p5RvVy1HyWOCxgyq/FXTXn+qEBPIg9mPNN5BMaKPwqtTuUlbf1xqhVk9w4bgqOm8api
         ZJ5ZGETklL7IrklsZ7fuSGVQDHSGzQce+byt1bvIX1EWW+HjEP9KsFyRlMCPyNz9B5Wg
         iGO3AQ5sTc5NGgGj6MKcju9cKfO8oUdvBZTDc1Xp6tm1Sq5y0tGRKMxKsVGeEwVnDFVp
         +yng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679994306;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C3GjN3p9ccpD2B5O58h3xZEaPlGMGrYBwTgOTQdFGIg=;
        b=uKEXauIxlvx+Jti1aK2TdUoIbr39B1ycAoNYBJkGs2OlTY1YuEzkkbBTTqV8jgL92I
         sF3aMHwQLsmz4U5FIivh+rcFkgy4GSJUB/McfPXSzk7r9eXVA4gqODNmLlXy20oEoS5l
         2ZrKvt5zQbqDjC+ZLXYJ7rogZdvDGGBxBqwAcwn+6DPhZ76gkwa5q1+wu9W+npYOIzf4
         pNXB1DPl3JmUxhUKGRmM88xT0Po+WSnDqYeZYQV4bkUXl2K3dzGM83nwwRC+vQEOaTlj
         J/6DtNbHX9s0x64R2Ejcx0IHRwU/Uxp0nG/V6Sz2bSMXnPU6Xq6ntuNzlzW3mIusuOjU
         YJjQ==
X-Gm-Message-State: AAQBX9c0WrgvtKFtfB80N4zC5wUHHoSW45BGZ2osVPwL3L6sT2YRLG08
        bwm/9w9saeuM+I9iV02PNinBYw==
X-Google-Smtp-Source: AKy350Y7a3jy3jCAnt0vZZbmeJGDqqUk0fRCUZ0iGtOe7GuMDvmLtoMOr3oE5zEXGthiLjnLftXJIA==
X-Received: by 2002:ac2:5638:0:b0:4dd:fd4e:5a20 with SMTP id b24-20020ac25638000000b004ddfd4e5a20mr4607528lff.58.1679994306438;
        Tue, 28 Mar 2023 02:05:06 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id y26-20020ac255ba000000b004e9b307d2c8sm4088202lfg.238.2023.03.28.02.05.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 02:05:06 -0700 (PDT)
Message-ID: <7522deaa-54be-d757-8a05-9d8195bf6ed9@linaro.org>
Date:   Tue, 28 Mar 2023 11:05:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 04/18] arm64: dts: qcom: sa8775p: add the pdc node
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230327125316.210812-1-brgl@bgdev.pl>
 <20230327125316.210812-5-brgl@bgdev.pl>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230327125316.210812-5-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27.03.2023 14:53, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add the Power Domain Controller node for SA8775p.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sa8775p.dtsi | 47 +++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> index 296ba69b81ab..6bb1db1839cc 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> @@ -591,6 +591,53 @@ tcsr_mutex: hwlock@1f40000 {
>  			#hwlock-cells = <1>;
>  		};
>  
> +		pdc: interrupt-controller@b220000 {
> +			compatible = "qcom,sa8775p-pdc", "qcom,pdc";
> +			reg = <0x0 0x0b220000 0x0 0x30000>,
> +			      <0x0 0x17c000f0 0x0 0x64>;
> +			qcom,pdc-ranges = <0 480 40>,
> +					  <40 140 14>,
> +					  <54 263 1>,
> +					  <55 306 4>,
> +					  <59 312 3>,
> +					  <62 374 2>,
> +					  <64 434 2>,
> +					  <66 438 2>,
> +					  <70 520 1>,
> +					  <73 523 1>,
> +					  <118 568 6>,
> +					  <124 609 3>,
> +					  <159 638 1>,
> +					  <160 720 3>,
> +					  <169 728 30>,
> +					  <199 416 2>,
> +					  <201 449 1>,
> +					  <202 89 1>,
> +					  <203 451 1>,
> +					  <204 462 1>,
> +					  <205 264 1>,
> +					  <206 579 1>,
> +					  <207 653 1>,
> +					  <208 656 1>,
> +					  <209 659 1>,
> +					  <210 122 1>,
> +					  <211 699 1>,
> +					  <212 705 1>,
> +					  <213 450 1>,
> +					  <214 643 2>,
> +					  <216 646 5>,
> +					  <221 390 5>,
> +					  <226 700 2>,
> +					  <228 440 1>,
> +					  <229 663 1>,
> +					  <230 524 2>,
> +					  <232 612 3>,
> +					  <235 723 5>;
> +			#interrupt-cells = <2>;
> +			interrupt-parent = <&intc>;
> +			interrupt-controller;
> +		};
> +
>  		tlmm: pinctrl@f000000 {
>  			compatible = "qcom,sa8775p-tlmm";
>  			reg = <0x0 0x0f000000 0x0 0x1000000>;
