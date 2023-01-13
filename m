Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD1666A407
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 21:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjAMUX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 15:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjAMUXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 15:23:54 -0500
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC0263AE;
        Fri, 13 Jan 2023 12:23:53 -0800 (PST)
Received: by mail-oo1-f43.google.com with SMTP id 187-20020a4a09c4000000b004d8f3cb09f5so5829005ooa.6;
        Fri, 13 Jan 2023 12:23:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9x024bi2HQcHf0JisS3CegxHl2k3K+Gz9WKll4gOlgM=;
        b=O/oCHnnfPSBB0miScDyUioaq2GNLXLpepY7ctworVjEagerPIFO+TOVxqfdqEAzqsY
         tJ4WVEEwD3MZRn+oEKYLn9r3aJOugVP+g6O5tSZSFZ3i4lPsf32bBbOSlh97/fKygu4S
         loY1G8BbNOrsX+tDgvXltayP3g5VkXNPNnMsXgU023/J9xM0GvWNZGLUp0ThIpZm0M4G
         hXDeSpek2RUfjIALx7H6HWoIzJOi0JfMnDydUkwdWQ1AfNck/KvxKgTqsPDtWpYdlsyN
         Y1rEtGct48VO0q6bZDKf//cwiRVIIYiLrBnp86pPIT9yL4chBz8QVXQzsdv+p6Mt2mSn
         Nfag==
X-Gm-Message-State: AFqh2kpWkHsLhCpX2/uXvoDMS538lDfI0B8wCnrkhQUQ25nQRn3sO/PN
        2Nz4M34IVpJjb0ZaPMaiIWwtW3mkMg==
X-Google-Smtp-Source: AMrXdXtPdiR37CCZkFLb3UQ9cXfbdGsbe4DVeFzSBEZxsljAmC5y+q4aFbM3LbFc1Le+RqluTSQRmA==
X-Received: by 2002:a05:6820:823:b0:4f1:f375:c240 with SMTP id bg35-20020a056820082300b004f1f375c240mr13282605oob.6.1673641433045;
        Fri, 13 Jan 2023 12:23:53 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x3-20020a4a8d43000000b004805b00b2cdsm10115142ook.28.2023.01.13.12.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 12:23:52 -0800 (PST)
Received: (nullmailer pid 2868198 invoked by uid 1000);
        Fri, 13 Jan 2023 20:23:51 -0000
Date:   Fri, 13 Jan 2023 14:23:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH v1 1/1] gpiolib: of: Move enum of_gpio_flags to its only
 user
Message-ID: <20230113202351.GA2864676-robh@kernel.org>
References: <20230112145140.67573-1-andriy.shevchenko@linux.intel.com>
 <Y8AzwdCGr4VFjP5X@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8AzwdCGr4VFjP5X@smile.fi.intel.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 06:22:25PM +0200, Andy Shevchenko wrote:
> On Thu, Jan 12, 2023 at 04:51:40PM +0200, Andy Shevchenko wrote:
> > GPIO library for OF is the only user for enum of_gpio_flags.
> > Move it there.
> 
> ...
> 
> > +/*
> > + * This is Linux-specific flags. By default controllers' and Linux' mapping
> > + * match, but GPIO controllers are free to translate their own flags to
> > + * Linux-specific in their .xlate callback. Though, 1:1 mapping is recommended.
> > + */
> 
> Now that I re-read the comment, I think this can be postponed until we get a
> consensus that no new driver is ever should do non 1:1 mapping.
> 
> If that consensus achieved, we may drop this enum altogether and replace it
> with the generic flags..

We don't keep things with no users. We can move this back if there ever 
is a user.

Rob
