Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D53D6640A5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 13:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238458AbjAJMhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 07:37:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238482AbjAJMg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 07:36:59 -0500
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C6358323
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 04:36:57 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id j16so17307040edw.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 04:36:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jdu1P19gxZfQlt5gE6MTJd2DGIzjOpSeua0YK3b5Xio=;
        b=Bh5z4nXo/6NArnnukbIhOSAT5i7e5b1VoEC0sLw7oO7pqGaUraj0sCRYOZ3oZvEtwI
         CpD1FA6LgayPT2CmNt6DFimrxLJJGwOv6j0a4cMC8wyO3m+W5qdxUEeQ/NbpeY5xifl8
         wUbB+hqQrFL7KUmf1YDMRj9ed5jaGwrX5xeof4G62oDyAI+LhXd62xxxUmKxEk7P6xAL
         rgbMWc2YSnP6izJVEKCvxKn+Jexni2V+811+1it44QYxL+8G8Xh+fxydwfYsy1lP3Yca
         bGLCCcS/RdhMQK5eGUMlbmCneurTk1FaI2ukThwls/X5DgNUiMQ08wCkKkePTGfkBYJB
         foVw==
X-Gm-Message-State: AFqh2krtEOJXoYmGlksW87up9eLa6mA6RWU6u0mUKijDYAg/Wvzho5gl
        DXXsFFjOonh1EraetoA3xdftuLs+J6pTE+K3yD0=
X-Google-Smtp-Source: AMrXdXvCwkP3VeOFq2P7qpfPto6JkhbqHzjUh5GgZmWPKUm/jgFyq0MBWecokCG0szh9Ee/+vId4BM640M+TSOSmeVk=
X-Received: by 2002:a05:6402:c44:b0:499:c651:625d with SMTP id
 cs4-20020a0564020c4400b00499c651625dmr251194edb.413.1673354216214; Tue, 10
 Jan 2023 04:36:56 -0800 (PST)
MIME-Version: 1.0
References: <20230109175810.2965448-1-gregkh@linuxfoundation.org> <20230109175810.2965448-5-gregkh@linuxfoundation.org>
In-Reply-To: <20230109175810.2965448-5-gregkh@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 10 Jan 2023 13:36:45 +0100
Message-ID: <CAJZ5v0iELAMo9E7o4V5rjE-2v0-oNRUz=PSTO+A=91Dtb2LyYw@mail.gmail.com>
Subject: Re: [PATCH 5/6] driver core: make subsys_dev_iter_exit() static
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
> The function subsys_dev_iter_exit() is not used outside of
> drivers/base/bus.c so make it static to that file and remove the global
> export.
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
> index 4be73f58d0ad..e0fe07872a74 100644
> --- a/drivers/base/bus.c
> +++ b/drivers/base/bus.c
> @@ -998,11 +998,10 @@ static struct device *subsys_dev_iter_next(struct subsys_dev_iter *iter)
>   * Finish an iteration.  Always call this function after iteration is
>   * complete whether the iteration ran till the end or not.
>   */
> -void subsys_dev_iter_exit(struct subsys_dev_iter *iter)
> +static void subsys_dev_iter_exit(struct subsys_dev_iter *iter)
>  {
>         klist_iter_exit(&iter->ki);
>  }
> -EXPORT_SYMBOL_GPL(subsys_dev_iter_exit);
>
>  int subsys_interface_register(struct subsys_interface *sif)
>  {
> diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
> index 5a7590bc7913..ffa562f2d975 100644
> --- a/include/linux/device/bus.h
> +++ b/include/linux/device/bus.h
> @@ -154,7 +154,6 @@ struct subsys_dev_iter {
>         struct klist_iter               ki;
>         const struct device_type        *type;
>  };
> -void subsys_dev_iter_exit(struct subsys_dev_iter *iter);
>
>  int bus_for_each_dev(struct bus_type *bus, struct device *start, void *data,
>                      int (*fn)(struct device *dev, void *data));
> --
> 2.39.0
>
