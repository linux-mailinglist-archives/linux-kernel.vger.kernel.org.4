Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5D3629BE4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 15:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbiKOOVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 09:21:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbiKOOVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 09:21:12 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F732BB01
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 06:21:08 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id s8so7502697lfc.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 06:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ACgHMFuGKzy3RGwW6XHrQYZNS+YLjUOXJZAsXWrWtGs=;
        b=HShR3wKOJcnBxWiCo3jeWX+nqBmY7jdqQxaDhFfMLBjHDv36J+RsIx27T1YWbYLSuI
         yJuV9RXMTuEFfa1vTJSZ2AkdCmq27eLcBDIla5OWTvnCNQpZPWiPVYMXP89CLL0i5dEp
         jNtwWCN/2k04uQShe5hSnv4VEecopp7F/GbsLYezvFV43PkSGTxLC0ft0nw8SYgtiewi
         HNo9RT9JxiYQKJ2j1f7/xCNs8Q/3eP81P5EbIEgCAEEcUhNJZIKcwltLzlSz4fPau3Sz
         XVBoEsK19cu2OgBxmLCWKmRN0a4DbiUmRFZCPNV4MQ9DGKR06bbSi4jKVjIkqBVhLLQd
         Z9qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ACgHMFuGKzy3RGwW6XHrQYZNS+YLjUOXJZAsXWrWtGs=;
        b=hke1z4y5OUiruo9fdNkwElijfWJZ+d4D9/nFlq+t6LpK6NOHvn2ZZJW5g0MPE7+nFf
         2U3Lyq79FpRIFncg3Aj4xyekdXWR42djLYmubF6kRDiCIb7VVJK5KGVgw3rF6+Zw3Bue
         75kPDUVEQdSQGzIptOMqtWAbJLt1sqR3dlgMJrvk1Kcw71OCaamqNAVdd0WWP+84NOCP
         p+ShrGNS8IwbzCEw9agS3Rw9vVetF79jPqAl9FwBxMGDPryqywAbj/6XSh3UggmcJlyI
         pXCnOL4WzAVKeZZwQhf81c0tuHH+Y435mlAE0nCRHC9pCs3I8Ci/6I53lr1H6oxk2OnH
         D6dA==
X-Gm-Message-State: ANoB5plqCLt+397bE+6uO4UzFHVj5zyVg6eTorbcK+oW0i9zeN3vi3nC
        R3KkHoiXQFNhk8qSy59dncrkHA==
X-Google-Smtp-Source: AA0mqf5KID519SFnnfTcLoNNny5R3BJ970yABv3j0l6ETKypPDYbUDkY+VVoHy6vD3ScOULPBNLKHw==
X-Received: by 2002:a19:5016:0:b0:4ad:5fbb:a5b0 with SMTP id e22-20020a195016000000b004ad5fbba5b0mr5417040lfb.466.1668522067299;
        Tue, 15 Nov 2022 06:21:07 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id c8-20020a056512324800b004afc1607130sm2226467lfr.8.2022.11.15.06.21.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 06:21:06 -0800 (PST)
Message-ID: <f3a6a7b1-b196-0abb-0c18-8a13908c6891@linaro.org>
Date:   Tue, 15 Nov 2022 15:21:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: lpass-va: add npl clock for new VA
 macro
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org
References: <20221115105541.16322-1-srinivas.kandagatla@linaro.org>
 <20221115105541.16322-2-srinivas.kandagatla@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221115105541.16322-2-srinivas.kandagatla@linaro.org>
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

On 15/11/2022 11:55, Srinivas Kandagatla wrote:
> LPASS VA Macro now has soundwire master to deal with access to
> analog mic in low power island use cases. This also means that VA macro
> now needs to get hold of the npl clock too. Add clock bindings required
> for this.
> 
> As part of adding this bindings, also update bindings to be able to
> specific and associate the clock names specific to the SoC.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../bindings/sound/qcom,lpass-va-macro.yaml   | 72 ++++++++++++++++---
>  1 file changed, 64 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
> index c36caf90b837..848e34111df1 100644
> --- a/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
> +++ b/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
> @@ -27,16 +27,13 @@ properties:
>      const: 0
>  
>    clocks:
> -    maxItems: 3
> +    minItems: 1
> +    maxItems: 4
> +
>  
>    clock-names:
> -    oneOf:
> -      - items:   #for ADSP based platforms
> -          - const: mclk
> -          - const: core
> -          - const: dcodec
> -      - items:   #for ADSP bypass based platforms
> -          - const: mclk
> +    minItems: 1
> +    maxItems: 4
>  
>    clock-output-names:
>      maxItems: 1
> @@ -61,6 +58,65 @@ required:
>    - reg
>    - "#sound-dai-cells"
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: qcom,sc7280-lpass-va-macro
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 1

You can skip minItems here.

> +          maxItems: 1
> +        clock-names:
> +          items:
> +            - const: mclk
> +      required:
> +        - clock-names
> +        - clocks

IIUC, all variants require now clocks, so these two lines should be part
of top level "required:".

> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: qcom,sm8250-lpass-va-macro
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 3
> +          maxItems: 3
> +        clock-names:
> +          items:
> +            - const: mclk
> +            - const: core
> +            - const: dcodec
> +      required:
> +        - clock-names
> +        - clocks
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,sc8280xp-lpass-va-macro
> +              - qcom,sm8450-lpass-va-macro
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 4
> +          maxItems: 4
> +        clock-names:
> +          items:
> +            - const: mclk
> +            - const: npl

How about making it the last clock so the order matches with sm8250?


Best regards,
Krzysztof

