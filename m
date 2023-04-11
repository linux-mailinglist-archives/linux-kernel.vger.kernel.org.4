Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3602B6DD8DC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 13:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjDKLGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 07:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjDKLGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 07:06:02 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F352420A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 04:05:45 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id d7so20954544lfj.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 04:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681211142;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FGoMp9jrWiv4D2uEfNBy/ctjAgVhDYetWYxNpQhTgtc=;
        b=UOdX+ACwVtbooY89XuZbEZ3qt3sRs7J4fWm1o7kypXtJRlxYb/FDOlOcjsudRNiZKf
         nGtJRceLtl479oNoARGt1Z+zZZneoPKI2l8ZyhzcF+O+i0N47LjgUM5RohObK5/f323O
         QL5sE4zN9yzCsKmcLh5QTa9JJOy5pO5983gzJt7pgUW/H0UPrRt5ahNrXOxzqeIV/PO8
         w9PQt8DfFxT+0EHfGHUo2fpb7YG7hj3cr7d4aWHFtTMwqoKtgQXImg+EQGrOX9Z4dAtC
         LE7S8Uy42bwbPmBojAul/epzN/hb2qQvdpFr3RmgzmJBw3H32at8nMzbTbGtQXXvdyQH
         N7Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681211142;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FGoMp9jrWiv4D2uEfNBy/ctjAgVhDYetWYxNpQhTgtc=;
        b=BrVui6H4F1a99/yIcxN9lxjijylim005WK4qVvvnW2+Dgfh0NEHQKeg2b20QMYHJ5S
         yy9tC4Leh02ey49anctsAB9sCc4rZOEIN1bYyVhmfZAHREK0puaJgWz7ZHSfaKr52BJd
         J+jKBTvASPL37MR0Wc3wiSrYXu+OUa9mHI7NhcaIFRnc+Yk/P8XGsYXm2owzK8uI/2vY
         AE0AvFm7MEzOnWc4mWtSDfYOdw5sLSHEavufV4/fGcuzLZfW6FvRN6OOq6lYx/qu9Ixd
         hYceBAXs1OZgaFLyncGC2R0F6u80hN/yy5WFRBGu8V3mA3Sd+21fZloWVafwRu6PtCKn
         dWtQ==
X-Gm-Message-State: AAQBX9eaCyLLXglywVV7Bbc0Ys7yqYQPWb4pttfQNORGsOhUi2Vun4i3
        njektPRNi0YHeJRiEye4yhznIw==
X-Google-Smtp-Source: AKy350YxbEmoseDIOSy/3xVBbfG0YW1u/HFCga6nwgAPiCkAieyr9cUaiJwAZ5+LJVX8cc0juldb0Q==
X-Received: by 2002:ac2:562b:0:b0:4da:e925:c95b with SMTP id b11-20020ac2562b000000b004dae925c95bmr4718273lff.62.1681211142120;
        Tue, 11 Apr 2023 04:05:42 -0700 (PDT)
Received: from [192.168.1.101] (abxj23.neoplus.adsl.tpnet.pl. [83.9.3.23])
        by smtp.gmail.com with ESMTPSA id h17-20020ac250d1000000b004d545f1e0ccsm2510931lfm.187.2023.04.11.04.05.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 04:05:41 -0700 (PDT)
Message-ID: <b42f7c48-84b1-1e50-bcad-1bf5edf1a168@linaro.org>
Date:   Tue, 11 Apr 2023 13:05:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 1/3] ARM: dts: qcom: apq8026: remove superfluous
 "input-enable"
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230410181005.25853-1-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230410181005.25853-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10.04.2023 20:10, Krzysztof Kozlowski wrote:
> Pin configuration property "input-enable" was used with the intention to
> disable the output, but this is done by default by Linux drivers.  Since
> patch ("dt-bindings: pinctrl: qcom: tlmm should use output-disable, not
> input-enable") the property is not accepted anymore.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm/boot/dts/qcom-apq8026-asus-sparrow.dts    | 2 --
>  arch/arm/boot/dts/qcom-apq8026-huawei-sturgeon.dts | 1 -
>  arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts        | 3 ---
>  3 files changed, 6 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-apq8026-asus-sparrow.dts b/arch/arm/boot/dts/qcom-apq8026-asus-sparrow.dts
> index 7a80e1c9f126..aa0e0e8d2a97 100644
> --- a/arch/arm/boot/dts/qcom-apq8026-asus-sparrow.dts
> +++ b/arch/arm/boot/dts/qcom-apq8026-asus-sparrow.dts
> @@ -268,7 +268,6 @@ bluetooth_default_state: bluetooth-default-state {
>  		function = "gpio";
>  		drive-strength = <8>;
>  		bias-disable;
> -		input-enable;
>  	};
>  
>  	wlan_hostwake_default_state: wlan-hostwake-default-state {
> @@ -276,7 +275,6 @@ wlan_hostwake_default_state: wlan-hostwake-default-state {
>  		function = "gpio";
>  		drive-strength = <2>;
>  		bias-disable;
> -		input-enable;
>  	};
>  
>  	wlan_regulator_default_state: wlan-regulator-default-state {
> diff --git a/arch/arm/boot/dts/qcom-apq8026-huawei-sturgeon.dts b/arch/arm/boot/dts/qcom-apq8026-huawei-sturgeon.dts
> index d64096028ab1..5593a3a60d6c 100644
> --- a/arch/arm/boot/dts/qcom-apq8026-huawei-sturgeon.dts
> +++ b/arch/arm/boot/dts/qcom-apq8026-huawei-sturgeon.dts
> @@ -352,7 +352,6 @@ wlan_hostwake_default_state: wlan-hostwake-default-state {
>  		function = "gpio";
>  		drive-strength = <2>;
>  		bias-disable;
> -		input-enable;
>  	};
>  
>  	wlan_regulator_default_state: wlan-regulator-default-state {
> diff --git a/arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts b/arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts
> index b82381229adf..b887e5361ec3 100644
> --- a/arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts
> +++ b/arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts
> @@ -307,7 +307,6 @@ bluetooth_default_state: bluetooth-default-state {
>  		function = "gpio";
>  		drive-strength = <2>;
>  		bias-disable;
> -		input-enable;
>  	};
>  
>  	touch_pins: touch-state {
> @@ -317,7 +316,6 @@ irq-pins {
>  
>  			drive-strength = <8>;
>  			bias-pull-down;
> -			input-enable;
>  		};
>  
>  		reset-pins {
> @@ -335,7 +333,6 @@ wlan_hostwake_default_state: wlan-hostwake-default-state {
>  		function = "gpio";
>  		drive-strength = <2>;
>  		bias-disable;
> -		input-enable;
>  	};
>  
>  	wlan_regulator_default_state: wlan-regulator-default-state {
