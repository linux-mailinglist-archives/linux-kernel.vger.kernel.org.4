Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E3A6E3654
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 10:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjDPIzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 04:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjDPIzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 04:55:13 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3784F10C4
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 01:55:10 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-504e232fe47so4080747a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 01:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681635308; x=1684227308;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pg6953tCPWmA6PZJp5D14eo4mPNGqutmBJkwLa5dsUk=;
        b=CobYjD5vknETNT4bPGz2Pi/w/5ocQBOFxXVFoTkj4ySM6RZu+shCwnOf006rXBYuZK
         IX/Aco3lY73lIvMwFCCyloieYtssgXKvkuXMo1wZ/TWBpF7SQ9uG5TIZbMcPj8QJXBxq
         FoWwywOqgxois+K2stLWZYbiUiue+x4bB4gAD0NQ3KOUiCy/jkyzYKE91pJMVHjlyMn7
         Eg/ZlM1bMSWRY4tfepT/N5YB9HV3wBUUZqinqfZnwG2/sGkY20CqYTeohR9x2+Afv7c/
         NAGlzTIr6hMl02JjF05B6r8A/qWrTv6gd5oo8FYPBLwNP+WT12AYzKRtuMkdkBBVTOns
         cRSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681635308; x=1684227308;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pg6953tCPWmA6PZJp5D14eo4mPNGqutmBJkwLa5dsUk=;
        b=c52lvrcLFgWVKluD0KKw6kLEZSiiWsbRCbPBxyOTB6L+x8hWhT9F876+8R9bNsJIz3
         qZIJENrPjt4xZ/LclQ7cbdPO0Vuhv4jQloig5JWrIvjCTqSDxxv5+GU5V6EpOBMgYcMJ
         7SGviWqWWRlw+oDoe6ZMTsbBsN173rkcrmsBHIsUQtA7h3w27zjNWyy0bHtuSF9zJLkZ
         xq37u5HMe4QRMd/kkl2BFpXaF8QS3/L41aMosBdVIR+SXgTHEzsK/3yuQdeGIqdKSv8e
         FSRZdd4TEvTP8KKa+euma06RYp/7pt11UG3I7x9+KtJiIl0fBAARbkTgV+V5LDgEc49G
         iM7w==
X-Gm-Message-State: AAQBX9fvOimEvBoK3iDj7+xRki+6qA+ntZ3psMTny78BeHGkQ30G2m6N
        WE+wBAXUx/fVju9DbPaMjmummQ==
X-Google-Smtp-Source: AKy350ZnYSDCTQ3LmTMg+Ln2LPy06L6LJBu235UK01i3de4KPcXULfb/EsShDcSUgY4efm4mzfBFnQ==
X-Received: by 2002:aa7:c3d5:0:b0:506:7c86:202 with SMTP id l21-20020aa7c3d5000000b005067c860202mr8382301edr.20.1681635308580;
        Sun, 16 Apr 2023 01:55:08 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:29dd:ded4:3ccc:83db? ([2a02:810d:15c0:828:29dd:ded4:3ccc:83db])
        by smtp.gmail.com with ESMTPSA id nd23-20020a170907629700b0094e9f87c6d4sm4765767ejc.192.2023.04.16.01.55.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 01:55:08 -0700 (PDT)
Message-ID: <060b0c6d-4058-46a9-4004-1dee135efec0@linaro.org>
Date:   Sun, 16 Apr 2023 10:55:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH RFC v3 4/4] dt-binding: mmc: histb-dw-mshc: Add
 Hi3798MV200 compatible string
Content-Language: en-US
To:     forbidden405@outlook.com, Ulf Hansson <ulf.hansson@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     tianshuliang <tianshuliang@hisilicon.com>,
        Jiancheng Xue <xuejiancheng@hisilicon.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        David Yang <mmyangfl@gmail.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230415-mmc-hi3798mv200-v3-0-00e2368c0709@outlook.com>
 <20230415-mmc-hi3798mv200-v3-4-00e2368c0709@outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230415-mmc-hi3798mv200-v3-4-00e2368c0709@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/2023 10:46, Yang Xiwen via B4 Relay wrote:
> From: Yang Xiwen <forbidden405@outlook.com>
> 
> Add Hi3798MV200 compatible string and an extra clock for it.
> 
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
>  Documentation/devicetree/bindings/mmc/histb-dw-mshc.yaml | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/histb-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/histb-dw-mshc.yaml
> index 4711ad293b9e8..bcc8ea393981f 100644
> --- a/Documentation/devicetree/bindings/mmc/histb-dw-mshc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/histb-dw-mshc.yaml
> @@ -19,6 +19,7 @@ properties:
>    compatible:
>      enum:
>        - hisilicon,hi3798cv200-dw-mshc
> +      - hisilicon,hi3798mv200-dw-mshc
>  
>    reg:
>      maxItems: 1
> @@ -28,13 +29,16 @@ properties:
>  
>    clocks:
>      minItems: 4
> +    maxItems: 5
>  
>    clock-names:
> +    minItems: 4
>      items:
>        - const: ciu
>        - const: biu
>        - const: ciu-sample
>        - const: ciu-drive
> +      - const: sap-dll-mode
>  
>  unevaluatedProperties: false
>  
> @@ -47,6 +51,18 @@ required:
>  
>  allOf:
>    - $ref: synopsys-dw-mshc-common.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: hisilicon,hi3798mv200-dw-mshc
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 5
> +
> +        clock-names:
> +          minItems: 5

else - maxItems: 4 for both


Best regards,
Krzysztof

