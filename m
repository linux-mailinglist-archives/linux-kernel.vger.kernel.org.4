Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F79D6277A8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 09:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236445AbiKNI3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 03:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236444AbiKNI33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 03:29:29 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848EE1A81E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 00:29:25 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id p8so18046208lfu.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 00:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B2Q+wDnMcLAR39alDRY9HqBEqFLD90Ds2DBuc9+51tk=;
        b=SPHsMEveqZPT1xDI0U35ttjRFZhE4T9hBY6D+7sBIIkfgxMhpwPM3gc06JDmKAhJ2Z
         MdQHpHqYNISfrwDwr6PzOO6U3qQy4I8CMfu281OerF3IkYoaMosvzb1P6KZjezBbLbFV
         QaTOhPymclukhK6E7QhRW84IY3u0/Vdzhv4bZFFL5ZPj614tD/b9gSa20Oa/UWpgX5Zt
         PnAL3RpF2oD8vdyxOat4kuVTgnJTMTB6VquQ0st1ILXiifcsxSEFOocKBoiFq+suAYzx
         d3wC3aUSNLRP7YAzm0Js7uDclRXRWh/E02EErFk+gTSO4V29Ds5A+P9CR9E/lNIh+Dtd
         vMqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B2Q+wDnMcLAR39alDRY9HqBEqFLD90Ds2DBuc9+51tk=;
        b=vnXLkxVMQUX5t8wv4tTXGYsgFZd1FQ+h/GErbbLj6kfgrI77Zxcdm/vGnKIzMSPVyz
         X283/hcv65tCJHCInnybtkkc4OzMUbiKGKPApy780FF+SliToCt9Ux8glXuCIEHEhrrR
         Gn5MNz0MAA0P/VXuG5JnKFPwSsTq34n8NYFm9TdLxCKgw85UK2P3MYR4S9v55ZWwSF05
         H5INcJSJVICuz8xRpbD2mbvwo5Twu3W2Igm2g+qWHX+1pYbqn2scqC4hoYvA/UlgWtGz
         U8lb1ppRF7WPUiA7VJ30U5b+b+j2A0IKu0kH/y6Q/ULVUbSPxqGsEyJHDTIawNwzCIjo
         dwDw==
X-Gm-Message-State: ANoB5pks3kmjZcTHfX4Rp3LTEQ/fx05YSffkwfEK/8jRR+AuddifDkox
        PNdHltRWHM3Cg611b+zK3Ap/LQ==
X-Google-Smtp-Source: AA0mqf7SvWBLHSCHU2EvvcgDyoJ64VwSuetOmzhz9SQsEwE8KEXrGXWWqcI1/T77tFzmytYIqpLMvw==
X-Received: by 2002:a05:6512:a86:b0:4b4:1048:42e6 with SMTP id m6-20020a0565120a8600b004b4104842e6mr3531270lfu.108.1668414563841;
        Mon, 14 Nov 2022 00:29:23 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id l10-20020a056512110a00b00494813c689dsm1730007lfg.219.2022.11.14.00.29.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 00:29:23 -0800 (PST)
Message-ID: <8eebfb8a-505e-3d6a-3274-d51a60742a08@linaro.org>
Date:   Mon, 14 Nov 2022 09:29:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 3/5] dt-bindings: net: ipq4019-mdio: require and validate
 clocks
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221113184727.44923-1-robimarko@gmail.com>
 <20221113184727.44923-3-robimarko@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221113184727.44923-3-robimarko@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/11/2022 19:47, Robert Marko wrote:
> Now that we can match the platforms requiring clocks by compatible start
> using those to allow clocks per compatible and make them required.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
>  .../bindings/net/qcom,ipq4019-mdio.yaml       | 28 +++++++++++++------
>  1 file changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml b/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
> index 2c85ae43d27d..b34955b0b827 100644
> --- a/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
> +++ b/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
> @@ -9,9 +9,6 @@ title: Qualcomm IPQ40xx MDIO Controller
>  maintainers:
>    - Robert Marko <robert.marko@sartura.hr>
>  
> -allOf:
> -  - $ref: "mdio.yaml#"
> -
>  properties:
>    compatible:
>      oneOf:
> @@ -40,18 +37,31 @@ properties:
>        the second Address and length of the register for ethernet LDO, this second
>        address range is only required by the platform IPQ50xx.
>  
> -  clocks:
> -    maxItems: 1

Keep it here.

> -    description: |
> -      MDIO clock source frequency fixed to 100MHZ, this clock should be specified
> -      by the platform IPQ807x, IPQ60xx and IPQ50xx.
> -
>  required:
>    - compatible
>    - reg
>    - "#address-cells"
>    - "#size-cells"
>  
> +allOf:
> +  - $ref: "mdio.yaml#"
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,ipq5018-mdio
> +              - qcom,ipq6018-mdio
> +              - qcom,ipq8074-mdio
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: MDIO clock source frequency fixed to 100MHZ
> +      required:
> +        - clocks

else:
  properties:
    clocks: false

> +
>  unevaluatedProperties: false
>  
>  examples:

Best regards,
Krzysztof

