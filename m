Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C723563D703
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 14:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiK3Nmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 08:42:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiK3Nmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 08:42:50 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBDB193E7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 05:42:49 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id x12so5189141ilg.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 05:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xB02vOOmC8AmHX6fqjha6NVxRlyLrOOR3HyAmHWblj0=;
        b=nQfdFp3454odqTKzzy6HtAWFTgGjw4E9Dk09UAYiTJcriqUPMTJSoRln2X+LTdUKb4
         SWsbcZh9IFw5fnZjJ6Y/E78vlFd5BR9DZIvjTnl3cJYPx293X0/IyD2zp+amitl+ABDB
         STcZxD2hAeZPKmciJVu3Y2T3VfRvlIwr4NCskPwVhnSh1zO2B0mMXsaGmCNTZez2atZi
         aEcwzCGgua6CaOHiG5nAebWpF5DlwRlStYUdwZsemkxWGptr7N7WRG/659ctBqoHxBl9
         N7kJfFgXBeJFkqySpImT6gcLlelNpC/oLZxWqLdxhrcAFtzQiR6bv+yNfdyg5Le1sYtB
         OF4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xB02vOOmC8AmHX6fqjha6NVxRlyLrOOR3HyAmHWblj0=;
        b=jnNOb6UYaKDANThQiHm4eJtCcKyarkCZfRbxx8l47wrB6wPn26GSOIuZSbEGXXuQY0
         ko/HT/tWFhtLcraVb2GBiZsKm7wTl+xNAk+1o1epl21j9eSaGYOEdJ0MvhZjwYuvJjX2
         o8YtFFO1d9cPHl24uD6SX50TXeFE2G1hRag6WoHnzuhyHKDmhPyqUM4oL11zkMIC9eQc
         NGutgdXIlpgFHU08tZwvPblDmZzhnuQeZKaclf4AOWYvPQXvJea/1RwIS6ByyI+ISEa1
         /LON9qKmUQ0q40eepNWO1i/Di0rzC6ekEQWjbfYXReE+GllgtB7QcBq7weFadmZcWufy
         E9cQ==
X-Gm-Message-State: ANoB5pn1vQYwU8hD+nhF/alJvmkBa5WErh9OucEzBjUGiHJnIQBfC03z
        5D3V5m9OV6C1wmroMTdqGoPQkcjz3kari7rg+yGElQ==
X-Google-Smtp-Source: AA0mqf5/UvyJdf0Zl/lV8T0zyuJg/0ksLKcor1mnU5+8IbELuGTlASPy/KHdkynw1pGgxifzSXuOZhVtSFpeDCexP+s=
X-Received: by 2002:a05:6e02:ca1:b0:303:1ebe:9c4c with SMTP id
 1-20020a056e020ca100b003031ebe9c4cmr4429252ilg.301.1669815768941; Wed, 30 Nov
 2022 05:42:48 -0800 (PST)
MIME-Version: 1.0
References: <CAKfTPtCZ5CttibZ9o18woLiQgzFeKCBMDAGrhMd3kbgX2qs29Q@mail.gmail.com>
 <E5C05A33-06E4-4627-8108-145752D72A24@joelfernandes.org> <CAKfTPtBZ8xfoP4=W1K5vaBBm5b05Ak9ojAdJeb2hvs5W=W3gmw@mail.gmail.com>
 <CAEXW_YRpYx3VC+PdM2J=QhZipcy59A46YnjyE0zpUQe3c4Ck8A@mail.gmail.com>
In-Reply-To: <CAEXW_YRpYx3VC+PdM2J=QhZipcy59A46YnjyE0zpUQe3c4Ck8A@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 30 Nov 2022 14:42:37 +0100
Message-ID: <CAKfTPtCKL5Ea9f13ONbC92UUeNMnd8qrt2KcsRmWg70ufrNzUg@mail.gmail.com>
Subject: Re: [PATCH 5/9] sched/fair: Take into account latency priority at wakeup
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org, qperret@google.com,
        tim.c.chen@linux.intel.com, joshdon@google.com, timj@gnu.org,
        kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org
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

On Wed, 30 Nov 2022 at 04:10, Joel Fernandes <joel@joelfernandes.org> wrote=
:
>
> Hi Vincent,
>
> On Tue, Nov 29, 2022 at 5:21 PM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> [...]
> > > >>> }
> > > >>>
> > > >>> /*
> > > >>> @@ -7544,7 +7558,7 @@ static int __sched_setscheduler(struct task=
_struct *p,
> > > >>>                if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)
> > > >>>                        goto change;
> > > >>>                if (attr->sched_flags & SCHED_FLAG_LATENCY_NICE &&
> > > >>> -                   attr->sched_latency_nice !=3D p->latency_nice=
)
> > > >>> +                   attr->sched_latency_nice !=3D LATENCY_TO_NICE=
(p->latency_prio))
> > > >>>                        goto change;
> > > >>>
> > > >>>                p->sched_reset_on_fork =3D reset_on_fork;
> > > >>> @@ -8085,7 +8099,7 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, =
struct sched_attr __user *, uattr,
> > > >>>        get_params(p, &kattr);
> > > >>>        kattr.sched_flags &=3D SCHED_FLAG_ALL;
> > > >>>
> > > >>> -       kattr.sched_latency_nice =3D p->latency_nice;
> > > >>> +       kattr.sched_latency_nice =3D LATENCY_TO_NICE(p->latency_p=
rio);
> > > >>>
> > > >>> #ifdef CONFIG_UCLAMP_TASK
> > > >>>        /*
> > > >>> @@ -11294,6 +11308,20 @@ const u32 sched_prio_to_wmult[40] =3D {
> > > >>>  /*  15 */ 119304647, 148102320, 186737708, 238609294, 286331153,
> > > >>> };
> > > >>>
> > > >>> +/*
> > > >>> + * latency weight for wakeup preemption
> > > >>> + */
> > > >>> +const int sched_latency_to_weight[40] =3D {
> > > >>> + /* -20 */     -1024,     -973,     -922,      -870,      -819,
> > > >>> + /* -15 */      -768,     -717,     -666,      -614,      -563,
> > > >>> + /* -10 */      -512,     -461,     -410,      -358,      -307,
> > > >>> + /*  -5 */      -256,     -205,     -154,      -102,       -51,
> > > >>> + /*   0 */         0,       51,      102,       154,       205,
> > > >>> + /*   5 */       256,      307,      358,       410,       461,
> > > >>> + /*  10 */       512,      563,      614,       666,       717,
> > > >>> + /*  15 */       768,      819,      870,       922,       973,
> > > >>> +};
> > > >>> +
> > > >>
> > > >> The table is linear. You could approximate this as: weight =3D nic=
e * 51
> > > >> since it is a linear scale and do the conversion in place.
> > > >>
> > > >> Or, since the only place you are using the latency_to_weight is in
> > > >> set_latency_offset(), can we drop the sched_latency_to_weight arra=
y
> > > >> and simplify as follows?
> > > >
> > > > It's also used in cgroup patch and keeps a coherency between
> > > > nice/weight an latency_nice/offset so I prefer
> > >
> > > I dont think it=E2=80=99s a valid comparison as nice/weight conversio=
n are non linear and over there a table makes sense: weight =3D 1024 / 1.25=
 ^ nice
> > >
> > > > keeping current
> > > > implementation
> > >
> > > I could be missing something, but, since its a linear scale, why does=
 cgroup need weight at all? Just store nice directly. Why would that not wo=
rk?
> > >
> > > In the end the TG and SE has the latency offset in the struct, that i=
s all you care about. All the conversion back and forth is unnecessary, as =
it is a linear scale and just increases LOC and takes more memory to store =
linear arrays.
> > >
> > > Again I could be missing something and I will try to play with your s=
eries and see if I can show you what I mean (or convince myself it=E2=80=99=
s needed).
> >
> > I get what you mean but I think that having an array gives latitude to
> > adjust this internal offset mapping at a minimum cost of a const array
>
> Ok that makes sense. If you feel like there might be updates in the
> future to this mapping array (like changing the constants as you
> mentioned), then I am Ok with us keeping it.
>
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>
> I am excited about your series, the CFS latency issues have been
> thorny. This feels like a step forward in the right direction. Cheers,

Thanks
Vincent

>
>  - Joel
