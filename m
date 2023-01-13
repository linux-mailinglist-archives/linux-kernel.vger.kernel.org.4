Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F40466A416
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 21:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjAMU2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 15:28:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjAMU2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 15:28:31 -0500
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E41DFB8;
        Fri, 13 Jan 2023 12:28:28 -0800 (PST)
Received: by mail-ot1-f44.google.com with SMTP id i26-20020a9d68da000000b00672301a1664so12852458oto.6;
        Fri, 13 Jan 2023 12:28:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Si0GZadZUNr/kAzkR96YtQzx/rwHGtAM5R2fd2AJPtM=;
        b=hbz1KH99nENcgpqOA+elOSEPZgrhmhzgCal2uaKqeuztf1wO6f5eOWvxHGQtFSW6c4
         KoGoPNnG2SX7BWSiN47Z4+06vRMmvspjS4DF9OcRNWMfNaHTZ1uetadB+udFUa/Zjm9s
         23j60BuF5JDS+wHiCAz01VHLRkGzLJZaOt5cc305p+9vIVSpT/COz2jpUDW6fCp+joNe
         RJXgUUtQ6vuhDgnp4T7p2qUpqkEgnSne3K8uJkVCpISj0AWgL9JgGA4V/SnqBlUy+S40
         t1ueIiZ3pxuMEkASLXi1YFLwYnt8zELHH+LAhevlldT9h5/Y8mfqr+PNVUiSLgcm+Za5
         ip+w==
X-Gm-Message-State: AFqh2koVuXDHnh5nN/PQBmqVDoNLD15QkqGA+7VDfy1DW1mVqwLbk0+6
        dPP6K3W27zkb5nhInXokfQ==
X-Google-Smtp-Source: AMrXdXuMSvIJVaKBYEpyXo28TveYvAVuR4kf5SXeshFdkbUzEoBLGodclOngcq6esI9pN07M2LaFWQ==
X-Received: by 2002:a9d:738e:0:b0:670:4588:f8c4 with SMTP id j14-20020a9d738e000000b006704588f8c4mr38179288otk.18.1673641707873;
        Fri, 13 Jan 2023 12:28:27 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x8-20020a9d6288000000b00661a3f4113bsm10770631otk.64.2023.01.13.12.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 12:28:27 -0800 (PST)
Received: (nullmailer pid 2873223 invoked by uid 1000);
        Fri, 13 Jan 2023 20:28:26 -0000
Date:   Fri, 13 Jan 2023 14:28:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH v1 1/1] gpiolib: Remove unused of_mm_gpiochip_add()
Message-ID: <20230113202826.GA2868820-robh@kernel.org>
References: <20230112144526.66794-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112144526.66794-1-andriy.shevchenko@linux.intel.com>
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

On Thu, Jan 12, 2023 at 04:45:26PM +0200, Andy Shevchenko wrote:
> of_mm_gpiochip_add() is unused API, remove it for good.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpio/TODO       | 4 ++--
>  include/linux/of_gpio.h | 5 -----
>  2 files changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpio/TODO b/drivers/gpio/TODO
> index 76560744587a..68ada1066941 100644
> --- a/drivers/gpio/TODO
> +++ b/drivers/gpio/TODO
> @@ -61,8 +61,8 @@ Work items:
>  
>  - Get rid of struct of_mm_gpio_chip altogether: use the generic  MMIO
>    GPIO for all current users (see below). Delete struct of_mm_gpio_chip,
> -  to_of_mm_gpio_chip(), of_mm_gpiochip_add_data(), of_mm_gpiochip_add()
> -  of_mm_gpiochip_remove() from the kernel.
> +  to_of_mm_gpio_chip(), of_mm_gpiochip_add_data(), of_mm_gpiochip_remove()
> +  from the kernel.
>  
>  - Change all consumer drivers that #include <linux/of_gpio.h> to
>    #include <linux/gpio/consumer.h> and stop doing custom parsing of the
> diff --git a/include/linux/of_gpio.h b/include/linux/of_gpio.h
> index e27a9187c0c6..935225caf70d 100644
> --- a/include/linux/of_gpio.h
> +++ b/include/linux/of_gpio.h
> @@ -56,11 +56,6 @@ extern int of_get_named_gpio(const struct device_node *np,
>  extern int of_mm_gpiochip_add_data(struct device_node *np,
>  				   struct of_mm_gpio_chip *mm_gc,
>  				   void *data);
> -static inline int of_mm_gpiochip_add(struct device_node *np,
> -				     struct of_mm_gpio_chip *mm_gc)
> -{
> -	return of_mm_gpiochip_add_data(np, mm_gc, NULL);
> -}
>  extern void of_mm_gpiochip_remove(struct of_mm_gpio_chip *mm_gc);

Keep going!

Looks like of_get_gpio_flags, of_get_gpio, of_gpio_count, 
of_gpio_named_count, and of_get_named_gpio_flags are all unused.

Rob
