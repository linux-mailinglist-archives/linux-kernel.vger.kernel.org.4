Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0C6735837
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 15:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjFSNOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 09:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjFSNOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 09:14:39 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6EBE74
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 06:14:33 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f849a0e371so4293934e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 06:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687180472; x=1689772472;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3V88tgTy2Oq43K7mSvVDSYb4+JWi1+bC1S0A+SLW2xU=;
        b=Id23VFiBlm2EjAN3qHakK844pf1Kk3dzIdn1MWkMZr68cQt+r4adwE8Lr1ReoOQrfU
         1B0FE/6/99t1yFY+YIGBIQJuCJ12WW35D/6PdsYYx+S2dnUUtaiUR5/KXj4l0zDdyYja
         MONv0yQ6UL+xOG6wXDtfMmk2rqikTmOuumpjK+5LNKPMeEdGeY6hbnu4ayTuCkeViIWO
         XOqn/IsAxgYeuhtIeys9oMa0K+BL73qHjvSdeViLkqw6DFNgrjanwsZt0/6e6IhSnBKe
         ptjg3GF+Ww6BPTNi+oi5AJyUDDpd1vYe9pgHZBrqzcNJxdaJ9/MorUmk43eFUHpfcE/y
         2J6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687180472; x=1689772472;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3V88tgTy2Oq43K7mSvVDSYb4+JWi1+bC1S0A+SLW2xU=;
        b=EDcztrtMYNCMQ2RjhumZYXHPEIoXztX+Sd2pzEFMK29V351EKURG8b5EG0/mZ+anki
         loRgLb/Qgc+DnrN3RW+KMOGXrw9N+0kwGlTb49dJCRRIRiN2NLZ3egZyOl9ctFy18f4Q
         qELNIaP4EKNJmM7PuRJrIVDW8ebNBRtE8hBmDIrNcFxi05Q4f433aNR75q2WnBKhq+Xf
         IDyCI4fKvZTK6fAYyMAQYwrFPgOUwaxenrrk4R4npj64jICbBlJAIXskEpX3tJ4LIRUX
         DJo1YKtZm91m3tPk7oUHnz8vcUfFrZv0aGI+Z63/dS60z9P6FNp97754wNuLgcHvNkS5
         zG3Q==
X-Gm-Message-State: AC+VfDxJF8hH2JSK7apFpX8Sry9CkdPCHxE/HxeiTfGwTzaKstH3IWay
        98bEk2r9XJTAmLiqkCvpgERkNQ==
X-Google-Smtp-Source: ACHHUZ7TeuRP+EVScfPBYu5Ftyhevg7WgW0GnXpvi29cpx4NtmHdYr9gS1d/4BybmzRFQoqmq0Npyw==
X-Received: by 2002:a19:6d12:0:b0:4f5:a181:97b8 with SMTP id i18-20020a196d12000000b004f5a18197b8mr4577942lfc.25.1687180472154;
        Mon, 19 Jun 2023 06:14:32 -0700 (PDT)
Received: from [192.168.1.101] (abyl242.neoplus.adsl.tpnet.pl. [83.9.31.242])
        by smtp.gmail.com with ESMTPSA id s7-20020ac25fa7000000b004f37b88eacfsm960609lfe.187.2023.06.19.06.14.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 06:14:31 -0700 (PDT)
Message-ID: <29f6fb78-c122-2b71-61b8-2dc9aa27ad1d@linaro.org>
Date:   Mon, 19 Jun 2023 15:14:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 09/15] arm64: dts: qcom: sc7280-crd: add dummy Bluetooth
 VDDIO supply
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
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
References: <20230617171541.286957-1-krzysztof.kozlowski@linaro.org>
 <20230617171541.286957-9-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230617171541.286957-9-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.06.2023 19:15, Krzysztof Kozlowski wrote:
> Bluetooth requires VDDIO supply.  Due to lack of schematics provide
> something dummy to satisfy `dtbs_check`:
> 
>   sc7280-crd-r3.dtb: bluetooth: 'vddio-supply' is a required property
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
For this:

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

+CC Doug to perhaps fix this properly (though I think we should have got
it through the cros list anyway)

Konrad
>  arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts b/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts
> index afae7f46b050..b1aa5b0ee95c 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts
> @@ -24,6 +24,13 @@ aliases {
>  	chosen {
>  		stdout-path = "serial0:115200n8";
>  	};
> +
> +	bt_vddio: regulator-bt-vddio {
> +		compatible = "regulator-fixed";
> +		regulator-name = "bt-vddio";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +	};
>  };
>  
>  &apps_rsc {
> @@ -38,6 +45,10 @@ vreg_s1k_1p0: smps1 {
>  	};
>  };
>  
> +&bluetooth {
> +	vddio-supply = <&bt_vddio>;
> +};
> +
>  ap_tp_i2c: &i2c0 {
>  	status = "okay";
>  	clock-frequency = <400000>;
