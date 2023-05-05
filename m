Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168EC6F882C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 19:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbjEERxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 13:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233216AbjEERxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 13:53:16 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3EF820771
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 10:52:49 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-50bc25f0c7dso4017488a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 10:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683309151; x=1685901151;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6sUv+mxYLqvu3NJwUUp7JPVxNoacj7K8gOnMggCQwI0=;
        b=M1VZtkM0ywzlajTqWZXGk82E3QZX7h/h9qN2QiTl5IB6oCnyM7vqfryA1Cy+WAtERo
         JS66N5pzJJQ0lgPBcEt+33wkO9kO24juExekk70M8ri7Za8L79eCLw/L9esxyM27SOwD
         xoUHriGv05ZG81jrceRk4HKJzBhR+9nmKWX7lD6XLBreg8XQw2N28uxVLq6oIv8M1lDe
         CoDNhfupqIaW8lO3dvoP1o7HJcU/MqYzIDqon/xoEQJoPzxTcouuFnht9fys8u1apaiY
         QC8664pXj9ZX9guj/RJbGQ5lyzu3AGhzwmX9Rt7mC9ovXdoueV2xUTK1yCxuGfiKbIKa
         /+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683309151; x=1685901151;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6sUv+mxYLqvu3NJwUUp7JPVxNoacj7K8gOnMggCQwI0=;
        b=LORKjx2XWFyh7KQwcnZzsJ02Q/VZLPMKL/A+P2OWaXG6wEpgqj4MVfwwJ4sG807Gtr
         rZuCubOMPB3A/gr6ECQkZ0EB6qxtyX9998UTd7F4yRnv147nJypPIsU3mqk87Lw/2Efm
         C3Er4DLhoeSxICSVsYyP/Nk4OJ/wiEID21pZC647wY1/n6Y8zWfFKaspDxcQDE627Qb7
         degffv9rVqEjqJv5EZbZ3GV/wDqypvpLHGnjYvBTkLrNbapR+T2t1iY2h0UNTZoZ841/
         isNPgveCuyv0xpNTnlltS5ZlTjwnkAHKeclKJHAjSzuUuHdqD8dxhxH246/zIjnSpAr7
         4zHA==
X-Gm-Message-State: AC+VfDwdN8lspITctY6NofK/CJjk5EQv7ErgjsMdVhD/3KgY4Ap9jfLS
        m3TUawt2F5IwlWEKOuWGbuEweQ==
X-Google-Smtp-Source: ACHHUZ5KpVgBxX/ctiq3aH7QlmcztFKjWUetQv4Px3BNI5sTnDbBf1pnLETF1U6N9rL6emZOqvn+QQ==
X-Received: by 2002:a17:907:1687:b0:958:cc8:bd55 with SMTP id hc7-20020a170907168700b009580cc8bd55mr2736877ejc.0.1683309151533;
        Fri, 05 May 2023 10:52:31 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:52e:24ce:bbc1:127d? ([2a02:810d:15c0:828:52e:24ce:bbc1:127d])
        by smtp.gmail.com with ESMTPSA id bz6-20020a1709070aa600b0095850aef138sm1202538ejc.6.2023.05.05.10.52.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 10:52:30 -0700 (PDT)
Message-ID: <5e470654-11c8-929f-cfd4-5ca03519bec2@linaro.org>
Date:   Fri, 5 May 2023 19:52:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 1/2] dt-bindings: net: motorcomm: Add pad driver
 strength cfg
Content-Language: en-US
To:     Samin Guo <samin.guo@starfivetech.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>,
        Frank <Frank.Sae@motor-comm.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Yanhong Wang <yanhong.wang@starfivetech.com>
References: <20230505090558.2355-1-samin.guo@starfivetech.com>
 <20230505090558.2355-2-samin.guo@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230505090558.2355-2-samin.guo@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/2023 11:05, Samin Guo wrote:
> The motorcomm phy (YT8531) supports the ability to adjust the drive
> strength of the rx_clk/rx_data, the value range of pad driver
> strength is 0 to 7.
> 
> Signed-off-by: Samin Guo <samin.guo@starfivetech.com>
> ---
>  .../devicetree/bindings/net/motorcomm,yt8xxx.yaml    | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/motorcomm,yt8xxx.yaml b/Documentation/devicetree/bindings/net/motorcomm,yt8xxx.yaml
> index 157e3bbcaf6f..29a1997a1577 100644
> --- a/Documentation/devicetree/bindings/net/motorcomm,yt8xxx.yaml
> +++ b/Documentation/devicetree/bindings/net/motorcomm,yt8xxx.yaml
> @@ -52,6 +52,18 @@ properties:
>        for a timer.
>      type: boolean
>  
> +  motorcomm,rx-clk-driver-strength:
> +    description: drive strength of rx_clk pad.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
> +    default: 3

No improvements after Andrew's comment.

Best regards,
Krzysztof

