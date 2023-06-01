Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C634E7193F0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 09:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjFAHKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 03:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbjFAHJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 03:09:59 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00C4128
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 00:09:57 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-96f50e26b8bso62809366b.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 00:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685603396; x=1688195396;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=21iAnhfOCOE1fP1JIm6u9Hm6NZmMCUEF7VO5uMtx84k=;
        b=LgREeLNor2SqPcJQCb4f4v9YKA1089fWRMS6umird7Dd4cduZww182HDUVxdw7MwjD
         w0rneeWDz9908RaEHEqtyUN6qwER1pQpWROjTJo0n0PyEGeH8FHOujb/Hcww2ozrw/3Q
         Z7lLmuHcy4XIXDWtXw9U4iBuPjdh7YeeSazlqy7RCL+ruHYlKZM0UWecCJ9aWcJ+l/CB
         hSZfJx/SVzO+f+9zE29lflEWo31YJUYuRNY+W0dAkfdplnN8kKADdzRq3TWszwzv//3v
         e4umrWvZONqATZ+g8KiyUUxiu+9I3nygQj4okz5sIBI6bV3ecTmqKFXb21Z5Rm+fRYY+
         4fzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685603396; x=1688195396;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=21iAnhfOCOE1fP1JIm6u9Hm6NZmMCUEF7VO5uMtx84k=;
        b=KtlBEGdcE9m2aa9q+up2OtZVzxCDiHW/pqaswYdWcRk2aCNi1bNgz9k+yQ93j9DWZ7
         Xt02cI7z2bgd5dHU9GzC/09cBqgh1vIRgXLsBTVF2BjylXHjlBSStRjTzjOAkUXqndxy
         GQdApJsPKkAlDoREuaQbpZrYvPG1PbG6igbOMmzM/CUXcH11sM+oRWPcDTT67tZ02Xju
         w5QVTyms2qbOLbi6iHbSht9eGzYZVYuid2GYpqxdW5uXnKkOSQ3HHQeVZ8yxIBeSiqI+
         5IvxXZklkTeidhmfvmx/exzGYz8fkP4UZ6yJDbu2V4mwI8TqT5O07JK9njm0Lu2CM/cw
         cOng==
X-Gm-Message-State: AC+VfDyVmjCIRFS18yWWbbvObkV2iqw0HxxTan0sLkdnVOOyzhoJ7ksR
        waKJpE3GFRbr+Tf5FZJCB62ILg==
X-Google-Smtp-Source: ACHHUZ7tcNLG3ERUSLkHz+IPljRSIaIgjYdPAmT7rfGQr6wZ7veiS6P62xUWniNzQ0icZFFat2U3jA==
X-Received: by 2002:a17:907:168c:b0:973:dd61:d427 with SMTP id hc12-20020a170907168c00b00973dd61d427mr3642963ejc.66.1685603396362;
        Thu, 01 Jun 2023 00:09:56 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id fi13-20020a170906da0d00b0096fbc516a93sm9979942ejb.211.2023.06.01.00.09.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 00:09:42 -0700 (PDT)
Message-ID: <009679e5-792f-a872-bc02-dda3ff8781bb@linaro.org>
Date:   Thu, 1 Jun 2023 09:09:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 4/6] dt-bindings: sram: qcom,ocmem: Add msm8226 support
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Brian Masney <masneyb@onstation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230506-msm8226-ocmem-v2-0-177d697e43a9@z3ntu.xyz>
 <20230506-msm8226-ocmem-v2-4-177d697e43a9@z3ntu.xyz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230506-msm8226-ocmem-v2-4-177d697e43a9@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/05/2023 22:55, Luca Weiss wrote:
> Add the compatible for the OCMEM found on msm8226 which compared to
> msm8974 only has a core clock and no iface clock.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>  .../devicetree/bindings/sram/qcom,ocmem.yaml         | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/sram/qcom,ocmem.yaml b/Documentation/devicetree/bindings/sram/qcom,ocmem.yaml
> index 4bbf6db0b6bd..02e4da9649fd 100644
> --- a/Documentation/devicetree/bindings/sram/qcom,ocmem.yaml
> +++ b/Documentation/devicetree/bindings/sram/qcom,ocmem.yaml
> @@ -15,7 +15,9 @@ description: |
>  
>  properties:
>    compatible:
> -    const: qcom,msm8974-ocmem
> +    enum:
> +      - qcom,msm8226-ocmem  # v1.1.0
> +      - qcom,msm8974-ocmem  # v1.4.0
>  
>    reg:
>      items:
> @@ -28,11 +30,13 @@ properties:
>        - const: mem
>  
>    clocks:
> +    minItems: 1
>      items:
>        - description: Core clock
>        - description: Interface clock
>  
>    clock-names:
> +    minItems: 1
>      items:
>        - const: core
>        - const: iface
> @@ -58,6 +62,20 @@ required:
>  
>  additionalProperties: false
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,msm8974-ocmem
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 2
> +        clock-names:
> +          minItems: 2

else:
maxItems: 1?

Best regards,
Krzysztof

