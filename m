Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D1F66585F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 10:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjAKJ7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 04:59:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238765AbjAKJ6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 04:58:24 -0500
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B79C120B3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 01:55:09 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id u19so35386439ejm.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 01:55:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uyLw+0OLYyN4uoIdtLVbUt1eZhkop5g4Dw980KT9BTY=;
        b=FGVX2iWLc918zAw8eg98Ara5LFm+Fa10spioeUCNDZfbbrNVib6jPXAqsbHcW4yiEU
         V8BvKVcT6f/fuRPqyfULhXx0l5H9QVfidrmaPU/69IJh08z3VvkrACtjhsZ68p70ABQw
         14kgvA+XXT7k2HtL5r5PXmjtSYuTyn8VL60Bv1O83nkWR7y+vT72+WeUfbL8EW96EQXy
         31xX73KVkglR2tw8HXccTCfk7pGvw7DF/GOKkIW/JrYJ+S/FFmj/l7dA5Wwf1aX6Nz4b
         8AgPLQp6FEgBlDen4EU3MY8r9s/IQfqiES7lNKa8RJl6WyOnZs1fOI1tYjd7560xFxGx
         eHwg==
X-Gm-Message-State: AFqh2ko6ASmgGqzHxjS7ZsFwck1DxzHSicjzwPP80SJtS496tsRStu4W
        q56qXTFq3GYerfFkXlzXjsKUmGhm+j1N6wQtB6g=
X-Google-Smtp-Source: AMrXdXuVkHaSi7bkqpcbMUgfBacpRoP5G36tZ6MDdAOhCIX1SlTf1GLpX9ZIRODM7BVv6FkJfVtw/ThUf2ykZvF8pkg=
X-Received: by 2002:a17:906:9484:b0:84d:3c6a:4c55 with SMTP id
 t4-20020a170906948400b0084d3c6a4c55mr1762789ejx.509.1673430907900; Wed, 11
 Jan 2023 01:55:07 -0800 (PST)
MIME-Version: 1.0
References: <20230111092331.3946745-1-gregkh@linuxfoundation.org>
In-Reply-To: <20230111092331.3946745-1-gregkh@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 11 Jan 2023 10:54:55 +0100
Message-ID: <CAJZ5v0hOOeGBKiOpnsQSm=CKum-JEASmygKXrU76WK7gynVdKw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] driver core: bus.h: document bus notifiers better
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 10:23 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> The bus notifier values are not documented all that well, so clean this
> up and make a real enumerated type for them and document them much
> better.  When doing this, remove the hex values and just rely on the
> enumerated type instead as that is all that is needed.
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Randy Dunlap <rdunlap@infradead.org>

I would add a Co-developed-by for Randy along with his sign-off (which
was given IIRC).

Anyway

Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>

> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> v3: - fix up the documentation to be proper kernel-doc format thanks to
>       Randy.
>     - Remove the values entirely now that this is an enumerated type,
>       they are not needed.
>
> v2: - move the values to decimal from hex as pointed out by Rafael.
>
>  include/linux/device/bus.h | 42 +++++++++++++++++++++++++-------------
>  1 file changed, 28 insertions(+), 14 deletions(-)
>
> diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
> index d529f644e92b..7b4a48b5159b 100644
> --- a/include/linux/device/bus.h
> +++ b/include/linux/device/bus.h
> @@ -257,21 +257,35 @@ extern int bus_register_notifier(struct bus_type *bus,
>  extern int bus_unregister_notifier(struct bus_type *bus,
>                                    struct notifier_block *nb);
>
> -/* All 4 notifers below get called with the target struct device *
> - * as an argument. Note that those functions are likely to be called
> - * with the device lock held in the core, so be careful.
> +/**
> + * enum bus_notifier_event - Bus Notifier events that have happened
> + * @BUS_NOTIFY_ADD_DEVICE: device is added to this bus
> + * @BUS_NOTIFY_DEL_DEVICE: device is about to be removed from this bus
> + * @BUS_NOTIFY_REMOVED_DEVICE: device is successfully removed from this bus
> + * @BUS_NOTIFY_BIND_DRIVER: a driver is about to be bound to this device on this bus
> + * @BUS_NOTIFY_BOUND_DRIVER: a driver is successfully bound to this device on this bus
> + * @BUS_NOTIFY_UNBIND_DRIVER: a driver is about to be unbound from this device on this bus
> + * @BUS_NOTIFY_UNBOUND_DRIVER: a driver is successfully unbound from this device on this bus
> + * @BUS_NOTIFY_DRIVER_NOT_BOUND: a driver failed to be bound to this device on this bus
> + *
> + * These are the value passed to a bus notifier when a specific event happens.
> + *
> + * Note that bus notifiers are likely to be called with the device lock already
> + * held by the driver core, so be careful in any notifier callback as to what
> + * you do with the device structure.
> + *
> + * All bus notifiers are called with the target struct device * as an argument.
>   */
> -#define BUS_NOTIFY_ADD_DEVICE          0x00000001 /* device added */
> -#define BUS_NOTIFY_DEL_DEVICE          0x00000002 /* device to be removed */
> -#define BUS_NOTIFY_REMOVED_DEVICE      0x00000003 /* device removed */
> -#define BUS_NOTIFY_BIND_DRIVER         0x00000004 /* driver about to be
> -                                                     bound */
> -#define BUS_NOTIFY_BOUND_DRIVER                0x00000005 /* driver bound to device */
> -#define BUS_NOTIFY_UNBIND_DRIVER       0x00000006 /* driver about to be
> -                                                     unbound */
> -#define BUS_NOTIFY_UNBOUND_DRIVER      0x00000007 /* driver is unbound
> -                                                     from the device */
> -#define BUS_NOTIFY_DRIVER_NOT_BOUND    0x00000008 /* driver fails to be bound */
> +enum bus_notifier_event {
> +       BUS_NOTIFY_ADD_DEVICE,
> +       BUS_NOTIFY_DEL_DEVICE,
> +       BUS_NOTIFY_REMOVED_DEVICE,
> +       BUS_NOTIFY_BIND_DRIVER,
> +       BUS_NOTIFY_BOUND_DRIVER,
> +       BUS_NOTIFY_UNBIND_DRIVER,
> +       BUS_NOTIFY_UNBOUND_DRIVER,
> +       BUS_NOTIFY_DRIVER_NOT_BOUND,
> +};
>
>  extern struct kset *bus_get_kset(struct bus_type *bus);
>
> --
> 2.39.0
>
