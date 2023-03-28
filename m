Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B99D6CCAA2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 21:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjC1T3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 15:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjC1T3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 15:29:52 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104CF3A8E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 12:29:50 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id p15so16527874ybl.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 12:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680031789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wVYgMmmcsm1731n1mzQ0oLQHz+Whcq4PF5zJ4lB7lmw=;
        b=ItnSGLh1jpQN3JVppS9sVCITPiYQS/CkhnmA16xHvlicXGfnhKU7y6aVo7pYYSOzC1
         smXX3KHtLdxbsldbWCfIAKlgsZDKQ2ir20UPA1ml5S4/HUI1dBEpV+3dUWTCPRPsvm57
         2b7WuH9ClXFJuQLxTKeFBMDEezY55J0GItJuePZmJ4R3w8LEoS3fNdYzGhbDtRiGPIKz
         sAoyax2niXufDDgUigY3psKXsSXX+cYX05u7XmhcWLyyqXaP3eTmqcVkLvT6ydpZ/wmp
         nI4N3rbZ+3g/+ulQD9uBM222QzdjqIhU3lkZqCuQs5xDRK1vS1Bs/4f8vpZzqtccTube
         ZWOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680031789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wVYgMmmcsm1731n1mzQ0oLQHz+Whcq4PF5zJ4lB7lmw=;
        b=E2abmUrXiXvWb/zP/zC+Vtu/T9pP8OoXWlrQiGuY48fExg1V8g74A6VX7IanECytzI
         C4bzWp3FH11pxpglHtNjOADT/UW5Pv4usmMbbYaiNOhU45GY1dbRdUC7G58MgZercrkR
         liKtLyah2mUDoIMtmuRCAecniIaUqEbPHvLVwT9a+Xnz1Pma1dqe9FafBgQBYYtqAc/8
         FFEbDBTOwmC0Rc7gtz2YY9BEHGo1YCDWKT+imkc/bxNKext7HaeobhIkA08StawxJ5Er
         ZmYABemNPZe2Ovk9ymPIGAyC0Y2kOjzYnT0u8BdLH4rVdSVWRqdhREm7W1EU5kWe95ey
         0Uqw==
X-Gm-Message-State: AAQBX9drgmYzFb1bdH5HwF8kGwBSsDrqp2bFqRno1KXwqArLYRJ71OGt
        nCvdZ0s7xBHkOdrE9fxEC0viYVWlCEiOqz+xoah2oA==
X-Google-Smtp-Source: AKy350YU0gY54wvMoHew+J42IOIyRrMc9szJehhhtmBSQris0Dj2bJw+BAstdzChU6VQNK6YKTd1shm29zDJZe+UDxU=
X-Received: by 2002:a05:6902:154e:b0:b77:d2db:5f8f with SMTP id
 r14-20020a056902154e00b00b77d2db5f8fmr10431743ybu.12.1680031789049; Tue, 28
 Mar 2023 12:29:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230328061638.203420-1-yosryahmed@google.com>
 <20230328061638.203420-9-yosryahmed@google.com> <CALvZod7wJ-e-dHEhMynquiqQWFU2j+05wUyUe_yv_rBqJLu2rw@mail.gmail.com>
 <CAJD7tkaKh4w3roqau4V93Q022BG280yzdsh1YSVenZCLm0qVow@mail.gmail.com>
In-Reply-To: <CAJD7tkaKh4w3roqau4V93Q022BG280yzdsh1YSVenZCLm0qVow@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 28 Mar 2023 12:29:38 -0700
Message-ID: <CALvZod7jhZCHXc1ShxHwhepAbhrdordFw4Wci8cSqtOxyQE6Gw@mail.gmail.com>
Subject: Re: [PATCH v1 8/9] vmscan: memcg: sleep when flushing stats during reclaim
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 12:02=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> On Tue, Mar 28, 2023 at 8:19=E2=80=AFAM Shakeel Butt <shakeelb@google.com=
> wrote:
> >
> > On Mon, Mar 27, 2023 at 11:16=E2=80=AFPM Yosry Ahmed <yosryahmed@google=
.com> wrote:
> > >
> > > Memory reclaim is a sleepable context. Allow sleeping when flushing
> > > memcg stats to avoid unnecessarily performing a lot of work without
> > > sleeping. This can slow down reclaim code if flushing stats is taking
> > > too long, but there is already multiple cond_resched()'s in reclaim
> > > code.
> > >
> > > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> >
> > Acked-by: Shakeel Butt <shakeelb@google.com>
> >
> > > ---
> > >  mm/vmscan.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > > index a9511ccb936f..9c1c5e8b24b8 100644
> > > --- a/mm/vmscan.c
> > > +++ b/mm/vmscan.c
> > > @@ -2845,7 +2845,7 @@ static void prepare_scan_count(pg_data_t *pgdat=
, struct scan_control *sc)
> > >          * Flush the memory cgroup stats, so that we read accurate pe=
r-memcg
> > >          * lruvec stats for heuristics.
> > >          */
> > > -       mem_cgroup_flush_stats_atomic();
> > > +       mem_cgroup_flush_stats();
> >
> > I wonder if we should just replace this with
> > mem_cgroup_flush_stats_ratelimited().
>
> Thanks for taking a look!
>
> I was hesitant about doing this because the flush call is inside the
> retry loop, and it seems like we want to get fresh stats on each
> retry. It seems very likely that we end up not flushing between
> retries with mem_cgroup_flush_stats_ratelimited().
>
> Maybe change it if we observe problems with non-atomic flushing?

Yeah, let's leave it for the future if we see the issue.
