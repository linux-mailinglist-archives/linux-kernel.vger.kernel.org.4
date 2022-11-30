Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD9A63CFFF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 09:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbiK3IAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 03:00:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbiK3IAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 03:00:09 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7702E9EE
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 00:00:08 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id e189so11830551iof.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 00:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4kCRKqO2mkH/fqLy77WABljMo3p7d3wXwbsA6OHP5js=;
        b=DjY91hKS2Q3XDMivXHzl+hoHSYC9VQykBomQkUOEmrk08Jo/FeJYn3aZzmZrRkoPNA
         53IuVAtjYtZ7r9ANBabvof9LDOdOwpT11hMAgQLDWDxrENJJWhb918tBmlam70VkOgWV
         z17NtM5DhXW3mx6Rdpc4kKZfBvSiX4kic07301CRXnWlh3sn87OXP/appT/y1ZZcZu1Q
         8VbNNhRQROE7sUlPRqkNBBCfWsH1+y7mP/zW3/leiIJDxEC5pb211DbNydf9WcJU3Bi3
         Zg/TFkCU5KE+tTmwvTOsfVMhRv6wqFpz5lwP/CT1Az9QmyOEp+7YW4/mvfcWCrdWWfRG
         d2/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4kCRKqO2mkH/fqLy77WABljMo3p7d3wXwbsA6OHP5js=;
        b=6OrJDrpjAGU9MezcmPqGey1fetDmyjyu3A8M06Yfo1Qzh2F/Q0UN5zV90ZseGyjheu
         uKG+WdxHsyPts1vjnYP4rzdj7H6jwEAuW+/OQRU/yjgP6IpKfRno8/lTz0OdAG1rBUSL
         sqGd6g4fwWJYkZrpyXjmWuQUr98NjojO0UxMMjZP6GAp/cp3lKHW6pWSdkRmIkZLXBiS
         cBS0HdRQJ6zdJmoBr5g5rlZMZmEikguNkRSUy/upH70JdmRHaNrM1roShr6TkX3g/Cm6
         GcMsmAN3FGddkJtWainHe7zBjcnOu4sFDJdSBpyZpzVG/kARpwGn+ZYgwwGb8EEWV0Ls
         5vug==
X-Gm-Message-State: ANoB5plMUJFUhtsFEKV7TtvE7x6ouZMMlLUanCutTO0W61RgAKOuCXL/
        wgLB+u2gERmPbSC2WNGxHaAIBWvCBLp82Q+nNk2g/Ja4N5c=
X-Google-Smtp-Source: AA0mqf7rIi2N8kYOep15xbmtfJEO4EIZVYYxTDj5W26IsKAWsrubQU7D6jMMeV5e1piXpB3EzKKie3CD/vArLc1hKDI=
X-Received: by 2002:a02:942a:0:b0:373:d769:bc14 with SMTP id
 a39-20020a02942a000000b00373d769bc14mr20408615jai.264.1669795207651; Wed, 30
 Nov 2022 00:00:07 -0800 (PST)
MIME-Version: 1.0
References: <20221026064300.78869-1-jiahao.os@bytedance.com>
 <20221026064300.78869-3-jiahao.os@bytedance.com> <20221114121517.vwg4rr5xb3nvwpjy@techsingularity.net>
 <7ca91933-2e49-1813-bb30-363c540e5139@bytedance.com>
In-Reply-To: <7ca91933-2e49-1813-bb30-363c540e5139@bytedance.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 30 Nov 2022 08:59:56 +0100
Message-ID: <CAKfTPtAYuck69ph62PODHKr+4Zx-Fqq3OW99RCzOPnW7LJwQ3Q@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 2/2] sched/core: Adjusting the order of
 scanning CPU
To:     Hao Jia <jiahao.os@bytedance.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        mingo@kernel.org, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Nov 2022 at 07:35, Hao Jia <jiahao.os@bytedance.com> wrote:
>
>
>
> On 2022/11/14 Mel Gorman wrote:
> > On Wed, Oct 26, 2022 at 02:43:00PM +0800, Hao Jia wrote:
> >> When select_idle_capacity() starts scanning for an idle CPU, it starts
> >> with target CPU that has already been checked in select_idle_sibling()=
.
> >> So we start checking from the next CPU and try the target CPU at the e=
nd.
> >> Similarly for task_numa_assign(), we have just checked numa_migrate_on
> >> of dst_cpu, so start from the next CPU. This also works for
> >> steal_cookie_task(), the first scan must fail and start directly
> >> from the next one.
> >>
> >> Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
> >
> > Test results in general look ok so
> >
> > Acked-by: Mel Gorman <mgorman@techsingularity.net>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> >
>
> Hi, Peter
> These two patches have been Acked-by Mel Gorman.
> If you have time, please review these two patches.
>
> Thanks=EF=BC=8C
> Hao
