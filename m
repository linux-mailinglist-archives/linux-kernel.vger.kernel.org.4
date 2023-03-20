Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63D56C18CA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 16:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232885AbjCTP1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 11:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232882AbjCTP1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 11:27:10 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA06536FE5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 08:20:20 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id cy23so48071607edb.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 08:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679325617;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LOrZ5g8zdYLMMt/fhRI5yMqCJEU1JUk79LtCQCDW0I4=;
        b=v2jP13USe3El5ibm5ULPAOe6v1TgLHACFqAb7NOoffPPmagV6WXHcR9/U++BrBMju1
         Y5W4wSy9X/OtVaAzwJpli+Nlhf+l6ZkDmNWGRTRn90ebdhZbojmHGOBViDduv36IQ20j
         faQs2UcKdsJcJTguxRV1PmB3J+vKOV0lOQIDxJ50Ps74ObjWw/9Z/jQqvq498+G8zELC
         tptafNyx+SI6KU3+DMq5Xw5+cEJTBfVIALQjNPtQaKREXhsSZs3BMowYK/oTXfys5pxU
         MEZhnQedPdmioFe9Y4Yx0zBaPSHyhSg+mL/yc+zd5mmLlKBpHjR5kQlJaOWbyCr5131+
         hQig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679325617;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LOrZ5g8zdYLMMt/fhRI5yMqCJEU1JUk79LtCQCDW0I4=;
        b=IGSP6phRyDP0gYL95lPgFJQuizGo72e/pnq9hj/6X0IFJw8EbozVrr53FgZzYQ2qcd
         FsMqEsNWQK4JGK6xvnu+m8QPHp94eYb+98JGh0JnDa2z5Eo53WzyVSxm6qL3Srm4tYpD
         yC/fUhTFnKbqkvzuwJWlRImaRaW5TrEuHLXx0Hw9J3+4LIKi3bjInGhM95YkrfcbvkuG
         keqfoDyT4Z3+KqQ5TPJ+HCkyS9dEaGNVkhNENQvvx0V+psWmWkFX6XqDRoUN/vu0wkot
         02OpXih6uOFVKieyVMDwNvxCgcDCSokZf2qX7m3uysx+K71DMMnYnFxsoajgHTfOcAgE
         ZoeQ==
X-Gm-Message-State: AO0yUKVxCmbnhIkmRzuOXHIxS5bwgIdS0jHzd/wwn6ZYBF5Wlie3/eEd
        L3KhwPn1bphcnRPrD6NC0nT1wOiGLzpEpJ+i2cQ=
X-Google-Smtp-Source: AK7set+DykKBrHBsj1B79y1NsIEEw3FRRJc6/M2u8ITlG3pK0w5s9iRXJyWQlGL1qfK7UlK6ZmLFyA==
X-Received: by 2002:a05:6402:110e:b0:4fa:c3eb:d2c9 with SMTP id u14-20020a056402110e00b004fac3ebd2c9mr11982032edv.12.1679325617415;
        Mon, 20 Mar 2023 08:20:17 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:458e:64e7:8cf1:78b0? ([2a02:810d:15c0:828:458e:64e7:8cf1:78b0])
        by smtp.gmail.com with ESMTPSA id f3-20020a50d543000000b00501d51c23fbsm310901edj.6.2023.03.20.08.20.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 08:20:16 -0700 (PDT)
Message-ID: <06cbcd7d-bc83-bfeb-0821-72c7caf9a5e7@linaro.org>
Date:   Mon, 20 Mar 2023 16:20:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/3] dt-bindings: arm: ti: k3: Add compatible for AM62x LP
 SK
To:     Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230320051304.2730692-1-vigneshr@ti.com>
 <20230320051304.2730692-2-vigneshr@ti.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230320051304.2730692-2-vigneshr@ti.com>
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

On 20/03/2023 06:13, Vignesh Raghavendra wrote:
> Add compatible for AM62x SoC based Low Power Starter Kit board[1]
> 
> [1] https://www.ti.com/tool/SK-AM62-LP
> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>  Documentation/devicetree/bindings/arm/ti/k3.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
> index a60a4065caa8..56fdd94bf899 100644
> --- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
> +++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
> @@ -29,6 +29,7 @@ properties:
>          items:
>            - enum:
>                - ti,am625-sk
> +              - ti,am62x-lp-sk

Don't use wildcards in compatibles... but judging by
https://www.ti.com/tool/SK-AM62 it looks like model name. If it is truly
model name, not wildcard, then:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

