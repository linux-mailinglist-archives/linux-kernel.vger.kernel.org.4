Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1D66C019E
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 13:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjCSM3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 08:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjCSM3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 08:29:06 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D380515556
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 05:29:01 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id o12so36850060edb.9
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 05:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679228940;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j+O52D/DV4YgwqI2JOZWwPGBcydQvd8bbC9f6R3xUAY=;
        b=d6mMatByqBvvw9nV/5nVC3nV+LZkLVWCQ02kayCz3j4h/dxzFQzDkCLxYQy0KC/WfT
         0QobqY056ZHkhLgWHaG1xLa7ef5yTFtYXmtwmDQr8CkJp64w1rcQa3fE7vUH3omf+5Gi
         SBt/5xq6XIa8vDgFiyq4TUNOV/M1S+Nzn7h34itm18QnZAO01WgwnNKZQ8w9XkHufo2q
         ssFZyAHWqRsUIj5fO9jVy7zgcZZmf7ZDmNDBM5+jYIPN5DatiKgfNOEdwenvrG8GKMNT
         HCacgmlBDvNqSAB2vQfZ3QYLQ8a34MW246jkM/NDQHkFQYwnbq8c+EXVEAK4+VwGtram
         Gw/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679228940;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j+O52D/DV4YgwqI2JOZWwPGBcydQvd8bbC9f6R3xUAY=;
        b=3TXx75GbHy+egdvsGo09VCJb75XXDZTgPIv5YfJzIJ+LWlhwentoMrbVYTskHJWoCO
         H0tUwNrUAK2o+/X7WCRybfymBAQznXYywoKpH2AS7U+bYCiz2RiY1dMEZ0vkRUPV9l3C
         S0EG0n28ZT/e6AnplmWqeZc6W12Pf1ZkV3Xdd5BD0cVbHrmd6MX3pSgWqZC3ZXxp3twI
         6/piUsvZnU7mQ0D4eceZ6hYody1ohxcpkx69nQZJM/WWKXStGRiW7wr1gvW90ynRHsF+
         cW276G1JSIsn4dVsfkdl7lhRmKGLSyfViahsruI1EDnX5330KY2T8DeHN7tmsvg6hpPk
         P3Eg==
X-Gm-Message-State: AO0yUKUR/QUJDyzFMY7OQP3zFbWkJ6IdwWQ3Y8N7TFrZ8zWhPzFLQb5a
        hEbl8nXXEjjyfgCNaLijDMzK+g==
X-Google-Smtp-Source: AK7set94owjWJlViRmiDbyyh8a8jp6CCdztcsXHhVWObolmpVvjrHsBmCzRtr9vz4WkLaB2DLCdndw==
X-Received: by 2002:a17:906:6953:b0:931:c6ba:8619 with SMTP id c19-20020a170906695300b00931c6ba8619mr6028801ejs.72.1679228940261;
        Sun, 19 Mar 2023 05:29:00 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:5b5f:f22b:a0b:559d? ([2a02:810d:15c0:828:5b5f:f22b:a0b:559d])
        by smtp.gmail.com with ESMTPSA id qx20-20020a170906fcd400b008eaf99be56esm3262695ejb.170.2023.03.19.05.28.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Mar 2023 05:28:59 -0700 (PDT)
Message-ID: <1f352445-4677-e33b-be14-c76bd7ffa188@linaro.org>
Date:   Sun, 19 Mar 2023 13:28:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 3/6] dt-bindings: soc: starfive: syscon: Add optional
 patternProperties
Content-Language: en-US
To:     Xingyu Wu <xingyu.wu@starfivetech.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Conor Dooley <conor@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        William Qiu <william.qiu@starfivetech.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <20230316030514.137427-1-xingyu.wu@starfivetech.com>
 <20230316030514.137427-4-xingyu.wu@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230316030514.137427-4-xingyu.wu@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/03/2023 04:05, Xingyu Wu wrote:
> Add optional compatible and patternProperties.
> 
> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> ---
>  .../soc/starfive/starfive,jh7110-syscon.yaml  | 39 ++++++++++++++++---
>  1 file changed, 33 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml b/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml
> index ae7f1d6916af..b61d8921ef42 100644
> --- a/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml
> +++ b/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml
> @@ -15,16 +15,31 @@ description: |
>  
>  properties:
>    compatible:
> -    items:
> -      - enum:
> -          - starfive,jh7110-aon-syscon
> -          - starfive,jh7110-stg-syscon
> -          - starfive,jh7110-sys-syscon
> -      - const: syscon
> +    oneOf:
> +      - items:
> +          - enum:
> +              - starfive,jh7110-aon-syscon
> +              - starfive,jh7110-stg-syscon
> +              - starfive,jh7110-sys-syscon
> +          - const: syscon
> +      - items:
> +          - enum:
> +              - starfive,jh7110-aon-syscon
> +              - starfive,jh7110-stg-syscon
> +              - starfive,jh7110-sys-syscon
> +          - const: syscon
> +          - const: simple-mfd
>  
>    reg:
>      maxItems: 1
>  
> +patternProperties:
> +  # Optional children
> +  "pll-clock-controller":

It's not a pattern.

Anyway should be clock-controller

> +    type: object
> +    $ref: /schemas/clock/starfive,jh7110-pll.yaml#
> +    description: Clock provider for PLL.
> +

You just added these bindings! So the initial submission was incomplete
on purpose?

No, add complete bindings.

>  required:
>    - compatible
>    - reg
> @@ -38,4 +53,16 @@ examples:
>          reg = <0x10240000 0x1000>;
>      };
>  
> +  - |
> +    syscon@13030000 {

No need for new example... Just put it in existing one.


Best regards,
Krzysztof

