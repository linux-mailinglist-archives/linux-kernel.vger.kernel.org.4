Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB2F63E2C5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 22:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiK3VbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 16:31:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiK3VbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 16:31:00 -0500
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9CA900D6;
        Wed, 30 Nov 2022 13:30:59 -0800 (PST)
Received: by mail-ot1-f48.google.com with SMTP id p8-20020a056830130800b0066bb73cf3bcso12080180otq.11;
        Wed, 30 Nov 2022 13:30:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mc6V9+sDoG9Mki15v8P5KKA7NfsAq4SE0l5Qimb/jYw=;
        b=Hr6Tyebvi7CjgUcUnY3TaOuf8HGIPSMODvO5A9+JZxg/S1iCQGQVbwJ8WmvSomjrCm
         uEFFpAhL796uM9L1JxGyyaPCuJ0cwuH4aoNLdF4OPJdFEoCjGLMIp9P5KR8RDjk6r47P
         6lZvcR2F2chuN5cKaUo9QH0gt/wLQ97VqkTX4CUBRAGm9fJwcy7MWHuYYIKVxbkN6T4y
         bVZ+5LZrHnNmf/4pbfcx5DgNndifq+cAIuxSn/GeZ3i57UfnLYTQYiYeZ1zCl46iZroy
         /pBO55ifq3P184+OSiQyH75eiOGuI8OyOghGceLq55tPGyKI1aZn15dg6J1py1+c4GKL
         o4Ng==
X-Gm-Message-State: ANoB5pnGKRk8w8vXwMWJwn5yUF6GwtCF5c4HNXDWAQu87IM8T3cjxpTo
        vYNX3h3bNgLsMMvwXzz47g==
X-Google-Smtp-Source: AA0mqf4vUPSR7ovZbOCRKRqMQN2EeuGVgLzCTx74Sseob1+HjZJNxvL9pC0HARrpgxgB7hYUbhdb3Q==
X-Received: by 2002:a05:6830:1688:b0:66c:42d7:7d70 with SMTP id k8-20020a056830168800b0066c42d77d70mr21118469otr.98.1669843858446;
        Wed, 30 Nov 2022 13:30:58 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u9-20020a056870f28900b0011bde9f5745sm1781162oap.23.2022.11.30.13.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 13:30:57 -0800 (PST)
Received: (nullmailer pid 2960995 invoked by uid 1000);
        Wed, 30 Nov 2022 21:30:57 -0000
Date:   Wed, 30 Nov 2022 15:30:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Neal Liu <neal_liu@aspeedtech.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "Chia-Wei Wang --cc=linux-kernel @ vger . kernel . org" 
        <chiawei_wang@aspeedtech.com>, linux-crypto@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] dt-bindings: bus: add documentation for Aspeed
 AHBC
Message-ID: <20221130213057.GA2960216-robh@kernel.org>
References: <20221124105552.1006549-1-neal_liu@aspeedtech.com>
 <20221124105552.1006549-5-neal_liu@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221124105552.1006549-5-neal_liu@aspeedtech.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 06:55:52PM +0800, Neal Liu wrote:
> Add device tree binding documentation for the Aspeed
> Advanced High-Performance Bus (AHB) Controller.
> 
> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> ---
>  .../bindings/bus/aspeed,ast2600-ahbc.yaml     | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/bus/aspeed,ast2600-ahbc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/bus/aspeed,ast2600-ahbc.yaml b/Documentation/devicetree/bindings/bus/aspeed,ast2600-ahbc.yaml
> new file mode 100644
> index 000000000000..cf9740f2a0c7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/bus/aspeed,ast2600-ahbc.yaml
> @@ -0,0 +1,37 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bus/aspeed,ast2600-ahbc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ASPEED Advanced High-Performance Bus Controller (AHBC) Device Tree Bindings

Drop " Device Tree Bindings"

With that,

Reviewed-by: Rob Herring <robh@kernel.org>
