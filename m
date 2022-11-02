Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14CA26160EE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 11:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbiKBKg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 06:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbiKBKgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 06:36:19 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BF928E25
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 03:36:16 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id g12so23849549wrs.10
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 03:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from:reply-to
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CM8x/Qx9/7RS3amQWGrUYxIRVWFO9lZpv2GsrWNqh4k=;
        b=DX7fI6DTEHCPP/FVpQSEGpuaDtv379glLpKQ99iQOBYWUcuRnqav21lq0Ws5AEai4/
         NeXQskc8/8TfrU4peWK3RUITh1rR7UtvOMi/2YQn/HwelqRQlQ8+MRD25CfDK7+PN1+L
         U2irnsKKYweKZTZuieps9wnV5yNNWwe6G4ytl9GRZtODSnK/T8zlb1KPdpCSy+5duOGf
         wScyrAFvIrVqwoPLidO52ucF8x0maD+Yy171AM+qkGfsJqgoS7o+Fr2nYZA+Bu3YsQpR
         ymp7pdfSkFPGzX6BRLri/PsOpLvgT2kg7IT7EUYQDYfZ9nIo7hGRmEE9zi9SVHbY+Aqk
         WOVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:reply-to
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CM8x/Qx9/7RS3amQWGrUYxIRVWFO9lZpv2GsrWNqh4k=;
        b=Yua4mO4DeifgjtyKWuNjsihaIbCuPbIs0wBaFaGdOqYa2mI7c3KTAxfn74h7f6YTWh
         UkD9n90Jv4lMQbGAASOXtOP135Mfprcy03bWBJ9Cp0VdC7ETspsOqXy9emy3lS+tSCM6
         28wkORfMTz7yfTjgSLc41xrri7V3INHQGsvPy2ibin6n7SY2KZKfHiXsh3mG8n+Z4Q3E
         vj6IvwepTsyaEEn+u9wbIcZsKdvHxrGdV4EClRgJz7li+bdh/JS5JE3ciIkF/9n/eK+t
         wO6RFxA3zU3bxT5Jk1C4PJk9yzXwhiRm1dc1SYbuaFddLg7WCS4SkZzRONUGy3ow0vUJ
         eZ0A==
X-Gm-Message-State: ACrzQf0PFM6dIHXthJn7JBskfXKU6jOR9yIsIT4X3gaSpMWhuE3gdIiR
        41vr641ddp6saLEmyV9g1XrhEg==
X-Google-Smtp-Source: AMsMyM4kw9f2DyP33KZdpJA2QqtXKrqv4z8u4KP2BVpfVbsc/7mzK7syC0R11W6S6qsmbbBLyTQxsQ==
X-Received: by 2002:a5d:4f09:0:b0:236:a983:ae5c with SMTP id c9-20020a5d4f09000000b00236a983ae5cmr14099973wru.708.1667385375804;
        Wed, 02 Nov 2022 03:36:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:6bae:ac40:a798:cbb4? ([2a01:e0a:982:cbb0:6bae:ac40:a798:cbb4])
        by smtp.gmail.com with ESMTPSA id x21-20020a1c7c15000000b003b492753826sm1539798wmc.43.2022.11.02.03.36.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 03:36:15 -0700 (PDT)
Message-ID: <46019893-5c27-086b-1a78-90f6ed1e8af7@linaro.org>
Date:   Wed, 2 Nov 2022 11:36:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 3/3] ARM: dts: qcom: pm8941: rename misc node name
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        afd@ti.com, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221031175717.942237-1-luca@z3ntu.xyz>
 <20221031175717.942237-3-luca@z3ntu.xyz>
Reply-To: neil.armstrong@linaro.org
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <20221031175717.942237-3-luca@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/10/2022 18:57, Luca Weiss wrote:
> The spmi-pmic bindings is now using usb-detect@ for this node, so adjust
> the dts to match.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>   arch/arm/boot/dts/qcom-pm8941.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-pm8941.dtsi b/arch/arm/boot/dts/qcom-pm8941.dtsi
> index 7a4467e03aa1..863e598591b7 100644
> --- a/arch/arm/boot/dts/qcom-pm8941.dtsi
> +++ b/arch/arm/boot/dts/qcom-pm8941.dtsi
> @@ -27,7 +27,7 @@ pwrkey@800 {
>   			bias-pull-up;
>   		};
>   
> -		usb_id: misc@900 {
> +		usb_id: usb-detect@900 {
>   			compatible = "qcom,pm8941-misc";
>   			reg = <0x900>;
>   			interrupts = <0x0 0x9 0 IRQ_TYPE_EDGE_BOTH>;


Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
