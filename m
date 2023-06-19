Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24EC8735861
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 15:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjFSNTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 09:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbjFSNTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 09:19:17 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42A3AF
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 06:19:12 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f841b7a697so4016481e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 06:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687180751; x=1689772751;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yRq4CYO+4MuDV5j8okCm0v3AnA6NcPptEyIiXYTaKWo=;
        b=lPEIN0JL70Zl+kGc/CZNQqcNyLjR1Odv8f+XHsZ8++OmP2bUJ+AoCw7N4cK+LE1qWJ
         5fZ+AHx1LVih0WvXjpUDnWT7JHOBTYRLlsQ1utl/cC+MPtZej/4TMXERUmvaSlt3ifv0
         +Wut7FGggcTzevMKAiuRDQ2xy3NOy0jSZhOGwIXFvkNbmSW/XciZaVsyckSVserDR7iO
         wHj2L326+rHCtx4OPEb70fdElWzIRktVJSS0OBdXVb8rUkMSEtpU/9vTcNB1k8x/HNEK
         l9RLIXF+n06e79u8AxbvmONfcWeBHkRxCu2sWGFFw+W3pDSCHBgiVDroQ1OWybQxnbkX
         5GHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687180751; x=1689772751;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yRq4CYO+4MuDV5j8okCm0v3AnA6NcPptEyIiXYTaKWo=;
        b=YyrjSQh2jQVGi1q8TVZECHsYIoqWZz4ivHoGwlTNILk8pznu5oRAfczrWA/FPn65YW
         lqEkowsyRzyuSOEB4OkHOkW5awOhFu3kZEcZF+83lk/InefnhTLNHN3cXqLPuUPYGnGZ
         bz+8Fw2B5AEQ2FPDCdlV/EOwAafK4+P7aioyYbaryhUv8Qjra9ZRWdBJaXv3kG1/lWNe
         IB/wBE/e63r8rKSIelKqmc4uF99STetYiz6o//X0GzGq9SebPlFISneGsa7w+ZwBDggc
         e1DM/gxrirAG43tFYHB4pZJR1hR1u5FIWbu2lGe/vD+nUg/+atizeGZPxFM5jFvA1A9R
         VaLg==
X-Gm-Message-State: AC+VfDwWDLXL9Vq5d9C9fMh3h4fm/Kg6kT6yT6pvss2t+l5gp/HXnYTi
        27aWjyYgyoeno5Rso+aS0YSnuw==
X-Google-Smtp-Source: ACHHUZ4KqmOED5CoREdA2paWDzEqfu3bGHZlMDOCPDN3vk3VNORkULIqSkx0/q6IRAX3SXqSm2iMvQ==
X-Received: by 2002:a05:6512:609:b0:4f8:57bc:1bbc with SMTP id b9-20020a056512060900b004f857bc1bbcmr5120076lfe.58.1687180751128;
        Mon, 19 Jun 2023 06:19:11 -0700 (PDT)
Received: from [192.168.1.101] (abyl242.neoplus.adsl.tpnet.pl. [83.9.31.242])
        by smtp.gmail.com with ESMTPSA id o17-20020ac24951000000b004f8494363e3sm1736509lfi.16.2023.06.19.06.19.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 06:19:10 -0700 (PDT)
Message-ID: <bc5e6de9-c28c-8ead-799c-8e46752469c0@linaro.org>
Date:   Mon, 19 Jun 2023 15:19:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/3] arm64: dts: qcom: sm8350-hdk: include PMK8350
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230616190222.2251186-1-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230616190222.2251186-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.06.2023 21:02, Krzysztof Kozlowski wrote:
> HDK8350 comes with PMK8350 PMIC, so include relevant DTSI.  This also
> allows to use reboot reason.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

What about the other ones though?

Konrad
>  arch/arm64/boot/dts/qcom/sm8350-hdk.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
> index d33338e9a95f..de67438b3a97 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
> @@ -7,6 +7,7 @@
>  
>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>  #include "sm8350.dtsi"
> +#include "pmk8350.dtsi"
>  
>  / {
>  	model = "Qualcomm Technologies, Inc. SM8350 HDK";
