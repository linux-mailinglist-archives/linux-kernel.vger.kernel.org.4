Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1286E645CC7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 15:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiLGOjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 09:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiLGOjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 09:39:19 -0500
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565B528E2F;
        Wed,  7 Dec 2022 06:39:18 -0800 (PST)
Received: by mail-qt1-f179.google.com with SMTP id g7so4942740qts.1;
        Wed, 07 Dec 2022 06:39:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=st69qTJtNhLQP+45bZZhSRzLZ9Ow1Uh7dUebsxtqTbs=;
        b=rZ9P0EGiGdp7TwlzuqpQl29OwsXX6vVKzjDW0iUfHq1FgQIviFnEfa+um0/3HziqBI
         sviKN3TO9zuiMhzlvgO7N1PjptB/LCxCAJnlhHYAzZRVzjKiBWEWE1lLOvQt9RTw3AB6
         AziGfmRZH9AQuAxlmRUShty9XXnOX8q2D/fMISSRsZuyji+rX1TuYCPi6XW7qUhMepon
         HL+AWC4C4dov0Mw1+5yKRfJAl+19jpkXp0WmWTIg4f1xC1V6W4NPrJO5e4P5dnxt31b+
         HRMEarwjTrsg82+wAAuGVkQXInlEloKSR9U0Pm3bfk88mLxMg2U2PdHf3Ouej4WDgfa+
         ssSg==
X-Gm-Message-State: ANoB5pkH1WzrLmpAF32rSTHzTIT/KaeFo6iHO5qaFF8nZKljOkr8uWuT
        FKQ6G83lK7EAaS4qbXaZI1Tv1vTVtOKUtu68srM=
X-Google-Smtp-Source: AA0mqf6F7hRchNoSenvN19KkCmprz9FxYTZLsuAvm+FIKPdB9bG4wIPaOnsioD3rFZktc2SkAHISX/QhjJAStmaiBGo=
X-Received: by 2002:ac8:6b08:0:b0:3a7:eaad:3367 with SMTP id
 w8-20020ac86b08000000b003a7eaad3367mr6855723qts.153.1670423957465; Wed, 07
 Dec 2022 06:39:17 -0800 (PST)
MIME-Version: 1.0
References: <1670416895-50172-1-git-send-email-lirongqing@baidu.com> <1670416895-50172-2-git-send-email-lirongqing@baidu.com>
In-Reply-To: <1670416895-50172-2-git-send-email-lirongqing@baidu.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 7 Dec 2022 15:39:06 +0100
Message-ID: <CAJZ5v0i9J2YimfQsqJiZjFMR9MLG0fdBf+Regr+_PcsYrAE=SQ@mail.gmail.com>
Subject: Re: [PATCH 2/2][v2] cpuidle-haltpoll: Build as module by default
To:     lirongqing@baidu.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, peterz@infradead.org,
        akpm@linux-foundation.org, tony.luck@intel.com,
        jpoimboe@kernel.org, linux-kernel@vger.kernel.org,
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

On Wed, Dec 7, 2022 at 1:41 PM <lirongqing@baidu.com> wrote:
>
> From: Li RongQing <lirongqing@baidu.com>
>
> Allow user to unload it in running

Just like that?  And corrupt things left and right while at it?

No way.

And why do you need this?

> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  drivers/cpuidle/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
> index ff71dd6..43ddb84 100644
> --- a/drivers/cpuidle/Kconfig
> +++ b/drivers/cpuidle/Kconfig
> @@ -74,7 +74,7 @@ endmenu
>  config HALTPOLL_CPUIDLE
>         tristate "Halt poll cpuidle driver"
>         depends on X86 && KVM_GUEST
> -       default y
> +       default m
>         help
>          This option enables halt poll cpuidle driver, which allows to poll
>          before halting in the guest (more efficient than polling in the
> --
