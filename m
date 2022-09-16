Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6C95BB246
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 20:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbiIPSjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 14:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiIPSjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 14:39:20 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3F0B777D;
        Fri, 16 Sep 2022 11:39:19 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-127dca21a7dso53285693fac.12;
        Fri, 16 Sep 2022 11:39:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=LloOAAh3fMnP4loPWLwVdN2fBYfkgLtJ0iyYP475p/A=;
        b=kblzHY3iywxTM/a3KfzXHjHcGSX+w6ywCJjqnpGySEKxfmzqgW6pcfJteKMg+ne4qt
         8KcDFi1l8Ws9HH8LT1/X78ciOKMZzGy+cBh+i1rRpxj2vKoxZdzoYTNwKpGMGSw/j16d
         0C/DmSxhbSmKKVSCejcF8Cm8aLYnWVoZXot3AZ8CU1HBHoVwyLq0TUYNg636XqkZpwHX
         UF75cC+WnTftAs4sd3MLzssBK+T6eOMzlIUA555IP8rLcYHaAThNS7I9DGdDO7G1TJIC
         yI0dOd7/4LLTda92EvEnp1oRoPJIPmpXa1cVUNfCV5AbYymLNHTR5AF2ZOFnzif8ibax
         8T4g==
X-Gm-Message-State: ACgBeo3uOrwBndKOuq4Fv/LtclK6c+AXx7xPD48aJzJw9nRvWIN7W3GV
        /4Br3d55/Qf1yBFP+95Tdg==
X-Google-Smtp-Source: AA6agR4rJd3UZwBNHhnMn8U25gn7La8l8lm2O3ldIEUl+kA3gcHdpA10nwvFJdyB9SsWmen12iN1vg==
X-Received: by 2002:a05:6870:2191:b0:126:729a:b1d0 with SMTP id l17-20020a056870219100b00126729ab1d0mr8892314oae.131.1663353558579;
        Fri, 16 Sep 2022 11:39:18 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r11-20020a056871088b00b0012752d3212fsm3218681oaq.53.2022.09.16.11.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 11:39:18 -0700 (PDT)
Received: (nullmailer pid 1044162 invoked by uid 1000);
        Fri, 16 Sep 2022 18:39:17 -0000
Date:   Fri, 16 Sep 2022 13:39:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Janne Grunau <j@jannau.net>
Cc:     devicetree@vger.kernel.org,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        asahi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Hector Martin <marcan@marcan.st>,
        linux-arm-kernel@lists.infradead.org,
        Mark Kettenis <kettenis@openbsd.org>,
        Sven Peter <sven@svenpeter.dev>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v1 03/10] dt-bindings: arm: apple: Add t6001/t6002 Mac
 Studio compatibles
Message-ID: <20220916183917.GA1044129-robh@kernel.org>
References: <20220916142550.269905-1-j@jannau.net>
 <20220916142550.269905-4-j@jannau.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220916142550.269905-4-j@jannau.net>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Sep 2022 16:25:43 +0200, Janne Grunau wrote:
> This adds the following apple,t6001 platform:
> 
> - apple,j375c - Mac Studio (M1 Max, 2022)
> 
> And the initial apple,t6002 platform:
> 
> - apple,j375d - Mac Studio (M1 Ultra, 2022)
> 
> Signed-off-by: Janne Grunau <j@jannau.net>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes in v1:
>  - added blank lines between SoC entires
>  - added Krzysztof's ack
> 
>  Documentation/devicetree/bindings/arm/apple.yaml | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
