Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8DF0669351
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 10:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240987AbjAMJw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 04:52:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240988AbjAMJv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 04:51:59 -0500
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEC33AAB7;
        Fri, 13 Jan 2023 01:46:19 -0800 (PST)
Received: by mail-ej1-f50.google.com with SMTP id ss4so43760554ejb.11;
        Fri, 13 Jan 2023 01:46:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jLI7E18nq2NI0CRNNCvmAghIfM0C0xJwAK1q64EV0cA=;
        b=gRm7TgaeZsD25AJRra5g81mwll6LjAFXZai0wulpFo9Qee43u/N1JBHa2ZKRI6dQEb
         wGnXnEh2rpCQ5zgJc0CJoAek+S2ZqdkBZ9nfu0LgWtw+TkxZ1RUouK5nTsHJu6+W68jv
         VVqdkYnjrJMVThAzWlIx4P216UhMaNYs8pPn/+uLQQyaa8dHqhZ4FgRIf8ndf8rwIwOw
         oSQzZb+QMSuGemlnry8C3Q9ljT9VCcdNFaoRa+OXNe6sZ14rNZPcwbvefGngTbyg1HWu
         aHcygAXHcuEW79PKj8oQas5UYfE1whmQOg5N6Q7lTw0J9KYoXJHbWuGSOLOpcwW69gre
         L5qw==
X-Gm-Message-State: AFqh2kq5s7Sa9PK8FHmO6+m7jyGd72BMTUGHICZ9zehGSRLBukypI5zN
        4ZJbYrVgcFwGFCVf1dQoT16faYeoC2S7k0JlKIY=
X-Google-Smtp-Source: AMrXdXsTUDwFT6STEAFjHKpztlFtilSPG/b2RMjFC+hvEcjuYWB5klvDRR6SSG7yE55p2jbEYoefPpLJP/3AzGXpS4w=
X-Received: by 2002:a17:907:c203:b0:867:77a9:db77 with SMTP id
 ti3-20020a170907c20300b0086777a9db77mr536071ejc.209.1673603178410; Fri, 13
 Jan 2023 01:46:18 -0800 (PST)
MIME-Version: 1.0
References: <20230113001103.GA3374173@paulmck-ThinkPad-P17-Gen-1> <20230113001132.3375334-2-paulmck@kernel.org>
In-Reply-To: <20230113001132.3375334-2-paulmck@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 13 Jan 2023 10:46:06 +0100
Message-ID: <CAJZ5v0gX9aseKnx1YOS_+=qtNGyM81qC2NjmdC1N0eMr=QaVZw@mail.gmail.com>
Subject: Re: [PATCH rcu v2 02/20] drivers/base: Remove CONFIG_SRCU
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        John Ogness <john.ogness@linutronix.de>
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

On Fri, Jan 13, 2023 at 1:11 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> Now that the SRCU Kconfig option is unconditionally selected, there is
> no longer any point in conditional compilation based on CONFIG_SRCU.
> Therefore, remove the #ifdef and throw away the #else clause.
>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: John Ogness <john.ogness@linutronix.de>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  drivers/base/core.c | 42 ------------------------------------------
>  1 file changed, 42 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index a3e14143ec0cf..bb36aca8d1b7a 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -181,7 +181,6 @@ void fw_devlink_purge_absent_suppliers(struct fwnode_handle *fwnode)
>  }
>  EXPORT_SYMBOL_GPL(fw_devlink_purge_absent_suppliers);
>
> -#ifdef CONFIG_SRCU
>  static DEFINE_MUTEX(device_links_lock);
>  DEFINE_STATIC_SRCU(device_links_srcu);
>
> @@ -220,47 +219,6 @@ static void device_link_remove_from_lists(struct device_link *link)
>         list_del_rcu(&link->s_node);
>         list_del_rcu(&link->c_node);
>  }
> -#else /* !CONFIG_SRCU */
> -static DECLARE_RWSEM(device_links_lock);
> -
> -static inline void device_links_write_lock(void)
> -{
> -       down_write(&device_links_lock);
> -}
> -
> -static inline void device_links_write_unlock(void)
> -{
> -       up_write(&device_links_lock);
> -}
> -
> -int device_links_read_lock(void)
> -{
> -       down_read(&device_links_lock);
> -       return 0;
> -}
> -
> -void device_links_read_unlock(int not_used)
> -{
> -       up_read(&device_links_lock);
> -}
> -
> -#ifdef CONFIG_DEBUG_LOCK_ALLOC
> -int device_links_read_lock_held(void)
> -{
> -       return lockdep_is_held(&device_links_lock);
> -}
> -#endif
> -
> -static inline void device_link_synchronize_removal(void)
> -{
> -}
> -
> -static void device_link_remove_from_lists(struct device_link *link)
> -{
> -       list_del(&link->s_node);
> -       list_del(&link->c_node);
> -}
> -#endif /* !CONFIG_SRCU */
>
>  static bool device_is_ancestor(struct device *dev, struct device *target)
>  {
> --
> 2.31.1.189.g2e36527f23
>
