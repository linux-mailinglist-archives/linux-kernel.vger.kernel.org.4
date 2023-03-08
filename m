Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542F76AFAF5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 01:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjCHATJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 19:19:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjCHATG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 19:19:06 -0500
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B55493113;
        Tue,  7 Mar 2023 16:19:05 -0800 (PST)
Received: by mail-oi1-f173.google.com with SMTP id bh20so11002355oib.9;
        Tue, 07 Mar 2023 16:19:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678234744;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ydYIeT5CpiYV9PuLS2/dqB/u1lmO0H7llULte7BqSmU=;
        b=dXaNWWU2oogYOaRcsy3he7qVSOodx2vdh2Dg5k3Y932dAWTSoipgH1rfrvGf0i1uIZ
         EyhdfqbROX1uKS5wvrZJrt/MVWUfqefcQ/pcR1H6UHuOyPw7G1lQfzUvn+C2RbW8uQYs
         kDzK1lAYNkf3MdIUOsbOlP3bB9Ex2j05bzbij6EgKZccDtYS3yIopvdl7N/CcYD2f+q5
         EHt3qBF5ILm0xSlZrDub6WxfCLXPpLqT21kKSlZQpdCsj9stwFmPQiJ1GQST5gjye3DD
         K31DrQpozBOfFo7eOJZodgF4S+LS1zL3URIPqDsWuZdzbZyVqKAd5iruJFDocE9MY1QW
         B/gA==
X-Gm-Message-State: AO0yUKW+mER3bodF93Ev+zNmVSgK9wp3HJFfOObJYunxOlv9pAJw82f4
        bM20OPuRL5YLeSakh/NiYg==
X-Google-Smtp-Source: AK7set/aNjBliRav8GyDeMZdpRrH2aJKfIXTqN1Oy6KTiiDWd6EsCHdNtr+8ou/LRrVmCKY5q4p1Rw==
X-Received: by 2002:aca:1314:0:b0:360:c119:48fc with SMTP id e20-20020aca1314000000b00360c11948fcmr6925666oii.41.1678234744549;
        Tue, 07 Mar 2023 16:19:04 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q81-20020acad954000000b0037fa61eb1dasm5655892oig.47.2023.03.07.16.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 16:19:04 -0800 (PST)
Received: (nullmailer pid 524042 invoked by uid 1000);
        Wed, 08 Mar 2023 00:19:03 -0000
Date:   Tue, 7 Mar 2023 18:19:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Walle <michael@walle.cc>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sebastian Reichel <sre@kernel.org>,
        Wolfram Sang <wsa@kernel.org>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 03/21] of: Rename of_modalias_node()
Message-ID: <20230308001903.GA513330-robh@kernel.org>
References: <20230307165359.225361-1-miquel.raynal@bootlin.com>
 <20230307165359.225361-4-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307165359.225361-4-miquel.raynal@bootlin.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 05:53:41PM +0100, Miquel Raynal wrote:
> This helper does not produce a real modalias, but tries to get the
> "product" compatible part of the "vendor,product" compatibles only. It
> is far from creating a purely useful modalias string and does not seem
> to be used like that directly anyway, so let's try to give this helper a
> more meaningful name before moving there a real modalias helper (already
> existing under of/device.c).
> 
> Also update the various documentations to refer to the strings as
> "aliases" rather than "modaliases" which has a real meaning in the Linux
> kernel.
> 
> There is no functional change.
> 
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Wolfram Sang <wsa@kernel.org>
> Cc: Mark Brown <broonie@kernel.org>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/acpi/bus.c                |  7 ++++---
>  drivers/gpu/drm/drm_mipi_dsi.c    |  2 +-
>  drivers/hsi/hsi_core.c            |  2 +-

These should not have been using this function. The matching on just the 
product was a relic from I2C and SPI which we don't want to propogate. 
No clue why ACPI needed it...

If you respin or want to fixup while applying, can you add a kerneldoc 
comment to not add new users of the function. Not that anyone will 
follow that... :(

Reviewed-by: Rob Herring <robh@kernel.org>

>  drivers/i2c/busses/i2c-powermac.c |  2 +-
>  drivers/i2c/i2c-core-of.c         |  2 +-
>  drivers/of/base.c                 | 15 ++++++++-------
>  drivers/spi/spi.c                 |  4 ++--
>  include/linux/of.h                |  2 +-
>  8 files changed, 19 insertions(+), 17 deletions(-)
