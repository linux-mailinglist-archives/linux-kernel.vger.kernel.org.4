Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B226771611B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 15:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbjE3NI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 09:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232458AbjE3NIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 09:08:54 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B84B0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 06:08:52 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51456392cbbso8613899a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 06:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685452130; x=1688044130;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jZXIY4rtAXwpW+oWkjV46RQdYU5hKm1yGrqNPmpHKfU=;
        b=wEi+COhB4saE6t3QX0aBzZRVTpQ7odjIOZ2E4o7tTiZl8AnovhqRf7Bodd0DYdqUIw
         3dbjTQa6AJYb8q6GdY7xBc4lmTXn9ivsYko6Z48h96ql6mvKhHdDuExxPgKJ/D9g9xw4
         uxr+SinEI0jqUKRfePH5ukhM/HkBzMk6BfN2S4rtvBv4Pvp7bXxqx+WgBlKTU8ZU8V9g
         5SsksCPlm6QBoyHDHok8s/Occz5ETdfedATS1HqQIHw4M5QgjmL3RGk6CtzENlKtAc7A
         z55iGBXDsKcrzb5QbuAlCN89iZDnLPTdi/PUgvEQhUGH7OXFKR4ImPvovl9fVz3h+sFe
         XHIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685452130; x=1688044130;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jZXIY4rtAXwpW+oWkjV46RQdYU5hKm1yGrqNPmpHKfU=;
        b=g3vAqwVxGKIrjkTxYhaKRywiXGxifidjPuzPDh+SEBEuWNNCFaj2CWSXqrwzuasMvy
         WPyPdFsTHSXIerOVqxWPUOl4Ypi9XNuIgk4OA9TcVM9CbaVr1up+FX2GubA0Llhrao1R
         n2+gT+Iqr9ueFV5gx1R0AKpaleNlNHUCeV6Va/2VBNHOU2Y1vgD2FYXJK7TubG0Gttrt
         yok636WS8t2mJNnRqdtjuXFnHyg7UtdXE3nmcwzgjbjBT3Ierdr38+U0XZX4Zql4a0om
         cPRLcHlUpldbw/VHfZv25B/j0P21NBZwh+lp2wIhw/LnrHoOmbFJX423EjjLc1/b+Gym
         CraQ==
X-Gm-Message-State: AC+VfDyO1pZhll92kLuyr8o3t/4eZAMYp+Lx2HD8Os9cP4OwxlxFVjmZ
        2k2geZCrY/Er7pHkbx8BfKZEFQ==
X-Google-Smtp-Source: ACHHUZ4RM/uBVqPWi+sisdgqZOaN+mYhKX2B80COqCOcYP5pLPymJxYK4pUbM9xiPei6arPXAmPDqA==
X-Received: by 2002:a17:907:7da0:b0:96f:b40a:c85f with SMTP id oz32-20020a1709077da000b0096fb40ac85fmr10368239ejc.23.1685452130647;
        Tue, 30 May 2023 06:08:50 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id oy11-20020a170907104b00b0096f7e6d0063sm7309682ejb.75.2023.05.30.06.08.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 06:08:50 -0700 (PDT)
Message-ID: <65e7b6df-b83b-2d7c-5093-f5822050827a@linaro.org>
Date:   Tue, 30 May 2023 15:08:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 12/12] dt-bindings: fsl-dma: fsl-edma: add edma3
 compatible string
Content-Language: en-US
To:     Frank Li <Frank.Li@nxp.com>, krzysztof.kozlowski+dt@linaro.org,
        peng.fan@nxp.com, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        imx@lists.linux.dev, joy.zou@nxp.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, shenwei.wang@nxp.com
References: <20230529200453.1423796-1-Frank.Li@nxp.com>
 <20230529200453.1423796-13-Frank.Li@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230529200453.1423796-13-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/05/2023 22:04, Frank Li wrote:
> Extend Freescale eDMA driver bindings to support eDMA3 IP blocks in
> i.MX8QM and i.MX8QXP SoCs. In i.MX93, both eDMA3 and eDMA4 are now.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../devicetree/bindings/dma/fsl,edma.yaml     | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> index 5fd8fc604261..eed12687b0c9 100644
> --- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> +++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> @@ -21,6 +21,10 @@ properties:
>        - enum:
>            - fsl,vf610-edma
>            - fsl,imx7ulp-edma
> +          - fsl,imx8qm-edma
> +          - fsl,imx8qm-adma
> +          - fsl,imx93-edma3
> +          - fsl,imx93-edma4

What are these last two? What is "3" and "4"?

>        - items:
>            - const: fsl,ls1028a-edma
>            - const: fsl,vf610-edma
> @@ -101,6 +105,22 @@ allOf:
>          reg:
>            maxItems: 2
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            anyOf:
> +              - const: fsl,imx8qm-edma
> +              - const: fsl,imx8qm-adma
> +              - const: fsl,imx93-edma3
> +              - const: fsl,imx93-edma4
> +    then:
> +      properties:
> +        reg:
> +          maxItems: 1
> +        interrupts:
> +          maxItems: 64

That's odd. What about the names? What about minItems? Anyway, this
wasn't tested - you will have failures with dtbs_check.



Best regards,
Krzysztof

