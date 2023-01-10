Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D401466409E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 13:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238550AbjAJMgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 07:36:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238482AbjAJMfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 07:35:55 -0500
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BB848CFA
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 04:35:44 -0800 (PST)
Received: by mail-ej1-f52.google.com with SMTP id hw16so16328963ejc.10
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 04:35:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G6faOsm8D/gSJvUuMAxV0VWp2nUOjD0+Qv1S3t6V1WU=;
        b=AsJUDGTlcNPRx4RT3gI0N7wbsnSmgv5d/cLXaclKYRH45XG1udJH5jzbnyYBhHwzwY
         xw6v2cQ56SiIsRNA/tGyTWaQ4buiOtbgzS54cEkWeo8TpN7PdvNwHRuWO0jKc6iiXNUQ
         pX/tYKYb6hqR4XSIYcaPgbGhhrba4029MiisIt6cUw6mjNZ0O1/LbQWrVW9YDdH8XXr+
         r8AnYR/Fv6n6zGkfKVSmhS+3Xhv7IVcnV41ux20ZhQFkabxMvIQZ+g/hldFcvrm9rOLY
         V4qLhaiwcNCbwWakl64LSGoGfYxUwFmiOmuHzfCZmdGMN8NsevLzrC2s/XW42xj6qScr
         8Kwg==
X-Gm-Message-State: AFqh2kp5kS1Quqh7Z0OSlOGKcU7R0PeuQORZnmB8t/oPRCBLi5t39GjQ
        ASZQtjn98W/a/sJHtS30TU31NTkfAgZocAtgZdMSEk3nNvM=
X-Google-Smtp-Source: AMrXdXu3xeY3Y2Pr63q2b9eIrTNx0K9LQ0TXcxHMqgYVJVo09qhQd3D371vkW6oOc8Rx6UAaoxs0hr9T8J7c98R5EXM=
X-Received: by 2002:a17:907:98ee:b0:7c1:5ff0:6cc2 with SMTP id
 ke14-20020a17090798ee00b007c15ff06cc2mr4914363ejc.246.1673354142951; Tue, 10
 Jan 2023 04:35:42 -0800 (PST)
MIME-Version: 1.0
References: <20230109175810.2965448-1-gregkh@linuxfoundation.org> <20230109175810.2965448-3-gregkh@linuxfoundation.org>
In-Reply-To: <20230109175810.2965448-3-gregkh@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 10 Jan 2023 13:35:31 +0100
Message-ID: <CAJZ5v0hX7r3MDvmHz_PF5My3tweP56GZmUP_dim3tw8eEUthBw@mail.gmail.com>
Subject: Re: [PATCH 3/6] driver core: make subsys_dev_iter_init() static
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
> No one outside of drivers/base/bus.c calls this function so make it
> static and remove the exported symbol.
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  drivers/base/bus.c         | 5 ++---
>  include/linux/device/bus.h | 4 ----
>  2 files changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/base/bus.c b/drivers/base/bus.c
> index 45aa8d996f0a..a375305a11dd 100644
> --- a/drivers/base/bus.c
> +++ b/drivers/base/bus.c
> @@ -953,8 +953,8 @@ EXPORT_SYMBOL_GPL(bus_sort_breadthfirst);
>   * otherwise if it is NULL, the iteration starts at the beginning of
>   * the list.
>   */
> -void subsys_dev_iter_init(struct subsys_dev_iter *iter, struct bus_type *subsys,
> -                         struct device *start, const struct device_type *type)
> +static void subsys_dev_iter_init(struct subsys_dev_iter *iter, struct bus_type *subsys,
> +                                struct device *start, const struct device_type *type)
>  {
>         struct klist_node *start_knode = NULL;
>
> @@ -963,7 +963,6 @@ void subsys_dev_iter_init(struct subsys_dev_iter *iter, struct bus_type *subsys,
>         klist_iter_init_node(&subsys->p->klist_devices, &iter->ki, start_knode);
>         iter->type = type;
>  }
> -EXPORT_SYMBOL_GPL(subsys_dev_iter_init);
>
>  /**
>   * subsys_dev_iter_next - iterate to the next device
> diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
> index d865440d8c02..a1da2f8647af 100644
> --- a/include/linux/device/bus.h
> +++ b/include/linux/device/bus.h
> @@ -154,10 +154,6 @@ struct subsys_dev_iter {
>         struct klist_iter               ki;
>         const struct device_type        *type;
>  };
> -void subsys_dev_iter_init(struct subsys_dev_iter *iter,
> -                        struct bus_type *subsys,
> -                        struct device *start,
> -                        const struct device_type *type);
>  struct device *subsys_dev_iter_next(struct subsys_dev_iter *iter);
>  void subsys_dev_iter_exit(struct subsys_dev_iter *iter);
>
> --
> 2.39.0
>
