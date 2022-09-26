Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577DF5E9C8F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 10:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234263AbiIZIyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 04:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233095AbiIZIy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 04:54:28 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3138E3CBD4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 01:54:27 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id h3so6661151lja.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 01:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=e/vHxJ7p3NXVY0RQEho6oW7DtMBKQPU9s2f0ckKs0FQ=;
        b=YiCG1/uTFNivzTFtXwph9hPOB4lNhH0EMID4OBHxvsFVspv2zfS7zN4s68MW9RouLx
         kioCzT8kcbcjw+O1zQk9HRF+BgAyupSV2tB3a4pThfElVq6Zcj9gFbXR5O7w4zNWwPPI
         DD/4PEp2psarS2iYJiK5YiRASThVz9kwidMMzACFvSeb7MoJW87/R10BFtiKGDCIAyfv
         rp8T8LEU2fcbOwHy0Oh8WEqOWgDI7rOCnBKrGmoApY3GS2IyQh1trIJTVH3mU5ePxL4A
         Hhv5E+XA+nTfwMCjHIynUxBoyy5t/94kFxVWw0uJ71tdYQ0GGvhmR3odQoXDM0QFHtca
         A1gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=e/vHxJ7p3NXVY0RQEho6oW7DtMBKQPU9s2f0ckKs0FQ=;
        b=ir+SEPUUIF0PX2ugKPLPItjzbN1y+MGAnubyWlerTb7VWcuxbiYWkNag4pgtRqpezP
         pFD6qc+15uk8USk9HgamoI8sDrT7Qbx9zkWImLP6g2ABsXC5KiZQ9FjWcxq4GHP/TO1n
         BLoVtorxawj3hjfG0YA8BPjuVET7E5+2F3QDb4w1wy7pLXMavOpLyPWcOW+7kxd9EaCJ
         U1pLaEPWjICdQ+2dcCmqmTn97Tt0e2RuoBmu25BrX0EYwfwtJux7BrDF6EopDUC8s1K1
         XbJHUOebO9Wjelef4E35L/EWvHL3NiZk6raoAET12WiFAOj1zW1E4Q4AWaShf9hQ/H1J
         uX3Q==
X-Gm-Message-State: ACrzQf0aFd5v630WXWtgUgcbR5fi19fUkrc7vltjTQRTyYZ2AI9pS04L
        x1LjtpC0LLSFtfwmTj1+rCbW0g==
X-Google-Smtp-Source: AMsMyM4nMe6vdTILQv21uOyEfJPoQ0JN0ZXBUGTtrB+48pEyxgGGeziiN+8WlVSzFlPGauOnlqhQkg==
X-Received: by 2002:a2e:a547:0:b0:26c:6b98:6b2e with SMTP id e7-20020a2ea547000000b0026c6b986b2emr6912902ljn.90.1664182465572;
        Mon, 26 Sep 2022 01:54:25 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id k1-20020ac257c1000000b004947555dbc2sm2474692lfo.100.2022.09.26.01.54.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 01:54:25 -0700 (PDT)
Message-ID: <74ef3de8-5be0-70ec-e34b-717ba93d3d77@linaro.org>
Date:   Mon, 26 Sep 2022 10:54:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 2/2] ARM: dts: qcom: pm8941: fix iadc node
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220925161821.78030-1-luca@z3ntu.xyz>
 <20220925161821.78030-2-luca@z3ntu.xyz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220925161821.78030-2-luca@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/09/2022 18:18, Luca Weiss wrote:
> The iadc node name is supposed to be just 'adc' and the compatible is
> only supposed to be qcom,spmi-iadc according to the bindings.
> 
> Adjust the node to match that.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>  arch/arm/boot/dts/qcom-pm8941.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-pm8941.dtsi b/arch/arm/boot/dts/qcom-pm8941.dtsi
> index 3c15eecf2f21..33517cccee01 100644
> --- a/arch/arm/boot/dts/qcom-pm8941.dtsi
> +++ b/arch/arm/boot/dts/qcom-pm8941.dtsi
> @@ -131,8 +131,8 @@ adc-chan@48 {
>  			};
>  		};
>  
> -		pm8941_iadc: iadc@3600 {
> -			compatible = "qcom,pm8941-iadc", "qcom,spmi-iadc";
> +		pm8941_iadc: adc@3600 {
> +			compatible = "qcom,spmi-iadc";

I am not sure this is correct. Usually specific compatibles are encouraged.

Best regards,
Krzysztof

