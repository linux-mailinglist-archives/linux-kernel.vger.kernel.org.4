Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35AF070D467
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 08:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbjEWG5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 02:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235229AbjEWG53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 02:57:29 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22AF118
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 23:57:27 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-25275edf6caso3203835a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 23:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684825047; x=1687417047;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fs/Kka212K9HZw+Uadp6iad5J5sck5LyYW6ilIuJq5k=;
        b=qU8Y57Ae5oUb3EHy1VaLRfa8tcqQSWnbp00CqHBV1JgnHI/zNPNSfAsyCNYJemFN8B
         nI9PwiuJVZ8I1Yp/sr5yzjJILrc41dZifSvOHvAIys9MKYzOBgmcgplnW12IyY6vxigv
         xbQ44ND/UcB19ZPIa/oujk8LkDaJCuPcU9glddStiz0D4cf9vlrDc18thPHNf8wUGN3z
         KDdB94hFu2HZvo0eoBFeGJeOtr2Aez0s2TeNbvKnPXaWwTEufS0VmT/XbqzDLKqP0sZa
         r0TdUd4n+pRRn5wq/pPXB+TTMpqmi+jp8dGXPayzCUJAZwhFVHenaeHC1RyWKgUfZTzB
         5eKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684825047; x=1687417047;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fs/Kka212K9HZw+Uadp6iad5J5sck5LyYW6ilIuJq5k=;
        b=bbMhYREwJ/D/74VmMjQjoum3nNrSXov+ceymnKhFiJ82QEn12mLdCFYD1w5SgA9dh8
         Z3q6yelcAtnp/hNl3qiXN3+E+HckGbXizvVwS8URupMKfkE5/njsc8xgE8AuiY0A3GLq
         t784voHHzeK81Ye1T0TEbEa7iAKaOE0ZzQi4MG1p9ATVqPA0IQa4Gs51X+Wef356NTjY
         EfPgffXLN5bXMoD6qv1PB0BJgr9c1v/pAq5SLEfEWxbn1kjbrERy1jlKn2Zyz2FX/ML6
         7P0giWrozADIHWHEKhXuPuIsGDZrno9UiApeUzztGyVEK2oA6UkhuOJ8LxGlsmjWB88g
         Ymww==
X-Gm-Message-State: AC+VfDzxzM8uF+tIdVzbjXK7EpxP8voxVsYhhnEGH397dYyf3m11arUb
        kGGf3kN7ziH0biNILrXZgS0C5CcwBenc83FKV36euw==
X-Google-Smtp-Source: ACHHUZ4kaRxfpCrCPytzA2We1U6cXsMLcjsxtAF+aJH82mAn/MrmgbWfIDxjTsntLPxzBB5+KybKlE4v45V5aTZs2cY=
X-Received: by 2002:a17:90a:6641:b0:24d:dcbb:6307 with SMTP id
 f1-20020a17090a664100b0024ddcbb6307mr14422119pjm.6.1684825046988; Mon, 22 May
 2023 23:57:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230522195021.3456768-1-arnd@kernel.org>
In-Reply-To: <20230522195021.3456768-1-arnd@kernel.org>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 23 May 2023 08:57:15 +0200
Message-ID: <CAKfTPtA1HeUdF8BN+zQzViXARespUsum2rOOGZUHH5Fy+mHnqg@mail.gmail.com>
Subject: Re: [PATCH 0/5] sched: address missing-prototype warnings
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 May 2023 at 21:50, Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> I sent out a lot of -Wmissing-prototype warnings already, but noticed that
> I missed some of the patches I did for the scheduler.
>
> Addressing this is mainly useful in order to allow turning the
> warning on by default in the future, but I also tried to
> improe the code where possible.
>
> Arnd Bergmann (5):
>   sched: hide unused sched_update_scaling()
>   sched: add schedule_user() declaration
>   sched: fair: hide unused init_cfs_bandwidth() stub
>   sched: make task_vruntime_update() prototype visible
>   sched: fair: move unused stub functions to header

For the whole serie

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

>
>  kernel/sched/core.c  |  2 --
>  kernel/sched/fair.c  | 19 +++----------------
>  kernel/sched/sched.h | 13 +++++++++++++
>  3 files changed, 16 insertions(+), 18 deletions(-)
>
> --
> 2.39.2
>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: linux-kernel@vger.kernel.org
>
