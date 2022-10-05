Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC03C5F5760
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 17:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbiJEPWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 11:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiJEPWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 11:22:17 -0400
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556623FD51;
        Wed,  5 Oct 2022 08:22:16 -0700 (PDT)
Received: by mail-qk1-f179.google.com with SMTP id a22so126828qkk.7;
        Wed, 05 Oct 2022 08:22:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4o7jKpdTpHVRL3i/qWOAEJ2ycxxPaVJnIcSfhAtoNts=;
        b=Jvym8lPCEFXoSUX5jhnBC9WJ6nnFlC9FAi8Kj1OirgekLzE4UDm5mWe2s9gCDEx7UQ
         eFx5qsfcZQMzLuNpim9XBVpL+n+hkkeap9tfy6bzxMrqQ1gLHtUVxqSOsBagXwS8wkba
         Nlj6Q8Rq3VzDEk6TDyGkGDqqF8QB6MB1PLtzBTJY0sG/L86z5LZlV4VVq47oWTOLcpQF
         aVW5Ws2m0jcwJ6Uvxtr9nSzkYtojbPPCcxsNExVQzZL54x2MlPXq1YEI6YXeHWQiFC24
         z1RrE42jpLi/ebN1/9JiPnhYvAxDjvA/f2hV8b4BXiZ0EnPy1uxQq5C/wWg3MIxUkeWX
         xkfg==
X-Gm-Message-State: ACrzQf3FI4oLK8IQ7VAvtkJbGw7hNxNjxG22QXqcJb0tTB63Vgw3VJ3V
        xfwODYbIBFr18OzPZENwl5N/H4ODjGmLFj6KN8HTz8Pm
X-Google-Smtp-Source: AMsMyM4lVrmmPHUgbTcRn5yNIAERw0LA41Ey/SY40hUUWlNdEIE1rqefEUi8a+/9PHFAiaiXmVm8qyHaAZcPXyg/u7U=
X-Received: by 2002:a05:620a:290d:b0:6b6:1a92:d88a with SMTP id
 m13-20020a05620a290d00b006b61a92d88amr110277qkp.58.1664983335468; Wed, 05 Oct
 2022 08:22:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAJvTdKn8jCWF3f3_EnBCaOAgQf9UgPCCG4oAysva5U2JF=C_4Q@mail.gmail.com>
In-Reply-To: <CAJvTdKn8jCWF3f3_EnBCaOAgQf9UgPCCG4oAysva5U2JF=C_4Q@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 5 Oct 2022 17:22:04 +0200
Message-ID: <CAJZ5v0hKL+qEL=tFAbLatVf0tASaVjkw7NyNL=b-hEC0JyPYjQ@mail.gmail.com>
Subject: Re: [GIT PULL] turbostat 2022.10.04
To:     Len Brown <lenb@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 4, 2022 at 11:08 PM Len Brown <lenb@kernel.org> wrote:
>
> Hi Rafael,
>
> Please pull these turbostat patches to update Linux to turbostat 2022.10.04.
>
> Add support for two new platforms, and two bug fixes on existing platforms.
>
> thanks!
> Len Brown, Intel Open Source Technology Center
>
> The following changes since commit 4fe89d07dcc2804c8b562f6c7896a45643d34b2f:
>
>   Linux 6.0 (2022-10-02 14:09:07 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git turbostat
>
> for you to fetch changes up to 9992dd777123b052e106eb5633de47148fef502e:
>
>   tools/power turbostat: version 2022.10.04 (2022-10-04 23:02:03 +0200)
>
> ----------------------------------------------------------------
> Artem Bityutskiy (1):
>       tools/power turbostat: Do not dump TRL if turbo is not supported
>
> Len Brown (1):
>       tools/power turbostat: version 2022.10.04
>
> Zhang Rui (3):
>       tools/power turbostat: Add support for RPL-S
>       tools/power turbostat: Add support for MeteorLake platforms
>       tools/power turbostat: Use standard Energy Unit for SPR Dram RAPL domain
>
>  tools/power/x86/turbostat/turbostat.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)

Pulled and added to my linux-next branch, thanks!
