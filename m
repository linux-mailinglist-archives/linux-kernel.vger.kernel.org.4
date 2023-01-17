Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB6966E87F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 22:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjAQVex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 16:34:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjAQVbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 16:31:40 -0500
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0BB58999;
        Tue, 17 Jan 2023 11:57:25 -0800 (PST)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-12c8312131fso33200695fac.4;
        Tue, 17 Jan 2023 11:57:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WoQ1Ujnm/vZWONGjo7EJYTRd9zE4o9AG/5l154hNW+Y=;
        b=nxaZklT82ZHMQ5DyC+GUFan+usFVL7TEGBKGoACetZC9STI+05e7f49rPbkTd/OZY4
         1N6LRfSpBk7qfBjOCFd2L7xx3rRWA2B6WTsmxIKS07OnhSCRrEajyhP5DShvNc3Ui7UD
         fP/DxdABwUw+vvW2zfLGM+XktEvgRMkyLY+qiwMi7znCI2OnbqGIKVeubbtBy065GOh4
         ABPUFhdjMac0N2NynPNYNnWJgWmqd+efprqgj4SK5fdcU4unGggj83S3vjl9Pe5Hy46G
         5ZLrJKMykfaky6rTT2A6yV0DarIUflEuGWNQMMSJrlmXT16vEB+rvtY2D1iJ8T3cU2gS
         2KIQ==
X-Gm-Message-State: AFqh2kpnDNMFgkrD3ONsJOerTeRXO4QqOE68BEoxx3OUy5VcNRv11oFN
        /rUO/9d9aP6h0cVcQuzf4Q==
X-Google-Smtp-Source: AMrXdXsWU+wMIMJZJ0i92BSHODRi1mci32oCzZVAgx/IGlmoFNzIN6Vsk3DXaRLgbmBP86jPqZIr8w==
X-Received: by 2002:a05:6870:588c:b0:15f:6de0:b74 with SMTP id be12-20020a056870588c00b0015f6de00b74mr1595745oab.19.1673985444692;
        Tue, 17 Jan 2023 11:57:24 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q187-20020a4a4bc4000000b004a3c359fdaesm15462457ooa.30.2023.01.17.11.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 11:57:24 -0800 (PST)
Received: (nullmailer pid 3536600 invoked by uid 1000);
        Tue, 17 Jan 2023 19:57:23 -0000
Date:   Tue, 17 Jan 2023 13:57:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?Q?Micha=C5=82?= Grzelak <mchl.grzlk@gmail.com>
Cc:     linux-kernel@vger.kernel.org, lars@metafoo.de,
        Michael.Hennerich@analog.com, cosmin.tanislav@analog.com,
        jic23@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: addac: adi,74115: Add missing maxItems
Message-ID: <20230117195723.GA3527095-robh@kernel.org>
References: <20230115022558.145076-1-mchl.grzlk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230115022558.145076-1-mchl.grzlk@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 15, 2023 at 03:25:58AM +0100, Michał Grzelak wrote:
> Running 'make dt_binding_check' gives following warnings:
> iio/addac/adi,ad74115.example.dtb:
> addac@0: adi,conv2-range-microvolt: 'oneOf' conditional failed, one must
> be fixed:
>         4282967296 is not one of [-2500000, 0]
>         4282967296 is not one of [-12000000, 0]
>         -2500000 was expected
>         -104000 was expected
>         625000 was expected
> 
> addac@0: Unevaluated properties are not allowed
> ('adi,conv2-range-microvolt' was unexpected)
>         From schema: iio/addac/adi,ad74115.yaml

I think your dtschema version is out of date. I don't see this issue. 
The issue has to do with signed types and there have been some fixes 
related to them.

> As every property with standard suffix has inferred type of array of
> cells, adi,conv2-range-microvolt is required by meta-schemas/cell.yaml
> to have maxItems >= 2. Fix these errors by setting maxItems to 2.

The meta-schemas have nothing to do with warnings in examples. It's like 
this: meta-schemas check schemas check examples

> 
> Signed-off-by: Michał Grzelak <mchl.grzlk@gmail.com>
> ---
>  Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml b/Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml
> index 72d2e910f206..cdeb04184f5a 100644
> --- a/Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml
> +++ b/Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml
> @@ -87,6 +87,7 @@ properties:
>  
>    adi,conv2-range-microvolt:
>      description: Conversion range for ADC conversion 2.
> +    maxItems: 2
>      oneOf:
>        - items:
>            - enum: [-2500000, 0]
> -- 
> 2.37.3
> 
