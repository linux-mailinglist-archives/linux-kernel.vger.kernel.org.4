Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3DA4661833
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 19:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236129AbjAHSeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 13:34:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjAHSdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 13:33:55 -0500
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CE41005;
        Sun,  8 Jan 2023 10:33:54 -0800 (PST)
Received: by mail-il1-f175.google.com with SMTP id u8so3833295ilq.13;
        Sun, 08 Jan 2023 10:33:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AnLn590CxObCPHVpqzU2YKM6yS2U3fQhJcXnp9MuaEg=;
        b=yh0nj16rq21xVLIhyzGh4KV0gPtbKpkAGH7DHxNUGZo7FzxlgpNUsApBYVqqTbu8FF
         nfZam41n0JqkQCdNexu5+SVKPvtGvIXvtFuinSm1EILeA/zIgbHgEdPDmG/WxTKgX3wg
         94bHOa8aR6yphsYfWhtjS8u8xQn/frj9W2TMXTrgoP2x8U5Y2ATwj+cmNzgw4Um54Ta1
         U9huDZ9k1ytH5SIBX3wdnE1ANuBbPco3jt3WIrdfqGHwS8RgavK28Pt3eAs6JqKmquuJ
         iy99dy//Ucw9VHu5v1RoAgohQ2hvtge4Tn3RRGTEaxsq80IyV5xsW2ZYk19ERJbBjyfj
         i6ZQ==
X-Gm-Message-State: AFqh2kqTibbDQWCtndaUjn3yuxvPh1lci6r+q7bRhMYOcUben7e0s8Xb
        oWQ3GoeCt/9160Bc8salcg==
X-Google-Smtp-Source: AMrXdXsyQQy9O9q6deLP1/nsKTazK9kzf6iytk5IS8CbSyS/PIHCy5h3pO4pbod2IM6YsQCWfPmI7w==
X-Received: by 2002:a05:6e02:525:b0:30c:2bb4:a2ea with SMTP id h5-20020a056e02052500b0030c2bb4a2eamr22671802ils.13.1673202833579;
        Sun, 08 Jan 2023 10:33:53 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:8069:516a:f2b0:691e:4315:7c0f])
        by smtp.gmail.com with ESMTPSA id y21-20020a027315000000b00389cb050d1bsm2099433jab.33.2023.01.08.10.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 10:33:53 -0800 (PST)
Received: (nullmailer pid 180457 invoked by uid 1000);
        Sun, 08 Jan 2023 18:33:50 -0000
Date:   Sun, 8 Jan 2023 12:33:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Lionel Debieve <lionel.debieve@foss.st.com>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] dt-bindings: crypto: Let STM32 define Ux500 HASH
Message-ID: <20230108183350.GA177741-robh@kernel.org>
References: <20221227-ux500-stm32-hash-v1-0-b637ac4cda01@linaro.org>
 <20221227-ux500-stm32-hash-v1-1-b637ac4cda01@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221227-ux500-stm32-hash-v1-1-b637ac4cda01@linaro.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2022 at 12:03:33AM +0100, Linus Walleij wrote:
> This adds device tree bindings for the Ux500 HASH block
> as a compatible in the STM32 HASH bindings.
> 
> The Ux500 HASH binding has been used for ages in the kernel
> device tree for Ux500 but was never documented, so fill in
> the gap by making it a sibling of the STM32 HASH block,
> which is what it is.
> 
> The relationship to the existing STM32 HASH block is pretty
> obvious when looking at the register map, and I have written
> patches to reuse the STM32 HASH driver on the Ux500.
> 
> The main difference from the outside is that the Ux500 HASH
> lacks the interrupt line, so some special if-clauses are
> needed to accomodate this in the binding.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../devicetree/bindings/crypto/st,stm32-hash.yaml  | 30 +++++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/crypto/st,stm32-hash.yaml b/Documentation/devicetree/bindings/crypto/st,stm32-hash.yaml
> index 4ccb335e8063..681812e1c941 100644
> --- a/Documentation/devicetree/bindings/crypto/st,stm32-hash.yaml
> +++ b/Documentation/devicetree/bindings/crypto/st,stm32-hash.yaml
> @@ -6,12 +6,18 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
>  title: STMicroelectronics STM32 HASH
>  
> +description: The STM32 HASH block is built on the HASH block found in
> +  the STn8820 SoC introduced in 2007, and subsequently used in the U8500
> +  SoC in 2010.
> +
>  maintainers:
>    - Lionel Debieve <lionel.debieve@foss.st.com>
>  
>  properties:
>    compatible:
>      enum:
> +      - st,stn8820-hash
> +      - stericsson,ux500-hash
>        - st,stm32f456-hash
>        - st,stm32f756-hash
>  
> @@ -41,11 +47,33 @@ properties:
>      maximum: 2
>      default: 0
>  
> +  power-domains:
> +    maxItems: 1
> +
>  required:
>    - compatible
>    - reg
>    - clocks
> -  - interrupts
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          items:
> +            const: stericsson,ux500-hash
> +    then:
> +      properties:
> +        interrupts: false
> +
> +  - if:
> +      not:
> +        properties:
> +          compatible:
> +            items:
> +              const: stericsson,ux500-hash

Why not use 'else' instead?

> +    then:
> +      required:
> +        - interrupts
>  
>  additionalProperties: false
>  
> 
> -- 
> 2.38.1
> 
