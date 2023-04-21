Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECE16EB07C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 19:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbjDURWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 13:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbjDURWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 13:22:18 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A62393F4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 10:22:16 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-94a34d3812dso322824466b.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 10:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682097734; x=1684689734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BfR9lcqvLbO+sXRYYQ4Al5uQ4a/w4jqcaiHNX0XG2d8=;
        b=M7kgruF3UfRfDWNCLtS06HOrbY/My1F5qsoj3AdCxeDtL9AnMCKstRKn/+mzyTSJXD
         nUELrf0ki/bVD0Bf6VaQ/BPcAyOipMfOJft9lnwibEAhqePhPxl+6N2xFt8K2aLmxT4d
         eI7byFtpOOMmoO8AzyO787vo6Mv+NG+LT4/rW6D9JlgChyif1F0ltmnqqBIp/0Lsuu0m
         IO2ZCJHgpTWXkJgsbgBAHGD8t9exscbi9IJH23YwGaJndjTrVI5DhTELy21qO5sIXB3J
         AiAoU6sruhfjdjNyk8Fg+wuorOokt2S7FMxMvRhCaYZ/12NWLYAdQflE/0HQdBDR8ffd
         FQfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682097734; x=1684689734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BfR9lcqvLbO+sXRYYQ4Al5uQ4a/w4jqcaiHNX0XG2d8=;
        b=WLXtoXJOX7E7YQZPsFlZlmCyb0Q6dDQhAt6FBZFk+OEZeuGp3me0Kjzd88E2wsdQ7g
         tA/+mGvvh+kwEZ/leU+e7q0SVbZhdkP32jV+rr707M3mDKx82iX7XkaTFii2G9WbI+Uw
         gunYRCL1OBPn7Aos11xkAoqqj/WJcOBaxkZn7fqb1JM0OUG78k5loiudsynEZDp8stRU
         dwrjY91nXr3/BaLxAM/tkKIWZzTlpidgTo5zE6VRvKa61eSJR/ms9j8uSlk02ZEaF47F
         8pY2MlZBbMV7msHN0vDTMJqFAF7MmaXFH1ciBJdOKFkJb7uzLKkGMpUmGXGQ0gUdzFhE
         LHAg==
X-Gm-Message-State: AAQBX9eLjmqYRPRqIAHxnXUoNVhuQoWrRFiDiTRTPPZTLDR2KPDtJRTE
        1Uz2Y1Tx+y7NK4N7mE1CEN9n96DprixGvl63CB48pg==
X-Google-Smtp-Source: AKy350axrab997pt4/P+KsZ/mjGlBLpHSvPcnzMc+GCcSQviGW1yDnMwiUwpJtmJyvjReOIzY0QnplK4idGv54zBasw=
X-Received: by 2002:aa7:d385:0:b0:4fb:7ccf:3b33 with SMTP id
 x5-20020aa7d385000000b004fb7ccf3b33mr5514114edq.31.1682097734305; Fri, 21 Apr
 2023 10:22:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230403220337.443510-1-yosryahmed@google.com>
 <20230403220337.443510-2-yosryahmed@google.com> <20230421085341.b2zvzeuc745bs6sa@quack3>
In-Reply-To: <20230421085341.b2zvzeuc745bs6sa@quack3>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 21 Apr 2023 10:21:36 -0700
Message-ID: <CAJD7tkYUJd+HERVKDhqKimWdXUKoBvutvKJHJDJVMOTJBV9aKA@mail.gmail.com>
Subject: Re: [PATCH mm-unstable RFC 1/5] writeback: move wb_over_bg_thresh()
 call outside lock section
To:     Jan Kara <jack@suse.cz>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 1:53=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 03-04-23 22:03:33, Yosry Ahmed wrote:
> > wb_over_bg_thresh() calls mem_cgroup_wb_stats() which invokes an rstat
> > flush, which can be expensive on large systems. Currently,
> > wb_writeback() calls wb_over_bg_thresh() within a lock section, so we
> > have to make the rstat flush atomically. On systems with a lot of
> > cpus/cgroups, this can cause us to disable irqs for a long time,
> > potentially causing problems.
> >
> > Move the call to wb_over_bg_thresh() outside the lock section in
> > preparation to make the rstat flush in mem_cgroup_wb_stats() non-atomic=
.
> > The list_empty(&wb->work_list) should be okay outside the lock section
> > of wb->list_lock as it is protected by a separate lock (wb->work_lock),
> > and wb_over_bg_thresh() doesn't seem like it is modifying any of the b_=
*
> > lists the wb->list_lock is protecting. Also, the loop seems to be
> > already releasing and reacquring the lock, so this refactoring looks
> > safe.
> >
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
>
> The patch looks good to me. Nice find. Feel free to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>

Thanks for taking a look!

>
>                                                                 Honza
>
> > ---
> >  fs/fs-writeback.c | 16 +++++++++++-----
> >  1 file changed, 11 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> > index 195dc23e0d831..012357bc8daa3 100644
> > --- a/fs/fs-writeback.c
> > +++ b/fs/fs-writeback.c
> > @@ -2021,7 +2021,6 @@ static long wb_writeback(struct bdi_writeback *wb=
,
> >       struct blk_plug plug;
> >
> >       blk_start_plug(&plug);
> > -     spin_lock(&wb->list_lock);
> >       for (;;) {
> >               /*
> >                * Stop writeback when nr_pages has been consumed
> > @@ -2046,6 +2045,9 @@ static long wb_writeback(struct bdi_writeback *wb=
,
> >               if (work->for_background && !wb_over_bg_thresh(wb))
> >                       break;
> >
> > +
> > +             spin_lock(&wb->list_lock);
> > +
> >               /*
> >                * Kupdate and background works are special and we want t=
o
> >                * include all inodes that need writing. Livelock avoidan=
ce is
> > @@ -2075,13 +2077,19 @@ static long wb_writeback(struct bdi_writeback *=
wb,
> >                * mean the overall work is done. So we keep looping as l=
ong
> >                * as made some progress on cleaning pages or inodes.
> >                */
> > -             if (progress)
> > +             if (progress) {
> > +                     spin_unlock(&wb->list_lock);
> >                       continue;
> > +             }
> > +
> >               /*
> >                * No more inodes for IO, bail
> >                */
> > -             if (list_empty(&wb->b_more_io))
> > +             if (list_empty(&wb->b_more_io)) {
> > +                     spin_unlock(&wb->list_lock);
> >                       break;
> > +             }
> > +
> >               /*
> >                * Nothing written. Wait for some inode to
> >                * become available for writeback. Otherwise
> > @@ -2093,9 +2101,7 @@ static long wb_writeback(struct bdi_writeback *wb=
,
> >               spin_unlock(&wb->list_lock);
> >               /* This function drops i_lock... */
> >               inode_sleep_on_writeback(inode);
> > -             spin_lock(&wb->list_lock);
> >       }
> > -     spin_unlock(&wb->list_lock);
> >       blk_finish_plug(&plug);
> >
> >       return nr_pages - work->nr_pages;
> > --
> > 2.40.0.348.gf938b09366-goog
> >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
