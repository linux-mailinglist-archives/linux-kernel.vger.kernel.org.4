Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139E4712DF0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 21:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237095AbjEZTxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 15:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237050AbjEZTxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 15:53:11 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA88C1B1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 12:53:09 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2af177f12a5so11211721fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 12:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685130788; x=1687722788;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EdOxC7pmuf6A/Xakhco3OcLae3tnkD2fShwausc2Awo=;
        b=HOrZeNPoR3ZYMQxO8fqChg/oAGdcW3K8v9RhXw3PAtxwsL3JS1D7LydUT65LwFS8rd
         d8oanhI4eQEI5hcOLZ5PILzZm/xBDSbUUEiMz/bJtc5x1x0tgYnASt4sBHAhLnerxMiP
         X9uJiiH05lY6LeC1Pg1nP49h/dzQH+A5tcltvwAQyR7NUB5a2r5UaaULBndvd5OmNq65
         XAGy6ZRhI8ZTJAV5wOZz2JgXR1FrOlBVIRuVFk3dvsjulvIXqM/X84c02PpZhU6srX4E
         KG/DohoNiI1JrAJBaWw6OFY2jly2qMhqe4f8ttYtqI/HpmKNgJaE7Fns3qDR5yAM/CGf
         XbPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685130788; x=1687722788;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EdOxC7pmuf6A/Xakhco3OcLae3tnkD2fShwausc2Awo=;
        b=VrH033sCMzuOT0cJW4FJpAC5fdiERTTSDLu13YzZJ6SkL3vsiGuvH6YnAXLfKyrwJ9
         JlKwrwYyNXQDvqPewIFkyixlI+UMGAp24No9/8U5CO8yubBL5lZgxJmrNaMvajjVOM5s
         RKm/6hkHTXwU8/NVSsYXe69ox/Sekf3XWKaBSvUazzV8EDyFz9+PR4yX5ht+VTqzc1B3
         e1PS5/CQxVPE4VqZrvF25cN6YZJmV+xFjJYRH3jDWuQyO1tCqaB5mVdh4g72+oQJ3PyV
         RAHndteU5Jkrfthb/y62hsW2q9iTqKG1DVv/s+7XJPeTA1F10j1obp+8FuX1M3g2Jino
         O8FQ==
X-Gm-Message-State: AC+VfDxUoekAzwbC3MosFZkIrugYaT4QeTiiIj4JTyX3nC169FUhe2NO
        di/LlgFsbxyTLotl7rYnGrJWj6NkR24yaa0l84w=
X-Google-Smtp-Source: ACHHUZ4khPTysmRopzYaR5zjx+FiCgvNlpBkbFBZniRUlr/Zm+W/qbEL2Eup6UXRtM1OFsiXiiwbAg==
X-Received: by 2002:a2e:808c:0:b0:2ad:92b9:83b4 with SMTP id i12-20020a2e808c000000b002ad92b983b4mr1228070ljg.5.1685130787979;
        Fri, 26 May 2023 12:53:07 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id f6-20020a2e3806000000b002adb36f7343sm900375lja.77.2023.05.26.12.53.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 12:53:07 -0700 (PDT)
Message-ID: <be3f426e-6831-9efd-19c3-1b679cc3ea7e@linaro.org>
Date:   Fri, 26 May 2023 21:53:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 4/4] arm64: dts: qcom: sm8550-qrd: enable PMIC Volume and
 Power buttons
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
 <20230525-topic-sm8550-upstream-pm8550-lpg-dt-v1-4-4d5d7602f290@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230525-topic-sm8550-upstream-pm8550-lpg-dt-v1-4-4d5d7602f290@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25.05.2023 17:47, Neil Armstrong wrote:
> The Volume Down & Power buttons are controlled by the PMIC via
> the PON hardware, and the Volume Up is connected to a PMIC gpio.
> 
> Enable the necessary hardware and setup the GPIO state for the
> Volume Up gpio key.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8550-qrd.dts | 36 +++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
> index b08a8201ad23..c354dcc12621 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
> @@ -28,6 +28,22 @@ chosen {
>  		stdout-path = "serial0:115200n8";
>  	};
>  
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&volume_up_n>;
property-n
property-names

> +
> +		key-volume-up {
> +			label = "Volume Up";
> +			linux,code = <KEY_VOLUMEUP>;
> +			gpios = <&pm8550_gpios 6 GPIO_ACTIVE_LOW>;
> +			debounce-interval = <15>;
> +			linux,can-disable;
> +			wakeup-source;
> +		};
> +	};
> +
>  	pmic-glink {
>  		compatible = "qcom,sm8550-pmic-glink", "qcom,pmic-glink";
>  		#address-cells = <1>;
> @@ -426,6 +442,16 @@ &pcie0_phy {
>  	status = "okay";
>  };
>  
> +&pon_pwrkey {
> +	status = "okay";
> +};
> +
> +&pon_resin {
Not alphabetically ordered

Konrad
> +	linux,code = <KEY_VOLUMEDOWN>;
> +
> +	status = "okay";
> +};
> +
>  &pm8550_flash {
>  	status = "okay";
>  
> @@ -450,6 +476,16 @@ led-1 {
>  	};
>  };
>  
> +&pm8550_gpios {
> +	volume_up_n: volume-up-n-state {
> +		pins = "gpio6";
> +		function = "normal";
> +		power-source = <1>;
> +		bias-pull-up;
> +		input-enable;
> +	};
> +};
> +
>  &pm8550_pwm {
>  	status = "okay";
>  
> 
