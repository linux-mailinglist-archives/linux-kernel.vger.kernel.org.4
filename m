Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC94C66A419
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 21:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjAMU3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 15:29:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjAMU3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 15:29:00 -0500
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508B8857E8;
        Fri, 13 Jan 2023 12:28:55 -0800 (PST)
Received: by mail-ot1-f46.google.com with SMTP id k44-20020a9d19af000000b00683e176ab01so12824489otk.13;
        Fri, 13 Jan 2023 12:28:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T6uOIBY2QWdwRY5nTsaJOc8EMrdxEkItzpmSPcJ18uE=;
        b=qBrD+TTeCBpv0zzPssIQd1zA3xhhilch4WYOvNcyctcKzg5HpXmKZm/X8c24QVAf2/
         o1AqtEBK9ZCw3GH3lnEJxd2e1vwtkRMUNv1tzEOyYyzho6zI0wK6D1t3ZLtHiK97bmbh
         TY9PiZeiuLCG83HeG8CRctUbSqfy/+3Na0SGePKiF2I3wgLv11jEv5f/XPelVgvKL1gJ
         TqRxqdlPdrjQ5cX827Ez5rKdUJLqnhiqa7DfYKcXg2O6NMCfvEJmFjgHv47Ys2GZPPTM
         LP9pheP9oN/+4BcGgjiGUESczz/Kyd6PfxWH84y+nLX4H5vqgyO8yuPjEmXUGMsO3z8b
         zGlA==
X-Gm-Message-State: AFqh2kqC4XI8u5DaJe8BGyUhe4j4mJApcBdfpf3w508JmKSThTTWNpRX
        IuyDnTF04TTGlS1CPVpw7A==
X-Google-Smtp-Source: AMrXdXuB9QGO3F1RomRyX28k9iRLhRC6dBkm6YnLhP+cEL6fK3sUhFJXD9Y46j08rn9gza6BJU/mRA==
X-Received: by 2002:a05:6830:6303:b0:684:a1e5:4f with SMTP id cg3-20020a056830630300b00684a1e5004fmr8228493otb.18.1673641734566;
        Fri, 13 Jan 2023 12:28:54 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bt25-20020a05683039d900b0066e80774203sm11182551otb.43.2023.01.13.12.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 12:28:54 -0800 (PST)
Received: (nullmailer pid 2873785 invoked by uid 1000);
        Fri, 13 Jan 2023 20:28:53 -0000
Date:   Fri, 13 Jan 2023 14:28:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH v1 1/1] gpiolib: of: Move enum of_gpio_flags to its only
 user
Message-ID: <167364172860.2873659.6905782483557660702.robh@kernel.org>
References: <20230112145140.67573-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112145140.67573-1-andriy.shevchenko@linux.intel.com>
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


On Thu, 12 Jan 2023 16:51:40 +0200, Andy Shevchenko wrote:
> GPIO library for OF is the only user for enum of_gpio_flags.
> Move it there.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpio/gpiolib-of.c | 15 +++++++++++++++
>  include/linux/of_gpio.h   | 15 ---------------
>  2 files changed, 15 insertions(+), 15 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
