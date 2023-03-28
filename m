Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD2A86CB7B7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 09:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjC1HLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 03:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjC1HLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 03:11:42 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A04B2D48
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 00:11:41 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id eg48so45480775edb.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 00:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679987499;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a5fyW1eX1RAR+NBmwPpWJ9Jn0eMpcCTBleyehK3tanw=;
        b=yUYRLQb9IVWEbo20PLorrGnjtm3zZiFX+UHX46vIe6ye583NOm04sdjQJF0ruYxHRO
         0wltvHNA3PsMmTaKV7r/wcnE5B0u/pExzwBFBABJtuSlm4nhbXQ58ZrrFMLU5E5KkfT4
         +De9QmNLjfzZ8c85rGnVqsW1mIiSXDoGYpRRDJt7tKagLlUPQ8jV9F33CCKtfUAx1p4T
         JFTUt/iPM5pVFebaNmS7U/DXABCDUyyN8GRG82xvSFPxE/LG7HfnK5YuoEkl5nqEscps
         j+7QIwwHdnLT5AF8F2VJRA2i9nJ34uekIaizThFaUCrtjrRvuZFZL7AlfnSVcaBCQnhF
         m79A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679987499;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a5fyW1eX1RAR+NBmwPpWJ9Jn0eMpcCTBleyehK3tanw=;
        b=RPBoW6BlPZuj1D4G7eEROx14qNKJFKDFbbrBYPdYAUpMYSlHZ10PfqDa+IKy4eVPeh
         KhRng7+irBEJokrM5GB/NaQun39VYdPPTRWMkQ7cdcXMvjmSSXZUWszbeEq9u4K4vvSr
         jB6l8jTgELCqv3oDfftAzigncuRTFWawjtRqSUgps8lVbqiJ//qJWop/lBextYDLusSC
         7aXlEpxGUizqIGx5Rvu3douQhXt4uZ7myDxZl/S9SLyBuaEOJ2zFgnAeN0/5QgX2D3nv
         tyFY1+I7sZ4aSFGYWnQn75pQGcsxKvIqt7qUalOwJd0Y7X+gGzqv+Kjf1FCoZX0/HTLz
         ddjg==
X-Gm-Message-State: AAQBX9fhLXsxzAADbySOV+4yKT2FaMXdWy3skUGhQ5H7VXgO6zMGqG1j
        f31nyJcFiQRwUNb/AFO8kkcERw==
X-Google-Smtp-Source: AKy350bYJuSxq8c07X8GOgM+6HypZc8my/E583ZMsjqpdiOYZOwxDATAJ8NU9HcdX0ogeGKLpjFyIA==
X-Received: by 2002:a17:907:c248:b0:931:ce20:db8e with SMTP id tj8-20020a170907c24800b00931ce20db8emr15303083ejc.51.1679987499545;
        Tue, 28 Mar 2023 00:11:39 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:9e92:dca6:241d:71b6? ([2a02:810d:15c0:828:9e92:dca6:241d:71b6])
        by smtp.gmail.com with ESMTPSA id o23-20020a170906289700b00922547486f9sm15222236ejd.146.2023.03.28.00.11.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 00:11:39 -0700 (PDT)
Message-ID: <a68c7693-9d43-0aa9-c77b-26183e5a0a06@linaro.org>
Date:   Tue, 28 Mar 2023 09:11:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 3/8] dt-bindings: usb: dwc3: Add IPQ9574 compatible
Content-Language: en-US
To:     Varadarajan Narayanan <quic_varada@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        mturquette@baylibre.com, sboyd@kernel.org, quic_wcheng@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-clk@vger.kernel.org
References: <cover.1679909245.git.quic_varada@quicinc.com>
 <526f822a4d2397284f70ba632d92feaa3db0143e.1679909245.git.quic_varada@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <526f822a4d2397284f70ba632d92feaa3db0143e.1679909245.git.quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/03/2023 11:30, Varadarajan Narayanan wrote:
> Document the IPQ9574 dwc3 compatible.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  Changes in v4:
> 	- Update other relevant sections
> 	- Remove constraints not applicable to IPQ9574

No, that's not way to go. These are required.

> ---
>  .../devicetree/bindings/usb/qcom,dwc3.yaml         | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> index a2aabda..3fc8c3c 100644
> --- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> +++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> @@ -17,6 +17,7 @@ properties:
>            - qcom,ipq6018-dwc3
>            - qcom,ipq8064-dwc3
>            - qcom,ipq8074-dwc3
> +          - qcom,ipq9574-dwc3
>            - qcom,msm8953-dwc3
>            - qcom,msm8994-dwc3
>            - qcom,msm8996-dwc3
> @@ -132,11 +133,8 @@ required:
>    - "#address-cells"
>    - "#size-cells"
>    - ranges
> -  - power-domains
>    - clocks
>    - clock-names
> -  - interrupts
> -  - interrupt-names
>  
>  allOf:
>    - if:
> @@ -242,6 +240,24 @@ allOf:
>          compatible:
>            contains:
>              enum:
> +              - qcom,ipq9574-dwc3
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 5
> +        clock-names:
> +          items:
> +            - const: sys_noc_axi
> +            - const: anoc_axi

Heh, do we really need entirely different clock names for each new variant?


Best regards,
Krzysztof

