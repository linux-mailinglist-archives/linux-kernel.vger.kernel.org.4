Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC66A6DC9E4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 19:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjDJRUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 13:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbjDJRU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 13:20:29 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F8D2116
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 10:20:27 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id sg7so25437725ejc.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 10:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681147226;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uiGkVZuP4SKipoXqig3t+i70oWcmpQUiQnrzBe9N9p8=;
        b=XY9PmTQFGXLKphdbRxca8qtQziW/zeEMFu4EGtG/reD0qqja3WrlyFWkeoMPU5a2Bw
         TqJSoG3DpY4mAdD1k9K/xerwkmuS+DN2fE/UZ7vq4iB0hr+D8Ix88jc4nTJfh+NGqHKw
         geL4vh7/73w5K4RsJDWkjiMBncCxhx3AOHD7BjSzgfE2eB7ibfMgRBsE2K1OCD/MUL+y
         5xgjU4Va1Shl9G0r9gbGU57yvf5LQKwZMBWbYjQSdrQxqSFEhR0t2cIKaeLGqFSAim7r
         51KORrDgJfh5cxh881gvERllMEPan9rzpu3c2XzHJ5+8a3dFg5+DVC3HnDnqgjd/O9U6
         O9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681147226;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uiGkVZuP4SKipoXqig3t+i70oWcmpQUiQnrzBe9N9p8=;
        b=XjcvF+5fiXLMMN93v9JDzqLqpd1wVH0ju/lkiQLdfeq7b3vhUApfnp2yCoHjuIPrUX
         184ksIdWfPAU+rKHeZqDRqsuILcdqlmmnYam6w3CRbQOWzSMRpG2yXWiC9PFvBKCBezb
         w8uNq6voE0fFV1dApdYHYg+sdvF2rFJ9UOlp9tYdYTdxxiPu8pbTY6xm/2keFTy/mcY9
         VyYne20G+ziv2Ily6YNjP+hmNHnM98Rim6qP5CGYXWsMfvDDb2i6+QhQHKioCLAkwNJ3
         55nkZmvgyZ/doixi9D8Pi27lQBe3t8nXbCAl3HG0wFHs/Hy0At9xBxzfqTeSH69/VGLc
         ywcQ==
X-Gm-Message-State: AAQBX9eDNJaUsSwN29jDWSbt0XZtpcvucz/Q5T/GmhzugiTEvsN6Tg1L
        J0K5ysK6AkDFAsKA/gVNfrZlOQ==
X-Google-Smtp-Source: AKy350ZSYPnunqjrFFEoIZOM1l/debS3IXgfIFfaJ7eZsVCrY2BwfQH1FGJj3rO11FgSMdyfagldCw==
X-Received: by 2002:a17:906:3843:b0:93a:353d:e38b with SMTP id w3-20020a170906384300b0093a353de38bmr7223420ejc.37.1681147226436;
        Mon, 10 Apr 2023 10:20:26 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:1a6c:6968:e633:48df? ([2a02:810d:15c0:828:1a6c:6968:e633:48df])
        by smtp.gmail.com with ESMTPSA id e23-20020a170906375700b0094da6a90107sm302005ejc.73.2023.04.10.10.20.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 10:20:25 -0700 (PDT)
Message-ID: <5d264f46-b9e8-62ec-9bce-9d666fd1eaa8@linaro.org>
Date:   Mon, 10 Apr 2023 19:20:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/2] dt-bindings: firmware: arm,scmi: support parameter
 passing in smc/hvc
Content-Language: en-US
To:     Nikunj Kela <quic_nkela@quicinc.com>, sudeep.holla@arm.com
Cc:     cristian.marussi@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230409181918.29270-1-quic_nkela@quicinc.com>
 <20230409181918.29270-2-quic_nkela@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230409181918.29270-2-quic_nkela@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/2023 20:19, Nikunj Kela wrote:
> Currently, smc/hvc calls are made with smc-id only. The parameters are
> all set to zeros. This patch defines two optional device tree bindings,
> that can be used to pass parameters in smc/hvc calls.
> 
> This is useful when multiple scmi instances are used with common smc-id.
> 
> Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
> ---
>  .../devicetree/bindings/firmware/arm,scmi.yaml   | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> index 5824c43e9893..08c331a79b80 100644
> --- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> +++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> @@ -115,6 +115,22 @@ properties:
>      description:
>        SMC id required when using smc or hvc transports
>  
> +  arm,smc32-params:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description:
> +      An optional parameter list passed in smc32 or hvc32 calls
> +    default: 0
> +    minItems: 1
> +    maxItems: 6
> +
> +  arm,smc64-params:
> +    $ref: /schemas/types.yaml#/definitions/uint64-array
> +    description:
> +      An optional parameter list passed in smc64 or hvc64 calls
> +    default: 0
> +    minItems: 1
> +    maxItems: 6

These do not look like hardware properties and the fact that you need
two properties for the same also points that you tied it to specific SW
interface.

Why this should be board-specific? Actually better question - why this
should be fixed per board? Doesn't my software want to have different
parameters, depending on some other condition?

You also did not provide any DTS user for this, so difficult to judge
usefulness.

Best regards,
Krzysztof

