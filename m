Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4C46986A9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 21:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjBOUzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 15:55:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbjBOUy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 15:54:57 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69163460B5;
        Wed, 15 Feb 2023 12:51:51 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id c15so16976987oic.8;
        Wed, 15 Feb 2023 12:51:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ga+t+f/0IwHyZHrwQgjPT2MoJkcZAMv05bM6ZtnYEzs=;
        b=6IkNy3Es7V+TjHkv91yZ9JTlewzVDcCDnqS6eJNWLp9BbE1Q4Ssvchf6u/OG5FCmEZ
         nhnLlby/mVdb8FbaSuGAQdDkg3bl+DVSsHBePfWjOEbZYJVdfpXYe1oKntGf4YF8sGfO
         GJK1kR2OilavmTILOwnRvS8Jq9KofnSA6MIzWVMXAgc6eJYIJDKj/98p3EyavQ5wcXRR
         mQl5A+2pYMEZLzT7gE+zenCxhcL/82RLgae79wiEY2sSVrM70tpcBR40yn4/WFdIL5Y7
         iCqe8323zJ4LPAn7F8vq2s6facleQZvJ51psuTncgNRykTqE+wnDs3SktJ0nK5N6Qsnf
         C8tg==
X-Gm-Message-State: AO0yUKXqu8hKO8r5YXu8J7M7+EFmrfgJsNCQbWso9GdRuNbvAznsCILr
        Q6N0nEffQi7zwP0eGEyItg==
X-Google-Smtp-Source: AK7set9uKEXlFY7OztCxYaBkIzSGW27WpnODYmXq+svIfX/4qXfn14oKqa9ODmPlqs1+efwrWqjZQA==
X-Received: by 2002:a54:4793:0:b0:378:79a4:867 with SMTP id o19-20020a544793000000b0037879a40867mr1521653oic.33.1676494173874;
        Wed, 15 Feb 2023 12:49:33 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h15-20020aca180f000000b0037dcb5323d6sm1557457oih.51.2023.02.15.12.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 12:49:33 -0800 (PST)
Received: (nullmailer pid 528815 invoked by uid 1000);
        Wed, 15 Feb 2023 20:49:32 -0000
Date:   Wed, 15 Feb 2023 14:49:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-media@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v2 3/7] media: dt-bindings: samsung,exynos4210-csis:
 convert to dtschema
Message-ID: <167649417223.528776.7556862250752901936.robh@kernel.org>
References: <20230214104508.51955-1-krzysztof.kozlowski@linaro.org>
 <20230214104508.51955-4-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214104508.51955-4-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 14 Feb 2023 11:45:04 +0100, Krzysztof Kozlowski wrote:
> Convert the Samsung S5P/Exynos SoC series MIPI CSI-2 receiver (MIPI
> CSIS) bindings to DT schema.  Changes during conversion - adjust to
> existing DTS and Linux driver:
> 1. Add phys and power-domains.
> 2. Move samsung,csis-wclk property to the endpoint node.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../media/samsung,exynos4210-csis.yaml        | 170 ++++++++++++++++++
>  .../bindings/media/samsung-mipi-csis.txt      |  81 ---------
>  MAINTAINERS                                   |   1 +
>  3 files changed, 171 insertions(+), 81 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/media/samsung,exynos4210-csis.yaml
>  delete mode 100644 Documentation/devicetree/bindings/media/samsung-mipi-csis.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>

