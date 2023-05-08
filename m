Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1FEC6FB21A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 15:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234359AbjEHN7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 09:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233752AbjEHN7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 09:59:33 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BEA35DA9
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 06:59:30 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9619095f479so723360966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 06:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683554369; x=1686146369;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jq3J7+1ys1dSse2zrXI8w6B2jfTU5HybCEFcTuGrfvI=;
        b=rKSKiXLEkv3IwzslJAuu/S/mOwWyIwnHPlOVC/5jrFB25bK5suewvDEPWm/4X1yWfD
         3krqGBLkiLuRjhxCrE3VANXOtU+RYfj1VitH5kSX9CjrQ4GdK4t/Ky3ieRb+zlSEzuVZ
         CHAJp4LbYmZCQAgcsV1FSmIXCVm0orEthoumSY7MuoY8aS3U8Wi0kXI5ucZC+QEfWLkI
         6x+5dioufh7biFRQDPp5s0wuoMODHZjk4k0QhgzEa3f8uzCbzJl5hBs4P6HTruJvKu4N
         xNlxWWdl2aHa0RgJ45zS8I8+HnyTssKq0FrXj2s4WisiGdNw1qwl/SH7Yu9yR937UBg+
         wdQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683554369; x=1686146369;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jq3J7+1ys1dSse2zrXI8w6B2jfTU5HybCEFcTuGrfvI=;
        b=BNDNca0DC38/L2XeKqNp5E9rUwRWVp0SWMebQEKcw5K6MQgBj31SVHcZkonEcXrbYx
         YCRGOr9aC9jFO9EZ1/IEmXEYIbNsa5f7TbAcEbwR8/sSryQDbrgBzYRMAd8/TkFpgRgf
         6op/nOVvx9qrnPGWyApaiwWBgL87a/JkgOF/7KKyeXT+OpCYJITJFbjp6malAtfHor45
         i1Hgl/lMyRQfnVfP7ndq9+dKoCVTnJ/XZyFrNRtBo1fkOLBGkqtHqs/pR+kTaAynm2xA
         z/d+Vl2BeSP2iJ1YdfStaAVRqU+EngCvfo1EwORTsFBcZ0CkVENorVpx8iBvqpCJXbpu
         11Tg==
X-Gm-Message-State: AC+VfDzpq8zJhmhWOTf1SyfvSG1yS0jVZ7jkPNoaeD6ewnjGt2FuXfjD
        HjpXGGqZdqNvSMFZSynkIbuMZg==
X-Google-Smtp-Source: ACHHUZ5LrhWFh5iQx3Nf7XyU8hCLZYUOSPRPDjrUAIH3uVROjaWLxfJvQ/amtmLnKfk6c78Ux2MYHQ==
X-Received: by 2002:a17:907:8a01:b0:967:21:589d with SMTP id sc1-20020a1709078a0100b009670021589dmr2449230ejc.2.1683554369113;
        Mon, 08 May 2023 06:59:29 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:50e0:ebdf:b755:b300? ([2a02:810d:15c0:828:50e0:ebdf:b755:b300])
        by smtp.gmail.com with ESMTPSA id t9-20020a170906608900b0096557203071sm4991017ejj.217.2023.05.08.06.59.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 06:59:28 -0700 (PDT)
Message-ID: <698a836c-42a4-02eb-ba58-908db8abdd47@linaro.org>
Date:   Mon, 8 May 2023 15:59:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/5] dt-bindings: mailbox: tegra: Document Tegra264 HSP
Content-Language: en-US
To:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20230508122048.99953-1-pdeschrijver@nvidia.com>
 <20230508122048.99953-2-pdeschrijver@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230508122048.99953-2-pdeschrijver@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05/2023 14:20, Peter De Schrijver wrote:
> Add the compatible string for the HSP block found on the Tegra264 SoC.
> 
> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> ---
>  .../devicetree/bindings/mailbox/nvidia,tegra186-hsp.yaml         | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.yaml b/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.yaml
> index a3e87516d637..2d14fc948999 100644
> --- a/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.yaml
> +++ b/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.yaml
> @@ -66,6 +66,7 @@ properties:
>      oneOf:
>        - const: nvidia,tegra186-hsp
>        - const: nvidia,tegra194-hsp
> +      - const: nvidia,tegra264-hsp

I didn't get other patches, so I assume you know what you are doing and
the device is not compatible with others (see entire context of that diff).

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

