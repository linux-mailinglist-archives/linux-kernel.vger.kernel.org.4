Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841B472279D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 15:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjFENiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 09:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbjFENiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 09:38:18 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E67992
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 06:38:17 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-974638ed5c5so665128966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 06:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685972296; x=1688564296;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YLyoEValMocGeR7hgOgzE/kheQnkrpszWV0a0C9TVl4=;
        b=fkvn2QYrPsJfos5zBtbo/hdXMcMJOBJROMI85p4dwCpA++lAv4Uz8+tbjB6Hugq67x
         RFGVo5QcaeR85lG7f76G5FxJ+NynJxG/QHomah2/n+pD8nibSMVWdFNmtp8HonJ76i3h
         T4cXpYhYCcAFQWP8fWfPUZKQK2okCLiyizAutElK/0AhdEyl9FTH0P99aBEdq+cZPbrB
         ekJA2v5jy//BUJDjyi6WwUEDytl+vZfymqwyXe7XGgxD0Cu3vx6OyC0nB7BBZg3+WvVK
         8jfkSIBxWm+hEvO3XHhmLLUz2cZtrpcxz6UQ/D1DHYAmXB2I79xzsFQpemovzTZp8gTc
         GBJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685972296; x=1688564296;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YLyoEValMocGeR7hgOgzE/kheQnkrpszWV0a0C9TVl4=;
        b=QdOPWhvMEq5Y+iCxjJE/aUH2nCNp1dhg/lzgjLoMhj5Z/BLFipvX8dJTty97yg4EMj
         oJK3qdx97+Q589BY10rUfUQYClX0GmI1y4lLK0AoDP57VPBkjmb0f2N3uZGyl+uuFWSj
         XfBahYnqAoH3Q5GyIGuAB3EFxbQSmOePlUtwA3skH6TqJlo7g9b0TtDNbLdmx985bfjd
         6OgLcVxI66hSlYIfYv8ujasUJdn2r6QGsIRca/H07jI78AUfWardRFpksGjwJgx/FpPo
         pOpmKeDwJREG7VJ37SwjHP7RaQV3tjy9mLqyaTRv27SzI1xwlODrE0jT9UKn4WIy611a
         0/+Q==
X-Gm-Message-State: AC+VfDzmHBtL+yTALEdmjcbKmFtl3O8DJAjCgksdNh1e2+PAbo1qmQ2P
        56WkpdwwK7BB9CyeiUXqyDH8Jw==
X-Google-Smtp-Source: ACHHUZ7XI9buLjboedG2CXZeO60+HVdfffsOtvJfrjVcif+HXPZhSTUxG2pyGFmoNV5clXR1o54RsQ==
X-Received: by 2002:a17:907:7b88:b0:973:8edc:5a57 with SMTP id ne8-20020a1709077b8800b009738edc5a57mr6594638ejc.4.1685972295769;
        Mon, 05 Jun 2023 06:38:15 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id y10-20020a170906914a00b00965ac8f8a3dsm4364101ejw.173.2023.06.05.06.38.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 06:38:15 -0700 (PDT)
Message-ID: <5d1f08f1-792b-255b-89f0-dd5fa2f0baa4@linaro.org>
Date:   Mon, 5 Jun 2023 15:38:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v3 1/2] dt-bindings: clock: fixed-clock: Add nvmem support
Content-Language: en-US
To:     Mike Looijmans <mike.looijmans@topic.nl>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.1d0217a8-661f-4359-b77b-02222c761b01@emailsignatures365.codetwo.com>
 <20230605133410.15076-1-mike.looijmans@topic.nl>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230605133410.15076-1-mike.looijmans@topic.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/06/2023 15:34, Mike Looijmans wrote:
> Add bindings for a fixed-rate clock that retrieves its rate from an
> NVMEM provider. This allows to store clock settings in EEPROM or EFUSE
> or similar device.
> 
> Component shortages lead to boards being shipped with different clock
> crystals, based on what was available at the time. The clock frequency
> was written to EEPROM at production time. Systems can adapt to a wide
> range of input frequencies using the clock framework, but this required
> us to patch the devicetree at runtime or use some custom driver. This
> provides a more generic solution.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> 
> ---
> 
> Changes in v3:
> Modify fixed-clock instead of introducing nvmem-clock
> 
> Changes in v2:
> Changed "fixed-clock" into "nvmem-clock" in dts example
> Add minItems:1 to nvmem-cell-names
> 
>  .../bindings/clock/fixed-clock.yaml           | 25 ++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/fixed-clock.yaml b/Documentation/devicetree/bindings/clock/fixed-clock.yaml
> index b0a4fb8256e2..23e4df96d3b0 100644
> --- a/Documentation/devicetree/bindings/clock/fixed-clock.yaml
> +++ b/Documentation/devicetree/bindings/clock/fixed-clock.yaml
> @@ -12,7 +12,9 @@ maintainers:
>  
>  properties:
>    compatible:
> -    const: fixed-clock
> +    enum:
> +      - fixed-clock
> +      - fixed-clock-nvmem

Do you even need new compatible? Isn't this the same clock from the
hardware point of view?

>  
>    "#clock-cells":
>      const: 0
> @@ -33,6 +35,27 @@ required:
>  
>  additionalProperties: false
>  

Put it under allOf. Entire block should be before additionalProperties
(just like in example-schema).

> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        const: fixed-clock-nvmem
> +
> +then:
> +  properties:
> +    nvmem-cells:
> +      maxItems: 2

Anyway, I don't think you tested it. Provide a DTS user of this. I don't
think it works and such user would point to mistakes.

Properties should be defined in top-level properties:, not in
allOf:if:then. In allOf:if:then you only narrow them.


> +      description:
> +        Reads clock-frequency and/or clock-accuracy from an NVMEM provider in
> +        binary native integer format. The size of the NVMEM cell can be 1, 2, 4
> +        or 8 bytes. If the contents of the nvmem are all zeroes or all 0xff, the
> +        value reverts to the one given in the property.
> +

Best regards,
Krzysztof

