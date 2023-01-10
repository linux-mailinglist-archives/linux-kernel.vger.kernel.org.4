Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA5B66409B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 13:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238542AbjAJMfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 07:35:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238465AbjAJMfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 07:35:16 -0500
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6983D9EC
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 04:35:07 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id v6so17279603edd.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 04:35:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kskJGwsWk6CSrMTpuucDbOAsrmAF8JgY2c4LCkoUG0s=;
        b=6ivdmlU5cg+Vcc0ak5UdfZyYlSholrslnUd+6zXDrLFQ6H8NuZHuERf1Y56QDZpDzU
         yqzRSDNMX9Gl9yIOGj9mRkjNfZr+X/VwAstpIk7HTUZZN2IsBDHyS+RdYfXoZFZuYkIT
         omNONnhykVP73ldtD/Eq3S3s6KiW4C/IEBYiAfSbuf+xRm8aBOWIVX+AKE3khI088xog
         3/isF/xdVvx1wA5sq13P5owk2SLN7LXnUrKleXB4Y+kSJx89u+JGeSVGnz7TfOMJItRz
         37kYCtFn97nYMEA4bMd1BldkU1zUem8EP2LAoqLFWhNOHpa1t5nj0q+im5u7ib3a4B9C
         nJxw==
X-Gm-Message-State: AFqh2komHEE5Wu0+GinVTJH4DtaBqq/zrR2vNFkIcz9ioHjPUrbzEhAa
        YdULT5aYwcawmJmPnHlcrAeSL4NK6DadZaJfAUk=
X-Google-Smtp-Source: AMrXdXvkEZMHwhN83BWBCxWEwkkcCWqFc0c+6XU4RzrC1iiarWKnHfl8MoKN9MXuvxY4xiw+f9CL5UOD0mY3GxseTMI=
X-Received: by 2002:a05:6402:5c5:b0:46d:53d7:d1f6 with SMTP id
 n5-20020a05640205c500b0046d53d7d1f6mr6960519edx.211.1673354106030; Tue, 10
 Jan 2023 04:35:06 -0800 (PST)
MIME-Version: 1.0
References: <20230109175810.2965448-1-gregkh@linuxfoundation.org> <20230109175810.2965448-2-gregkh@linuxfoundation.org>
In-Reply-To: <20230109175810.2965448-2-gregkh@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 10 Jan 2023 13:34:54 +0100
Message-ID: <CAJZ5v0jje=ys4uMSFJ44fyac3GcgkU8wL+wQ2pdjX-+iJjd9iQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] driver core: remove subsys_find_device_by_id()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 9, 2023 at 6:58 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This function has not been called by any code in the kernel tree in many
> many years so remove it as it is unused.
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  drivers/base/bus.c         | 41 --------------------------------------
>  include/linux/device/bus.h |  2 --
>  2 files changed, 43 deletions(-)
>
> diff --git a/drivers/base/bus.c b/drivers/base/bus.c
> index 4e6fdb65a157..45aa8d996f0a 100644
> --- a/drivers/base/bus.c
> +++ b/drivers/base/bus.c
> @@ -363,47 +363,6 @@ struct device *bus_find_device(struct bus_type *bus,
>  }
>  EXPORT_SYMBOL_GPL(bus_find_device);
>
> -/**
> - * subsys_find_device_by_id - find a device with a specific enumeration number
> - * @subsys: subsystem
> - * @id: index 'id' in struct device
> - * @hint: device to check first
> - *
> - * Check the hint's next object and if it is a match return it directly,
> - * otherwise, fall back to a full list search. Either way a reference for
> - * the returned object is taken.
> - */
> -struct device *subsys_find_device_by_id(struct bus_type *subsys, unsigned int id,
> -                                       struct device *hint)
> -{
> -       struct klist_iter i;
> -       struct device *dev;
> -
> -       if (!subsys)
> -               return NULL;
> -
> -       if (hint) {
> -               klist_iter_init_node(&subsys->p->klist_devices, &i, &hint->p->knode_bus);
> -               dev = next_device(&i);
> -               if (dev && dev->id == id && get_device(dev)) {
> -                       klist_iter_exit(&i);
> -                       return dev;
> -               }
> -               klist_iter_exit(&i);
> -       }
> -
> -       klist_iter_init_node(&subsys->p->klist_devices, &i, NULL);
> -       while ((dev = next_device(&i))) {
> -               if (dev->id == id && get_device(dev)) {
> -                       klist_iter_exit(&i);
> -                       return dev;
> -               }
> -       }
> -       klist_iter_exit(&i);
> -       return NULL;
> -}
> -EXPORT_SYMBOL_GPL(subsys_find_device_by_id);
> -
>  static struct device_driver *next_driver(struct klist_iter *i)
>  {
>         struct klist_node *n = klist_next(i);
> diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
> index 0699b3970344..d865440d8c02 100644
> --- a/include/linux/device/bus.h
> +++ b/include/linux/device/bus.h
> @@ -250,8 +250,6 @@ bus_find_device_by_acpi_dev(struct bus_type *bus, const void *adev)
>  }
>  #endif
>
> -struct device *subsys_find_device_by_id(struct bus_type *bus, unsigned int id,
> -                                       struct device *hint);
>  int bus_for_each_drv(struct bus_type *bus, struct device_driver *start,
>                      void *data, int (*fn)(struct device_driver *, void *));
>  void bus_sort_breadthfirst(struct bus_type *bus,
> --
> 2.39.0
>
