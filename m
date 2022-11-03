Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B20618B52
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 23:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbiKCWVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 18:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiKCWVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 18:21:40 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653FB1D0FC
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 15:21:39 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id x15so2130717qtv.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 15:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vi/pWwgGFs4pXzg7F1f4rBtGcIgo+CI+e4hAiYlYSug=;
        b=gCQrA1mESAHroZExu5yboI7YitKs8V66ouZfsz1dAghoX9z/eu7dcqx7XxwzfGYq9i
         dqFz3S3xkBhQWa8DNRIxGDsNVVTFf7ujh1Gl2oFDfdhmI3Z7JY9KTazDjbvMWT6Emqer
         Eg3U7XlfoN0f6RXzeEZ05D7fWJZ2Is+T/Sdof72bjT5lW3YT5IdwaLgLF1gP57ysFb3x
         wmUhMCtakRcaI3Mei5/02Q7CYwzXBjwSvUhM8uwZyKusaQs1JeatXu/Lfm0+GrQE4k2x
         wxYCiGVkcJyA9+YhIC9Qy5+9wdjBQC1yfpGNsYSfRajgctIk7bYVQRSjPXO1YO53tYWA
         PAzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vi/pWwgGFs4pXzg7F1f4rBtGcIgo+CI+e4hAiYlYSug=;
        b=UO4I5hW/bWkDVunRm6BISPCDlr7WGhO5tEiZxWLsILSDOUlc1CoHFnaTtX+WoqU+LI
         tH7ubTg1pvIknby+qtAaJPfBeLKSEQFHoEFIg5rUA2qI2RnP6cuUPOT5lVcNt+E8cCfI
         L2ZS3M79NJFoUWU06q9jtFuIltTe58EkYjs2+2uwK++5FzoeDwQo9HSV2xmkpUy7IZyK
         1Ag4NSvsJHSFzO3EVHEj8WflcXe2pFWvUEvOgGHm2cNVQiNPeCjMce6GwmAkBK2h6Y0y
         sLhl3Uklk3KmQtvLwZKLHD3Pz5XAfCKvS/Z3oM3ZnCLoOOXFkNeWQcrQX3dfsdsQk7ba
         P+ig==
X-Gm-Message-State: ACrzQf0M1IiMGXi7ElAGy6oSCkruasUjtGiSLbWTo2SAwf7Oq72925Tc
        hiBba8+ZBARGdmzr+YN6mf1vMQ==
X-Google-Smtp-Source: AMsMyM4dV+l3qpT2GaeRAl+EKAxXhDQLiMQslAFWNumDisNbRwbsB45L9HEavd86pL52uLDz5fe2Dg==
X-Received: by 2002:ac8:7651:0:b0:3a5:528c:f326 with SMTP id i17-20020ac87651000000b003a5528cf326mr4491581qtr.586.1667514098561;
        Thu, 03 Nov 2022 15:21:38 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:a35d:9f85:e3f7:d9fb? ([2601:586:5000:570:a35d:9f85:e3f7:d9fb])
        by smtp.gmail.com with ESMTPSA id k7-20020ac81407000000b0039cd4d87aacsm1264139qtj.15.2022.11.03.15.21.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 15:21:37 -0700 (PDT)
Message-ID: <035a66e3-0b21-18de-0899-fb2ee22df15f@linaro.org>
Date:   Thu, 3 Nov 2022 18:21:36 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v1 2/2] arm64: dts: qcom: msm8916-alcatel-idol347: add LED
 indicator
Content-Language: en-US
To:     Vincent Knecht <vincent.knecht@mailoo.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221029145557.106920-1-vincent.knecht@mailoo.org>
 <20221029145557.106920-2-vincent.knecht@mailoo.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221029145557.106920-2-vincent.knecht@mailoo.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/10/2022 10:55, Vincent Knecht wrote:
> Add si-en,sn3190 LED controller to enable white LED indicator.
> 
> This requires adding the additional "enable" gpio that the OEM
> choose to use, despite it not being mentioned in si-en,sn3190
> datasheet nor supported by the driver.
> 
> Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
> ---
>  .../boot/dts/qcom/msm8916-alcatel-idol347.dts | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts b/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
> index 3a0a593899ae..952ae092e6ae 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
> @@ -130,6 +130,27 @@ gyroscope@68 {
>  	};
>  };
>  
> +&blsp_i2c6 {
> +	status = "okay";
> +
> +	led-controller@68 {
> +		compatible = "si-en,sn3190";
> +		reg = <0x68>;
> +		shutdown-gpios = <&msmgpio 89 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&led_enable_default &led_shutdown_default>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		led@1 {
> +			reg = <1>;
> +			led-max-microamp = <5000>;
> +			function = LED_FUNCTION_INDICATOR;
> +			color = <LED_COLOR_ID_WHITE>;
> +		};
> +	};
> +};
> +
>  &pm8916_resin {
>  	status = "okay";
>  	linux,code = <KEY_VOLUMEDOWN>;
> @@ -306,6 +327,29 @@ gyro_int_default: gyro-int-default {
>  		bias-disable;
>  	};
>  
> +	/*
> +	 * The OEM wired an additional GPIO to be asserted so that
> +	 * the si-en,sn3190 LED IC works. Since this GPIO is not
> +	 * part of the IC datasheet nor supported by the driver,
> +	 * force it asserted here.
> +	 */
> +	led_enable_default: led-enable-default {

Add suffix to node name: "-state"

Same in other places. Bindings require it now.

Best regards,
Krzysztof

