Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5695766B854
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 08:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbjAPHlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 02:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbjAPHle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 02:41:34 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C845AC142;
        Sun, 15 Jan 2023 23:41:29 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id az20so46906509ejc.1;
        Sun, 15 Jan 2023 23:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V9xXzKXRO+NGObj3dwVimAXlD4rcXBD5shnDxRrZZuA=;
        b=qysVqxHpHhOd0B8XZacdoKyAMbMf00PMCmXmQU1jRSMF5p2Yj6ybuJbspeMYGwjCdn
         hSwqqWsVKJSJIBvCIAklSque+uAL4J7jNtLL/PTx51nSUHfRyeJS6DVmW2X+K+K4Wo4z
         TLnZ3gDKo8v7eblYIuuoUl8wfMlHojdD0+DWhWimeJWv2IfpFokx47VzO6qPLlkxrp/A
         7+cjc9i9rwBjYbMrKLYdtl7yRozC9GoKDzlIX0ZaKY/y3EM6Dq+F03+d6Go9DjlCujnL
         4uqRQQu51zybQHHVvpEHJkBFQqhKW8nT+UkN9wSYT+V7YJaJVctEN9IGSgk/z36U8QT9
         D4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V9xXzKXRO+NGObj3dwVimAXlD4rcXBD5shnDxRrZZuA=;
        b=60/EAkhjHGI3IUUs9fL2Bg5bCa/6F9IvoazbfaywCqHbIDJjyCHw8yJToVxgIbm+Nm
         WtttI74K5GJOhj3neWV5yfXA6rzVkwDHOGWI11PKx7CDTcprNDQwo3XGtEqlntiQ6t1O
         i7JbGnIU7fReF4IB6Wm/6+S0hmljFlNGXglss2i05ShdRAtB1oGwrnnPuCrQXhhuqgpb
         rLY+jxhBHXTnbUvXoZcqHtF9YQCa+N3cfJcPrItrg+FvxXGqBN8PYr7C93C1LVYt+V2z
         YqnTRkkesXdPWx5xcbWqYxK3eEjFA/I9YTv1ZWohNXDijq1n04ilK4lOAa/+rDxrV4my
         +GIA==
X-Gm-Message-State: AFqh2kr6FPlf2WnlUwWzfTGGDDBcsdztPFsPnizv6yn0KWCGWXgvBly+
        WeBuvuIRaNf02CkJcSDvj2ne8m83Gtes1jSxfCq37qOk
X-Google-Smtp-Source: AMrXdXscUiZr7v1nbWrNcDcM2BSoIPDBsHyQWjtcKuZ7ybN2TxC9BzAoZJGzm1Gm7NCREpVwGAvOgGtCDKge4ZEuEcw=
X-Received: by 2002:a17:906:f909:b0:86e:8b7b:adb0 with SMTP id
 lc9-20020a170906f90900b0086e8b7badb0mr313198ejb.130.1673854888202; Sun, 15
 Jan 2023 23:41:28 -0800 (PST)
MIME-Version: 1.0
References: <n-Xd5VZl4mxdBIPvH-LgdDqAi8N9cL3TiAQ6fKEOpXLKsyDAxcf9VWQZfnMobTdIXucJJ1U2B82W6KhoODwWr_n3d-V9YkDcV92AjzxMrys=@n8pjl.ca>
In-Reply-To: <n-Xd5VZl4mxdBIPvH-LgdDqAi8N9cL3TiAQ6fKEOpXLKsyDAxcf9VWQZfnMobTdIXucJJ1U2B82W6KhoODwWr_n3d-V9YkDcV92AjzxMrys=@n8pjl.ca>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Mon, 16 Jan 2023 08:41:17 +0100
Message-ID: <CAKXUXMyBaTdFWvguHqQDD3e1CJ9nUoQ0yO_mTL836rP9LOrf7g@mail.gmail.com>
Subject: Re: [PATCH] pcmcia: avoid defines prefixed with CONFIG
To:     peter@n8pjl.ca
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux@dominikbrodowski.net" <linux@dominikbrodowski.net>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 4:30 PM Peter Lafreniere <peter@n8pjl.ca> wrote:
>
> Macros prefixed with "CONFIG_" should be relegated to Kconfig switches,
> so we should change the config state flags to avoid conflicts.
>
> This change affects only code readability, not function.
>
> Signed-off-by: Peter Lafreniere <peter@n8pjl.ca>
> ---

Thanks for supporting the effort of the clean-up on removing CONFIG
definitions that are not Kconfig options. Those three instances are
all instances in drivers/pcmcia/ that the
./scripts/checkkconfigsymbols.py points out. So that addresses yet
another subsystem that is cleaned up. Renaming the defines is a good
solution for these three instances.

Reviewed-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Lukas

>  drivers/pcmcia/cs_internal.h     |  6 +++---
>  drivers/pcmcia/pcmcia_resource.c | 26 +++++++++++++-------------
>  2 files changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/pcmcia/cs_internal.h b/drivers/pcmcia/cs_internal.h
> index 580369f3c0b0..95df616fb0a4 100644
> --- a/drivers/pcmcia/cs_internal.h
> +++ b/drivers/pcmcia/cs_internal.h
> @@ -59,9 +59,9 @@ struct pccard_resource_ops {
>  };
>
>  /* Flags in config state */
> -#define CONFIG_LOCKED          0x01
> -#define CONFIG_IRQ_REQ         0x02
> -#define CONFIG_IO_REQ          0x04
> +#define CFG_LOCKED             0x01
> +#define CFG_IRQ_REQ            0x02
> +#define CFG_IO_REQ             0x04
>
>  /* Flags in socket state */
>  #define SOCKET_PRESENT         0x0008
> diff --git a/drivers/pcmcia/pcmcia_resource.c b/drivers/pcmcia/pcmcia_resource.c
> index d78091e79a0f..d559977b9332 100644
> --- a/drivers/pcmcia/pcmcia_resource.c
> +++ b/drivers/pcmcia/pcmcia_resource.c
> @@ -168,7 +168,7 @@ static int pcmcia_access_config(struct pcmcia_device *p_dev,
>         mutex_lock(&s->ops_mutex);
>         c = p_dev->function_config;
>
> -       if (!(c->state & CONFIG_LOCKED)) {
> +       if (!(c->state & CFG_LOCKED)) {
>                 dev_dbg(&p_dev->dev, "Configuration isn't locked\n");
>                 mutex_unlock(&s->ops_mutex);
>                 return -EACCES;
> @@ -262,7 +262,7 @@ int pcmcia_fixup_iowidth(struct pcmcia_device *p_dev)
>         dev_dbg(&p_dev->dev, "fixup iowidth to 8bit\n");
>
>         if (!(s->state & SOCKET_PRESENT) ||
> -               !(p_dev->function_config->state & CONFIG_LOCKED)) {
> +               !(p_dev->function_config->state & CFG_LOCKED)) {
>                 dev_dbg(&p_dev->dev, "No card? Config not locked?\n");
>                 ret = -EACCES;
>                 goto unlock;
> @@ -310,7 +310,7 @@ int pcmcia_fixup_vpp(struct pcmcia_device *p_dev, unsigned char new_vpp)
>         dev_dbg(&p_dev->dev, "fixup Vpp to %d\n", new_vpp);
>
>         if (!(s->state & SOCKET_PRESENT) ||
> -               !(p_dev->function_config->state & CONFIG_LOCKED)) {
> +               !(p_dev->function_config->state & CFG_LOCKED)) {
>                 dev_dbg(&p_dev->dev, "No card? Config not locked?\n");
>                 ret = -EACCES;
>                 goto unlock;
> @@ -361,9 +361,9 @@ int pcmcia_release_configuration(struct pcmcia_device *p_dev)
>                         s->ops->set_socket(s, &s->socket);
>                 }
>         }
> -       if (c->state & CONFIG_LOCKED) {
> -               c->state &= ~CONFIG_LOCKED;
> -               if (c->state & CONFIG_IO_REQ)
> +       if (c->state & CFG_LOCKED) {
> +               c->state &= ~CFG_LOCKED;
> +               if (c->state & CFG_IO_REQ)
>                         for (i = 0; i < MAX_IO_WIN; i++) {
>                                 if (!s->io[i].res)
>                                         continue;
> @@ -407,7 +407,7 @@ static void pcmcia_release_io(struct pcmcia_device *p_dev)
>                 release_io_space(s, &c->io[1]);
>
>         p_dev->_io = 0;
> -       c->state &= ~CONFIG_IO_REQ;
> +       c->state &= ~CFG_IO_REQ;
>
>  out:
>         mutex_unlock(&s->ops_mutex);
> @@ -491,7 +491,7 @@ int pcmcia_enable_device(struct pcmcia_device *p_dev)
>
>         mutex_lock(&s->ops_mutex);
>         c = p_dev->function_config;
> -       if (c->state & CONFIG_LOCKED) {
> +       if (c->state & CFG_LOCKED) {
>                 mutex_unlock(&s->ops_mutex);
>                 dev_dbg(&p_dev->dev, "Configuration is locked\n");
>                 return -EACCES;
> @@ -581,7 +581,7 @@ int pcmcia_enable_device(struct pcmcia_device *p_dev)
>         }
>
>         /* Configure I/O windows */
> -       if (c->state & CONFIG_IO_REQ) {
> +       if (c->state & CFG_IO_REQ) {
>                 iomap.speed = io_speed;
>                 for (i = 0; i < MAX_IO_WIN; i++)
>                         if (s->io[i].res) {
> @@ -602,7 +602,7 @@ int pcmcia_enable_device(struct pcmcia_device *p_dev)
>                         }
>         }
>
> -       c->state |= CONFIG_LOCKED;
> +       c->state |= CFG_LOCKED;
>         p_dev->_locked = 1;
>         mutex_unlock(&s->ops_mutex);
>         return 0;
> @@ -635,11 +635,11 @@ int pcmcia_request_io(struct pcmcia_device *p_dev)
>                 goto out;
>         }
>
> -       if (c->state & CONFIG_LOCKED) {
> +       if (c->state & CFG_LOCKED) {
>                 dev_dbg(&p_dev->dev, "Configuration is locked\n");
>                 goto out;
>         }
> -       if (c->state & CONFIG_IO_REQ) {
> +       if (c->state & CFG_IO_REQ) {
>                 dev_dbg(&p_dev->dev, "IO already configured\n");
>                 goto out;
>         }
> @@ -663,7 +663,7 @@ int pcmcia_request_io(struct pcmcia_device *p_dev)
>         } else
>                 c->io[1].start = 0;
>
> -       c->state |= CONFIG_IO_REQ;
> +       c->state |= CFG_IO_REQ;
>         p_dev->_io = 1;
>
>         dev_dbg(&p_dev->dev, "pcmcia_request_io succeeded: %pR , %pR",
> --
> 2.39.0
>
