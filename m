Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A41565DFD0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 23:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240469AbjADWUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 17:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235406AbjADWUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 17:20:43 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B9710577;
        Wed,  4 Jan 2023 14:20:41 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id bq39so44705649lfb.0;
        Wed, 04 Jan 2023 14:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iVZymcIRh33LZ5vtPH5reGcm8Q0RulUJ4aIPnJyztV0=;
        b=YnMtXnugmUMSD1S7sSkpcwRTbCTcOw/Ur5AM5BOtRLuJeJQ7PGrkcTf6mTgXaGWn5X
         p4a98zYFG7kHGhub7In6zaFnLkziweu5Mnar7+UjvL6g3wLvkbIBNMGyF1oWBtTHJi82
         f2bAke7DCdtQShLGxjOZPHFdZ7Dnpq6I9rQDkHv/rRgeNm9CqN9LJOXdfj4nOvCfJvaC
         CfODNtoukkEQO7u5eXHfo6j8miHETogKDFmZhylZqL6LKiQ1Qpkolk4Z4EjmlCXcbTuv
         SGlUGPlh54nmldz54hkxH5hcgEO5tHfD6t46O232aCVkgCJb4ItLA8ey7pYN5gXyBjon
         lLmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iVZymcIRh33LZ5vtPH5reGcm8Q0RulUJ4aIPnJyztV0=;
        b=U2iY5VAgRmTwD/5Smzd+S1u/oPU94INIY+pKyJoE84pqONuyZE2i+LL0N1vYULS7UR
         R4E72ft8+VeDHfRfp004W238gi/eJLX3qr/Ja9XjkTNlfbGyKVolXuEaMVRLklJQmkx6
         c0mJeuufH4ChR6QS7+ki1moilWgTBUDWK96e4lHlqemaC6RGv7HsEA/rOKnoypVjFsrL
         7jPiTCT+utw54fVhBTQzPlVeQ0mcWDoVZ2K/xUomPv9trdczLjsowl39Va5/vUT1VGw7
         IGgTWOXZK2MvE4Dlsbk+BBgZXvX1JnspO39AV+wLUhy3naMfddFo4QIvu3gFpzgj9vvA
         KaXw==
X-Gm-Message-State: AFqh2kqlfHFvyloS1So6Y91rIGsjAxXmPNanNFFW4+8j+nwHzqJhiR/v
        ym32TA2gxZzTXxct2ug99Fc=
X-Google-Smtp-Source: AMrXdXu+r973DUePL6Ju6O2TPYHdZB4lJSAmCS1j6Age35S+3vV/oOHe47FYBhl1p2HJUldMSLJC1Q==
X-Received: by 2002:ac2:44d6:0:b0:4b5:4606:7ae3 with SMTP id d22-20020ac244d6000000b004b546067ae3mr11749964lfm.46.1672870839609;
        Wed, 04 Jan 2023 14:20:39 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id bu20-20020a056512169400b004cb02ed464esm4153357lfb.196.2023.01.04.14.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 14:20:38 -0800 (PST)
Date:   Thu, 5 Jan 2023 01:20:36 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Sudip Mukherjee <sudip.mukherjee@sifive.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        jude.onyenegecha@sifive.com, ben.dooks@sifive.com,
        jeegar.lakhani@sifive.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/15] Add support for enhanced SPI for Designware SPI
 controllers
Message-ID: <20230104222036.h4ke6maxkdvuqtqc@mobilestation>
References: <20221212180732.79167-1-sudip.mukherjee@sifive.com>
 <20221218174523.cke7ubh6nycd247c@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221218174523.cke7ubh6nycd247c@mobilestation>
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

On Sun, Dec 18, 2022 at 08:45:26PM +0300, Serge Semin wrote:
> Hi Sudip
> 
> On Mon, Dec 12, 2022 at 06:07:17PM +0000, Sudip Mukherjee wrote:
> > The is v2 of the patch series adding enhanced SPI support. Some Synopsys SSI
> > controllers support enhanced SPI which includes Dual mode, Quad mode and
> > Octal mode. DWC_ssi includes clock stretching feature in enhanced SPI modes
> > which can be used to prevent FIFO underflow and overflow conditions while
> > transmitting or receiving the data respectively.
> > 
> > This is almost a complete rework based on the review from Serge.
> 
> Thank you very much for the series. I'll have a look at it on the next
> week.

Just so you know. I haven't forgot about the series. There are some
problematic parts which I need to give more thinking than I originally
expected. I'll submit my comments very soon. Sorry for the delay.

Good news is that I've got the HW-manual for the DW SSI v1.01a
IP-core. So I'll no longer need to ask of you about that device
implementation specifics.

-Serge(y)

> 
> -Serge(y)
> 
> > 
> > 
> > -- 
> > Regards
> > Sudip
> > 
> > Sudip Mukherjee (15):
> >   spi: dw: Introduce spi_frf and STD_SPI
> >   spi: dw: update NDF while using enhanced spi mode
> >   spi: dw: update SPI_CTRLR0 register
> >   spi: dw: add check for support of enhanced spi
> >   spi: dw: Introduce enhanced mem_op
> >   spi: dw: Introduce dual/quad/octal spi
> >   spi: dw: send cmd and addr to start the spi transfer
> >   spi: dw: update irq setup to use multiple handler
> >   spi: dw: use irq handler for enhanced spi
> >   spi: dw: Calculate Receive FIFO Threshold Level
> >   spi: dw: adjust size of mem_op
> >   spi: dw: Add retry for enhanced spi mode
> >   spi: dw: detect enhanced spi mode
> >   spi: dt-bindings: snps,dw-ahb-ssi: Add generic dw-ahb-ssi version
> >   spi: dw: initialize dwc-ssi controller
> > 
> >  .../bindings/spi/snps,dw-apb-ssi.yaml         |   1 +
> >  drivers/spi/spi-dw-core.c                     | 347 +++++++++++++++++-
> >  drivers/spi/spi-dw-mmio.c                     |   1 +
> >  drivers/spi/spi-dw.h                          |  27 ++
> >  4 files changed, 364 insertions(+), 12 deletions(-)
> > 
> > -- 
> > 2.30.2
> > 
