Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2FE765EFB7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 16:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234457AbjAEPK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 10:10:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233829AbjAEPJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 10:09:54 -0500
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C7B5C916;
        Thu,  5 Jan 2023 07:09:53 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id jo4so90752514ejb.7;
        Thu, 05 Jan 2023 07:09:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NPqwtXJcnV/yOJo+keiiaPa7yqhjqKpHG2APIjKSvok=;
        b=5zdNsGkjQRhBg1srr5FM3lHU8jOfLhgKZc9ONhDhWsNVKmfFNLoFBgtgJwnEdn2775
         otefr91u1N6DSwCVjPpfuIePFr/xESP0jJAPU6ttlHGWZ8fNwZ/t/sGKBRHWbxHHI705
         4nbio46xFEKkAB2T69FqxSinA7vrttraye85dH1sEFLVn38Ajs23QqQw36/Whptd0Xcr
         ICCRU5lMhSoWF5DQfrxQhqu/DJaWLlYm2Vz/RvQQoWWL1x2DPx3t2XQBSmCokjSwkuHV
         BrrBkTqiaVZ9HAyJ4sD/z05QhFKsUfw5xq/ZZylhcjSh4K3uSTZlr+eZTpXqoSOBzArc
         VUNg==
X-Gm-Message-State: AFqh2kqoRynqXxaKj/yDLEMefOnipiYWLNo5h13cFxwdAEoWHSlTDRcE
        upfoJ+OJ9usL5txTTJovQbOodUbcM7xJqjEU+6A=
X-Google-Smtp-Source: AMrXdXv/fN/pEqOjc1QOCIu41MbCtvDo3E6LWlWwMv2mxzajBEOM5qCK33X3iMg1PTKam1yyLerMwnFZ6ZINn09a7S8=
X-Received: by 2002:a17:907:6d2a:b0:7c0:efba:b39c with SMTP id
 sa42-20020a1709076d2a00b007c0efbab39cmr5537944ejc.209.1672931391939; Thu, 05
 Jan 2023 07:09:51 -0800 (PST)
MIME-Version: 1.0
References: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1> <20230105003813.1770367-10-paulmck@kernel.org>
In-Reply-To: <20230105003813.1770367-10-paulmck@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 5 Jan 2023 16:09:38 +0100
Message-ID: <CAJZ5v0j4M3Xco7bSPNog9h-zDgEuHE+jqktWNoRZKyLZCVJeBA@mail.gmail.com>
Subject: Re: [PATCH rcu 10/27] drivers/cpufreq: Remove "select SRCU"
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
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
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: <linux-pm@vger.kernel.org>

Acked-by: "Rafael J. Wysocki" <rafael@kernel.org>

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
> 2.31.1.189.g2e36527f23
>
