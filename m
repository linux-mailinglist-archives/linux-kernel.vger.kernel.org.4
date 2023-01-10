Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592ED664090
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 13:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238363AbjAJMeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 07:34:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbjAJMeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 07:34:02 -0500
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAAC17061
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 04:34:00 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id jo4so28211176ejb.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 04:34:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p11xjHDGcN1z2sNc7CIMkepZaYOPFjolrt2Rg/QUmPA=;
        b=yJohtjZ4NnrIDQsNDLVJg2qFKBWmzga9rnTIKY2jp6BOwofx/PEmcgNhzhPh/XexVD
         kDBa4Xy9/m/q6J5APPqQlC9tS2Wkjib3pxyq9wtRLr0QxX38uhgYmsIX3mWDY85rocZG
         C+FNhd0QcAqDBjRdtXEk9SufcI8+oDjq38M8J0fdIcSFQtY52YGZV1yI0LlWBydXzziZ
         icsfC3hxzlvHFQpVHT8+ITjhe4DTMymwd6h7Qry4BqzAX5YqiSeK5FC5aR0zzb4QWVSA
         ujpXQStNCnpiNC17sX9eQjWzvR0hhV6pfbiLrT3HHgydqJ+znrLUZq1Jg5XKgrQuQ9g0
         1YUA==
X-Gm-Message-State: AFqh2kq3owwQqvi4NC5pN5cGfMwErIbPjff68KdhYr6/pNTaE+BrqTRJ
        +1d+eEMtIEzMg54vXWnPEgYnETiN1iwPz0J+gQt6JML3KO0=
X-Google-Smtp-Source: AMrXdXtXZAnjkd7wBaLkBHED7txQL4kfj50yErDYeDq2U6bK7nREfhKQzkmxcWdKx3bcIzOEE5WRvh00j8++WPKgOdo=
X-Received: by 2002:a17:906:9484:b0:84d:3c6a:4c55 with SMTP id
 t4-20020a170906948400b0084d3c6a4c55mr1264636ejx.509.1673354039092; Tue, 10
 Jan 2023 04:33:59 -0800 (PST)
MIME-Version: 1.0
References: <20230109175810.2965448-1-gregkh@linuxfoundation.org>
In-Reply-To: <20230109175810.2965448-1-gregkh@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 10 Jan 2023 13:33:48 +0100
Message-ID: <CAJZ5v0j7mbvcRWy=Ek00rbfNpsaRb6oGKqC3OaZ+OcASRZt8bg@mail.gmail.com>
Subject: Re: [PATCH 1/6] driver core: make bus_get_device_klist() static
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
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

On Mon, Jan 9, 2023 at 6:58 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> No one calls this function outside of drivers/base/bus.c so make it
> static so it does not need to be exported anymore.
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  drivers/base/bus.c         | 3 +--
>  include/linux/device/bus.h | 1 -
>  2 files changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/base/bus.c b/drivers/base/bus.c
> index e1bf741063e0..4e6fdb65a157 100644
> --- a/drivers/base/bus.c
> +++ b/drivers/base/bus.c
> @@ -927,11 +927,10 @@ struct kset *bus_get_kset(struct bus_type *bus)
>  }
>  EXPORT_SYMBOL_GPL(bus_get_kset);
>
> -struct klist *bus_get_device_klist(struct bus_type *bus)
> +static struct klist *bus_get_device_klist(struct bus_type *bus)
>  {
>         return &bus->p->klist_devices;
>  }
> -EXPORT_SYMBOL_GPL(bus_get_device_klist);
>
>  /*
>   * Yes, this forcibly breaks the klist abstraction temporarily.  It
> diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
> index f2cf7c4ddd20..0699b3970344 100644
> --- a/include/linux/device/bus.h
> +++ b/include/linux/device/bus.h
> @@ -287,6 +287,5 @@ extern int bus_unregister_notifier(struct bus_type *bus,
>  #define BUS_NOTIFY_DRIVER_NOT_BOUND    0x00000008 /* driver fails to be bound */
>
>  extern struct kset *bus_get_kset(struct bus_type *bus);
> -extern struct klist *bus_get_device_klist(struct bus_type *bus);
>
>  #endif
> --
> 2.39.0
>
