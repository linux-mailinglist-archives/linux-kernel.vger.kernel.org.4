Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBEFA737BBC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 09:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjFUGkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 02:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbjFUGkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 02:40:16 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225A61730
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 23:40:14 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-987accb4349so664097966b.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 23:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687329612; x=1689921612;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9949oLksZdjy8Az+Gl4mT3bNK7xXkV+1bNbAiYdMeMU=;
        b=X4JW/wGentX5X6jWe55iAHxs2NuH9xINsbENMRv84UCoi2Csxefpn3NgRW6T/5hwqG
         SzUvyjER6ddpAK66tgEF/Jztj49hzX2328fqQhz/qyZCN/fvBsinZXd2ykyw6JxWU0nl
         //iFwDjM51TcNFXEQs758RyuI3+ffFHbXtjyRbU4Xkrk4sqJLjNgGEU83BqBWdS6MAuv
         n7AaKWiSwh/GdInDqq7ec0ZUa9RtKiZvrPbGLCxQv+WNIKiWVmLGPblE7Ae/CeWtwXGI
         +mA8Vv4mY+cam5RCSnZ3C4YtC4kn+5/5lbBYKqCZMdajUMi65C884xOxIfryS3qDR4u3
         VFaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687329612; x=1689921612;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9949oLksZdjy8Az+Gl4mT3bNK7xXkV+1bNbAiYdMeMU=;
        b=C9fd3ldRFAnTLsiKzVAcsEifdctNjjmYf6VXgKaUSpxX19Or4VFyLEaJCo22dul3P5
         IHtLLr1AvJvojrB55qhHoSgcDRHIHCZYWjmavqEUBUpqQn2LJRI+lnHs9eyhk2nmmcMY
         1EciKXeVeK787vhljdsyTow6QsCANVyoS/s1t1HtaRIELFTvb1vOCzI8x0x170iuhHEt
         J3xlIUD+f4AP52CAftd8B2sKhodCqmYJh6URAsbRh+paZyEdt8Y8duYVSZk/8oyvDHrO
         JZtTUqv5Mdv1wO3owPyqAoKWpeR8DHz8eywN8UdYxE4H+Z60yCpNGTKXROQqpmn4rsUE
         2V4w==
X-Gm-Message-State: AC+VfDwLS7iIANPBqgH+qcnfa/clphzUKER0sdhwspxOV5mutgRBbaVe
        +KODhC8I/pQhmcGHZLEp0TOfxQ==
X-Google-Smtp-Source: ACHHUZ6ObrfThgT2NojmF8WfZ2mmQ6Fno7w71HjfXpQ6Kr2k2PDCjJEcAXwuA/qcB3rEO5Evwd7G7w==
X-Received: by 2002:a17:907:9726:b0:987:788d:7e1f with SMTP id jg38-20020a170907972600b00987788d7e1fmr10904022ejc.77.1687329612568;
        Tue, 20 Jun 2023 23:40:12 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id z19-20020a170906669300b00977c7566ccbsm2546915ejo.164.2023.06.20.23.40.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 23:40:12 -0700 (PDT)
Message-ID: <89143a15-6368-0de3-5d76-a942fe877583@linaro.org>
Date:   Wed, 21 Jun 2023 08:40:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] dt-bindings: crypto: intel,ixp4xx: drop unneeded quotes
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230609140745.65046-1-krzysztof.kozlowski@linaro.org>
 <20230609225442.GA2588193-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230609225442.GA2588193-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06/2023 00:54, Rob Herring wrote:
> On Fri, Jun 09, 2023 at 04:07:45PM +0200, Krzysztof Kozlowski wrote:
>> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
>> checking for this can be enabled in yamllint.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  .../devicetree/bindings/crypto/intel,ixp4xx-crypto.yaml         | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> You missed $id and $schema values.
> 
> Within drivers/crypto, there's also:
> 
> diff --git a/Documentation/devicetree/bindings/crypto/amlogic,gxl-crypto.yaml b/Documentation/devicetree/bi
> ndings/crypto/amlogic,gxl-crypto.yaml
> index ecf98a9e72b2..948e11ebe4ee 100644
> --- a/Documentation/devicetree/bindings/crypto/amlogic,gxl-crypto.yaml
> +++ b/Documentation/devicetree/bindings/crypto/amlogic,gxl-crypto.yaml
> @@ -19,8 +19,8 @@ properties:
>  
>    interrupts:
>      items:
> -      - description: "Interrupt for flow 0"
> -      - description: "Interrupt for flow 1"
> +      - description: Interrupt for flow 0
> +      - description: Interrupt for flow 1
>  
>    clocks:
>      maxItems: 1
> 
> Can you add this in here. No reason to split this up more that 1 patch 
> per subsystem really. 

I'll add it. I am also fine for you to squash it or take your scripted
changes/commit if you have it ready.

Best regards,
Krzysztof

