Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2DDE639C57
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 19:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiK0SZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 13:25:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiK0SZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 13:25:54 -0500
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4815F60;
        Sun, 27 Nov 2022 10:25:53 -0800 (PST)
Received: by mail-io1-f51.google.com with SMTP id r81so6228088iod.2;
        Sun, 27 Nov 2022 10:25:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S8bsHlpNOFcbCNV3S3KNbgx5jtrGlxhIxfZQJSXdiI8=;
        b=hpLrifZ6EtIfiPVqwH3jd8D9yE/AwbtlPGmiV7fhWKKlFHw3yhPOXdJi5esHl+vUhm
         CGNdBkE9bIejRhow/ExYpUQoVU1DB23Qfrip9hlGxjRHgUOr5tWwEZrZW3zHbtlctYb4
         5qqFNWbrIGmn1Odw24RcByQj+2C6pl4VyuWuWIfyNBmM0zHUWSlgF5Zfo/ds7dEVhOCL
         YuC9IzT//ixkk/0bKt5zuO6lh2kbJfd1X71UmLZLxQWojGv/jYRoZu9osRWL/FqFZA9w
         u1juFQl/J8ksYx1ajd5mNpojTfbhJFTcGRb3ax7r9VZSQnCEpozT15/3RO9/Wdr7wwwZ
         tPtw==
X-Gm-Message-State: ANoB5pluX5icoytYkIhN/uR2PAExqsNRfLaRNjqLxosOcDSsC1UG0EEK
        xdplp5ASLJgbmtwR5LDZgw==
X-Google-Smtp-Source: AA0mqf4/UTMwRwnIlC+je7s+xyLV5H6yWYNsPoNaMuJssYdZ1JVl/+l7lHnKDkheQefibulNpQHtFg==
X-Received: by 2002:a05:6638:ca4:b0:389:dbc8:c058 with SMTP id x4-20020a0566380ca400b00389dbc8c058mr1463216jad.10.1669573552742;
        Sun, 27 Nov 2022 10:25:52 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:80c1:3b80:81db:640f:ef27:c9e2])
        by smtp.gmail.com with ESMTPSA id e10-20020a92690a000000b00302e4c93a54sm3113081ilc.79.2022.11.27.10.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Nov 2022 10:25:52 -0800 (PST)
Received: (nullmailer pid 148616 invoked by uid 1000);
        Sun, 27 Nov 2022 18:25:52 -0000
Date:   Sun, 27 Nov 2022 12:25:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     qyousef@layalina.io, atishp@atishpatra.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        pratyush@kernel.org, robh+dt@kernel.org,
        linux-mtd@lists.infradead.org, anup@brainfault.org, richard@nod.at,
        linux-crypto@vger.kernel.org, miquel.raynal@bootlin.com,
        nicolas.ferre@microchip.com, devicetree@vger.kernel.org,
        michael@walle.cc, herbert@gondor.apana.org.au, tkhai@ya.ru,
        baolin.wang@linux.alibaba.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski+dt@linaro.org, broonie@kernel.org,
        arnd@arndb.de, linux-spi@vger.kernel.org,
        quic_abhinavk@quicinc.com, vasily.averin@linux.dev,
        colin.i.king@gmail.com
Subject: Re: [PATCH] MAINTAINERS: Update email of Tudor Ambarus
Message-ID: <166957354583.148471.5381866020763010078.robh@kernel.org>
References: <20221122125244.175295-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122125244.175295-1-tudor.ambarus@microchip.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 22 Nov 2022 14:52:44 +0200, Tudor Ambarus wrote:
> My professional email will change and the microchip one will bounce after
> mid-november of 2022.
> 
> Update the MAINTAINERS file, the YAML bindings, MODULE_AUTHOR entries and
> author mentions, and add an entry in the .mailmap file.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  .mailmap                                               |  1 +
>  .../bindings/crypto/atmel,at91sam9g46-aes.yaml         |  2 +-
>  .../bindings/crypto/atmel,at91sam9g46-sha.yaml         |  2 +-
>  .../bindings/crypto/atmel,at91sam9g46-tdes.yaml        |  2 +-
>  .../devicetree/bindings/spi/atmel,at91rm9200-spi.yaml  |  2 +-
>  .../devicetree/bindings/spi/atmel,quadspi.yaml         |  2 +-
>  MAINTAINERS                                            | 10 +++++-----
>  drivers/crypto/atmel-ecc.c                             |  4 ++--
>  drivers/crypto/atmel-i2c.c                             |  4 ++--
>  drivers/crypto/atmel-i2c.h                             |  2 +-
>  10 files changed, 16 insertions(+), 15 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
