Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9C66B165F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 00:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjCHXPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 18:15:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjCHXPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 18:15:50 -0500
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A5DEB41;
        Wed,  8 Mar 2023 15:15:49 -0800 (PST)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1763e201bb4so526288fac.1;
        Wed, 08 Mar 2023 15:15:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678317348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AYN1mGvw+BesOGmjKnVjW5qaCYL2NLcUZN6bNj4hymY=;
        b=KMT6qYf9SBJo9WH7FJ5k1kEKKuqGElq071qllOw3C7++00glR50BuZBmuVzgWP9ybS
         ncE94x3dpOq8WqpoltM52kJd3PyPnZT+6vHgkOelD0f94FurXmWgQvbdsx/s5wte8RI2
         98d+EYT3Obv9U/bosmsr5cH3Gr9iF2iuW7a0WVwDowtJFBvHyRYdBFZfn7GiQB7WuP/t
         OUHnZ6RBeSg6h/5zRCtiBcR19QcdYkabnLxFBT0S0a189ylx2r+ifaLOxjqJbGRkwjxX
         IB64REMfqTmjaGY3JBKUmnh6GLKcjgksa+ua92L4Ih3bNWCCdIHapY9v8UHIcPio0SzA
         GR3A==
X-Gm-Message-State: AO0yUKUETJTNaQDevi2sa/knreGULJi3Zovx9EBl1Zx4Xf95XCEDMnBF
        cFst0VkxR4xGvnIUuf34cw==
X-Google-Smtp-Source: AK7set+3Y1yRqQD4GNMNIxwBax8DMgnGF3zYCmHgGncdqoy23QFMf9depa6oFnXU7lhmUYbk+ssRow==
X-Received: by 2002:a05:6870:a118:b0:172:4d60:d4ef with SMTP id m24-20020a056870a11800b001724d60d4efmr12164922oae.14.1678317348534;
        Wed, 08 Mar 2023 15:15:48 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id zq41-20020a0568718ea900b0017703cd8ff6sm2080703oab.7.2023.03.08.15.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 15:15:48 -0800 (PST)
Received: (nullmailer pid 4055139 invoked by uid 1000);
        Wed, 08 Mar 2023 23:15:47 -0000
Date:   Wed, 8 Mar 2023 17:15:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Janne Grunau <j@jannau.net>
Cc:     asahi@lists.linux.dev, devicetree@vger.kernel.org,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Sven Peter <sven@svenpeter.dev>, Marc Zyngier <maz@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Mark Kettenis <kettenis@openbsd.org>,
        linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH v3 05/15] dt-bindings: interrupt-controller: apple,aic2:
 Add apple,t8112-aic compatible
Message-ID: <167831734698.4055079.137179018203660288.robh@kernel.org>
References: <20230202-asahi-t8112-dt-v3-0-d1a5f6383d95@jannau.net>
 <20230202-asahi-t8112-dt-v3-5-d1a5f6383d95@jannau.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202-asahi-t8112-dt-v3-5-d1a5f6383d95@jannau.net>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 07 Mar 2023 13:10:11 +0100, Janne Grunau wrote:
> The Apple M2 SoC uses AICv2 and is compatible with the existing driver.
> Add its per-SoC compatible.
> Since multi-die versions of the M2 are not expected decrease
> '#interrupt-cells' to 3 for apple,t8112-aic. This is seamlessly handled
> inside the driver.
> 
> Acked-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>  .../bindings/interrupt-controller/apple,aic2.yaml  | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

