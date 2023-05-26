Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E74712DE6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 21:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242221AbjEZTuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 15:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242143AbjEZTuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 15:50:50 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E71BD
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 12:50:49 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4effb818c37so1194657e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 12:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685130648; x=1687722648;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u+xUHXVQM9Dz8LrnzE+p2/PyuQIbjZpGsWxztNGcHQk=;
        b=CgsLcznPR5dE74lkBawoKz+qUl7pE/jMyb1FtW3xODZVPUHsQtP5OLqW5Ec2y8FK6p
         YvB1oRVNJkMc7J5+oRyYo+hAi+VhuN1f8e0C7VACsBQKLilTB4Aw+ZS5qF+Zkt9YO4/n
         3TsSwELsu7yG272kyvn2b7NUTK6R4EbRRX4FkIVPNRjGEYSTMe32pzCDz+hF4atqRqq9
         XZ8HYlbkHqbT5qe4atIc+lGgiSpntWQKUc2eGVTeTgw4fpxW7ch23vuoFMT0U08geYrY
         7fVNguONdqKHgXv8u4fLXiGpYmpAe9hGjhAxBOGllfwNqOdZUUMvtosQzkRvSvrHbjEp
         w3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685130648; x=1687722648;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u+xUHXVQM9Dz8LrnzE+p2/PyuQIbjZpGsWxztNGcHQk=;
        b=W3k9hD/N+8NncYrWRbjUvSt6EwGTZ2aSA1u/XM/vynzWJtnwnZgDqbKzb+mvcvkR2o
         vL/MojBhtBcUPgk2ympPjBaN27ha0enCK9XT+oZiGMZx8efIbw4kZt6benNbpSm9aW0f
         cE+608ILZ4C0nm7x++v7pjpziRkUxDFWEZ8P5Vy/oiwse+gFA7+vckWMDKACrgyQb5qG
         niIjm/albNfp0BpyvofAyCUu3CJnfEBKjPT7ZPty1Esw4qwPujcT8iHrm5/Svsks4JBs
         qHe4/fRo4IqWjSQ3KcGKFx1akvznOeU7QckykspM3L2aYMm+azcAPlcrchRonx5V6Ws9
         s6gg==
X-Gm-Message-State: AC+VfDw34DAdihkdapQTFo00IEtEUWoxNMow0MQolpaIFS6pgz4rjunM
        /g8kd1ky3VuC6RqyKh16Vjxqcg==
X-Google-Smtp-Source: ACHHUZ4jL/1nS12nZu/haNGgLw6OPPmU/aFrqzWNtwXug2PxZOC7Y3wjlwJ/cQvcMN9zf8Jp6TQd5Q==
X-Received: by 2002:a05:6512:513:b0:4f3:bad8:b7fc with SMTP id o19-20020a056512051300b004f3bad8b7fcmr839033lfb.29.1685130647892;
        Fri, 26 May 2023 12:50:47 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id y7-20020a2e7d07000000b002ad8174d025sm892875ljc.122.2023.05.26.12.50.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 12:50:47 -0700 (PDT)
Message-ID: <f417453d-4e11-4e9e-d24c-927772219ef5@linaro.org>
Date:   Fri, 26 May 2023 21:50:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/4] arm64: dts: qcom: sm8550-qrd: add notification RGB
 LED
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230525-topic-sm8550-upstream-pm8550-lpg-dt-v1-0-4d5d7602f290@linaro.org>
 <20230525-topic-sm8550-upstream-pm8550-lpg-dt-v1-2-4d5d7602f290@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230525-topic-sm8550-upstream-pm8550-lpg-dt-v1-2-4d5d7602f290@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25.05.2023 17:47, Neil Armstrong wrote:
> The QRD features a notification LED connected to the pm8550.
> Configure the RGB led controlled by the PMIC PWM controller.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sm8550-qrd.dts | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
> index ff61b8b36853..4a8177f99523 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
> @@ -450,6 +450,33 @@ led-1 {
>  	};
>  };
>  
> +&pm8550_pwm {
> +	status = "okay";
> +
> +	multi-led {
> +		color = <LED_COLOR_ID_RGB>;
> +		function = LED_FUNCTION_STATUS;
> +
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		led@1 {
> +			reg = <1>;
> +			color = <LED_COLOR_ID_RED>;
> +		};
> +
> +		led@2 {
> +			reg = <2>;
> +			color = <LED_COLOR_ID_GREEN>;
> +		};
> +
> +		led@3 {
> +			reg = <3>;
> +			color = <LED_COLOR_ID_BLUE>;
> +		};
> +	};
> +};
> +
>  &pm8550b_eusb2_repeater {
>  	vdd18-supply = <&vreg_l15b_1p8>;
>  	vdd3-supply = <&vreg_l5b_3p1>;
> 
