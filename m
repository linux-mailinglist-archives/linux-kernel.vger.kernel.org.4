Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC86686AA1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 16:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbjBAPsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 10:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232411AbjBAPrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 10:47:45 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8207974C17
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 07:47:39 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id m2so52199148ejb.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 07:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CB3wh5f+THhy2cQwYNaHueXz/AItW78u+yaM6hw2oOk=;
        b=di/IZ0yW16zjDBFX+EIkg8KlQ0FAluKvPy0aQzKTaTC4CVfT4GFF0R8b7UJtvzbgCL
         a4h2q2ThgyTuC+6Z/8ONZ4b+cXka/zy4GTQ42ezLELODu7cOl2wyUy+egJ2Y4/rry9Kd
         K5YRFUK3S5BcT0lINtdjLGBB/gC2S1M6aoetO7IVuEVbeWF0/z7mAEsunq725hnMvgwr
         3+emQinI6kSHwh2qIqXJCWzTLx8lRpYE9pQl3eluaQsunK5tpPoMOCbqkK7p5PnRgjI8
         3YNUgvORG56RQ8b9qS9U1fhge67yOjXn436ULpbBaneiQW4XvCpQzeo1XlpTIFkEhtU9
         CU9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CB3wh5f+THhy2cQwYNaHueXz/AItW78u+yaM6hw2oOk=;
        b=NcycD0WaaksgreRDX7whD7aEA5uherMe/LWMINYhOEYvwtsfj8ilx8yvwIUy9T6mF5
         8zHWhYnk10T56KlEYvQmKcjPLJKzD9DD+//fMhX+dSDPc3Z9LnPTy7aT2+LqArPjPUH6
         oVhcTR5wb6N+NbxD7p1cve+vju4tzk9KwLo5/n4Rr0QLV5qAmVOtHSBWvicPaJurqLJQ
         8lwyAcbZBKHpCi1BzWtFI/hXrRkPna186/NlQFLzY5vkIHWSer/zXEO04beP2zNNuMW6
         nfJa1+DusSBaflcqna63FYDrltLYo7R4hqW7FnMnvJbZGD4rZ4j5Ap8SmVatXIOlClBW
         C3sw==
X-Gm-Message-State: AO0yUKWMpyQpqKu3m3OP3h+ag4KwsTd1t7ZP8W+KJgf6wgpD7CvO7bTQ
        ufHbTb/wW6yL0eAyPmdRGsLMdA==
X-Google-Smtp-Source: AK7set91LQojQuI++r1pY+kClfznLC0f6ev0zKYLWFqTQWUqvX3IIECB3wjcE5eOqxRtO7ypzh0YSw==
X-Received: by 2002:a17:907:c20c:b0:883:3661:97e5 with SMTP id ti12-20020a170907c20c00b00883366197e5mr2256291ejc.50.1675266458108;
        Wed, 01 Feb 2023 07:47:38 -0800 (PST)
Received: from [192.168.1.101] (abyl20.neoplus.adsl.tpnet.pl. [83.9.31.20])
        by smtp.gmail.com with ESMTPSA id ed10-20020a056402294a00b004a236384909sm5624536edb.10.2023.02.01.07.47.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 07:47:37 -0800 (PST)
Message-ID: <87f4ba93-e566-821b-8f12-8765436e0791@linaro.org>
Date:   Wed, 1 Feb 2023 16:47:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sm8350-hdk: correct LT9611 pin
 function
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230201154321.276419-1-krzysztof.kozlowski@linaro.org>
 <20230201154321.276419-2-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230201154321.276419-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1.02.2023 16:43, Krzysztof Kozlowski wrote:
> SM8350 pin controller does not have "normal" pin function, so use
> "gpio".
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Makes one wonder if it was ever tested, as this would have probably
failed when setting pinctrl settings..

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sm8350-hdk.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
> index ece1a7cb8b3b..8b7cc45b0919 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
> @@ -725,7 +725,7 @@ usb_hub_enabled_state: usb-hub-enabled-state {
>  	lt9611_state: lt9611-state {
>  		rst-pins {
>  			pins = "gpio48";
> -			function = "normal";
> +			function = "gpio";
>  
>  			output-high;
>  			input-disable;
