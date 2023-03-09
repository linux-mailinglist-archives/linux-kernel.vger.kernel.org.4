Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB50E6B2101
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 11:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjCIKNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 05:13:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjCIKND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 05:13:03 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B99E6830
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 02:12:47 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id u9so4886207edd.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 02:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678356765;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YM/JDbd0VPnawILSkvqIBzMrYyUcm2iXljNAjcmjND4=;
        b=HNVE2HpXW56r51lhzb1tZh1LXSowpMnWYvjKkajOpEy7TNp8+qL5uL1vpy8TEQb1hB
         9ED4L0yiGHmeKUWQdjiWgV4DnRC9TDykOaQwbcTnJfsW7CKK8OO1OlZ8YZE3oa/oO0Az
         JN1SkedI8D+GHY8izVPuuwbJK4gg6BuIO+stXqgtP62UWBXKGyb/R7IEvhCz4B0kJxOf
         qiQtIzxmk9q9kpfqMJynnBOwrqSp84R/CAgnDYEyE/9h/vQK+aMiq3ix45gcPkNs0UGZ
         3RWjEeTIt0EzVMAyatbSGrW3Q4BcUkptE75NJsNq+wBhJw1PyMy5n+HS6AhgKku8rBvi
         uPdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678356765;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YM/JDbd0VPnawILSkvqIBzMrYyUcm2iXljNAjcmjND4=;
        b=162kAv2XQz8iUHiLhIBv6rNs7BhJbp1T5fpGCwTN6eyPk83Iv8uKZG3aByCAeRMBX3
         T4HQv9GOs36ccVw1hrPJx/8m6/5eHZF1agFaH8XBc+FN67lc04M84al0hnRYACQ7m5kJ
         3G4EZevI2hLMwT1iwujErkG5EhOMGl3cIUaGvlhil1rFzyDN+8Hc4yJg1ncuBy1CnqYv
         tBVjLg5fg8MF2QgwErCtE2Ags1iv9YnJ1vpyQbhNlXAec3LP3QoGAVQXDvuU0aqmLMwO
         D8BGlwn/Dc0Q/EbyPy5pmMIp72npOoWjbIVPKIeyiM/VO6pmVv11hSJyhWer+qDEcnx6
         NTRQ==
X-Gm-Message-State: AO0yUKVeSKYIx3tqp074ijIxdHZuJj5VOVO9ttOVvmT7eXYW9lYix3rX
        Hn8td0cggC/9HA5tohJNVOIETdnFYXQloZG92ZY=
X-Google-Smtp-Source: AK7set9NCiqLzxFOuWG9zuFJMcWCWwY1UJM+flMqHq9P1KRkknaFl7gGlf39ORhlj9cCZE7bEY/Xww==
X-Received: by 2002:a05:6402:88b:b0:4ad:5220:79f6 with SMTP id e11-20020a056402088b00b004ad522079f6mr19947573edy.18.1678356765683;
        Thu, 09 Mar 2023 02:12:45 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:7ee2:e73e:802e:45c1? ([2a02:810d:15c0:828:7ee2:e73e:802e:45c1])
        by smtp.gmail.com with ESMTPSA id ga1-20020a170906b84100b008b17879ec95sm8597656ejb.22.2023.03.09.02.12.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 02:12:45 -0800 (PST)
Message-ID: <49e67fb3-4ef9-5d50-c3e8-3c7857145bbc@linaro.org>
Date:   Thu, 9 Mar 2023 11:12:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] dt-bindings: power: supply: bq256xx: Add ts-ignore
 property
Content-Language: en-US
To:     Hermes Zhang <chenhuiz@axis.com>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Davis <afd@ti.com>
Cc:     kernel@axis.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230309023926.38682-1-chenhuiz@axis.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230309023926.38682-1-chenhuiz@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/2023 03:39, Hermes Zhang wrote:
> Add a new property: ts-ignore to allow user to enable the TS_IGNORE flag
> in chip. Ignore TS pin will allow user to control the charging
> parameters instead of the default JEITA profile in chip.

You miss users of it.

> 
> Signed-off-by: Hermes Zhang <chenhuiz@axis.com>
> ---
>  Documentation/devicetree/bindings/power/supply/bq256xx.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/bq256xx.yaml b/Documentation/devicetree/bindings/power/supply/bq256xx.yaml
> index 82f382a7ffb3..74fd48f4bec5 100644
> --- a/Documentation/devicetree/bindings/power/supply/bq256xx.yaml
> +++ b/Documentation/devicetree/bindings/power/supply/bq256xx.yaml
> @@ -68,6 +68,12 @@ properties:
>        Interrupt sends an active low, 256 μs pulse to host to report the charger
>        device status and faults.
>  
> +  ts-ignore:

Missing vendor prefix... is this generic property? ts-ignore is very
cryptic. You should describe here rather desired system characteristic.
Why anyone would need to use it per-board level?

> +    type: boolean
> +    description: |
> +      If this property is set, the TS_IGNORE flag will be set to 1 which means
> +      will not apply JEITA profile during the charging.> +
>  required:
>    - compatible
>    - reg

Best regards,
Krzysztof

