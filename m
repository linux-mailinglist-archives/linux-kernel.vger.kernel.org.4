Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1DA16983CC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 19:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjBOSvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 13:51:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjBOSvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 13:51:40 -0500
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9AFA1B9;
        Wed, 15 Feb 2023 10:51:39 -0800 (PST)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-16ab8581837so23992490fac.4;
        Wed, 15 Feb 2023 10:51:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FLIZ5hcN5GGXLtl+sjC37d6A4RUM2sKRYboYgXB5JVE=;
        b=WS29CYl7NzTFqVIsDLWAsMf0i0nePjQYyEg30joOI9pCvNZWcGt1m6++x7iMTK08S9
         VmHvLNzuQG93ZmqG/GJd7Sal8Z0wD2BFy/2cVMgViCSPmFoYzWgwqCF3TGmYMUiaziIx
         47vXDX06uypePI728qfPWBNnEkocV0i034qug3Xta6GDqBPicqEzcW4ILzXZWPzSnO5t
         fpvjaGXsyM9MUk68wAB512MZCGEc8NGKBm2QqlOWOFH59mexEbSQDY9/5MJHwxkI6ev2
         qJatjhytVcIEfeK0jlSk/EkWnx2aZDa41fsVHE5wZaQpYn6hJEprF8ZczfcLyn4CCnCN
         M0/g==
X-Gm-Message-State: AO0yUKVcS6BkmZxQma4BTFBddPFvyIgXknhVwl/EkzoOiSwpPcbvMhBQ
        v0+61057dtums1yR6wfBdw==
X-Google-Smtp-Source: AK7set/t6ufI9HN4BE8MoPGXJPcKFBr5gSmDs5kzz4KsTjhSuis17I25uEk9Medcs2ZibuHvI908Ww==
X-Received: by 2002:a05:6870:c226:b0:16a:bffc:43c2 with SMTP id z38-20020a056870c22600b0016abffc43c2mr1783131oae.36.1676487098888;
        Wed, 15 Feb 2023 10:51:38 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c5-20020a056870a58500b0015f4d1b195bsm7263459oam.36.2023.02.15.10.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 10:51:38 -0800 (PST)
Received: (nullmailer pid 396232 invoked by uid 1000);
        Wed, 15 Feb 2023 18:51:37 -0000
Date:   Wed, 15 Feb 2023 12:51:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Trevor Woerner <twoerner@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] dt-bindings: gpio.txt: expand gpio-line-names
 recommendations
Message-ID: <167648709585.396161.15674193561770841059.robh@kernel.org>
References: <20230211030646.24549-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230211030646.24549-1-twoerner@gmail.com>
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


On Fri, 10 Feb 2023 22:06:45 -0500, Trevor Woerner wrote:
> Provide more guidance to differentiate between recommendations for names of
> lines which are hard-wired to on-board devices, versus recommendations for
> names of lines which are connected to general-purpose pin headers.
> 
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>  .../devicetree/bindings/gpio/gpio.txt         | 41 +++++++++++++------
>  1 file changed, 29 insertions(+), 12 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

