Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69DE5686A9D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 16:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbjBAPrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 10:47:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232411AbjBAPqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 10:46:50 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190AA728E5
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 07:46:49 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id ml19so29096085ejb.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 07:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iNNBTT8NKx1pmMcPyMNzrgt3Jltr5D6oiqmx9nGMP4A=;
        b=PKDwdJroqqf09JySUscv/stK9ZJvU2oAUgFRr3bTYFBwQu+wRiVfBSWyZDH+Uc7ftG
         x+qQ6yqzCkKvDYdmBQjOAK9OF/L2la5xlytS5O67ib2BBuKHiBGNZzYSR3ZIZYR+4sEX
         Ylkn1xznYlCGfxbuNvEAOx4m+97GtzeKAMmeRJe43rye3ir+2X0QsHI4RKGIuoaCPrZ8
         nHOaPIAkKRy5paSU5xse+oPH+IMgEfT0q9RNv5ZqlMcMQ+eE6YonDKAzURDUiwA4sWGK
         ROESdam4npD9Vuu+RqwRQ2+ckEw1EZADNAbOZSytFKCJo8pVlJTGNSS1wemhefNKi5ma
         H7XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iNNBTT8NKx1pmMcPyMNzrgt3Jltr5D6oiqmx9nGMP4A=;
        b=5TegpPesU+QMMuC4vLh2Q7cGTPFX3letU9XWDhFF+Tz6KrJqbw5VaqtWzaEC95k0PO
         4r8DM0vtN3HN55KzgXVFGMnvBf69sv7omde48GAjc+daosz8No9bBTZVv1/NlysDioP6
         Cy7/hDh3QoU1lT4cmLVfhMEhOzElbS/s9TfwmBmjWxXg3AGhf6GEBFJOKeh/sGdp87Yp
         YHgZAxIhfnRlFpKrJdvsZywFc6TKZXZqubV+0pEi5quaCTTN75IlqucRuC8qoCCQl3tt
         0bfvqTO8mG50VuqN/Yazywem6h1o6ny6z1LIZr5z2ABD1L2JHYtuwsGNTzyWNuZhpjqF
         k7eA==
X-Gm-Message-State: AO0yUKX0NgfrN6fzRRpFqEExAiE84fZ1vRK1R1/qv1sElhkwBY5MFbLp
        pkECsielFjWIRAWDiWtF1HA7RQ==
X-Google-Smtp-Source: AK7set/fEH43rK5bc989YNeo0PEl+O1mNY7fIZkflRiZY9ycUzSwrZId4fllad9h3LKl4zGryZTtpQ==
X-Received: by 2002:a17:907:2bd1:b0:888:7d50:33b4 with SMTP id gv17-20020a1709072bd100b008887d5033b4mr2811205ejc.34.1675266407666;
        Wed, 01 Feb 2023 07:46:47 -0800 (PST)
Received: from [192.168.1.101] (abyl20.neoplus.adsl.tpnet.pl. [83.9.31.20])
        by smtp.gmail.com with ESMTPSA id p17-20020a170906b21100b00886c1a02d20sm5861929ejz.47.2023.02.01.07.46.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 07:46:47 -0800 (PST)
Message-ID: <844ecb2f-e398-1187-810a-4f24372bd189@linaro.org>
Date:   Wed, 1 Feb 2023 16:46:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 1/3] arm64: dts: qcom: sm8350-hdk: align pin config node
 names with bindings
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
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230201154321.276419-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1.02.2023 16:43, Krzysztof Kozlowski wrote:
> Bindings expect pins to be named with certain pattern.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
Do we want a Fixes: here?

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> 
> Endless work... People keep sending patches without running dtbs_check
> faster than I am fixing existing warnings.
> ---
>  arch/arm64/boot/dts/qcom/sm8350-hdk.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
> index df841230d1b7..ece1a7cb8b3b 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
> @@ -723,7 +723,7 @@ usb_hub_enabled_state: usb-hub-enabled-state {
>  	};
>  
>  	lt9611_state: lt9611-state {
> -		rst {
> +		rst-pins {
>  			pins = "gpio48";
>  			function = "normal";
>  
> @@ -731,7 +731,7 @@ rst {
>  			input-disable;
>  		};
>  
> -		irq {
> +		irq-pins {
>  			pins = "gpio50";
>  			function = "gpio";
>  			bias-disable;
