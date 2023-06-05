Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C85D721F60
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 09:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbjFEHSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 03:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjFEHSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:18:18 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2460AB7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 00:18:17 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-75ea05150b3so50074685a.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 00:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685949496; x=1688541496;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=05RCd0BotypeJ3vpqjuiW1CsQvUl82c9ZsPvAfek+Xo=;
        b=MBVqCRfWsw6qQRPiraqaKf3iGTJzuD8MVEYkkholH2SfWxwluGMd3kmvPbgJZr/23+
         l/GFYiuZ6mGYZV02PVAhnyRGrbU/S2rMbF3l8oYSX3sRB5hULdsdxU+CJ63kfIzafuvU
         //L+W2sEvbE2bTOvU3K1OBDa8+mNAjoBav3WcopiShAfhI9loZq2W3cZd+9glXYsuRUZ
         pxIIPRsG/V7zrvLack3DYQDZoAoM7eKE5AWrSmBVC8th92v1qUbCe+yvRBiVc661pHI1
         f+3e7ZX8OQgcejuEIEHGv9h3uJKR3sXPafdoBVB9aMlRmN8B6HpPEhQcfp8DXOXWOakK
         d0oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685949496; x=1688541496;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=05RCd0BotypeJ3vpqjuiW1CsQvUl82c9ZsPvAfek+Xo=;
        b=cWmrCtDpbbMNd3Kp/frZUcCyd2qJv178rxqHoUwFo08Cq1ejVNz/tQ8PmhEZwe190E
         40BuJwcRczFdrkhFJAzD8jNN7lrc98U4jJE0KW5fKmX80sPPjLYVJI71IXKnabcwlcfU
         vsXBOUOynFRtbqlcb0lM8TH8nYglvm9zP9BjC0oZUFt2zTXKwhx6/PikWNf3OPQflZYW
         ckIFPD4Ua5sbw2V5ozLtkH6wWc/9/1jJuNXEzMs3NB7kVkiPJYKIqu3vrkFXQ0HThAZJ
         azL/ZfUPmVUvN/O7mcpGX6RTPZvZSZbHprxBHjVkMeCxdab1MpEGweLaq6JflLx/xp3i
         b7tA==
X-Gm-Message-State: AC+VfDyk9KGh20x9YhP6yPUd87SXDtlVCa1huVBVhzgGUL7lygfG71lM
        NiSR0jc6b5uaszrZW4ELnA9y2i2td3VsvMDA5X6GhA==
X-Google-Smtp-Source: ACHHUZ60BFlLfrvJr4KjNvsksxKZxmoDpyyULnOwbTYyLIzWqQoPYjyVobDLBLOLo2mZwuj77c5mhKefsiW6zQf2INA=
X-Received: by 2002:a37:400b:0:b0:75b:23a1:8309 with SMTP id
 n11-20020a37400b000000b0075b23a18309mr16356109qka.4.1685949496255; Mon, 05
 Jun 2023 00:18:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230531115839.089944915@infradead.org> <20230531124603.654144274@infradead.org>
 <CAKfTPtDsHJ+d2dmi8sezU0VE_aRgPO1Ltj7k207rw-_jr=ZjhQ@mail.gmail.com> <20230602142739.GH620383@hirez.programming.kicks-ass.net>
In-Reply-To: <20230602142739.GH620383@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 5 Jun 2023 09:18:05 +0200
Message-ID: <CAKfTPtCZ2Thf0=jfhjGe9VHdqBX6=tU7OOzHwv2bDKUVZq+faw@mail.gmail.com>
Subject: Re: [PATCH 01/15] sched/fair: Add avg_vruntime
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, corbet@lwn.net, qyousef@layalina.io,
        chris.hyser@oracle.com, patrick.bellasi@matbug.net, pjt@google.com,
        pavel@ucw.cz, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org, kprateek.nayak@amd.com,
        yu.c.chen@intel.com, youssefesmat@chromium.org,
        joel@joelfernandes.org, efault@gmx.de, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Jun 2023 at 16:27, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Jun 02, 2023 at 03:51:53PM +0200, Vincent Guittot wrote:
> > On Wed, 31 May 2023 at 14:47, Peter Zijlstra <peterz@infradead.org> wrote:
> > > +static void
> > > +avg_vruntime_add(struct cfs_rq *cfs_rq, struct sched_entity *se)
> > > +{
> > > +       unsigned long weight = scale_load_down(se->load.weight);
> > > +       s64 key = entity_key(cfs_rq, se);
> > > +
> > > +       cfs_rq->avg_vruntime += key * weight;
> > > +       cfs_rq->avg_load += weight;
> >
> > isn't cfs_rq->avg_load similar to scale_load_down(cfs_rq->load.weight)  ?
> >
> > > +}
>
> Similar, yes, but not quite the same in two ways:
>
>  - it's sometimes off by one entry due to ordering of operations -- this
>    is probably fixable.
>
>  - it does the scale down after addition, whereas this does the scale
>    down before addition, esp for multiple low weight entries this makes
>    a significant difference.

Ah yes, we are still using the the scaled down value for computation

>
