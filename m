Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 609A46728C9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 20:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjARTzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 14:55:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjARTzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 14:55:37 -0500
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2693F5954B;
        Wed, 18 Jan 2023 11:55:31 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id x10so146031edd.10;
        Wed, 18 Jan 2023 11:55:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yQTDNe7yFHyxNpHt+5GYWQ4fTkN36Wo6nFC2zV7ddRA=;
        b=UdRUtm22/nVwd2/yhLyFOkTfSiQXuXeMFQ3Kp6hVPDDBU4Z/NMpGYTxQL2IX4MA87a
         52su/8R5xmPukNXLrUu/X39YO1pBFOSNi/hRGpzJawBunHm6YSvV7a4rnOem/sGoa2QH
         DCjMhA8cXwbD1UB6OLGLG3R+Wfs4tp9rOnYKtdFFyl9Zb+LgIanoIwQYAyIn+LzU832H
         GRvjRAaqT/YcnPSZXBG6mQwRkKmmQ6FGn0Pb4hW5a5w9SmA7U0zJ2FUZYdvZ/dWZpbyH
         Sve/8mlqFgY2QG7nK1IrIO2XtaYAg0izF7rPFxnVi+CVHnDG2Ge3mHmXsCm5UxDn7jCN
         qKLA==
X-Gm-Message-State: AFqh2kqprf4nISB5XnyWJuqbbUqQZqMW4omqpZocJZmQXdIBePTReBzH
        SzjuLD8e3tAlNtW0tfKIavWqe4IbD5Ej1do6fsY=
X-Google-Smtp-Source: AMrXdXufxEuzBCgs6edR0DKECeIru46xUZ4hMNXNamwvHSWkmE+7Nka2sXtX+eHIroy5RNXVkD9xY9GYYRBKHTFJazI=
X-Received: by 2002:a05:6402:40d6:b0:46d:53d7:d1f6 with SMTP id
 z22-20020a05640240d600b0046d53d7d1f6mr918494edb.211.1674071730393; Wed, 18
 Jan 2023 11:55:30 -0800 (PST)
MIME-Version: 1.0
References: <20230117152120.42531-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230117152120.42531-1-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 18 Jan 2023 20:55:19 +0100
Message-ID: <CAJZ5v0gdWWmAj9JMe--wUM+Z=MZLof65hbwHCGGgWknAnw61UQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] device property: Make fwnode_graph_for_each_endpoint()
 consistent
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 4:21 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Make fwnode_graph_for_each_endpoint() consistent with the rest of
> for_each_*() definitions in the file, i.e. use the form of
>
>         for (iter = func(NULL); iter; \
>              iter = func(iter))
>
> as it's done in all the rest of the similar macro definitions.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

and I think that you need to resend it and CC Greg (who picks up
device property patches nowadays).

> ---
>  include/linux/property.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/property.h b/include/linux/property.h
> index 37179e3abad5..f090419818a2 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -436,9 +436,9 @@ fwnode_graph_get_endpoint_by_id(const struct fwnode_handle *fwnode,
>  unsigned int fwnode_graph_get_endpoint_count(struct fwnode_handle *fwnode,
>                                              unsigned long flags);
>
> -#define fwnode_graph_for_each_endpoint(fwnode, child)                  \
> -       for (child = NULL;                                              \
> -            (child = fwnode_graph_get_next_endpoint(fwnode, child)); )
> +#define fwnode_graph_for_each_endpoint(fwnode, child)                          \
> +       for (child = fwnode_graph_get_next_endpoint(fwnode, NULL); child;       \
> +            child = fwnode_graph_get_next_endpoint(fwnode, child))
>
>  int fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
>                                 struct fwnode_endpoint *endpoint);
> --
