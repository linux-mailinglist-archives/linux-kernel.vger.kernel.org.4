Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6805A6E40C6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 09:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjDQHY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 03:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjDQHYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 03:24:51 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF54E4E
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 00:24:50 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-2fa36231b1cso321395f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 00:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681716289; x=1684308289;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=22NBFkAZpBEWVRcdbiSgrM/DQCt9Fz457g4INDypDTU=;
        b=ws8oMDzd81sxCrNKjw3kpcn76VTuR/IiRRQ+QSIYrp9zwn8lAekqgzN3LhjovKwRFm
         rxmk8qZQ9z8Ku8oA+ogSuBUuD1hrCUW0aGcRvUA1GMlQblgTLkwSFPRYYU2lO6RdsBS9
         XXk7gGuU0hZVQE7FUk4tRTB9DpdkUj05koLY+qqQCeD0kitxzjiQzgeuKzRdjvTr+owo
         jTfjFndKG58oSncZdJCX4LyGtylmRtDj02ibZ50EytCq0cbecXiFSjzI2OpXr6972XeQ
         ksMkX0c8yxvbqzMai/1/rxZnbnfg7fHIQH0J1Xx1wLQLwDJ+xiM0AafrD+5rtl+wFWEu
         cBcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681716289; x=1684308289;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=22NBFkAZpBEWVRcdbiSgrM/DQCt9Fz457g4INDypDTU=;
        b=ePy1a5CGE72oxZXlqOKV/2WLRZB5/RWFo9kOC1w3dc1YcuT05TGQxA+KhG0cmg2aj4
         lpS1QUZHUeylxAL749NHrCsj72CN4pnl9444L3ldBCEzAyK4V1Qwvzp0RAidNh6NSOtT
         5N7yDeZzRuLnFa8R6rUYqyDOjmGXy95/75ibf7p00hg1yy+8y/xOA8fzeI4ebWxjJ3sJ
         9mfYV6Xz9DnyMRGvNGKtomd7FpLZRrnMbQ4t26SKaeJ+RIihGRzc2f/lJNXR3OC1wtgV
         lL042LBxy9w1V4VSEnQg0mEWcvKmuzsFoSSHo5BbN5WUbAcZ4RvqPbrULHnggulGUMIu
         WfNw==
X-Gm-Message-State: AAQBX9d02e89yRPQmtz0I45t1aikiqfcykMwznNgNz3366meSxPmhBDv
        RU7+to0xgqX/o6idKdMhRYJaJA==
X-Google-Smtp-Source: AKy350ZT3rUaSRfkAshIfCc8Uf3pZEYw3cF9SrNeYfj680ogrumtR/gBPGLWWYlueBxbmRo2BMX+GQ==
X-Received: by 2002:adf:ce12:0:b0:2ef:b137:37fe with SMTP id p18-20020adfce12000000b002efb13737femr4408130wrn.0.1681716288740;
        Mon, 17 Apr 2023 00:24:48 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:a1e1:81a8:1acc:2b91? ([2a01:e0a:982:cbb0:a1e1:81a8:1acc:2b91])
        by smtp.gmail.com with ESMTPSA id s15-20020adfea8f000000b002d1801018e2sm9768428wrm.63.2023.04.17.00.24.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 00:24:48 -0700 (PDT)
Message-ID: <b7c40bb6-5e71-d997-8f6b-772f3bcf03d8@linaro.org>
Date:   Mon, 17 Apr 2023 09:24:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] dt-bindings: display: panel: add common definition of
 ports
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>
References: <20230416153929.356330-1-krzysztof.kozlowski@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <20230416153929.356330-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/2023 17:39, Krzysztof Kozlowski wrote:
> Few panel bindings for dual-link connections just type "ports: true",
> which does not enforce any type.  Add common definition of ports, so the
> type will be fixed.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   .../bindings/display/panel/panel-common.yaml     | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/panel-common.yaml b/Documentation/devicetree/bindings/display/panel/panel-common.yaml
> index 5b38dc89cb21..ad62d34e6fa3 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel-common.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/panel-common.yaml
> @@ -70,6 +70,16 @@ properties:
>     port:
>       $ref: /schemas/graph.yaml#/properties/port
>   
> +  # For dual-link connections
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +    patternProperties:
> +      "^port@[0-9a-f]+$":
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +
> +    required:
> +      - port@0
> +
>     ddc-i2c-bus:
>       $ref: /schemas/types.yaml#/definitions/phandle
>       description:
> @@ -154,6 +164,12 @@ dependencies:
>     width-mm: [ height-mm ]
>     height-mm: [ width-mm ]
>   
> +allOf:
> +  - not:
> +      required:
> +        - port
> +        - ports
> +
>   additionalProperties: true
>   
>   ...

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
