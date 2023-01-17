Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2FD66D8B7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 09:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235973AbjAQIw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 03:52:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235789AbjAQIwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 03:52:30 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB202CFCB
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 00:51:46 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id l41-20020a05600c1d2900b003daf986faaeso3960469wms.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 00:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=expaoc4a1kUuojomtX/CBeI3GGcWe8iG4JOwm7tA2Ms=;
        b=GCBuP2ME3LEmq3d288LClfQ+DDoceb7qejVUCKci1Io3+3RT81PEq0YzI+C1ZzwsT5
         6WyQCYKa7CiON2FBCWKBC+ZrjoPsaFO5JDZTtLTblFsb0I90j7ED6EsBVKGyb9eMbfjW
         zL/aWSzykK4zTaUc4GgVZs/QUjdTlpK4BCVtJBhNAGmInT8k0Gh9CUOdgUMk/69WsWqI
         T0liqYDKLBb7PqCc5cJAcgK/89PPlPM8ZoGDAHIjm6wK+/lYKZGo9fhmW0b7V9ja1joI
         iA76KK54eIYL7LNUe07Mnj7MuYHzX2Q2/qBEMEkGW/HVJ9ZGhJpKcr5egZmElAtKO/yS
         J6aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=expaoc4a1kUuojomtX/CBeI3GGcWe8iG4JOwm7tA2Ms=;
        b=ssDhp2450Ke/5enpdPf8dMuT2Gge60cwi0ZIevhBmHofMmAxSyokoP1QjtPXB4Lx1f
         N1arCB4Ov478z4NkqfsMdcDPsK5Zr2PGKfQvoYsmL2p9sQkW/1YhRqhEw8u1EsxJG0R0
         kcvuqgzqZDNnxeRyrRLJzNFXQt/Rpl78fSO2kttLXv1cn2Y2Ln2+nYYzsr+nont+I1uH
         jRiYqcD+WSkPkBtPejKxLwpfP+aSz9nb+MP5ffIrZ21TqiuaRsL1Epda2s0jpFEFD39p
         gV9yzw+o5stkc1lmHNKZteDiHwpSsKWVJBlMX3d2E9mCmivmSF/bUWvgaLnq2UVypYbx
         Gu2g==
X-Gm-Message-State: AFqh2koWZ3ObuejRPPdCIl9cKwIRcQEWdoxbuzvLnRDP7B7hWIjy8sN9
        5NORYwB/3wsDjUhc04wfnDHQhg==
X-Google-Smtp-Source: AMrXdXueXFpF3XR7NYfg4P+jSjPuEvD2oSEf8abJxzrHhstw07/IPA3YDM4cBB/MjzxBAzfHOuxzSA==
X-Received: by 2002:a05:600c:5006:b0:3da:f92a:5446 with SMTP id n6-20020a05600c500600b003daf92a5446mr2418854wmr.27.1673945504969;
        Tue, 17 Jan 2023 00:51:44 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id h19-20020a05600c351300b003d9a86a13bfsm39331066wmq.28.2023.01.17.00.51.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 00:51:44 -0800 (PST)
Message-ID: <ee9ef65b-38c6-2283-b1e7-abf49abdccd6@linaro.org>
Date:   Tue, 17 Jan 2023 09:51:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH] regulator: dt-bindings: qcom-labibb: Allow
 regulator-common properties
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230116092502.71146-1-konrad.dybcio@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230116092502.71146-1-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/01/2023 10:25, Konrad Dybcio wrote:
> Allow regulator-common properties on lab/ibb regulators, such as
> regulator-always-on, etc.

Are these proper regulators? If so this looks sensible. Why calling it
RFC? What is here questionable?

> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../bindings/regulator/qcom-labibb-regulator.yaml           | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/regulator/qcom-labibb-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom-labibb-regulator.yaml
> index f97b8083678f..c0be7d5a6d40 100644
> --- a/Documentation/devicetree/bindings/regulator/qcom-labibb-regulator.yaml
> +++ b/Documentation/devicetree/bindings/regulator/qcom-labibb-regulator.yaml
> @@ -20,7 +20,8 @@ properties:
>  
>    lab:
>      type: object
> -    additionalProperties: false
> +    $ref: "regulator.yaml#"

Drop quotes.

> +    unevaluatedProperties: false
>  
>      properties:
>        qcom,soft-start-us:
> @@ -46,7 +47,8 @@ properties:
>  
>    ibb:
>      type: object
> -    additionalProperties: false
> +    $ref: "regulator.yaml#"

Drop quotes.

> +    unevaluatedProperties: false
>  
>      properties:
>        qcom,discharge-resistor-kohms:

Best regards,
Krzysztof

