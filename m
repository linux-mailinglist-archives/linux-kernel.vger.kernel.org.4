Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F8B720F36
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 12:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjFCK2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 06:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjFCK2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 06:28:04 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD081F5
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 03:28:02 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5149429c944so4451749a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 03 Jun 2023 03:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685788081; x=1688380081;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uTfEVykiA9a5JMQx/MTE8KQh4y/HxIlvoyXh87G4vjw=;
        b=Z4y1JuOWcHNdxfvqtVWQZHxCoTdO3tNgb/nPan405XHw1I4shPgErmHHeyEMRelp5g
         p+omMXFPMaDTQJPUzPoi9tjsiXJVX4kolQ7DcvwcxGPBcKm62ZroQJn63A1AAR02lnvk
         rQXAm3HKrzLLKdXNm1KLw1n5luvjxv1IStkLdXejvWUPkAnT7kxwbl5CEg1V04zg2Ly2
         6HNRc2MkHh+JGki8bmL7DAmGdXmgfuHOmTZpYaDohlYTLpq5OGWf0tN1bCKMWFJKXuKO
         Co7L0JQMHcLZfB99T9MztmbfqGDp49Yp7oGV/2E9GLWySVO7eIDnpwaFJzom/R5OCBHd
         lKEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685788081; x=1688380081;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uTfEVykiA9a5JMQx/MTE8KQh4y/HxIlvoyXh87G4vjw=;
        b=cH0FnmODSzJkp218CPLOqzYo4/Wer+54YpNBe9LDDi0tSCKpxsj/UOLOof0OhLunSx
         MBn7aISJeiK40ui3e6ku3ng21zlNAcg3P9ikAQP+CLIOXKyinEhB0IzC20BDwMyTb1UV
         Q7gdSB14mqe3XSTGKzWXS+LlswuvLlEzZ+Dk5ukxDMhfT41ftthFIqCMxtIFUwZO6+aU
         odypDcrKn9YptTorWceq9Ld4VOKerJFg7zg3c4UXXyqOz+2Rh9o6q1voWalOWcbIXk3K
         TfFDeIOUIiC+dHtVPaWP8Hyqkv1XaP3x8TnA34TrHtBeX9e/IQwwp1f+sOXnuSlqqRpb
         Rvew==
X-Gm-Message-State: AC+VfDy4m+XvXdwnlnoEVglodkhy8Hb57v5L+jb1j8d1wKuGwVEg2JjT
        +Bwgh506oHOLoQopQ+SI9TXV0Q==
X-Google-Smtp-Source: ACHHUZ5nm1DquVUVP7bIFxKfwWMjSOcM1pZkWya1hPAuODm5Dy6DGX133tCXVsEMhIwlRoMBcMvXJg==
X-Received: by 2002:a17:906:3047:b0:974:9b83:7523 with SMTP id d7-20020a170906304700b009749b837523mr1048655ejd.76.1685788081137;
        Sat, 03 Jun 2023 03:28:01 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id y11-20020a170906070b00b00974c32c9a75sm1556369ejb.216.2023.06.03.03.27.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Jun 2023 03:28:00 -0700 (PDT)
Message-ID: <d98c54c9-22e0-c2c3-5ad0-0baf7f51c438@linaro.org>
Date:   Sat, 3 Jun 2023 12:27:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 2/3] dt-bindings: net: phy: Document support for
 external PHY clk
Content-Language: en-US
To:     Detlev Casanova <detlev.casanova@collabora.com>,
        linux-kernel@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>,
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
References: <20230602182659.307876-1-detlev.casanova@collabora.com>
 <20230602182659.307876-3-detlev.casanova@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230602182659.307876-3-detlev.casanova@collabora.com>
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

On 02/06/2023 20:26, Detlev Casanova wrote:
> Ethern PHYs can have external an clock that needs to be activated before
> probing the PHY.
> 
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> ---
>  Documentation/devicetree/bindings/net/ethernet-phy.yaml | 6 ++++++

With fixes from Andrew:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

