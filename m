Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E9B5FF50C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 23:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiJNVKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 17:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiJNVKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 17:10:36 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB75F124223;
        Fri, 14 Oct 2022 14:10:34 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id w196so6342202oiw.8;
        Fri, 14 Oct 2022 14:10:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xM+4m5a2a5cuZ5VhUjxrp5HzYAY1IJVbywUtama6FlI=;
        b=r9QR4ZGzO398Ly+owwsHgWN0FyRZ94twmXXBwlbXQEbaTUTx6TfDegQzVkC2Z7fVVg
         rkqEACu8C8LklI21LCt4V+uXzLwqrcurVMZYL3/24dcbTzxI8E728a7gZs488NQLPPn1
         1Y0c+4qs1F87FGRiOH1Fl3YiyBOAMxQLVaR0J5b3ZE6hAyJCscI9BECiXdRR0UAlZ9aN
         dVQVcrGb1zgQtYkPaiRD+PMKclnl1cWhx4yvOvAzH6BfNW0GcOvDlWTfZg+G5LXN5MGY
         vyOWUSeSNvOh6Tv3HenX9DTIaTNuNopvUrtHT9Wj7RzJaDdk9nDkRT0X9ufm71IrNOoR
         4KSg==
X-Gm-Message-State: ACrzQf3MHdPgpPFLPFKOqgPrGlfNG6pc+zbH6mZXxMa/Bf9PVS06gQSx
        cJwu2veDzgndJoHwgQ0f9A==
X-Google-Smtp-Source: AMsMyM70Akl6mGH6k+1/khm5MR7s9COqT/1+UPtLcqb+A+ugOm6M9TWM9XzVXoggbzWtk1ZXP1Lwpg==
X-Received: by 2002:a05:6808:1b0d:b0:355:219c:3d28 with SMTP id bx13-20020a0568081b0d00b00355219c3d28mr1571823oib.31.1665781833942;
        Fri, 14 Oct 2022 14:10:33 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 23-20020aca0f17000000b00354d7c7e42esm1549201oip.30.2022.10.14.14.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 14:10:33 -0700 (PDT)
Received: (nullmailer pid 2911731 invoked by uid 1000);
        Fri, 14 Oct 2022 21:10:34 -0000
Date:   Fri, 14 Oct 2022 16:10:34 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Markuss Broks <markuss.broks@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Dillon Min <dillon.minfei@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Daniel Mack <daniel@zonque.org>, devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] dt-bindings: display: panel: use
 spi-peripheral-props.yaml
Message-ID: <166578183285.2911660.11950210372738963572.robh@kernel.org>
References: <20221004120907.72767-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221004120907.72767-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Oct 2022 14:09:07 +0200, Krzysztof Kozlowski wrote:
> For devices connectable by SPI bus (e.g. already using
> "spi-max-frequency" property), reference the "spi-peripheral-props.yaml"
> schema to allow using all SPI device properties, even these which device
> bindings author did not tried yet.
> 
> Change "additionalProperties" to "unevaluatedProperties", so the actual
> other properties from "spi-peripheral-props.yaml" can be used.  This has
> additional impact of allowing also other properties from
> panel-common.yaml to be used.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/display/panel/ilitek,ili9163.yaml    | 3 ++-
>  .../devicetree/bindings/display/panel/ilitek,ili9341.yaml    | 1 +
>  .../devicetree/bindings/display/panel/nec,nl8048hl11.yaml    | 3 ++-
>  .../bindings/display/panel/samsung,lms380kf01.yaml           | 5 ++---
>  .../bindings/display/panel/samsung,lms397kf04.yaml           | 3 ++-
>  .../devicetree/bindings/display/panel/samsung,s6d27a1.yaml   | 4 ++--
>  .../devicetree/bindings/display/panel/tpo,tpg110.yaml        | 1 +
>  7 files changed, 12 insertions(+), 8 deletions(-)
> 

Applied, thanks!
