Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462C8618D26
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 01:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiKDATH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 20:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiKDATE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 20:19:04 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4151CB19
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 17:19:03 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-368edbc2c18so30373797b3.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 17:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ij+8EORhQiwBgvoQHaY6EZ7bPKWoMGciFgaPFeIyDFo=;
        b=Fy2LdhzVIg5UUciraKhJnMoGEMNeueoP4dkiRBNXBu2atdul2scMBan+NuzqWShUJO
         xSK2OEHrwI1daR07YakJUr+8D11Lh/gMCgoZYGm4X/pc5ONg7LDRgKWZKqtVQSngbk2t
         JmLrWSz1NUKX+xIhX0Y3WH4PUG0XlFmKTbMvEZCCAySEr56meiA0e+8TTimRgNNMpIqZ
         YyhhKdcm/f/B0Ke7yBGhe8b7ZhKV8OE+ZORAbjhmWn/Uswx34dUC7dmNPHoyKNLJzIZX
         6E2HA9DnJ1f6WuiDPYNJ0wrVTRPXMN1dNB9UUsyschX9uGrDWi258tseuuY2kQiXh9By
         v47w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ij+8EORhQiwBgvoQHaY6EZ7bPKWoMGciFgaPFeIyDFo=;
        b=QKK6xUD5wVoOCd7Q2ifdmycX2YI2sn2smay5GQAuLNT9wQZFJQM0DpdRXlyNH96EB/
         a5s1jZyRedn98dFaEDCDzteZUfYin+ASNl751scMgQECuhW/qTfunUMgEVn4ty8WMoAa
         D04DOYL3GJiHopzvSuT4V68jURB3Y/2rAjf4nbp/XOXa2QJlNt9S1RWpmPahcsbpA9Xr
         1Z9t5TcqaLR6hSiB84flyIc5H017xK0k0oWwH8W7cM5b8qHU5RCPFOywCluwpgRrVKjc
         +HCN5By7Cc+29EHepjdQqhMb55oz/G2mTA+eImX6pN1Y8TAryBLKAoV1bpL/yvsXdouk
         AJyw==
X-Gm-Message-State: ACrzQf2VzFbtO4qDbrRjt+KMCCFRl1qbEUlOTL26mGVaWs017YFZvJJs
        nJU9zUTcfKyB4ZzsWT/r6taJ2TKDXDXYcYUY8sR8IsyTDug=
X-Google-Smtp-Source: AMsMyM5U3/1DYtWBUcLAPvfgAH1t8of7qHVgezwezwzzU14jnPTYPtNtfhkHA8Gr1l+vOubRKuwsYbaHUyRFioSz7sA=
X-Received: by 2002:a0d:ff01:0:b0:353:380e:ca03 with SMTP id
 p1-20020a0dff01000000b00353380eca03mr31203256ywf.466.1667521142759; Thu, 03
 Nov 2022 17:19:02 -0700 (PDT)
MIME-Version: 1.0
References: <20221024052841.3291983-1-shakeelb@google.com> <CGME20221102210957eucas1p2915f88d8b923ccf79f0e8770d208a1bd@eucas1p2.samsung.com>
 <fb370ccf-d22a-7885-1773-da85c9d7ea8c@samsung.com> <20221103171407.ydubp43x7tzahriq@google.com>
 <38797f54-3287-496f-a65e-755c1f025e0a@samsung.com>
In-Reply-To: <38797f54-3287-496f-a65e-755c1f025e0a@samsung.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 3 Nov 2022 17:18:51 -0700
Message-ID: <CALvZod79Z_OeQ2KN82ox8Moh8pn+3ySQxHK5z+Symma2wiNZjg@mail.gmail.com>
Subject: Re: [PATCH] mm: convert mm's rss stats into percpu_counter
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 3, 2022 at 4:02 PM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> Hi,
>
> On 03.11.2022 18:14, Shakeel Butt wrote:
> > On Wed, Nov 02, 2022 at 10:09:57PM +0100, Marek Szyprowski wrote:
> >> On 24.10.2022 07:28, Shakeel Butt wrote:
> >>> Currently mm_struct maintains rss_stats which are updated on page fault
> >>> and the unmapping codepaths. For page fault codepath the updates are
> >>> cached per thread with the batch of TASK_RSS_EVENTS_THRESH which is 64.
> >>> The reason for caching is performance for multithreaded applications
> >>> otherwise the rss_stats updates may become hotspot for such
> >>> applications.
> >>>
> >>> However this optimization comes with the cost of error margin in the rss
> >>> stats. The rss_stats for applications with large number of threads can
> >>> be very skewed. At worst the error margin is (nr_threads * 64) and we
> >>> have a lot of applications with 100s of threads, so the error margin can
> >>> be very high. Internally we had to reduce TASK_RSS_EVENTS_THRESH to 32.
> >>>
> >>> Recently we started seeing the unbounded errors for rss_stats for
> >>> specific applications which use TCP rx0cp. It seems like
> >>> vm_insert_pages() codepath does not sync rss_stats at all.
> >>>
> >>> This patch converts the rss_stats into percpu_counter to convert the
> >>> error margin from (nr_threads * 64) to approximately (nr_cpus ^ 2).
> >>> However this conversion enable us to get the accurate stats for
> >>> situations where accuracy is more important than the cpu cost. Though
> >>> this patch does not make such tradeoffs.
> >>>
> >>> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> >> This patch landed recently in linux-next as commit d59f19a7a068 ("mm:
> >> convert mm's rss stats into percpu_counter"). Unfortunately it causes a
> >> regression on my test systems. I've noticed that it triggers a 'BUG: Bad
> >> rss-counter state' warning from time to time for random processes. This
> >> is somehow related to CPU hot-plug and/or system suspend/resume. The
> >> easiest way to reproduce this issue (although not always) on my test
> >> systems (ARM or ARM64 based) is to run the following commands:
> >>
> >> root@target:~# for i in /sys/devices/system/cpu/cpu[1-9]; do echo 0
> >>   >$i/online;
> >> BUG: Bad rss-counter state mm:f04c7160 type:MM_FILEPAGES val:1
> >> BUG: Bad rss-counter state mm:50f1f502 type:MM_FILEPAGES val:2
> >> BUG: Bad rss-counter state mm:50f1f502 type:MM_ANONPAGES val:15
> >> BUG: Bad rss-counter state mm:63660fd0 type:MM_FILEPAGES val:2
> >> BUG: Bad rss-counter state mm:63660fd0 type:MM_ANONPAGES val:15
> >>
> >> Let me know if I can help debugging this somehow or testing a fix.
> >>
> > Hi Marek,
> >
> > Thanks for the report. It seems like there is a race between
> > for_each_online_cpu() in __percpu_counter_sum() and
> > percpu_counter_cpu_dead()/cpu-offlining. Normally this race is fine for
> > percpu_counter users but for check_mm() is not happy with this race. Can
> > you please try the following patch:
> >
> >
> > From: Shakeel Butt <shakeelb@google.com>
> > Date: Thu, 3 Nov 2022 06:05:13 +0000
> > Subject: [PATCH] mm: percpu_counter: use race free percpu_counter sum
> >   interface
> >
> > percpu_counter_sum can race with cpu offlining. Add a new interface
> > which does not race with it and use that for check_mm().
> > ---
> >   include/linux/percpu_counter.h | 11 +++++++++++
> >   kernel/fork.c                  |  2 +-
> >   lib/percpu_counter.c           | 24 ++++++++++++++++++------
> >   3 files changed, 30 insertions(+), 7 deletions(-)
>
>
> Yes, this seems to fix the issue I've reported. Feel free to add:
>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>
>

Thanks a lot Marek. I will send out a formal patch later with your
reported-by and tested-by tags.
