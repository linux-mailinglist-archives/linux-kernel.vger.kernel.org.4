Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7718A6489E5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 22:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiLIVKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 16:10:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiLIVKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 16:10:06 -0500
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1662CB3D9B;
        Fri,  9 Dec 2022 13:10:06 -0800 (PST)
Received: by mail-oi1-f179.google.com with SMTP id e205so5636243oif.11;
        Fri, 09 Dec 2022 13:10:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CCAwPwnZELHbdthNoIZf6xlVOvb+QmWPg86KZ64WyBA=;
        b=K6ylmouXjHflaQ89UZkMu+cMSUxfmbrx4vaX+sgLUkY7mJ73XLIXvdnQyKvUZgq/D5
         UUdSs/iThnqK1zK2cAiaXb1TWwImqjTcaix8XQj6tA+aEU49LA19TW1vWrM+dDVlvn9V
         +5ni0TagF0xB4+K0ZqR80rhwAqgpfSMsE4WW3Mx14OsXm9RECfTHNETATKdb0aptiHZX
         VJ4yVSWpQmz2MqqIx17xyZhm3wVNh7NBGxNzU55sY9GMrHQ64l6LKk4zWStM5reXnVm9
         I8MhBdRjTo6E4nTV5hbMTZBqmr+kOOpRFqL4g/8RyNAOSHTJDTEPrjGXXmZCgir0ocwE
         N2kg==
X-Gm-Message-State: ANoB5pkGmRwY1aSRFceQXwSXkPYGMwGPMcBc3F028lIZSbE2ksj9rIsJ
        MgRLa582zLIy5pJwoAYmBmCptUYsLQ==
X-Google-Smtp-Source: AA0mqf7EJ2BkImAGMqL2fHbvECzZRcLlDPZydh9SbWQYW5YWbXz2ebFm0U3iTZqqhx7XP5FnICfatQ==
X-Received: by 2002:a05:6808:308f:b0:35a:1439:6880 with SMTP id bl15-20020a056808308f00b0035a14396880mr4381453oib.46.1670620205368;
        Fri, 09 Dec 2022 13:10:05 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j11-20020a4ac54b000000b0049f5ce88583sm800919ooq.7.2022.12.09.13.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 13:10:04 -0800 (PST)
Received: (nullmailer pid 3851768 invoked by uid 1000);
        Fri, 09 Dec 2022 21:10:04 -0000
Date:   Fri, 9 Dec 2022 15:10:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sriranjani P <sriranjani.p@samsung.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        alim.akhtar@samsung.com, pankaj.dubey@samsung.com,
        ravi.patel@samsung.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: soc: samsung: exynos-sysreg: add
 dedicated SYSREG compatibles to Exynos850
Message-ID: <20221209211004.GA3847427-robh@kernel.org>
References: <20221207105032.103510-1-sriranjani.p@samsung.com>
 <CGME20221207105043epcas5p306086213835a5287f39de9016dcd43d2@epcas5p3.samsung.com>
 <20221207105032.103510-2-sriranjani.p@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207105032.103510-2-sriranjani.p@samsung.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2022 at 04:20:29PM +0530, Sriranjani P wrote:
> Exynos850 has two different SYSREGs, hence add dedicated compatibles for
> them and deprecate usage of generic Exynos850 compatible alone.
> 
> Signed-off-by: Sriranjani P <sriranjani.p@samsung.com>
> ---
>  .../soc/samsung/samsung,exynos-sysreg.yaml        | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
> index 4954790eda6c..a37452965100 100644
> --- a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
> +++ b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
> @@ -17,7 +17,6 @@ properties:
>                - samsung,exynos3-sysreg
>                - samsung,exynos4-sysreg
>                - samsung,exynos5-sysreg
> -              - samsung,exynos850-sysreg
>                - samsung,exynosautov9-sysreg
>                - tesla,fsd-cam-sysreg
>                - tesla,fsd-fsys0-sysreg
> @@ -33,9 +32,17 @@ properties:
>            - const: samsung,exynos5433-sysreg
>            - const: syscon
>        - items:
> -          - const: samsung,exynos5433-sysreg
> +          - enum:
> +              - const: samsung,exynos5433-sysreg

This says the compatible entry is "const: samsung,exynos5433-sysreg".

That should be a schema warning. You did test this, right?

Rob
