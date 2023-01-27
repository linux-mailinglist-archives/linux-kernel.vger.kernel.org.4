Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87A367E021
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 10:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbjA0JaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 04:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbjA0J37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 04:29:59 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B581CF48
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 01:29:56 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id vw16so11958572ejc.12
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 01:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ueXviCovK+QZZYE7FrfJuFn3pk3O7fimKTZOGUVq37I=;
        b=ucIZPdauUKLlnppZeXT1jihQhRqrUpJHBV2l3a578ADOQ9+vNUzQbX8aWNZrKeoP+N
         4raynxXAvVdvJX2jBkBqdqyOx7rvn5i45GbtbcUa/A8OIrvuNbXGR/7x9AupBYb3jabz
         +xxnSvQRJJQDoPQ9MfvBmuA3d3PI7Sxfvn+HSaEDsEZzCiD8NwNHvfEsxwwNdpgH8iLw
         ghM5LG5jTVgsmHwcjfxSbVxrDZ1tz+hqG7vzYQf1CTey4hWC6pDCK3S7yYKHFTAU8nGw
         pp4pzPghxxHpu7YN93ch2Beau4xakWFu25wO1B00ltgWD11UtHPwU4LMem6fQ4ZvabXK
         gMbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ueXviCovK+QZZYE7FrfJuFn3pk3O7fimKTZOGUVq37I=;
        b=HUlUigRpPkMPiTBbNd4BUZzidfQCrJ8efAt4bQKZWmCSSuwzj5fnazNH4FchSPt5vn
         EbBXWIOfDrc0COgo9fTBvae2S5w1xVN8fWD4AeNDHvDZYp1iwxu9KUyLivuv3f5JPqHY
         1+zrIM6y6zydHRxPcCNWyoByAAiK6mQwIIA0GD+JuxY7tiLMtwBswWWe9WDikDHnpb/z
         DWXaQe5vPKCFFZfUKagnkF8+6QxZU4pMzF4Kp/KZbu8R5p57cjAszhya4RdbFlYPL7RJ
         fav4E6+p6tH5gqQZ7YKWiKwuGo26qt0GYqByTWIizVYDtLMCm2QPkWWfKNOXw//JEzFr
         BUGA==
X-Gm-Message-State: AO0yUKWAbA0z942EAw2a5B1rXcnAZrwKQy+IFF/43OwDyUJ4nLGNdFf/
        E8vIQ0Ub2do7wTmCPeomMBk+WQ==
X-Google-Smtp-Source: AK7set/9XOC0DAhGi2F4o+eYoAA684wb10hT9tRNzpE3bfPiNvmdonwMdm8UYqyo2aPRnV8unhvl0Q==
X-Received: by 2002:a17:906:fc08:b0:87b:1be:a8c2 with SMTP id ov8-20020a170906fc0800b0087b01bea8c2mr2048919ejb.73.1674811795473;
        Fri, 27 Jan 2023 01:29:55 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id v9-20020a170906380900b008786619684csm1899691ejc.125.2023.01.27.01.29.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 01:29:54 -0800 (PST)
Message-ID: <028b739f-f354-b11c-3e0c-971f1e9c70a2@linaro.org>
Date:   Fri, 27 Jan 2023 09:29:52 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 1/2] dt-bindings: nvmem: qfprom: add IPQ8074 compatible
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_kathirav@quicinc.com
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20230123101631.475712-1-robimarko@gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230123101631.475712-1-robimarko@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/01/2023 10:16, Robert Marko wrote:
> Document IPQ8074 compatible for QFPROM, its compatible with the generic
> QFPROM fallback.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Applied thanks,

--srin
> Changes in v2:
> * Add ACK tag from Krzysztof
> ---
>   Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
> index 9ddf3cef9e84..2173fe82317d 100644
> --- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
> @@ -19,6 +19,7 @@ properties:
>             - qcom,apq8064-qfprom
>             - qcom,apq8084-qfprom
>             - qcom,ipq8064-qfprom
> +          - qcom,ipq8074-qfprom
>             - qcom,msm8916-qfprom
>             - qcom,msm8974-qfprom
>             - qcom,msm8976-qfprom
