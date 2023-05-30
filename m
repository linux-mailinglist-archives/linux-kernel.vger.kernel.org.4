Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744DF716302
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbjE3OEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjE3OEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:04:37 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9F7B2
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 07:04:36 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-510f525e06cso7860402a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 07:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685455475; x=1688047475;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QYxvmLTRS13Ehc3QgciGTadH+O7LLfNmtYTSHMK4epM=;
        b=AfV/EiRzkrXsTyysLyhpCFT8cI/HfscqQp0tI3HrhAPz4ynNqrdym/iIYy5F/pw+74
         B9HnS9kFRB3OrvdSz+l1t5ler1GR1rUzWopwNykAPsXX4pJiWJEynSMnuIuoelqSREbq
         ozI4/MsvwNS9UHhbajkaDiRF0QC22E9exrDbrPg1dJ7luqtjpqEU6/CoFoDMGV4u1kUz
         MT9BzkXx9EfhaR9lPnuDXjPH/zoC7cnRLgGeYwlHHNve2aQQ2qD/vNc5NPFtAX0ymfoI
         ksq577fC4rGw/UrfFPjDK2aAU68qmtvXNsSuq2Jp16qUQXVVKU9+RxFPFbIcvR3uR9I2
         PR6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685455475; x=1688047475;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QYxvmLTRS13Ehc3QgciGTadH+O7LLfNmtYTSHMK4epM=;
        b=RiEkhGgzAhR2WqXQGzgESMD4rOyRjqhLMLbkhPGHwmrH2X0xr6Pz7TrpEk++o+uROT
         n686LL38bAtpcywucsMtmnRPMQJDvabohPc1LMUppGWNMOcUq3SgSEn+RJlB9XxAg7A5
         ZjZQWGMh5OKf557E9p39oKhDfh2u72xIa7DRepVnGK+tHHKLwnIaPdIZTu4s3LIbv+ug
         9H4IlsoaHEZ655dJTSntISXhQ8bZ+vj/UL+eULUhF3pDGtS5wz2KbsMzNE6ltdgSoyRh
         PZ7h+gWCIG3K6fCpHDTCfg9XD0JvBY4Fi2a1HMpAJNq6MNWYEijRI9r5d7GO2ilG5KQA
         Ddhw==
X-Gm-Message-State: AC+VfDzh8wdh/d+o7DTLJA7jUPB3IhGzIWJdi7KzSDcChTZaVevBlJBu
        9AgwPhZGPtE94XhK/oCG8p7u7w==
X-Google-Smtp-Source: ACHHUZ65SdQ7bm40X1xjIzR//czjn3KI6YOqjCZL15qypKnRSXEwK+KSK6hQIq2PFBtO6Vd526Gbkw==
X-Received: by 2002:aa7:dccd:0:b0:50c:cde7:285b with SMTP id w13-20020aa7dccd000000b0050ccde7285bmr1610460edu.29.1685455475339;
        Tue, 30 May 2023 07:04:35 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id r25-20020aa7da19000000b00510d8e43fe0sm4415999eds.7.2023.05.30.07.04.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 07:04:34 -0700 (PDT)
Message-ID: <ca6042f7-5586-8f7d-19a1-73a3676697f6@linaro.org>
Date:   Tue, 30 May 2023 16:04:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/3] dt-bindings: net: pse-pd: Add "ethernet-pse-0"
 example to improve validation in podl-pse-regulator DT binding
Content-Language: en-US
To:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        =?UTF-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <jerome.pouiller@silabs.com>
Cc:     kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org
References: <20230530083713.2527380-1-o.rempel@pengutronix.de>
 <20230530083713.2527380-3-o.rempel@pengutronix.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230530083713.2527380-3-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/2023 10:37, Oleksij Rempel wrote:
> This change adds a new example, "ethernet-pse-0", to the device tree
> binding for podl-pse-regulator. This helps improve validation by
> supporting more types of node names.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  .../devicetree/bindings/net/pse-pd/podl-pse-regulator.yaml  | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/pse-pd/podl-pse-regulator.yaml b/Documentation/devicetree/bindings/net/pse-pd/podl-pse-regulator.yaml
> index 94a527e6aa1b..25d237e0f406 100644
> --- a/Documentation/devicetree/bindings/net/pse-pd/podl-pse-regulator.yaml
> +++ b/Documentation/devicetree/bindings/net/pse-pd/podl-pse-regulator.yaml
> @@ -38,3 +38,9 @@ examples:
>        pse-supply = <&reg_t1l1>;
>        #pse-cells = <0>;
>      };
> +  - |
> +    ethernet-pse-0 {

It's the same example. No need for new one with different node names.

Best regards,
Krzysztof

