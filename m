Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61218679C3E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 15:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235061AbjAXOnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 09:43:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234912AbjAXOmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 09:42:42 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173EA4A1DC;
        Tue, 24 Jan 2023 06:42:27 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id t18so1281353wro.1;
        Tue, 24 Jan 2023 06:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ULYuWXV/gOEakuXjYyzzPaFAF/ufwa1YfwMolryeGUM=;
        b=cgw3mJmyiwBWjJtV9xeWFnFIArTiv+hIHox3q8JHJd1tEiIc95OhiLNb+Esl7v2uk/
         l9j6UQA8fmquOTUmBmWw46iI+3ZFYjM2z0RFxDxwYqDwIS1IGjUUpEvCn8YsHdIYBfR4
         GBcLi0y+5KVuNclKgoHqAK8kw4w7BUjWIHPa/iaNCtCZ9UhDIwHGSmSiGPxJ62ycV8Ly
         MCJu5HZI4GzabKTMv+82IT+Eh7AzcsrMrffut+SJPkINivgb9UKhY6y0k/G+JJx0zIk5
         qACMp3TpagVHMu0zMZghJnAqfl8Pfbi7aaY6qUBj1E/r4XofX+oEk09Yy+UswNOQvfSs
         gqTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ULYuWXV/gOEakuXjYyzzPaFAF/ufwa1YfwMolryeGUM=;
        b=ASjZcVoFx5yT2HJxL5O/jLI9I5bxOM/k9LbREdGdVTnO6gPhvyKeHfEEi0Z9UnI8iM
         Ci+KAmYTd9hoMtA1LSw09ioeziCYhfB3+c0zDD3Z4dQZ+LoHdWZg5qkDc7xJ8UfyqeFB
         lDkefvjH0yXKTkf5pseNoY9psZBAsEKhPej34e9aL2E9+1kLngJMCuUDk53x5zH1EBz0
         HZbbbTIYJ/qrHNHwV9DXcL5Snuj6aBXfQ4zvSQybhhjMoWmf5Xl+f5z9ai5ImreD7cRt
         3EpXcjPfjNcw+qWd3DLED8szvzOYR2n+A4Z6WE/jyPVj3OmtEz5u30O87sy04tHgSj00
         m1xg==
X-Gm-Message-State: AFqh2koGlr0oP/aWJII5uYP42pFdGc46scRBATz/wlAcjmLF3WC1DK2g
        szxBbfvzA3kz4zK7T/XoJaY=
X-Google-Smtp-Source: AMrXdXskPF1ZD0ZmfencZ5tEi8M4YEL2aTheDKQMrqEBrm7RB+dZMcEceObH2/QvJlVxFhODeOG0wg==
X-Received: by 2002:a05:6000:549:b0:2be:184a:5d5c with SMTP id b9-20020a056000054900b002be184a5d5cmr21672099wrf.59.1674571345340;
        Tue, 24 Jan 2023 06:42:25 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id m14-20020adffa0e000000b00287da7ee033sm2098028wrr.46.2023.01.24.06.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 06:42:24 -0800 (PST)
Date:   Tue, 24 Jan 2023 17:42:21 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Brent Pappas <bpappas@pappasbrent.com>
Cc:     sakari.ailus@linux.intel.com, bingbu.cao@intel.com,
        tian.shu.qiu@intel.com, mchehab@kernel.org,
        gregkh@linuxfoundation.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mdeia: ipu3: ipu33-mmu: Replace macro IPU3_ADDR2PTE()
 with a function
Message-ID: <Y8/uTYK7qmYD5MSA@kadam>
References: <20230124135554.13787-1-bpappas@pappasbrent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124135554.13787-1-bpappas@pappasbrent.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 08:55:54AM -0500, Brent Pappas wrote:
> Replace the macro IPU3_ADDR2PTE() with a static function to match
> Linux coding style standards.

When you say "Linux coding style standards" what exactly does that mean?
I've just re-read the Documentation/process/coding-style.rst section on
"Macros, Enums and RTL" and I don't see an issue with the macro.

This code is in the middle of a big section full of macros.  Why did you
pick this particular macro?  Now it doesn't mirror the IPU3_PTE2ADDR()
so this patch hurts readability.

> 
> Signed-off-by: Brent Pappas <bpappas@pappasbrent.com>
> ---
>  drivers/staging/media/ipu3/ipu3-mmu.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/media/ipu3/ipu3-mmu.c b/drivers/staging/media/ipu3/ipu3-mmu.c
> index cb9bf5fb29a5..d2d603c32773 100644
> --- a/drivers/staging/media/ipu3/ipu3-mmu.c
> +++ b/drivers/staging/media/ipu3/ipu3-mmu.c
> @@ -25,7 +25,11 @@
>  #define IPU3_PT_SIZE		(IPU3_PT_PTES << 2)
>  #define IPU3_PT_ORDER		(IPU3_PT_SIZE >> PAGE_SHIFT)
>  
> -#define IPU3_ADDR2PTE(addr)	((addr) >> IPU3_PAGE_SHIFT)
> +static u32 ipu3_addr2pte(phys_addr_t addr)
> +{
> +	return addr >> IPU3_PAGE_SHIFT;
> +}

To me the original macro is fine.  The inline would also be fine if it
were done consistently.  But I guess I just don't see a lot of value in
changing the existing code.

If you were taking ownership of this driver in a more meaningful way
then I would defer to your taste...  But I just don't see a lot of value
in the patch.

regards,
dan carpenter

