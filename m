Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 864686C4135
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 04:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjCVDlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 23:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjCVDlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 23:41:21 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA1E5AB55
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 20:41:05 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id y5so19634014ybu.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 20:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679456464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V3jUG0oglxMHUcZ7R/TmWEumXbeO4lDHFIDhwNqEDys=;
        b=QgNe0dtNidUBSmdsTDiK4Px2nDl8EPhFA/9VkGSCSMzzpyLMRXoJE4xlrw1NM2oQNK
         +mFspaVMAnaGws1YfyPgT+m/35w3PMt5+LtTPg7mCH8hIfHwolqG7yTpxPjT5mtWNLHw
         uJMXNRY5EBI5+OFtZAuIhCIPZJdhsLAeTjgK/8eiEQBpaqv0GvtshfA4JiILCp4EkPGC
         +cgHkdhMCNjmee+9DEJCQluc2GUGGyuMSJLa7GfDHy2pndNEkWG/xxX5Ki4dcu+opljo
         BPIg8gTp5kdel8ORqTP+jKFOS3YX9P5cLFW647bk037iQskBbeecdihxBvuecHgURRYm
         /zrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679456464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V3jUG0oglxMHUcZ7R/TmWEumXbeO4lDHFIDhwNqEDys=;
        b=y8phBu7T0bu84Sar1fXXA39ZEDXMJZkb8159XRBEhuIGWHJLnKfFiRbp+iR84nVOJF
         VihLag9rc2zHgLPuYk3yneq2qHKTsdXtjhwKAkkPkrkmRbmni7e8QOxV4fb/EkzYUG/P
         zbfuvuGo8qsxzKJUlfhqAZEGFtThRK+WSqzLkHoKonyhvYs0I0o9R8GjxpLFcZYABOPx
         57zRccXdYVp8H53aM6jnPNhxgDD08+NtSZUY7+OKqbgkYdiWu9fAga2sKcoxiXv721a4
         2rWgm6VkyAPAAmI9KjoW0QOw9SLRM3SC6RKAL4HdpLNRigM3npoQ6ZEQX7AjQE1FiBD7
         Oi3g==
X-Gm-Message-State: AAQBX9dkXGmVwUzQqYNA2lNzxKDYHUVFehK5heGIEbVubwgjuiHGBFpe
        y2anlrpbO/SoNxclOOYC1o+Xz9iumVB7CvBW4foaaY+Iicl6L2GosJy7OQ==
X-Google-Smtp-Source: AKy350YZm3SAAw+t57lPyxsw90p3kGALbDdVj7prqsbYFXGA5wuUug8vavPt8IUirU74K8IaUJDoG8dHxggELSUFugU=
X-Received: by 2002:a5b:c0d:0:b0:a02:a3a6:78fa with SMTP id
 f13-20020a5b0c0d000000b00a02a3a678famr2582824ybq.12.1679456464304; Tue, 21
 Mar 2023 20:41:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230309170756.52927-1-cerasuolodomenico@gmail.com>
 <20230309170756.52927-4-cerasuolodomenico@gmail.com> <CAJuCfpE18RYymcpzKZDapQg35ew5BiUPepnbS7cj+z6H5--Huw@mail.gmail.com>
 <CA+CLi1g=70ot=YFL+xug3jC4OXG727NGo+NXxmC45WcwaFpo8g@mail.gmail.com>
In-Reply-To: <CA+CLi1g=70ot=YFL+xug3jC4OXG727NGo+NXxmC45WcwaFpo8g@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 21 Mar 2023 20:40:52 -0700
Message-ID: <CAJuCfpFMrpL16RMp5CNJUKuPM5nTUmRvSNjK+zaxhRcdArLVhg@mail.gmail.com>
Subject: Re: [PATCH 3/4] sched/psi: extract update_triggers side effect
To:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        brauner@kernel.org, chris@chrisdown.name, hannes@cmpxchg.org
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

On Tue, Mar 21, 2023 at 3:18=E2=80=AFAM Domenico Cerasuolo
<cerasuolodomenico@gmail.com> wrote:
>
> Hi Suren, thanks for all the feedback! This makes sense, I only have one =
doubt, if we set update_total flag to window_update() and update_triggers()=
, that flag would be ignored when the caller is psi_avgs_work(), this would=
 be happening in the next patch in the set.

I don't see why the update_triggers part should be conceptually
different between RT and unprivileged triggers. Could you please
explain?

> What do you think if I just remove this change from the patchset and then=
 work on a solution after the iterations on the main change are completed? =
This was in fact just an attempt to clean up.
> I'll apply your suggested changes on the other patches, wait a bit for co=
mments from someone else and then send V2.
>
> On Tue, Mar 21, 2023 at 12:00=E2=80=AFAM Suren Baghdasaryan <surenb@googl=
e.com> wrote:
>>
>> On Thu, Mar 9, 2023 at 9:08=E2=80=AFAM Domenico Cerasuolo
>> <cerasuolodomenico@gmail.com> wrote:
>> >
>> > The update of rtpoll_total inside update_triggers can be moved out of
>> > the function since changed_states has the same information as the
>> > update_total flag used in the function. Besides the simplification of
>> > the function, with the next patch it would become an unwanted side
>> > effect needed only for PSI_POLL.
>>
>> (changed_states & group->rtpoll_states) and update_total flag are not
>> really equivalent. update_total flag depends on the difference between
>> group->polling_total[state] and group->total[PSI_POLL][state] while
>> changed_states depends on the difference between groupc->times and
>> groupc->times_prev. groupc->times_prev is updated every time
>> collect_percpu_times() is called and there are 3 places where that
>> happens: from psi_avgs_work(), from psi_poll_work() and from
>> psi_show(). group->polling_total[state] is updated only from
>> psi_poll_work(). Therefore the deltas between these values might not
>> always be in-sync.
>>
>> Consider the following sequence as an example:
>>
>> psi_poll_work()
>> ...
>> psi_avgs_work()/psi_show()
>>   collect_percpu_times() // we detect a change in a monitored state
>> ...
>> psi_poll_work()
>>   collect_percpu_times() // this time no change in monitored states
>>   update_triggers() // group->polling_total[state] !=3D
>> group->total[PSI_POLL][state]
>>
>> In the last psi_poll_work() collect_percpu_times() recorded no change
>> in monitored states, so (changed_states & group->rtpoll_states) =3D=3D 0=
,
>> however since the last time psi_poll_work() was called there was
>> actually a change in monitored states recorded by the first
>> collect_percpu_times(), therefore (group->polling_total[t->state] !=3D
>> total[t->state]) and we should update the totals. With your change we
>> will miss that update.
>>
>> I think you can easily fix that by introducing update_triggers as an
>> output parameter in window_update() like this:
>>
>> static u64 window_update(struct psi_window *win, u64 now, u64 value,
>> bool *update_triggers) {
>>     *update_total =3D false;
>> ...
>>     if (new_stall) {
>>         *update_total =3D true;
>> ...
>> }
>>
>> static void psi_rtpoll_work(struct psi_group *group) {
>> +       bool update_triggers;
>> ...
>> -       if (now >=3D group->rtpoll_next_update)
>> +       if (now >=3D group->rtpoll_next_update) {
>>                 group->rtpoll_next_update =3D update_triggers(group,
>> now, &update_triggers);
>> +               if (update_triggers)
>> +                       memcpy(group->rtpoll_total, group->total[PSI_POL=
L],
>> +                                  sizeof(group->rtpoll_total));
>> +       }
>> }
>>
>>
>> >
>> > Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
>> > Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
>> > ---
>> >  kernel/sched/psi.c | 20 +++++---------------
>> >  1 file changed, 5 insertions(+), 15 deletions(-)
>> >
>> > diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
>> > index a3d0b5cf797a..476941c1cbea 100644
>> > --- a/kernel/sched/psi.c
>> > +++ b/kernel/sched/psi.c
>> > @@ -433,7 +433,6 @@ static u64 window_update(struct psi_window *win, u=
64 now, u64 value)
>> >  static u64 update_triggers(struct psi_group *group, u64 now)
>> >  {
>> >         struct psi_trigger *t;
>> > -       bool update_total =3D false;
>> >         u64 *total =3D group->total[PSI_POLL];
>> >
>> >         /*
>> > @@ -456,14 +455,6 @@ static u64 update_triggers(struct psi_group *grou=
p, u64 now)
>> >                  * events without dropping any).
>> >                  */
>> >                 if (new_stall) {
>> > -                       /*
>> > -                        * Multiple triggers might be looking at the s=
ame state,
>> > -                        * remember to update group->polling_total[] o=
nce we've
>> > -                        * been through all of them. Also remember to =
extend the
>> > -                        * polling time if we see new stall activity.
>> > -                        */
>> > -                       update_total =3D true;
>> > -
>> >                         /* Calculate growth since last update */
>> >                         growth =3D window_update(&t->win, now, total[t=
->state]);
>> >                         if (!t->pending_event) {
>> > @@ -484,11 +475,6 @@ static u64 update_triggers(struct psi_group *grou=
p, u64 now)
>> >                 /* Reset threshold breach flag once event got generate=
d */
>> >                 t->pending_event =3D false;
>> >         }
>> > -
>> > -       if (update_total)
>> > -               memcpy(group->rtpoll_total, total,
>> > -                               sizeof(group->rtpoll_total));
>> > -
>> >         return now + group->rtpoll_min_period;
>> >  }
>> >
>> > @@ -686,8 +672,12 @@ static void psi_rtpoll_work(struct psi_group *gro=
up)
>> >                 goto out;
>> >         }
>> >
>> > -       if (now >=3D group->rtpoll_next_update)
>> > +       if (now >=3D group->rtpoll_next_update) {
>> >                 group->rtpoll_next_update =3D update_triggers(group, n=
ow);
>> > +               if (changed_states & group->rtpoll_states)
>> > +                       memcpy(group->rtpoll_total, group->total[PSI_P=
OLL],
>> > +                                  sizeof(group->rtpoll_total));
>> > +       }
>> >
>> >         psi_schedule_rtpoll_work(group,
>> >                 nsecs_to_jiffies(group->rtpoll_next_update - now) + 1,
>> > --
>> > 2.34.1
>> >
