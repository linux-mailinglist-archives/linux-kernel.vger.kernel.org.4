Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9FC773BF56
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 22:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjFWUQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 16:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjFWUQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 16:16:50 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194132724;
        Fri, 23 Jun 2023 13:16:28 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-782c0777d51so33082039f.3;
        Fri, 23 Jun 2023 13:16:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687551387; x=1690143387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rg/P2zhgjAUIopl8t7yQhUsy858DpN4kyXTcUhN5dxQ=;
        b=EslYncKWkeQi4lCHtmxX9oky/oYE/pKRv1M7y9k0M5KQ2EqhnRaTLUR4dDcAuLI0Qh
         1U0iYhd15K584vyyka8XnBFMmq/90aU5ON9sFEwh/zSyyjD9R8vCXfzlvJHcf7OAipCg
         Pb05UG2eFCbQfh2cJU/S5kUt833/7/S095Yd6VO5A3ZUJEdANT/4+xjVm01iD7tIi+2J
         8HSIJQkKBQjWEHTK5eqwLhPPwBM5BnRh5fX8pI1N0QNhwm+VOht+H12TRZ+auWp3NPau
         H+HU7AvVMTcrJBHbvFUNJns61ItbtpYdAoqlx//FYfgx9aVPktNCVdcTPkNkkahtp7GK
         uF3g==
X-Gm-Message-State: AC+VfDw/EwlhKoSr4SCgYYrC66YT0oJqYeZTSeOSZioeJxiZPs83ZCFV
        ssCB2rSfdF6Ilm0ilPK75g==
X-Google-Smtp-Source: ACHHUZ4Fso4Lmt1qsSt17keZ134C/Kw4+TuhenK7iJdSx01fnSyGw3szdKNZIu5pgpbUZWCI2e5tDg==
X-Received: by 2002:a92:d691:0:b0:341:b14f:971c with SMTP id p17-20020a92d691000000b00341b14f971cmr19319993iln.27.1687551387267;
        Fri, 23 Jun 2023 13:16:27 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id d8-20020a92d788000000b0034233fd80d3sm48463iln.22.2023.06.23.13.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 13:16:26 -0700 (PDT)
Received: (nullmailer pid 1038150 invoked by uid 1000);
        Fri, 23 Jun 2023 20:16:24 -0000
Date:   Fri, 23 Jun 2023 14:16:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-crypto@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-amlogic@lists.infradead.org,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH v3] dt-bindings: crypto: drop unneeded quotes
Message-ID: <168755138352.1038014.15444309395419792467.robh@kernel.org>
References: <20230621064403.9221-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621064403.9221-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 21 Jun 2023 08:44:03 +0200, Krzysztof Kozlowski wrote:
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> ---
> 
> Changes in v3:
> 1. Adjust subject perfix (drop ixp4xx)
> 
> Changes in v2:
> 1. Drop more quotes (also amlogic)
> 2. Add Linus' tag
> ---
>  .../devicetree/bindings/crypto/amlogic,gxl-crypto.yaml      | 4 ++--
>  .../devicetree/bindings/crypto/intel,ixp4xx-crypto.yaml     | 6 +++---
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 

Applied, thanks!

