Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 750AC6277AF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 09:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236483AbiKNIaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 03:30:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236438AbiKNIaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 03:30:13 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE53218E29
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 00:30:11 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id t10so12213739ljj.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 00:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6XSzuz/caDzlGdP1JjrgMd0/WGznr0dDZqjNVCNB+/c=;
        b=ndprzE0y2vB4yrX2xSHIt3q999Wbvv14dKKyS/eivQZ5cPpGDBtpiyyPbJKg03z8sw
         MAz6F6u/Y2kMhxwqqJLLOXGX7uI8Y4h9uWtpKZ5ftdHGOMUsO+uHd+mU4g+LoRzSPgWV
         eqf6+skMbanAmr04fIkRXhw01dVgt5vgivhV2qc8ETZfc5RSNWElGKOBrU71PUKc4zb6
         aD5vkU7lN7BDY0nGxzudV6kKUBASKj+9uWDQB3eVQAoYi6omJnP7/f/WesTxmTOjznMX
         grMmhPdgYfkqfCKbI+sFLSKDdwAwnp3W4xAf/JvB9XQEDi5niW8KzQ1XuM/t1QoEZ8HC
         mjgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6XSzuz/caDzlGdP1JjrgMd0/WGznr0dDZqjNVCNB+/c=;
        b=nL7iVwTjFUlM0Sgi3u1Rkerlx64XW8VXN9he/UUPBudoY8y3Gp6qcQxLMg97YNm2X9
         VfYiC1fK/MQq/BtYBGQbpwZC0GjSUOVQUuMs2iaW/ArBroJN5hkSicpJPIJoK3O3I6fx
         eFzj9IWKOlaDlFmHvsxumKOGf4A64FIDac5sMDlJAEenMTbBrBDi7vnc1yBbTlfAEh85
         DflnWG/cmPanl2uWeeo/zZoz/Mbwl5twu6/3GO09TKroxPxluBl0OcqaWtYdttqzEv/3
         n9rbZzd45h8P9lf/icSYCsfIqJ8qB8sAdwHfqyhhQy6OJ+1/8LX67zFq72rgjGq8cL7+
         E5lA==
X-Gm-Message-State: ANoB5pk6plXgizaHkanhfGMKAazmrrYZL3KKLOcUTxN1B3YfL/kbEIaT
        KZW/OL/CzFaBxw0EV8jAQIgIGA==
X-Google-Smtp-Source: AA0mqf6pJJTrohnqE9pyE4pr0wWJ7/cvGGbEUre+MLmNV+ECkh/KlOmRNLdC9kB7sClsGC4o+MPUSQ==
X-Received: by 2002:a2e:7310:0:b0:277:d86:a36d with SMTP id o16-20020a2e7310000000b002770d86a36dmr3653941ljc.288.1668414610128;
        Mon, 14 Nov 2022 00:30:10 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id o21-20020ac24e95000000b004b07cdef19csm1736291lfr.138.2022.11.14.00.30.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 00:30:09 -0800 (PST)
Message-ID: <131db9ff-35cb-f5bb-4365-dd1e37a3f4ce@linaro.org>
Date:   Mon, 14 Nov 2022 09:30:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 4/5] dt-bindings: net: ipq4019-mdio: document required
 clock-names
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221113184727.44923-1-robimarko@gmail.com>
 <20221113184727.44923-4-robimarko@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221113184727.44923-4-robimarko@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/11/2022 19:47, Robert Marko wrote:
> IPQ5018, IPQ6018 and IPQ8074 require clock-names to be set as driver is
> requesting the clock based on it and not index, so document that and make
> it required for the listed SoC-s.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
>  Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml b/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
> index b34955b0b827..d233009b0d49 100644
> --- a/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
> +++ b/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
> @@ -59,8 +59,12 @@ allOf:
>          clocks:
>            items:
>              - description: MDIO clock source frequency fixed to 100MHZ

Similarly to clocks, define clock-names in top-level and disallow them
for other variants. Do not define properties in allOf:if:then - it makes
schema difficult to maintain and read.

> +        clock-names:
> +          items:
> +            - const: gcc_mdio_ahb_clk
>        required:
>          - clocks
> +        - clock-names
>  
>  unevaluatedProperties: false
>  

Best regards,
Krzysztof

