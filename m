Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72FA26E9087
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 12:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234783AbjDTKmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 06:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234630AbjDTKmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:42:23 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE9C4C31
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:41:19 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2a8a6602171so4198001fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681987278; x=1684579278;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yYJib+KQpRN6Chzv9c6xYxJsgyv5cT5aVycO+xQckao=;
        b=VBUTkbmrolkfG2HfEcgTK0vDuXwjt6JD29+KkTRVwL/3szw1ASTwqK1tfPffuYb3Ji
         4K4Ijw7CasoMUf2pLiGr35Pi2Fq+YlI1U9gBRhSYZU/n9WO/Dlnn/Iot3GjzKtMNKJSX
         IGhL2vLPMC8YaqZrO9s5cF94R+Lk9D/kQS0YfhA5o+++uBY3xX3AY/BXKZJqBDZQ8N2W
         UJKvF9GQOlRcofDCf8qU5zmjTINV78rsbZPBgktwrn6hqTJrpuAENz8nQCZSmzSqGjXi
         eiPxN7VA1HwSY4kRvGLYqn/85LfagJEtte9GsiNFUYkUOjimR4Plwydj9uxVJA0yQo+t
         6kvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681987278; x=1684579278;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yYJib+KQpRN6Chzv9c6xYxJsgyv5cT5aVycO+xQckao=;
        b=l8ndGtUslqFulhW/QtmIhBd9HOEs15tZXcwkWbmdEUyDdw3wbCQb3QOXJCiC1hN5q0
         yIZVSt0Qhu7sLgZTlxK2k3nj+iwuxbuz+dHaat4e2unIkiPK4aMqFuZPSFS4eO/F2BqI
         LUOuYhUh5dmvj/HFKKpG+JBsJDmR4V2pzbcYjXVyyyw2nFFmurKrvNU8FXfsv1JMyy0l
         SMn1iYVWAscfzPZ8HCU7pVNy6d8PpcIwSW2j/S4XQj04E32r9HEVGGURhdHOctWlBGnl
         Xe/aozhYPqy59JUnP8yZUBsBPEFxwczdQaivtNZbX3NrGqe9dlyNK4tSv88gueAvz6jJ
         k0Fw==
X-Gm-Message-State: AAQBX9eaG+eplh/a56feFJw/p4TLPWF0rmZUD2fhdp00TAk/TAsF2XAd
        4bZ3J4rx1+iyVgONxpmV5ZjueA==
X-Google-Smtp-Source: AKy350bflVL4FNLvEiOCx3SDmmD4O9EV3jKBx3p9B/hdDwhOXn3V1VVtrkWhvhhaPJtrfxeCjcsQ4A==
X-Received: by 2002:ac2:5550:0:b0:4db:4fe8:fd0f with SMTP id l16-20020ac25550000000b004db4fe8fd0fmr302284lfk.25.1681987278035;
        Thu, 20 Apr 2023 03:41:18 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id e13-20020ac2546d000000b004b567e1f8e5sm174205lfn.125.2023.04.20.03.41.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 03:41:17 -0700 (PDT)
Message-ID: <2549bb8a-c64f-ee23-307a-1e39a86d9814@linaro.org>
Date:   Thu, 20 Apr 2023 12:41:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] dt-bindings: thermal: qcom-tsens: correct unit address
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230420072429.36255-1-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230420072429.36255-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20.04.2023 09:24, Krzysztof Kozlowski wrote:
> Match unit-address to first reg entry.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> index b6452ed78802..d9aa54c11663 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> @@ -328,7 +328,7 @@ examples:
>    - |
>      #include <dt-bindings/interrupt-controller/arm-gic.h>
>      // Example 1 (new calbiration data: for pre v1 IP):
> -    thermal-sensor@900000 {
> +    thermal-sensor@4a9000 {
>          compatible = "qcom,msm8916-tsens", "qcom,tsens-v0_1";
>          reg = <0x4a9000 0x1000>, /* TM */
>                <0x4a8000 0x1000>; /* SROT */
> @@ -358,7 +358,7 @@ examples:
>    - |
>      #include <dt-bindings/interrupt-controller/arm-gic.h>
>      // Example 1 (legacy: for pre v1 IP):
> -    tsens1: thermal-sensor@900000 {
> +    tsens1: thermal-sensor@4a9000 {
>             compatible = "qcom,msm8916-tsens", "qcom,tsens-v0_1";
>             reg = <0x4a9000 0x1000>, /* TM */
>                   <0x4a8000 0x1000>; /* SROT */
