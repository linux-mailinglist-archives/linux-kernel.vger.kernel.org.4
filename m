Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2086717360
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 03:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233650AbjEaBwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 21:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbjEaBwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 21:52:23 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2455C12A
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 18:52:16 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5149429c944so6420392a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 18:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google; t=1685497934; x=1688089934;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0kq3x9zvWg85N0CP6ua7seTkySasfOXAnnoVUsmrbWs=;
        b=Y+5Gc3DnmpVGo4PWtG4MvbBIQvfCDQO/atHAKftbmc0cf9VJaRzlcu1uzrDowNwk+z
         3hEqbslI1EZYY4guCg4uyQnsBlFyD09aRyffYxrLfyUWQfkpEDaI9TjIba2WNyS8mAvP
         SyMLRn51d0B6fZtYXdQkkxjd0v9tzfWc9UA8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685497934; x=1688089934;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0kq3x9zvWg85N0CP6ua7seTkySasfOXAnnoVUsmrbWs=;
        b=eJWMkVZvu7TArn5qxeiJav9u0xtqP0ez9ST4FvsoJusofws59Q/kU4IHqaILSVV+q5
         lmS3r3edtvPR/kIp64Bzbv3ZWh+qfAgXYh0uEJLpOpyRG7pWrrD2QIXZaWmaGVuZe9Fu
         WAYW1Rneleyf25aqywTtJbI7UK161/65gv9rQnm2m7XePMUKC+L5ZCj3MZIWsYC1kNXx
         476JmNo2FUr33H+BkjqnTRu6ASHkuvIU5wGFP2bGLQGm5tlKrg8RRtoXNMC/BrMMQEoD
         ordgg6Metz7P73FCuWQ0gHGM0RGXieRyZ9VBXUBBvkXmueCenVpzKNf2Rd/yC9Bht2dt
         pDOA==
X-Gm-Message-State: AC+VfDwrmrmZkckYiIZYeWWz3YiweffKXh2kutOprdT0eoWd8SVN5iJO
        Es2eN6r4xI4QWXAPGDTKkeh+PiiYwLzV/VtYd8k=
X-Google-Smtp-Source: ACHHUZ7KbDL/soZoOOk0KEb6opFn2dNOkzYBihm0tKATRKH2Ky77h1iletYJP+EcKSImD63k4ghv9qBunxPj0Hg5DNQ=
X-Received: by 2002:a17:907:3da0:b0:974:1e0e:9bd3 with SMTP id
 he32-20020a1709073da000b009741e0e9bd3mr3733598ejc.23.1685497934203; Tue, 30
 May 2023 18:52:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230412185602.1592629-1-eajames@linux.ibm.com> <20230412185602.1592629-3-eajames@linux.ibm.com>
In-Reply-To: <20230412185602.1592629-3-eajames@linux.ibm.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 31 May 2023 01:52:02 +0000
Message-ID: <CACPK8Xeh=Za3b5w2KVqhQiCDjCa57poq+T8tTLgB9mwBaT7=Jg@mail.gmail.com>
Subject: Re: [PATCH 2/2] fsi: core: Add trace events for scan and unregister
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        jk@ozlabs.org, alistair@popple.id.au
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Apr 2023 at 18:56, Eddie James <eajames@linux.ibm.com> wrote:
>
> Add more trace events for the scanning and unregistration
> functions for debug purposes.
>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  drivers/fsi/fsi-core.c     |  4 ++++
>  include/trace/events/fsi.h | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 35 insertions(+)
>
> diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
> index 18d4d68482d7..2dc119ab073c 100644
> --- a/drivers/fsi/fsi-core.c
> +++ b/drivers/fsi/fsi-core.c
> @@ -1220,6 +1220,7 @@ static int fsi_master_scan(struct fsi_master *master)
>  {
>         int link, rc;
>
> +       trace_fsi_master_scan(master, true);
>         for (link = 0; link < master->n_links; link++) {
>                 rc = fsi_master_link_enable(master, link);
>                 if (rc) {
> @@ -1261,6 +1262,7 @@ static int fsi_master_remove_slave(struct device *dev, void *arg)
>
>  static void fsi_master_unscan(struct fsi_master *master)
>  {
> +       trace_fsi_master_scan(master, false);
>         device_for_each_child(&master->dev, NULL, fsi_master_remove_slave);
>  }
>
> @@ -1355,6 +1357,8 @@ EXPORT_SYMBOL_GPL(fsi_master_register);
>  void fsi_master_unregister(struct fsi_master *master)
>  {
>         mutex_lock(&master->scan_lock);
> +       trace_fsi_master_unregister(master);
> +
>         if (master->idx >= 0) {
>                 ida_simple_remove(&master_ida, master->idx);
>                 master->idx = -1;
> diff --git a/include/trace/events/fsi.h b/include/trace/events/fsi.h
> index c9a72e8432b8..5ff15126ad9d 100644
> --- a/include/trace/events/fsi.h
> +++ b/include/trace/events/fsi.h
> @@ -122,6 +122,37 @@ TRACE_EVENT(fsi_master_break,
>         )
>  );
>
> +TRACE_EVENT(fsi_master_scan,
> +       TP_PROTO(const struct fsi_master *master, bool scan),
> +       TP_ARGS(master, scan),
> +       TP_STRUCT__entry(
> +               __field(int,    master_idx)
> +               __field(int,    n_links)
> +               __field(bool,   scan)
> +       ),
> +       TP_fast_assign(
> +               __entry->master_idx = master->idx;
> +               __entry->n_links = master->n_links;
> +               __entry->scan = scan;
> +       ),
> +       TP_printk("fsi%d (%d links) %s", __entry->master_idx, __entry->n_links,
> +                 __entry->scan ? "scan" : "unscan")
> +);
> +
> +TRACE_EVENT(fsi_master_unregister,
> +       TP_PROTO(const struct fsi_master *master),
> +       TP_ARGS(master),
> +       TP_STRUCT__entry(
> +               __field(int,    master_idx)
> +               __field(int,    n_links)
> +       ),
> +       TP_fast_assign(
> +               __entry->master_idx = master->idx;
> +               __entry->n_links = master->n_links;
> +       ),
> +       TP_printk("fsi%d (%d links)", __entry->master_idx, __entry->n_links)
> +);
> +
>  TRACE_EVENT(fsi_slave_init,
>         TP_PROTO(const struct fsi_slave *slave),
>         TP_ARGS(slave),
> --
> 2.31.1
>
