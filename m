Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C15B5BB2D2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 21:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbiIPTcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 15:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiIPTb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 15:31:59 -0400
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47FAA5F10A;
        Fri, 16 Sep 2022 12:31:57 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-12c8312131fso3341622fac.4;
        Fri, 16 Sep 2022 12:31:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Z3Sthnj1FcNAMBSXALUfkD26U2zHJqvId9wxHnJlzmY=;
        b=3b0i18ONW3pGFCtwvTqwk6BEKKPjHiLt0wMiG8UgZCJau7EWkv5jws442mxSDSoKYm
         GVTBYmZq6HkgQqG7CIDe0n05aMSgxHCeGk+5neWMeJPDxH7f9LidkG0BrvlvgYl9Vpq8
         9Gd56JjB1wiuNOriITtBtK4UStHWeM07vkgR7Y1rn/VrNeintHbQguA/pbqqvR6kkHNQ
         hv+NPQ+huCGmGNYRPAyTJKn9FevIiF2MDVE3c/zekYOyEaUkWhHRKHhqypBpj0OJln3e
         QgetrI8j8fgOdVRbHFAQSXBviiA06KXSsYtfsBjwD2xk40XsRme15NiLSvq1W+pskOVZ
         ug2Q==
X-Gm-Message-State: ACrzQf0apnDtdtrA6248pDACT0saOKxSqtxuykNFL3UCTlwLZN9+R0z/
        L4kJIbPRCHabjWcfQFI42g==
X-Google-Smtp-Source: AMsMyM5Rud+4rF6YtBDwMIg8bCMYOKWqbQQPT5V67M6vLmxAkZc0l4fY485Hix4y6qmiYT/d/aVVKg==
X-Received: by 2002:a05:6870:e997:b0:10c:6f42:b05e with SMTP id r23-20020a056870e99700b0010c6f42b05emr3602742oao.89.1663356716571;
        Fri, 16 Sep 2022 12:31:56 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f92-20020a9d2c65000000b00655bc32a413sm10481673otb.42.2022.09.16.12.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 12:31:55 -0700 (PDT)
Received: (nullmailer pid 1133996 invoked by uid 1000);
        Fri, 16 Sep 2022 19:31:55 -0000
Date:   Fri, 16 Sep 2022 14:31:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Julius Werner <jwerner@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>, devicetree@vger.kernel.org,
        Jian-Jia Su <jjsu@google.com>,
        Doug Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 3/4 v4] dt-bindings: memory: Add jedec,lpddr4 and
 jedec,lpddr5 bindings
Message-ID: <20220916193155.GA1133958-robh@kernel.org>
References: <20220915003222.1296421-1-jwerner@chromium.org>
 <20220915003222.1296421-3-jwerner@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220915003222.1296421-3-jwerner@chromium.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Sep 2022 17:32:21 -0700, Julius Werner wrote:
> This patch adds bindings for LPDDR4 and LPDDR5 memory analogous to the
> existing bindings for LPDDR2 and LPDDR3. For now, the new types are only
> needed for topology description, so other properties like timing
> parameters are omitted. They can be added later if needed.
> 
> Signed-off-by: Julius Werner <jwerner@chromium.org>
> ---
>  .../ddr/jedec,lpddr-props.yaml                |  4 ++
>  .../memory-controllers/ddr/jedec,lpddr4.yaml  | 35 ++++++++++++++
>  .../memory-controllers/ddr/jedec,lpddr5.yaml  | 46 +++++++++++++++++++
>  3 files changed, 85 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr4.yaml
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr5.yaml
> 
> Changelog:
> 
> - v2
>   - removed minItems
>   - moved `$ref` below `maintainers`
>   - renamed example node from `lpddr4` to `lpddr`
> - v3
>   - removed manufacturer-id property from examples
> - v4
>   - removed quotes from schema $ref strings
> 

Reviewed-by: Rob Herring <robh@kernel.org>
