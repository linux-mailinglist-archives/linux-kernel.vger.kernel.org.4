Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1DF565044A
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 19:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbiLRS3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 13:29:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbiLRS2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 13:28:46 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25AC4C23;
        Sun, 18 Dec 2022 09:45:28 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id s25so7063036lji.2;
        Sun, 18 Dec 2022 09:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fUzlIolrkO35IM847g1aZdLGAKepQ/5ib1TfeOvGlxY=;
        b=XfvTZuXpYRutEu7yMimcOYjfNe0gU00ElbWqGZrMExxP2DRKnUs9ZS6sxrDsY7nYSP
         SJf0Na4FXDbLptu1dUnlrTzFxCgdjPZcWpTc45t4TpOftktbK/jP/clov95razDkgbqw
         7AcUgdn797L9DKQNnYpRNzW6ZSEESzLshuFAmT5E9k65Voz1YqJVpTuPcyQKuz7k7HGN
         jQNIU3PM6WzsdciRu/HJTGkmT1SGnZMlc9BNGK/ZH/NmlpoXa0AIMl5xFWlO9ml2YRoX
         aCW6R5/cB3kORG5LDdVTzv3lSCszaAipIKZyBz42HhZVto6xfm7iXANFGmtle+H7WNIx
         HAZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fUzlIolrkO35IM847g1aZdLGAKepQ/5ib1TfeOvGlxY=;
        b=R/TjUJCo8oUXHx+AQFKS4PFnu5abSNY4ynKfe5sy7QH7y7X6UFPuHVzycrNHELn6gk
         0zw8e+bouoLkgUYo5nvakNzivhjg06K/6Nb1uNGo4tGiw17godctzPnCYu4iH9UrZmj1
         JvHaJiWYUpZoKulL0DwDRRffR0It+vrn/GkClX1ExhtyXhmVVa8dsrSNaWW/ytn+ExWs
         VJx2upxFulWn4bdFhTFMdzeprkeH6NQg+ZV2oHz7IW5RJHuRfX89p6w1KNJAFr+q3wSC
         9dbtdJFPCaH8rzQFUztTt9aoVSwjxBmZhs0ADxNMusuIBzbip50MAS1ADVYmoYMgxBag
         EZUg==
X-Gm-Message-State: ANoB5pk+9pV9FcEs3TBOqIsgltCLAM3TT4xnWReZ/mXUulE0f1SkB9Kw
        7dV1MPSbI+BiznOIyR0ZNLuqu3RCjxk=
X-Google-Smtp-Source: AA0mqf7OQXKC1W2FrEkt0GD+KiUFbsAj3RJrLzmiYFqowcOQFAVHjhNCXR+lUVMaNe/GkQW/2LxRzA==
X-Received: by 2002:a2e:bc09:0:b0:27a:40a3:d9a with SMTP id b9-20020a2ebc09000000b0027a40a30d9amr11527713ljf.9.1671385526080;
        Sun, 18 Dec 2022 09:45:26 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id m18-20020a056512359200b004b523766c23sm870247lfr.202.2022.12.18.09.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Dec 2022 09:45:25 -0800 (PST)
Date:   Sun, 18 Dec 2022 20:45:23 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Sudip Mukherjee <sudip.mukherjee@sifive.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        jude.onyenegecha@sifive.com, ben.dooks@sifive.com,
        jeegar.lakhani@sifive.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/15] Add support for enhanced SPI for Designware SPI
 controllers
Message-ID: <20221218174523.cke7ubh6nycd247c@mobilestation>
References: <20221212180732.79167-1-sudip.mukherjee@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212180732.79167-1-sudip.mukherjee@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudip

On Mon, Dec 12, 2022 at 06:07:17PM +0000, Sudip Mukherjee wrote:
> The is v2 of the patch series adding enhanced SPI support. Some Synopsys SSI
> controllers support enhanced SPI which includes Dual mode, Quad mode and
> Octal mode. DWC_ssi includes clock stretching feature in enhanced SPI modes
> which can be used to prevent FIFO underflow and overflow conditions while
> transmitting or receiving the data respectively.
> 
> This is almost a complete rework based on the review from Serge.

Thank you very much for the series. I'll have a look at it on the next
week.

-Serge(y)

> 
> 
> -- 
> Regards
> Sudip
> 
> Sudip Mukherjee (15):
>   spi: dw: Introduce spi_frf and STD_SPI
>   spi: dw: update NDF while using enhanced spi mode
>   spi: dw: update SPI_CTRLR0 register
>   spi: dw: add check for support of enhanced spi
>   spi: dw: Introduce enhanced mem_op
>   spi: dw: Introduce dual/quad/octal spi
>   spi: dw: send cmd and addr to start the spi transfer
>   spi: dw: update irq setup to use multiple handler
>   spi: dw: use irq handler for enhanced spi
>   spi: dw: Calculate Receive FIFO Threshold Level
>   spi: dw: adjust size of mem_op
>   spi: dw: Add retry for enhanced spi mode
>   spi: dw: detect enhanced spi mode
>   spi: dt-bindings: snps,dw-ahb-ssi: Add generic dw-ahb-ssi version
>   spi: dw: initialize dwc-ssi controller
> 
>  .../bindings/spi/snps,dw-apb-ssi.yaml         |   1 +
>  drivers/spi/spi-dw-core.c                     | 347 +++++++++++++++++-
>  drivers/spi/spi-dw-mmio.c                     |   1 +
>  drivers/spi/spi-dw.h                          |  27 ++
>  4 files changed, 364 insertions(+), 12 deletions(-)
> 
> -- 
> 2.30.2
> 
