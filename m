Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04ABF673CD5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 15:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjASOyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 09:54:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbjASOyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 09:54:46 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E45798FA;
        Thu, 19 Jan 2023 06:54:42 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id b7so2131455wrt.3;
        Thu, 19 Jan 2023 06:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wy5TUZFPF5q8Yt4s63OdjaHjAcmxGBFMCBM3EbZvWiA=;
        b=RQ/Ocry7XDJLW+Ir5Swv2D4r+NGiJfMvZheDWAMTdVu+GxyjOqvzOOwbiSrjvN4EPE
         4zxlqYcP95+QFfgTqVIeQDR3eRhAKzFe3blYux+ZH6YdHI7eeX2zVmw9dQL0TsWetY6j
         N9xog01QXKs0y1e+nIPyfEaNn1HzPy05DbWpZ6vOWP3guLc5DPl7QZVUxKp4M4+PScIw
         vHNRLWou4Joj5VEgNBPu+zP9xDZR3oRCNzuqoisaq26mXMzGq8XsBbvHR7TzlpM38MkU
         OohAXk68S5bqNutdw9eszxsLYfkAGPC1HNmEdbH7ITgzhkaqLizXbeiaHvSrDMCX8WdY
         mUkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wy5TUZFPF5q8Yt4s63OdjaHjAcmxGBFMCBM3EbZvWiA=;
        b=FK97/uX08fsWKVMtmTl/PssJW7Y4D7Hp09amqyj4Ga7Qs6RwW3eHq7bx9xun1Jo5kI
         lb2EIAfBW6YRZE4zdI5JwfqcIfe+4qu6VkMIVo8hCeMXLUcLZZKngp+FoLxO3OCvSo5N
         ZY5Jn5nbe6/F9pHsDoywsjp9igugge7baLspiJuTxMX/N6B23SWV70UbfjZhdXBwMWH+
         GpLYBFlBlveoHXhiJVyZ4itf3xjnDpcZ0ACoVZktMGIJEzUZudQDMVYRYavsTiRoinHT
         GwrFtnazJlDfP3dhqztXqxgil7JTVmhUd5FBCfSzFbKZIn5E0w5XJT40JrEssoSpjpGU
         deZA==
X-Gm-Message-State: AFqh2kpum4xctB1i+AojT0KWBy1H/o7JajbfpYUjxk5r5qjc8FYqQXnY
        yeD6Km6iBaOsidxI6i/bzamu+PDOLEIcIw==
X-Google-Smtp-Source: AMrXdXu2WNrBPsS8qb3Vrho0oFI8358Pv6WvBJb0HPYxPZM3rU4S1uzhuV+Uun42ZoTKQGl4BclE6A==
X-Received: by 2002:adf:f78d:0:b0:2bd:bed5:9207 with SMTP id q13-20020adff78d000000b002bdbed59207mr9873199wrp.12.1674140081020;
        Thu, 19 Jan 2023 06:54:41 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id q15-20020adfab0f000000b002bde7999cd6sm16094172wrc.61.2023.01.19.06.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 06:54:40 -0800 (PST)
Date:   Thu, 19 Jan 2023 17:54:37 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Brent Pappas <bpappas@pappasbrent.com>
Cc:     andy.shevchenko@gmail.com, andy@kernel.org, colin.i.king@gmail.com,
        gregkh@linuxfoundation.org, hdegoede@redhat.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, mchehab@kernel.org,
        sakari.ailus@linux.intel.com
Subject: Re: [PATCH v2] media: atomisp: pci: sh_css: Inline single invocation
 of macro STATS_ENABLED()
Message-ID: <Y8lZreSphK6DIkJg@kadam>
References: <CAHp75Vc4QS=Gr-DSvf7pzCKktqGPfno4TBDmicj5CKgyHGjSsw@mail.gmail.com>
 <20230119144203.17084-1-bpappas@pappasbrent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119144203.17084-1-bpappas@pappasbrent.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 09:42:03AM -0500, Brent Pappas wrote:
> Inline the single invocation of the macro STATS_ENABLED().
> The macro abstraction is not necessary because the logic behind it is only
> used once.
> 
> Signed-off-by: Brent Pappas <bpappas@pappasbrent.com>
> ---

Needs a V2: note which says what changed.

>  drivers/staging/media/atomisp/pci/sh_css.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/media/atomisp/pci/sh_css.c b/drivers/staging/media/atomisp/pci/sh_css.c
> index 726cb7aa4ecd..93789500416f 100644
> --- a/drivers/staging/media/atomisp/pci/sh_css.c
> +++ b/drivers/staging/media/atomisp/pci/sh_css.c
> @@ -97,9 +97,6 @@
>   */
>  #define JPEG_BYTES (16 * 1024 * 1024)
>  
> -#define STATS_ENABLED(stage) (stage && stage->binary && stage->binary->info && \
> -	(stage->binary->info->sp.enable.s3a || stage->binary->info->sp.enable.dis))
> -
>  struct sh_css my_css;
>  
>  int  __printf(1, 0) (*sh_css_printf)(const char *fmt, va_list args) = NULL;
> @@ -3743,7 +3740,9 @@ ia_css_pipe_enqueue_buffer(struct ia_css_pipe *pipe,
>  			 * The SP will read the params after it got
>  			 * empty 3a and dis
>  			 */
> -			if (STATS_ENABLED(stage)) {
> +			if (stage && stage->binary && stage->binary->info &&
                            ^^^^^^^^
We know that "stage" must be non-NULL.  You should wait over night
before resending v2 patches so that we think "This guy spend overnight
running tests.  He must be very serious."  There is no rush.

regards,
dan carpenter
