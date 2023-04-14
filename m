Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1F16E1D46
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 09:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjDNHfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 03:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjDNHfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 03:35:04 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9E36595
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 00:34:43 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id q23so33946857ejz.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 00:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681457676; x=1684049676;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R+rh3tDvh6WkK7g8h9KApr2CJ8l25rqXWTlNAb5p0pY=;
        b=p3fXroZpOQkazJL/kjoMSRniuPA4fAGPsUR3lrGrgN306Q6HTfNnzTmfz3zOofY2Eq
         0izO5J5X/Fy94Y2sCAERvKKyInONDCnHlJ+7gvHjOl946qu2TicB4L0AQRRJMONqRHDJ
         dGzVGJcdmD39i6WI1+KNGYGJZIQfGBrnDVZkeWESjfDyluYYrzCICF+er2Jg/RwsWtW2
         mg+LWjrBnPFL9jN2fPgt2LRTDKRuYb6PheaZOe7lWsU3VO9AAwdW/c5oIbpj9NQmJBtr
         pslTev0VbDyx7JkbEm5g7yN5L3Sf288U6MypPefNgbzOIBBxioUqzv+j4gKzZ3vXQIMr
         /jTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681457676; x=1684049676;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R+rh3tDvh6WkK7g8h9KApr2CJ8l25rqXWTlNAb5p0pY=;
        b=WorzgPQckHEZZLvcmr+eT0Ma65oQ/P83seMBhwObuIq3ADOJOnls4CXGd+YpUYry9S
         QdNoy+UKnb6aRuKEp8Fl4RCHz3yR6PpLyG5xHSWyhp4hczzW0Ki1CAb2IfpIKm4IRkbm
         OwM86dAdznaMdnses44pP01c8y8tuobOaObKFallyhPCWHYUR31uHVgxELQJGIfJ7tSl
         nwOD+s/CUMWX04+4pMM2JUFrUYpuXuS9NBVKQJKDINgqe02KXQfKcTguwKKgdkRm3jWc
         fopnoXzrRErh+xZQxaM0wIDB8lz1lJFHPl4H10sULnHLCNzybrQ6YwzszumUVXcWHDux
         RndA==
X-Gm-Message-State: AAQBX9elNEIj3lzx44pOdobfbLDp3VYtzvPoledZvp2qgSFR8ivduhod
        A7rSBiNDlCAKtzwTvvVZlzYlFA==
X-Google-Smtp-Source: AKy350arUjQBSNqUUBjSuVfoDP8zc1vyW/pMS/UxUoiUXdFN6JUn2vgJa2VEVtjwqNN1gsEkfBgebg==
X-Received: by 2002:a17:906:a4b:b0:94e:4700:7a66 with SMTP id x11-20020a1709060a4b00b0094e47007a66mr9163112ejf.6.1681457675818;
        Fri, 14 Apr 2023 00:34:35 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:8a60:6b0f:105a:eefb? ([2a02:810d:15c0:828:8a60:6b0f:105a:eefb])
        by smtp.gmail.com with ESMTPSA id d16-20020a17090648d000b0094bcf409ec9sm2050595ejt.49.2023.04.14.00.34.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 00:34:35 -0700 (PDT)
Message-ID: <9ceba633-cf36-efd3-6889-1bbe6755b398@linaro.org>
Date:   Fri, 14 Apr 2023 09:34:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCHv4 1/3] dt-bindings: usb: Add RK3588 OHCI
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Rob Herring <robh@kernel.org>
References: <20230413173150.71387-1-sebastian.reichel@collabora.com>
 <20230413173150.71387-2-sebastian.reichel@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230413173150.71387-2-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2023 19:31, Sebastian Reichel wrote:
> Add compatible for RK3588 OHCI. As far as I know it's fully
> compatible with generic-ohci.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Sebastian,

Can you fix PATCH subject part in all your submissions? There should be
a space between PATCH and v. Just like `git format-patch` creates. If
you use other tools for this, fix them so they don't create other format.

You also need to rebase your patches - this is something old and cannot
be applied.

> ---
>  .../devicetree/bindings/usb/generic-ohci.yaml    | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/generic-ohci.yaml b/Documentation/devicetree/bindings/usb/generic-ohci.yaml
> index a9ba7257b884..4feb993af53b 100644
> --- a/Documentation/devicetree/bindings/usb/generic-ohci.yaml
> +++ b/Documentation/devicetree/bindings/usb/generic-ohci.yaml
> @@ -44,6 +44,7 @@ properties:
>                - hpe,gxp-ohci
>                - ibm,476gtr-ohci
>                - ingenic,jz4740-ohci
> +              - rockchip,rk3588-ohci
>                - snps,hsdk-v1.0-ohci
>            - const: generic-ohci
>        - enum:
> @@ -69,7 +70,7 @@ properties:
>  
>    clocks:
>      minItems: 1
> -    maxItems: 3
> +    maxItems: 4
>      description: |
>        In case the Renesas R-Car Gen3 SoCs:
>          - if a host only channel: first clock should be host.
> @@ -147,6 +148,19 @@ allOf:
>      then:
>        properties:
>          transceiver: false
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: rockchip,rk3588-ohci
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 4
> +    else:
> +      properties:
> +        clocks:

Please test the patches before sending. If you tested, you would see
warnings here.

You need minItems: 1.

> +          maxItems: 3
>  
>  additionalProperties: false
>  

Best regards,
Krzysztof

