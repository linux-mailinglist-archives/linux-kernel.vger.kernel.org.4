Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F3E6943B1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 12:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjBMLCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 06:02:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjBMLCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 06:02:04 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653F5C162
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 03:02:03 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id n13so8404590wmr.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 03:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8WzWyArS5gEO/wRc+fU03BRey5p9sqIym9cvOO3Y6eU=;
        b=zTMeYc9cO7mscsDds2h1TZLFUu8Tl/dWC1eLhgkAYD33QzKi6lOyFZCe4+5knSiBwW
         XR9UNZ7XsvjvO+JG615egdZseIchSL73cinaBanQbKXDwrgW6dI+LJeA0+4BOQMu1/PF
         v9zI5YVn0kLkc96zUF45F0XddOourilUsjqZ5szNWdTcjvKSgFQ7Kr49GHZCMqFk8XYo
         6nXIBHRxVldefmfy3uIgJCqG2AYHb6yEFGpeYNwKl0qVOBfBX4MJGRdOwPOuRWvjK2iH
         i+aPALN0LvPGF6CkeuXz11c6z1jOZewTHifzj233mIEG8CXKDMNEdNxzgiLC/bHO7oc6
         XePw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8WzWyArS5gEO/wRc+fU03BRey5p9sqIym9cvOO3Y6eU=;
        b=E/YAIi86Qrget/4ffPSwX1rpH5ADlH0mbEBiPUU0i2cmhP9OqwtxXdVQeQY8iEFrZX
         4nMauRU8eD4nz+lVwRJrU54CE+MOoVXB5KZR7C471RttSak7b4aCDuQvIVsYdTsY89om
         5fwHLClpxPQmZB8xqf9leP9gU07PyEWF12dXzSJtcpdmpMtpjKZUPu+oBhJ1qbOOPr9n
         Bdmu5hb+6ehc6XBjD0SKZbqKp6EHZgRVffelSlBVUi9VpahKWMgvB+cYWL0/D89asiPX
         fwQKJWN4vCKrjm8c8YjW11+53cke65iYflTmph3GNIsgB8RvIJXiLRXwoiwlqnfrLO0T
         YhhQ==
X-Gm-Message-State: AO0yUKWcJiSTYyKN+9W1iVh9Sbw9ts6PuBCXLkKcqgfaSFTANHTwImig
        9yWhVHSBQZqenuv1QRdiMe3fdQ==
X-Google-Smtp-Source: AK7set+QKXqhsOFrxdGsWPqrhu0Ju0VH7kga/YlH2Hs/FF4nhofUvdKD5RlJPyj/WOB3XGC6kDFFXg==
X-Received: by 2002:a05:600c:30ca:b0:3df:c284:7e78 with SMTP id h10-20020a05600c30ca00b003dfc2847e78mr20536285wmn.38.1676286121946;
        Mon, 13 Feb 2023 03:02:01 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id g10-20020a05600c310a00b003e1e8d794e1sm4719972wmo.13.2023.02.13.03.02.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 03:02:01 -0800 (PST)
Message-ID: <4b8e3164-f39a-c559-7bac-86c4fdcd6834@linaro.org>
Date:   Mon, 13 Feb 2023 12:01:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 4/6] dt-bindings: soc: amlogic: convert
 amlogic,gxbb-clkc.txt to dt-schema
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20230209-b4-amlogic-bindings-convert-take2-v1-0-c4fe9049def9@linaro.org>
 <20230209-b4-amlogic-bindings-convert-take2-v1-4-c4fe9049def9@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230209-b4-amlogic-bindings-convert-take2-v1-4-c4fe9049def9@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02/2023 14:41, Neil Armstrong wrote:
> Convert the Amlogic Clock Controller bindings to dt-schema.

Subject prefix - clock, not soc.

> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../bindings/clock/amlogic,gxbb-clkc.txt           | 53 ----------------------
>  .../bindings/clock/amlogic,gxbb-clkc.yaml          | 51 +++++++++++++++++++++
>  2 files changed, 51 insertions(+), 53 deletions(-)


> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: xtal
> +
> +  '#clock-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - clocks
> +  - clock-names
> +  - '#clock-cells'
> +
> +unevaluatedProperties: false

additionalProperties: false

> +
> +examples:
> +  - |
> +    sysctrl: system-controller@0 {
> +        compatible = "amlogic,meson-gx-hhi-sysctrl", "simple-mfd", "syscon";
> +        reg = <0 0x400>;

Drop the parent node, not needed here. You could even skip the example
entirely as it is part of your syscon. If you keep example, then without
parent pieces.

> + 
> +        clkc: clock-controller {
> +            compatible = "amlogic,gxbb-clkc";
> +            #clock-cells = <1>;
> +            clocks = <&xtal>;
> +            clock-names = "xtal";
> +        };
> +    };
> 

Best regards,
Krzysztof

