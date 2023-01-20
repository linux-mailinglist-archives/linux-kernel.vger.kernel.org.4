Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D684675A91
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjATQ4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjATQ4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:56:07 -0500
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA437B2EA;
        Fri, 20 Jan 2023 08:55:33 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id mg12so15499427ejc.5;
        Fri, 20 Jan 2023 08:55:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9m2NFPSTNnzbZ6uoQzeQe+dPEOJYdnmvCnlxt5htzBY=;
        b=7pRzDJIPD7TXT2dXMGXvnL7cGFHaa+7wIksxMWVMlO+9rnPc4d9W2HiDmZU8RcVwFZ
         lhdO8HhFEo1hGTW5pPVMgZCimvJBUKPU8/TQ/eIOhVCFJNhfahVh2bwE68GG9zSA2lFG
         AoPtx2YlqcWGz3MfqcuJJLlAQh86ElL8KgLe5f8QQOyn468n2mMI1w4XuDbWv7Mx6j5/
         GUhn630TGqPV8jTdwjhI7aenryO0MTT5OisTVNNsWop9NVgbphvTUB6upeRfRgr+gDoY
         Xh1vSc8HB4ZKk+xcaC/bsJ6kkBKiDgOffZkDXMJIq/WH140gZIEtmHzJFEpCfvcrohjp
         eBzQ==
X-Gm-Message-State: AFqh2kqgSI2QYnO+BKCA4yqkm8YPNUt0HI5kMCfZTXD5nEfFM5+zxXIt
        8xq61iV9O/mAm5TpBvPP2e/3oVu6VHXZacvRfn8=
X-Google-Smtp-Source: AMrXdXvDOE6HlqspQEUNRnN4d/uMbmudFtV/inUv2YbDlb4+YLsxba5iDHoVSZUuc0jyAOgUYFvvuMt74P4miet8h6g=
X-Received: by 2002:a17:906:940c:b0:86f:d628:e184 with SMTP id
 q12-20020a170906940c00b0086fd628e184mr1926123ejx.96.1674233715519; Fri, 20
 Jan 2023 08:55:15 -0800 (PST)
MIME-Version: 1.0
References: <20230113001103.GA3374173@paulmck-ThinkPad-P17-Gen-1> <20230113001132.3375334-16-paulmck@kernel.org>
In-Reply-To: <20230113001132.3375334-16-paulmck@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 20 Jan 2023 17:55:04 +0100
Message-ID: <CAJZ5v0gNbp4ZgPRDfLV6kmieUo7zcQSEGjdsB=G8Zr4W=HAHoQ@mail.gmail.com>
Subject: Re: [PATCH rcu v2 16/20] kernel/power: Remove "select SRCU"
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-pm@vger.kernel.org, John Ogness <john.ogness@linutronix.de>
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

On Fri, Jan 13, 2023 at 1:11 AM Paul E. McKenney <paulmck@kernel.org> wrote:
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
> Acked-by: "Rafael J. Wysocki" <rafael@kernel.org>
> Reviewed-by: John Ogness <john.ogness@linutronix.de>
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

Applied as 6.3 material, thanks!
