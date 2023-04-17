Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774D66E40A0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 09:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjDQHVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 03:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjDQHVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 03:21:02 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE2844B4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 00:20:34 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4ec817735a7so1188804e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 00:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681716033; x=1684308033;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=23eaV4yrZlv41f+CKNhvw+EBCrhUaHp4FA0RWyDryN0=;
        b=brrL1QkKtXOzgBfJa/J15xXIyDQ7hn5Ramsb1NyNUFrt9xKV+RafsrwZSVMIi/SOqi
         4WlwHdUOu2anKQdKDl8mGXpCtkkfBpjMLvdMfxrBZsFs0p/f2/rhBtMSlasgzrQIleIv
         fz0lnazxeXtCMYnUPqbrW6XICHV06uBE8QYA4TmObJO2RjyjIPZZaOK7GbK8nwB0EH8N
         EV8xAQBRXZD5C7BcV24IMP0KRhFDYUf2U1T3uvTlls7Ea0gupaKsPMWNjV+lmBTWj4j3
         So/3uP7iv2yokepC2vsq8NbCEQdZOQ52DOxqbohFNzWh3NC8Syhi1q16BvUR4MeyDIPX
         isPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681716033; x=1684308033;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=23eaV4yrZlv41f+CKNhvw+EBCrhUaHp4FA0RWyDryN0=;
        b=ULnAXZYu4/21paleXq/zRaLOC4yWy+DkIm5+qSfj2oZXdGAkqnCeV1fvgIid0btdIP
         sRniDwKTY7bgZM0X9ICAQHMKwULgKdXGPwgWb+I3mR61yw6qQYMRof+CHzZFJz9q1wmI
         RmUHbvMZdoafqvnj4kO+Y59E2wqWLWFPzGD3PhW9UE+HX8jTCJw5sfnEvohSKR+te/hK
         sHN0c5xergrGfycj2pnwdZlMjic1tIccsGpJ2fp1vLC3zv1HxE7c1OjreLB0FSPXCunv
         OXY2YoRCLPOBETylXIRXf+dvl/goMj7hSVL9w7xRwf9UTwCuuHFpCQ6UFWf7uZ++9SMV
         uriw==
X-Gm-Message-State: AAQBX9fKDIQ3GVmDkh0ckt/BPSsbYBbkwqJYU8+DpaTXTJYbIXmCoaJs
        lX8M7MJrR+MmCPRFX0vAzmnKFA==
X-Google-Smtp-Source: AKy350ZCzYttSbW0KXmPxpfqHUCsLYwl5TDvD9kAjWNUhP1831FlnXfA3HGZWwg3Xq2TkcdcwMnS9g==
X-Received: by 2002:ac2:5310:0:b0:4eb:3615:4c35 with SMTP id c16-20020ac25310000000b004eb36154c35mr1510089lfh.33.1681716032961;
        Mon, 17 Apr 2023 00:20:32 -0700 (PDT)
Received: from [192.168.1.101] (abyk99.neoplus.adsl.tpnet.pl. [83.9.30.99])
        by smtp.gmail.com with ESMTPSA id 13-20020ac2482d000000b004e8452972a2sm1949681lft.247.2023.04.17.00.20.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 00:20:32 -0700 (PDT)
Message-ID: <33ac8c1d-bc0b-7056-09f5-95ee4f319f1a@linaro.org>
Date:   Mon, 17 Apr 2023 09:20:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] dt-bindings: display: panel: add common definition of
 ports
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230416153929.356330-1-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230416153929.356330-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
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



On 16.04.2023 17:39, Krzysztof Kozlowski wrote:
> Few panel bindings for dual-link connections just type "ports: true",
> which does not enforce any type.  Add common definition of ports, so the
> type will be fixed.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> 
> Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../bindings/display/panel/panel-common.yaml     | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/panel-common.yaml b/Documentation/devicetree/bindings/display/panel/panel-common.yaml
> index 5b38dc89cb21..ad62d34e6fa3 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel-common.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/panel-common.yaml
> @@ -70,6 +70,16 @@ properties:
>    port:
>      $ref: /schemas/graph.yaml#/properties/port
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
>    ddc-i2c-bus:
>      $ref: /schemas/types.yaml#/definitions/phandle
>      description:
> @@ -154,6 +164,12 @@ dependencies:
>    width-mm: [ height-mm ]
>    height-mm: [ width-mm ]
>  
> +allOf:
> +  - not:
> +      required:
> +        - port
> +        - ports
> +
>  additionalProperties: true
>  
>  ...
