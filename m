Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C2971EFB9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 18:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjFAQxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 12:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbjFAQwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 12:52:36 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B4F195
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 09:52:24 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2af316b4515so15347901fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 09:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685638343; x=1688230343;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cv5o48CpGTaTmkSqmSGB6JrLPZbZffPhXroyECMP20Q=;
        b=dK2zE69rNsGt4bXTMWMxq6bZpD4cU/x1vn4XebDWEoyqfWByDSis5f5x5GGv4KO6+g
         B+FkzBs6FLdaaLN183dNIA96rVI5Kzag0fh8EugZ5FurJHNO/MwMye+IcB4vb1hIHsRV
         q1+Uau405GRgsgxsByoJgmnJACabUg9vPnQBfz9vtnbQiTiEtWB6MoHLDz7LUyRHm9+1
         DwKobSv0MjAJ+TlLpEN3pyvRUZXb23HNRa7tQe88t8gq2Eo/iVfo4PegSVzC8fRDa7dZ
         gMtLNuqAvIOS8aRLs7GsGHEJwnJIV1/4y8GwjlFi459jLzGr5gsmz9I7H1xLmg0DAZeg
         dWPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685638343; x=1688230343;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cv5o48CpGTaTmkSqmSGB6JrLPZbZffPhXroyECMP20Q=;
        b=brQye5g0pUBXAyn7YwUEb1bvKy1kki38ZG5qOPMg8FhRz+WNAlDGh6B79coBlo+ouB
         k8PxMWKRQtTxhTnVyyl+2+vvPN/v4+9J4sM6XVMTqlqb4K9UCCZEQxKvkche3ctKqUjX
         oHaO/gJBmc6LxtPeA2xTijR1ojc4iM90zSz8ph+Jt88kK6E2okj2x5Ke/Yn1ZzxISI9p
         ClRh7rnMH2uFUtiX+Xeck4N2zpMhBeUqeVVlaYzCDT45crcD+cgak43Rhl5PfjwBx8GO
         PNYUzbnJwEI/An7CZqlGhoA7Qm3uNetzzcg6PnjuSYmC6zRs4aJwSKY9Aa4dEc0t8G9D
         Nqbw==
X-Gm-Message-State: AC+VfDzbfR8Vrnao7n389ty3jVp7L6Z86EQqrSTdFB32d+aHzn2VTyVg
        x1tm2VxhgSQwZS354vh1+KNLKQ==
X-Google-Smtp-Source: ACHHUZ45xf+TTk2bM1U0IxRDaisGc8GzwSlvqbxUDojASZ12tvMvve9++CtLVgt3KkKUeuYY89L//A==
X-Received: by 2002:a2e:b043:0:b0:2af:1807:9e6 with SMTP id d3-20020a2eb043000000b002af180709e6mr7081ljl.35.1685638342869;
        Thu, 01 Jun 2023 09:52:22 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id fi13-20020a170906da0d00b0096fbc516a93sm10668583ejb.211.2023.06.01.09.52.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 09:52:22 -0700 (PDT)
Message-ID: <5f5f6412-f466-9a3f-3ec7-aa45ab0049c6@linaro.org>
Date:   Thu, 1 Jun 2023 18:52:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] dt-bindings: net: phy: Support external PHY xtal
Content-Language: en-US
To:     Detlev Casanova <detlev.casanova@collabora.com>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     linux-kernel@vger.kernel.org,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org
References: <20230531150340.522994-1-detlev.casanova@collabora.com>
 <ade45bcf-c174-429a-96ca-d0ffb41748d4@lunn.ch> <6646604.lOV4Wx5bFT@arisu>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <6646604.lOV4Wx5bFT@arisu>
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

On 31/05/2023 20:00, Detlev Casanova wrote:
>>> +  clock-names:
>>> +    items:
>>> +      - const: xtal
>>
>> I don't think xtal is the best of names here. It generally is used as
>> an abbreviation for crystal. And the commit message is about there not
>> being a crystal, but an actual clock.
>>
>> How is this clock named on the datasheet?
> 
> In the case of the PHY I used (RTL8211F), it is EXT_CLK. But this must be 
> generic to any (ethernet) PHY, so using ext_clk to match it would not be
> good either.
> 
> Now this is about having an external clock, so the ext_clk name makes sense in 
> this case.
> 
> I'm not pushing one name or another, let's use what you feel is more natural.

Just drop the name.

Best regards,
Krzysztof

