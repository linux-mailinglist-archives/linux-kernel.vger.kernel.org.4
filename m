Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39185F21E7
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 10:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiJBINH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 04:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiJBINE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 04:13:04 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB583D5A4
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 01:12:59 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id a8so12627417lff.13
        for <linux-kernel@vger.kernel.org>; Sun, 02 Oct 2022 01:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=hn8aunpvelYplCa+ipF4DNW3DXvRbXgLoMvalMQd/ok=;
        b=KfVsqGzGHEOv3AIsxLtsLN525rsnaoBQUpBRenkWsHaKviyHHdW2o0RLjHvxUyn02i
         rsXy4GQv6MAatGxAgEyFFRK0i61r4NW0rN1r1rtx3Hwj5yodMTgeMniw+NuA2wukJ0ZP
         M/xZo945yeaA9eEMomS2G5b0yUpmDpszC8p0PnPdpQUIWOST08vl+F9fykPcdWwkFjj0
         awqYeKo9MlFgl68823C7lNfLNahnQjIIhiZCcrfeiHPObK1YYRYwzyMgwHgLQKnxvw/0
         qmuT4pnDF3dZ9wZ5uXpEwXGJ1XqlswJP+g3lfdBru/ge2Sc8ZuGjWkgDIVdJEHfhMBuC
         yxFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=hn8aunpvelYplCa+ipF4DNW3DXvRbXgLoMvalMQd/ok=;
        b=aXF0WWoBd0UKBgqgYJ575Cq6KtzFxJBW0JYTMAlPkoHPpw7YUZslqhdI8tv2mP/R/p
         hLmVswEdQrcUXGiAbCoG8//u+DNfboaPbzib6slhKBFguW7lK6JIja71Nl22p6sAbF6m
         LJm4OgotsO+KhGy45jHYrbDCdvPwYWWfqCGEiHQMb0K0CSOsfzqlbRW5IV7MyNuFozHR
         lr1a7XLc2CyFSUMT+2wZsQ2xO440K08/qPLDvVSvBzWL6rrpqKMoTqW/XvKRbLUKDXPW
         /0vMExWUVQfl1MngieDFfBB16mQJS/BphbJ5xywmzt4w+EW7cEBubxxDG22wHzXGZDmx
         hZJA==
X-Gm-Message-State: ACrzQf19Hl4wRdofPybuKDQWgigrsmn9beEU8rmcboWIzJpRBzbMNeE8
        +FyH5wEp+ZbpHoNlTS2E0OmUzg==
X-Google-Smtp-Source: AMsMyM5IlLn5kJh8Vr8Z3KLdbci0EUOFu5zPxDR/Osj12BQ+145bTvpsOIfot26zhqu9SiInuOTmxg==
X-Received: by 2002:a05:6512:1056:b0:498:efaf:5bd1 with SMTP id c22-20020a056512105600b00498efaf5bd1mr5373193lfb.64.1664698378004;
        Sun, 02 Oct 2022 01:12:58 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id 7-20020a05651c00c700b00261b175f9c4sm573011ljr.37.2022.10.02.01.12.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Oct 2022 01:12:57 -0700 (PDT)
Message-ID: <49b25b8f-9102-1dad-abe1-23ff0d6bdbb9@linaro.org>
Date:   Sun, 2 Oct 2022 10:12:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sm6125: Add i2c and SPI pin
 configuration
Content-Language: en-US
To:     Martin Botka <martin.botka@somainline.org>, martin.botka1@gmail.com
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jamipkettunen@somainline.org>,
        Paul Bouchara <paul.bouchara@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221001185628.494884-1-martin.botka@somainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221001185628.494884-1-martin.botka@somainline.org>
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

On 01/10/2022 20:56, Martin Botka wrote:
> This commit adds configuration for I2C and SPI
> pins used in SM6125 SoC

Do not use "This commit/patch".
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

> 
> Signed-off-by: Martin Botka <martin.botka@somainline.org>
> ---
>  arch/arm64/boot/dts/qcom/sm6125.dtsi | 547 +++++++++++++++++++++++++++
>  1 file changed, 547 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> index 85c52b64522e..350713742ccd 100644
> --- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> @@ -445,6 +445,553 @@ data {
>  					bias-pull-up;
>  				};
>  			};
> +
> +			/* qup_0 SE mappings */
> +			/* SE 0 pin mappings */
> +			qup_i2c0_default: qup-i2c0-default {

We are transitioning to more organized bindings, so this must have
"-stat" suffix.

See:
https://lore.kernel.org/linux-devicetree/20220925110608.145728-1-krzysztof.kozlowski@linaro.org/T/#mc1409d1ff6b58c2a2622aaf838eb42170e76d48b

> +				mux {
> +					pins = "gpio0", "gpio1";
> +					function = "qup00";
> +				};
> +
> +				config {

Merge these nodes either in one node with "-pins" or just under above
"-state".

> +					pins = "gpio0", "gpio1";
> +					drive-strength = <2>;
> +					bias-disable;
> +				};
> +			};
> +			qup_i2c0_sleep: qup-i2c0-sleep {

-state

> +				mux {

Merge or -pins. This applies everywhere.

> +					pins = "gpio0", "gpio1";
> +					function = "gpio";
> +				};
> +
> +				config {
> +					pins = "gpio0", "gpio1";
> +					drive-strength = <2>;
> +					bias-pull-up;
> +				};
> +			};
> +
> +			/* SE 1 pin mappings */
> +			qup_i2c1_default: qup-i2c1-default {
> +				mux {
> +					pins = "gpio4", "gpio5";
> +					function = "qup01";
> +				};
> +
> +				config {
> +					pins = "gpio4", "gpio5";
> +					drive-strength = <2>;
> +					bias-disable;
> +				};
> +			};
> +			qup_i2c1_sleep: qup-i2c1-sleep {
> +				mux {
> +					pins = "gpio4", "gpio5";
> +					function = "gpio";
> +				};
> +
> +				config {
> +					pins = "gpio4", "gpio5";
> +					drive-strength = <2>;
> +					bias-pull-up;
> +				};
> +			};
> +
> +			/* SE 2 pin mappings */
> +			qup_i2c2_default: qup-i2c2-default {
> +				mux {
> +					pins = "gpio6", "gpio7";
> +					function = "qup02";
> +				};
> +
> +				config {
> +					pins = "gpio6", "gpio7";
> +					drive-strength = <2>;
> +					bias-disable;
> +				};
> +			};
> +			qup_i2c2_sleep: qup-i2c2-sleep {
> +				mux {
> +					pins = "gpio6", "gpio7";
> +					function = "gpio";
> +				};
> +
> +				config {
> +					pins = "gpio6", "gpio7";
> +					drive-strength = <2>;
> +					bias-pull-up;
> +				};
> +			};
> +
> +			/* SE 3 pin mappings */
> +			qup_i2c3_default: qup-i2c3-default {
> +				mux {
> +						pins = "gpio14", "gpio15";
> +						function = "qup03";
> +				};
> +
> +				config {
> +						pins = "gpio14", "gpio15";
> +						drive-strength = <2>;
> +						bias-disable;
> +				};
> +			};
> +
> +			qup_i2c3_sleep: qup-i2c3-sleep {
> +				mux {
> +						pins = "gpio14", "gpio15";
> +						function = "gpio";
> +				};
> +
> +				config {
> +						pins = "gpio14", "gpio15";
> +						drive-strength = <2>;
> +						bias-pull-up;
> +				};
> +			};
> +
> +			/* SE 4 pin mappings */
> +			qup_i2c4_default: qup-i2c4-default {
> +				mux {
> +						pins = "gpio16", "gpio17";
> +						function = "qup04";
> +				};
> +
> +				config {
> +						pins = "gpio16", "gpio17";
> +						drive-strength = <2>;
> +						bias-disable;
> +				};
> +			};
> +
> +			qup_i2c4_sleep: qup-i2c4-sleep {
> +				mux {
> +						pins = "gpio16", "gpio17";
> +						function = "gpio";
> +				};
> +
> +				config {
> +						pins = "gpio16", "gpio17";
> +						drive-strength = <2>;
> +						bias-pull-up;
> +				};
> +			};
> +
> +			/*qup_1 SE mappings */

Missing space after /*

> +			/* SE 5 pin mappings */
> +			qup_i2c5_default: qup-i2c5-default {
> +				mux {
> +						pins = "gpio22", "gpio23";
> +						function = "qup10";
> +				};
> +
> +				config {
> +						pins = "gpio22", "gpio23";
> +						drive-strength = <2>;
> +						bias-disable;
> +				};
> +			};


(...)

> +
> +			/* SE 6 pin mappings */
> +			qup_spi6_default: qup-spi6-default {
> +				mux {
> +					pins = "gpio30", "gpio31", "gpio32",
> +								"gpio33";
> +					function = "qup11";
> +				};
> +
> +				config {
> +					pins = "gpio30", "gpio31", "gpio32",
> +								"gpio33";
> +					drive-strength = <6>;
> +					bias-disable;
> +				};
> +			};
> +
> +			qup_spi6_sleep: qup-spi6-sleep {
> +				mux {
> +					pins = "gpio30", "gpio31", "gpio32",
> +								"gpio33";
> +					function = "gpio";
> +				};
> +
> +				configs {
> +					pins = "gpio30", "gpio31", "gpio32",
> +								"gpio33";
> +					drive-strength = <6>;
> +					bias-disable;
> +				};
> +			};
> +
> +			/* SE 8 pin mappings */
> +			qup_spi8_default: qup-spi8-default {
> +				mux {
> +					pins = "gpio18", "gpio19", "gpio20",
> +								"gpio21";

Wrong indentation. It should be aligned with previous gpio18 entry. This
applies everywhere.

> +					function = "qup13";
> +				};
> +


Best regards,
Krzysztof

