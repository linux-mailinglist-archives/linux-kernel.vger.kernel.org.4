Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4256C9335
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 10:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjCZIze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 04:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjCZIzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 04:55:32 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1A659EF
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 01:55:30 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id cn12so24197091edb.4
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 01:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679820929;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tdNvg2xzB0D6uDTPiIMwPnLLRw75WzKQ9BcxMmfR+wY=;
        b=Xj+sSGNQBNP7Iza1zytcVsHoE8CypUQ4EaoKfjK1YL8N4dKi9Vx7Snac560bFAKU+q
         taLI1eyAUkJSRprrF11FEEtpU1XwJIWgNVSE2muN8LcBhJWfOiIUpy6FvC5JS0N7FzlQ
         jOIN2bD54sw0AB6MtLUuAgTO8wve9goyp0ff1ax+v5/hSPZwmICQ0naCiCTcn5QV55zd
         kr57EEpIpd756yjngPmpabPMiMvEvQDQL5+AKfNaneahijpjTDvT3iRyMYdxPN/gq7rr
         AUiVGJitOLTfuW4Sh9Qibu9Az4IdDC2I9QW0Ly/S/3xNrV8LMcaIA7TsbK2m4OhubR/6
         QN8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679820929;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tdNvg2xzB0D6uDTPiIMwPnLLRw75WzKQ9BcxMmfR+wY=;
        b=WR4zgTXxqVhIjm48Jrz0uXP6/oYH2fRYL1F38zdD4pKBI3azFVEiN6K0hTknBcUzGT
         ywVdXlVr/fC+lF5dllVwkemjGdcDxOye3WvPHC4tBYAu1iR54VxollNdXJ0XozbhBiq4
         hxXxV/zdterruenUVZXfz3NjD41Zk1qFR100AhZNfVFl/YPbYV2FhIKYPsuWhjaOnog/
         DjOJg3OIHFKdICrbk5kJzFGc+uNmgQY5iABCG7tCCxrEjnOKg0pmCrMtYlW5KO2FfR3I
         ApwCjDLRHh67gZbTkym1xL1yhoLOJbBQHjh7o3u1RqenHJEGPFk0rCPQjpw2tLsvsvVr
         3FNw==
X-Gm-Message-State: AAQBX9c1PmBN/aLQrFpsOUJ5q2QYZmQZQ2+sPbJ8GXSKeCwZAC1rPvxw
        AKL1+qjMs91XYIGAt6tMPghMrg==
X-Google-Smtp-Source: AKy350Y38IpZvpn5NNWAeJxfYzkMeR5mFaBTL528SH6D3m4QIrdFOXOo/qajkV63WIgaHLxTeRedyA==
X-Received: by 2002:a17:907:d09:b0:930:e634:3d52 with SMTP id gn9-20020a1709070d0900b00930e6343d52mr10709447ejc.24.1679820929084;
        Sun, 26 Mar 2023 01:55:29 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:6cac:926d:a4f2:aa09? ([2a02:810d:15c0:828:6cac:926d:a4f2:aa09])
        by smtp.gmail.com with ESMTPSA id gv52-20020a1709072bf400b0093a7952411asm7282987ejc.48.2023.03.26.01.55.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Mar 2023 01:55:28 -0700 (PDT)
Message-ID: <883c3c48-c6e5-556d-431f-e92592b9106a@linaro.org>
Date:   Sun, 26 Mar 2023 10:55:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/2] dt-bindings: misc: qcom,fastrpc: add
 qcom,assign-all-memory property
Content-Language: en-US
To:     Dylan Van Assche <me@dylanvanassche.be>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20230325134410.21092-1-me@dylanvanassche.be>
 <20230325134410.21092-2-me@dylanvanassche.be>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230325134410.21092-2-me@dylanvanassche.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/03/2023 14:44, Dylan Van Assche wrote:
> Document the added qcom,assign-all-memory in devicetree bindings.
> 
> Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
> ---
>  Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
> index 1ab9588cdd89..fa5b00534b30 100644
> --- a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
> +++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
> @@ -57,6 +57,12 @@ properties:
>        Virtual machine IDs for remote processor.
>      $ref: "/schemas/types.yaml#/definitions/uint32-array"
>  
> +  qcom,assign-all-mem:
> +    description:
> +      Assign memory to all Virtual machines defined by qcom,vmids.

This (neither commit msg) does not explain why this is needed and
actually does not sound like hardware-related property.

> +    type: boolean
> +
> +

Do not add double blank lines.

>    "#address-cells":
>      const: 1
>  

Best regards,
Krzysztof

