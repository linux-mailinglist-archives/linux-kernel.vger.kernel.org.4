Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586F76640A3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 13:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238558AbjAJMhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 07:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238570AbjAJMgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 07:36:36 -0500
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF304858A
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 04:36:09 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id cf18so21867735ejb.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 04:36:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S/6AN76mYx/Ro4svLMpQwGEXQQftkRuzPsjlJhb9mcY=;
        b=qqwP+qj8EH8GtOwSd2m9nY6tby8qe5UAAoOv+JhtVkKhH+hSwL/JpfVJcMo/hEtFLT
         Vu4Klduweo+iunJx/wLOv4C5v0mmjkWcAbJBIrkUgc0FL9TxezeTc7sw7rksXAE0qBGg
         6dj2k0KRHNi93z+8LDjYyGRMXH4NjMvytC70JBl+emj+0uuBAOOcdS8nKWVraBkL5uzt
         AA8sI9TyInEvXknCIzdNjYW+54XDidjL0n7oQhvq/cRIyw5/ZvKj51fxcMKXAFG/cdfM
         mnyqIYc3Q7SVf9vJYb4yUCiUFQlsOIciwh0Ga7ms1QWyuFniQXWRKg64+YXCfkRJd5I7
         nzwg==
X-Gm-Message-State: AFqh2koPsWSI7M5QFZpHEwjW+ni+0DqZX4gNR6LCSzBPiXh2IKASdbI9
        USakez52MrBStxYtaw+EN5Hv4aeEMugN2LIIUwerfEB0uxE=
X-Google-Smtp-Source: AMrXdXuKmB8vAJsMmTkApX85ogvzgYl8HLV3v9RxtBvqTNSYkPW93CiFvB7PgGJuPVHHqVxUG2/63izO4yO0s5ktAy0=
X-Received: by 2002:a17:907:8d0e:b0:7b2:7b45:2cd2 with SMTP id
 tc14-20020a1709078d0e00b007b27b452cd2mr5924377ejc.615.1673354167961; Tue, 10
 Jan 2023 04:36:07 -0800 (PST)
MIME-Version: 1.0
References: <20230109175810.2965448-1-gregkh@linuxfoundation.org> <20230109175810.2965448-4-gregkh@linuxfoundation.org>
In-Reply-To: <20230109175810.2965448-4-gregkh@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 10 Jan 2023 13:35:56 +0100
Message-ID: <CAJZ5v0ieLfMs2ytN5qRjXBtDmSYZC7XA6ACdL11uUQCun=v4OA@mail.gmail.com>
Subject: Re: [PATCH 4/6] driver core: make subsys_dev_iter_next() static
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
> The function subsys_dev_iter_next() is only used in drivers/base/bus.c
> so make it static to that file and remove the global export.
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
> index a375305a11dd..4be73f58d0ad 100644
> --- a/drivers/base/bus.c
> +++ b/drivers/base/bus.c
> @@ -976,7 +976,7 @@ static void subsys_dev_iter_init(struct subsys_dev_iter *iter, struct bus_type *
>   * free to do whatever it wants to do with the device including
>   * calling back into subsys code.
>   */
> -struct device *subsys_dev_iter_next(struct subsys_dev_iter *iter)
> +static struct device *subsys_dev_iter_next(struct subsys_dev_iter *iter)
>  {
>         struct klist_node *knode;
>         struct device *dev;
> @@ -990,7 +990,6 @@ struct device *subsys_dev_iter_next(struct subsys_dev_iter *iter)
>                         return dev;
>         }
>  }
> -EXPORT_SYMBOL_GPL(subsys_dev_iter_next);
>
>  /**
>   * subsys_dev_iter_exit - finish iteration
> diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
> index a1da2f8647af..5a7590bc7913 100644
> --- a/include/linux/device/bus.h
> +++ b/include/linux/device/bus.h
> @@ -154,7 +154,6 @@ struct subsys_dev_iter {
>         struct klist_iter               ki;
>         const struct device_type        *type;
>  };
> -struct device *subsys_dev_iter_next(struct subsys_dev_iter *iter);
>  void subsys_dev_iter_exit(struct subsys_dev_iter *iter);
>
>  int bus_for_each_dev(struct bus_type *bus, struct device *start, void *data,
> --
> 2.39.0
>
