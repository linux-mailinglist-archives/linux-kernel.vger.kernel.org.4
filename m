Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31EA6B287D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 16:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjCIPQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 10:16:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbjCIPPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 10:15:39 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C19B186
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 07:14:50 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id cp7-20020a17090afb8700b0023756229427so6551861pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 07:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678374890;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yT6LX29bvZ5b2ab24nRfc8hIZuV8Cxc5bgMuyUeRjMQ=;
        b=vWQ7P5yCm7whVVsru563y3fqWchdJ6H1PgewfAxGheQb5UVcHA02a8RRlaNaeSiB2W
         NX2uWhr/A+SJ2pArNuX8IgLdN9dceSPZEMyWaje/cTrImL0JQy8pRHFXBGSVZKPjnhKi
         ON0kke0Jxa8ZQSgn3jXhseh9YnLIMqMfYh2folO1HWzluuUq6Z3jeH6QGD9k7c6BYmPv
         XV4BcKM5fnXANhjQi4loYZE/bSU0MRIpyaNMji/8v1nj74wgmiFf3hTCyCrRUc1LFe4a
         mPTcr/J1mPiqq8SgBlLn3/tg5pxosApvXhSOQyvIv4jMv0mkwcG/MQfk9pqaSEazK+B3
         gxOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678374890;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yT6LX29bvZ5b2ab24nRfc8hIZuV8Cxc5bgMuyUeRjMQ=;
        b=EIsgbNroH24Sqh0OppCF1HDp6beDMZ3ucWy5wLi5vFRH3K/u4zPK9W35pUxT0AwGLk
         7QQ+hynlOxNTmCISs0joFxu6fZj6FeaxrF6/pI6nDR9Q54yFw8KJp6cMIy10BV2NojPZ
         UKSCXvxwUlY3TqB3Dmc8kaIqbVoF4ugsZBYfd31YZjodfBTfUyp/vWOR3DD1y2GDUFmR
         EPUJEloAw2DwYxSRljOh7c7hQtrlssfl5X50m7xNXZnBbMfJ95yBIUJRdI5ykK94hnbY
         /knL62q4YRrCA/+Em6l6tYPTS/D1//a2SHlKHmx+2R+0a+U6nOzm+IOs2RdX0cm1gDpP
         VZ1g==
X-Gm-Message-State: AO0yUKUYUWNkWFehoCW41OHsb6UyKyRqz+T2cnseQIBN6oheGIc6MMg0
        dCivyXNPf2MQSw9HBG+Jo7vxNOyWeau5b2EtkOYTIQ==
X-Google-Smtp-Source: AK7set+gbx5b3QdbxjGn2GgS2yXVctQW0/nnJD1rWQopqWp50Uu37Js6meR6kGsRUOYN37VCbn069+OFVl+QHyeDkY8=
X-Received: by 2002:a17:903:4282:b0:19a:ac0b:9d93 with SMTP id
 ju2-20020a170903428200b0019aac0b9d93mr8813160plb.0.1678374889749; Thu, 09 Mar
 2023 07:14:49 -0800 (PST)
MIME-Version: 1.0
References: <20230306132418.50389-1-zhangqiao22@huawei.com>
 <20230309130524.GA273121@hirez.programming.kicks-ass.net> <CAKfTPtAf5RrzZRSHtfK+r3QvnFQ-oM3+rJ-z5SB8T4+nUv1aQw@mail.gmail.com>
 <20230309142825.GB273121@hirez.programming.kicks-ass.net> <ZAnvCGdlOrWbIC/o@hirez.programming.kicks-ass.net>
In-Reply-To: <ZAnvCGdlOrWbIC/o@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 9 Mar 2023 16:14:38 +0100
Message-ID: <CAKfTPtADUas2QHZCQyu0ad-JTKRQ=PcsB=o7+PuJNVxHwAzkCQ@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: sanitize vruntime of entity being migrated
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Zhang Qiao <zhangqiao22@huawei.com>, linux-kernel@vger.kernel.org,
        mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, rkagan@amazon.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Mar 2023 at 15:37, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Mar 09, 2023 at 03:28:25PM +0100, Peter Zijlstra wrote:
> > On Thu, Mar 09, 2023 at 02:34:05PM +0100, Vincent Guittot wrote:
> >
> > > Then, even if we don't clear exec_start before migrating and keep
> > > current value to be used in place_entity on the new cpu, we can't
> > > compare the rq_clock_task(rq_of(cfs_rq)) of 2 different rqs AFAICT
> >
> > Blergh -- indeed, irq and steal time can skew them between CPUs :/
> > I suppose we can fudge that... wait_start (which is basically what we're
> > making it do) also does that IIRC.
> >
> > I really dislike having this placement muck spreadout like proposed.
>
> Also, I think we might be over-engineering this, we don't care about
> accuracy at all, all we really care about is 'long-time'.

you mean taking the patch 1/2 that you mentioned here to add a
migrated field:
https://lore.kernel.org/all/68832dfbb60fda030540b5f4e39c5801942689b1.1648228023.git.tim.c.chen@linux.intel.com/T/#ma5637eb8010f3f4a4abff778af8db705429d003b

And assume that the divergence between the rq_clock_task() can be ignored ?

That could probably work but we need to replace the (60LL *
NSEC_PER_SEC) by ((1ULL << 63) / NICE_0_LOAD) because 60sec divergence
would not be unrealistic.
and a comment to explain why it's acceptable


>
>
