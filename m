Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C35737BDD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 09:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjFUGoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 02:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbjFUGnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 02:43:50 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB5819A3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 23:43:48 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-988b75d8b28so378473366b.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 23:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687329827; x=1689921827;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F0A4OfbxXz0NGj/tr2eOFVX7aKZ0BmIyiRE/0eK0Tsc=;
        b=A1A3VqqATsj9m91b8e6nszvWgrgzHYl5Dtbu9Bmigq/HCZV3BEKgWFbJ4LjLgiiiTO
         0bcN8ZlOv25gLfLK9c6IZ1jMf51Gq1n8Wqej0pwdjSTxQmspiz8jzidC/xD8kKm4Cc3U
         9PxnltFcq9eHMs0ziN35adhftX77fndHtKQWONC/ZSZ2C09cDahX0wikojZ6yS8T2tzC
         VodO25bJKgchu0vy1JNQygqXgwZm0o9WTUcA1Tcfko3Fx96aNfPLILfCr7NBOKH20CbD
         pxGXhWYe5bNmrJ+xOCBbjkGT5yqhHfKepdxKk/hXFP2Df5wP9wHZD4LN3NJDw5aRWXuf
         R4BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687329827; x=1689921827;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F0A4OfbxXz0NGj/tr2eOFVX7aKZ0BmIyiRE/0eK0Tsc=;
        b=Lj8HhwXjRXcJYWcNf5sHlRQOTnK01NRM4bwRNemrsp0LS4sD7J2dpVffbmLvj9cVhM
         moigSZ8Ct/o7BnawQkQpUG2Ak8kpKwSIB7schAgt/eGMkyrnfOz/tQDFotu3gZpNKpUa
         LYm/TOriOF8Pm8V9Vi6op/m7kI51sx8Vh9ygZj9y8WL08m8PRJn/59Zx5zliD+SVoK+3
         L10AqD5NY3mVbd7MGVn9J+6/T6ZSZXXZ8ITO8d1FYtC4qzqXpvXAgzqdWpld/ayCPO6S
         Js3AZuJh2fcfmvul51VHZTEtIfVLrWgJEa1QHlTFiX+P0nUDUNKaDsrgmRohOZkhlv48
         fvxg==
X-Gm-Message-State: AC+VfDwVxws2Q/MyUTSdiTsV3YcqRHTdzrM1Ma5qFy0OrnEWMQp94Ht9
        kOOHKr6rM4E70UwM8DwIw5X7LA==
X-Google-Smtp-Source: ACHHUZ5NLJ7rt7MgGuAm518oncvlxewAqw47rJlEY3QWjb+vmV9EdHXHOO4uemy2tyvG7B+vutb7ag==
X-Received: by 2002:a17:907:1c07:b0:94f:956:b3f7 with SMTP id nc7-20020a1709071c0700b0094f0956b3f7mr15282239ejc.2.1687329826802;
        Tue, 20 Jun 2023 23:43:46 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id w17-20020a1709060a1100b0096f6a131b9fsm2536918ejf.23.2023.06.20.23.43.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 23:43:46 -0700 (PDT)
Message-ID: <f2546eb4-5b4f-3e77-a08c-941a323e7f73@linaro.org>
Date:   Wed, 21 Jun 2023 08:43:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] dt-bindings: crypto: intel,ixp4xx: drop unneeded
 quotes
Content-Language: en-US
To:     Corentin Labbe <clabbe@baylibre.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-crypto@vger.kernel.org, linux-amlogic@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230621064242.9038-1-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230621064242.9038-1-krzysztof.kozlowski@linaro.org>
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

On 21/06/2023 08:42, Krzysztof Kozlowski wrote:
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> ---
> 
> Changes in v2:
> 1. Drop more quotes (also amlogic)

I need to update subject, so v3.

Best regards,
Krzysztof

