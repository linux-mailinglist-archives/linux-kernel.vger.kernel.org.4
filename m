Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D5766D8B4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 09:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235842AbjAQIwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 03:52:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236272AbjAQIw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 03:52:29 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2B82CFEA
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 00:51:32 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id g10so21646752wmo.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 00:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8xUTsuDVDtEpe1GJ8CtfZxPtOBZeRfWuY5JCnMma88g=;
        b=Q3J63XlGShJ/2WbvRq4hq2JID/RnkKt4xtbAsiugUa9SNycDgYwChezLN95KF6GWZS
         ZVJkIixYUlATzLJeowVp4c1h7z/f/4DH7nMUk4d4cegvxfChKv/AYjU+hXanodexOasF
         VAq8RVqnozkvWd1b5Fh1WlO2+qOfWgf+KUsbML1KuGpsVE2k8s88Z7SJqQfDqdIzgmai
         qbo8EyyaT9JS2OZssTz1Kfflfc2yI4nJHvivkCXHHpXB6yQMbO8dk+957rWZtiA+tEDr
         mJo3+KPuXQid4Tndd7zCW0puoOEZ60Ol+p6iPz76PYqum6cooiDuY2vr0mGP53YeFcAD
         MZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8xUTsuDVDtEpe1GJ8CtfZxPtOBZeRfWuY5JCnMma88g=;
        b=EIHad2hzm2iuY/sM4Z6A1dn8O52NBVWjqVP6aaMSrD64koUjbbPJI20ge/NEWIY+Nc
         32tH3b8QjpCpxf6gXUejcoIXMtJii6RLZ4+Ez08eLIuw4ripxkHfXxDninmuVSbH9ill
         5epclo3ilPehcEE7wSXZwDNugP2M5CJerky87Wuq8HhyqnbodxVp0iTsFr46B0ncz5vA
         TVzCiU2nPuxcARnv6MzF9BIAn488EK3SuQ2id3ZjVZMbfCx2u7mgW78AiUdSlmTsj0i2
         FxqQCXU8ZEg5FM3lZz69qbAImwpmDEdLrs1hjlI/2oH6pRJDizyPUUiTFm4tH1CyQ02p
         La4A==
X-Gm-Message-State: AFqh2korACEb77dagzrKgXQ2dTbANEIK/6eDh/f0aQ9vk9kQYXujL9oK
        Zd9Qfx4I/RR/yu969/rHdjc=
X-Google-Smtp-Source: AMrXdXuaWZ988H1JpKPLPP+mvkv2SJjjaD8lYx2S17O9IVBsaXXDA9gK/NSe7U0nWs0SYGpizHjdWQ==
X-Received: by 2002:a05:600c:1d22:b0:3da:f66c:795d with SMTP id l34-20020a05600c1d2200b003daf66c795dmr2466961wms.9.1673945491342;
        Tue, 17 Jan 2023 00:51:31 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id o2-20020a05600c4fc200b003da2932bde0sm13956874wmq.23.2023.01.17.00.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 00:51:30 -0800 (PST)
Date:   Tue, 17 Jan 2023 11:51:27 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Brent Pappas <bpappas@pappasbrent.com>
Cc:     rmfrfs@gmail.com, johan@kernel.org, elder@kernel.org,
        gregkh@linuxfoundation.org, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: gpio: Replace macro
 irq_data_to_gpio_chip with function
Message-ID: <Y8Zhj81ltR7HI7Uh@kadam>
References: <20230116184707.22302-1-bpappas@pappasbrent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230116184707.22302-1-bpappas@pappasbrent.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 01:47:06PM -0500, Brent Pappas wrote:
> Replace the macro irq_data_to_gpio_chip with a static inline function to comply
> with Linux coding style standards.
> 
> Signed-off-by: Brent Pappas <bpappas@pappasbrent.com>
> ---
>  drivers/staging/greybus/gpio.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/greybus/gpio.c b/drivers/staging/greybus/gpio.c
> index 8a7cf1d0e968..833162ceb385 100644
> --- a/drivers/staging/greybus/gpio.c
> +++ b/drivers/staging/greybus/gpio.c
> @@ -43,7 +43,11 @@ struct gb_gpio_controller {
>  };
>  #define gpio_chip_to_gb_gpio_controller(chip) \
>  	container_of(chip, struct gb_gpio_controller, chip)
> -#define irq_data_to_gpio_chip(d) (d->domain->host_data)
> +
> +static inline void *irq_data_to_gpio_chip(struct irq_data *d)

1) Don't make this a void pointer.  ->host_data is void but we want to
   return a struct gpio_chip * type so declare it as returning a
   gpio_chip struct pointer.  A big advantage of function over macros is
   the type checking.

2) Don't declare it as inline.  Modern compilers are smart and confident.
   They are smart enough to make it inline automatically.  And confident
   enough that they just ignore when people mark stuff as inline.  (We
   have an __always_inline macro for when the compiler is wrong.)

regards,
dan carpenter

