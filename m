Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970C06CF274
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 20:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjC2Ss6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 14:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjC2Ssz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 14:48:55 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9264C3A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 11:48:54 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id u20so10929275pfk.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 11:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680115734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mU/Jc0gXgHaKy6uBEAxI8FhgmA9MJxxnsTJvuJaE4Nk=;
        b=rMvP09cVkpjy0ICtdAjusbVIBflBABMCJ0gdgTU1tkbXKR/bLgByF0KcTXx1btkpjb
         SgiT9etHZM8ZGIT90dBWjKAz08CCQ6Hs0IPcSTCT+ONxRbtLFjzVczoibWFJZCP4KRTk
         pfmjlABeetRZVyNrdRj0+dVppABLEMqCdMXtycE2tLVHfA8fENXQFRzM2gLpLd+OUnFS
         qmNl6tOWXurPRxgS8m4lIAppssohoH+k2o3XhiEr6LmrrCUwG0SrpJKM5C+/Qrm4DcRp
         khfJDiWKp+bzwFrSmg6zx4lkBa1fuKjrJXGxuwo0QPPhUsAs7xnx17I2FU19heVWnKa2
         cLdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680115734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mU/Jc0gXgHaKy6uBEAxI8FhgmA9MJxxnsTJvuJaE4Nk=;
        b=VA8wz2mphljnbA95YyC+7iiaWZuk4qiANGnUpNnPC906Jwzwu7CJysHGqA9Zu0xKeO
         Iv/fcFUSUiieoqzQhw4yrpb89nz0KaB0XtVrwV++/ei59/e3LKewqfHmkvLta7vDauJa
         6NXhlJ+ZemB+BtmnTTmnG98hCOC3fT3YzgJZkFCoRR7jDZmBzStaC7+MsjKkSSH1kuAR
         UYfg864xSob6ZaW7salHr343zLK3pBQWwJc1wJ4Gu+BuZV56AIJWcdiDUenpvkLcgWbD
         vyMDkxhks7ftOhnIqT09U4qGnPvMmJFNqfPbefq89bZCPShYzwUssED7k97xWVb3E3+1
         ISDg==
X-Gm-Message-State: AAQBX9ciB9jyRfcnrAXhHafokWDOKSx6d2nUydTe7eOjWFe1G/2xESK5
        3oBePJ1b9UnPyom7vS4GVZmx1JoHM0fdjejUlHPz2Q==
X-Google-Smtp-Source: AKy350Z07Nnk7MEnLbohzkV7bbjziztwC3QSGFPfhks5MwyVeikATF/kKxlPhxxdoupXc62ZmUsZFGQU26AxTQmGtJg=
X-Received: by 2002:a63:ef0e:0:b0:513:86ef:f080 with SMTP id
 u14-20020a63ef0e000000b0051386eff080mr973876pgh.9.1680115733737; Wed, 29 Mar
 2023 11:48:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230328092622.062917921@infradead.org> <20230328110354.141543852@infradead.org>
 <CABk29Nt4T67S+L9Qs1qeOUyo5gY1Qy5KuOwuCYNM74E58J81Eg@mail.gmail.com>
 <20230329080646.GL4253@hirez.programming.kicks-ass.net> <20230329082235.GA38236@hirez.programming.kicks-ass.net>
In-Reply-To: <20230329082235.GA38236@hirez.programming.kicks-ass.net>
From:   Josh Don <joshdon@google.com>
Date:   Wed, 29 Mar 2023 11:48:41 -0700
Message-ID: <CABk29NstO+-=T-91fc7rNRYNSgP5=+SGvGEFxejrS7qPsMOKbQ@mail.gmail.com>
Subject: Re: [PATCH 08/17] sched/fair: Implement an EEVDF like policy
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, corbet@lwn.net,
        qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, pjt@google.com, pavel@ucw.cz,
        qperret@google.com, tim.c.chen@linux.intel.com, timj@gnu.org,
        kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org, efault@gmx.de
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

On Wed, Mar 29, 2023 at 1:22=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Wed, Mar 29, 2023 at 10:06:46AM +0200, Peter Zijlstra wrote:
> > On Tue, Mar 28, 2023 at 06:26:51PM -0700, Josh Don wrote:
> > > > +static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
> > > > +{
> > > > +       struct rb_node *node =3D cfs_rq->tasks_timeline.rb_root.rb_=
node;
> > > > +       struct sched_entity *curr =3D cfs_rq->curr;
> > > > +       struct sched_entity *best =3D NULL;
> > > > +
> > > > +       if (curr && (!curr->on_rq || !entity_eligible(cfs_rq, curr)=
))
> > > > +               curr =3D NULL;
> > > > +
> > > > +       while (node) {
> > > > +               struct sched_entity *se =3D __node_2_se(node);
> > > > +
> > > > +               /*
> > > > +                * If this entity is not eligible, try the left sub=
tree.
> > > > +                */
> > > > +               if (!entity_eligible(cfs_rq, se)) {
> > > > +                       node =3D node->rb_left;
> > > > +                       continue;
> > > > +               }
> > > > +
> > > > +               /*
> > > > +                * If this entity has an earlier deadline than the =
previous
> > > > +                * best, take this one. If it also has the earliest=
 deadline
> > > > +                * of its subtree, we're done.
> > > > +                */
> > > > +               if (!best || deadline_gt(deadline, best, se)) {
> > > > +                       best =3D se;
> > > > +                       if (best->deadline =3D=3D best->min_deadlin=
e)
> > > > +                               break;
> > >
> > > Isn't it possible to have a child with less vruntime (ie. rb->left)
> > > but with the same deadline? Wouldn't it be preferable to choose the
> > > child instead since the deadlines are equivalent but the child has
> > > received less service time?
> >
> > Possible, yes I suppose. But given this is ns granular virtual time,
> > somewhat unlikely. You can modify the last (validation) patch and have
> > it detect the case, see if you can trigger it.

Agreed on unlikely, was just checking my understanding here, since
this becomes a question of tradeoff (likelihood of decent vs the ideal
scheduling decision). Leaving as-is seems fine, with potentially a
short comment.

> > Doing that will make the pick always do a full decent of the tree
> > through, which is a little more expensive. Not sure it's worth the
> > effort.
>
> Hmm, maybe not, if there is no smaller-or-equal deadline then the
> min_deadline of the child will be greater and we can terminate the
> decent right there.
>
