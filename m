Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E64F646828
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 05:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiLHEQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 23:16:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiLHEQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 23:16:22 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218632B249
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 20:16:21 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id g10so365293plo.11
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 20:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vr4Iu5BVbe01s1rT8smT36x+TYWRbPQICEznB+Ae7Q8=;
        b=yBvhrWL+A/kCBVS4MGy/NjwrpHIMPZurfmIzsx4neakG3t+cCfME3n8wajiL58P/dg
         5myFyO+w21AjPpL4V0vTGsaWblNF97osEbvgCBLoOHGts4G31mWPAZkOWp86o2dvWXtx
         vCfVI9SPvAE7EF/e4RC1hs8pNXF6V+FcupNqwZjS0+3zsdd9w8cNgb0KgLJgaSM024/L
         gospE35XY3gSe1nEW5mN3LYPXkqhiVB00ymiMfsyPRm3ESy6htE09X2ByY21Ea+VQWqi
         PVAUJX+VIu9zGHyN5KIWtUqymV1OdyNqHv3i1N+KSj1pwoxp6hJS+LG2rNZSBO35rFqi
         M5mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vr4Iu5BVbe01s1rT8smT36x+TYWRbPQICEznB+Ae7Q8=;
        b=JrqIzlSNBf14ewlujliayZm3thGxqc3tNJqjKjHHS7PXXqznGiDLw2i+8GJTiwycuL
         caGysKtNpQYAVw5CYy9CBiOkoU7HI/Gr6Hjf8bQtT6f0LkQIwHHJ99gUQ/eZ5dzJEozw
         3iIAPxRECA7J2zYjeHtcSnLh91YSq2H8ti63xoKeV3EQKMI3umHT3iUSp2eleTTANZSd
         OQAVYeA+rZtSsrDmH9LJeDgo3XbGP5IQ+8Na8QfEjXW0YxIpJKfy1nyxVnBviGWcxpU5
         nSeRuqc/dAFH5SDSPOCBpsdzHApVaksf9YakAELRB2Q1DMmZpR8aOjNckpnfR1J9226T
         4jww==
X-Gm-Message-State: ANoB5pnpb9wRS2NIwB+cKLxpzN06tNk61WvlddIMCd38R8yFS7qTjNH1
        9sj7LWloYaPoLtAo1OQeq9D+9Q==
X-Google-Smtp-Source: AA0mqf4njlA4WTgWF83snVkrtQ9N1QP7elEJdN3JpX/G4HiuA7X9rnolD38Li/2QJmaAM777LvIJgA==
X-Received: by 2002:a17:903:452:b0:189:6574:7ac1 with SMTP id iw18-20020a170903045200b0018965747ac1mr61287388plb.47.1670472980638;
        Wed, 07 Dec 2022 20:16:20 -0800 (PST)
Received: from localhost ([122.172.87.149])
        by smtp.gmail.com with ESMTPSA id mr4-20020a17090b238400b002193f87fb4asm314384pjb.4.2022.12.07.20.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 20:16:19 -0800 (PST)
Date:   Thu, 8 Dec 2022 09:46:14 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Ilia Lin <ilia.lin@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: opp: opp-v2-kryo-cpu: Add missing
 'cache-unified' property in example
Message-ID: <20221208041614.zpg5skdixia2mduj@vireshk-i7>
References: <20221206014343.3117101-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206014343.3117101-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-12-22, 19:43, Rob Herring wrote:
> The examples' cache nodes are incomplete as 'cache-unified' is a
> required cache property for unified caches which an L2 cache certainly
> is.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
> index a202b6c6561d..27412c2cfc0f 100644
> --- a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
> +++ b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
> @@ -106,6 +106,7 @@ examples:
>                  L2_0: l2-cache {
>                      compatible = "cache";
>                      cache-level = <2>;
> +                    cache-unified;
>                  };
>              };
>  
> @@ -140,6 +141,7 @@ examples:
>                  L2_1: l2-cache {
>                      compatible = "cache";
>                      cache-level = <2>;
> +                    cache-unified;
>                  };
>              };
>  

Applied. Thanks.

-- 
viresh
