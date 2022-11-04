Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE3246194F2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 11:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbiKDK6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 06:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbiKDK5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 06:57:55 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B5C2C12C
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 03:57:51 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id z3so3488833iof.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 03:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KBw6r/39I5ZdX4ted0MRMCqrVaORjgimjhJ6CowDODg=;
        b=Q5xZXnEapVLguBKftTH5xS9ORf/btiGt8a8j4JTuzlKNIlICxEKZ72BcAeq2dRtjpg
         FRD9ECAQ3ryxiE5HQy9bZq3jBmmnp6MUg4jTUUGCGdXHkt9v838CIuOtoYzQR8byduSb
         /DlueIbH6r/BUU9n5rZpHOZ8jrxjzmjjdi1VRBkmmkyH8WENIuhTTcRm9ojpgqclWiBV
         twBrm9lp46EOcV2Q7HoEfVPs773R2EiDW2r4LdLn+Z583EkDCEl4s/8UmQTq7oKTrjIP
         XjaGJTn66UOt94RYNiG63BbfpEOBWBoRxVvZZEtrq65ejICKfE8xi23osDPGgzCE2gwB
         xx4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KBw6r/39I5ZdX4ted0MRMCqrVaORjgimjhJ6CowDODg=;
        b=yWLIwIateg7BgXVJw9QrNSex6rPx3SqCw4sxgIT/zbqi3Eq9Q6llMhjU3Gck5fWLb2
         bpLT4ZLqAYiK5qWLuunnkI0EESilStMPFCII325+X9Jp+lKo+b/tBjd8QOpkge+1ddOs
         7QXuM58fDEoIhC3v/BZ6oO04Ge6xZNyZH/7hf4UuiVPZBVopdYoF1OpiU47KZbZjSSGT
         Vyme2e20o8pzNbtroTCY36pB0c3c3foSDMoxDnFHhMu6AFTa7SeG+meOLmwGUwkK6LLu
         T1aEoeR7/tzC3vkXEpHxKRyV8BLljzIQ3pZ9Pd2yJR43wGD9vRNM9faARNUi65bUvRJK
         G1ZQ==
X-Gm-Message-State: ACrzQf00OjjrEZwqsp8JAovnwkJBTAC8H9idNLtdbPC5A6L1s8MWc/8B
        8Tadw5yOzx4Ch6VGeTSKOesTl3Xrl8bPUJZDExiu5g==
X-Google-Smtp-Source: AMsMyM6KdkkbJMxSJCn9XgLLHkwaUKBPOwsu5sngExm6GJ/ZMHrz7nrg8BkmrJwEWQ1+0TPgCouWYHNlv2ddi0i6d6w=
X-Received: by 2002:a02:9a07:0:b0:375:4db5:2a4e with SMTP id
 b7-20020a029a07000000b003754db52a4emr18497636jal.71.1667559471338; Fri, 04
 Nov 2022 03:57:51 -0700 (PDT)
MIME-Version: 1.0
References: <20221028093403.6673-1-vincent.guittot@linaro.org>
 <20221028093403.6673-7-vincent.guittot@linaro.org> <20221101192848.pjns3um7dnrwrk5p@airbuntu>
 <CAKfTPtA=vJQA_=6Un1CqwzMUaOxMeFGTKUZnj8qyqvqmSdYBAg@mail.gmail.com>
 <20221103142732.m5ibwkuymvhcdxkn@airbuntu> <CAKfTPtDu=c-psGnHkoWSPRWoh1Z0VBBfsN++g+krv4B1SJmFjg@mail.gmail.com>
 <CAEXW_YQd2y9=RHw3Sge7ghnhBz0AyR+B-U4zG10LXuSbg5bGSA@mail.gmail.com>
 <CAKfTPtBJQOY7UUkm1=wvG18UWgLLiTW0dr3bTGUJY=siM_LLxQ@mail.gmail.com> <CAEXW_YTcmbPg+UCacb4Vy0LeYuorT-yECoa39pqtw5wPUkzsvQ@mail.gmail.com>
In-Reply-To: <CAEXW_YTcmbPg+UCacb4Vy0LeYuorT-yECoa39pqtw5wPUkzsvQ@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 4 Nov 2022 11:57:39 +0100
Message-ID: <CAKfTPtCfL7KZSyJmGRaW0KhGtkdZkk0JJDF0w_sgiSmZ-x-DSA@mail.gmail.com>
Subject: Re: [PATCH v7 6/9] sched/fair: Add sched group latency support
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Qais Yousef <qyousef@layalina.io>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        qais.yousef@arm.com, chris.hyser@oracle.com,
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

On Fri, 4 Nov 2022 at 11:48, Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Fri, Nov 4, 2022 at 10:37 AM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> [...]
> > > during *same CPU* competition between different groups by juggling
> > > around the wakeup-preemption window -- which maybe is good for
> > > Android.
> > >
> > > OTOH, the =E2=80=9Cprefer idle=E2=80=9D flag in android that Qais is =
referring to,
> > > will need a completely different method as I cannot see how a nice
> > > value can communicate that (that can complement Vincent's changes
> > > here). And it will need to have a per-task interface as well. We have
> >
> > Why a negative latency_nice value condition can't be used ? or latency =
-20  ?
>
> That's overloading the meaning of a value, the whole nice thing is
> supposed to be "relative to something". So you are being nice to
> something else. Here -20 means you are not being nice. But in fact you
> are, because you are avoiding hurting something else by going to an
> idle CPU. So it becomes really weird.

Looking for an idle CPU 1st is already the default behavior of CFS.
Here we speak about an EAS specific behavior where we want to forgot
the "full" EAS policy for some tasks and favor latency by spreading
and looking for an idle cpu

>
> Also, why would -19 or -18 not be a value instead to cause wakeup to
> prefer an idle CPU? It confuses the user on how to choose value and we
> should refrain from that IMHO.

IIRC, the 1st idea was to say any negative value but then using the
lowest one can be seen as an addon to the wakeup preemption
