Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A247565EFAF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 16:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234509AbjAEPJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 10:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233578AbjAEPJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 10:09:09 -0500
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32EF75470B;
        Thu,  5 Jan 2023 07:08:55 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id fc4so90620986ejc.12;
        Thu, 05 Jan 2023 07:08:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=36CCpGE0tQutyayspxRUrB05I7UyYFsz1J6g+3NJKUo=;
        b=PHGpfuH0XzEzVrMmEXModtuME+o3Gb1JpHu9gElF2H6awghGY5ha5oG5cjOdW3yjYI
         0UXf8adSGsv2VqD47ZPLfCGu+6eEJq+WnUYP4Fh0jOBp53ULCEV2KkhyqqqI2JwHHUm9
         2iWsMtnLUpn1D7ZbTpq8PlqW5G7zerjzCt3JSnBESTuMAJOm9NXgoicTaV7GruxIww7O
         8TMVIHLSkBko3LCCytC+FIYgF7mkt9hbguoacKQZEfuKEAUsW3i1YQkAeqhi8OctvGs/
         M+w7APcJbHQNwpnM/Cofs665BcYlRz0ywlmRP8AyHWn5wjzKVyuLl/d8SDxkYEV1PT8H
         TSRw==
X-Gm-Message-State: AFqh2kpPNAhxHzFoeMiCYy97a25i1imNcAXdsfylXor2MLf8l3pNesxO
        pBzZ8LGib2Zj4HQZNoKm4jqcewLzeLvcEkQBsjA=
X-Google-Smtp-Source: AMrXdXufVF+71X+TU8G1ZdZARn8knKHzDIjlhvmceks/zWdynuK4QkKAP/GQtALIoT6Lg4ejLsUs+I4lRuCNxKEyyJA=
X-Received: by 2002:a17:906:bce8:b0:7c4:fe2d:afd3 with SMTP id
 op8-20020a170906bce800b007c4fe2dafd3mr3318250ejb.390.1672931333824; Thu, 05
 Jan 2023 07:08:53 -0800 (PST)
MIME-Version: 1.0
References: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1> <20230105003813.1770367-23-paulmck@kernel.org>
In-Reply-To: <20230105003813.1770367-23-paulmck@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 5 Jan 2023 16:08:39 +0100
Message-ID: <CAJZ5v0iiDTR=9cF3epdPxPYbVVV5oz+M6tL7egd_RwKywzUkLw@mail.gmail.com>
Subject: Re: [PATCH rcu 23/27] kernel/power: Remove "select SRCU"
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 5, 2023 at 1:38 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> Now that the SRCU Kconfig option is unconditionally selected, there is
> no longer any point in selecting it.  Therefore, remove the "select SRCU"
> Kconfig statements.
>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: <linux-pm@vger.kernel.org>

Acked-by: "Rafael J. Wysocki" <rafael@kernel.org>

> ---
>  kernel/power/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> index 60a1d3051cc79..4b31629c5be4b 100644
> --- a/kernel/power/Kconfig
> +++ b/kernel/power/Kconfig
> @@ -118,7 +118,6 @@ config PM_SLEEP
>         def_bool y
>         depends on SUSPEND || HIBERNATE_CALLBACKS
>         select PM
> -       select SRCU
>
>  config PM_SLEEP_SMP
>         def_bool y
> --
> 2.31.1.189.g2e36527f23
>
