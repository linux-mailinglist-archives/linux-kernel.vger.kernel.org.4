Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF07E675A86
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjATQyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:54:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjATQya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:54:30 -0500
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8AA340D3;
        Fri, 20 Jan 2023 08:54:29 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id mp20so15446381ejc.7;
        Fri, 20 Jan 2023 08:54:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JvGqKTbPdxFCIDctccXZ8ag0aRsrvNM+XguF5zArEMo=;
        b=uYmoO7o7OxgC0BkxLXMuO8WjCiRchUZm9KLURipGR++xkxFgDoxqlwOgLQdNkX0B+M
         g6hdTLnDZ5gN4bAqqAAVWLVaXc0VqWWGHg/j10Sg7l6dhUHZ6BOgqNvZ+ayXUXZFYKI1
         TkF+UbvHv3BIeb3EXXqOqsj23513Kv32RoAwxZNvZ1/0/a621FoOn9fdFSEKg8ObQQR7
         X01wzfYmrQToyQQLJtVZz1JPeSNB2ynobRTNP+ttBTKqOsI0xa98y7XfybXLYGcE6dxp
         noql1+0OBnNKTxDGL8IOMVDQL3i1z518y7gQyONjRyAtkB/qxpiQpCWpDaY6e8Z1w8d2
         /oMA==
X-Gm-Message-State: AFqh2kq9z+TG4cwsCCze1WcqGG7152djWOetOYfjDuydWyA2yH/V/wvT
        IOxOacbBHCLeMoytXJUSpxEqwnzh5tyBB98bvYYsnntk
X-Google-Smtp-Source: AMrXdXtFOZxuPY1e4z/wPOsqhdSIkGIafy7skTvy0DLYDLB/Sr7BH2MJQgcmtPsS3KzgUj6GOZsmFncS2/IjtUeEmwA=
X-Received: by 2002:a17:906:1684:b0:871:9c0:1ef5 with SMTP id
 s4-20020a170906168400b0087109c01ef5mr2132210ejd.500.1674233668328; Fri, 20
 Jan 2023 08:54:28 -0800 (PST)
MIME-Version: 1.0
References: <20230113001103.GA3374173@paulmck-ThinkPad-P17-Gen-1> <20230113001132.3375334-3-paulmck@kernel.org>
In-Reply-To: <20230113001132.3375334-3-paulmck@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 20 Jan 2023 17:54:17 +0100
Message-ID: <CAJZ5v0ge-bYk+PM7c98+wNi28q9aOwERxfqC9K9ZSfCmUOzFfg@mail.gmail.com>
Subject: Re: [PATCH rcu v2 03/20] drivers/cpufreq: Remove "select SRCU"
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
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
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: <linux-pm@vger.kernel.org>
> Acked-by: "Rafael J. Wysocki" <rafael@kernel.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Reviewed-by: John Ogness <john.ogness@linutronix.de>
> ---
>  drivers/cpufreq/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> index 2a84fc63371e2..785541df59379 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -3,7 +3,6 @@ menu "CPU Frequency scaling"
>
>  config CPU_FREQ
>         bool "CPU Frequency scaling"
> -       select SRCU
>         help
>           CPU Frequency scaling allows you to change the clock speed of
>           CPUs on the fly. This is a nice method to save power, because
> --

Applied as 6.3 material, thanks!
