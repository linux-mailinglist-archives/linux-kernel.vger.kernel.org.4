Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80FE661A02
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 22:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234878AbjAHVbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 16:31:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234073AbjAHVbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 16:31:36 -0500
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA7B2652;
        Sun,  8 Jan 2023 13:31:35 -0800 (PST)
Received: by mail-qv1-f53.google.com with SMTP id t17so4983771qvw.6;
        Sun, 08 Jan 2023 13:31:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=js0w/jb+lh+/4h7Fj3cofK1pNZXgAj1iZs13t0WEx7U=;
        b=O3/QB1oY2VD+0rDeVJtDR9ibPffXORKtQ6tvd+OxNbMUu0HxxZekTO8L3bGIBVc9pZ
         PG0m2HW8BOsDAlQKksNKxVera2SPts8E5ScttGtnEtLg7xKbtzK7FBPb5EaVf7Ilw7L3
         X/mNS3VOKtBc/a5gqe63WLMiRnIvcZ50yq0fSH/ysKPypODxq/hNIWQDfOI6N0q1j8kX
         mwJFXhAvNehUbT2NMeld31oSUiWY1ZZR3URejApjLvZokuUwnuBr6k0CpkE7Qz7YK3LY
         l7bv4CnM9KLrTp0ECE93oR3ZbZ1o5xSDE3cBOGPjFLEfK1w3NzaVEJVr8yxlmUyny1HK
         4hJg==
X-Gm-Message-State: AFqh2kr3oz8GZUT3VaTaWB1MdJg2fNqGc68Z74n6KtzeZJxZRuENOosI
        qhjtt7r5QfBB+eRaDhgwww==
X-Google-Smtp-Source: AMrXdXuBm+J+Rynuin0d2pDwJb7zmpV8C55xdiobHV2KiVZ4+Tky8PsFOPSUUj6AjwE8vmlqoBWtGw==
X-Received: by 2002:a0c:80e4:0:b0:531:91cd:59de with SMTP id 91-20020a0c80e4000000b0053191cd59demr59201574qvb.26.1673213494064;
        Sun, 08 Jan 2023 13:31:34 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:80a5:9b51:39ae:24d1:33f3:811e])
        by smtp.gmail.com with ESMTPSA id l23-20020a37f917000000b006fc2b672950sm4256353qkj.37.2023.01.08.13.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 13:31:33 -0800 (PST)
Received: (nullmailer pid 306308 invoked by uid 1000);
        Sun, 08 Jan 2023 21:31:19 -0000
Date:   Sun, 8 Jan 2023 15:31:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        devicetree@vger.kernel.org, Janne Grunau <j@jannau.net>,
        asahi@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 4/5] spi: dt-bindings: Add hold/inactive CS delay
 peripheral properties
Message-ID: <167321346258.305589.13314015291667781400.robh@kernel.org>
References: <20230104093631.15611-1-marcan@marcan.st>
 <20230104093631.15611-5-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104093631.15611-5-marcan@marcan.st>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 04 Jan 2023 18:36:30 +0900, Hector Martin wrote:
> From: Janne Grunau <j@jannau.net>
> 
> These two properties complete the bindings for the Linux spi_device cs
> model, which includes cs_setup, cs_hold and cs_inactive delay values.
> 
> Signed-off-by: Janne Grunau <j@jannau.net>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  .../devicetree/bindings/spi/spi-peripheral-props.yaml  | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
