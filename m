Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F9F70717E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 21:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjEQTHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 15:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjEQTHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 15:07:15 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886C51FFA
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 12:07:12 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-965cc5170bdso178923766b.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 12:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684350431; x=1686942431;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sjU63skqCTcgfqPTFoQRuF0AORaTbY/dYzoZwYojga4=;
        b=z3HRdzYzgb7UjvGGZLE0de4RfGjaC3dI0a5ll2R9nl/7xPCLVCo6CX8Q+/eerHdHrA
         4tmNsl3Sx/I7IroS6mDSOx6dq1wo8qrru60XTcxUHwPGg3yeYmf7tgbXlZgiAvrioC2T
         diG3ZxUu5VsXgk41DBmU10v8tBjqQAvrecXI6ZsAkiU4yTYwMXO86rxvoVH0fwYSkgrj
         IF85hR4z3BqaWt1enBIlbjTdw9ii3619h0krlsqr+NNP6I1hQjehH0zS0c1gADaIBKg7
         97WLq08U44+9SpvlzXtiT44t7eFJdS0f9+qxVOxWiO+f16TT67aOJtSm9Axabe69fh0P
         BJgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684350431; x=1686942431;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sjU63skqCTcgfqPTFoQRuF0AORaTbY/dYzoZwYojga4=;
        b=VUnfMc53tFkfLItIkVr/ZjxfpQxdJ9LdgNcIm9cyfH3Vm5hNGrYivKNK6d/quIabUx
         47PgKCIh2XfCpB+rSdLtOubo0WezpfUdFVJyNPMbF/QpUcUADb7Se3pm6zKBBxQVPgf4
         tmsGnTKDG9d6TXhsXZ4y89KGATpKjgtC+DAtMPImOtqIFtRLp4Y23Dx7x1bB9HD5hlR0
         l7LPqJ4ilPTE4RrLMAZsTsKhs/oruwP0CQKiHEQmqJ1++GZTu11DMyxGhRZGGr/QoPfu
         gbZ/aFZQN/2fePR+WUf461xrbxf0tTQR5zY5oaI7fXoFqiLX4z39hRzN6slJr8QUTgBk
         z5/g==
X-Gm-Message-State: AC+VfDwSrUMYObYPy3Fo2X7EeMAu2q7QL2KkuCCfUI+RseBq3LCsP0LN
        liQVpqq/Njk/EcWjzB1PSe2Tdg==
X-Google-Smtp-Source: ACHHUZ5B92EqkTOQwxl3OS8GU6Zy19JKsxA9kUMtqvA27n8/1/XjFdFaEe6RdAnyp6Qb4IEtOSqE5Q==
X-Received: by 2002:a17:907:7b98:b0:947:55ad:dd00 with SMTP id ne24-20020a1709077b9800b0094755addd00mr40841052ejc.26.1684350430968;
        Wed, 17 May 2023 12:07:10 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d7a:e7cc:21b3:c435? ([2a02:810d:15c0:828:d7a:e7cc:21b3:c435])
        by smtp.gmail.com with ESMTPSA id hs32-20020a1709073ea000b009534211cc97sm12663542ejc.159.2023.05.17.12.07.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 12:07:09 -0700 (PDT)
Message-ID: <a10695f5-e7d6-7fac-695c-a5b1c17ad56a@linaro.org>
Date:   Wed, 17 May 2023 21:07:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] arm64: dts: qcom: pmi8998: add flash LED
To:     Dylan Van Assche <me@dylanvanassche.be>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        amartinz@shiftphones.com
References: <20230517182133.72590-1-me@dylanvanassche.be>
 <20230517182133.72590-2-me@dylanvanassche.be>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230517182133.72590-2-me@dylanvanassche.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2023 20:21, Dylan Van Assche wrote:
> Qualcomm PMIC PMI8998 has a 3 channel flash LED driver which is used
> by many phones for 1 or 2 flash LEDs. Each LED can be used in flash mode
> or torch mode. Add the flash LED node to PMI8998 DTS.
> 
> Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
> ---
>  arch/arm64/boot/dts/qcom/pmi8998.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/pmi8998.dtsi b/arch/arm64/boot/dts/qcom/pmi8998.dtsi
> index ffe587f281d8..89f959353ad5 100644
> --- a/arch/arm64/boot/dts/qcom/pmi8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pmi8998.dtsi
> @@ -60,6 +60,12 @@ pmi8998_lpg: pwm {
>  			status = "disabled";
>  		};
>  
> +		pmi8998_flash: led-controller@d300 {
> +			compatible = "qcom,spmi-flash-led";

This cannot be alone.

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).

Best regards,
Krzysztof

