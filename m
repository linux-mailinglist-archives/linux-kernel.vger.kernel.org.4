Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90AF17164A3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjE3Ood (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjE3Ooa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:44:30 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C805B2
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 07:44:29 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-96f99222e80so941391066b.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 07:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685457868; x=1688049868;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tDgeJNYR1mRc99Zwj6kB5L18o06yCX2/R5yquqZiFxE=;
        b=s9B2XEAGQnToGrKy96poGs6yBxMIg2mYHKWAVzyLwmGed+drbKC3E4WkNzfMSribiD
         T4dZCqmg1eM6qB2lYjEIWvjlunTeAdG4MgUb/OCX7Js05KGquKhRl+r+fShDpW07OtWD
         tC6GsH1gTz8dkeAh7DrmtXStiLql+G+zBo/+fGoXEoOeDdqvcZK3yeJ4KMOrdVoiHFRs
         Ubxbv0ryCJKqa28BFX6eLF5vJUpFVYZS3/XVdN2e2HR7ZD/i0Xso7l9x5T6qaaGAEEN6
         nArTdsa56zvCs8SDhzENCq/7xLpsdUF7PdTC3+TxZ4iJrANS0I1jR4fJ1wzcHYAc8kQC
         FPDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685457868; x=1688049868;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tDgeJNYR1mRc99Zwj6kB5L18o06yCX2/R5yquqZiFxE=;
        b=fcQ+Zgf1vBa5sRgMKg+C+QYyqmQXvLYtC6bTnRxGyp602FhML2IZoTpK8SSuQVVWvx
         kDtIWgqkxQUpzvp+OVkZRoAp1DYAG3jrYAjN57cCYipfGMEhw+Ci9BTUp4X2BzjxnIbX
         U2UxFG/lCtvyE7YBO2uozmfNRbeKyj0vHmcGdGWl+Piy4XC1p5VWnneO4R+q5sp5Hl7T
         bvgIoNUyFNO83DXA7oq3YLz0s77xxzPJukMwGXcu//CxNO0EU7FTM6m4NiLbdVi5JqqZ
         GZVM2fnvm7sCFBoWwufxHpIj3XwuMms45QoF7HHM0CYGlR9jRXb28HckSEW8S8ep8Na2
         ZeJQ==
X-Gm-Message-State: AC+VfDy9Ay2Ja2PIQf3BC+sD14cOVfTkQjY35tff/apmmMT7H+F1JsJa
        Uv4T0BvyXiN56xj+zN3NKWRJaw==
X-Google-Smtp-Source: ACHHUZ4T5PHcFnaPx8v9mzg3bIbkkS6HlPhAMlCvITGaIHWTSg5GtmcwkVpaT4RExgTL+ftHPEXFZA==
X-Received: by 2002:a17:907:7da0:b0:96f:b40a:c85f with SMTP id oz32-20020a1709077da000b0096fb40ac85fmr10682964ejc.23.1685457867760;
        Tue, 30 May 2023 07:44:27 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id b16-20020a170906151000b0096b15e4ffcesm7415705ejd.85.2023.05.30.07.44.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 07:44:27 -0700 (PDT)
Message-ID: <fdfc568e-703e-6e74-953e-742c00f0b5fe@linaro.org>
Date:   Tue, 30 May 2023 16:44:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] arm64: dts: qcom: ipq6018: correct the qrng node name
Content-Language: en-US
To:     Kathiravan T <quic_kathirav@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230526161138.25497-1-quic_kathirav@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230526161138.25497-1-quic_kathirav@quicinc.com>
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

On 26/05/2023 18:11, Kathiravan T wrote:
> qrng node address is mentioned incorrectly. Lets fix it.
> 
> Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> ---
> Note: Only compilation and dtbs_check is checked. Also dependent on the
> below series, no functional dependencies
> https://lore.kernel.org/linux-arm-msm/20230526125305.19626-1-quic_kathirav@quicinc.com/T/#t
> 
>  arch/arm64/boot/dts/qcom/ipq6018.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> index 0f6d6c6daed2..5d2cc0caf5a1 100644
> --- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> @@ -309,7 +309,7 @@
>  			#size-cells = <1>;
>  		};
>  
> -		prng: qrng@e1000 {
> +		prng: qrng@e3000 {

This was fixed some time ago:

https://lore.kernel.org/all/20230419211856.79332-1-krzysztof.kozlowski@linaro.org/

Best regards,
Krzysztof

